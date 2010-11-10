Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 3/7] Refactoring adapter_update_found_devices() function
Date: Wed, 10 Nov 2010 13:51:23 -0400
Message-Id: <1289411487-6113-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1289411487-6113-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1289411487-6113-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

The common code from adapter_update_found_devices() was moved to
update_found_devices().
---
 src/adapter.c |   52 +++++++++++++++++++++++++++++++---------------------
 1 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4d23db0..c54d035 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3108,12 +3108,11 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	g_strfreev(uuids);
 }
 
-void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-				int8_t rssi, uint32_t class, const char *name,
-				const char *alias, gboolean legacy,
-				name_status_t name_status, uint8_t *eir_data)
+static gboolean update_found_devices(struct btd_adapter *adapter,
+	bdaddr_t *bdaddr, int8_t rssi, struct remote_dev_info **dev_info)
 {
 	struct remote_dev_info *dev, match;
+	gboolean found;
 
 	memset(&match, 0, sizeof(struct remote_dev_info));
 	bacpy(&match.bdaddr, bdaddr);
@@ -3121,30 +3120,41 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 
 	dev = adapter_search_found_devices(adapter, &match);
 	if (dev) {
+		found = TRUE;
 		/* Out of range list update */
 		adapter->oor_devices = g_slist_remove(adapter->oor_devices,
-							dev);
-
-		if (rssi == dev->rssi)
-			return;
-
-		goto done;
+									dev);
+	} else {
+		found = FALSE;
+		dev = g_new0(struct remote_dev_info, 1);
+		bacpy(&dev->bdaddr, bdaddr);
+		adapter->found_devices = g_slist_prepend(adapter->found_devices,
+									dev);
 	}
 
-	dev = g_new0(struct remote_dev_info, 1);
+	*dev_info = dev;
 
-	bacpy(&dev->bdaddr, bdaddr);
-	dev->class = class;
-	if (name)
-		dev->name = g_strdup(name);
-	if (alias)
-		dev->alias = g_strdup(alias);
-	dev->legacy = legacy;
-	dev->name_status = name_status;
+	return found;
+}
 
-	adapter->found_devices = g_slist_prepend(adapter->found_devices, dev);
+void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
+				int8_t rssi, uint32_t class, const char *name,
+				const char *alias, gboolean legacy,
+				name_status_t name_status, uint8_t *eir_data)
+{
+	struct remote_dev_info *dev;
+
+	if (!update_found_devices(adapter, bdaddr, rssi, &dev)) {
+		dev->class = class;
+		if (name)
+			dev->name = g_strdup(name);
+		if (alias)
+			dev->alias = g_strdup(alias);
+		dev->legacy = legacy;
+		dev->name_status = name_status;
+	} else if (dev->rssi == rssi)
+		return;
 
-done:
 	dev->rssi = rssi;
 
 	adapter->found_devices = g_slist_sort(adapter->found_devices,
-- 
1.7.0.4

