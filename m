Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <5CD2BD8F1F23A943BAEBE96AB20C24980549DD3E@VS1.hdi.tvcabo>
From: "filipe_abrantes" <filipe_abrantes@netcabo.pt>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Failed to connect to SDP server on 00:10:60:A4:89:15: Function not implemented
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
Date: Thu, 26 Feb 2004 17:29:26 -0000

greetings all:

[root@ee99217 bluez-sdp-1.5]# sdptool search GN
Inquiring ...
Failed to connect to SDP server on 00:10:60:A4:89:15: Function not =
implemented

if i try this i get :

[root@ee99217 bluez-sdp-1.5]# pand --connect 00:10:60:A4:89:15 --nosdp

Feb 26 17:16:34 ee99217 pand[8447]: PAN daemon ver 1.1
Feb 26 17:16:34 ee99217 pand[8447]: Connecting to 00:10:60:A4:89:15
Feb 26 17:16:37 ee99217 pand[8447]: Connect to 00:10:60:A4:89:15 failed. =
Function not implemented(38)


on the other end, everything is running normally:

[root@ee99217 bluez-sdp-1.5]# ps -x
...
 4113 ?        S      0:00 hcid: processing events
 8388 ?        S      0:00 /usr/sbin/sdpd
 8391 ?        S      0:00 pand --listen --role GN
 8451 pts/1    R      0:00 ps -x

[root@ee99217 bluez-sdp-1.5]# lsmod
Module                  Size  Used by
bnep                   16384  2
l2cap                  25220  6 bnep
ide_cd                 40836  0
cdrom                  37920  1 ide_cd
lp                     11076  0
autofs                 16896  0
prism54                49176  0
firmware_class          9344  1 prism54
ds                     16004  4
yenta_socket           17024  1
pcmcia_core            69344  2 ds,yenta_socket
floppy                 57940  0
sg                     33176  0
scsi_mod               77228  1 sg
parport_pc             36268  1
parport                42856  2 lp,parport_pc
microcode               6816  0
ohci1394               35460  0
ieee1394               79664  1 ohci1394
hci_usb                10880  1
bluetooth              49636  5 bnep,l2cap,hci_usb


im using kernel 2.6.2, fedora.


any ideas on this?



thanks a lot for your time


filipe



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
