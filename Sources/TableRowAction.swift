//
//    Copyright (c) 2015 Max Sokolov https://twitter.com/max_sokolov
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of
//    this software and associated documentation files (the "Software"), to deal in
//    the Software without restriction, including without limitation the rights to
//    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//    the Software, and to permit persons to whom the Software is furnished to do so,
//    subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

public enum TableRowActionType {
    
    case click
    case clickDelete
    case select
    case deselect
    case willSelect
    case willDisplay
    case shouldHighlight
    case height
    case canEdit
    case configure
    case custom(String)
    
    var key: String {
        
        switch (self) {
        case .custom(let key):
            return key
        default:
            return "_\(self)"
        }
    }
}

open class TableRowActionData<CellType: ConfigurableCell> where CellType: UITableViewCell {

    open let item: CellType.T
    open let cell: CellType?
    open let indexPath: IndexPath
    open let userInfo: [AnyHashable: Any]?

    init(item: CellType.T, cell: CellType?, path: IndexPath, userInfo: [AnyHashable: Any]?) {

        self.item = item
        self.cell = cell
        self.indexPath = path
        self.userInfo = userInfo
    }
}

private enum TableRowActionHandler<CellType: ConfigurableCell> where CellType: UITableViewCell {

    case voidAction((TableRowActionData<CellType>) -> Void)
    case action((TableRowActionData<CellType>) -> Any?)

    func invoke(item: CellType.T, cell: UITableViewCell?, path: IndexPath) -> Any? {
        
        switch self {
        case .voidAction(let handler):
            return handler(TableRowActionData(item: item, cell: cell as? CellType, path: path, userInfo: nil))
        case .action(let handler):
            return handler(TableRowActionData(item: item, cell: cell as? CellType, path: path, userInfo: nil))
        }
    }
}

open class TableRowAction<CellType: ConfigurableCell> where CellType: UITableViewCell {

    open let type: TableRowActionType
    private let handler: TableRowActionHandler<CellType>
    
    public init(_ type: TableRowActionType, handler: @escaping (_ data: TableRowActionData<CellType>) -> Void) {

        self.type = type
        self.handler = .voidAction(handler)
    }
    
    public init<T>(_ type: TableRowActionType, handler: @escaping (_ data: TableRowActionData<CellType>) -> T) {

        self.type = type
        self.handler = .action(handler)
    }

    func invoke(item: CellType.T, cell: UITableViewCell?, path: IndexPath) -> Any? {
        return handler.invoke(item: item, cell: cell, path: path)
    }
}
