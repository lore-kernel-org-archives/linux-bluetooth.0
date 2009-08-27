Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2009 11:58:56 +0800
Message-ID: <8e7043060908262058x5fb20f24wf995a82a575abe1d@mail.gmail.com>
Subject: build system defect
From: Ted Feng <artisdom@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi:
I met a problem while making.

Since I like to put all stuff generating from build elsewhere,
I do all the configure, make action in a different directory.

$ ls
bluez-4.50/  bluez-build/
$ cd bluez-build
$ ../bluez-4.50/configure --prefix=/usr --sysconfdir=/etc
--localstatedir=/var --enable-debug -enable-test --enable-gstreamer
--enable-alsa --enable-usb --enable-netlink --enable-tools
--enable-bccmd --enable-pcmcia --enable-hid2hci --enable-dfutool
--enable-hidd --enable-pand --enable-dund --enable-cups
--enable-udevrules --enable-configfiles
...
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
 ...
  CCLD   test/hciemu
  GEN    scripts/97-bluetooth.rules
  GEN    scripts/97-bluetooth-hid2hci.rules
cp: cannot stat `scripts/bluetooth-hid2hci.rules': No such file or directory
make[1]: *** [scripts/97-bluetooth-hid2hci.rules] Error 1
make: *** [all] Error 2

The error seems just a small path problem.
Should I claim this a bug, or I have to live with it?

Thanks in advance.

Regards
Ted
