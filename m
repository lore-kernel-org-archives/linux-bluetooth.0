Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Alan Martinovic <alan.martinovic@senic.com>
Date: Fri, 16 Mar 2018 15:50:17 +0100
Message-ID: <CAOT_U5abzWLY7sHqLShNE5fhK0oq5GSJ3MExhjuWa2s=F=VVdQ@mail.gmail.com>
Subject: Disabling obex for a BLE build
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I'm trying to cross compile a BLE BlueZ master.
Am having build issues pointing to obex.
I'm building it using Yocto but have stripped it down
to the essentials:

./configure
  --build=x86_64-linux
  --host=arm-linux-gnueabi
  --target=arm-linux-gnueabi
  --prefix=/usr
  --exec_prefix=/usr
  --bindir=/usr/bin
  --sbindir=/usr/sbin
  --libexecdir=/usr/libexec
  --datadir=/usr/share
  --sysconfdir=/etc
  --sharedstatedir=/com
  --localstatedir=/var
  --libdir=/usr/lib
  --includedir=/usr/include
  --oldincludedir=/usr/include
  --infodir=/usr/share/info
  --mandir=/usr/share/man
  --disable-silent-rules
  --disable-dependency-tracking
  --with-libtool-sysroot=/home/alan/senic-os/build/tmp-glibc/work/cortexa7hf-neon-vfpv4-senic-linux-gnueabi/bluez5/5.49+gitAUTOINC+969dfae9a7-r0/recipe-sysroot
  --enable-test
  --enable-datafiles
  --enable-library
  --enable-a2dp
  --enable-avrcp
  --disable-cups
  --enable-deprecated
  --disable-health
  --enable-hid
  --enable-hog
  --disable-midi
  --enable-network
  --disable-nfc
  --disable-obex
  --enable-client
  --disable-sap
  --disable-sixaxis
  --enable-systemd
  --disable-testing
  --disable-threads
  --enable-tools
make -j 16

This results in a build error:

 ../git/obexd/src/genbuiltin filesystem bluetooth  opp ftp  mas mns >
obexd/src/builtin.h
 /bin/bash: obexd/src/builtin.h: No such file or directory
 Makefile:9431: recipe for target 'obexd/src/builtin.h' failed


Given that I don't need it for BLE, what else is required
besides "--disable-obex" to bypass this error?

Be Well,
Alan
