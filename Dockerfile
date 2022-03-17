FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build
WORKDIR /app
COPY . ./
RUN dotnet restore

COPY . ./
RUN dotnet publish ProjectTest.API -c release -o out

#FROM mcr.microsoft.com/dotnet/core/aspnet:5.0
FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim AS base
WORKDIR /app
COPY --from=build /app/out .
ENV ASPNETCORE_URLS http://*:80
ENV DOTNET_RUNNING_IN_CONTAINER true
EXPOSE 80
ENTRYPOINT ["dotnet", "ProjectTest.API.dll"]