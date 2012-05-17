Return-Path: <cyrus@holtmann.org>
From: Alex Elsayed <eternaleye@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alex Elsayed <eternaleye@gmail.com>
Subject: [PATCH v4] Add dbus service file that references the systemd unit
Date: Thu, 17 May 2012 10:00:27 -0700
Message-Id: <8a401753379e62beba65d277ad3d360280386463.1337273908.git.eternaleye@gmail.com>
In-Reply-To: <3754404.7KqlubBV4t@arkadios>
References: <3754404.7KqlubBV4t@arkadios>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows bluez to be bus-activated.
---
v4: Drop Exec= from dbus service (only systemd activation supported)
v3: Use alias as SystemdService so 'systemctl enable/disable' works
v2: Fix whitespace error

 Makefile.am              |    2 ++
 src/bluetooth.service.in |    1 +
 src/org.bluez.service    |    5 +++++
 3 files changed, 8 insertions(+)
 create mode 100644 src/org.bluez.service

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
 
diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 8a9edb6..2a576a3 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -8,3 +8,4 @@ ExecStart=@prefix@/sbin/bluetoothd -n
 
 [Install]
 WantedBy=bluetooth.target
+Alias=dbus-org.bluez.service
diff --git a/src/org.bluez.service b/src/org.bluez.service
new file mode 100644
index 0000000..dd7ae8f
--- /dev/null
+++ b/src/org.bluez.service
@@ -0,0 +1,5 @@
+[D-BUS Service]
+Name=org.bluez
+Exec=/bin/false
+User=root
+SystemdService=dbus-org.bluez.service
-- 
1.7.10.2

