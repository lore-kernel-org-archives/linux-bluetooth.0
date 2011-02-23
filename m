Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Add GStreamer version check in acinclude.m4
Date: Wed, 23 Feb 2011 14:13:07 +0100
Message-ID: <1298466787-2854-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since commit cc04c6a2f7500f3d29d56634e645130ff3bd80fb compilation fails with
GStreamer 0.10.28 or older.
---
 acinclude.m4 |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 91e0956..6aaa885 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -115,7 +115,8 @@ AC_DEFUN([AC_PATH_GLIB], [
 ])
 
 AC_DEFUN([AC_PATH_GSTREAMER], [
-	PKG_CHECK_MODULES(GSTREAMER, gstreamer-0.10 gstreamer-plugins-base-0.10, gstreamer_found=yes, gstreamer_found=no)
+	PKG_CHECK_MODULES(GSTREAMER, gstreamer-0.10 >= 0.10.30 gstreamer-plugins-base-0.10, gstreamer_found=yes,
+				AC_MSG_WARN(GStreamer library version 0.10.30 or later is required);gstreamer_found=no)
 	AC_SUBST(GSTREAMER_CFLAGS)
 	AC_SUBST(GSTREAMER_LIBS)
 	GSTREAMER_PLUGINSDIR=`$PKG_CONFIG --variable=pluginsdir gstreamer-0.10`
-- 
1.7.0.4
on behalf of ST-Ericsson
