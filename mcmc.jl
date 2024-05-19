using Turing
using Plots
using StatsPlots
using Distributions

# サンプルデータの生成
data = rand(Beta(2, 5), 100)

# Turingモデルの定義
@model function beta_model(data)
    α ~ Uniform(0, 10)  # αの事前分布
    β ~ Uniform(0, 10)  # βの事前分布
    for i in 1:length(data)
        data[i] ~ Beta(α, β)  # 観測データの尤度
    end
end

# モデルのインスタンス化
model = beta_model(data)

# サンプラーの設定とサンプリングの実行
chain = sample(model, NUTS(0.65), 1000)

# 結果の表示
println(chain)

# トレースプロットの作成
plot(chain)