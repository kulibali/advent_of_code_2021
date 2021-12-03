use "collections"
use "files"

class Day01Part2
  fun apply(lines: Iterator[String iso^], out: OutStream, err: OutStream)
    : U32 ?
  =>
    let window_size: USize = 3

    var total: U32 = 0
    let data = Array[U32].init(U32.max_value() / 3, window_size + 1)
    var start_a: USize = 0
    var start_b: USize = 1

    for line in lines do
      (let current, _) =
        try
          line.read_int[U32]()?
        else
          err.print("Unable to parse line " + (consume line))
          error
        end
      try
        data((start_a + window_size) % data.size())? = current
      else
        err.print("Buffer overflow")
        error
      end

      var sum_a: U32 = 0
      for i in Range[USize](start_a, start_a + window_size) do
        sum_a =
          try
            sum_a + data(i % data.size())?
          else
            err.print("Invalid index i " + i.string())
            error
          end
      end
      var sum_b: U32 = 0
      for j in Range[USize](start_b, start_b + window_size) do
        sum_b =
          try
            sum_b + data(j % data.size())?
          else
            err.print("Invalid index j " + j.string())
            error
          end
      end
      if sum_b > sum_a then
        total = total + 1
      end
      start_a = (start_a + 1) % data.size()
      start_b = (start_b + 1) % data.size()
    end
    total
