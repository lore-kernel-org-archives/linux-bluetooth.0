Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH v2 2/5] Include check to readline lib on acinlude.m4
Date: Fri, 11 Feb 2011 11:17:20 -0300
Message-Id: <1297433843-9192-2-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1297433843-9192-1-git-send-email-sheldon.demario@openbossa.org>
References: <1297433843-9192-1-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <20110209212642.GA11368@jh-x301>
References: <20110209212642.GA11368@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 acinclude.m4 |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 9d3f6b2..91e0956 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -153,6 +153,15 @@ AC_DEFUN([AC_PATH_SNDFILE], [
 	AC_SUBST(SNDFILE_LIBS)
 ])
 
+AC_DEFUN([AC_PATH_READLINE], [
+	AC_CHECK_HEADER(readline/readline.h,
+		AC_CHECK_LIB(readline, main,
+			[ readline_found=yes
+			AC_SUBST(READLINE_LIBS, "-lreadline")
+			], readline_found=no),
+		[])
+])
+
 AC_DEFUN([AC_PATH_OUI], [
 	AC_ARG_WITH(ouifile,
 		    AS_HELP_STRING([--with-ouifile=PATH],[Path to the oui.txt file @<:@auto@:>@]),
@@ -356,6 +365,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(HEALTHPLUGIN, test "${health_enable}" = "yes")
 	AM_CONDITIONAL(MCAP, test "${health_enable}" = "yes")
 	AM_CONDITIONAL(HAL, test "${hal_enable}" = "yes")
+	AM_CONDITIONAL(READLINE, test "${readline_found}" = "yes")
 	AM_CONDITIONAL(ATTRIBPLUGIN, test "${attrib_enable}" = "yes")
 	AM_CONDITIONAL(ECHOPLUGIN, test "no" = "yes")
 	AM_CONDITIONAL(PNATPLUGIN, test "${pnat_enable}" = "yes")
-- 
1.7.1

