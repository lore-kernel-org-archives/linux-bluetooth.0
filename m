Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: stefan.seyfried@googlemail.com
To: linux-bluetooth@vger.kernel.org
Cc: Stefan Seyfried <seife+dev@b1-systems.com>
Subject: [PATCH] obexd: use AM_LDFLAGS for linking
Date: Tue, 12 Dec 2017 19:27:17 +0100
Message-Id: <20171212182717.3429-1-stefan.seyfried@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Stefan Seyfried <seife+dev@b1-systems.com>

without this, --enable-pie does not work for obexd
---
 Makefile.obexd | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index 2e33cbc72..86c395305 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -83,7 +83,7 @@ obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
 			@ICAL_LIBS@ @DBUS_LIBS@ @GLIB_LIBS@ -ldl
 
-obexd_src_obexd_LDFLAGS = -Wl,--export-dynamic
+obexd_src_obexd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic
 
 obexd_src_obexd_CFLAGS = $(AM_CFLAGS) @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
 				@ICAL_CFLAGS@ -DOBEX_PLUGIN_BUILTIN \
-- 
2.15.1

