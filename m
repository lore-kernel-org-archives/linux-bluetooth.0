Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] build: Require GLib 2.32 or later when building with gstreamer support
Date: Tue, 24 Jul 2012 14:04:42 +0200
Message-ID: <1343131482-17629-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1343131482-17629-1-git-send-email-szymon.janc@tieto.com>
References: <1343131482-17629-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

gstreamer code now uses g_mutex_init() and related functions only
available in GLib >= 2.32.
---
 acinclude.m4 |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/acinclude.m4 b/acinclude.m4
index 39b0a18..5e39aa7 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -108,6 +108,8 @@ AC_DEFUN([AC_PATH_GLIB], [
 AC_DEFUN([AC_PATH_GSTREAMER], [
 	PKG_CHECK_MODULES(GSTREAMER, gstreamer-0.10 >= 0.10.30 gstreamer-plugins-base-0.10, gstreamer_found=yes,
 				AC_MSG_WARN(GStreamer library version 0.10.30 or later is required);gstreamer_found=no)
+	PKG_CHECK_MODULES(GLIB_FOR_GS, glib-2.0 >= 2.32, dummy=yes,
+				AC_MSG_ERROR(GLib >= 2.32 is required for gstreamer support))
 	AC_SUBST(GSTREAMER_CFLAGS)
 	AC_SUBST(GSTREAMER_LIBS)
 	GSTREAMER_PLUGINSDIR=`$PKG_CONFIG --variable=pluginsdir gstreamer-0.10`
-- 
1.7.9.5

