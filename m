Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <50745.80.146.4.18.1102837718.squirrel@schrell.de>
In-Reply-To: <1102804861.8750.2.camel@pegasus>
References: <35275.80.146.4.18.1102802831.squirrel@schrell.de>
    <1102804861.8750.2.camel@pegasus>
Subject: Re: [Bluez-users] 'hciconfig -a' ok,
      but 'hcitools scan' shows no devices
From: "Andreas Schrell" <as@schrell.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 12 Dec 2004 08:48:38 +0100 (CET)


Marcel,

yes original firmware, internal Bluetooth from Dell

/proc/bus/usb/devices:

delli:~# cat /proc/bus/usb/devices

T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.10-rc3as1 ehci_hcd
S:  Product=Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
S:  SerialNumber=0000:00:1d.7
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.10-rc3as1 uhci_hcd
S:  Product=Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI
Controller #3
S:  SerialNumber=0000:00:1d.2
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.10-rc3as1 uhci_hcd
S:  Product=Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI
Controller #2
S:  SerialNumber=0000:00:1d.1
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=120/900 us (13%), #Int=  2, #Iso=  2
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.10-rc3as1 uhci_hcd
S:  Product=Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI
Controller #1
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  4 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=05fe ProdID=0011 Rev= 0.10
S:  Manufacturer=Cypress Sem
S:  Product=PS2/USB Browser Combo Mouse
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=413c ProdID=8000 Rev=12.66
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

And hcidump -X from "hciconfig -a" and "hcitool scan":

HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> HCI Event: Command Complete (0x0e) plen 252
  0000: 01 14 0c 00 64 65 6c 6c  69 2d 30 00 00 00 00 00  ....delli-0.....
  0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00              ............
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
> HCI Event: Command Complete (0x0e) plen 7
  0000: 01 23 0c 00 00 01 00                              .#.....
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
  0000: 01 01 10 00 02 f2 04 02  0a 00 f2 04              ............
< HCI Command: Inquiry (0x01|0x0001) plen 5
  0000: 33 8b 9e 08 64                                    3...d
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 01 04                                       ....
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Inquiry Complete (0x01) plen 1
  0000: 00                                                .

and with S65:
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> HCI Event: Command Complete (0x0e) plen 252
  0000: 01 14 0c 00 64 65 6c 6c  69 2d 30 00 00 00 00 00  ....delli-0.....
  0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00              ............
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
> HCI Event: Command Complete (0x0e) plen 7
  0000: 01 23 0c 00 00 01 00                              .#.....
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
  0000: 01 01 10 00 02 f2 04 02  0a 00 f2 04              ............
< HCI Command: Inquiry (0x01|0x0001) plen 5
  0000: 33 8b 9e 08 64                                    3...d
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 01 04                                       ....
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Inquiry Complete (0x01) plen 1
  0000: 00                                                .

I think these are the same.

I can switch Bluetooth off and on. If I press the button I get

< HCI Command: Reset (0x03|0x0003) plen 0
Receive failed: Broken pipe

and in syslog

Dec 12 08:44:57 localhost kernel: atkbd.c: Unknown key pressed (translated
set 2, code 0x88 on isa0060/serio0).
Dec 12 08:44:57 localhost kernel: atkbd.c: Use 'setkeycodes e008
<keycode>' to make it known.
Dec 12 08:44:57 localhost kernel: usb 1-2: USB disconnect, address 6
Dec 12 08:44:57 localhost hcid[9862]: HCI dev 0 down
Dec 12 08:44:57 localhost hcid[9862]: Stoping security manager 0
Dec 12 08:44:57 localhost hcid[9862]: HCI dev 0 unregistered

next time I get
Dec 12 08:46:06 localhost hcid[9862]: HCI dev 0 up
Dec 12 08:46:06 localhost hcid[9862]: Starting security manager 0
Dec 12 08:46:09 localhost usb.agent[25983]:      hci_usb: already loaded
Dec 12 08:46:09 localhost usb.agent[25988]:      hci_usb: already loaded
Dec 12 08:46:09 localhost usb.agent[25993]:      hci_usb: already loaded

Look ok for me.

I tested a Nokia 6310i also, which is also not found.

Andreas




> Hi Andreas,
>
>> I am new on this list with the following problem:
>>
>> "hciconfig -a" shows
>>
>> hci0:   Type: USB
>>         BD Address: 00:10:C6:3A:B5:70 ACL MTU: 192:8  SCO MTU: 64:8
>>         UP RUNNING PSCAN ISCAN
>>         RX bytes:4187 acl:0 sco:0 events:370 errors:0
>>         TX bytes:1902 acl:0 sco:0 commands:72 errors:0
>>         Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
>>         Packet type: DM1 DH1 HV1
>>         Link policy: RSWITCH HOLD SNIFF PARK
>>         Link mode: SLAVE ACCEPT
>>         Name: 'delli-0'
>>         Class: 0x000100
>>         Service Classes: Unspecified
>>         Device Class: Computer, Uncategorized
>>         HCI Ver: 1.2 (0x2) HCI Rev: 0x4f2 LMP Ver: 1.2 (0x2) LMP Subver:
>> 0x4f2
>>         Manufacturer: Cambridge Silicon Radio (10)
>>
>> "hcitools scan" or "hcitools inq" only show scanning but no device.
>>
>> Kernel versions tested where 2.6.8.1 and 2.6.10-rc3 and the following
>> debian packages
>>
>> ii  bluez-firmware                1.0-2
>> ii  bluez-hcidump                 1.12-1
>> ii  bluez-pcmcia-support          2.10-5
>> ii  bluez-pin                     0.24-1
>> ii  bluez-utils                   2.10-5
>>
>> dmesg:Bluetooth: Core ver 2.7
>> Bluetooth: HCI device and connection manager initialized
>> Bluetooth: HCI socket layer initialized
>> Bluetooth: HCI USB driver ver 2.7
>> Bluetooth: L2CAP ver 2.6
>> Bluetooth: L2CAP socket layer initialized
>> Bluetooth: RFCOMM ver 1.3
>> Bluetooth: RFCOMM socket layer initialized
>> Bluetooth: RFCOMM TTY layer initialized
>>
>> Tested also with --length=30, --flush
>>
>> System is a Dell 8600 and a Siemens S65 mobile.
>
> so this is the original firmware in the Bluetooth chip? You haven't
> flashed it? Is there a wireless switch on that machine? Maybe you need
> to activate the antenna.
>
> Please show us "/proc/bus/usb/devices" and what "hcidump -X" showing.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
