Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 13/13] build: Enable -Wswitch-enum in maintainer mode
Date: Tue,  2 Dec 2014 18:28:38 +0100
Message-Id: <1417541318-24259-13-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
References: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes GCC verify if all enum values are listed in switch.
---
 acinclude.m4 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/acinclude.m4 b/acinclude.m4
index 2065852..4c241bf 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -20,6 +20,7 @@ AC_DEFUN([COMPILER_FLAGS], [
 		with_cflags="$with_cflags -Wmissing-declarations"
 		with_cflags="$with_cflags -Wredundant-decls"
 		with_cflags="$with_cflags -Wcast-align"
+		with_cflags="$with_cflags -Wswitch-enum"
 		with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
 		with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_28"
 		with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_28"
-- 
1.9.1

