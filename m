Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-users] Desperate newbie
Message-ID: <EFCD68F7BFDB06468769D4D9EAAA9387025D93E7@scsmsx401.sc.intel.com>
From: "Pering, Trevor" <trevor.pering@intel.com>
To: "Gary Martin" <gary_martin_au@yahoo.com.au>,
   <bluez-users@lists.sourceforge.net>
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
Date: Sat, 27 Mar 2004 05:47:06 -0800

Given the output you have, it's not a hciattach or hciusb problem. Those
pieces are the connection from linux to the Bluetooth hardware on your
computer -- which seems to be working ok because you can do basic
operations (like hcitool scan). There is something really strange going
on because basic connectivity with the other device seems to work (as
indicated by hcitool scan, which fetches the name from the remote
device), but hcitool info and l2ping don't seem to be working properly,
which is strange. =20

Unfortunately, I don't know more than that to be able to help you. But,
I think it indicates the problem might be on the remote (phone) side,
not the laptop. Ideally, you could find a different BT device to try it
with.

	Trevor


-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Gary
Martin
Sent: Saturday, March 27, 2004 3:25 AM
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Desperate newbie

Hi all

I'm a Linux user trying to sync my mobile phone with
my computer in desperate need of help. I'm running
Debian testing/unstable on a Apple PowerBook G3. I
have researched as much as I can, but I can't get
bluetooth to work with Linux.

My phone (Sonyericsson T628) can pair with the
PowerBook, but it says that the only service available
is "object push" and I can send files to the
PowerBook.

Multisync cannot find the phone.

Everything works perfectly in Mac OS X without any
configuration

I'm beginning to suspect it is a hci_usb -- hciattach
problem. But I don't understand hciattach.

Below are some diagnostics/output. Hopefully someone
can help


Debian:~# modinfo bfusb
filename:  =20
/lib/modules/2.4.25-powerpc/kernel/drivers/bluetooth/bfusb.o
description: "BlueFRITZ! USB driver ver 1.1"
author:      "Marcel Holtmann <marcel@holtmann.org>"
license:     "GPL"

debian:~# lsmod
Module                  Size  Used by    Not tainted
rfcomm                 35640   1  (autoclean)
l2cap                  18900   2  (autoclean) [rfcomm]
af_packet              15112   1  (autoclean)
hid                    23108   0  (unused)
sco                    10308   0  (unused)
hfs                    81196   0  (unused)
dmasound_pmac          65424   1
dmasound_core          12848   1  [dmasound_pmac]
soundcore               4200   3  [dmasound_core]
i2c-core               14532   0  [dmasound_pmac]
hci_usb                 9152   1
bluez                  36332   3  [rfcomm l2cap sco
hci_usb]

debian:~# hcitool scan
Scanning ...
        00:0E:07:54:32:0B       T628

debian:~# hcitool info 00:0E:07:54:32:0B
Requesting information ...
Can't create connection: Input/output error

debian:~# hcitool inq
Inquiring ...
        00:0E:07:54:32:0B       clock offset: 0x747b =20
 class: 0x520204

debian:~# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0D:88:AC:D1:EE ACL MTU: 192:8=20
SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:388 acl:0 sco:0 events:18 errors:0
        TX bytes:333 acl:0 sco:0 commands:15 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00
0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'debian-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1
(0x1) LMP Subver: 0x1bb
        Manufacturer: Cambridge Silicon Radio (10)

debian:~# l2ping 00:0E:07:54:32:0B
Ping: 00:0E:07:54:32:0B from 00:0D:88:AC:D1:EE (data
size 20) ...
0 bytes from 00:0E:07:54:32:0B id 200 time 56.94ms
0 bytes from 00:0E:07:54:32:0B id 201 time 32.72ms
0 bytes from 00:0E:07:54:32:0B id 202 time 44.73ms
0 bytes from 00:0E:07:54:32:0B id 203 time 38.74ms
0 bytes from 00:0E:07:54:32:0B id 204 time 38.74ms
0 bytes from 00:0E:07:54:32:0B id 205 time 48.77ms
0 bytes from 00:0E:07:54:32:0B id 206 time 41.79ms
0 bytes from 00:0E:07:54:32:0B id 207 time 42.79ms
0 bytes from 00:0E:07:54:32:0B id 208 time 39.81ms
0 bytes from 00:0E:07:54:32:0B id 209 time 44.83ms
0 bytes from 00:0E:07:54:32:0B id 210 time 42.83ms
0 bytes from 00:0E:07:54:32:0B id 211 time 41.84ms
0 bytes from 00:0E:07:54:32:0B id 212 time 39.85ms
13 sent, 13 received, 0% loss

debian:~# lsusb
Bus 002 Device 001: ID 0000:0000
Bus 002 Device 002: ID 0a12:0001 Cambridge Silicon
Radio, Ltd Bluetooth Dongle
Bus 001 Device 001: ID 0000:0000


Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
