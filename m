Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1789.192.168.1.253.1080351984.squirrel@legio.mine.nu>
From: "Peter Andersson" <peter@legio.mine.nu>
To: bluez-users@lists.sourceforge.net
Reply-To: peter@legio.mine.nu
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-users] PANU and "ACL tx timeout"
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
Date: Sat, 27 Mar 2004 02:46:24 +0100 (CET)

Hi!
I am trying to set up a pan network between two usb dongles (belkin FT001
and bluetake BT007SV). The belkin dongle is run as the network access
point (NAP) and the bluetake dongle is run as a client. Connecting the tw=
o
devices works just fine. Just browsing around an ftp works fine, the
trouble is when i try to send/recive 'larger amounts' of data, eg files
larger than 10k the connection hangs. (I have listed the output from
/var/log/messages below.) Filetransfer with obex push works flawless. As =
a
test i transfered a four megabyte file (with object push) back and fourth
between the computers without trouble. Just to clearify, the problems
occur on the computer running as NAP using the belkin FT001 dongle.

I initialize the dongle in the following manner:

modprobe bluez
modprobe hci_usb
modprobe l2cap
modprobe bnep
then i connect the usb dongle (belkin FT001)
hciconfig hci0 up
hcid -f /etc/bluetooth/hcid.conf
sdpd
pand --listen --role NAP

I am using a box running redhat 9.0, kernel 2.4.25 with the latest bluez
patches (mh3). I am also running the latest stable libraries and tools
( bluez-libs-2.5.tar.gz, bluez-utils-2.5.tar.gz, bluez-sdp-1.5.tar.gz,
bluez-pan-1.1.tar.gz, bluez-hcidump-1.8.tar.gz, bluez-hciemu-1.0.tar.gz
and bluez-bluefw-1.0.tar.gz).

any help would be most appreciated!

regards

/peter

Output from /var/log/messages:

Mar 26 23:24:52 legio kernel: hub.c: new USB device 00:0c.0-2, assigned
address 2
Mar 26 23:24:52 legio kernel: usb.c: USB device 2 (vend/prod 0xa5c/0x2033=
)
is not claimed by any active driver.
Mar 26 23:24:56 legio bluefw[2252]: Loading firmware to usb device 0a5c:2=
033
Mar 26 23:24:56 legio bluefw[2280]: Loading firmware to usb device 0a5c:2=
033
Mar 26 23:24:56 legio bluefw[2280]: Can't claim interface 0. Device or
resource busy (16)
Mar 26 23:24:56 legio bluefw[2252]: FW loaded
Mar 26 23:24:57 legio kernel: usb.c: USB disconnect on device 00:0c.0-2
address 2
Mar 26 23:24:58 legio kernel: hub.c: new USB device 00:0c.0-2, assigned
address 3
Mar 26 23:26:05 legio hcid[2444]: HCI daemon ver 2.5 started
Mar 26 23:26:05 legio hcid[2444]: Starting security manager 0
Mar 26 23:26:10 legio sdpd[2448]: sdpd v1.5 started
Mar 26 23:26:17 legio kernel: BlueZ BNEP ver 1.1
Mar 26 23:26:17 legio kernel: Copyright (C) 2001,2002 Inventel Systemes
Mar 26 23:26:17 legio kernel: Written 2001,2002 by Clement Moreau
<clement.moreau@inventel.fr>
Mar 26 23:26:17 legio kernel: Written 2001,2002 by David Libault
<david.libault@inventel.fr>
Mar 26 23:26:17 legio kernel: Copyright (C) 2002 Maxim Krasnyanskiy
<maxk@qualcomm.com>
Mar 26 23:26:17 legio pand[2452]: PAN daemon ver 1.1
Mar 26 23:26:38 legio hcid[2444]: link_key_request (sba=3D00:03:C9:2E:48:=
E9,
dba=3D00:08:F4:00:6F:AB)
Mar 26 23:26:38 legio hcid[2444]: pin_code_request (sba=3D00:03:C9:2E:48:=
E9,
dba=3D00:08:F4:00:6F:AB)
Mar 26 23:26:46 legio hcid[2444]: link_key_notify (sba=3D00:03:C9:2E:48:E=
9)
Mar 26 23:26:46 legio hcid[2444]: Replacing link key 00:03:C9:2E:48:E9
00:08:F4:00:6F:AB
Mar 26 23:26:57 legio hcid[2444]: link_key_request (sba=3D00:03:C9:2E:48:=
E9,
dba=3D00:08:F4:00:6F:AB)
Mar 26 23:26:58 legio pand[2454]: New connection from 00:08:F4:00:6F:AB b=
nep0
Mar 26 23:28:09 legio kernel: hci_acl_tx_to: hci0 ACL tx timeout
Mar 26 23:28:09 legio kernel: hci_acl_tx_to: hci0 killing stalled ACL
connection AB:6F:00:F4:08:00


(sometimes the "hci_acl_tx_to: hci0 ACL tx timeout" message keeps
repeating until i remove the usb dongle.)



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
