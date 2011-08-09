Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 05/14] Add disable for RSSI threshold monitor
Date: Tue,  9 Aug 2011 18:00:32 -0300
Message-Id: <1312923641-12028-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   20 ++++++++++++++++++++
 src/adapter.h |    2 ++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 08675a1..aa65135 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3666,3 +3666,23 @@ gboolean btd_adapter_enable_rssi_monitor(struct btd_adapter *adapter,
 
 	return TRUE;
 }
+
+gboolean btd_adapter_disable_rssi_monitor(struct btd_adapter *adapter,
+							bdaddr_t *bdaddr)
+{
+	struct rssi_monitor_data *monitor;
+	GSList *l;
+
+	l = g_slist_find_custom(adapter->rssi_monitors, bdaddr,
+						rssi_monitor_bacmp);
+	if (!l)
+		return FALSE;
+
+	monitor = l->data;
+
+	adapter->rssi_monitors = g_slist_remove(adapter->rssi_monitors,
+								monitor);
+	g_free(monitor);
+
+	return TRUE;
+}
diff --git a/src/adapter.h b/src/adapter.h
index ca53152..66949e7 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -285,3 +285,5 @@ gboolean btd_adapter_enable_rssi_monitor(struct btd_adapter *adapter,
 					bdaddr_t *bdaddr, int8_t low,
 					int high, rssi_monitor cb,
 					gpointer user_data);
+gboolean btd_adapter_disable_rssi_monitor(struct btd_adapter *adapter,
+							bdaddr_t *bdaddr);
-- 
1.7.6

