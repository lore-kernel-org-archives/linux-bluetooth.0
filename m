Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 05/12] android/bluetooth: Expose API to update sign counter
Date: Thu, 22 May 2014 10:07:35 +0200
Message-Id: <1400746062-24766-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400746062-24766-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400746062-24766-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed so GATT can notify GAP that write sign has been done and
sign counter shall be increased as per spec.
---
 android/bluetooth.c | 14 ++++++++++++++
 android/bluetooth.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 2ef7846..8df4d91 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3230,6 +3230,20 @@ bool bt_get_csrk(const bdaddr_t *addr, enum bt_csrk_type type, uint8_t key[16],
 	return true;
 }
 
+void bt_update_sign_counter(const bdaddr_t *addr, enum bt_csrk_type type)
+{
+	struct device *dev;
+
+	dev = find_device(addr);
+	if (!dev)
+		return;
+
+	if (type == LOCAL_CSRK)
+		dev->local_sign_cnt++;
+	else
+		dev->remote_sign_cnt++;
+}
+
 static uint8_t set_adapter_scan_mode(const void *buf, uint16_t len)
 {
 	const uint8_t *mode = buf;
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 35a5b52..c4fb375 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -63,3 +63,5 @@ bool bt_read_device_rssi(const bdaddr_t *addr, bt_read_device_rssi_done cb,
 
 bool bt_get_csrk(const bdaddr_t *addr, enum bt_csrk_type type,
 					uint8_t key[16], uint32_t *sign_cnt);
+
+void bt_update_sign_counter(const bdaddr_t *addr, enum bt_csrk_type type);
-- 
1.8.4

