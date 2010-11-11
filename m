Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH v2 3/7] Refactoring adapter_update_found_devices() function
Date: Thu, 11 Nov 2010 15:51:57 -0300
Message-Id: <1289501521-21825-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

The common code from adapter_update_found_devices() was moved to
update_found_devices().
---
 src/adapter.c |   50 +++++++++++++++++++++++++++++++-------------------
 1 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 363ee94..6f4f2a3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3108,10 +3108,8 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	g_strfreev(uuids);
 }
 
-void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-				int8_t rssi, uint32_t class, const char *name,
-				const char *alias, gboolean legacy,
-				name_status_t name_status, uint8_t *eir_data)
+static struct remote_dev_info *get_found_dev(struct btd_adapter *adapter,
+				const bdaddr_t *bdaddr, gboolean *new_dev)
 {
 	struct remote_dev_info *dev, match;
 
@@ -3121,30 +3119,44 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 
 	dev = adapter_search_found_devices(adapter, &match);
 	if (dev) {
+		*new_dev = FALSE;
 		/* Out of range list update */
 		adapter->oor_devices = g_slist_remove(adapter->oor_devices,
 							dev);
+	} else {
+		*new_dev = TRUE;
+		dev = g_new0(struct remote_dev_info, 1);
+		bacpy(&dev->bdaddr, bdaddr);
+		adapter->found_devices = g_slist_prepend(adapter->found_devices,
+									dev);
+	}
 
-		if (rssi == dev->rssi)
-			return;
+	return dev;
+}
 
-		goto done;
-	}
+void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
+				int8_t rssi, uint32_t class, const char *name,
+				const char *alias, gboolean legacy,
+				name_status_t name_status, uint8_t *eir_data)
+{
+	struct remote_dev_info *dev;
+	gboolean new_dev;
 
-	dev = g_new0(struct remote_dev_info, 1);
+	dev = get_found_dev(adapter, bdaddr, &new_dev);
 
-	bacpy(&dev->bdaddr, bdaddr);
-	dev->class = class;
-	if (name)
-		dev->name = g_strdup(name);
-	if (alias)
-		dev->alias = g_strdup(alias);
-	dev->legacy = legacy;
-	dev->name_status = name_status;
+	if (new_dev) {
+		if (name)
+			dev->name = g_strdup(name);
 
-	adapter->found_devices = g_slist_prepend(adapter->found_devices, dev);
+		if (alias)
+			dev->alias = g_strdup(alias);
+
+		dev->class = class;
+		dev->legacy = legacy;
+		dev->name_status = name_status;
+	} else if (dev->rssi == rssi)
+		return;
 
-done:
 	dev->rssi = rssi;
 
 	adapter->found_devices = g_slist_sort(adapter->found_devices,
-- 
1.7.3.2

