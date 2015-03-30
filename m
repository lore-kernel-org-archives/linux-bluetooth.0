Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v6 2/8] core/adapter: Refactor of scan type
Date: Mon, 30 Mar 2015 16:32:14 -0700
Message-Id: <1427758340-14949-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1427758340-14949-1-git-send-email-jpawlowski@google.com>
References: <1427758340-14949-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces scan type with defined constants, and creates
new method that might be used to get currently avaliable scan type.
---
 src/adapter.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b806106..8f6583c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -89,6 +89,9 @@
 #define TEMP_DEV_TIMEOUT (3 * 60)
 #define BONDING_TIMEOUT (2 * 60)
 
+#define SCAN_TYPE_BREDR (1 << BDADDR_BREDR)
+#define SCAN_TYPE_LE ((1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM))
+
 static DBusConnection *dbus_conn = NULL;
 
 static bool kernel_conn_control = false;
@@ -1187,7 +1190,7 @@ static gboolean passive_scanning_timeout(gpointer user_data)
 
 	adapter->passive_scan_timeout = 0;
 
-	cp.type = (1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM);
+	cp.type = SCAN_TYPE_LE;
 
 	mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY,
 				adapter->dev_id, sizeof(cp), &cp,
@@ -1329,6 +1332,21 @@ static void cancel_passive_scanning(struct btd_adapter *adapter)
 	}
 }
 
+static uint8_t get_scan_type(struct btd_adapter *adapter)
+{
+	uint8_t type;
+
+	if (adapter->current_settings & MGMT_SETTING_BREDR)
+		type = SCAN_TYPE_BREDR;
+	else
+		type = 0;
+
+	if (adapter->current_settings & MGMT_SETTING_LE)
+		type |= SCAN_TYPE_LE;
+
+	return type;
+}
+
 static void trigger_start_discovery(struct btd_adapter *adapter, guint delay);
 
 static void start_discovery_complete(uint8_t status, uint16_t length,
@@ -1374,13 +1392,7 @@ static gboolean start_discovery_timeout(gpointer user_data)
 
 	adapter->discovery_idle_timeout = 0;
 
-	if (adapter->current_settings & MGMT_SETTING_BREDR)
-		new_type = (1 << BDADDR_BREDR);
-	else
-		new_type = 0;
-
-	if (adapter->current_settings & MGMT_SETTING_LE)
-		new_type |= (1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM);
+	new_type = get_scan_type(adapter);
 
 	if (adapter->discovery_enable == 0x01) {
 		/*
-- 
2.2.0.rc0.207.ga3a616c

