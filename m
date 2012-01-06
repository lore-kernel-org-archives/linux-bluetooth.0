Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <keybuk@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Scott James Remnant <keybuk@chromium.org>
Subject: [PATCH] build: increase check requirement to 0.9.6
Date: Thu,  5 Jan 2012 17:07:11 -0800
Message-Id: <1325812031-28953-1-git-send-email-keybuk@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ck_assert, used by unit/test-eir.c wasn't added to check until 0.9.6
---
 acinclude.m4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 753b994..0aa1526 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -171,7 +171,7 @@ AC_DEFUN([AC_PATH_READLINE], [
 ])
 
 AC_DEFUN([AC_PATH_CHECK], [
-	PKG_CHECK_MODULES(CHECK, check >= 0.9.4, check_found=yes, check_found=no)
+	PKG_CHECK_MODULES(CHECK, check >= 0.9.6, check_found=yes, check_found=no)
 	AC_SUBST(CHECK_CFLAGS)
 	AC_SUBST(CHECK_LIBS)
 ])
-- 
1.7.3.1

