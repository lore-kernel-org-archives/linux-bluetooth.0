Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 4/8] Return FALSE if RSSI monitor is already enabled
Date: Tue,  2 Aug 2011 18:37:36 -0300
Message-Id: <1312321060-19283-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312321060-19283-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312321060-19283-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 37ed727..08675a1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -105,6 +105,7 @@ struct service_auth {
 };
 
 struct rssi_monitor_data {
+	bdaddr_t bdaddr;
 	rssi_monitor cb;
 	gpointer user_data;
 };
@@ -3634,6 +3635,14 @@ int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 	return adapter_ops->remove_remote_oob_data(adapter->dev_id, bdaddr);
 }
 
+static int rssi_monitor_bacmp(gconstpointer data, gconstpointer user_data)
+{
+	const struct rssi_monitor_data *monitor = data;
+	const bdaddr_t *bdaddr = user_data;
+
+	return bacmp(&monitor->bdaddr, bdaddr);
+}
+
 gboolean btd_adapter_enable_rssi_monitor(struct btd_adapter *adapter,
 					bdaddr_t *bdaddr, int8_t low,
 					int high, rssi_monitor cb,
@@ -3641,10 +3650,15 @@ gboolean btd_adapter_enable_rssi_monitor(struct btd_adapter *adapter,
 {
 	struct rssi_monitor_data *monitor;
 
+	if (g_slist_find_custom(adapter->rssi_monitors, bdaddr,
+						rssi_monitor_bacmp))
+		return FALSE;
+
 	monitor = g_try_new(struct rssi_monitor_data, 1);
 	if (monitor == NULL)
 		return FALSE;
 
+	bacpy(&monitor->bdaddr, bdaddr);
 	monitor->cb = cb;
 	monitor->user_data = user_data;
 
-- 
1.7.6

