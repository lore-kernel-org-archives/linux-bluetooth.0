Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 05/15] proximity: Move UUID defintion to core
Date: Wed, 30 May 2012 14:59:58 +0200
Message-Id: <1338382808-29725-6-git-send-email-wagi@monom.org>
In-Reply-To: <1338382808-29725-1-git-send-email-wagi@monom.org>
References: <1338382808-29725-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 proximity/manager.c  |    6 ++----
 proximity/reporter.c |    4 ++--
 src/uuid.h           |    5 +++++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/proximity/manager.c b/proximity/manager.c
index 286f7e3..6e89839 100644
--- a/proximity/manager.c
+++ b/proximity/manager.c
@@ -30,6 +30,8 @@
 #include <gdbus.h>
 #include <bluetooth/uuid.h>
 
+#include "../src/uuid.h"
+
 #include "adapter.h"
 #include "device.h"
 #include "att.h"
@@ -39,10 +41,6 @@
 #include "reporter.h"
 #include "manager.h"
 
-#define IMMEDIATE_ALERT_UUID	"00001802-0000-1000-8000-00805f9b34fb"
-#define LINK_LOSS_UUID		"00001803-0000-1000-8000-00805f9b34fb"
-#define TX_POWER_UUID		"00001804-0000-1000-8000-00805f9b34fb"
-
 static DBusConnection *connection = NULL;
 
 static struct enabled enabled  = {
diff --git a/proximity/reporter.c b/proximity/reporter.c
index 20779a8..d051477 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -34,6 +34,8 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
+#include "../src/uuid.h"
+
 #include "log.h"
 
 #include "dbus-common.h"
@@ -51,8 +53,6 @@
 
 #define BLUEZ_SERVICE "org.bluez"
 
-#define GATT_UUID     "00001801-0000-1000-8000-00805f9b34fb"
-
 struct reporter_adapter {
 	DBusConnection *conn;
 	struct btd_adapter *adapter;
diff --git a/src/uuid.h b/src/uuid.h
index 7ef19cc..2fc3d54 100644
--- a/src/uuid.h
+++ b/src/uuid.h
@@ -44,3 +44,8 @@
 
 #define PNPID_UUID		"00002a50-0000-1000-8000-00805f9b34fb"
 #define DEVICE_INFORMATION_UUID	"0000180a-0000-1000-8000-00805f9b34fb"
+
+#define GATT_UUID		"00001801-0000-1000-8000-00805f9b34fb"
+#define IMMEDIATE_ALERT_UUID	"00001802-0000-1000-8000-00805f9b34fb"
+#define LINK_LOSS_UUID		"00001803-0000-1000-8000-00805f9b34fb"
+#define TX_POWER_UUID		"00001804-0000-1000-8000-00805f9b34fb"
-- 
1.7.10.130.g36e6c

