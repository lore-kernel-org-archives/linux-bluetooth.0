Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <marcel@holtmann.org>, Andrzej Kaczmarek
	<andrzej.kaczmarek@tieto.com>
Subject: [PATCH 9/9] core: Poll for connection info
Date: Tue, 27 May 2014 09:52:51 +0200
Message-ID: <1401177171-19994-10-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds actual polling mechanism for devices which are stored
on list for each adapter.
---
 src/adapter.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 045ce30..c0ebfab 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -183,6 +183,7 @@ struct btd_adapter {
 	guint discovery_idle_timeout;	/* timeout between discovery runs */
 	guint passive_scan_timeout;	/* timeout between passive scans */
 	guint temp_devices_timeout;	/* timeout for temporary devices */
+	guint mon_devices_timeout;
 
 	guint pairable_timeout_id;	/* pairable timeout id */
 	guint auth_idle_id;		/* Pending authorization dequeue */
@@ -4189,6 +4190,11 @@ static void adapter_remove(struct btd_adapter *adapter)
 		adapter->temp_devices_timeout = 0;
 	}
 
+	if (adapter->mon_devices_timeout > 0) {
+		g_source_remove(adapter->mon_devices_timeout);
+		adapter->mon_devices_timeout = 0;
+	}
+
 	discovery_cleanup(adapter);
 
 	g_slist_free(adapter->connect_list);
@@ -5467,6 +5473,73 @@ static void disconnect_complete(uint8_t status, uint16_t length,
 	dev_disconnected(adapter, &rp->addr, MGMT_DEV_DISCONN_LOCAL_HOST);
 }
 
+static void monitor_conn_info_destroy(void *data)
+{
+	struct btd_device *device = data;
+
+	btd_device_unref(device);
+}
+
+static void monitor_conn_info_rsp(uint8_t status, uint16_t len,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_get_conn_info *rp = param;
+	struct btd_device *device = user_data;
+
+	DBG("status %d", status);
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Get Connection Information failed: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		return;
+	}
+
+	if (len < sizeof(*rp)) {
+		error("Too small Get Connection Information response");
+		return;
+	}
+
+	device_set_conn_rssi(device, rp->rssi);
+	device_set_conn_tx_power(device, rp->tx_power);
+}
+
+static void monitor_conn_info(void *data, void *user_data)
+{
+	struct mgmt_addr_info *addr = data;
+	struct btd_adapter *adapter = user_data;
+	struct mgmt_cp_get_conn_info cp;
+	char addrstr[18];
+	struct btd_device *device;
+
+	ba2str(&addr->bdaddr, addrstr);
+	DBG("bdaddr %s type %d", addrstr, addr->type);
+
+	device = btd_adapter_find_device(adapter, &addr->bdaddr, addr->type);
+	if (!device)
+		return;
+
+	btd_device_ref(device);
+
+	memset(&cp, 0, sizeof(cp));
+	bacpy(&cp.addr.bdaddr, &addr->bdaddr);
+	cp.addr.type = addr->type;
+
+	mgmt_send(adapter->mgmt, MGMT_OP_GET_CONN_INFO, adapter->dev_id,
+					sizeof(cp), &cp, monitor_conn_info_rsp,
+					device, monitor_conn_info_destroy);
+}
+
+static gboolean trigger_conn_monitor(gpointer user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	DBG("");
+
+	queue_foreach(adapter->monitored_devices, monitor_conn_info, adapter);
+
+	return TRUE;
+}
+
 struct monitored_device {
 	struct mgmt_addr_info addr;
 };
@@ -5500,6 +5573,10 @@ int btd_adapter_add_monitored_device(struct btd_adapter *adapter,
 		return 0;
 	}
 
+	if (!queue_length(adapter->monitored_devices))
+		adapter->mon_devices_timeout =
+			g_timeout_add(2000, trigger_conn_monitor, adapter);
+
 	queue_push_tail(adapter->monitored_devices, mdev);
 
 	return 0;
@@ -5529,6 +5606,12 @@ int btd_adapter_remove_monitored_device(struct btd_adapter *adapter,
 
 	free(mdev);
 
+	if (!queue_length(adapter->monitored_devices))
+		if (adapter->mon_devices_timeout > 0) {
+			g_source_remove(adapter->mon_devices_timeout);
+			adapter->mon_devices_timeout = 0;
+		}
+
 	return 0;
 }
 
-- 
1.9.3
