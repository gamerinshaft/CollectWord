class CollectWord
  def initialize
    input()
    @count = 0
    @hit_word = -1
    @t1 = Time.now.tv_sec
    str = ""
    f = File.open(@file_name, "w"){|f| f.write(str)}
    @mode = "a"
  end

  def input
    puts("シャッフルしたい文字列を入力して下さい。")
    @collect = gets.chomp
    puts("保存先のファイル名を入力して下さい。上書きされるので注意！")
    @file_name = gets.chomp
  end

  def main
    loop do
      spell = @collect.split("").shuffle
      @base = ""
      spell.each_with_index do |k,index|
        if k == @collect.split("")[index]
         hit(k, index)
        else
          break
        end
      end
      if @base == @collect
        collect()
        break
      end
      @count += 1
      if @count % 10000 == 0
        symbol()
      end
    end
  end

  private

  def hit(str, ind)
    @base += str
    if(@hit_word < ind) then
      @hit_word = ind
      str1 = "\n" + @base + "\n↑ #{@count+1}回目にhit\n"
      open( @file_name , @mode ){|f| f.write(str1)}
    end
  end

  def symbol
    if  @count % 50000 == 0
      str = "≡"
    elsif  @count % 40000 == 0
      str = "="
    elsif  @count % 30000 == 0
      str = "−"
    elsif  @count % 20000 == 0
      str = "≒"
    else
      str = "≠"
    end
    open( @file_name , @mode ){|f| f.write(str)}
  end

  def collect
    @t2 = Time.now.tv_sec
    str2 = "(読み込み時間： #{@t2-@t1})"
    open( @file_name , @mode ){|f| f.write(str2)}
  end
end

CollectWord.new().main


