Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v5 10/12] Cleanup inserting new device found entry
Date: Wed, 18 May 2011 16:39:58 -0300
Message-Id: <1305747598-19739-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1305656789-9875-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1305656789-9875-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   97 +++++++++++++++++++++++++++-----------------------------
 1 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b1cf603..dc051cd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2914,29 +2914,24 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	g_free(alias);
 }
 
-static struct remote_dev_info *get_found_dev(struct btd_adapter *adapter,
-						const bdaddr_t *bdaddr,
-						gboolean *new_dev)
+static struct remote_dev_info *found_device_new(const bdaddr_t *bdaddr,
+					gboolean le, const char *name,
+					const char *alias, uint32_t class,
+					gboolean legacy, name_status_t status,
+					int flags)
 {
-	struct remote_dev_info *dev, match;
+	struct remote_dev_info *dev;
 
-	memset(&match, 0, sizeof(struct remote_dev_info));
-	bacpy(&match.bdaddr, bdaddr);
-	match.name_status = NAME_ANY;
-
-	dev = adapter_search_found_devices(adapter, &match);
-	if (dev) {
-		*new_dev = FALSE;
-		/* Out of range list update */
-		adapter->oor_devices = g_slist_remove(adapter->oor_devices,
-							dev);
-	} else {
-		*new_dev = TRUE;
-		dev = g_new0(struct remote_dev_info, 1);
-		bacpy(&dev->bdaddr, bdaddr);
-		adapter->found_devices = g_slist_prepend(adapter->found_devices,
-									dev);
-	}
+	dev = g_new0(struct remote_dev_info, 1);
+	bacpy(&dev->bdaddr, bdaddr);
+	dev->le = le;
+	dev->name = g_strdup(name);
+	dev->alias = g_strdup(alias);
+	dev->class = class;
+	dev->legacy = legacy;
+	dev->name_status = status;
+	if (flags >= 0)
+		dev->flags = flags;
 
 	return dev;
 }
@@ -3002,11 +2997,11 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 					uint32_t class, int8_t rssi,
 					uint8_t *data, size_t eir_size)
 {
-	struct remote_dev_info *dev;
+	struct remote_dev_info *dev, match;
 	struct eir_data eir_data;
-	char *name;
-	gboolean new_dev, legacy, le;
-	name_status_t name_status = NAME_NOT_REQUIRED;
+	char *alias, *name;
+	gboolean legacy, le;
+	name_status_t name_status;
 	int err;
 
 	memset(&eir_data, 0, sizeof(eir_data));
@@ -3019,6 +3014,25 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	if (eir_data.name != NULL && eir_data.name_complete)
 		write_device_name(&adapter->bdaddr, bdaddr, eir_data.name);
 
+	/* Device already seen in the discovery session ? */
+	memset(&match, 0, sizeof(struct remote_dev_info));
+	bacpy(&match.bdaddr, bdaddr);
+	match.name_status = NAME_ANY;
+
+	dev = adapter_search_found_devices(adapter, &match);
+	if (dev) {
+		adapter->oor_devices = g_slist_remove(adapter->oor_devices,
+							dev);
+		if (dev->rssi != rssi)
+			goto done;
+
+		eir_data_free(&eir_data);
+
+		return;
+	}
+
+	/* New device in the discovery session */
+
 	name = read_stored_data(&adapter->bdaddr, bdaddr, "names");
 
 	if (eir_data.flags < 0) {
@@ -3035,34 +3049,19 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	} else {
 		le = TRUE;
 		legacy = FALSE;
+		name_status = NAME_NOT_REQUIRED;
 	}
 
-	dev = get_found_dev(adapter, bdaddr, &new_dev);
-
-	if (new_dev) {
-		const char *dev_name = (name ? name : eir_data.name);
-		char *alias;
+	alias = read_stored_data(&adapter->bdaddr, bdaddr, "aliases");
 
-		if (dev_name)
-			dev->name = g_strdup(dev_name);
-
-		alias = read_stored_data(&adapter->bdaddr, bdaddr, "aliases");
-		if (alias) {
-			dev->alias = g_strdup(alias);
-			free(alias);
-		}
-
-		dev->le = FALSE;
-		dev->class = class;
-		dev->legacy = legacy;
-		dev->name_status = name_status;
+	dev = found_device_new(bdaddr, le, name, alias, class, legacy,
+						name_status, eir_data.flags);
+	free(name);
+	free(alias);
 
-		if (eir_data.flags >= 0)
-			dev->flags = eir_data.flags;
-
-	} else if (dev->rssi == rssi)
-		goto done;
+	adapter->found_devices = g_slist_prepend(adapter->found_devices, dev);
 
+done:
 	dev->rssi = rssi;
 
 	adapter->found_devices = g_slist_sort(adapter->found_devices,
@@ -3073,8 +3072,6 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 
 	adapter_emit_device_found(adapter, dev);
 
-done:
-	free(name);
 	eir_data_free(&eir_data);
 }
 
-- 
1.7.5.rc3

