Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Move hid2hci to /lib/udev
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="ISO-8859-15"
Date: Fri, 29 Apr 2011 00:32:25 +0200
Message-ID: <1304029945.27065.1.camel@zag>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 6a825582d6a3b1e1c3ed2a7ea6c62c207d45542d Mon Sep 17 00:00:00 2001
From: Kay Sievers <kay.sievers@vrfy.org>
Date: Fri, 29 Apr 2011 00:29:15 +0200
Subject: [PATCH] Move hid2hci to /lib/udev

---
 Makefile.am    |    2 +-
 Makefile.tools |    4 +++-
 acinclude.m4   |   10 ++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 9703bf0..552c81d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -334,7 +334,7 @@ EXTRA_DIST += audio/bluetooth.conf
 include Makefile.tools
 
 if UDEVRULES
-rulesdir = @UDEV_DATADIR@
+rulesdir = @UDEV_DIR@/rules.d
 
 udev_files = scripts/bluetooth.rules
 
diff --git a/Makefile.tools b/Makefile.tools
index 1bf21b2..bec10b5 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -100,7 +100,9 @@ EXTRA_DIST += tools/bccmd.8
 endif
 
 if HID2HCI
-sbin_PROGRAMS += tools/hid2hci
+udevdir = @UDEV_DIR@
+
+udev_PROGRAMS = tools/hid2hci
 
 tools_hid2hci_LDADD = @USB_LIBS@ @UDEV_LIBS@
 
diff --git a/acinclude.m4 b/acinclude.m4
index a27cd22..d77937b 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -84,13 +84,11 @@ AC_DEFUN([AC_INIT_BLUEZ], [
 	AC_SUBST(CONFIGDIR, "${configdir}")
 	AC_SUBST(STORAGEDIR, "${storagedir}")
 
-	UDEV_DATADIR="`$PKG_CONFIG --variable=udevdir udev`"
-	if (test -z "${UDEV_DATADIR}"); then
-		UDEV_DATADIR="${sysconfdir}/udev/rules.d"
-	else
-		UDEV_DATADIR="${UDEV_DATADIR}/rules.d"
+	UDEV_DIR="`$PKG_CONFIG --variable=udevdir udev`"
+	if (test -z "${UDEV_DIR}"); then
+		UDEV_DIR="/lib/udev"
 	fi
-	AC_SUBST(UDEV_DATADIR)
+	AC_SUBST(UDEV_DIR)
 ])
 
 AC_DEFUN([AC_PATH_DBUS], [
-- 
1.7.4.2


