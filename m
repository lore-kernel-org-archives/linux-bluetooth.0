Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 28 May 2007 22:10:52 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: bluez-devel@lists.sf.net
Message-ID: <20070528201052.GA5864@esaurito.net>
MIME-Version: 1.0
Cc: 426410@bugs.debian.org, 426410-submitter@bugs.debian.org
Subject: [Bluez-devel] [bernat@luffy.cx: [Pkg-bluetooth-maintainers]
	Bug#426410: bluez-utils: Once paired,
	a device is granted all accesses]
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,
I'm forwarding this upstream so we can have an opinion.

thanks for your report,
filippo

----- Forwarded message from Vincent Bernat <bernat@luffy.cx> -----

From: Vincent Bernat <bernat@luffy.cx>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Message-ID: <20070528152146.21103.1798.reportbug@zoro.luffy.cx>
X-Mailer: reportbug 3.38
Date: Mon, 28 May 2007 17:21:46 +0200
Subject: [Pkg-bluetooth-maintainers] Bug#426410: bluez-utils: Once paired,
	a device is granted all accesses
Reply-To: Vincent Bernat <bernat@luffy.cx>, 426410@bugs.debian.org
Sender: pkg-bluetooth-maintainers-bounces+filippo=esaurito.net@lists.alioth.debian.org

Package: bluez-utils
Version: 3.7-1
Severity: wishlist
Tags: security

Hi !

I did not find any place to grant access to some services to a device
and not some others. If it is not possible to tell which service a
device can access, I think this is a major security drawback and that
bluez stack should implement a way to define services access.

For example, I pair with a device to send him a file. I don't want him
to be able to use my Internet access if dund is started. I don't want
him to be able to access files from obexserver and I don't want him to
be able to act as a keyboard for my host.

-- System Information:
Debian Release: lenny/sid
  APT prefers unstable
  APT policy: (990, 'unstable'), (1, 'experimental')
Architecture: i386 (i686)

Kernel: Linux 2.6.21.1-zoro.15
Locale: LANG=fr_FR@euro, LC_CTYPE=fr_FR@euro (charmap=ISO-8859-15)
Shell: /bin/sh linked to /bin/bash

Versions of packages bluez-utils depends on:
ii  dbus                         1.0.2-5     simple interprocess messaging syst
ii  libbluetooth2                3.9-1       Library to use the BlueZ Linux Blu
ii  libc6                        2.5-9       GNU C Library: Shared libraries
ii  libdbus-1-3                  1.0.2-5     simple interprocess messaging syst
ii  libusb-0.1-4                 2:0.1.12-7  userspace USB programming library
ii  lsb-base                     3.1-23.1    Linux Standard Base 3.1 init scrip
ii  makedev                      2.3.1-83    creates device files in /dev
ii  module-init-tools            3.3-pre11-1 tools for managing Linux kernel mo
ii  udev                         0.105-4     /dev/ and hotplug management daemo

Versions of packages bluez-utils recommends:
pn  bluez-passkey-gnome           <none>     (no description available)

-- no debconf information


_______________________________________________
Pkg-bluetooth-maintainers mailing list
Pkg-bluetooth-maintainers@lists.alioth.debian.org
http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers

----- End forwarded message -----

filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

All language designers are arrogant. Goes with the territory...
-- Larry Wall

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
