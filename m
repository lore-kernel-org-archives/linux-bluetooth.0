Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 2/6] android/bluetooth: Add API to add device to auto connect list
Date: Fri,  1 Aug 2014 15:31:21 +0200
Message-Id: <1406899885-5338-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1406899885-5338-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1406899885-5338-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 31 +++++++++++++++++++++++++++++++
 android/bluetooth.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index a71e192..a40c3a6 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1489,6 +1489,37 @@ bool bt_device_set_uuids(const bdaddr_t *addr, GSList *uuids)
 	return true;
 }
 
+bool bt_auto_connect_add(const bdaddr_t *addr)
+{
+	struct mgmt_cp_add_device cp;
+	struct device *dev;
+
+	if (!main_opts.kernel_conn_control)
+		return false;
+
+	dev = find_device(addr);
+	if (!dev)
+		return false;
+
+	if (dev->bdaddr_type == BDADDR_BREDR) {
+		DBG("auto-connection feature is not available for BR/EDR");
+		return false;
+	}
+
+	memset(&cp, 0, sizeof(cp));
+	bacpy(&cp.addr.bdaddr, addr);
+	cp.addr.type = dev->bdaddr_type;
+	cp.action = 0x02;
+
+	if (mgmt_send(mgmt_if, MGMT_OP_ADD_DEVICE, adapter.index, sizeof(cp),
+						&cp, NULL, NULL, NULL) > 0)
+		return true;
+
+	error("Failed to add device");
+
+	return false;
+}
+
 static bool rssi_above_threshold(int old, int new)
 {
 	/* only 8 dBm or more */
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 600526d..9b83baa 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -85,3 +85,5 @@ void bt_store_gatt_ccc(const bdaddr_t *addr, uint16_t value);
 uint16_t bt_get_gatt_ccc(const bdaddr_t *addr);
 
 const bdaddr_t *bt_get_id_addr(const bdaddr_t *addr, uint8_t *type);
+
+bool bt_auto_connect_add(const bdaddr_t *addr);
-- 
1.8.4

