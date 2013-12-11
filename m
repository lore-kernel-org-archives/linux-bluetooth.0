Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/9] android/bluetooth: Add support for remote device RSSI
Date: Wed, 11 Dec 2013 11:31:24 +0100
Message-Id: <1386757887-29018-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
References: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to cache remote device RSSI and get it with get property
command.
---
 android/bluetooth.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 0515468..254ccb4 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -97,6 +97,7 @@ struct device {
 	char *name;
 	char *friendly_name;
 	uint32_t class;
+	int32_t rssi;
 };
 
 struct browse_req {
@@ -822,6 +823,8 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 	}
 
 	if (rssi) {
+		dev->rssi = rssi;
+
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_RSSI,
 							sizeof(rssi), &rssi);
 		(*num_prop)++;
@@ -2306,11 +2309,13 @@ static uint8_t get_device_friendly_name(struct device *dev)
 
 static uint8_t get_device_rssi(struct device *dev)
 {
-	DBG("Not implemented");
+	if (!dev->rssi)
+		return HAL_STATUS_FAILED;
 
-	/* TODO */
+	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_RSSI,
+						sizeof(dev->rssi), &dev->rssi);
 
-	return HAL_STATUS_FAILED;
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t get_device_version_info(struct device *dev)
-- 
1.8.3.2

