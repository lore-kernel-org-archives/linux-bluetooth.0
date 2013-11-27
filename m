Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC] build: Force GLib version check while building in maintainer mode
Date: Wed, 27 Nov 2013 16:44:56 +0100
Message-Id: <1385567096-27261-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to catch up build errors introduced by using GLib API
introduced in newer GLib than minimal required even if building with
newer version.
---
 acinclude.m4 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/acinclude.m4 b/acinclude.m4
index 5bfa29d..2065852 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -21,6 +21,8 @@ AC_DEFUN([COMPILER_FLAGS], [
 		with_cflags="$with_cflags -Wredundant-decls"
 		with_cflags="$with_cflags -Wcast-align"
 		with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
+		with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_28"
+		with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_28"
 	fi
 	AC_SUBST([WARNING_CFLAGS], $with_cflags)
 ])
-- 
1.8.3.2

