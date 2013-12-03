Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 3 Dec 2013 14:38:17 -0800
Message-ID: <CAEsx0Y9WEbK=dDdonn016SLA9vGRMc99qPasntEtRZq-+QkVpQ@mail.gmail.com>
Subject: cross compiling bluez 4.101
From: Daniel Schultze <kinglag@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Developers,

I'm having a bit of trouble cross compiling bluez 4.101 with an older
kernel 2.6.31. I'm using:

me@buildmachine:~/tmp/bluez-4.101$ arm-none-linux-gnueabi-gcc --version
arm-none-linux-gnueabi-gcc (GCC) 4.1.2
Copyright (C) 2006 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

I'll admit its a bit old but, its what I have to work with. In
addition I have built glibc 2.10.1, glib 2.28.8, and dbus 1.4.26
successfully to fulfill bluez's prerequisites.

This is error I'm getting:

  CCLD   src/bluetoothd
attrib/bluetoothd-gatt.o: In function `read_long_destroy':
gatt.c:(.text+0xfec): undefined reference to `__sync_fetch_and_sub_4'
attrib/bluetoothd-gatt.o: In function `read_blob_helper':
gatt.c:(.text+0x121c): undefined reference to `__sync_fetch_and_add_4'
attrib/bluetoothd-gatt.o: In function `read_char_helper':
gatt.c:(.text+0x13e8): undefined reference to `__sync_fetch_and_add_4'
attrib/bluetoothd-gatt.o: In function `gatt_read_char':
gatt.c:(.text+0x15d8): undefined reference to `__sync_fetch_and_add_4'
attrib/bluetoothd-gattrib.o: In function `g_attrib_ref':
gattrib.c:(.text+0x1fc): undefined reference to `__sync_fetch_and_add_4'
attrib/bluetoothd-gattrib.o: In function `g_attrib_unref':
gattrib.c:(.text+0x528): undefined reference to `__sync_fetch_and_sub_4'
collect2: ld returned 1 exit status
make[1]: *** [src/bluetoothd] Error 1
make: *** [all] Error 2

and I have configured using this line (for building outside of ltib):

./configure CFLAGS="--sysroot=/home/me/ltib_me/rootfs -march=armv5te"
--prefix=/usr --build=$MACHTYPE --host=arm-none-linux-gnueabi
--disable-alsa --disable-audio --enable-gatt --disable-pcmcia
--disable-gstreamer

and the build machine is:

me@buildmachine:~/tmp/bluez-4.101$ echo $MACHTYPE
i686-pc-linux-gnu
me@buildmachine:~/tmp/bluez-4.101$ uname -a
Linux buildmachine 3.0.0-12-generic-pae #20-Ubuntu SMP Fri Oct 7
16:37:17 UTC 2011 i686 i686 i386 GNU/Linux
me@buildmachine:~/tmp/bluez-4.101$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description: Ubuntu 11.10
Release: 11.10
Codename: oneiric

Any help on resolving this error would be appreciated.
