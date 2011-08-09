Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 07/14] Notify registered monitors when alert is triggered
Date: Tue,  9 Aug 2011 18:00:34 -0300
Message-Id: <1312923641-12028-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a function in the adapter to notify the registered clients when
the RSSI threshold alert event is received from the low layers.
---
 src/adapter.c |   16 ++++++++++++++++
 src/adapter.h |    2 ++
 src/event.c   |   14 ++++++++++++++
 src/event.h   |    2 ++
 4 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 33ad41f..13155bd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3635,6 +3635,22 @@ int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 	return adapter_ops->remove_remote_oob_data(adapter->dev_id, bdaddr);
 }
 
+void adapter_rssi_monitor_alert_triggered(struct btd_adapter *adapter,
+					bdaddr_t *bdaddr, uint8_t alert)
+{
+	GSList *l;
+
+	for (l = adapter->rssi_monitors; l; l = l->next) {
+		struct rssi_monitor_data *monitor = l->data;
+
+		if (bacmp(&monitor->bdaddr, bdaddr) != 0)
+			continue;
+
+		monitor->cb(alert, monitor->user_data);
+		break;
+	}
+}
+
 static int rssi_monitor_bacmp(gconstpointer data, gconstpointer user_data)
 {
 	const struct rssi_monitor_data *monitor = data;
diff --git a/src/adapter.h b/src/adapter.h
index 66949e7..0a715c3 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -116,6 +116,8 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 void adapter_emit_device_found(struct btd_adapter *adapter,
 						struct remote_dev_info *dev);
+void adapter_rssi_monitor_alert_triggered(struct btd_adapter *adapter,
+					bdaddr_t *bdaddr, uint8_t alert);
 void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode);
 int adapter_update_local_name(struct btd_adapter *adapter, const char *name);
 void adapter_service_insert(struct btd_adapter *adapter, void *rec);
diff --git a/src/event.c b/src/event.c
index dc45bd3..92a73b4 100644
--- a/src/event.c
+++ b/src/event.c
@@ -460,6 +460,20 @@ void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer)
 	adapter_remove_connection(adapter, device);
 }
 
+void btd_event_rssi_monitor_alert(bdaddr_t *local, bdaddr_t *peer,
+							uint8_t alert)
+{
+	struct btd_adapter *adapter;
+
+	adapter = manager_find_adapter(local);
+	if (!adapter) {
+		error("No matching adapter found");
+		return;
+	}
+
+	adapter_rssi_monitor_alert_triggered(adapter, peer, alert);
+}
+
 /* Section reserved to device HCI callbacks */
 
 void btd_event_returned_link_key(bdaddr_t *local, bdaddr_t *peer)
diff --git a/src/event.h b/src/event.h
index 1268edf..72902cc 100644
--- a/src/event.h
+++ b/src/event.h
@@ -40,3 +40,5 @@ int btd_event_user_passkey(bdaddr_t *sba, bdaddr_t *dba);
 int btd_event_user_notify(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey);
 int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
 					uint8_t key_type, uint8_t pin_length);
+void btd_event_rssi_monitor_alert(bdaddr_t *local, bdaddr_t *peer,
+							uint8_t alert);
-- 
1.7.6

