Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 2/6] android/bluetooth: Add API to add device to auto connect list
Date: Mon,  4 Aug 2014 12:34:15 +0200
Message-Id: <1407148459-20125-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1407148459-20125-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1407148459-20125-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 31 +++++++++++++++++++++++++++++++
 android/bluetooth.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index aaba585..a4a77c8 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1496,6 +1496,37 @@ bool bt_kernel_conn_control(void)
 	return kernel_conn_control;
 }
 
+bool bt_auto_connect_add(const bdaddr_t *addr)
+{
+	struct mgmt_cp_add_device cp;
+	struct device *dev;
+
+	if (!kernel_conn_control)
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
index adad6c4..4a7063d 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -81,3 +81,5 @@ uint16_t bt_get_gatt_ccc(const bdaddr_t *addr);
 const bdaddr_t *bt_get_id_addr(const bdaddr_t *addr, uint8_t *type);
 
 bool bt_kernel_conn_control(void);
+
+bool bt_auto_connect_add(const bdaddr_t *addr);
-- 
1.8.4

