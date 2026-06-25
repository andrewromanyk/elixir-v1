defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  test "store values by key" do
    {:ok, bucket} = KV.Bucket.start_link([])
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "stores values by key on a named process", config do
    {:ok, _} = KV.Bucket.start_link(name: config.test)
    assert KV.Bucket.get(config.test, "milk") == nil

    KV.Bucket.put(config.test, "milk", 3)
    assert KV.Bucket.get(config.test, "milk") == 3
  end

  test "stores and delete values within a bucket" do
    {:ok, bucket} = KV.Bucket.start_link([])

    KV.Bucket.put(bucket, "milk", 3)
    KV.Bucket.put(bucket, "bread", 5)

    assert KV.Bucket.get(bucket, "milk") == 3
    assert KV.Bucket.get(bucket, "bread") == 5

    KV.Bucket.delete(bucket, "bread")

    assert KV.Bucket.get(bucket, "milk") == 3
    assert KV.Bucket.get(bucket, "bread") == nil
  end
end
