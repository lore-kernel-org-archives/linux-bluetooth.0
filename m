Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <10e392ce0601061234j12dcc8dfw@mail.gmail.com>
From: Cyberalex <cyberalexgm@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <10e392ce0601061203k45c59478j@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <10e392ce0601061203k45c59478j@mail.gmail.com>
Subject: [Bluez-users] Problem with hcitool scan
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
Date: Fri, 6 Jan 2006 20:34:03 +0000

I have a latitude x1 with integrated dongle connected by usb bus.
I installed bluez-libs and bluez-utils and added modules (bluetooth
l2cap rfcomm bnep hidp hci_usb)
I start services and hciconfig -a return:
tuxone ~ # hciconfig -a
hci0:   Type: USB
        BD Address: 00:10:C6:D1:07:A1 ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:697 acl:0 sco:0 events:55 errors:0
        TX bytes:640 acl:0 sco:0 commands:32 errors:0
        Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x679 LMP Ver: 1.2 (0x2) LMP Subver: 0x=
679
        Manufacturer: Cambridge Silicon Radio (10)
tuxone ~ #

The dongle led flash,it seems working.
I have 2 nokia 3650 and an other pc with bluetooth and they work.
If i enter hcitool scan from latitude :

tuxone ~ # hcitool scan
Scanning ...
tuxone ~ #

It doesn't recognize all bt hosts.

If i do a scanning from an other host i can't recognize the notebook
(but the led of its dongle flash with a different timed during the
scanning).

Can anyone help me?

Alex


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
