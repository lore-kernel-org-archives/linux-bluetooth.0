Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 24 Jan 2016 22:30:21 +0800
Message-ID: <CAGybJz_hOTULCDDEPXg_nT0bcoqZXGmxujCU3mfEnRkLUVToYw@mail.gmail.com>
Subject: Need help with convert bluez BLE configure file to windows
From: yangxuan he <yangxuan8282@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It seems like that bluez and windows BLE(Bluetooth Low Energy)
configure file contain different value.
How can I convert them. I would like to sync use my bluetooth mouse on
linux and windows.
example format post below:

bluez BLE configure file:
---
BREDR=false
AddressType=2
Name=Designer Mouse
Timestamp=1453647431
LocalCSRK=4156C09EE5A30E515C2B58200CDBC2E2
LocalCSRKAuthenticated=false
LongTermKey=DA1B4408FF8F418867772D5E43CB0026
LongTermKeyType=0
LongTermKeyEncSize=16
LongTermKeyEDiv=23907
LongTermKeyRand=7996339405254297788
Services=0000181200001000800000805F9B34FB;0000180F00001000800000805F9B34FB;0000180A00001000800000805F9B34FB;0000180100001000800000805F9B34FB;0000180000001000800000805F9B34FB;


windows:
---
AddressType 1
AuthReq 1
CSRK E8A035AC27868E5C6A2859ED3D9611A8
EDIV d05b
ERand f611ea5f4fc22b6a
IRK BF02C85F86E086666546ECF9CB1C41D9
KeyLength 0
LTK 5091C321B95B35030E40486F3188095A
