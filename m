Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <402D1E8C.6020301@handgranat.org>
From: Sunnan <sunnan@handgranat.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] apple wireless mouse on apple ibook (g4, builtin
 usb)
References: <402D07B8.8030504@handgranat.org> <1076694675.2671.191.camel@pegasus>
In-Reply-To: <1076694675.2671.191.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------020105020703060005090403"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 13 Feb 2004 19:59:24 +0100

This is a multi-part message in MIME format.
--------------020105020703060005090403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:
> what is the output of "hciconfig -a" and the content of
> /proc/bus/usb/devices (before and after the run of hid2hci)?

I don't know how to show how it was before. Now it shows:

slowstorm/home/sunnan% sudo hciconfig -a
hci0:   Type: USB
          BD Address: 00:0D:93:04:19:15  ACL MTU: 192:8  SCO MTU: 64:8
          UP RUNNING PSCAN ISCAN
          RX bytes:6963 acl:399 sco:0 events:198 errors:0
          TX bytes:2109 acl:66 sco:0 commands:62 errors:0
          Features: 0xff 0xff 0x0f 0x00 0x18 0x18 0x00 0x00
          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
          Link policy: RSWITCH HOLD SNIFF PARK
          Link mode: SLAVE ACCEPT
          Name: 'slowstorm-0'
          Class: 0x000100
          HCI Ver: 1.1 (0x1) HCI Rev: 0x8503  LMP Ver: 1.1 (0x1) LMP
Subver: 0x8503
          Manufacturer: not assigned (2560)


and I've attached the devices.txt that resulted from

cat /proc/bus/usb/devices > devices.txt

(The name 'slowstorm-0' above probably is due to the line
           name "%h-%d";
which I have in my /etc/bluetooth/hcid.conf)

> The Apple Bluetooth mouse expects a PIN or a link key even if you only
> connect to the SDP service (security mode 3). This is stupid for a HID
> mouse, but they did it this way. A working PIN is "0000". So I say you
> replace your PIN helper program (from hcid.conf) with the following
> executable script
> 
> 	#!/bin/sh
> 	echo "PIN:0000"
> 
> and put also "0000" into /etc/bluetooth/pin. Restart the hcid and see
> how it goes. If this don't work, run "hcidump -w <file>" and send us the
> dump file.

One of the more interesting(?) entries in my /var/log/daemon.log after
doing this was:

Feb 13 19:38:29 slowstorm sdpd[25047]: init_server: binding L2CAP
socket: Address already in use

hcidump -w dump.data

printed:
HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff

but never quit. I checked dump.data with wc from time to time but it
never appeared to get any largers.

I got childishly impatient after a couple of minutes and hit C-c. I
attached the file anyway. Is it supposed to take very long time? If so,
I could give it another go. Thanks for your patience.

Sunnan

--------------020105020703060005090403
Content-Type: text/plain;
 name="devices.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="devices.txt"


T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.3-rc2-ben1 ohci_hcd
S:  Product=OHCI Host Controller
S:  SerialNumber=0001:01:1b.1
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 3
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.3-rc2-ben1 ohci_hcd
S:  Product=OHCI Host Controller
S:  SerialNumber=0001:01:1b.0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  1, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.3-rc2-ben1 ohci_hcd
S:  Product=OHCI Host Controller
S:  SerialNumber=0001:01:1a.0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=05ac ProdID=8203 Rev= 9.01
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)


--------------020105020703060005090403
Content-Type: application/octet-stream;
 name="dump.data"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dump.data"

DQABAIkaLUBLmQwABAQKV18BlQoAgCUAAQsAAACJGi1Ae5kMAAEJBAdXXwGVCgABBwABAIka
LUAn7wwABA8EAAEJBA4AAQCKGi1AWckCAAQDCwAtAFdfAZUKAAEACAAAAIoaLUCHyQIAAQ0I
BC0ADwAKAAEAihotQDbNAgAEIAdXXwGVCgABEQABAIoaLUCp5AIAAi0gDAAIAAEAAhQEABEA
UAAVAAAAihotQMrkAgACLSAQAAwAAQADFAgAAABQAAIAAAAJAAEAihotQLELAwAEDgYBDQgA
LQAIAAAAihotQMELAwABDwQELQAYzAcAAQCKGi1AFU4DAAQPBAABDwQIAAEAihotQP9RAwAE
HQUALQAYAAcAAQCRGi1AVnAHAAQFBAAtAAgNAAEAkRotQJZeCAAEBApXXwGVCgCAJQABCwAA
AJEaLUDGXggAAQkEB1dfAZUKAAEHAAEAkRotQHi0CAAEDwQAAQkEDgABAJEaLUD8zA0ABAML
ADEAV18BlQoAAQAIAAAAkRotQCrNDQABDQgEMQAPAAoAAQCRGi1A2dANAAQgB1dfAZUKAAER
AAEAkRotQEToDQACMSAMAAgAAQACFQQAEQBRABUAAACRGi1AWugNAAIxIBAADAABAAMVCAAA
AFEAAgAAAAkAAQCRGi1AVg8OAAQOBgENCAAxAAgAAACRGi1AcQ8OAAEPBAQxABjMBwABAJEa
LUDQTQ4ABA8EAAEPBAgAAQCRGi1AuFEOAAQdBQAxABgACAABAJIaLUA8kwUABBMFATEAAQAH
AAEArhotQJg7CQAEBQQAMQAI
--------------020105020703060005090403--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
