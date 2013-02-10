Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCHv2 BlueZ 2/2] configure.ac: call AC_SUBST(*_CFLAGS) and AC_SUBST(*_LIBS) only when needed
Date: Sun, 10 Feb 2013 22:20:51 +0100
Message-Id: <1360531251-18371-3-git-send-email-ospite@studenti.unina.it>
In-Reply-To: <1360531251-18371-1-git-send-email-ospite@studenti.unina.it>
References: <1359906411-12624-1-git-send-email-ospite@studenti.unina.it>
 <1360531251-18371-1-git-send-email-ospite@studenti.unina.it>
List-ID: <linux-bluetooth.vger.kernel.org>

Bring AC_SUBST(*_CFLAGS) and AC_SUBST(*_LIBS) in the same block of the
corresponding PKG_CHECK_MODULES() call.

Having these variables defined outside of the if tests is more than what
is needed as the corresponding PKG_CHECK_MODULES() might not have been
called at all there.

This is the same logic already used for USB_CFLAGS and USB_LIBS.
---
 configure.ac |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index b11dcf1..4ac8a78 100644
--- a/configure.ac
+++ b/configure.ac
@@ -140,12 +140,12 @@ AC_ARG_ENABLE(udev, AC_HELP_STRING([--disable-udev],
 if (test "${enable_tools}" != "no" && test "${enable_udev}" != "no"); then
 	PKG_CHECK_MODULES(UDEV, libudev >= 143, dummy=yes,
 				AC_MSG_ERROR(libudev >= 143 is required))
+	AC_SUBST(UDEV_CFLAGS)
+	AC_SUBST(UDEV_LIBS)
 	AC_CHECK_LIB(udev, udev_hwdb_new,
 		AC_DEFINE(HAVE_UDEV_HWDB_NEW, 1,
 			[Define to 1 if you have the udev_hwdb_new() function.]))
 fi
-AC_SUBST(UDEV_CFLAGS)
-AC_SUBST(UDEV_LIBS)
 AM_CONDITIONAL(UDEV, test "${enable_udev}" != "no")
 
 AC_ARG_WITH([udevdir], AC_HELP_STRING([--with-udevdir=DIR],
@@ -172,9 +172,9 @@ AC_ARG_ENABLE(obex, AC_HELP_STRING([--disable-obex],
 if (test "${enable_obex}" != "no"); then
 	PKG_CHECK_MODULES(ICAL, libical, dummy=yes,
 					AC_MSG_ERROR(libical is required))
+	AC_SUBST(ICAL_CFLAGS)
+	AC_SUBST(ICAL_LIBS)
 fi
-AC_SUBST(ICAL_CFLAGS)
-AC_SUBST(ICAL_LIBS)
 AM_CONDITIONAL(OBEX, test "${enable_obex}" != "no")
 
 AC_ARG_ENABLE(client, AC_HELP_STRING([--disable-client],
-- 
1.7.10.4
