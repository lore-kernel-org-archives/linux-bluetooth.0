Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 3/6] android/bluetooth: Add API to remove device from auto connect list
Date: Fri,  1 Aug 2014 15:31:22 +0200
Message-Id: <1406899885-5338-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1406899885-5338-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1406899885-5338-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 28 ++++++++++++++++++++++++++++
 android/bluetooth.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index a40c3a6..77ccd27 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1520,6 +1520,34 @@ bool bt_auto_connect_add(const bdaddr_t *addr)
 	return false;
 }
 
+void bt_auto_connect_remove(const bdaddr_t *addr)
+{
+	struct mgmt_cp_remove_device cp;
+	struct device *dev;
+
+	if (!main_opts.kernel_conn_control)
+		return;
+
+	dev = find_device(addr);
+	if (!dev)
+		return;
+
+	if (dev->bdaddr_type == BDADDR_BREDR) {
+		DBG("auto-connection feature is not available for BR/EDR");
+		return;
+	}
+
+	memset(&cp, 0, sizeof(cp));
+	bacpy(&cp.addr.bdaddr, addr);
+	cp.addr.type = dev->bdaddr_type;
+
+	if (mgmt_send(mgmt_if, MGMT_OP_REMOVE_DEVICE, adapter.index,
+					sizeof(cp), &cp, NULL, NULL, NULL) > 0)
+		return;
+
+	error("Failed to remove device");
+}
+
 static bool rssi_above_threshold(int old, int new)
 {
 	/* only 8 dBm or more */
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 9b83baa..d767a89 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -87,3 +87,5 @@ uint16_t bt_get_gatt_ccc(const bdaddr_t *addr);
 const bdaddr_t *bt_get_id_addr(const bdaddr_t *addr, uint8_t *type);
 
 bool bt_auto_connect_add(const bdaddr_t *addr);
+
+void bt_auto_connect_remove(const bdaddr_t *addr);
-- 
1.8.4

