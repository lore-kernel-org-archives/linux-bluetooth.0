Return-Path: <cyrus@holtmann.org>
Message-ID: <51E8DBFF.4060702@boh.de>
Date: Fri, 19 Jul 2013 08:26:07 +0200
From: =?ISO-8859-1?Q?J=F6rg_Esser?= <jackfritt@boh.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
References: <51E7ED11.7010103@boh.de> <36A79410-3FA3-408F-BA16-6A30568A7035@holtmann.org>
In-Reply-To: <36A79410-3FA3-408F-BA16-6A30568A7035@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann schrieb:
> Hi Joerg,
>
>> don´t know if it is wrong to post under the same topic which is more than one year old.
>> Ref to it is here.
>> http://www.spinics.net/lists/linux-bluetooth/msg18763.html
>> There was never an answer to the latest question from Michael if there will be a solution.
>>
>> I also tried to get this to run with my latest kernel 3.10 under debian 7 without success.
>> Will there be a solution or should I open my real trashbin?(other sticks are working so far for me) :)
>>
>> Let me know if you need more info´s on that.
>>
>> Thx,
>> Joerg
>>
>> My syslog says:
>> Jul 18 15:11:10 debian-capi kernel: [ 64.808373] usb 1-3: new full-speed USB device number 5 using ohci_hcd
>> Jul 18 15:11:10 debian-capi kernel: [ 65.277828] usb 1-3: New USB device found, idVendor=057c, idProduct=3800
>> Jul 18 15:11:10 debian-capi kernel: [ 65.277834] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>> Jul 18 15:11:10 debian-capi kernel: [ 65.277838] usb 1-3: Product: Bluetooth Device
>> Jul 18 15:11:10 debian-capi kernel: [ 65.277841] usb 1-3: Manufacturer: Bluetooth Device
>> Jul 18 15:11:10 debian-capi kernel: [ 65.277844] usb 1-3: SerialNumber: CC1C8D0E0400
>> Jul 18 15:11:10 debian-capi bluetoothd[2199]: HCI dev 0 registered
>> Jul 18 15:11:10 debian-capi bluetoothd[2199]: Listening for HCI events on hci0
>> Jul 18 15:11:11 debian-capi bluetoothd[2894]: Can't init device hci0: Invalid request code (56)
> any chance you can run btmon and see if we have failing HCI commands during the setup phase.
Sure! Here you are:

debian-capi:~# btmon
Bluetooth monitor ver 5.7
= New Index: 00:00:00:00:00:00 (BR/EDR,USB,hci0) [hci0] 0.025804
< HCI Command: Reset (0x03|0x0003) plen 0 [hci0] 0.031045
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.037000
       Reset (0x03|0x0003) ncmd 1
         Status: Success (0x00)
< HCI Command: Read Local Supported Feat.. (0x04|0x0003) plen 0 [hci0] 
0.037209
 > HCI Event: Command Complete (0x0e) plen 12 [hci0] 0.040740
       Read Local Supported Features (0x04|0x0003) ncmd 1
         Status: Success (0x00)
         Features: 0xff 0xff 0x05 0x00 0x18 0x18 0x00 0x00
           3 slot packets
           5 slot packets
           Encryption
           Slot offset
           Timing accuracy
           Role switch
           Hold mode
           Sniff mode
           Park state
           Power control requests
           Channel quality driven data rate (CQDDR)
           SCO link
           HV2 packets
           HV3 packets
           u-law log synchronous data
           A-law log synchronous data
           CVSD synchronous data
           Power control
           AFH capable slave
           AFH classification slave
           AFH capable master
           AFH classification master
< HCI Command: Read Local Version Inform.. (0x04|0x0001) plen 0 [hci0] 
0.041025
 > HCI Event: Command Complete (0x0e) plen 12 [hci0] 0.043811
       Read Local Version Information (0x04|0x0001) ncmd 1
         Status: Success (0x00)
         HCI version: 2 - 0x2006
         LMP version: 2 - 0x1806
         Manufacturer: AVM Berlin (31)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0 [hci0] 0.044100
 > HCI Event: Command Complete (0x0e) plen 10 [hci0] 0.046722
       Read BD ADDR (0x04|0x0009) ncmd 1
         Status: Success (0x00)
         Address: 00:04:0E:8D:1C:CC (OUI 00-04-0E)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0 [hci0] 0.046988
 > HCI Event: Command Complete (0x0e) plen 11 [hci0] 0.050948
       Read Buffer Size (0x04|0x0005) ncmd 1
         Status: Success (0x00)
         ACL MTU: 120  ACL max packet: 20
         SCO MTU: 24   SCO max packet: 5
< HCI Command: Read Class of Device (0x03|0x0023) plen 0 [hci0] 0.051235
 > HCI Event: Command Complete (0x0e) plen 7 [hci0] 0.055000
       Read Class of Device (0x03|0x0023) ncmd 1
         Status: Success (0x00)
         Class: 0x000000
           Major class: Miscellaneous
           Minor class: 0x00
< HCI Command: Read Local Name (0x03|0x0014) plen 0 [hci0] 0.055261
 > HCI Event: Command Complete (0x0e) plen 252 [hci0] 0.092918
       Read Local Name (0x03|0x0014) ncmd 1
         Status: Success (0x00)
         Name:
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0 [hci0] 0.093212
 > HCI Event: Command Complete (0x0e) plen 6 [hci0] 0.096713
       Read Voice Setting (0x03|0x0025) ncmd 1
         Status: Success (0x00)
         Setting: 0x0060
< HCI Command: Set Event Filter (0x03|0x0005) plen 1 [hci0] 0.096974
         Type: 0x00
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.101024
       Set Event Filter (0x03|0x0005) ncmd 1
         Status: Success (0x00)
< HCI Command: Write Connection Accept T.. (0x03|0x0016) plen 2 [hci0] 
0.101262
         Timeout: 20000.000 msec (0x7d00)
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.105011
       Write Connection Accept Timeout (0x03|0x0016) ncmd 1
         Status: Success (0x00)
< HCI Command: Read Page Scan Activity (0x03|0x001b) plen 0 [hci0] 0.105254
 > HCI Event: Command Complete (0x0e) plen 8 [hci0] 0.108002
       Read Page Scan Activity (0x03|0x001b) ncmd 1
         Status: Success (0x00)
         Interval: 1280.000 msec (0x0800)
         Window: 11.250 msec (0x0012)
< HCI Command: Read Page Scan Type (0x03|0x0046) plen 0 [hci0] 0.108255
 > HCI Event: Command Complete (0x0e) plen 5 [hci0] 0.111710
       Read Page Scan Type (0x03|0x0046) ncmd 1
         Status: Success (0x00)
         Type: Standard Scan (0x00)
< HCI Command: Set Event Mask (0x03|0x0001) plen 8 [hci0] 0.111960
         Mask: 0x00001807fffbffff
           Inquiry Complete
           Inquiry Result
           Connection Complete
           Connection Request
           Disconnection Complete
           Authentication Complete
           Remote Name Request Complete
           Encryption Change
           Change Connection Link Key Complete
           Master Link Key Complete
           Read Remote Supported Features Complete
           Read Remote Version Information Complete
           QoS Setup Complete
           Command Complete
           Command Status
           Hardware Error
           Flush Occurred
           Role Change
           Mode Change
           Return Link Keys
           PIN Code Request
           Link Key Request
           Link Key Notification
           Loopback Command
           Data Buffer Overflow
           Max Slots Change
           Read Clock Offset Complete
           Connection Packet Type Changed
           QoS Violation
           Page Scan Mode Change
           Page Scan Repetition Mode Change
           Flow Specification Complete
           Inquiry Result with RSSI
           Read Remote Extended Features Complete
           Synchronous Connection Complete
           Synchronous Connection Changed
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.114810
       Set Event Mask (0x03|0x0001) ncmd 1
         Status: Success (0x00)
< HCI Command: Read Local Supported Comm.. (0x04|0x0002) plen 0 [hci0] 
0.114948
 > HCI Event: Command Status (0x0f) plen 4 [hci0] 0.117791
       Read Local Supported Commands (0x04|0x0002) ncmd 1
         Status: Unknown HCI Command (0x01)
< HCI Command: Reset (0x03|0x0003) plen 0 [hci0] 0.121133
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.131017
       Reset (0x03|0x0003) ncmd 1
         Status: Success (0x00)
< HCI Command: Read Local Supported Feat.. (0x04|0x0003) plen 0 [hci0] 
0.131157
 > HCI Event: Command Complete (0x0e) plen 12 [hci0] 0.134997
       Read Local Supported Features (0x04|0x0003) ncmd 1
         Status: Success (0x00)
         Features: 0xff 0xff 0x05 0x00 0x18 0x18 0x00 0x00
           3 slot packets
           5 slot packets
           Encryption
           Slot offset
           Timing accuracy
           Role switch
           Hold mode
           Sniff mode
           Park state
           Power control requests
           Channel quality driven data rate (CQDDR)
           SCO link
           HV2 packets
           HV3 packets
           u-law log synchronous data
           A-law log synchronous data
           CVSD synchronous data
           Power control
           AFH capable slave
           AFH classification slave
           AFH capable master
           AFH classification master
< HCI Command: Read Local Version Inform.. (0x04|0x0001) plen 0 [hci0] 
0.135164
 > HCI Event: Command Complete (0x0e) plen 12 [hci0] 0.138030
       Read Local Version Information (0x04|0x0001) ncmd 1
         Status: Success (0x00)
         HCI version: 2 - 0x2006
         LMP version: 2 - 0x1806
         Manufacturer: AVM Berlin (31)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0 [hci0] 0.138178
 > HCI Event: Command Complete (0x0e) plen 10 [hci0] 0.141784
       Read BD ADDR (0x04|0x0009) ncmd 1
         Status: Success (0x00)
         Address: 00:04:0E:8D:1C:CC (OUI 00-04-0E)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0 [hci0] 0.141965
 > HCI Event: Command Complete (0x0e) plen 11 [hci0] 0.144741
       Read Buffer Size (0x04|0x0005) ncmd 1
         Status: Success (0x00)
         ACL MTU: 120  ACL max packet: 20
         SCO MTU: 24   SCO max packet: 5
< HCI Command: Read Class of Device (0x03|0x0023) plen 0 [hci0] 0.144831
 > HCI Event: Command Complete (0x0e) plen 7 [hci0] 0.148377
       Read Class of Device (0x03|0x0023) ncmd 1
         Status: Success (0x00)
         Class: 0x000000
           Major class: Miscellaneous
           Minor class: 0x00
< HCI Command: Read Local Name (0x03|0x0014) plen 0 [hci0] 0.148518
 > HCI Event: Command Complete (0x0e) plen 252 [hci0] 0.187913
       Read Local Name (0x03|0x0014) ncmd 1
         Status: Success (0x00)
         Name:
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0 [hci0] 0.188103
 > HCI Event: Command Complete (0x0e) plen 6 [hci0] 0.191659
       Read Voice Setting (0x03|0x0025) ncmd 1
         Status: Success (0x00)
         Setting: 0x0060
< HCI Command: Set Event Filter (0x03|0x0005) plen 1 [hci0] 0.191790
         Type: 0x00
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.195844
       Set Event Filter (0x03|0x0005) ncmd 1
         Status: Success (0x00)
< HCI Command: Write Connection Accept T.. (0x03|0x0016) plen 2 [hci0] 
0.195971
         Timeout: 20000.000 msec (0x7d00)
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.198667
       Write Connection Accept Timeout (0x03|0x0016) ncmd 1
         Status: Success (0x00)
< HCI Command: Read Page Scan Activity (0x03|0x001b) plen 0 [hci0] 0.198911
 > HCI Event: Command Complete (0x0e) plen 8 [hci0] 0.202899
       Read Page Scan Activity (0x03|0x001b) ncmd 1
         Status: Success (0x00)
         Interval: 1280.000 msec (0x0800)
         Window: 11.250 msec (0x0012)
< HCI Command: Read Page Scan Type (0x03|0x0046) plen 0 [hci0] 0.203040
 > HCI Event: Command Complete (0x0e) plen 5 [hci0] 0.206659
       Read Page Scan Type (0x03|0x0046) ncmd 1
         Status: Success (0x00)
         Type: Standard Scan (0x00)
< HCI Command: Set Event Mask (0x03|0x0001) plen 8 [hci0] 0.206842
         Mask: 0x00001807fffbffff
           Inquiry Complete
           Inquiry Result
           Connection Complete
           Connection Request
           Disconnection Complete
           Authentication Complete
           Remote Name Request Complete
           Encryption Change
           Change Connection Link Key Complete
           Master Link Key Complete
           Read Remote Supported Features Complete
           Read Remote Version Information Complete
           QoS Setup Complete
           Command Complete
           Command Status
           Hardware Error
           Flush Occurred
           Role Change
           Mode Change
           Return Link Keys
           PIN Code Request
           Link Key Request
           Link Key Notification
           Loopback Command
           Data Buffer Overflow
           Max Slots Change
           Read Clock Offset Complete
           Connection Packet Type Changed
           QoS Violation
           Page Scan Mode Change
           Page Scan Repetition Mode Change
           Flow Specification Complete
           Inquiry Result with RSSI
           Read Remote Extended Features Complete
           Synchronous Connection Complete
           Synchronous Connection Changed
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.209839
       Set Event Mask (0x03|0x0001) ncmd 1
         Status: Success (0x00)
< HCI Command: Read Local Supported Comm.. (0x04|0x0002) plen 0 [hci0] 
0.210014
 > HCI Event: Command Status (0x0f) plen 4 [hci0] 0.217361
       Read Local Supported Commands (0x04|0x0002) ncmd 1
         Status: Unknown HCI Command (0x01)


>
>> debian-capi:~# lsusb -v -d 057c:3800
> Can you include /sys/kernel/debug/usb/devices from this device.

After mounting debugfs with

*mount -t debugfs none /sys/kernel/debug*

I got this:

debian-capi:~# cat /sys/kernel/debug/usb/devices

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh= 8
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0002 Rev= 3.10
S:  Manufacturer=Linux 3.10.1 ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:0b.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12   MxCh= 8
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0001 Rev= 3.10
S:  Manufacturer=Linux 3.10.1 ohci_hcd
S:  Product=OHCI Host Controller
S:  SerialNumber=0000:00:06.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=80ee ProdID=0021 Rev= 1.00
S:  Manufacturer=VirtualBox
S:  Product=USB Tablet
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   6 Ivl=10ms

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=02(comm.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0675 ProdID=1688 Rev= 1.00
S:  Manufacturer=USB ISDN TA
S:  Product=USB ISDN TA
S:  SerialNumber=USB ISDN TA
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr= 64mA
I:* If#= 0 Alt= 0 #EPs= 0 Cls=02(comm.) Sub=80 Prot=ff Driver=(none)
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=ff Driver=HFC-S_USB
I:* If#= 1 Alt= 1 #EPs= 8 Cls=0a(data ) Sub=00 Prot=ff Driver=HFC-S_USB
E:  Ad=05(O) Atr=01(Isoc) MxPS=  16 Ivl=1ms
E:  Ad=85(I) Atr=01(Isoc) MxPS=  16 Ivl=1ms
E:  Ad=06(O) Atr=01(Isoc) MxPS=  16 Ivl=1ms
E:  Ad=86(I) Atr=01(Isoc) MxPS=  16 Ivl=1ms
E:  Ad=07(O) Atr=01(Isoc) MxPS=  16 Ivl=1ms
E:  Ad=87(I) Atr=01(Isoc) MxPS=  16 Ivl=1ms
E:  Ad=08(O) Atr=01(Isoc) MxPS=  16 Ivl=1ms
E:  Ad=88(I) Atr=01(Isoc) MxPS=  16 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 7 Cls=0a(data ) Sub=00 Prot=ff Driver=HFC-S_USB
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=4ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=4ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=16ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  64 Ivl=4ms
I:  If#= 1 Alt= 3 #EPs= 8 Cls=0a(data ) Sub=00 Prot=ff Driver=HFC-S_USB
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=05(O) Atr=01(Isoc) MxPS=  16 Ivl=1ms
E:  Ad=85(I) Atr=01(Isoc) MxPS=  16 Ivl=1ms
E:  Ad=06(O) Atr=01(Isoc) MxPS=  16 Ivl=1ms
E:  Ad=86(I) Atr=01(Isoc) MxPS=  16 Ivl=1ms

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=03 Dev#=  8 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=ff Prot=ff MxPS=64 #Cfgs=  1
P:  Vendor=057c ProdID=3800 Rev=15.00
S:  Manufacturer=Bluetooth Device
S:  Product=Bluetooth Device
S:  SerialNumber=CC1C8D0E0400
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=200mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
debian-capi:~#

Oh i forgot to mention that I run this under Virtualbox 4.2.16 with 
Windows7 64bit host.
I hope that i still get support?
If not I also can put this into some real hardware with latest kernel.


-- 
Gruss, Joerg
