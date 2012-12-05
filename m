Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] build: Include bluetooth lib folder for obexd
Date: Wed, 05 Dec 2012 11:27:57 +0900
Message-id: <1354674477-25835-2-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1354674477-25835-1-git-send-email-chanyeol.park@samsung.com>
References: <1354674477-25835-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

Because obexd is included in bluez repo, obexd should refer to local
lib folder before system's one.
---
 Makefile.obexd |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index 1ed423b..cbcd65d 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -29,7 +29,7 @@ obexd_src_obexd_CFLAGS = @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
 					-DPLUGINDIR=\""$(obex_plugindir)"\" \
 					-fPIC -D_FILE_OFFSET_BITS=64
 
-obexd_src_obexd_CPPFLAGS = -I$(builddir)/obexd/src \
+obexd_src_obexd_CPPFLAGS = -I$(builddir)/lib -I$(builddir)/obexd/src  \
 				-I$(srcdir)/obexd/src -I$(srcdir)/btio \
 				-I$(srcdir)/gobex -I$(srcdir)/gdbus
 
@@ -76,7 +76,8 @@ obexd_client_obex_client_LDADD = lib/libbluetooth-private.la \
 obexd_client_obex_client_CFLAGS = @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
 						-fPIC -D_FILE_OFFSET_BITS=64
 
-obexd_client_obex_client_CPPFLAGS = -I$(srcdir)/obexd/src -I$(srcdir)/btio \
-					-I$(srcdir)/gobex -I$(srcdir)/gdbus
+obexd_client_obex_client_CPPFLAGS = -I$(builddir)/lib -I$(srcdir)/obexd/src \
+				-I$(srcdir)/btio -I$(srcdir)/gobex \
+				-I$(srcdir)/gdbus
 
 obexd_client_obex_client_SHORTNAME = obex-client
-- 
1.7.9.5

