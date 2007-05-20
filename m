Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46505989.3090103@doerges.net>
Date: Sun, 20 May 2007 16:22:01 +0200
From: =?UTF-8?B?VGlsbCBEw7ZyZ2Vz?= <lists@doerges.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------080407000604020107060905"
Subject: [Bluez-devel] hcid.conf: device section with specific bt address is
	ignored
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080407000604020107060905
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everybody,

in hcid.conf a device section with a bluetooth address specified apparently is
ignored. The following should work according to the man-page:

># *not* working
>device 00:09:DD:10:42:C4 {
>        name "%h (dongle 1)";
>[...]

The default device section is working as expected.


Things were working fine with bluez-libs-2.24 and bluez-utils-2.24 (from
openSUSE 10.1).

After the upgrade to openSUSE 10.2 with bluez-libs-3.7 and
bluez-utils-3.7 the problem occurred. (I did adapt to the new config
file format.)

I briefly tried the latest versions (bluez-libs-3.10
bluez-utils-3.10.1) but I ran into a dbus problem (hcid complains with
"Unable to get on D-Bus") and I didn't want to dig any further.

Following is a recording from starting hcid and attached is the
configuration file in question.
(Note that in the recording the names given to the devices are wrong.)

If you need more information, just let me know.

Thanks -- Till

----------------------------------------------------------------------

# cat /etc/SuSE-release
openSUSE 10.2 (i586)
VERSION = 10.2

# rpm -qa | grep 'blue\|dbus' | sort
bluez-hcidump-1.33-8
bluez-libs-3.7-14.1
bluez-utils-3.7-29.2
dbus-1-1.0.0-7
dbus-1-devel-1.0.0-7
dbus-1-glib-0.71-26
dbus-1-glib-devel-0.71-26
dbus-1-qt3-0.62-38
dbus-1-qt3-devel-0.62-38
dbus-1-x11-1.0.0-7
kdebluetooth-0.99.0svn576598-38
libqt4-dbus-1-4.2.1-18
yast2-bluetooth-2.14.0-33

# lsmod | grep 'l2cap\|rfcomm\|bnep\|blue'
bluetooth              57188  1 hci_usb

# /etc/init.d/bluetooth start
Starting bluetooth:  hcid sdpd hidd                                   done

# tail -20 /var/log/messages
May 20 15:47:50 myhost hcid[9828]: Bluetooth HCI daemon
May 20 15:47:50 myhost kernel: Bluetooth: L2CAP ver 2.8
May 20 15:47:50 myhost kernel: Bluetooth: L2CAP socket layer initialized
May 20 15:47:50 myhost sdpd[9831]: Bluetooth SDP daemon
May 20 15:47:50 myhost kernel: Bluetooth: HIDP (Human Interface Emulation) ver 1.1
May 20 15:47:50 myhost hcid[9828]: Register path:/org/bluez fallback:1
May 20 15:47:50 myhost hcid[9828]: HCI dev 0 registered
May 20 15:47:50 myhost hcid[9828]: Register path:/org/bluez/hci0 fallback:0
May 20 15:47:50 myhost hcid[9828]: HCI dev 0 already up
May 20 15:47:50 myhost hcid[9828]: Device hci0 has been added
May 20 15:47:50 myhost hidd[9842]: Bluetooth HID daemon
May 20 15:47:50 myhost hcid[9828]: Starting security manager 0
May 20 15:47:50 myhost hcid[9828]: Device hci0 has been activated
May 20 15:47:50 myhost hcid[9828]: HCI dev 1 registered
May 20 15:47:50 myhost hcid[9828]: Register path:/org/bluez/hci1 fallback:0
May 20 15:47:50 myhost hcid[9828]: HCI dev 1 already up
May 20 15:47:50 myhost hcid[9828]: Device hci1 has been added
May 20 15:47:50 myhost hcid[9828]: Starting security manager 1
May 20 15:47:50 myhost hcid[9828]: Device hci1 has been activated

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:09:DD:10:42:C4 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:4238 acl:0 sco:0 events:89 errors:0
        TX bytes:1571 acl:0 sco:0 commands:85 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'bzdefault myhost (0)'
        Class: 0x100100
        Service Classes: Object Transfer
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: 0x175
        Manufacturer: Cambridge Silicon Radio (10)

hci1:   Type: USB
        BD Address: 00:80:98:34:D0:CA ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:1591 acl:0 sco:0 events:40 errors:0
        TX bytes:903 acl:0 sco:0 commands:40 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'bzdefault myhost (1)'
        Class: 0x100100
        Service Classes: Object Transfer
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x136 LMP Ver: 1.1 (0x1) LMP Subver: 0x136
        Manufacturer: Cambridge Silicon Radio (10)

# lsmod | grep 'l2cap\|rfcomm\|bnep\|blue'
l2cap                  31104  7 hidp
bluetooth              57188  9 hidp,l2cap,hci_usb

--------------080407000604020107060905
Content-Type: text/plain;
 name="hcid.conf"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="hcid.conf"

IyBIQ0kgZGFlbW9uIGNvbmZpZ3VyYXRpb24gZmlsZS4KIwojIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IwojIFRpbGwgRMO2cmdlcyAtLSBPY3QgMTUsIDIwMDUgLS0gZGlmZmVyZW50IG5hbWVzIGZv
ciBleHQuIGFuZCBpbnQuIGJ0IGRvbmdsZQojIFRpbGwgRMO2cmdlcyAtLSBNYXkgMTgsIDIw
MDcgLS0gYWRhcHRlZCB0byBvcGVuU1VTRSAxMC4yCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCgoj
IGN1cnJlbnRseSB0aGVyZSBzZWVtcyB0byBiZSBhIGJ1Zzogb25seSB0aGUgZGVmYXVsdCBk
ZXZpY2Ugc2VjdGlvbiBpcyByZXNwZWN0ZWQKCm9wdGlvbnMgewoJYXV0b2luaXQgeWVzOwoJ
c2VjdXJpdHkgdXNlcjsKCXBhaXJpbmcgbXVsdGk7Cn0KCgojICBidCBhZGRyZXNzICAwMDo4
MDo5ODozNDpEMDpDQQojICB1c2IgaWQgICAgICBJRCAwNGJmOjAzMTAgVERLIENvcnAuCmRl
dmljZSAwMDo4MDo5ODozNDpEMDpDQSB7CgluYW1lICIlaCAoaW50ZXJuYWwpIjsKCWNsYXNz
IDB4MTAwMTAwOwoJaXNjYW4gZW5hYmxlOwoJcHNjYW4gZW5hYmxlOwoJbG0gYWNjZXB0OwoJ
bHAgcnN3aXRjaCxob2xkLHNuaWZmLHBhcms7Cn0KCgojICBidCBhZGRyZXNzCTAwOjA5OkRE
OjEwOjQyOkM0CiMgIHVzYiBpZAlJRCAwYTEyOjAwMDEgQ2FtYnJpZGdlIFNpbGljb24gUmFk
aW8sIEx0ZCBCbHVldG9vdGggRG9uZ2xlIChIQ0kgbW9kZSkKZGV2aWNlIDAwOjA5OkREOjEw
OjQyOkM0IHsKCW5hbWUgIiVoIChleHRlcm5hbCkiOwoJY2xhc3MgMHgxMDAxMDA7Cglpc2Nh
biBlbmFibGU7Cglwc2NhbiBlbmFibGU7CglsbSBhY2NlcHQ7CglscCByc3dpdGNoLGhvbGQs
c25pZmYscGFyazsKfQoKCiMgZGVmYXVsdHMgZm9yIGFueSBvdGhlciBkZXZpY2UKZGV2aWNl
IHsKCW5hbWUgImJ6ZGVmYXVsdCAlaCAoJWQpIjsKCWNsYXNzIDB4MTAwMTAwOwoJaXNjYW4g
ZW5hYmxlOwoJcHNjYW4gZW5hYmxlOwoJbG0gYWNjZXB0OwoJbHAgcnN3aXRjaCxob2xkLHNu
aWZmLHBhcms7Cn0K
--------------080407000604020107060905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------080407000604020107060905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------080407000604020107060905--
