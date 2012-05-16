Return-Path: <cyrus@holtmann.org>
From: Alex Elsayed <eternaleye@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alex Elsayed <eternaleye@gmail.com>
Subject: [PATCH v2] Add dbus service file that references the systemd unit
Date: Wed, 16 May 2012 13:53:54 -0700
Message-Id: <3bc04a064cb81285510d978c3c867e5ea5203600.1337201604.git.eternaleye@gmail.com>
In-Reply-To: <20120516080134.GA27987@x220>
References: <20120516080134.GA27987@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows bluez to be bus-activated.

v2: Fix whitespace error
---
 Makefile.am              |    2 ++
 configure.ac             |    2 +-
 src/org.bluez.service.in |    5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 src/org.bluez.service.in

diff --git a/Makefile.am b/Makefile.am
index 44e82c0..82df92e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -27,8 +27,10 @@ include_HEADERS =
 
 if DATAFILES
 dbusdir = $(sysconfdir)/dbus-1/system.d
+dbusservicedir = $(datadir)/dbus-1/system-services
 
 dbus_DATA = src/bluetooth.conf
+dbusservice_DATA = src/org.bluez.service
 
 confdir = $(sysconfdir)/bluetooth
 
diff --git a/configure.ac b/configure.ac
index 44f33ad..0fb3879 100644
--- a/configure.ac
+++ b/configure.ac
@@ -71,4 +71,4 @@ if (test -n "${path_systemdunit}"); then
 fi
 AM_CONDITIONAL(SYSTEMD, test -n "${path_systemdunit}")
 
-AC_OUTPUT(Makefile doc/version.xml src/bluetoothd.8 src/bluetooth.service bluez.pc)
+AC_OUTPUT(Makefile doc/version.xml src/bluetoothd.8 src/bluetooth.service src/org.bluez.service bluez.pc)
diff --git a/src/org.bluez.service.in b/src/org.bluez.service.in
new file mode 100644
index 0000000..83e2740
--- /dev/null
+++ b/src/org.bluez.service.in
@@ -0,0 +1,5 @@
+[D-BUS Service]
+Name=org.bluez
+Exec=@prefix@/sbin/bluetoothd -n
+User=root
+SystemdService=bluetooth.service
-- 
1.7.10.2

