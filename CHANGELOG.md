# Change Log

All notable changes to this project will be documented in this file.

## [2.0.0](https://github.com/maxsokolov/TableKit/releases/tag/1.4.0)
Released on 2016-09-06. Breaking changes in 2.0.0:
<br/>The signatures of `TableRow` and `TableRowAction` classes were changed from
```swift
let action = TableRowAction<String, StringTableViewCell>(.click) { (data) in
}

let row = TableRow<String, StringTableViewCell>(item: "some string", actions: [action])
```
to
```swift
let action = TableRowAction<StringTableViewCell>(.click) { (data) in
}

let row = TableRow<StringTableViewCell>(item: "some string", actions: [action])
```
This is the great improvement that comes from the community. Thanks a lot!

## [1.3.0](https://github.com/maxsokolov/TableKit/releases/tag/1.3.0)
Released on 2016-09-04. Swift 3.0 support.

## [0.1.0](https://github.com/maxsokolov/TableKit/releases/tag/0.1.0)
Released on 2015-11-15. Initial release called Tablet.