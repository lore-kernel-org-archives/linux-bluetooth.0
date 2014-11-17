Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/4] android/client: Add handshake callback
Date: Mon, 17 Nov 2014 15:06:58 +0100
Message-Id: <1416233218-16456-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1416233218-16456-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416233218-16456-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-hh.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/android/client/if-hh.c b/android/client/if-hh.c
index b2bf8ca..25519e5 100644
--- a/android/client/if-hh.c
+++ b/android/client/if-hh.c
@@ -100,6 +100,18 @@ static void virtual_unplug_cb(bt_bdaddr_t *bd_addr, bthh_status_t hh_status)
 						bthh_status_t2str(hh_status));
 }
 
+/* Callback for Android 5.0 handshake api. */
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static void handshake_cb(bt_bdaddr_t *bd_addr, bthh_status_t hh_status)
+{
+	char addr[MAX_ADDR_STR_LEN];
+
+	haltest_info("%s: bd_addr=%s hh_status=%s\n", __func__,
+						bt_bdaddr_t2str(bd_addr, addr),
+						bthh_status_t2str(hh_status));
+}
+#endif
+
 /*
  * Callback for get hid info
  * hid_info will contain attr_mask, sub_class, app_id, vendor_id, product_id,
@@ -163,7 +175,10 @@ static bthh_callbacks_t bthh_callbacks = {
 	.protocol_mode_cb = protocol_mode_cb,
 	.idle_time_cb = idle_time_cb,
 	.get_report_cb = get_report_cb,
-	.virtual_unplug_cb = virtual_unplug_cb
+	.virtual_unplug_cb = virtual_unplug_cb,
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	.handshake_cb = handshake_cb
+#endif
 };
 
 /* init */
-- 
1.9.1

