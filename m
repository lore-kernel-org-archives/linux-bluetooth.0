Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 07/13] Unify inquiry results and advertises
Date: Thu, 28 Apr 2011 19:37:03 -0300
Message-Id: <1304030229-6672-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adapter needs to have only one method to allow discovery results
integration for both interfaces: hciops and mgmtops. This patch
moves the code related to advertises parsing to the same function
that handles inquiry results.
---
 src/adapter.c |   80 ++++++++++++++++++++++-----------------------------------
 src/adapter.h |    8 ++---
 src/event.c   |   25 +++---------------
 3 files changed, 38 insertions(+), 75 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f2be3ba..7612eb6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3082,43 +3082,6 @@ static void dev_prepend_uuid(gpointer data, gpointer user_data)
 	dev->services = g_slist_prepend(dev->services, g_strdup(new_uuid));
 }
 
-void adapter_update_device_from_info(struct btd_adapter *adapter,
-					bdaddr_t bdaddr, int8_t rssi,
-					uint8_t evt_type, const char *name,
-					GSList *services, int flags)
-{
-	struct remote_dev_info *dev;
-	gboolean new_dev;
-
-	dev = get_found_dev(adapter, &bdaddr, &new_dev);
-
-	if (new_dev) {
-		dev->le = TRUE;
-		dev->evt_type = evt_type;
-	} else if (dev->rssi == rssi)
-		return;
-
-	dev->rssi = rssi;
-
-	adapter->found_devices = g_slist_sort(adapter->found_devices,
-						(GCompareFunc) dev_rssi_cmp);
-
-	g_slist_foreach(services, remove_same_uuid, dev);
-	g_slist_foreach(services, dev_prepend_uuid, dev);
-
-	if (flags >= 0)
-		dev->flags = flags;
-
-	if (name) {
-		g_free(dev->name);
-		dev->name = g_strdup(name);
-	}
-
-	/* FIXME: check if other information was changed before emitting the
-	 * signal */
-	adapter_emit_device_found(adapter, dev);
-}
-
 static int remote_legacy_pairing(bdaddr_t *local, bdaddr_t *peer,
 					uint8_t *data, gboolean *legacy)
 {
@@ -3155,13 +3118,15 @@ static char *read_stored_data(bdaddr_t *local, bdaddr_t *peer, const char *file)
 }
 
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-				uint32_t class, int8_t rssi, uint8_t *data)
+					uint8_t bda_type, uint32_t class,
+					int8_t rssi, uint8_t *data,
+					size_t eir_size)
 {
 	struct remote_dev_info *dev;
 	struct eir_data eir_data;
 	char *name;
-	gboolean new_dev, legacy;
-	name_status_t name_status;
+	gboolean new_dev, legacy, le;
+	name_status_t name_status = NAME_NOT_REQUIRED;
 	const char *dev_name;
 	int err, type;
 
@@ -3172,17 +3137,30 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 		return;
 	}
 
-	if (remote_legacy_pairing(&adapter->bdaddr, bdaddr, data, &legacy) < 0)
-		legacy = TRUE;
-
 	name = read_stored_data(&adapter->bdaddr, bdaddr, "names");
-	type = adapter_get_discover_type(adapter);
 
-	if (!name && type & DISC_RESOLVNAME &&
-			adapter_has_discov_sessions(adapter))
-		name_status = NAME_REQUIRED;
-	else
-		name_status = NAME_NOT_REQUIRED;
+	switch (bda_type) {
+	case BDADDR_TYPE_LE_PUBLIC:
+	case BRADDR_TYPE_LE_RANDOM:
+		le = TRUE;
+		legacy = FALSE;
+		break;
+	default:
+		/*  BDADDR_TYPE_BR */
+		le = FALSE;
+		if (remote_legacy_pairing(&adapter->bdaddr, bdaddr,
+							data, &legacy) < 0)
+			legacy = TRUE;
+
+		type = adapter_get_discover_type(adapter);
+
+		if (!name && type & DISC_RESOLVNAME &&
+				adapter_has_discov_sessions(adapter))
+			name_status = NAME_REQUIRED;
+		else
+			name_status = NAME_NOT_REQUIRED;
+		break;
+	}
 
 	/* Complete EIR names are always used. Shortened EIR names are only
 	 * used if there is no name already in storage. */
@@ -3214,6 +3192,10 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 		dev->class = class;
 		dev->legacy = legacy;
 		dev->name_status = name_status;
+
+		if (eir_data.flags >= 0)
+			dev->flags = eir_data.flags;
+
 	} else if (dev->rssi == rssi)
 		goto done;
 
diff --git a/src/adapter.h b/src/adapter.h
index 94707e5..931be37 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -118,12 +118,10 @@ int adapter_get_state(struct btd_adapter *adapter);
 int adapter_get_discover_type(struct btd_adapter *adapter);
 struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter,
 						struct remote_dev_info *match);
-void adapter_update_device_from_info(struct btd_adapter *adapter,
-					bdaddr_t bdaddr, int8_t rssi,
-					uint8_t evt_type, const char *name,
-					GSList *services, int flags);
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-				uint32_t class, int8_t rssi, uint8_t *data);
+					uint8_t bda_type, uint32_t class,
+					int8_t rssi, uint8_t *data,
+					size_t eir_size);
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 void adapter_emit_device_found(struct btd_adapter *adapter,
 						struct remote_dev_info *dev);
diff --git a/src/event.c b/src/event.c
index 263d428..84a51cf 100644
--- a/src/event.c
+++ b/src/event.c
@@ -250,19 +250,10 @@ void btd_event_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer,
 	device_simple_pairing_complete(device, status);
 }
 
-static void free_eir_data(struct eir_data *eir)
-{
-	g_slist_foreach(eir->services, (GFunc) g_free, NULL);
-	g_slist_free(eir->services);
-	g_free(eir->name);
-}
-
 void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 {
 	struct btd_adapter *adapter;
-	struct eir_data eir_data;
 	int8_t rssi;
-	int err;
 
 	adapter = manager_find_adapter(local);
 	if (adapter == NULL) {
@@ -270,19 +261,10 @@ void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 		return;
 	}
 
-	memset(&eir_data, 0, sizeof(eir_data));
-	err = eir_parse(&eir_data, info->data, info->length);
-	if (err < 0)
-		error("Error parsing advertising data: %s (%d)",
-							strerror(-err), -err);
-
 	rssi = *(info->data + info->length);
 
-	adapter_update_device_from_info(adapter, info->bdaddr, rssi,
-					info->evt_type, eir_data.name,
-					eir_data.services, eir_data.flags);
-
-	free_eir_data(&eir_data);
+	adapter_update_found_devices(adapter, &info->bdaddr, info->bdaddr_type,
+					0, rssi, info->data, info->length);
 }
 
 static void update_lastseen(bdaddr_t *sba, bdaddr_t *dba)
@@ -336,7 +318,8 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 		adapter_set_state(adapter, state);
 	}
 
-	adapter_update_found_devices(adapter, peer, class, rssi, data);
+	adapter_update_found_devices(adapter, peer, BDADDR_TYPE_BR, class,
+						rssi, data, EIR_DATA_LENGTH);
 
 }
 
-- 
1.7.5.rc3

