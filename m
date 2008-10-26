Return-Path: <cyrus@holtmann.org>
Date: Sun, 26 Oct 2008 01:12:13 -0400 (EDT)
From: "George F. Nemeyer" <tigerwolf@tigerden.com>
To: linux-bluetooth@vger.kernel.org
Subject: 4.16 Bluez compile failure
Message-ID: <Pine.LNX.4.53.0810260102170.14544@tiger.tigerden.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Compile of 4.16 package fails with:

gcc -I../include -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
-I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -I../gdbus
-DPLUGINDIR=\"/usr/lib/bluetooth/plugins\" -O2 -march=i586 -mtune=i686
-D_FORTIFY_SOURCE=2 -fPIC -Wl,--export-dynamic -pie -o .libs/bluetoothd
main.o security.o sdpd-server.o sdpd-request.o sdpd-service.o
sdpd-database.o plugin.o storage.o agent.o error.o manager.o adapter.o
device.o dbus-common.o dbus-hci.o  ../common/libhelper.a
../gdbus/.libs/libgdbus.a /usr/lib/libglib-2.0.so /usr/lib/libdbus-1.so
../lib/.libs/libbluetooth.so -ldl
device.o(.text+0xbb5): In function `disconnect':
: undefined reference to `g_timeout_add_seconds'
collect2: ld returned 1 exit status
make[2]: *** [bluetoothd] Error 1
make[2]: Leaving directory `/root/Desktop/bluez-4.16/src'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/root/Desktop/bluez-4.16'
make: *** [all] Error 2

Machine info:
Linux blackwolf.tigerden.net 2.6.20_IBM-600 #2 PREEMPT Thu May 8 01:08:22
EDT 2008 i686 pentium2 i386 GNU/Linux

DISTRO:  Vector Linux 5.8 Standard (based on slackware)

Machine sees an adapter:

Oct 25 23:41:33 blackwolf kernel: usb 1-1: new full speed USB device
using uhci_hcd and address 2
Oct 25 23:41:33 blackwolf kernel: usb 1-1: configuration #1 chosen from 1
choice
Oct 25 23:41:34 blackwolf kernel: Bluetooth: Core ver 2.11
Oct 25 23:41:34 blackwolf kernel: NET: Registered protocol family 31
Oct 25 23:41:34 blackwolf kernel: Bluetooth: HCI device and connection
manager initialized
Oct 25 23:41:34 blackwolf kernel: Bluetooth: HCI socket layer initialized
Oct 25 23:41:34 blackwolf kernel: Bluetooth: HCI USB driver ver 2.9
Oct 25 23:41:34 blackwolf kernel: usbcore: registered new interface driver
hci_usb


GCC:
Reading specs from /usr/lib/gcc/i486-slackware-linux/3.4.6/specs
Configured with: ../gcc-3.4.6/configure --prefix=/usr --enable-shared
--enable-threads=posix --enable-__cxa_atexit --disable-checking
--with-gnu-ld --verbose --target=i486-slackware-linux
--host=i486-slackware-linux
Thread model: posix
gcc version 3.4.6

Any help and cure would be appreciated.

=^_^=  Tigerwolf
