Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 3/3] Code clean-up: remove unnecessary brackets
Date: Thu, 11 Aug 2011 17:59:48 +0300
Message-Id: <1313074788-16317-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1313074788-16317-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1313074788-16317-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 40d2cfd..4d1d458 100644
--- a/src/device.c
+++ b/src/device.c
@@ -946,9 +946,8 @@ struct btd_device *device_create(DBusConnection *conn,
 	if (read_blocked(&src, &device->bdaddr))
 		device_block(conn, device);
 
-	if (read_link_key(&src, &device->bdaddr, NULL, NULL) == 0) {
+	if (read_link_key(&src, &device->bdaddr, NULL, NULL) == 0)
 		device_set_bonded(device, TRUE);
-	}
 
 	return btd_device_ref(device);
 }
-- 
1.7.4.1

