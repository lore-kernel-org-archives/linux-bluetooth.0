Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org, linux-nfc-request@lists.01.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH neard 1/2] build: Use AM_CPPFLAGS instead of INCLUDES
Date: Thu, 10 Jan 2013 13:18:13 -0200
Message-Id: <1357831094-13513-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Makefile.am:50: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 2dd3517..8c3571e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -47,7 +47,7 @@ AM_CFLAGS = @GLIB_CFLAGS@ @DBUS_CFLAGS@ @NETLINK_CFLAGS@ $(builtin_cflags) \
 					-DPLUGINDIR=\""$(plugindir)"\" \
 					-DCONFIGDIR=\""$(configdir)\""
 
-INCLUDES = -I$(builddir)/include -I$(builddir)/src -I$(srcdir)/gdbus
+AM_CPPFLAGS = -I$(builddir)/include -I$(builddir)/src -I$(srcdir)/gdbus
 
 CLEANFILES = src/builtin.h $(local_headers)
 
-- 
1.8.1

