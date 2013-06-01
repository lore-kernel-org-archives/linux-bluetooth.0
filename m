Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH] configure.ac: Fix typos sytemd -> systemd
Date: Sat,  1 Jun 2013 14:49:19 +0200
Message-Id: <1370090959-5450-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 configure.ac |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index f3c58be..2aa06d3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -196,7 +196,7 @@ AC_ARG_WITH([systemdsystemunitdir],
 			[path to systemd system unit directory]),
 					[path_systemunitdir=${withval}])
 if (test "${enable_systemd}" != "no" && test -z "${path_systemunitdir}"); then
-	AC_MSG_CHECKING([sytemd system unit dir])
+	AC_MSG_CHECKING([systemd system unit dir])
 	path_systemunitdir="`$PKG_CONFIG --variable=systemdsystemunitdir systemd`"
 	if (test -z "${path_systemunitdir}"); then
 		AC_MSG_ERROR([systemd system unit directory is required])
@@ -210,7 +210,7 @@ AC_ARG_WITH([systemduserunitdir],
 			[path to systemd user unit directory]),
 					[path_userunitdir=${withval}])
 if (test "${enable_systemd}" != "no" && test -z "${path_userunitdir}"); then
-	AC_MSG_CHECKING([sytemd user unit dir])
+	AC_MSG_CHECKING([systemd user unit dir])
 	path_userunitdir="`$PKG_CONFIG --variable=systemduserunitdir systemd`"
 	if (test -z "${path_userunitdir}"); then
 		AC_MSG_ERROR([systemd user unit directory is required])
-- 
1.7.10.4

