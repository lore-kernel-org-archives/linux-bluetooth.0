Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH] adapter: add API to get the current list of devices
Date: Thu, 30 Aug 2012 15:02:57 +0300
Message-ID: <1346328177-12068-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

This allows internal components to traverse the existing device list.
---
 src/adapter.c |    5 +++++
 src/adapter.h |    2 ++
 2 files changed, 7 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 50779fd..42ecae9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3479,6 +3479,11 @@ void adapter_bonding_complete(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	}
 }
 
+GSList *adapter_get_devices(struct btd_adapter *adapter)
+{
+	return adapter->devices;
+}
+
 int btd_adapter_read_local_oob_data(struct btd_adapter *adapter)
 {
 	return mgmt_read_local_oob_data(adapter->dev_id);
diff --git a/src/adapter.h b/src/adapter.h
index 5a0247e..4cda9c8 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -232,3 +232,5 @@ int btd_adapter_gatt_server_start(struct btd_adapter *adapter);
 void btd_adapter_gatt_server_stop(struct btd_adapter *adapter);
 
 int btd_adapter_ssp_enabled(struct btd_adapter *adapter);
+
+GSList *adapter_get_devices(struct btd_adapter *adapter);
-- 
1.7.9.5

