Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] build: Remove gstreamer pkg config warning
Date: Wed, 01 Aug 2012 14:00:04 +0900
Message-id: <1343797204-1202-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

GSTREAMER is not mandatory option when bluez build.
---
 acinclude.m4 |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 6505ad3..6e3eb83 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -106,8 +106,9 @@ AC_DEFUN([AC_PATH_GLIB], [
 ])
 
 AC_DEFUN([AC_PATH_GSTREAMER], [
-	PKG_CHECK_MODULES(GSTREAMER, gstreamer-0.10 >= 0.10.30 gstreamer-plugins-base-0.10, gstreamer_found=yes,
-				AC_MSG_WARN(GStreamer library version 0.10.30 or later is required);gstreamer_found=no)
+	PKG_CHECK_MODULES(GSTREAMER,
+                        gstreamer-0.10 >= 0.10.30 gstreamer-plugins-base-0.10,
+                        gstreamer_found=yes, gstreamer_found=no)
 	AC_SUBST(GSTREAMER_CFLAGS)
 	AC_SUBST(GSTREAMER_LIBS)
 	GSTREAMER_PLUGINSDIR=`$PKG_CONFIG --variable=pluginsdir gstreamer-0.10`
-- 
1.7.9.5

