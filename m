Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] include test/rctest.1 into man_MANS and EXTRA_DIST
Date: Mon,  6 Jul 2009 16:20:54 +0200
Message-Id: <1246890054-13479-2-git-send-email-filippo@esaurito.net>
In-Reply-To: <1246890054-13479-1-git-send-email-filippo@esaurito.net>
References: <1246890054-13479-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/Makefile.am |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/test/Makefile.am b/test/Makefile.am
index e54e88e..7bd68c0 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -36,15 +36,20 @@ btiotest_LDADD = $(top_builddir)/common/libhelper.a @GLIB_LIBS@ @BLUEZ_LIBS@
 
 noinst_MANS = bdaddr.8
 
+if MANPAGES
+man_MANS = rctest.1
+endif
+
 AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@
 endif
 
 INCLUDES = -I$(top_srcdir)/common
 
-EXTRA_DIST = apitest hsplay hsmicro bdaddr.8 dbusdef.py monitor-bluetooth \
-		list-devices test-discovery test-manager test-adapter \
-		test-device test-service test-serial test-telephony \
-		test-network simple-agent simple-service service-record.dtd \
-		service-did.xml service-spp.xml service-opp.xml service-ftp.xml
+EXTRA_DIST = apitest hsplay hsmicro bdaddr.8 rctest.1 dbusdef.py \
+		monitor-bluetooth list-devices test-discovery test-manager \
+		test-adapter test-device test-service test-serial \
+		test-telephony test-network simple-agent simple-service \
+		service-record.dtd service-did.xml service-spp.xml \
+		service-opp.xml service-ftp.xml
 
 MAINTAINERCLEANFILES = Makefile.in
-- 
1.6.3.3

