Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v4 1/5] build: Update glib dependency to 2.32
Date: Fri, 28 Sep 2012 18:32:21 +0200
Message-Id: <1348849945-5762-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1348849945-5762-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1348849945-5762-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This version of the library adds several convenient features such as
g_queue_free_full.
---
 acinclude.m4 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index ed2d011..9f4b11f 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -99,8 +99,8 @@ AC_DEFUN([AC_PATH_DBUS], [
 ])
 
 AC_DEFUN([AC_PATH_GLIB], [
-	PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28, dummy=yes,
-				AC_MSG_ERROR(GLib >= 2.28 is required))
+	PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.32, dummy=yes,
+				AC_MSG_ERROR(GLib >= 2.32 is required))
 	AC_SUBST(GLIB_CFLAGS)
 	AC_SUBST(GLIB_LIBS)
 ])
-- 
1.7.11.4

