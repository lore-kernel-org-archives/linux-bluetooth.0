Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] android: Fix non-ANSI function declaration
Date: Tue,  1 Jul 2014 15:50:41 +0300
Message-Id: <1404219043-4216-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1404219043-4216-1-git-send-email-luiz.dentz@gmail.com>
References: <1404219043-4216-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/gatt.c      | 2 +-
 android/hal-a2dp.c  | 4 ++--
 android/hal-avrcp.c | 4 ++--
 android/hal-pan.c   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 9c2b5dc..677a337 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -415,7 +415,7 @@ static struct gatt_device *find_device_by_addr(const bdaddr_t *addr)
 	return queue_find(gatt_devices, match_device_by_bdaddr, addr);
 }
 
-static struct gatt_device *find_pending_device()
+static struct gatt_device *find_pending_device(void)
 {
 	return queue_find(gatt_devices, match_pending_device, NULL);
 }
diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
index 7d3a651..99cd147 100644
--- a/android/hal-a2dp.c
+++ b/android/hal-a2dp.c
@@ -118,7 +118,7 @@ static bt_status_t init(btav_callbacks_t *callbacks)
 	return ret;
 }
 
-static void cleanup()
+static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
 
@@ -145,7 +145,7 @@ static btav_interface_t iface = {
 	.cleanup = cleanup
 };
 
-btav_interface_t *bt_get_a2dp_interface()
+btav_interface_t *bt_get_a2dp_interface(void)
 {
 	return &iface;
 }
diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 51ab7da..761ddfb 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -645,7 +645,7 @@ static bt_status_t set_volume(uint8_t volume)
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
-static void cleanup()
+static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
 
@@ -680,7 +680,7 @@ static btrc_interface_t iface = {
 	.cleanup = cleanup
 };
 
-btrc_interface_t *bt_get_avrcp_interface()
+btrc_interface_t *bt_get_avrcp_interface(void)
 {
 	return &iface;
 }
diff --git a/android/hal-pan.c b/android/hal-pan.c
index 0f71ef6..d9e042a 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -196,7 +196,7 @@ static btpan_interface_t pan_if = {
 	.cleanup = pan_cleanup
 };
 
-btpan_interface_t *bt_get_pan_interface()
+btpan_interface_t *bt_get_pan_interface(void)
 {
 	return &pan_if;
 }
-- 
1.9.3

