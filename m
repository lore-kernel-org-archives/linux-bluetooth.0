Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH 2/3] adapter: implement API to read Tx power
Date: Sun, 11 Mar 2012 11:23:18 +0200
Message-Id: <1331457799-26506-3-git-send-email-arik@wizery.com>
In-Reply-To: <1331457799-26506-1-git-send-email-arik@wizery.com>
References: <1331457799-26506-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A caller wishing to read Tx power registers a one time callback function.
This function is called when a Tx-power-read operation completes
successfully.

We do not introduce facilities to unregister the callback (in case
the caller exits) since the read operation is close to immediate.
---
 plugins/mgmtops.c |    3 ++
 src/adapter.c     |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h     |   11 ++++++++
 3 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 317df24..7753989 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1259,6 +1259,9 @@ static void read_tx_power_complete(int sk, uint16_t index, void *buf,
 		DBG("Adapter not found");
 		return;
 	}
+
+	adapter_tx_power_read_complete(adapter, rp->status, &rp->addr.bdaddr,
+				       rp->level);
 }
 
 static void read_local_oob_data_complete(int sk, uint16_t index, void *buf,
diff --git a/src/adapter.c b/src/adapter.c
index b3ee9d7..0909b33 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -106,6 +106,12 @@ struct service_auth {
 	struct btd_adapter *adapter;
 };
 
+struct tx_power_read_data {
+	adapter_tx_power_read_cb cb;
+	bdaddr_t bdaddr;
+	gpointer user_data;
+};
+
 struct btd_adapter {
 	uint16_t dev_id;
 	gboolean up;
@@ -153,6 +159,8 @@ struct btd_adapter {
 	GSList *pin_callbacks;
 
 	GSList *loaded_drivers;
+
+	GSList *txpower_callbacks;
 };
 
 static void dev_info_free(void *data)
@@ -2521,6 +2529,7 @@ void adapter_remove(struct btd_adapter *adapter)
 		btd_adapter_gatt_server_stop(adapter);
 
 	g_slist_free(adapter->pin_callbacks);
+	g_slist_free(adapter->txpower_callbacks);
 
 	/* Return adapter to down state if it was not up on init */
 	adapter_ops->restore_powered(adapter->dev_id);
@@ -3594,3 +3603,69 @@ struct btd_device *adapter_get_device_by_path(struct btd_adapter *adapter,
 
 	return l->data;
 }
+
+int adapter_read_tx_power(struct btd_adapter *adapter,
+			  struct btd_device *device,
+			  uint8_t type, adapter_tx_power_read_cb cb,
+			  gpointer user_data)
+{
+	struct tx_power_read_data *data;
+	bdaddr_t addr;
+	addr_type_t addr_type;
+	int ret;
+
+	if (!adapter_ops->read_tx_power)
+		return -ENOTSUP;
+
+	device_get_address(device, &addr, &addr_type);
+
+	ret = adapter_ops->read_tx_power(adapter->dev_id, &addr, addr_type,
+					 type);
+	if (ret)
+		return ret;
+
+	data = g_new0(struct tx_power_read_data, 1);
+	bacpy(&data->bdaddr, &addr);
+	data->cb = cb;
+	data->user_data = user_data;
+
+	adapter->txpower_callbacks =
+		g_slist_prepend(adapter->txpower_callbacks, data);
+
+	return 0;
+}
+
+void adapter_tx_power_read_complete(struct btd_adapter *adapter,
+				    uint8_t status, bdaddr_t *bdaddr,
+				    int8_t level)
+{
+	GSList *l;
+	struct tx_power_read_data *data = NULL;
+	struct btd_device *device;
+	char addr[18];
+
+	for (l = adapter->txpower_callbacks; l != NULL; l = g_slist_next(l)) {
+		data = l->data;
+		if (bacmp(&data->bdaddr, bdaddr) == 0)
+			break;
+	}
+
+	/* callback not found */
+	if (!l)
+		return;
+
+	/* don't call the cb if we failed, just remove it */
+	if (status)
+		goto out;
+
+	ba2str(bdaddr, addr);
+	device = adapter_find_device(adapter, addr);
+	if (!device)
+		goto out;
+
+	data->cb(adapter, device, level, data->user_data);
+out:
+	adapter->txpower_callbacks =
+		g_slist_remove(adapter->txpower_callbacks, data);
+	g_free(data);
+}
diff --git a/src/adapter.h b/src/adapter.h
index 1407c18..18e102d 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -150,6 +150,17 @@ void btd_adapter_unref(struct btd_adapter *adapter);
 int btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
 							uint8_t minor);
 
+typedef void (*adapter_tx_power_read_cb) (struct btd_adapter *adapter,
+					  struct btd_device *dev, int8_t level,
+					  gpointer user_data);
+int adapter_read_tx_power(struct btd_adapter *adapter,
+			  struct btd_device *device,
+			  uint8_t type, adapter_tx_power_read_cb cb,
+			  gpointer user_data);
+void adapter_tx_power_read_complete(struct btd_adapter *adatper,
+				    uint8_t status, bdaddr_t *bdaddr,
+				    int8_t level);
+
 struct btd_adapter_driver {
 	const char *name;
 	int (*probe) (struct btd_adapter *adapter);
-- 
1.7.5.4

