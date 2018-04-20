Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] build: Make bt_shell conditional to readline
Date: Fri, 20 Apr 2018 16:02:54 +0300
Message-Id: <20180420130254.20063-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_shell APIs shall only be build if readline is present on the system
since it currently depend on it.
---
 Makefile.am | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index daf34b6ca..9c3c17139 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -119,7 +119,11 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/gatt-server.h src/shared/gatt-server.c \
 			src/shared/gatt-db.h src/shared/gatt-db.c \
 			src/shared/gap.h src/shared/gap.c \
-			src/shared/tty.h src/shared/shell.c src/shared/shell.h
+			src/shared/tty.h
+
+if READLINE
+shared_sources += src/shared/shell.c src/shared/shell.h
+endif
 
 src_libshared_glib_la_SOURCES = $(shared_sources) \
 				src/shared/io-glib.c \
-- 
2.14.3

