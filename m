Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 3/6] android/bluetooth: Add API to remove device from auto connect list
Date: Mon,  4 Aug 2014 12:34:16 +0200
Message-Id: <1407148459-20125-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1407148459-20125-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1407148459-20125-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 28 ++++++++++++++++++++++++++++
 android/bluetooth.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index a4a77c8..34690b7 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1527,6 +1527,34 @@ bool bt_auto_connect_add(const bdaddr_t *addr)
 	return false;
 }
 
+void bt_auto_connect_remove(const bdaddr_t *addr)
+{
+	struct mgmt_cp_remove_device cp;
+	struct device *dev;
+
+	if (!kernel_conn_control)
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
index 4a7063d..ac7f3ad 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -83,3 +83,5 @@ const bdaddr_t *bt_get_id_addr(const bdaddr_t *addr, uint8_t *type);
 bool bt_kernel_conn_control(void);
 
 bool bt_auto_connect_add(const bdaddr_t *addr);
+
+void bt_auto_connect_remove(const bdaddr_t *addr);
-- 
1.8.4

