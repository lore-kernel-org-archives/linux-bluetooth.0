Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 3/8] android/client: Add AVRCP set_player_app_value_cb support
Date: Tue, 18 Mar 2014 15:29:54 +0200
Message-Id: <1395149399-27531-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1395149399-27531-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1395149399-27531-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-rc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index f1cdbc5..dec815c 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -68,6 +68,17 @@ static void get_play_status_cb(void)
 	haltest_info("%s\n", __func__);
 }
 
+static void set_player_app_value_cb(btrc_player_settings_t *p_vals)
+{
+	int i;
+
+	haltest_info("%s, num_attr=%u\n", __func__, p_vals->num_attr);
+
+	for (i = 0; i < p_vals->num_attr; i++)
+		haltest_info("attr id=%u, values=%u\n", p_vals->attr_ids[i],
+							p_vals->attr_values[i]);
+}
+
 static void get_element_attr_cb(uint8_t num_attr, btrc_media_attr_t *attrs)
 {
 	uint8_t i;
@@ -97,6 +108,7 @@ static btrc_callbacks_t rc_cbacks = {
 	.size = sizeof(rc_cbacks),
 	.remote_features_cb = remote_features_cb,
 	.get_play_status_cb = get_play_status_cb,
+	.set_player_app_value_cb = set_player_app_value_cb,
 	.get_element_attr_cb = get_element_attr_cb,
 	.register_notification_cb = register_notification_cb,
 	.volume_change_cb = volume_change_cb,
-- 
1.8.3.2

