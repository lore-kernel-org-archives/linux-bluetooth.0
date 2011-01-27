Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 1/6] Include check to readline lib on acinlude.m4
Date: Thu, 27 Jan 2011 16:08:57 -0300
Message-Id: <1296155342-31956-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 acinclude.m4 |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index ecf4b4b..f27d4eb 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -153,6 +153,13 @@ AC_DEFUN([AC_PATH_SNDFILE], [
 	AC_SUBST(SNDFILE_LIBS)
 ])
 
+AC_DEFUN([AC_PATH_READLINE], [
+	AC_CHECK_LIB(readline, main,
+		[ readline_found=yes
+		 AC_SUBST(READLINE_LIBS, "-lreadline")
+		], readline_found=no)
+])
+
 AC_DEFUN([AC_PATH_OUI], [
 	AC_ARG_WITH(ouifile,
 		    AS_HELP_STRING([--with-ouifile=PATH],[Path to the oui.txt file @<:@auto@:>@]),
-- 
1.7.1

