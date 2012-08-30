Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH] adapter: add API to find an existing device by D-Bus path
Date: Thu, 30 Aug 2012 15:09:02 +0300
Message-ID: <1346328542-13203-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

This allows us to get a btd_device from information passed in D-Bus
method calls or signals.
---
 src/adapter.c |   15 +++++++++++++++
 src/adapter.h |    2 ++
 2 files changed, 17 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 50779fd..6aee982 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3479,6 +3479,21 @@ void adapter_bonding_complete(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	}
 }
 
+struct btd_device *adapter_get_device_by_path(struct btd_adapter *adapter,
+					      const char *path)
+{
+	GSList *l;
+
+	for (l = adapter->devices; l != NULL; l = g_slist_next(l))
+		if (g_strcmp0(device_get_path(l->data), path) == 0)
+			break;
+
+	if (!l)
+		return NULL;
+
+	return l->data;
+}
+
 int btd_adapter_read_local_oob_data(struct btd_adapter *adapter)
 {
 	return mgmt_read_local_oob_data(adapter->dev_id);
diff --git a/src/adapter.h b/src/adapter.h
index 5a0247e..6435dfb 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -232,3 +232,5 @@ int btd_adapter_gatt_server_start(struct btd_adapter *adapter);
 void btd_adapter_gatt_server_stop(struct btd_adapter *adapter);
 
 int btd_adapter_ssp_enabled(struct btd_adapter *adapter);
+struct btd_device *adapter_get_device_by_path(struct btd_adapter *adapter,
+					      const char *path);
-- 
1.7.9.5

