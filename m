Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8e7043060908271916w76adc10fh8fdc088802d3a1f9@mail.gmail.com>
References: <8e7043060908262058x5fb20f24wf995a82a575abe1d@mail.gmail.com>
	 <1251401131.2950.118.camel@localhost.localdomain>
	 <8e7043060908271916w76adc10fh8fdc088802d3a1f9@mail.gmail.com>
Date: Fri, 28 Aug 2009 10:31:26 +0800
Message-ID: <8e7043060908271931n6fe29a62o840df9b8f3badf74@mail.gmail.com>
Subject: Re: build system defect
From: Ted Feng <artisdom@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sorry for the delay.

>2009/8/27 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> is it a clean checkout?

I use the tarball release bluez-4.50.tar.gz, If that counts.

> Perhaps build is broken when compiling outside the source tree,

Pretty much, I think.


>2009/8/28 Marcel Holtmann <marcel@holtmann.org>:
> I have not seen this problem, but I there might be still problems here.

Just build outside the source tree. The error will show up.

> Can you give us details on your distro etc. I would have to fix this.

$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 9.04
Release:        9.04
Codename:       jaunty

$ uname -r
2.6.28-14-generic

To reproduce the error, here is the step:

$ wget http://www.kernel.org/pub/linux/bluetooth/bluez-4.50.tar.gz
$ tar xvf bluez-4.50.tar.gz
$ mkdir bluez-build
$ cd bluez-build
$ ../bluez-4.50/configure --prefix=/usr --sysconfdir=/etc
--localstatedir=/var --enable-debug -enable-test --enable-gstreamer
--enable-alsa --enable-usb --enable-netlink --enable-tools
--enable-bccmd --enable-pcmcia --enable-hid2hci --enable-dfutool
--enable-hidd --enable-pand --enable-dund --enable-cups
--enable-udevrules --enable-configfiles
...
checking for SNDFILE... yes
configure: creating ./config.status
config.status: creating Makefile
config.status: creating scripts/bluetooth.rules
config.status: creating doc/version.xml
config.status: creating src/bluetoothd.8
config.status: creating bluez.pc
config.status: creating config.h
config.status: executing depfiles commands
config.status: executing libtool commands
$ make
make --no-print-directory all-am
 CC     audio/audio_libasound_module_pcm_bluetooth_la-pcm_bluetooth.lo
 CC     audio/audio_libasound_module_pcm_bluetooth_la-ipc.lo
 CC     sbc/sbc_libsbc_la-sbc.lo
 CC     sbc/sbc_libsbc_la-sbc_primitives.lo
 CC     sbc/sbc_libsbc_la-sbc_primitives_mmx.lo
 CC     sbc/sbc_libsbc_la-sbc_primitives_neon.lo
...
 CCLD   tools/bccmd
 CC     tools/hid2hci.o
 CCLD   tools/hid2hci
 CC     test/hciemu.o
 CCLD   test/hciemu
 GEN    scripts/97-bluetooth.rules
 GEN    scripts/97-bluetooth-hid2hci.rules
cp: cannot stat `scripts/bluetooth-hid2hci.rules': No such file or directory
make[1]: *** [scripts/97-bluetooth-hid2hci.rules] Error 1
