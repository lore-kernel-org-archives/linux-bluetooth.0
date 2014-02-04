Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 3/3] android/bluetooth: Send prop change event only if prop was changed
Date: Tue,  4 Feb 2014 17:34:23 +0100
Message-Id: <1391531663-13143-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391531663-13143-1-git-send-email-szymon.janc@tieto.com>
References: <1391531663-13143-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 3becc45..9f8e7b4 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1118,7 +1118,7 @@ static void update_device(struct device *dev, int8_t rssi,
 	ev->status = HAL_STATUS_SUCCESS;
 	bdaddr2android(&dev->bdaddr, ev->bdaddr);
 
-	if (eir->class) {
+	if (eir->class && dev->class != eir->class) {
 		dev->class = eir->class;
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_CLASS,
 					sizeof(dev->class), &dev->class);
@@ -1132,7 +1132,7 @@ static void update_device(struct device *dev, int8_t rssi,
 		ev->num_props++;
 	}
 
-	if (eir->name) {
+	if (eir->name && strcmp(dev->name, eir->name)) {
 		g_free(dev->name);
 		dev->name = g_strdup(eir->name);
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_NAME,
-- 
1.8.3.2

