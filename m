Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 4/4] Fix leak of EIR data if RSSI does not change
Date: Mon, 27 Dec 2010 09:21:08 -0400
Message-Id: <1293456068-11615-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1293456068-11615-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1293456068-11615-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If RSSI value does not change, memory used by parsed EIR data would leak
because it would not be assigned to the remote_dev_info structure.
---
 src/adapter.c |   19 ++++++++++++-------
 src/adapter.h |   11 ++++++-----
 src/event.c   |   16 ++++++++++++----
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index fddf0ad..aff1262 100644
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
index 15fac94..795686e 100644
--- a/src/event.c
+++ b/src/event.c
@@ -452,9 +452,13 @@ void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 
 	rssi = *(info->data + info->length);
 
-	adapter_update_device_from_info(adapter, info->bdaddr, rssi,
+	if (!adapter_update_device_from_info(adapter, info->bdaddr, rssi,
 					info->evt_type, eir_data.name,
-					eir_data.services, eir_data.flags);
+					eir_data.services, eir_data.flags)) {
+		g_slist_foreach(eir_data.services, (GFunc) g_free, NULL);
+		g_slist_free(eir_data.services);
+		g_free(eir_data.name);
+	}
 }
 
 static void update_lastseen(bdaddr_t *sba, bdaddr_t *dba)
@@ -556,8 +560,12 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	} else if (eir_data.name != NULL)
 		g_free(eir_data.name);
 
-	adapter_update_found_devices(adapter, peer, rssi, class, name, alias,
-					legacy, eir_data.services, name_status);
+	if (!adapter_update_found_devices(adapter, peer, rssi, class, name,
+					alias, legacy, eir_data.services,
+					name_status)) {
+		g_slist_foreach(eir_data.services, (GFunc) g_free, NULL);
+		g_slist_free(eir_data.services);
+	}
 
 	g_free(name);
 	g_free(alias);
-- 
1.7.0.4

