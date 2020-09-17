Pod::Spec.new do |s|
  s.name         = "TestPodF"
  s.version      = "0.0.2"
  s.summary      = "this is s.summary s.summary s.summary s.summary s.summary s.summary"
  s.description  = <<-DESC

  this is s.description s.descriptions.descriptions.descriptions.descriptions.descriptions.descriptions.descriptions.descriptions.descriptions.descriptions.description

  DESC
  s.homepage     = "https://github.com/riceFun/TestPodF"
  s.license      = "MIT"
  s.author       = { "riceFun" => "adolphbaofan@163.com" }
  s.source       = { :git => "https://github.com/riceFun/TestPodF.git", :tag => "#{s.version}"  }
  s.requires_arc = true
  s.platform     = :ios, "11.0"
  s.vendored_frameworks = "WorkSpaceSDK.framework"
#  s.dependency 'Alamofire', '~> 1.0.0'
#  s.source_files  = "TestPodF/WorkSpaceSDK.framework"
#  s.source_files  = "WorkSpaceSDK.framework"
  
  
#  s.public_header_files = "UpgradeManager/FMDBUpgradeHeader.h"

#  s.subspec "UpgradeManager" do |ss|
#    ss.source_files = "UpgradeManager"
#    ss.public_header_files = "UpgradeManager/*+Upgrade.h"
#  end

 # s.dependency "FMDB"

end
