#encoding: utf-8
class TagCloud

  attr_reader :tags_with_count

  # 参数名:
  #   +tags+      标签项集合，每项是一个数组。Array[0]-标签名，Array[1]-数量
  #   +options+   可选项
  #       :max_size       标签云最大字体
  #       :min_size       标签云最小字体
  #       :log            是否采用对数曲线，默认不采用。
  def initialize(tags_with_count, options={})
    @options = default_options.merge(options)
    @tag_cloud = generate(tags_with_count)
  end

  def max_size
    @options[:max_size]
  end

  def min_size
    @options[:min_size]
  end

  def log?
    @options[:log] ? true : false
  end

  def each
    @tag_cloud.each do |tag, font_size|
      yield tag, font_size
    end
  end

  def count
    @tag_cloud.count
  end

  private

  def default_options
    {max_size: 38, min_size: 12, log: true}
  end

  def generate(tags_with_count)
    font_range = max_size - min_size

    min_tag, max_tag = tags_with_count.minmax_by{|tag| tag[1]}

    @tag_cloud = tags_with_count.map do |tag_with_count|
      tag_ratio = tag_weight_ratio(tag_with_count[1],max_tag[1],min_tag[1],log?)
      [tag_with_count[0], (min_size + tag_ratio * font_range).round]
    end

    @tag_cloud = @tag_cloud.sort_by{|tag| tag[0] }    
  end

  # 获取标签权重率
  def tag_weight_ratio(tag_weight,max_weight,min_weight,log)
    if log
      min_log = Math.log(min_weight)
      max_log = Math.log(max_weight)
      log_range = (max_log == min_log) ? 1 : (max_log - min_log)
      (Math.log(tag_weight) - min_log) / log_range
    else
      log_range = max_weight - min_weight
      if log_range > 0
        (tag_weight - min_weight).to_f / log_range.to_f
      else
        0
      end
    end
  end  
end