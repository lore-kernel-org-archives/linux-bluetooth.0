Return-Path: <cyrus@holtmann.org>
Subject: Downstream patches
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-oQgENXP1d7JnyRYe/EB9"
Date: Wed, 27 Oct 2010 19:02:06 +0100
Message-ID: <1288202527.30124.107.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-oQgENXP1d7JnyRYe/EB9
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Heya,

2 small patches for the current master.

0001-systemd-install-systemd-unit-files.patch installs a systemd unit,
which, when systemd is used, replaces the udev rule to launch
bluetoothd. This was pretty heavily tested as part of the alpha for
Fedora 14, though systemd was not included in the end.

This patch is used in Fedora 15 now.

0002-build-Fix-parallel-build.patch fixes a parallel build problem I
encountered on my machine, running "make -j8".

Cheers

--=-oQgENXP1d7JnyRYe/EB9
Content-Disposition: attachment; filename="0001-systemd-install-systemd-unit-files.patch"
Content-Type: text/x-patch; name="0001-systemd-install-systemd-unit-files.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From b3483ab0b821d29bbeb6aa5630b36bc126a89441 Mon Sep 17 00:00:00 2001
From: Lennart Poettering <lennart@poettering.net>
Date: Wed, 21 Jul 2010 19:20:44 +0200
Subject: [PATCH 3/3] systemd: install systemd unit files

This also enables bus activation for bluetoothd, but only if systemd is
running. Only if that's the case we can make sure in a race-free fashion
that bluetoothd is not started twice at the same time.
---
 Makefile.am                  |   21 ++++++++++++++++++---
 configure.ac                 |    9 +++++++++
 scripts/.gitignore           |    1 +
 scripts/bluetooth.service.in |   12 ++++++++++++
 scripts/org.bluez.service    |    5 +++++
 5 files changed, 45 insertions(+), 3 deletions(-)
 create mode 100644 scripts/.gitignore
 create mode 100644 scripts/bluetooth.service.in
 create mode 100644 scripts/org.bluez.service

diff --git a/Makefile.am b/Makefile.am
index e855713..1edd6a2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -344,7 +344,8 @@ endif
 CLEANFILES += $(rules_DATA)
 
 EXTRA_DIST += scripts/bluetooth.rules \
-		scripts/bluetooth-hid2hci.rules scripts/bluetooth-serial.rules
+		scripts/bluetooth-hid2hci.rules scripts/bluetooth-serial.rules \
+		scripts/bluetooth.service.in scripts/org.bluez.service
 
 if PCMCIA
 udevdir = $(libexecdir)/udev
@@ -352,6 +353,20 @@ udevdir = $(libexecdir)/udev
 dist_udev_SCRIPTS = scripts/bluetooth_serial
 endif
 
+if HAVE_SYSTEMD
+systemdsystemunit_DATA = \
+       scripts/bluetooth.service
+
+scripts/bluetooth.service: scripts/bluetooth.service.in
+	@$(SED) -e "s|\@sbindir\@|$(sbindir)|" $< >$@
+
+dbussystemservicesdir = $(datadir)/dbus-1/system-services
+
+dbussystemservices_DATA = \
+	scripts/org.bluez.service
+
+endif
+
 EXTRA_DIST += doc/manager-api.txt \
 		doc/adapter-api.txt doc/device-api.txt \
 		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
@@ -376,9 +391,9 @@ pkgconfigdir = $(libdir)/pkgconfig
 
 pkgconfig_DATA = bluez.pc
 
-DISTCHECK_CONFIGURE_FLAGS = --disable-udevrules --enable-attrib
+DISTCHECK_CONFIGURE_FLAGS = --disable-udevrules --enable-attrib --with-systemdsystemunitdir=
 
-DISTCLEANFILES = $(pkgconfig_DATA)
+DISTCLEANFILES = $(pkgconfig_DATA) scripts/bluetooth.service
 
 MAINTAINERCLEANFILES = Makefile.in \
 	aclocal.m4 configure config.h.in config.sub config.guess \
diff --git a/configure.ac b/configure.ac
index d375ac9..6619a42 100644
--- a/configure.ac
+++ b/configure.ac
@@ -56,5 +56,14 @@ if (test "${enable_capng}" = "yes"); then
 	AC_DEFINE(HAVE_CAPNG, 1, [Define to 1 if you have capabilities library.])
 fi
 
+# systemd
+
+AC_ARG_WITH([systemdsystemunitdir],
+	AS_HELP_STRING([--with-systemdsystemunitdir=DIR], [Directory for systemd service files]),
+	[],
+	[with_systemdsystemunitdir=$($PKG_CONFIG --variable=systemdsystemunitdir systemd)])
+AC_SUBST([systemdsystemunitdir], [$with_systemdsystemunitdir])
+AM_CONDITIONAL(HAVE_SYSTEMD, [test -n "$with_systemdsystemunitdir"])
+
 AC_OUTPUT(Makefile scripts/bluetooth.rules doc/version.xml
 					src/bluetoothd.8 bluez.pc)
diff --git a/scripts/.gitignore b/scripts/.gitignore
new file mode 100644
index 0000000..4b9f765
--- /dev/null
+++ b/scripts/.gitignore
@@ -0,0 +1 @@
+bluetooth.service
diff --git a/scripts/bluetooth.service.in b/scripts/bluetooth.service.in
new file mode 100644
index 0000000..f95b0b0
--- /dev/null
+++ b/scripts/bluetooth.service.in
@@ -0,0 +1,12 @@
+[Unit]
+Description=Bluetooth Manager
+After=syslog.target
+
+[Service]
+Type=dbus
+BusName=org.bluez
+ExecStart=@sbindir@/bluetoothd -n
+StandardOutput=syslog
+
+[Install]
+WantedBy=bluetooth.target
diff --git a/scripts/org.bluez.service b/scripts/org.bluez.service
new file mode 100644
index 0000000..2a3b057
--- /dev/null
+++ b/scripts/org.bluez.service
@@ -0,0 +1,5 @@
+[D-BUS Service]
+Name=org.bluez
+Exec=/bin/false
+User=root
+SystemdService=bluetooth.service
-- 
1.7.3.1


--=-oQgENXP1d7JnyRYe/EB9
Content-Disposition: attachment; filename="0002-build-Fix-parallel-build.patch"
Content-Type: text/x-patch; name="0002-build-Fix-parallel-build.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From ad21a880935863d3592cae708147ef54c796222d Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 27 Oct 2010 18:54:49 +0100
Subject: [PATCH 2/3] build: Fix parallel build

Fix parallel build where parser.h won't have been generated when
we're trying to compile kword itself.

 YACC   tools/parser.c
 LEX    tools/lexer.c
conflicts: 3 shift/reduce
 CC     tools/kword.o
tools/kword.c:36:20: fatal error: parser.h: No such file or directory
compilation terminated.
---
 Makefile.tools |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 405a42b..797b53d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -12,6 +12,8 @@ sbin_PROGRAMS += tools/hciattach tools/hciconfig
 noinst_PROGRAMS += tools/avinfo tools/ppporc \
 				tools/hcieventmask tools/hcisecfilter
 
+tools/kword.c: tools/parser.h
+
 tools_rfcomm_SOURCES = tools/main.c tools/parser.y tools/lexer.l \
 					tools/kword.h tools/kword.c
 EXTRA_tools_rfcomm_SOURCES = tools/parser.h tools/parser.c \
-- 
1.7.3.1


--=-oQgENXP1d7JnyRYe/EB9--

