# Sử dụng image SDK để build ứng dụng
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Sao chép các file dự án và restore các gói nuget
COPY *.csproj ./
RUN dotnet restore

# Sao chép toàn bộ mã nguồn và build ứng dụng
COPY . ./
RUN dotnet publish -c Release -o /app/publish

# Sử dụng image runtime để chạy ứng dụng
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
COPY --from=build /app/publish .

# Chạy ứng dụng
ENTRYPOINT ["dotnet", "SampleLoginApp.dll"]
