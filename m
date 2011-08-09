Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 03/14] Add enable RSSI threshold monitoring
Date: Tue,  9 Aug 2011 18:00:30 -0300
Message-Id: <1312923641-12028-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial RSSI threshold monitoring in the adapter. RSSI monitor callback
will be called when the RSSI monitor state changes triggered by one of
the thresholds transition. Not yet functional.
---
 src/adapter.c |   27 +++++++++++++++++++++++++++
 src/adapter.h |    6 ++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4c88a0e..37ed727 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -104,6 +104,11 @@ struct service_auth {
 	struct btd_adapter *adapter;
 };
 
+struct rssi_monitor_data {
+	rssi_monitor cb;
+	gpointer user_data;
+};
+
 struct btd_adapter {
 	uint16_t dev_id;
 	int up;
@@ -148,6 +153,8 @@ struct btd_adapter {
 	GSList *powered_callbacks;
 	GSList *pin_callbacks;
 
+	GSList *rssi_monitors;		/* RSSI Threshold monitors */
+
 	GSList *loaded_drivers;
 };
 
@@ -2467,6 +2474,7 @@ static void adapter_free(gpointer user_data)
 	sdp_list_free(adapter->services, NULL);
 
 	g_slist_free_full(adapter->found_devices, dev_info_free);
+	g_slist_free_full(adapter->rssi_monitors, g_free);
 
 	g_slist_free(adapter->oor_devices);
 
@@ -3625,3 +3633,22 @@ int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 {
 	return adapter_ops->remove_remote_oob_data(adapter->dev_id, bdaddr);
 }
+
+gboolean btd_adapter_enable_rssi_monitor(struct btd_adapter *adapter,
+					bdaddr_t *bdaddr, int8_t low,
+					int high, rssi_monitor cb,
+					gpointer user_data)
+{
+	struct rssi_monitor_data *monitor;
+
+	monitor = g_try_new(struct rssi_monitor_data, 1);
+	if (monitor == NULL)
+		return FALSE;
+
+	monitor->cb = cb;
+	monitor->user_data = user_data;
+
+	adapter->rssi_monitors = g_slist_append(adapter->rssi_monitors, monitor);
+
+	return TRUE;
+}
diff --git a/src/adapter.h b/src/adapter.h
index 658a211..ca53152 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -279,3 +279,9 @@ int btd_adapter_add_remote_oob_data(struct btd_adapter *adapter,
 
 int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 							bdaddr_t *bdaddr);
+
+typedef void (*rssi_monitor) (uint8_t alert, gpointer user_data);
+gboolean btd_adapter_enable_rssi_monitor(struct btd_adapter *adapter,
+					bdaddr_t *bdaddr, int8_t low,
+					int high, rssi_monitor cb,
+					gpointer user_data);
-- 
1.7.6

