Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 05/14] proximity: Move UUID string definition to lib
Date: Thu, 31 May 2012 15:43:29 +0200
Message-Id: <1338471818-20894-6-git-send-email-wagi@monom.org>
In-Reply-To: <1338471818-20894-1-git-send-email-wagi@monom.org>
References: <1338471818-20894-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 lib/uuid.h           |    5 +++++
 proximity/manager.c  |    4 ----
 proximity/reporter.c |    2 --
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/uuid.h b/lib/uuid.h
index 713075e..86679a9 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -56,6 +56,11 @@ extern "C" {
 #define PNPID_UUID		"00002a50-0000-1000-8000-00805f9b34fb"
 #define DEVICE_INFORMATION_UUID	"0000180a-0000-1000-8000-00805f9b34fb"
 
+#define GATT_UUID		"00001801-0000-1000-8000-00805f9b34fb"
+#define IMMEDIATE_ALERT_UUID	"00001802-0000-1000-8000-00805f9b34fb"
+#define LINK_LOSS_UUID		"00001803-0000-1000-8000-00805f9b34fb"
+#define TX_POWER_UUID		"00001804-0000-1000-8000-00805f9b34fb"
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
diff --git a/proximity/manager.c b/proximity/manager.c
index 286f7e3..f2e49a6 100644
--- a/proximity/manager.c
+++ b/proximity/manager.c
@@ -39,10 +39,6 @@
 #include "reporter.h"
 #include "manager.h"
 
-#define IMMEDIATE_ALERT_UUID	"00001802-0000-1000-8000-00805f9b34fb"
-#define LINK_LOSS_UUID		"00001803-0000-1000-8000-00805f9b34fb"
-#define TX_POWER_UUID		"00001804-0000-1000-8000-00805f9b34fb"
-
 static DBusConnection *connection = NULL;
 
 static struct enabled enabled  = {
diff --git a/proximity/reporter.c b/proximity/reporter.c
index 20779a8..607de2b 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -51,8 +51,6 @@
 
 #define BLUEZ_SERVICE "org.bluez"
 
-#define GATT_UUID     "00001801-0000-1000-8000-00805f9b34fb"
-
 struct reporter_adapter {
 	DBusConnection *conn;
 	struct btd_adapter *adapter;
-- 
1.7.10.130.g36e6c

