Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ] build-sys: Remove leftover AM_YFLAGS
Date: Tue,  9 Oct 2012 14:51:17 -0300
Message-Id: <1349805077-30412-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index dbbd794..35b1520 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -405,8 +405,6 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/oob-api.txt doc/proximity-api.txt doc/heartrate-api.txt \
 		doc/thermometer-api.txt
 
-AM_YFLAGS = -d
-
 AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
 
 AM_CPPFLAGS = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
-- 
1.7.12.2

