Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 4 Jul 2007 16:11:23 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070704141123.GA10807@suse.de>
MIME-Version: 1.0
Subject: [Bluez-devel] Mouse reconnect problems since version 3.12
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I recently upgraded to bluez-3.12 on my openSUSE Factory machine and now i
have problems with the mouse reconnecting after a timeout.

It simply does not reconnect. Nothing in syslog nor in the output of
kbluetooth which is my authorization agent.

I do not know exactly how to proceed with debugging - i tried a
hcidump -X -V
when the mouse did not reconnect, and it spat out lots of stuff when i
moved the mouse. But of course, i could not make any sense out of it.

So:
- what do i need to do to debug this?
- what output of which tool do you need?

This is a Logitech MX Laser mouse which worked very reliable before with
a Microsoft Bluetooth dongle:

hci0:   Type: USB
        BD Address: 00:50:F2:EA:6B:EF ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:2544 acl:82 sco:0 events:43 errors:0
        TX bytes:786 acl:8 sco:0 commands:30 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'strolchi MS dongle'
        Class: 0x3e010c
        Service Classes: Networking, Rendering, Capturing, Object Transfer,=
 Audio
        Device Class: Computer, Laptop
        HCI Ver: 1.2 (0x2) HCI Rev: 0x3 LMP Ver: 1.2 (0x2) LMP Subver: 0x800
        Manufacturer: Broadcom Corporation (15)

-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
