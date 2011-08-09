Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 06/14] Add adapter_ops calls for RSSI Enable/Disable
Date: Tue,  9 Aug 2011 18:00:33 -0300
Message-Id: <1312923641-12028-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index aa65135..33ad41f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3649,6 +3649,7 @@ gboolean btd_adapter_enable_rssi_monitor(struct btd_adapter *adapter,
 					gpointer user_data)
 {
 	struct rssi_monitor_data *monitor;
+	int err;
 
 	if (g_slist_find_custom(adapter->rssi_monitors, bdaddr,
 						rssi_monitor_bacmp))
@@ -3658,6 +3659,14 @@ gboolean btd_adapter_enable_rssi_monitor(struct btd_adapter *adapter,
 	if (monitor == NULL)
 		return FALSE;
 
+	err = adapter_ops->enable_rssi_monitor(adapter->dev_id, bdaddr, low,
+									high);
+	if (err < 0) {
+		error("Enable RSSI threshold monitor: %s", strerror(-err));
+		g_free(monitor);
+		return FALSE;
+	}
+
 	bacpy(&monitor->bdaddr, bdaddr);
 	monitor->cb = cb;
 	monitor->user_data = user_data;
@@ -3672,6 +3681,7 @@ gboolean btd_adapter_disable_rssi_monitor(struct btd_adapter *adapter,
 {
 	struct rssi_monitor_data *monitor;
 	GSList *l;
+	int err;
 
 	l = g_slist_find_custom(adapter->rssi_monitors, bdaddr,
 						rssi_monitor_bacmp);
@@ -3684,5 +3694,7 @@ gboolean btd_adapter_disable_rssi_monitor(struct btd_adapter *adapter,
 								monitor);
 	g_free(monitor);
 
-	return TRUE;
+	err = adapter_ops->disable_rssi_monitor(adapter->dev_id, bdaddr);
+
+	return (err < 0 ? FALSE : TRUE);
 }
-- 
1.7.6

