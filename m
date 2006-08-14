Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44E04497.3050807@ipb.pt>
Date: Mon, 14 Aug 2006 10:38:31 +0100
From: Rui Pedro Lopes <rlopes@ipb.pt>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Trying to connect to a headset... permission denied...
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all!

I've been trying to use a bluetooth headset with my laptop and I keep
getting the following error:
- ---->

Here is what I am doing:

# modprobe snd-bt-sco
# dmesg
snd-bt-sco revision 1.12 $
snd-bt-sco: snd-bt-scod thread starting

# hciconfig hci0 voice 0x0060
tash:/home/rlopes# hciconfig -a
hci0:   Type: USB
        BD Address: 00:03:7A:0A:D9:D9 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:230384 acl:15911 sco:0 events:750 errors:0
        TX bytes:1074 acl:18 sco:0 commands:46 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM3 DM5 DH1 DH3 DH5 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'tash-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object
Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP
Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)


(put the headset in pairing mode)

# hcitool scan
Scanning ...
        00:0D:44:43:B7:01       BT-Headphones

# sdptool search --bdaddr 00:0D:44:43:B7:01 0x1108
Class 0x1108
Failed to connect to SDP server on 00:0D:44:43:B7:01: Permission denied

(the output of hcidump for this last command is:)
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Mode Change (0x14) plen 6
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: PIN Code Request (0x16) plen 6
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11


(Finally:)
# btsco 00:0D:44:43:B7:01 1
Can't connect RFCOMM channel: Permission denied

(the output of hcidump for this last command is:)
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: PIN Code Request (0x16) plen 6
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11


Am I doing something wrong? Am I missing something?

Thanks for your attention!

/rp
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE4ESWAhGrHSs5PNIRAsoPAKCpVoFTAJxg7ysu8A6gLV1biXQUOACgtguE
tP79LqCLiKPNkYdvbvkdA8M=
=ULji
-----END PGP SIGNATURE-----


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
