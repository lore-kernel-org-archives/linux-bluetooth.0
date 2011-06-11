Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] build: Add support for systemd service configuration
Date: Sat, 11 Jun 2011 12:46:00 -0300
Message-Id: <1307807160-1611-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore               |    1 +
 Makefile.am              |    4 ++++
 configure.ac             |   11 ++++++++++-
 src/bluetooth.service.in |   10 ++++++++++
 4 files changed, 25 insertions(+), 1 deletions(-)
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
index 4659c80..4e28708 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -35,6 +35,10 @@ conf_DATA =
 statedir = $(localstatedir)/lib/bluetooth
 
 state_DATA =
+
+systemdunitdir = @SYSTEMD_UNITDIR@
+
+systemdunit_DATA = src/bluetooth.service
 endif
 
 plugindir = $(libdir)/bluetooth/plugins
diff --git a/configure.ac b/configure.ac
index 2ce4acf..6c37e83 100644
--- a/configure.ac
+++ b/configure.ac
@@ -57,5 +57,14 @@ if (test "${enable_capng}" = "yes"); then
 	AC_DEFINE(HAVE_CAPNG, 1, [Define to 1 if you have capabilities library.])
 fi
 
+AC_ARG_WITH([systemdsystemunitdir], AC_HELP_STRING([--with-systemdsystemunitdir=DIR],
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
index 0000000..8a9edb6
--- /dev/null
+++ b/src/bluetooth.service.in
@@ -0,0 +1,10 @@
+[Unit]
+Description=Bluetooth service
+
+[Service]
+Type=dbus
+BusName=org.bluez
+ExecStart=@prefix@/sbin/bluetoothd -n
+
+[Install]
+WantedBy=bluetooth.target
-- 
1.7.5.2

