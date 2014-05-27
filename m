Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <marcel@holtmann.org>, Andrzej Kaczmarek
	<andrzej.kaczmarek@tieto.com>
Subject: [PATCH 6/9] core: Read max TX power when device connected
Date: Tue, 27 May 2014 09:52:48 +0200
Message-ID: <1401177171-19994-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds proper support for max TX power, i.e. this property
is refreshed once device is connected.
---
 src/adapter.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index f5f8c8c..585f2e2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6174,6 +6174,54 @@ static void disconnected_callback(uint16_t index, uint16_t length,
 	dev_disconnected(adapter, &ev->addr, reason);
 }
 
+static void read_max_tx_power_destroy(void *data)
+{
+	struct btd_device *device = data;
+
+	btd_device_unref(device);
+}
+
+static void read_max_tx_power_rsp(uint8_t status, uint16_t len,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_get_conn_info *rp = param;
+	struct btd_device *device = user_data;
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
+	device_set_conn_max_tx_power(device, rp->max_tx_power);
+}
+
+static void read_max_tx_power(struct btd_adapter *adapter,
+					struct btd_device *device,
+					const bdaddr_t *addr, uint8_t addr_type)
+{
+	struct mgmt_cp_get_conn_info cp;
+	char addrstr[18];
+
+	ba2str(addr, addrstr);
+	DBG("bdaddr %s type %d", addrstr, addr_type);
+
+	btd_device_ref(device);
+
+	memset(&cp, 0, sizeof(cp));
+	bacpy(&cp.addr.bdaddr, addr);
+	cp.addr.type = addr_type;
+
+	mgmt_send(adapter->mgmt, MGMT_OP_GET_CONN_INFO, adapter->dev_id,
+					sizeof(cp), &cp, read_max_tx_power_rsp,
+					device, read_max_tx_power_destroy);
+}
+
 static void connected_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -6220,6 +6268,8 @@ static void connected_callback(uint16_t index, uint16_t length,
 		btd_device_device_set_name(device, eir_data.name);
 	}
 
+	read_max_tx_power(adapter, device, &ev->addr.bdaddr, ev->addr.type);
+
 	eir_data_free(&eir_data);
 }
 
-- 
1.9.3
