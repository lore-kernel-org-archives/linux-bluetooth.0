Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v3] Fix leak of EIR data if RSSI does not change
Date: Tue, 28 Dec 2010 14:10:20 -0400
Message-Id: <1293559820-10738-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1293473827-26418-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1293473827-26418-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If RSSI value does not change, memory used by parsed EIR data would leak
because it would not be assigned to the remote_dev_info structure.
---
 src/adapter.c |   20 ++++++++++++++------
 src/adapter.h |    6 +++---
 src/event.c   |   49 ++++++++++++++++++++++++++++---------------------
 3 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4af11bc..b7a65dc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2923,10 +2923,18 @@ static void remove_same_uuid(gpointer data, gpointer user_data)
 	}
 }
 
+static void dev_prepend_uuid(gpointer data, gpointer user_data)
+{
+	struct remote_dev_info *dev = user_data;
+	char *new_uuid = data;
+
+	dev->services = g_slist_prepend(dev->services, g_strdup(new_uuid));
+}
+
 void adapter_update_device_from_info(struct btd_adapter *adapter,
-						bdaddr_t bdaddr, int8_t rssi,
-						uint8_t evt_type, char *name,
-						GSList *services, uint8_t flags)
+					bdaddr_t bdaddr, int8_t rssi,
+					uint8_t evt_type, const char *name,
+					GSList *services, uint8_t flags)
 {
 	struct remote_dev_info *dev;
 	gboolean new_dev;
@@ -2945,13 +2953,13 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 						(GCompareFunc) dev_rssi_cmp);
 
 	g_slist_foreach(services, remove_same_uuid, dev);
-	dev->services = g_slist_concat(dev->services, services);
+	g_slist_foreach(services, dev_prepend_uuid, dev);
 
 	dev->flags = flags;
 
 	if (name) {
 		g_free(dev->name);
-		dev->name = name;
+		dev->name = g_strdup(name);
 	}
 
 	/* FIXME: check if other information was changed before emitting the
@@ -2989,7 +2997,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 						(GCompareFunc) dev_rssi_cmp);
 
 	g_slist_foreach(services, remove_same_uuid, dev);
-	dev->services = g_slist_concat(dev->services, services);
+	g_slist_foreach(services, dev_prepend_uuid, dev);
 
 	adapter_emit_device_found(adapter, dev);
 }
diff --git a/src/adapter.h b/src/adapter.h
index 1fbc221..a655cdb 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -135,9 +135,9 @@ int adapter_get_discover_type(struct btd_adapter *adapter);
 struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter,
 						struct remote_dev_info *match);
 void adapter_update_device_from_info(struct btd_adapter *adapter,
-						bdaddr_t bdaddr, int8_t rssi,
-						uint8_t evt_type, char *name,
-						GSList *services, uint8_t flags);
+					bdaddr_t bdaddr, int8_t rssi,
+					uint8_t evt_type, const char *name,
+					GSList *services, uint8_t flags);
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				int8_t rssi, uint32_t class, const char *name,
 				const char *alias, gboolean legacy,
diff --git a/src/event.c b/src/event.c
index 178cea8..b1054d7 100644
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
@@ -455,6 +462,8 @@ void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 	adapter_update_device_from_info(adapter, info->bdaddr, rssi,
 					info->evt_type, eir_data.name,
 					eir_data.services, eir_data.flags);
+
+	free_eir_data(&eir_data);
 }
 
 static void update_lastseen(bdaddr_t *sba, bdaddr_t *dba)
@@ -491,6 +500,7 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	int state, err;
 	dbus_bool_t legacy;
 	unsigned char features[8];
+	const char *dev_name;
 
 	ba2str(local, local_addr);
 	ba2str(peer, peer_addr);
@@ -517,11 +527,6 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 		adapter_set_state(adapter, state);
 	}
 
-	memset(&eir_data, 0, sizeof(eir_data));
-	err = parse_eir_data(&eir_data, data, EIR_DATA_LENGTH);
-	if (err < 0)
-		error("Error parsing EIR data: %s (%d)", strerror(-err), -err);
-
 	/* the inquiry result can be triggered by NON D-Bus client */
 	if (adapter_get_discover_type(adapter) & DISC_RESOLVNAME &&
 				adapter_has_discov_sessions(adapter))
@@ -547,28 +552,30 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	} else
 		legacy = TRUE;
 
-	if (eir_data.name) {
+	memset(&eir_data, 0, sizeof(eir_data));
+	err = parse_eir_data(&eir_data, data, EIR_DATA_LENGTH);
+	if (err < 0)
+		error("Error parsing EIR data: %s (%d)", strerror(-err), -err);
+
+	/* Complete EIR names are always used. Shortened EIR names are only
+	 * used if there is no name already in storage. */
+	dev_name = name;
+	if (eir_data.name != NULL) {
 		if (eir_data.name_complete) {
 			write_device_name(local, peer, eir_data.name);
 			name_status = NAME_NOT_REQUIRED;
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
+			dev_name = eir_data.name;
+		} else if (name == NULL)
+			dev_name = eir_data.name;
 	}
 
-	adapter_update_found_devices(adapter, peer, rssi, class, name, alias,
-					legacy, eir_data.services, name_status);
+	adapter_update_found_devices(adapter, peer, rssi, class, dev_name,
+					alias, legacy, eir_data.services,
+					name_status);
 
-	g_free(name);
-	g_free(alias);
+	free_eir_data(&eir_data);
+	free(name);
+	free(alias);
 }
 
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer,
-- 
1.7.0.4

