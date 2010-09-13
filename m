Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH V2 2/2] btio: Seperate btio.[ch] into btio directory
Date: Mon, 13 Sep 2010 16:04:02 +0800
Message-Id: <1284365042-7526-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1284365042-7526-1-git-send-email-zhenhua.zhang@intel.com>
References: <1284365042-7526-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Seperate btio.[ch] from src directory to btio sub-folder.
---
 Makefile.am          |   19 ++++++++++---------
 {src => btio}/btio.c |    0
 {src => btio}/btio.h |    0
 3 files changed, 10 insertions(+), 9 deletions(-)
 rename {src => btio}/btio.c (100%)
 rename {src => btio}/btio.h (100%)

diff --git a/Makefile.am b/Makefile.am
index e6940bc..175747c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -19,6 +19,8 @@ gwobex_sources = gwobex/gw-obex.h gwobex/gw-obex.c \
 			gwobex/obex-xfer.h gwobex/obex-xfer.c \
 			gwobex/utils.h gwobex/utils.c gwobex/log.h
 
+btio_sources = btio/btio.h btio/btio.c
+
 libexec_PROGRAMS =
 
 if SERVER
@@ -66,11 +68,10 @@ builtin_nodist += plugins/phonebook.c
 
 libexec_PROGRAMS += src/obexd
 
-src_obexd_SOURCES = $(gdbus_sources) $(builtin_sources) \
+src_obexd_SOURCES = $(gdbus_sources) $(builtin_sources) $(btio_sources) \
 			src/main.c src/obexd.h src/plugin.h src/plugin.c \
-			src/log.h src/log.c src/btio.h src/btio.c \
-			src/dbus.h src/manager.c src/obex.h src/obex.c \
-			src/obex-priv.h \
+			src/log.h src/log.c src/dbus.h src/manager.c \
+			src/obex.h src/obex.c src/obex-priv.h \
 			src/mimetype.h src/mimetype.c \
 			src/service.h src/service.c \
 			src/transport.h src/transport.c \
@@ -108,13 +109,12 @@ service_in_files += client/obex-client.service.in
 
 libexec_PROGRAMS += client/obex-client
 
-client_obex_client_SOURCES = $(gdbus_sources) $(gwobex_sources) client/main.c \
-				client/session.h client/session.c \
+client_obex_client_SOURCES = $(gdbus_sources) $(gwobex_sources) $(btio_sources) \
+				client/main.c client/session.h client/session.c \
 				src/log.h src/log.c \
 				client/pbap.h client/pbap.c \
 				client/sync.h client/sync.c \
-				client/transfer.h client/transfer.c \
-				src/btio.c src/btio.h
+				client/transfer.h client/transfer.c
 
 client_obex_client_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ @OPENOBEX_LIBS@ @BLUEZ_LIBS@
 endif
@@ -127,7 +127,8 @@ AM_CFLAGS = @OPENOBEX_CFLAGS@ @BLUEZ_CFLAGS@ @EBOOK_CFLAGS@ \
 			-DOBEX_PLUGIN_BUILTIN -DPLUGINDIR=\""$(plugindir)"\"
 
 INCLUDES = -I$(builddir)/src -I$(srcdir)/src -I$(srcdir)/plugins \
-				-I$(srcdir)/gdbus -I$(srcdir)/gwobex
+				-I$(srcdir)/gdbus -I$(srcdir)/gwobex \
+				-I$(srcdir)/btio
 
 CLEANFILES = $(service_DATA) $(builtin_files)
 
diff --git a/src/btio.c b/btio/btio.c
similarity index 100%
rename from src/btio.c
rename to btio/btio.c
diff --git a/src/btio.h b/btio/btio.h
similarity index 100%
rename from src/btio.h
rename to btio/btio.h
-- 
1.7.0.4

