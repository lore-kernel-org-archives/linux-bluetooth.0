Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd] Fix quoting in readline checks
Date: Mon, 18 Jul 2011 13:24:23 +0200
Message-Id: <1310988263-4944-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Readline check was underquoted causing not very helpful error message
when readline is missing.
---
 acinclude.m4 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 2a824eb..fdd8a9e 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -12,10 +12,10 @@ AC_DEFUN([AC_PROG_CC_PIE], [
 
 AC_DEFUN([AC_PATH_READLINE], [
 	AC_CHECK_HEADER(readline/readline.h,
-		AC_CHECK_LIB(readline, main,
+		[AC_CHECK_LIB(readline, main,
 			[ readline_found=yes
 			AC_SUBST(READLINE_LIBS, "-lreadline")
-			], readline_found=no),
+			], readline_found=no)],
 		[])
 ])
 
-- 
1.7.4.1

