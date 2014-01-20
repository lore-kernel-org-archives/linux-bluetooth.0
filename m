Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] build: Bump D-Bus dependency to 1.6
Date: Mon, 20 Jan 2014 14:54:47 +0100
Message-Id: <1390226087-14202-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

dbus_validate_path() was introduced in D-Bus 1.6 and it is no longer
possible to build with 1.4.

 CCLD   tools/bluetooth-player
tools/bluetooth-player.o: In function `cmd_change_folder':
tools/bluetooth-player.c:741: undefined reference to `dbus_validate_path'
collect2: ld returned 1 exit status
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index c85f208..ddbd584 100644
--- a/configure.ac
+++ b/configure.ac
@@ -62,8 +62,8 @@ if (test "${enable_threads}" = "yes"); then
 	GLIB_LIBS="$GLIB_LIBS $GTHREAD_LIBS"
 fi
 
-PKG_CHECK_MODULES(DBUS, dbus-1 >= 1.4, dummy=yes,
-				AC_MSG_ERROR(D-Bus >= 1.4 is required))
+PKG_CHECK_MODULES(DBUS, dbus-1 >= 1.6, dummy=yes,
+				AC_MSG_ERROR(D-Bus >= 1.6 is required))
 AC_SUBST(DBUS_CFLAGS)
 AC_SUBST(DBUS_LIBS)
 
-- 
1.8.3.2

