Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCHv2 BlueZ 1/2] configure.ac: call AC_SUBST unconditionally with --with-* options
Date: Sun, 10 Feb 2013 22:20:50 +0100
Message-Id: <1360531251-18371-2-git-send-email-ospite@studenti.unina.it>
In-Reply-To: <1360531251-18371-1-git-send-email-ospite@studenti.unina.it>
References: <1359906411-12624-1-git-send-email-ospite@studenti.unina.it>
 <1360531251-18371-1-git-send-email-ospite@studenti.unina.it>
List-ID: <linux-bluetooth.vger.kernel.org>

Call AC_SUBST unconditionally when specifying --with-* options,
otherwise options like --with-dbusconfdir=DIR or --with-udevdir=DIR have
no effect.

Before this change, configuring with:

  $ mkdir build
  $ ./configure --disable-systemd \
                --prefix=$(pwd)/build \
                --with-dbusconfdir=$(pwd)/build/etc

resulted in the option value to be ignored at "make install" time, with
this error:

  /bin/mkdir: cannot create directory '/dbus-1/system.d': Permission denied

This is what was going on in configure.ac:

  # define the option
  AC_ARG_WITH([dbusconfdir] ... [path_dbusconfdir=${withval}])

  # when --with-dbusconfdir is NOT used
  if (test -z "${path_dbusconfdir}"); then
    ...

    # define the config dir automatically
    path_dbusconfdir="`$PKG_CONFIG --variable=sysconfdir dbus-1`"

    ...

    # set DBUS_CONFDIR
    AC_SUBST(DBUS_CONFDIR, [${path_dbusconfdir}])
  endif

when --with-dbusconfdir=SOMEDIR was used the test above failed, and the
result was that ${path_dbusconfdir} was indeed defined as manually
specified, but DBUS_CONFDIR was not, and the latter was going to be used
in Makefile.am:

  dbusdir = @DBUS_CONFDIR@/dbus-1/system.d

The failure in mkdir can be exposed by the use of the "--prefix" option
and by running "make install" as a normal user; when running "make
install" with the root user /dbus-1/system.d would be happily (and
wrongly) created.

By always setting variables relative to --with-* options (like
DBUS_CONFDIR) the cases when --with-someoption=SOMEDIR are used get
covered.
---
 configure.ac |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 070acea..b11dcf1 100644
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
