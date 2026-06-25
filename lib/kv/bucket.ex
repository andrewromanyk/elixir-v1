defmodule KV.Bucket do
  use Agent

  @doc """
  Create a new bucket.

  All options are forwarded to `Agent.start_link/2`.
  """
  def start_link(opts) do
    Agent.start_link(fn -> %{} end, opts)
  end

  @doc """
  Retrieves a value from the bucket using a key.
  """
  def get(bucket, key) do
    Agent.get(bucket, fn map -> Map.get(map, key) end)
  end

  @doc """
  Puts the value to the corresponding key in the given bucket.
  """
  def put(bucket, key, value) do
    Agent.update(bucket, fn map -> Map.put(map, key, value) end)
  end
end
