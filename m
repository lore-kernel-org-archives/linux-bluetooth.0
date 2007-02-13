Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <45d1e66413baa@wp.pl>
References: <45d1e66413baa@wp.pl>
Date: Tue, 13 Feb 2007 17:29:06 +0100
Message-Id: <1171384146.23580.31.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] connection problem between samsung mobile
	phone	nad bluez 3.8in slackware 11
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Miroslaw,

> I have problem with connection between my usb bluetooth and 
> samsung sgh -x680. I have installed slackware 11 with bluez 3.8 (lib and utils). for essy diagnostic I sending for you output same commands 
> and comments 
>  
> lsusb :
> 
> Bus 2 Device 2: ID 1131:1001 Integrated System Solution Corp. KY-BT100 Bluetooth Adapter
> 
> hciconfig -a 
> 
> hci0:   Type: USB
>         BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 48:10
>         UP RUNNING PSCAN
>         RX bytes:7001 acl:10 sco:0 events:265 errors:0
>         TX bytes:1665 acl:10 sco:0 commands:110 errors:0
>         Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: MASTER
>         Name: 'BlueZ (0)'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering, Capturing, Object Transfer, Audio
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver: 0x1fe
>         Manufacturer: Integrated System Solution Corp. (57)
> hcitool scan
> Scanning ...
> 
>         00:17:D5:47:4E:88       Mir
> 
> hcid and spdp demon I have started by rc.bluetooth script from /etc/rc.d
> 
> my mobile phone hasn't seen my usb bluetooth 
> When I have tried connect to my phone I haven't got any error  but this link hasn't work . 
> command l2ping to phone work very well.
> 
> hcitool con
> Connections:
> 
> 
> 
> I see my phon by kbluetooth but
> when I try connect by kbluetoothd -> "OBEX file transfer" (hcidump work in beckground) my phone askin my about pin. I write pin from my hcid.conf section passkey "1111"; and security auto but connection broken becous I see on my phone "pin invaide"
> 
> output hcidump -X -V
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 1 packets 1
> > HCI Event: PIN Code Request (0x16) plen 6
>     bdaddr 00:17:D5:47:4E:88
> < HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
>     bdaddr 00:17:D5:47:4E:88
> > HCI Event: Command Complete (0x0e) plen 10
>     PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
>     status 0x00 bdaddr 00:17:D5:47:4E:88
> > HCI Event: Auth Complete (0x06) plen 3
>     status 0x06 handle 1
>     Error: PIN or Key Missing
> 
> 
> Could you tell me where is problem ?

you might wanna check the syslog. My guess is that you don't have a
passkey agent running.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
