Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 1/3] android: Add wrapper function for get remote dev properties
Date: Tue, 7 Jan 2014 15:13:48 +0100
Message-ID: <1389104030-21314-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 3cbf68d..f281fcf 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2673,6 +2673,19 @@ static uint8_t get_device_timestamp(struct device *dev)
 	return HAL_STATUS_SUCCESS;
 }
 
+static void get_remote_device_props(struct device *dev)
+{
+	get_device_name(dev);
+	get_device_uuids(dev);
+	get_device_class(dev);
+	get_device_type(dev);
+	get_device_service_rec(dev);
+	get_device_friendly_name(dev);
+	get_device_rssi(dev);
+	get_device_version_info(dev);
+	get_device_timestamp(dev);
+}
+
 static void handle_get_remote_device_props_cmd(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_get_remote_device_props *cmd = buf;
@@ -2688,15 +2701,7 @@ static void handle_get_remote_device_props_cmd(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	get_device_name(l->data);
-	get_device_uuids(l->data);
-	get_device_class(l->data);
-	get_device_type(l->data);
-	get_device_service_rec(l->data);
-	get_device_friendly_name(l->data);
-	get_device_rssi(l->data);
-	get_device_version_info(l->data);
-	get_device_timestamp(l->data);
+	get_remote_device_props(l->data);
 
 	status = HAL_STATUS_SUCCESS;
 
-- 
1.8.4

