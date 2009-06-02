Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Jun 2009 09:21:07 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Cc: dan-greene@wi.rr.com, 531532-forwarded@bugs.debian.org,
	531532@bugs.debian.org
Subject: [dan-greene@wi.rr.com: /usr/sbin/bluetoothd: Main.conf has its own
	manpage? Where?]
Message-ID: <20090602072107.GH13067@esaurito.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Agreed, I'm forwarding this bug upstream.

----- Forwarded message from Dan Greene <dan-greene@wi.rr.com> -----

Date: Mon, 01 Jun 2009 23:23:07 -0500
From: Dan Greene <dan-greene@wi.rr.com>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: [Pkg-bluetooth-maintainers] Bug#531532: /usr/sbin/bluetoothd:
	Main.conf has its own manpage? Where?
X-Spam-Status: No, score=-1.0 required=5.0 tests=RCVD_IN_DNSWL_LOW
	autolearn=disabled version=3.2.5
Message-ID: <20090602042307.31817.45367.reportbug@debian>
X-Mailer: reportbug 4.4
Reply-To: Dan Greene <dan-greene@wi.rr.com>, 531532@bugs.debian.org
Sender: pkg-bluetooth-maintainers-bounces+filippo=esaurito.net@lists.alioth.debian.org

Package: bluez
Version: 4.40-2
Severity: normal
File: /usr/sbin/bluetoothd

>>From the manpage bluetoothd(8):
bluetoothd itself does not accept many command-line options, as most of
its configuration is done in the
/etc/bluetooth/main.conf file, which has its own man page.

Unfortunately, the name of the main.conf manpage is not mentioned, so I
can't look it up.

-- System Information:
Debian Release: squeeze/sid
  APT prefers unstable
  APT policy: (990, 'unstable'), (500, 'stable'), (200, 'experimental')
Architecture: i386 (i686)

Kernel: Linux 2.6.26custom
Locale: LANG=en_US, LC_CTYPE=en_US (charmap=ISO-8859-1)
Shell: /bin/sh linked to /bin/bash

Versions of packages bluez depends on:
ii  dbus                         1.2.14-2    simple interprocess messaging syst
ii  libbluetooth3                4.40-2      Library to use the BlueZ Linux Blu
ii  libc6                        2.9-13      GNU C Library: Shared libraries
ii  libdbus-1-3                  1.2.14-2    simple interprocess messaging syst
ii  libglib2.0-0                 2.20.1-2    The GLib library of C routines
ii  libnl1                       1.1-5       library for dealing with netlink s
ii  libusb-0.1-4                 2:0.1.12-13 userspace USB programming library
ii  lsb-base                     3.2-22      Linux Standard Base 3.2 init scrip
ii  makedev                      2.3.1-88    creates device files in /dev
ii  module-init-tools            3.7-pre9-1  tools for managing Linux kernel mo
ii  udev                         0.141-1     /dev/ and hotplug management daemo

bluez recommends no packages.

Versions of packages bluez suggests:
ii  python-dbus                   0.83.0-1   simple interprocess messaging syst
ii  python-gobject                2.16.1-1   Python bindings for the GObject li

-- no debconf information



_______________________________________________
Pkg-bluetooth-maintainers mailing list
Pkg-bluetooth-maintainers@lists.alioth.debian.org
http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers

----- End forwarded message -----

filippo
--
Filippo Giunchedi - http://esaurito.net - 0x6B79D401

It's not that I'm afraid to die, I just don't want to be there
when it happens.
-- Woody Allen
