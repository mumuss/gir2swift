// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let pkgName = "gir2swift"

let package = Package(
    name: pkgName,
    dependencies: [ .package(url: "https://github.com/mumuss/SwiftLibXML.git", .branch("master")) ],
    targets: [
        .target(name: pkgName, dependencies: ["SwiftLibXML"]),
        .testTarget(name: "\(pkgName)Tests", dependencies: [.byNameItem(name: pkgName)]),
    ]
)
