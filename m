Return-Path: <cyrus@holtmann.org>
From: ankushbansal89@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Ankush Bansal <ankushbansal89@gmail.com>
Subject: [PATCH] Changing required GLIB version in acinclude.m4
Date: Thu,  3 Feb 2011 01:34:05 +0530
Message-Id: <1296677045-12603-1-git-send-email-ankushbansal89@gmail.com>
In-Reply-To: <ankushbansal89@gmail.com>
References: <ankushbansal89@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ankush Bansal <ankushbansal89@gmail.com>

---
 acinclude.m4 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index ecf4b4b..9d3f6b2 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -108,8 +108,8 @@ AC_DEFUN([AC_PATH_DBUS], [
 ])
 
 AC_DEFUN([AC_PATH_GLIB], [
-	PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.14, dummy=yes,
-				AC_MSG_ERROR(GLib library version 2.14 or later is required))
+	PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.16, dummy=yes,
+				AC_MSG_ERROR(GLib library version 2.16 or later is required))
 	AC_SUBST(GLIB_CFLAGS)
 	AC_SUBST(GLIB_LIBS)
 ])
-- 
1.7.1

