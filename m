Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Florian Weimer <fweimer@redhat.com>
Subject: [PATCH 1/3] build: Enable BIND_NOW
Date: Thu, 24 Aug 2017 20:28:22 +0200
Message-Id: <20170824182824.8465-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Florian Weimer <fweimer@redhat.com>

Partial RELRO means that the object is GNU_RELRO but not BIND_NOW.  This
reduces the effectiveness of RELRO.  bluez triggers this because it
enables PIE during the build, and rpmdiff takes this as an indicator
that the best possible hardening is desired.

https://bugzilla.redhat.com/show_bug.cgi?id=983161
---
 acinclude.m4 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/acinclude.m4 b/acinclude.m4
index bc39c6d73..efce2f3cb 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -50,7 +50,7 @@ AC_DEFUN([MISC_FLAGS], [
 		if (test "${enableval}" = "yes" &&
 				test "${ac_cv_prog_cc_pie}" = "yes"); then
 			misc_cflags="$misc_cflags -fPIC"
-			misc_ldflags="$misc_ldflags -pie"
+			misc_ldflags="$misc_ldflags -pie -Wl,-z,now"
 		fi
 	])
 	if (test "$enable_coverage" = "yes"); then
-- 
2.13.5

