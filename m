Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 04/12] android/bluetooth: Expose API to get CSRK for device
Date: Thu, 22 May 2014 10:07:34 +0200
Message-Id: <1400746062-24766-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400746062-24766-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400746062-24766-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT will take CSRK key and sign counter each time it needs it to sign
att package or to verify att package
---
 android/bluetooth.c | 31 +++++++++++++++++++++++++++++++
 android/bluetooth.h |  8 ++++++++
 2 files changed, 39 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 379d8ea..2ef7846 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -116,6 +116,14 @@ struct device {
 
 	bool found; /* if device is found in current discovery session */
 	unsigned int confirm_id; /* mgtm command id if command pending */
+
+	bool valid_remote_csrk;
+	uint8_t remote_csrk[16];
+	uint32_t remote_sign_cnt;
+
+	bool valid_local_csrk;
+	uint8_t local_csrk[16];
+	uint32_t local_sign_cnt;
 };
 
 struct browse_req {
@@ -3199,6 +3207,29 @@ bool bt_read_device_rssi(const bdaddr_t *addr, bt_read_device_rssi_done cb,
 	return true;
 }
 
+bool bt_get_csrk(const bdaddr_t *addr, enum bt_csrk_type type, uint8_t key[16],
+							uint32_t *sign_cnt)
+{
+	struct device *dev;
+	bool local = (type == LOCAL_CSRK);
+
+	dev = find_device(addr);
+	if (!dev)
+		return false;
+
+	if (local && dev->valid_local_csrk) {
+		memcpy(key, dev->local_csrk, 16);
+		*sign_cnt = dev->local_sign_cnt;
+	} else if (!local && dev->valid_remote_csrk) {
+		memcpy(key, dev->remote_csrk, 16);
+		*sign_cnt = dev->remote_sign_cnt;
+	} else {
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
index 6a3e766..35a5b52 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -21,6 +21,11 @@
  *
  */
 
+enum bt_csrk_type {
+	LOCAL_CSRK,
+	REMOTE_CSRK,
+};
+
 typedef void (*bt_bluetooth_ready)(int err, const bdaddr_t *addr);
 bool bt_bluetooth_start(int index, bool mgmt_dbg, bt_bluetooth_ready cb);
 
@@ -55,3 +60,6 @@ typedef void (*bt_read_device_rssi_done)(uint8_t status, const bdaddr_t *addr,
 						int8_t rssi, void *user_data);
 bool bt_read_device_rssi(const bdaddr_t *addr, bt_read_device_rssi_done cb,
 							void *user_data);
+
+bool bt_get_csrk(const bdaddr_t *addr, enum bt_csrk_type type,
+					uint8_t key[16], uint32_t *sign_cnt);
-- 
1.8.4

