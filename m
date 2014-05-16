Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 3/4] android/bluetooth: Add support to read connection RSSI
Date: Fri, 16 May 2014 20:22:48 +0200
Message-Id: <1400264569-7936-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400264569-7936-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400264569-7936-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/bluetooth.h |  5 +++++
 2 files changed, 61 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 1e760d4..e1dc965 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3033,6 +3033,62 @@ bool bt_le_discovery_start(bt_le_device_found cb)
 	return false;
 }
 
+struct read_rssi_user_data {
+	bt_read_device_rssi_done cb;
+	void *user_data;
+};
+
+static void read_device_rssi_cb(uint8_t status, uint16_t length,
+			const void *param, void *user_data)
+{
+	const struct mgmt_rp_get_conn_info *rp = param;
+	struct read_rssi_user_data *data = user_data;
+
+	DBG("");
+
+	if (status)
+		error("Failed to get conn info: %s (0x%02x))",
+						mgmt_errstr(status), status);
+
+	if (length < sizeof(*rp)) {
+		error("Wrong size of get conn info response");
+		return;
+	}
+
+	data->cb(status, &rp->addr.bdaddr, rp->rssi, data->user_data);
+}
+
+bool bt_read_device_rssi(const bdaddr_t *addr, bt_read_device_rssi_done cb,
+							void *user_data)
+{
+	struct device *dev;
+	struct read_rssi_user_data *data;
+	struct mgmt_cp_get_conn_info cp;
+
+	dev = find_device(addr);
+	if (!dev)
+		return false;
+
+	memcpy(&cp.addr.bdaddr, addr, sizeof(cp.addr.bdaddr));
+	cp.addr.type = dev->bredr ? BDADDR_BREDR : dev->bdaddr_type;
+
+	data = new0(struct read_rssi_user_data, 1);
+	if (!data)
+		return false;
+
+	data->cb = cb;
+	data->user_data = user_data;
+
+	if (!mgmt_send(mgmt_if, MGMT_OP_GET_CONN_INFO, adapter.index,
+			sizeof(cp), &cp, read_device_rssi_cb, data, free)) {
+		free(data);
+		error("Failed to get conn info");
+		return false;
+	}
+
+	return true;
+}
+
 static uint8_t set_adapter_scan_mode(const void *buf, uint16_t len)
 {
 	const uint8_t *mode = buf;
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 3eef7a4..6a3e766 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -50,3 +50,8 @@ bool bt_le_set_advertising(bool advertising, bt_le_set_advertising_done cb,
 uint8_t bt_get_device_android_type(const bdaddr_t *addr);
 const char *bt_get_adapter_name(void);
 bool bt_device_is_bonded(const bdaddr_t *bdaddr);
+
+typedef void (*bt_read_device_rssi_done)(uint8_t status, const bdaddr_t *addr,
+						int8_t rssi, void *user_data);
+bool bt_read_device_rssi(const bdaddr_t *addr, bt_read_device_rssi_done cb,
+							void *user_data);
-- 
1.9.3

