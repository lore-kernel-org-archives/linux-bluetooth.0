Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Rolf S. Dubitzky " <Dubitzky@physi.uni-heidelberg.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200511141452.23951.Dubitzky@physi.uni-heidelberg.de>
Subject: [Bluez-users] hcid crashing on pin_code_request
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
Date: Mon, 14 Nov 2005 14:52:22 +0100

Hi,

I try to pair my jabraBT200 headset with a USB-BT dongle on FedoraC4.  
(details below) I used the dongle to communicate with the phone and that 
works just fine.  The headset works fine with the phone as well.  I suspect, 
that I have a compatibility problem with the package mix on my FC4 box (see 
below), since when starting hcid -n I get the following backtrace in the very 
second I try to communicate with the headset (e.g. l2ping and headset in 
pairing mode): (I tried  security auto; and   security user; but the pin 
helper isn't even started. hcid crashes before that I asume)

Thanx for any help, Rolf

# hcid -n
hcid[28766]: Bluetooth HCI daemon
hcid[28766]: Starting security manager 0

hcid[28766]: pin_code_request (sba=00:09:DD:10:53:4E, dba=00:07:A4:03:97:24)
28766: arguments to dbus_type_is_basic() were incorrect, assertion 
"_dbus_type_is_valid (typecode) || typecode == DBUS_TYPE_INVALID" failed in 
file dbus-signature.c line 259.
This is normally a bug in some application using the D-BUS library.
type unknown isn't supported yet in dbus_message_append_args_valist
*** buffer overflow detected ***: hcid: processing events terminated
======= Backtrace: =========
/lib/libc.so.6(__chk_fail+0x41)[0xf7ec45]
hcid: processing events[0x891e8b]
/usr/lib/libdbus-1.so.1[0x5ee155]
/usr/lib/libdbus-1.so.1[0x5ce49b]
/usr/lib/libdbus-1.so.1(dbus_connection_dispatch+0x20a)[0x5d2f37]
hcid: processing events[0x8919c0]
hcid: processing events[0x8918b0]
hcid: processing events(main+0x4c5)[0x88dfef]
/lib/libc.so.6(__libc_start_main+0xdf)[0xeb5d5f]
hcid: processing events[0x88d071]
======= Memory map: ========
005c2000-0062b000 r-xp 00000000 03:01 4896232    /usr/lib/libdbus-1.so.1.0.0
0062b000-00630000 rwxp 00069000 03:01 4896232    /usr/lib/libdbus-1.so.1.0.0
0077d000-0077e000 r-xp 0077d000 00:00 0          [vdso]
0088b000-00895000 r-xp 00000000 03:01 4256755    /usr/sbin/hcid
00895000-00896000 rwxp 00009000 03:01 4256755    /usr/sbin/hcid
008e5000-008f1000 r-xp 00000000 03:01 
4265003    /usr/lib/libbluetooth.so.1.0.15
008f1000-008f2000 rwxp 0000c000 03:01 
4265003    /usr/lib/libbluetooth.so.1.0.15
009f3000-00a05000 r-xp 00000000 03:01 3755952    /lib/libnsl-2.3.5.so
00a05000-00a06000 r-xp 00011000 03:01 3755952    /lib/libnsl-2.3.5.so
00a06000-00a07000 rwxp 00012000 03:01 3755952    /lib/libnsl-2.3.5.so
00a07000-00a09000 rwxp 00a07000 00:00 0
00aa7000-00ac1000 r-xp 00000000 03:01 3753769    /lib/ld-2.3.5.so
00ac1000-00ac2000 r-xp 00019000 03:01 3753769    /lib/ld-2.3.5.so
00ac2000-00ac3000 rwxp 0001a000 03:01 3753769    /lib/ld-2.3.5.so
00df6000-00dff000 r-xp 00000000 03:01 
3755943    /lib/libgcc_s-4.0.1-20050727.so.1
00dff000-00e00000 rwxp 00009000 03:01 
3755943    /lib/libgcc_s-4.0.1-20050727.so.1
00ea1000-00fc4000 r-xp 00000000 03:01 3753771    /lib/libc-2.3.5.so
00fc4000-00fc6000 r-xp 00123000 03:01 3753771    /lib/libc-2.3.5.so
00fc6000-00fc8000 rwxp 00125000 03:01 3753771    /lib/libc-2.3.5.so
00fc8000-00fca000 rwxp 00fc8000 00:00 0
08650000-08671000 rw-p 08650000 00:00 0          [heap]
b7f91000-b7f93000 rw-p b7f91000 00:00 0
b7fb0000-b7fb1000 rw-p b7fb0000 00:00 0
bf99b000-bf9b1000 rw-p bf99b000 00:00 0          [stack]
Aborted


-----

FC4 packages installed:

dbus-glib-0.33-3.fc4.1
dbus-0.33-3.fc4.1
dbus-python-0.33-3.fc4.1
dbus-x11-0.33-3.fc4.1
bluez-hcidump-1.18-1
bluez-utils-2.15-7
bluez-libs-2.15-1
bluez-libs-devel-2.15-1
bluez-pin-0.24-2

----

# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:09:DD:10:53:4E ACL MTU: 192:8 SCO MTU: 64:8
        HCI 17.11
        Chip version: BlueCore02
        Max key size: 128 bit
        SCO mapping:  HCI


# hcitool scan
Scanning ...
        00:07:A4:03:97:24       JABRA BT200

# hcidump -X -V  (I can provide more, but I doubt it is informative)
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:07:A4:03:97:24
==> crash






-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
