Return-Path: <cyrus@holtmann.org>
From: Will Wang <wiwang@mozilla.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Will Wang <wiwang@mozilla.com>
Subject: [PATCH v2 2/3] android/hal-handsfree: Fix missing HFP WBS callback
Date: Fri, 28 Aug 2015 18:40:29 +0800
Message-Id: <1440758430-24935-3-git-send-email-wiwang@mozilla.com>
In-Reply-To: <1440758430-24935-1-git-send-email-wiwang@mozilla.com>
References: <1440758430-24935-1-git-send-email-wiwang@mozilla.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-handsfree.c | 12 ++++++++++++
 android/hal-msg.h       |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 279b26a..3847901 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -153,6 +153,16 @@ static void handle_nrec(void *buf, uint16_t len, int fd)
 #endif
 }
 
+static void handle_wbs(void *buf, uint16_t len, int fd)
+{
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	struct hal_ev_handsfree_wbs *ev = buf;
+
+	if (cbs->wbs_cb)
+		cbs->wbs_cb(ev->wbs, (bt_bdaddr_t *) (ev->bdaddr));
+#endif
+}
+
 static void handle_chld(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_handsfree_chld *ev = buf;
@@ -289,6 +299,8 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_HANDSFREE_HSP_KEY_PRESS */
 	{ handle_hsp_key_press, false,
 				sizeof(struct hal_ev_handsfree_hsp_key_press) },
+	/* HAL_EV_HANDSFREE_WBS */
+	{ handle_wbs, false, sizeof(struct hal_ev_handsfree_wbs) },
 };
 
 static uint8_t get_mode(void)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 698f45a..ea79fa7 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1638,6 +1638,12 @@ struct hal_ev_handsfree_hsp_key_press {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+#define HAL_EV_HANDSFREE_WBS		0x91
+struct hal_ev_handsfree_wbs {
+	uint8_t wbs;
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
 #define HAL_AVRCP_FEATURE_NONE			0x00
 #define HAL_AVRCP_FEATURE_METADATA		0x01
 #define HAL_AVRCP_FEATURE_ABSOLUTE_VOLUME	0x02
-- 
1.9.1

