Return-Path: <cyrus@holtmann.org>
Message-ID: <48EA893E.2000704@pook.es>
Date: Mon, 06 Oct 2008 23:55:10 +0200
From: Stuart Pook <kernel6org@pook.es>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
 BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez/git + 2.6.27-rc8 + Belkin F8T017 -> Can't read class of
 adapter
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>	 <48E3B3BF.6070205@pook.es>	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net>	 <48E7FB1E.8000504@pook.es> <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com>	 <48E91E6F.1030202@pook.es> <A34AC171-77C2-4377-A60C-60A2793A2297@gmail.com>	 <48EA7770.30307@pook.es> <1223325944.11272.227.camel@violet.holtmann.net>
In-Reply-To: <1223325944.11272.227.camel@violet.holtmann.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

hi Marcel

> loas btusb or hci_usb with reset=1 and show me the content
> of /proc/bus/usb/devices to add a permanent quirk.

I forgot to "hciconfig hci0 down", that's why I had to reboot.

: root@kooka; modprobe -v btusb  reset=1
insmod /lib/modules/2.6.27-rc8/kernel/drivers/bluetooth/btusb.ko reset=1

I suppose that I have to repair my headset (though bluetoothd doesn't say this)
to get it to work with this new dongle. Time to install bluez-gnome-1.8. I had
to use bluetooth-wizard to pair with the device. Running aplay did not make
bluetooth-applet open and ask me to pair (even though I had the headset in
pairing mode).

My Jabra JX10 Series II headset now works. It even works with the VoIP
client twinkle http://www.twinklephone.com/.

Many thanks! Extra!

I hope that the quirk will make it into 2.6.27.

:; cat  /proc/bus/usb/devices

T:  Bus=08 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0002 Rev= 2.06
S:  Manufacturer=Linux 2.6.27-rc8 ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:1d.7
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

T:  Bus=07 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0001 Rev= 2.06
S:  Manufacturer=Linux 2.6.27-rc8 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.2
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=06 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0001 Rev= 2.06
S:  Manufacturer=Linux 2.6.27-rc8 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.1
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=05 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0001 Rev= 2.06
S:  Manufacturer=Linux 2.6.27-rc8 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  4/800 us ( 1%), #Int=  8, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0002 Rev= 2.06
S:  Manufacturer=Linux 2.6.27-rc8 ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:1a.7
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480 MxCh= 4
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=02 MxPS=64 #Cfgs=  1
P:  Vendor=0424 ProdID=2504 Rev= 0.01
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=01 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms
I:* If#= 0 Alt= 1 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=02 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms

T:  Bus=04 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  5 Spd=12  MxCh= 3
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=05ac ProdID=1003 Rev= 4.10
S:  Manufacturer=Mitsumi Electric
S:  Product=Hub in Apple Extended USB Keyboard
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 50mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

T:  Bus=04 Lev=03 Prnt=05 Port=01 Cnt=01 Dev#=  9 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=045e ProdID=0040 Rev= 3.00
S:  Manufacturer=Microsoft
S:  Product=Microsoft 3-Button Mouse with IntelliEye(TM)
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

T:  Bus=04 Lev=03 Prnt=05 Port=02 Cnt=02 Dev#= 10 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=05ac ProdID=020b Rev= 4.10
S:  Manufacturer=Mitsumi Electric
S:  Product=Apple Extended USB Keyboard
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr= 50mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
I:* If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
E:  Ad=82(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

T:  Bus=04 Lev=01 Prnt=01 Port=04 Cnt=02 Dev#=  3 Spd=480 MxCh= 4
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=02 MxPS=64 #Cfgs=  1
P:  Vendor=050d ProdID=0231 Rev= 0.07
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=01 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms
I:* If#= 0 Alt= 1 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=02 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms

T:  Bus=04 Lev=02 Prnt=03 Port=01 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0a92 ProdID=0071 Rev= 1.00
S:  Manufacturer=AUDIOTRAK
S:  Product=MAYA7.1 USB
C:* #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=250mA
I:* If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=snd-usb-audio
I:* If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
I:  If#= 1 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 768 Ivl=1ms

T:  Bus=04 Lev=02 Prnt=03 Port=02 Cnt=02 Dev#=  7 Spd=12  MxCh= 3
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=2222 ProdID=0200 Rev= 0.01
S:  Manufacturer=Macally
S:  Product=Macally iKey
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

T:  Bus=04 Lev=03 Prnt=07 Port=00 Cnt=01 Dev#= 11 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=2222 ProdID=0003 Rev= 0.01
S:  Manufacturer=Macally
S:  Product=Macally iKey
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

T:  Bus=04 Lev=02 Prnt=03 Port=03 Cnt=03 Dev#=  8 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=00 Prot=ff MxPS= 8 #Cfgs=  1
P:  Vendor=04a9 ProdID=220d Rev= 1.00
S:  Manufacturer=Canon
S:  Product=CanoScan
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=ff Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=16ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  2, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0001 Rev= 2.06
S:  Manufacturer=Linux 2.6.27-rc8 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1a.2
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 4
D:  Ver= 1.01 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=05e3 ProdID=0604 Rev= 0.12
S:  Product=USB Hub
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

T:  Bus=03 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0d8c ProdID=000c Rev= 1.00
S:  Product=C-Media USB Headphone Set
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=snd-usb-audio
I:* If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
I:  If#= 1 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 200 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
I:  If#= 2 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
E:  Ad=82(I) Atr=05(Isoc) MxPS= 100 Ivl=1ms
I:* If#= 3 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
E:  Ad=83(I) Atr=03(Int.) MxPS=   4 Ivl=32ms

T:  Bus=03 Lev=02 Prnt=02 Port=02 Cnt=02 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=10d6 ProdID=1100 Rev= 1.00
S:  Product=USB 2.0(FS) FLASH DISK
S:  SerialNumber=USB 2.0(FS) FLASH DISK
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=05 Prot=50 Driver=usb-storage
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0001 Rev= 2.06
S:  Manufacturer=Linux 2.6.27-rc8 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1a.1
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 27/900 us ( 3%), #Int=  4, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0001 Rev= 2.06
S:  Manufacturer=Linux 2.6.27-rc8 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1a.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 3
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0a5c ProdID=4500 Rev= 1.00
S:  Manufacturer=Broadcom
S:  Product=BCM2046B1
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 94mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

T:  Bus=01 Lev=02 Prnt=03 Port=00 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0a5c ProdID=4502 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  2mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

T:  Bus=01 Lev=02 Prnt=03 Port=01 Cnt=02 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0a5c ProdID=4503 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  2mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

T:  Bus=01 Lev=02 Prnt=03 Port=02 Cnt=03 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=050d ProdID=0017 Rev= 2.91
S:  Manufacturer=Broadcom Corp
S:  Product=BLUETOOTH USB +EDR ADAPTER Class 1 v2.1 UHE
S:  SerialNumber=000A3A8494D9
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=  2mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

: root@kooka; src/.libs/bluetoothd -dn
bluetoothd[4605]: Bluetooth daemon
bluetoothd[4605]: Enabling debug information
bluetoothd[4605]: parsing main.conf
bluetoothd[4605]: offmode=NoScan
bluetoothd[4605]: discovto=0
bluetoothd[4605]: pageto=8192
bluetoothd[4605]: name=%h-%d
bluetoothd[4605]: class=0x000100
bluetoothd[4605]: inqmode=0
bluetoothd[4605]: Starting SDP server
bluetoothd[4605]: Loading plugins /home/stuart/ws/install/bluez/git/bluez/plugins
bluetoothd[4605]: /home/stuart/ws/install/bluez/git/bluez/plugins/audio.so
bluetoothd[4605]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[4605]: Unix socket created: 11
bluetoothd[4605]: Telephony plugin initialized
bluetoothd[4605]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes"
bluetoothd[4605]: /home/stuart/ws/install/bluez/git/bluez/plugins/serial.so
bluetoothd[4605]: /home/stuart/ws/install/bluez/git/bluez/plugins/hal.so
bluetoothd[4605]: /home/stuart/ws/install/bluez/git/bluez/plugins/service.so
bluetoothd[4605]: /home/stuart/ws/install/bluez/git/bluez/plugins/network.so
bluetoothd[4605]: Parsing /etc/bluetooth/network.conf failed: No such file or directory
bluetoothd[4605]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[4605]: bridge pan0 created
bluetoothd[4605]: /home/stuart/ws/install/bluez/git/bluez/plugins/input.so
bluetoothd[4605]: input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[4605]: HCI dev 0 registered
bluetoothd[4605]: child 4614 forked
bluetoothd[4605]: HCI dev 0 already up
bluetoothd[4605]: headset_server_probe: path /org/bluez/hci0
bluetoothd[4605]: Adding record with handle 0x10000
bluetoothd[4605]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4605]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[4605]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[4605]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[4605]: Adding record with handle 0x10001
bluetoothd[4605]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4605]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[4605]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[4605]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[4605]: a2dp_server_probe: path /org/bluez/hci0
bluetoothd[4605]: SEP 0xb8ec4790 registered: type:0 codec:0 seid:1
bluetoothd[4605]: Adding record with handle 0x10002
bluetoothd[4605]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4605]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[4605]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[4605]: avrcp_server_probe: path /org/bluez/hci0
bluetoothd[4605]: Adding record with handle 0x10003
bluetoothd[4605]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4605]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[4605]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[4605]: Adding record with handle 0x10004
bluetoothd[4605]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4605]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[4605]: proxy_probe: path /org/bluez/hci0
bluetoothd[4605]: Registered interface org.bluez.SerialProxyManager on path /org/bluez/hci0
bluetoothd[4605]: service_probe: path /org/bluez/hci0
bluetoothd[4605]: Registered interface org.bluez.Service on path /org/bluez/hci0
bluetoothd[4605]: network_server_probe: path /org/bluez/hci0
bluetoothd[4605]: Adding record with handle 0x10005
bluetoothd[4605]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4605]: Record pattern UUID 00001115-0000-1000-8000-00805f9
bluetoothd[4605]: register_server_record: got record id 0x10005
bluetoothd[4605]: Registered interface org.bluez.NetworkPeer on path /org/bluez/hci0
bluetoothd[4605]: network_server_probe: path /org/bluez/hci0
bluetoothd[4605]: Adding record with handle 0x10006
bluetoothd[4605]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4605]: Record pattern UUID 00001117-0000-1000-8000-00805f9
bluetoothd[4605]: register_server_record: got record id 0x10006
bluetoothd[4605]: Registered interface org.bluez.NetworkHub on path /org/bluez/hci0
bluetoothd[4605]: network_server_probe: path /org/bluez/hci0
bluetoothd[4605]: Adding record with handle 0x10007
bluetoothd[4605]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4605]: Record pattern UUID 00001116-0000-1000-8000-00805f9
bluetoothd[4605]: register_server_record: got record id 0x10007
bluetoothd[4605]: Registered interface org.bluez.NetworkRouter on path /org/bluez/hci0
bluetoothd[4605]: Adapter /org/bluez/hci0 has been enabled
bluetoothd[4605]: Starting security manager 0
bluetoothd[4605]: child 4614 exited
bluetoothd[4605]: Computer is classified as desktop
bluetoothd[4605]: Current device class is 0x4a0104
bluetoothd[4605]: Setting 0x000104 for major/minor device class
bluetoothd[4605]: Accepted new client connection on unix socket (fd=23)
bluetoothd[4605]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[4605]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[4605]: Unix client disconnected (fd=23)
bluetoothd[4605]: Accepted new client connection on unix socket (fd=23)
bluetoothd[4605]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[4605]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[4605]: Unix client disconnected (fd=23)
bluetoothd[4605]: Accepted new client connection on unix socket (fd=23)
bluetoothd[4605]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[4605]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[4605]: Unix client disconnected (fd=23)
bluetoothd[4605]: Accepted new client connection on unix socket (fd=23)
bluetoothd[4605]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[4605]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[4605]: Unix client disconnected (fd=23)
bluetoothd[4605]: Accepted new client connection on unix socket (fd=23)
bluetoothd[4605]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[4605]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[4605]: Unix client disconnected (fd=23)
