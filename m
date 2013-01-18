Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] Adapter: Add workaround for device pairing kernel bug
Date: Fri, 18 Jan 2013 12:51:35 +0100
Message-ID: <1358509895-7460-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1358509895-7460-1-git-send-email-szymon.janc@tieto.com>
References: <1358509895-7460-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some kernels reply to device pairing command with bogus command status
instead of command complete event if adapter was not powered.

Command status event doesn't provide remote device address and type
needed to properly complete bonding request.

Pass possibly missing data as user_data to mgmt_send and use it in
pair_device_complete function if needed.
---
 src/adapter.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1a5b1ad..c413242 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4643,17 +4643,40 @@ static void adapter_bonding_complete(struct btd_adapter *adapter,
 	check_oob_bonding_complete(adapter, bdaddr, status);
 }
 
+struct pair_device_data {
+	struct btd_adapter *adapter;
+	bdaddr_t bdaddr;
+	uint8_t addr_type;
+};
+
+static void free_pair_device_data(void *user_data)
+{
+	struct pair_device_data *data = user_data;
+
+	g_free(data);
+}
+
 static void pair_device_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_rp_pair_device *rp = param;
-	struct btd_adapter *adapter = user_data;
+	struct pair_device_data *data = user_data;
 
 	DBG("%s (0x%02x)", mgmt_errstr(status), status);
 
+	/*
+	 * Workaround for a kernel bug
+	 *
+	 * Broken kernels may reply to device pairing command with command
+	 * status instead of command complete event e.g. if adapter was not
+	 * powered.
+	 */
 	if (status != MGMT_STATUS_SUCCESS && length < sizeof(*rp)) {
 		error("Pair device failed: %s (0x%02x)",
 						mgmt_errstr(status), status);
+
+		adapter_bonding_complete(data->adapter, &data->bdaddr,
+						data->addr_type, status);
 		return;
 	}
 
@@ -4662,7 +4685,7 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 		return;
 	}
 
-	adapter_bonding_complete(adapter, &rp->addr.bdaddr, rp->addr.type,
+	adapter_bonding_complete(data->adapter, &rp->addr.bdaddr, rp->addr.type,
 								status);
 }
 
@@ -4671,6 +4694,7 @@ int adapter_create_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 {
 	struct mgmt_cp_pair_device cp;
 	char addr[18];
+	struct pair_device_data *data;
 
 	suspend_discovery(adapter);
 
@@ -4683,13 +4707,21 @@ int adapter_create_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 	cp.addr.type = addr_type;
 	cp.io_cap = io_cap;
 
+	data = g_new0(struct pair_device_data, 1);
+	data->adapter = adapter;
+	bacpy(&data->bdaddr, bdaddr);
+	data->addr_type = addr_type;
+
 	if (mgmt_send(adapter->mgmt, MGMT_OP_PAIR_DEVICE,
 				adapter->dev_id, sizeof(cp), &cp,
-				pair_device_complete, adapter, NULL) > 0)
+				pair_device_complete, data,
+				free_pair_device_data) > 0)
 		return 0;
 
 	error("Failed to pair %s for hci%u", addr, adapter->dev_id);
 
+	free_pair_device_data(data);
+
 	return -EIO;
 }
 
-- 
1.8.0.3

