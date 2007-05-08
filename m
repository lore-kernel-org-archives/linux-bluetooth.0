Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1178608551.8628.52.camel@aeonflux.holtmann.net>
References: <463F7386.6050900@am.sony.com>
	<1178608551.8628.52.camel@aeonflux.holtmann.net>
Date: Tue, 08 May 2007 12:06:31 +0100
Message-Id: <1178622391.2824.34.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: maxk@qualcomm.com, bluez-devel@lists.sf.net,
        Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [Bluez-devel] [RFC] PS3 Bluetooth quirk for HCI_FLT_CLEAR_ALL
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Tue, 2007-05-08 at 09:15 +0200, Marcel Holtmann wrote:
> the quirk is wrong. Please give me some information about the actual
> used Bluetooth hardware. I need /proc/bus/usb/devices and once it is
> working the output of hciconfig -a.

T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=054c ProdID=0267 Rev= 1.00
S:  Manufacturer=Sony
S:  Product=Bluetooth Transceiver
C:* #Ifs= 4 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  11 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  11 Ivl=1ms
I:* If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  19 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  19 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  27 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  27 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  35 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  35 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  51 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  51 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=04(O) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=125us
I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=04(O) Atr=03(Int.) MxPS= 128 Ivl=125us
E:  Ad=85(I) Atr=03(Int.) MxPS= 128 Ivl=125us
I:  If#= 2 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=04(O) Atr=03(Int.) MxPS= 256 Ivl=125us
E:  Ad=85(I) Atr=03(Int.) MxPS= 256 Ivl=125us
I:  If#= 2 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=04(O) Atr=03(Int.) MxPS=1024 Ivl=125us
E:  Ad=85(I) Atr=03(Int.) MxPS=1024 Ivl=125us
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)


hci0:   Type: USB
        BD Address: 00:13:A9:79:09:C3 ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN 
        RX bytes:408 acl:0 sco:0 events:17 errors:0
        TX bytes:317 acl:0 sco:0 commands:17 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'ps3.infradead.org-0'
        Class: 0x120104
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 2.0 (0x3) HCI Rev: 0xe18 LMP Ver: 2.0 (0x3) LMP Subver: 0xe18
        Manufacturer: Cambridge Silicon Radio (10)


-- 
dwmw2


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
