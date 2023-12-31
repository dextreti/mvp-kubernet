FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY "MVCPrototipo.csproj" .
RUN dotnet restore "MVCPrototipo.csproj"
COPY . .
RUN dotnet build . -c Release -o /app/build

FROM build as publish
RUN dotnet publish "MVCPrototipo.csproj" -c Release -o /app/publish

FROM base AS final 
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT [ "dotnet","MVCPrototipo.dll" ]