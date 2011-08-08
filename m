Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Subject: [PATCH obexd] Use 'nice abort' when canceling outgoing OPP transer
Date: Mon,  8 Aug 2011 14:01:38 +0200
Message-Id: <1312804898-4117-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously client was suddenly disconnecting to cancel
outgoing OPP transfer. Now ABORT command will be sent
before disconnecting with server in that scenario.

This change is required to pass TC_CLIENT_OPH_BV_27_I PTS
test case (not mandatory for qualification).
---
 Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index d412f02..009bab3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -142,7 +142,7 @@ service_DATA = $(service_in_files:.service.in=.service)
 AM_CFLAGS = @OPENOBEX_CFLAGS@ @BLUEZ_CFLAGS@ @EBOOK_CFLAGS@ \
 			@GTHREAD_CFLAGS@ @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
 			@LIBICAL_CFLAGS@ -D_FILE_OFFSET_BITS=64 \
-			@TRACKER_CFLAGS@ \
+			@TRACKER_CFLAGS@ -DUSE_NICE_ABORT \
 			-DOBEX_PLUGIN_BUILTIN -DPLUGINDIR=\""$(plugindir)"\"
 
 INCLUDES = -I$(builddir)/src -I$(srcdir)/src -I$(srcdir)/plugins \
-- 
1.7.0.4

