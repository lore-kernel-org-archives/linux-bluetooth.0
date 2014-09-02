Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 03/16] android/hidhost: Allow to use cached dev when connecting
Date: Tue,  2 Sep 2014 12:09:48 +0200
Message-Id: <1409652601-28689-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason to not allow connect when there is cached hid device
---
 android/hidhost.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 652baa0..3dc3c25 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -867,12 +867,13 @@ static void bt_hid_connect(const void *buf, uint16_t len)
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
-	if (l) {
-		status = HAL_STATUS_FAILED;
-		goto failed;
-	}
+	if (l)
+		dev = l->data;
+	else
+		dev = hid_device_new(&dst);
 
-	dev = hid_device_new(&dst);
+	if (dev->state != HAL_HIDHOST_STATE_DISCONNECTED)
+		goto done;
 
 	ba2str(&dev->dst, addr);
 	DBG("connecting to %s", addr);
-- 
1.8.4

