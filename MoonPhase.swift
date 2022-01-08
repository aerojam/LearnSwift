import Foundation

func julianDate(from date: Date) -> Int {
    let d = Calendar.current.component(.day, from: date)
    let m = Calendar.current.component(.month, from: date)
    let y = Calendar.current.component(.year, from: date)
    
    var mm, yy: Int
    let k1, k2, k3: Int
    var j: Int
    
    yy = y - Int((12 - m) / 10)
    mm = m + 9
    
    if mm >= 12 {
        mm = mm - 12
    }
    
    k1 = Int(365.25 * Double(yy + 4712))
    k2 = Int(30.6001 * Double(mm) + 0.5)
    k3 = Int(((Double(yy) / 100.0) + 49.0) * 0.75) - 38
    
    j = k1 + k2 + d + 59
    
    if j > 2299160 {
        j = j - k3
    }
    
    return j
}

func moonAge(of date: Date) -> Int {
    var ag: Double
    
    let j = julianDate(from: date)
    
    var ip = (Double(j) + 4.867) / 29.53059
    ip = ip - Double(Int(ip))
    
    if ip < 0.5 {
        ag = ip * 29.53059 + 29.53059 / 2;
    } else {
        ag = ip * 29.53059 - 29.53059 / 2;
    }
    
    ag = Double(Int(ag)) + 1.0;
    
    return Int(ag);
}

func moonPhase(ofMoonAge age: Int) -> String {
    switch age {
    case 1:
        return "nov"
    case 2...7:
        return "dorůstající srpek"
    case 8:
        return "první čtvrť"
    case 9...14:
        return "dorůstající měsíc"
    case 15:
        return "úplněk"
    case 16...22:
        return "couvající měsíc"
    case 23:
        return "poslední čtvrť"
    case 24...29:
        return "couvající srpek"
    default:
        return "neznámý"
    }
}

let now = Date.now

for nextDays in 0..<31 {
    if let day = Calendar.current.date(byAdding: .day, value: nextDays, to: now) {
        print("\(day) | \(moonAge(of: day)) | \(moonPhase(ofMoonAge: moonAge(of: day)))")
    }
}

