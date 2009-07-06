Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] include test/hciemu.1 into man_MANS and EXTRA_DIST
Date: Mon,  6 Jul 2009 18:05:05 +0200
Message-Id: <1246896305-26018-3-git-send-email-filippo@esaurito.net>
In-Reply-To: <1246890054-13479-2-git-send-email-filippo@esaurito.net>
References: <1246890054-13479-2-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/Makefile.am |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/Makefile.am b/test/Makefile.am
index 7bd68c0..2e58d24 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -37,7 +37,7 @@ btiotest_LDADD = $(top_builddir)/common/libhelper.a @GLIB_LIBS@ @BLUEZ_LIBS@
 noinst_MANS = bdaddr.8
 
 if MANPAGES
-man_MANS = rctest.1
+man_MANS = rctest.1 hciemu.1
 endif
 
 AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@
@@ -45,7 +45,7 @@ endif
 
 INCLUDES = -I$(top_srcdir)/common
 
-EXTRA_DIST = apitest hsplay hsmicro bdaddr.8 rctest.1 dbusdef.py \
+EXTRA_DIST = apitest hsplay hsmicro bdaddr.8 rctest.1 hciemu.1 dbusdef.py \
 		monitor-bluetooth list-devices test-discovery test-manager \
 		test-adapter test-device test-service test-serial \
 		test-telephony test-network simple-agent simple-service \
-- 
1.6.3.3

