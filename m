Return-Path: <cyrus@holtmann.org>
From: Alex Elsayed <eternaleye@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alex Elsayed <eternaleye@gmail.com>
Subject: [PATCH v3] Add dbus service file that references the systemd unit
Date: Thu, 17 May 2012 09:37:42 -0700
Message-Id: <8413b8e5d2d104f40c808c851119711095bce393.1337272488.git.eternaleye@gmail.com>
In-Reply-To: <4094065.PHO1OqQSqp@arkadios>
References: <4094065.PHO1OqQSqp@arkadios>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows bluez to be bus-activated.
---
v3: Use alias as SystemdService so 'systemctl enable/disable' works
v2: Fix whitespace error

 Makefile.am              |    2 ++
 configure.ac             |    2 +-
 src/bluetooth.service.in |    1 +
 src/org.bluez.service.in |    5 +++++
 4 files changed, 9 insertions(+), 1 deletion(-)
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
diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 8a9edb6..2a576a3 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -8,3 +8,4 @@ ExecStart=@prefix@/sbin/bluetoothd -n
 
 [Install]
 WantedBy=bluetooth.target
+Alias=dbus-org.bluez.service
diff --git a/src/org.bluez.service.in b/src/org.bluez.service.in
new file mode 100644
index 0000000..64864cd
--- /dev/null
+++ b/src/org.bluez.service.in
@@ -0,0 +1,5 @@
+[D-BUS Service]
+Name=org.bluez
+Exec=@prefix@/sbin/bluetoothd -n
+User=root
+SystemdService=dbus-org.bluez.service
-- 
1.7.10.2

