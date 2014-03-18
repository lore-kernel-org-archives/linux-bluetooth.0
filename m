Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 4/8] android/client: Add AVRCP get_player_app_values_text_cb support
Date: Tue, 18 Mar 2014 15:29:55 +0200
Message-Id: <1395149399-27531-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1395149399-27531-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1395149399-27531-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-rc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index dec815c..03fad8f 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -68,6 +68,13 @@ static void get_play_status_cb(void)
 	haltest_info("%s\n", __func__);
 }
 
+static void get_player_app_values_text_cb(uint8_t attr_id, uint8_t num_val,
+								uint8_t *p_vals)
+{
+	haltest_info("%s, attr_id=%d num_val=%d values=%p\n", __func__,
+						attr_id, num_val, p_vals);
+}
+
 static void set_player_app_value_cb(btrc_player_settings_t *p_vals)
 {
 	int i;
@@ -108,6 +115,7 @@ static btrc_callbacks_t rc_cbacks = {
 	.size = sizeof(rc_cbacks),
 	.remote_features_cb = remote_features_cb,
 	.get_play_status_cb = get_play_status_cb,
+	.get_player_app_values_text_cb = get_player_app_values_text_cb,
 	.set_player_app_value_cb = set_player_app_value_cb,
 	.get_element_attr_cb = get_element_attr_cb,
 	.register_notification_cb = register_notification_cb,
-- 
1.8.3.2

