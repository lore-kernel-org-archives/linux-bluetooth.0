Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Hedin <andrewthegreat@mail.ru>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200405121820.59166.andrewthegreat@mail.ru>
Subject: [Bluez-users] Can't understand
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
Date: Wed, 12 May 2004 18:20:59 +0700

I have Redhat 9.0 with 2.6.6-mh1 patched kernel and all modules compiled.
I have Tecom BT3030 Dongle.

I compiled bluez-libs-2.7 and bluez-utils-2.7. After some effort (big effort!) 
I managed to compile bluez-pin (why is it needed - no word anywhere...).

I also installed all other modules without problems, except bluez-bluefw. It 
gives following errors:

# make

... SOME INFO...


source='bluefw.c' object='bluefw.o' libtool=no \
depfile='.deps/bluefw.Po' tmpdepfile='.deps/bluefw.TPo' \
depmode=gcc3 /bin/sh ./depcomp \
gcc -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" 
-DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\" -DPACKAGE=\"bluez-bluefw\" 
-DVERSION=\"1.0\" -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 
-DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 
-DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DBT3C_SUPPORT=1  -I. 
-I. -I/usr/src/linux/include    -Wall -g -O2 -c `test -f 'bluefw.c' || echo 
'./'`bluefw.c
In file included from usblib.h:30,
                 from bluefw.c:39:
/usr/src/linux/include/linux/usbdevice_fs.h:49: variable or field `__user' 
declared void
/usr/src/linux/include/linux/usbdevice_fs.h:49: warning: no semicolon at end 
of struct or union
/usr/src/linux/include/linux/usbdevice_fs.h:49: parse error before '*' token
/usr/src/linux/include/linux/usbdevice_fs.h:56: variable or field `__user' 
declared void
/usr/src/linux/include/linux/usbdevice_fs.h:56: warning: no semicolon at end 
of struct or union
/usr/src/linux/include/linux/usbdevice_fs.h:56: parse error before '*' token
/usr/src/linux/include/linux/usbdevice_fs.h:100: variable or field `__user' 
declared void
/usr/src/linux/include/linux/usbdevice_fs.h:100: warning: no semicolon at end 
of struct or union
/usr/src/linux/include/linux/usbdevice_fs.h:100: parse error before '*' token
/usr/src/linux/include/linux/usbdevice_fs.h:109: parse error before '}' token
/usr/src/linux/include/linux/usbdevice_fs.h:116: variable or field `__user' 
declared void
/usr/src/linux/include/linux/usbdevice_fs.h:116: warning: no semicolon at end 
of struct or union
/usr/src/linux/include/linux/usbdevice_fs.h:116: parse error before '*' token

... BAILS OUT...

/usr/src/linux is pointing to valid current kernel sources. Whats wrong with 
them? Problems with kernel?

Ok. I try to search for devices. When I do `hcitool dev` it gives no devices, 
when I do `hcitool inq` it gives:
Inquiring ...
Inquiry failed.: No such device

When I do `/usr/sbin/hciconfig hci0 up"
It gives: Can't get device info: No such device

The kernel sees the dongle (just as USB device).

At last, here is `lsmod`:
hci_usb                11264  0
l2cap                  23680  0
bluetooth              44900  2 hci_usb,l2cap

Are that all necessary modules, I guess?

What is the problem? Thx in advance. 



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
