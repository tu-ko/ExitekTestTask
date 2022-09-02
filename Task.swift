// Implement mobile phone storage protocol
// Requirements:
// - Mobiles must be unique (IMEI is an unique number)
// - Mobiles must be stored in memory
protocol MobileStorageProtocol {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}

struct Mobile: Hashable {
    let imei: String
    let model: String
}

enum MobileStorageError: Error {
    case mobileAlreadyExistsError
    case mobileImeiAlreadyExistsError
    case mobileNotFound
}


class MobileStorage: MobileStorageProtocol {
    var mobiles: Set<Mobile> = Set<Mobile>()
    
    func getAll() -> Set<Mobile> {
        return mobiles
    }
    
    func findByImei(_ imei: String) -> Mobile? {
        return mobiles.first { $0.imei == imei }
    }

    func save(_ mobile: Mobile) throws -> Mobile {
        if findByImei(mobile.imei) != nil {
            throw MobileStorageError.mobileImeiAlreadyExistsError
        }
        
        let (inserted, newMobile) = mobiles.insert(mobile)
        return newMobile
    }

    func delete(_ product: Mobile) throws {
        guard let deleted = mobiles.remove(product) else {
            throw MobileStorageError.mobileNotFound
        }
    }

    func exists(_ product: Mobile) -> Bool {
        mobiles.contains(product)
    }
}

