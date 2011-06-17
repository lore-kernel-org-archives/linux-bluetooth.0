Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2] build: Add support for systemd service configuration
Date: Thu, 16 Jun 2011 22:46:40 -0300
Message-Id: <1308275200-17393-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore               |    1 +
 Makefile.am              |    8 +++++++-
 configure.ac             |   11 ++++++++++-
 src/bluetooth.service.in |   12 ++++++++++++
 4 files changed, 30 insertions(+), 2 deletions(-)
 create mode 100644 src/bluetooth.service.in

diff --git a/.gitignore b/.gitignore
index 2ef7cb5..2ce99e7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -93,3 +93,4 @@ doc/version.xml
 doc/xml
 doc/html
 src/bluetoothd.8
+src/bluetooth.service
diff --git a/Makefile.am b/Makefile.am
index 4659c80..85f3d5f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -35,6 +35,12 @@ conf_DATA =
 statedir = $(localstatedir)/lib/bluetooth
 
 state_DATA =
+
+if SYSTEMD
+systemdunitdir = @SYSTEMD_UNITDIR@
+
+systemdunit_DATA = src/bluetooth.service
+endif
 endif
 
 plugindir = $(libdir)/bluetooth/plugins
@@ -385,7 +391,7 @@ pkgconfigdir = $(libdir)/pkgconfig
 
 pkgconfig_DATA = bluez.pc
 
-DISTCHECK_CONFIGURE_FLAGS = --disable-udevrules
+DISTCHECK_CONFIGURE_FLAGS = --disable-udevrules --with-systemdunitdir=
 
 DISTCLEANFILES = $(pkgconfig_DATA)
 
diff --git a/configure.ac b/configure.ac
index 2ce4acf..138a38f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -57,5 +57,14 @@ if (test "${enable_capng}" = "yes"); then
 	AC_DEFINE(HAVE_CAPNG, 1, [Define to 1 if you have capabilities library.])
 fi
 
+AC_ARG_WITH([systemdunitdir], AC_HELP_STRING([--with-systemdunitdir=DIR],
+	[path to systemd system service directory]), [path_systemdunit=${withval}],
+		[path_systemdunit="`$PKG_CONFIG --variable=systemdsystemunitdir systemd`"])
+if (test -n "${path_systemdunit}"); then
+	SYSTEMD_UNITDIR="${path_systemdunit}"
+	AC_SUBST(SYSTEMD_UNITDIR)
+fi
+AM_CONDITIONAL(SYSTEMD, test -n "${path_systemdunit}")
+
 AC_OUTPUT(Makefile scripts/bluetooth.rules doc/version.xml
-					src/bluetoothd.8 bluez.pc)
+			src/bluetoothd.8 src/bluetooth.service bluez.pc)
diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
new file mode 100644
index 0000000..02b6707
--- /dev/null
+++ b/src/bluetooth.service.in
@@ -0,0 +1,12 @@
+[Unit]
+Description=Bluetooth service
+After=syslog.target
+
+[Service]
+Type=dbus
+BusName=org.bluez
+ExecStart=@prefix@/sbin/bluetoothd -n
+StandardOutput=syslog
+
+[Install]
+WantedBy=bluetooth.target
-- 
1.7.5.2

