Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] src/adapter: Added connection parameter load/store functions
Date: Wed, 15 Feb 2017 18:18:22 +0000
Message-Id: <20170215181824.9041-3-eu@felipetonello.com>
In-Reply-To: <20170215181824.9041-1-eu@felipetonello.com>
References: <20170215181824.9041-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is interesting to let other parts of bluetoothd to access these
functions since there are few different use-cases where this updating
and loading connection parameters can happen.
---
 src/adapter.c | 24 ++++++++++++++++++++++--
 src/adapter.h |  9 +++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3dac7d6490d6..be22c6b1b046 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3609,6 +3609,26 @@ static void load_conn_params(struct btd_adapter *adapter, GSList *params)
 		btd_error(adapter->dev_id, "Load connection parameters failed");
 }
 
+void adapter_load_conn_params(struct btd_adapter *adapter, const bdaddr_t *peer,
+				uint8_t bdaddr_type, uint16_t min_interval,
+				uint16_t max_interval, uint16_t latency,
+				uint16_t timeout)
+{
+	GSList *params = NULL;
+	struct conn_param param;
+
+	bacpy(&param.bdaddr, peer);
+	param.bdaddr_type = bdaddr_type;
+	param.max_interval = max_interval;
+	param.min_interval = min_interval;
+	param.latency = latency;
+	param.timeout = timeout;
+
+	params = g_slist_append(params, &param);
+	load_conn_params(adapter, params);
+	g_slist_free(params);
+}
+
 static uint8_t get_le_addr_type(GKeyFile *keyfile)
 {
 	uint8_t addr_type;
@@ -7251,7 +7271,7 @@ static void new_irk_callback(uint16_t index, uint16_t length,
 	btd_device_set_temporary(device, false);
 }
 
-static void store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
+void adapter_store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
 				uint8_t bdaddr_type, uint16_t min_interval,
 				uint16_t max_interval, uint16_t latency,
 				uint16_t timeout)
@@ -7325,7 +7345,7 @@ static void new_conn_param(uint16_t index, uint16_t length,
 	if (!ev->store_hint)
 		return;
 
-	store_conn_param(adapter, &ev->addr.bdaddr, ev->addr.type,
+	adapter_store_conn_param(adapter, &ev->addr.bdaddr, ev->addr.type,
 					ev->min_interval, ev->max_interval,
 					ev->latency, ev->timeout);
 }
diff --git a/src/adapter.h b/src/adapter.h
index f9178d59e74a..a7cb87213635 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -227,3 +227,12 @@ void btd_adapter_for_each_device(struct btd_adapter *adapter,
 
 bool btd_le_connect_before_pairing(void);
 
+void adapter_load_conn_params(struct btd_adapter *adapter, const bdaddr_t *peer,
+				uint8_t bdaddr_type, uint16_t min_interval,
+				uint16_t max_interval, uint16_t latency,
+				uint16_t timeout);
+
+void adapter_store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
+			uint8_t bdaddr_type, uint16_t min_interval,
+			uint16_t max_interval, uint16_t latency,
+			uint16_t timeout);
-- 
2.11.1

