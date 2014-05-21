Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 05/12] android/bluetooth: Expose API to update sign counter
Date: Wed, 21 May 2014 14:44:55 +0200
Message-Id: <1400676302-13626-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400676302-13626-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400676302-13626-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed so GATT can notify GAP that write sign has been done and
sign counter shall be increased as per spec.
---
 android/bluetooth.c | 14 ++++++++++++++
 android/bluetooth.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 6a10e83..201238b 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3229,6 +3229,20 @@ bool bt_get_csrk(const bdaddr_t *addr, bool local, uint8_t key[16],
 	return true;
 }
 
+void bt_update_sign_counter(const bdaddr_t *addr, bool local)
+{
+	struct device *dev;
+
+	dev = find_device(addr);
+	if (!dev)
+		return;
+
+	if (local)
+		dev->local_sign_cnt++;
+	else
+		dev->remote_sign_cnt++;
+}
+
 static uint8_t set_adapter_scan_mode(const void *buf, uint16_t len)
 {
 	const uint8_t *mode = buf;
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 8462770..cc07525 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -58,3 +58,5 @@ bool bt_read_device_rssi(const bdaddr_t *addr, bt_read_device_rssi_done cb,
 
 bool bt_get_csrk(const bdaddr_t *addr, bool local, uint8_t key[16],
 							uint32_t *sign_cnt);
+
+void bt_update_sign_counter(const bdaddr_t *addr, bool local);
-- 
1.8.4

