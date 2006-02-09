Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43EBCB5D.7070300@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] csr + edr + class 1 *finally* in US
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
Date: Thu, 09 Feb 2006 16:08:13 -0700

Hey

We've had to wait long enough I suppose. Now these can be purchased
finally. It's in the Bluetake bt007ex:

http://www.btboutique.com/product_info.php?products_id=176

It also comes with windows & mac drivers so I'm going to try to use it
to get avrcp fully figured out... (is there a way in macos to spy on usb?)

jag:/home/bmidgley# hciconfig hci1 revision
hci1:   Type: USB
        BD Address: 50:00:20:F4:00:6F ACL MTU: 384:8 SCO MTU: 64:8
        HCI 19.2
        Chip version: BlueCore4-ROM
        Max key size: 128 bit
        SCO mapping:  HCI
jag:/home/bmidgley# hciconfig -a hci1
hci1:   Type: USB
        BD Address: 50:00:20:F4:00:6F ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:632 acl:0 sco:0 events:30 errors:0
        TX bytes:545 acl:0 sco:0 commands:29 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'jag.flamebot.com-1'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0 (0x3) LMP Subver:
0x7a6
        Manufacturer: Cambridge Silicon Radio (10)

whew!

Brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
