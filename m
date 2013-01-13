Return-Path: <cyrus@holtmann.org>
From: Lubomir Rintel <lkundrak@v3.sk>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] build: Substitute systemd unit directories if overriden by user
Date: Sun, 13 Jan 2013 11:51:40 +0100
Message-Id: <1358074300-6407-1-git-send-email-lkundrak@v3.sk>
List-ID: <linux-bluetooth.vger.kernel.org>

Otherwise --with-systemdsystemunitdir and --with-systemduserunitdir would be
effectively ignored.
---
 configure.ac |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 09e9d4a..514aa5a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -202,8 +202,8 @@ if (test "${enable_systemd}" != "no" && test -z "${path_systemunitdir}"); then
 		AC_MSG_ERROR([systemd system unit directory is required])
 	fi
 	AC_MSG_RESULT([${path_systemunitdir}])
-	AC_SUBST(SYSTEMD_SYSTEMUNITDIR, [${path_systemunitdir}])
 fi
+AC_SUBST(SYSTEMD_SYSTEMUNITDIR, [${path_systemunitdir}])
 
 AC_ARG_WITH([systemduserunitdir],
 			AC_HELP_STRING([--with-systemduserunitdir=DIR],
@@ -216,8 +216,8 @@ if (test "${enable_systemd}" != "no" && test -z "${path_userunitdir}"); then
 		AC_MSG_ERROR([systemd user unit directory is required])
 	fi
 	AC_MSG_RESULT([${path_userunitdir}])
-	AC_SUBST(SYSTEMD_USERUNITDIR, [${path_userunitdir}])
 fi
+AC_SUBST(SYSTEMD_USERUNITDIR, [${path_userunitdir}])
 
 AC_ARG_ENABLE(datafiles, AC_HELP_STRING([--disable-datafiles],
 			[do not install configuration and data files]),
-- 
1.7.1
