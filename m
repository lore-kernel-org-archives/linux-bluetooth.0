Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH BlueZ] configure.ac: call AC_SUBST unconditionally
Date: Sun,  3 Feb 2013 16:46:50 +0100
Message-Id: <1359906411-12624-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Call AC_SUBST unconditionally, otherwise options like
--with-dbusconfdir=DIR or --with-udevdir=DIR have no effect.

Before this change, configuring with:

  $ mkdir build
  $ ./configure --disable-systemd \
                --prefix=$(pwd)/build \
                --with-dbusconfdir=$(pwd)/build/etc

resulted in the option value to be ignored at "make install" time, with
this error:

  /bin/mkdir: cannot create directory '/dbus-1/system.d': Permission denied

After the patch the option value is respected.
---

Hi,

the issue was highlighted by the use "--prefix=" and running "make install" as
a restricted user, maybe the are still other issues with this use case.
Anyone willing to take a deeper look?

For instance, is "--prefix=DIR" supposed to be prepended to manually specified
paths too?

Thanks,
   Antonio

 configure.ac |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index 070acea..fe2893a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -71,8 +71,8 @@ if (test -z "${path_dbusconfdir}"); then
 		AC_MSG_ERROR([D-Bus configuration directory is required])
 	fi
 	AC_MSG_RESULT([${path_dbusconfdir}])
-	AC_SUBST(DBUS_CONFDIR, [${path_dbusconfdir}])
 fi
+AC_SUBST(DBUS_CONFDIR, [${path_dbusconfdir}])
 
 AC_ARG_WITH([dbussystembusdir], AC_HELP_STRING([--with-dbussystembusdir=DIR],
 				[path to D-Bus system bus services directory]),
@@ -84,8 +84,8 @@ if (test -z "${path_dbussystembusdir}"); then
 		AC_MSG_ERROR([D-Bus system bus services directory is required])
 	fi
 	AC_MSG_RESULT([${path_dbussystembusdir}])
-	AC_SUBST(DBUS_SYSTEMBUSDIR, [${path_dbussystembusdir}])
 fi
+AC_SUBST(DBUS_SYSTEMBUSDIR, [${path_dbussystembusdir}])
 
 AC_ARG_WITH([dbussessionbusdir], AC_HELP_STRING([--with-dbussessionbusdir=DIR],
 				[path to D-Bus session bus services directory]),
@@ -97,8 +97,8 @@ if (test -z "${path_dbussessionbusdir}"); then
 		AC_MSG_ERROR([D-Bus session bus services directory is required])
 	fi
 	AC_MSG_RESULT([${path_dbussessionbusdir}])
-	AC_SUBST(DBUS_SESSIONBUSDIR, [${path_dbussessionbusdir}])
 fi
+AC_SUBST(DBUS_SESSIONBUSDIR, [${path_dbussessionbusdir}])
 
 AC_ARG_ENABLE(library, AC_HELP_STRING([--enable-library],
 		[install Bluetooth library]), [enable_library=${enableval}])
@@ -121,8 +121,6 @@ AC_ARG_ENABLE(usb, AC_HELP_STRING([--disable-usb],
 if (test "${enable_tools}" != "no" && test "${enable_usb}" != "no"  ); then
 	PKG_CHECK_MODULES(USB, libusb, dummy=yes,
 			AC_MSG_ERROR(USB library support is required))
-	AC_SUBST(USB_CFLAGS)
-	AC_SUBST(USB_LIBS)
 	AC_CHECK_LIB(usb, usb_get_busses, dummy=yes,
 		AC_DEFINE(NEED_USB_GET_BUSSES, 1,
 			[Define to 1 if you need the usb_get_busses() function.]
@@ -133,6 +131,8 @@ if (test "${enable_tools}" != "no" && test "${enable_usb}" != "no"  ); then
 on.]))
 	AC_DEFINE(HAVE_LIBUSB, 1, [Define to 1 if you have USB library.])
 fi
+AC_SUBST(USB_CFLAGS)
+AC_SUBST(USB_LIBS)
 AM_CONDITIONAL(USB, test "${enable_usb}" != "no")
 
 AC_ARG_ENABLE(udev, AC_HELP_STRING([--disable-udev],
@@ -157,8 +157,8 @@ if (test "${enable_udev}" != "no" && test -z "${path_udevdir}"); then
 		AC_MSG_ERROR([udev directory is required])
 	fi
 	AC_MSG_RESULT([${path_udevdir}])
-	AC_SUBST(UDEV_DIR, [${path_udevdir}])
 fi
+AC_SUBST(UDEV_DIR, [${path_udevdir}])
 
 AM_CONDITIONAL(HID2HCI, test "${enable_tools}" != "no" &&
 		test "${enable_udev}" != "no" && test "${enable_usb}" != "no")
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
1.7.10.4

