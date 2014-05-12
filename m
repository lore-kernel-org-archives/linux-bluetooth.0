Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/gatt: Refresh device cache on disconnect if not bonded
Date: Mon, 12 May 2014 16:38:13 +0200
Message-Id: <1399905493-10699-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1399905493-10699-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399905493-10699-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds refreshing of device cache in case if device is not bonded.

It affects on TC_GAD_CL_BV_01_C, TC_GAD_CL_BV_02_C and search services
PTS test cases. With this patch those PTS tests cases pass.
---
 android/gatt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 157ebe6..1c94713 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -570,6 +570,10 @@ static void connection_cleanup(struct gatt_device *device)
 			bt_le_discovery_stop(NULL);
 	}
 
+	/* If device is not bonded service cache should be refreshed */
+	if (!bt_device_is_bonded(&device->bdaddr))
+		queue_remove_all(device->services, NULL, NULL, destroy_service);
+
 	device_set_state(device, DEVICE_DISCONNECTED);
 }
 
-- 
1.9.2

