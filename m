Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44ED2E66.70409@bartol.udel.edu>
Date: Thu, 24 Aug 2006 00:43:18 -0400
From: Rich Townsend <rhdt@bartol.udel.edu>
MIME-Version: 1.0
To: Bluez Developers <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel]  Frames too long in sco_send_frame
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

(Apologies for the repost, this accidentally ended up as a sidethread)

Hi all --

I'm experiencing a problem with my Belkin Compact Flash Bluetooth adapter
(F8T020 v.2). When trying to get a headset working with the adapter (via
snd-bt-sco), I've discovered that no SCO packets are being transmitted:

hciconfig -a hci0:

hci0:   Type: UART
        BD Address: 00:02:72:81:23:27 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:63524 acl:27 sco:361 events:59 errors:0
        TX bytes:2004 acl:22 sco:0 commands:29 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x120104
        Service Classes: Networking
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.1 (0x1) HCI Rev: 0x110 LMP Ver: 1.1 (0x1) LMP Subver: 0x110
        Manufacturer: Cambridge Silicon Radio (10)

hciconfig hci0 revision:

hci0:   Type: UART
         BD Address: 00:02:72:81:23:27 ACL MTU: 192:8 SCO MTU: 64:8
         HCI 14.3
         Chip version: BlueCore02-External (ES2)
         Max key size: 56 bit
         SCO mapping:  HCI

The adapter is CSR based (not Broadcom), and the problem therefore doesn't seem
to be MTU based.

However, inserting debugging code in net/bluetooth/sco.c, I discover that the
problem lies within sco_send_frame (or its caller). When the code fragment

	/* Check outgoing MTU */
	if (len > conn->mtu)
		return -EINVAL;

is reached, conn->mtu has the expected value of 64, but len is consistently
larger. Hence, sco_send_frame exits with -EINVAL, and the frame never leaves the
adapter.

I'd appreciate assistance in working out the source of the problem. I'm new to
the bluetooth code, so it's not clear to me why sco_send_frame is being passed
frames that are larger than the MTU.

cheers,

Rich

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
