Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <432CA117.5060109@psi.co.at>
From: Raphael Wegmann <raphael@psi.co.at>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Cc: swegmann@repr.at
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-devel] rfcomm bluez problem
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 18 Sep 2005 01:04:55 +0200

Hello,

the connection to my bluetooth modem doesn't work very reliable.
When I connect successfully, "hcidump -V -X" looks like this:
                                  .
< HCI Command: Create Connection (0x01|0x0005) plen 13
   0000: df cd 29 60 10 00 18 cc  02 00 00 00 01           ..)`.........
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Link Key Request (0x17) plen 6
   0000: df cd 29 60 10 00                                 ..)`..
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
   0000: df cd 29 60 10 00 ed 42  d3 73 9a 98 15 6e 09 95  ..)`...B.s...n..
   0010: 99 58 13 08 39 e2                                 .X..9.
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     0000: 00 df cd 29 60 10 00                              ...)`..
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 41 bdaddr 00:10:60:29:CD:DF type ACL encrypt 0x01
< ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
   0000: 29 00 06 00                                       )...
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     0000: 00 29 00                                          .).
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
   0000: df cd 29 60 10 00 01                              ..)`...
 > HCI Event: Max Slots Change (0x1b) plen 3
   0000: 29 00 05                                          )..
 > ACL data: handle 41 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
       Connection pending - Authorization pending
 > ACL data: handle 41 flags 0x02 dlen 16

In the error case, the trace looks like this:
                                      .
< HCI Command: Create Connection (0x01|0x0005) plen 13
   0000: df cd 29 60 10 00 18 cc  02 00 00 00 01           ..)`.........
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Link Key Request (0x17) plen 6
   0000: df cd 29 60 10 00                                 ..)`..
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
   0000: df cd 29 60 10 00 ed 42  d3 73 9a 98 15 6e 09 95  ..)`...B.s...n..
   0010: 99 58 13 08 39 e2                                 .X..9.
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     0000: 00 df cd 29 60 10 00                              ...)`..
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 41 bdaddr 00:10:60:29:CD:DF type ACL encrypt 0x01
< ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
   0000: 29 00 06 00                                       )...
 > HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     0000: 00 29 00                                          .).
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
   0000: df cd 29 60 10 00 01                              ..)`...
 > HCI Event: Max Slots Change (0x1b) plen 3
   0000: 29 00 05                                          )..
< HCI Command: Disconnect (0x01|0x0006) plen 3
   0000: 29 00 13                                          )..
 > HCI Event: Command Status (0x0f) plen 4
     Disconnect (0x01|0x0006) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 41 reason 0x16
     Reason: Connection Terminated by Local Host

Sometimes it's enough to restart the bluez-utils Ver 2.15 (hcid & sdpd),
but in other cases I need to reload these kernel modules:

Module                  Size  Used by    Not tainted
rfcomm                 25376   1
l2cap                  13008   2  (autoclean) [rfcomm]
uhci                   21468   0  (unused)
hci_usb                 7320   1
bluez                  24548   3  [rfcomm l2cap hci_usb]

/proc/bus/usb/devices:
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 27/900 us ( 3%), #Int=  1, #Iso=  2
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=fce0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a12 ProdID=0001 Rev= 8.28
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

# lspci -v
...

0000:00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 
01) (prog-if 00 [UHCI])
         Flags: bus master, medium devsel, latency 64, IRQ 11
         I/O ports at fce0 [size=32]
...

# grep BLUEZ config-2.4.27
CONFIG_BLUEZ=m
CONFIG_BLUEZ_L2CAP=m
CONFIG_BLUEZ_SCO=m
CONFIG_BLUEZ_RFCOMM=m
CONFIG_BLUEZ_RFCOMM_TTY=y
CONFIG_BLUEZ_BNEP=m
CONFIG_BLUEZ_BNEP_MC_FILTER=y
CONFIG_BLUEZ_BNEP_PROTO_FILTER=y
CONFIG_BLUEZ_CMTP=m
CONFIG_BLUEZ_HIDP=m
CONFIG_BLUEZ_HCIUSB=m
CONFIG_BLUEZ_HCIUSB_SCO=y
CONFIG_BLUEZ_HCIUART=m
CONFIG_BLUEZ_HCIUART_H4=y
CONFIG_BLUEZ_HCIUART_BCSP=y
# CONFIG_BLUEZ_HCIUART_BCSP_TXCRC is not set
CONFIG_BLUEZ_HCIBFUSB=m
CONFIG_BLUEZ_HCIDTL1=m
CONFIG_BLUEZ_HCIBT3C=m
CONFIG_BLUEZ_HCIBLUECARD=m
CONFIG_BLUEZ_HCIBTUART=m
CONFIG_BLUEZ_HCIVHCI=m

Syslog reports the following errors:

hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection DF:CD:29:60:10:00
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 64 rq 0 len 0 ret -32

best regards
-- 
Raphael


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
