Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2] Fix leak of EIR data if RSSI does not change
Date: Mon, 27 Dec 2010 14:17:07 -0400
Message-Id: <1293473827-26418-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1293456068-11615-4-git-send-email-anderson.lizardo@openbossa.org>
References: <1293456068-11615-4-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If RSSI value does not change, memory used by parsed EIR data would leak
because it would not be assigned to the remote_dev_info structure.

Also simplify related code and replace a couple of g_free()'s with
free() (simply because they were allocated with malloc()).
---
 src/adapter.c |   19 ++++++++++++-------
 src/adapter.h |   11 ++++++-----
 src/event.c   |   47 ++++++++++++++++++++++++-----------------------
 3 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index bfc2b8b..4b10189 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2917,7 +2917,7 @@ static void remove_same_uuid(gpointer data, gpointer user_data)
 	}
 }
 
-void adapter_update_device_from_info(struct btd_adapter *adapter,
+gboolean adapter_update_device_from_info(struct btd_adapter *adapter,
 						bdaddr_t bdaddr, int8_t rssi,
 						uint8_t evt_type, char *name,
 						GSList *services, uint8_t flags)
@@ -2931,7 +2931,7 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 		dev->le = TRUE;
 		dev->evt_type = evt_type;
 	} else if (dev->rssi == rssi)
-		return;
+		return FALSE;
 
 	dev->rssi = rssi;
 
@@ -2951,12 +2951,15 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 	/* FIXME: check if other information was changed before emitting the
 	 * signal */
 	adapter_emit_device_found(adapter, dev);
+
+	return TRUE;
 }
 
-void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-				int8_t rssi, uint32_t class, const char *name,
-				const char *alias, gboolean legacy,
-				GSList *services, name_status_t name_status)
+gboolean adapter_update_found_devices(struct btd_adapter *adapter,
+				bdaddr_t *bdaddr, int8_t rssi, uint32_t class,
+				const char *name, const char *alias,
+				gboolean legacy, GSList *services,
+				name_status_t name_status)
 {
 	struct remote_dev_info *dev;
 	gboolean new_dev;
@@ -2975,7 +2978,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 		dev->legacy = legacy;
 		dev->name_status = name_status;
 	} else if (dev->rssi == rssi)
-		return;
+		return FALSE;
 
 	dev->rssi = rssi;
 
@@ -2986,6 +2989,8 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	dev->services = g_slist_concat(dev->services, services);
 
 	adapter_emit_device_found(adapter, dev);
+
+	return TRUE;
 }
 
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr)
diff --git a/src/adapter.h b/src/adapter.h
index 857eec8..cee0bd4 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -134,14 +134,15 @@ int adapter_get_state(struct btd_adapter *adapter);
 int adapter_get_discover_type(struct btd_adapter *adapter);
 struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter,
 						struct remote_dev_info *match);
-void adapter_update_device_from_info(struct btd_adapter *adapter,
+gboolean adapter_update_device_from_info(struct btd_adapter *adapter,
 						bdaddr_t bdaddr, int8_t rssi,
 						uint8_t evt_type, char *name,
 						GSList *services, uint8_t flags);
-void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-				int8_t rssi, uint32_t class, const char *name,
-				const char *alias, gboolean legacy,
-				GSList *services, name_status_t name_status);
+gboolean adapter_update_found_devices(struct btd_adapter *adapter,
+				bdaddr_t *bdaddr, int8_t rssi, uint32_t class,
+				const char *name, const char *alias,
+				gboolean legacy, GSList *services,
+				name_status_t name_status);
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 void adapter_emit_device_found(struct btd_adapter *adapter,
 						struct remote_dev_info *dev);
diff --git a/src/event.c b/src/event.c
index 178cea8..5beedb8 100644
--- a/src/event.c
+++ b/src/event.c
@@ -431,6 +431,13 @@ static int parse_eir_data(struct eir_data *eir, uint8_t *eir_data,
 	return 0;
 }
 
+static void free_eir_data(struct eir_data *eir)
+{
+	g_slist_foreach(eir->services, (GFunc) g_free, NULL);
+	g_slist_free(eir->services);
+	g_free(eir->name);
+}
+
 void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 {
 	struct btd_adapter *adapter;
@@ -452,9 +459,10 @@ void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 
 	rssi = *(info->data + info->length);
 
-	adapter_update_device_from_info(adapter, info->bdaddr, rssi,
+	if (!adapter_update_device_from_info(adapter, info->bdaddr, rssi,
 					info->evt_type, eir_data.name,
-					eir_data.services, eir_data.flags);
+					eir_data.services, eir_data.flags))
+		free_eir_data(&eir_data);
 }
 
 static void update_lastseen(bdaddr_t *sba, bdaddr_t *dba)
@@ -529,6 +537,14 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	else
 		name_status = NAME_NOT_REQUIRED;
 
+	/* Update storage if EIR contains the complete device name */
+	if (eir_data.name && eir_data.name_complete) {
+		write_device_name(local, peer, eir_data.name);
+		name_status = NAME_NOT_REQUIRED;
+		g_free(eir_data.name);
+		eir_data.name = NULL;
+	}
+
 	create_name(filename, PATH_MAX, STORAGEDIR, local_addr, "aliases");
 	alias = textfile_get(filename, peer_addr);
 
@@ -547,28 +563,13 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	} else
 		legacy = TRUE;
 
-	if (eir_data.name) {
-		if (eir_data.name_complete) {
-			write_device_name(local, peer, eir_data.name);
-			name_status = NAME_NOT_REQUIRED;
-
-			if (name)
-				g_free(name);
-
-			name = eir_data.name;
-		} else {
-			if (name)
-				free(eir_data.name);
-			else
-				name = eir_data.name;
-		}
-	}
-
-	adapter_update_found_devices(adapter, peer, rssi, class, name, alias,
-					legacy, eir_data.services, name_status);
+	if (!adapter_update_found_devices(adapter, peer, rssi, class, name,
+					alias, legacy, eir_data.services,
+					name_status))
+		free_eir_data(&eir_data);
 
-	g_free(name);
-	g_free(alias);
+	free(name);
+	free(alias);
 }
 
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer,
-- 
1.7.0.4

