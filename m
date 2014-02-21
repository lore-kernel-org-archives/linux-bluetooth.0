Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android/bluetooth: Don't set remote name to empty string
Date: Fri, 21 Feb 2014 17:49:52 +0100
Message-Id: <1393001393-1160-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If remote device has name but it is empty (0 bytes) just ignore it and
continue using address as name. This will avoid sending remote device
property notification with empty name.
---
 android/bluetooth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 31092e3..e225264 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1096,7 +1096,7 @@ static void update_new_device(struct device *dev, int8_t rssi,
 		ev->num_props++;
 	}
 
-	if (eir->name) {
+	if (eir->name && strlen(eir->name)) {
 		g_free(dev->name);
 		dev->name = g_strdup(eir->name);
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_NAME,
@@ -1136,7 +1136,7 @@ static void update_device(struct device *dev, int8_t rssi,
 		ev->num_props++;
 	}
 
-	if (eir->name && strcmp(dev->name, eir->name)) {
+	if (eir->name && strlen(eir->name) && strcmp(dev->name, eir->name)) {
 		g_free(dev->name);
 		dev->name = g_strdup(eir->name);
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_NAME,
-- 
1.8.5.3

