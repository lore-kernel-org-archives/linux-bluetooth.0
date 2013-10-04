Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 14/14] build-sys: Add missing $(AM_CFLAGS) to obexd_src_obexd_CFLAGS
Date: Fri, 4 Oct 2013 11:05:38 +0200
Message-ID: <1380877538-22614-14-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
References: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix not passing extra build flags when --enable-maintainer-mode
is used.
---
 Makefile.obexd | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index d5377cb..2d4f10d 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -85,7 +85,7 @@ obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
 
 obexd_src_obexd_LDFLAGS = -Wl,--export-dynamic
 
-obexd_src_obexd_CFLAGS = @GLIB_CFLAGS@ @DBUS_CFLAGS@ @ICAL_CFLAGS@ \
+obexd_src_obexd_CFLAGS = $(AM_CFLAGS) @GLIB_CFLAGS@ @DBUS_CFLAGS@ @ICAL_CFLAGS@ \
 					-DOBEX_PLUGIN_BUILTIN \
 					-DPLUGINDIR=\""$(obex_plugindir)"\" \
 					-fPIC -D_FILE_OFFSET_BITS=64
-- 
1.8.4

