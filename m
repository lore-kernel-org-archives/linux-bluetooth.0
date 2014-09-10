Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] core: Remove not used device_set_conn_param function
Date: Wed, 10 Sep 2014 22:13:07 +0200
Message-Id: <1410379987-4265-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1410379987-4265-1-git-send-email-szymon.janc@tieto.com>
References: <1410379987-4265-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function is not used since connection parameters are stored from
adapter.c. Also remove no longer needed members from struct btd_device.
---
 src/device.c | 31 -------------------------------
 src/device.h |  3 ---
 2 files changed, 34 deletions(-)

diff --git a/src/device.c b/src/device.c
index d63e627..875a5c5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -223,12 +223,6 @@ struct btd_device {
 	GIOChannel	*att_io;
 	guint		cleanup_id;
 	guint		store_id;
-
-	bool		pending_conn_params;
-	uint16_t	min_interval;
-	uint16_t	max_interval;
-	uint16_t	latency;
-	uint16_t	timeout;
 };
 
 static const uint16_t uuid_list[] = {
@@ -382,18 +376,6 @@ static gboolean store_device_info_cb(gpointer user_data)
 		g_key_file_remove_group(key_file, "DeviceID", NULL);
 	}
 
-	if (device->pending_conn_params) {
-		device->pending_conn_params = false;
-		g_key_file_set_integer(key_file, "ConnectionParameters",
-					"MinInterval", device->min_interval);
-		g_key_file_set_integer(key_file, "ConnectionParameters",
-					"MaxInterval", device->max_interval);
-		g_key_file_set_integer(key_file, "ConnectionParameters",
-					"Latency", device->latency);
-		g_key_file_set_integer(key_file, "ConnectionParameters",
-					"Timeout", device->timeout);
-	}
-
 	create_file(filename, S_IRUSR | S_IWUSR);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
@@ -2554,19 +2536,6 @@ void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type)
 		device->le_seen = time(NULL);
 }
 
-void device_set_conn_param(struct btd_device *dev, uint16_t min_interval,
-				uint16_t max_interval, uint16_t latency,
-				uint16_t timeout)
-{
-	dev->pending_conn_params = true;
-	dev->min_interval = min_interval;
-	dev->max_interval = max_interval;
-	dev->latency = latency;
-	dev->timeout = timeout;
-
-	store_device_info(dev);
-}
-
 /* It is possible that we have two device objects for the same device in
  * case it has first been discovered over BR/EDR and has a private
  * address when discovered over LE for the first time. In such a case we
diff --git a/src/device.h b/src/device.h
index 59db52c..2e0473e 100644
--- a/src/device.h
+++ b/src/device.h
@@ -43,9 +43,6 @@ void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
 void device_set_bredr_support(struct btd_device *device);
 void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type);
 void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type);
-void device_set_conn_param(struct btd_device *dev, uint16_t min_interval,
-				uint16_t max_interval, uint16_t latency,
-				uint16_t timeout);
 void device_merge_duplicate(struct btd_device *dev, struct btd_device *dup);
 uint32_t btd_device_get_class(struct btd_device *device);
 uint16_t btd_device_get_vendor(struct btd_device *device);
-- 
1.9.3

