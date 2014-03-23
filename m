Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/3] android/gatt: Restart scan after connection
Date: Sun, 23 Mar 2014 21:20:09 +0100
Message-ID: <1395606010-19807-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395606010-19807-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395606010-19807-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch we make sure that scan is restarted if it was holded for
connection purpose.
---
 android/gatt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 775adec..5384a72 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -481,6 +481,12 @@ reply:
 	/* If connection did not succeed, destroy device */
 	if (status)
 		destroy_device(dev);
+
+	/* Check if we should restart scan */
+	if (scanning)
+		bt_le_discovery_start(le_device_found_handler);
+
+	/*FIXME: What to do if discovery won't start here. */
 }
 
 static int connect_le(struct gatt_device *dev)
-- 
1.8.4

