Return-Path: <c.torens@web.de>
Date: Fri, 27 Aug 2004 15:58:47 +0200
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [Bluez-users] l2cap question
Cc: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
References: <opsda220m9eocfdv@debian> <1093469385.537.17.camel@pegasus>  <opsdbdbhfdeocfdv@debian> <1093516424.2581.1.camel@pegasus>
From: "Christoph Torens" <c.torens@web.de>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Message-ID: <opsdd839qmeocfdv@debian>
In-Reply-To: <1093516424.2581.1.camel@pegasus>
Sender: c.torens@web.de
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel, Hi List,

On Thu, 26 Aug 2004 12:33:44 +0200, Marcel Holtmann <marcel@holtmann.org>  
wrote:

> Hi Christoph,
>
>> >> Does a Bluetooth USB-Dongle use isochronus USB transfers?
>> > It uses it for SCO support.
>>
>> I read SCO is only (or mainly?) for speech.
>> I don't use speech, but I guess it is somehow used when
>> SCO is enabled in the config?
>> Is it used by "hciconfig hci0 up", too?
>> (This is making problems with some, but not all dongles)
>
> show me the "hciconfig -a" and "/proc/bus/usb/devices" for these dongles
> and I will mark them with broken SCO support.

ok, here it follows. But I dond't understand, I thought my hostcontroller  
has
isoc problems? But Why does this dongle have problems with the command and  
the
Acer BT510 Zeevo chip not?

The device with problems is a EPoX BT-DG02A

root@viper root# hciconfig -a
hci0:   Type: USB
         BD Address: 00:04:61:81:11:3C ACL MTU: 192:8  SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:384 acl:0 sco:0 events:17 errors:0
         TX bytes:308 acl:0 sco:0 commands:16 errors:0
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'BlueZ (0)'
         Class: 0x000100
         Service Classes: Unspecified
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:  
0x20d
         Manufacturer: Cambridge Silicon Radio (10)

root@viper root# cat /proc/bus/usb/devices
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB ISP116x Root Hub
S:  SerialNumber=0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a12 ProdID=0001 Rev= 5.25
C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=  0mA
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
root@viper root#

-- 
Regards,
Christoph
