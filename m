Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 05 May 2007 19:06:22 +0200
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
From: "Goran Ristic" <gr@emmily.com>
MIME-Version: 1.0
Message-ID: <op.tru5swmwwn7nsu@xps.emmily.com>
Subject: [Bluez-users] bcm2045 works, but...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I have a Dell XPS M1710 with that 355 HDR 2.0 module (AFAIK bcm2045).

After reading lists, googleing around for days, patching and recompiling  
(a lot of it),
at least hciconfig -a shows the correct ID of that chip:

gr@xps:~$ hciconfig -a
hci0:   Type: USB
         BD Address: 00:16:CF:FA:31:16 ACL MTU: 1017:8 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:28023 acl:1142 sco:0 events:419 errors:0
         TX bytes:2989 acl:66 sco:0 commands:154 errors:0
         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'xps-0'
         Class: 0x3e0100
         Service Classes: Networking, Rendering, Capturing, Object  
Transfer, Audio
         Device Class: Computer, Uncategorized
         HCI Ver: 2.0 (0x3) HCI Rev: 0x2128 LMP Ver: 2.0 (0x3) LMP Subver:  
0x41d8
         Manufacturer: Broadcom Corporation (15)

I used "hci_udb reset=1" for that. Unfortunately after resetting the  
module, I do have
to press the pairing-button on my mouse (Microsoft Lasermouse 8000), and  
reconnect it
by typing "hidd --connect ...". In that case, in /dev/input a new device  
(event9)
appears and the scroll-wheel works well.

Without the reset-flag, the mouse moves (no wheel-support) and the  
manufacturer-line
above shows an error.
I tried different Kernels (currently 2.6.21.1 vanilla with Ubuntu Feisty  
amd64).

I wasn't able to figure out what I must do to get it automagically. -- Is  
there a
work-around out there? Or anything I must change in my configs?

Thanks for any help and hints.
-- 
Gruss, GR

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
