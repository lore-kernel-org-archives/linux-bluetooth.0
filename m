Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 4/8] android/client: Add AVRCP get_player_app_values_text_cb support
Date: Fri, 14 Mar 2014 11:16:43 +0200
Message-Id: <1394788607-29075-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394788607-29075-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394788607-29075-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-rc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index df172d3..cb3280d 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -68,6 +68,13 @@ static void get_play_status_cb(void)
 	haltest_info("%s\n", __func__);
 }
 
+static void get_player_app_values_text_cb(uint8_t attr_id, uint8_t num_val,
+								uint8_t *p_vals)
+{
+	haltest_info("%s, attr_id=%d num_val=%d values=%u\n", __func__,
+						attr_id, num_val, p_vals);
+}
+
 static void set_player_app_value_cb(btrc_player_settings_t *p_vals)
 {
 	haltest_info("%s, settings=%u\n", __func__, p_vals);
@@ -102,6 +109,7 @@ static btrc_callbacks_t rc_cbacks = {
 	.size = sizeof(rc_cbacks),
 	.remote_features_cb = remote_features_cb,
 	.get_play_status_cb = get_play_status_cb,
+	.get_player_app_values_text_cb = get_player_app_values_text_cb,
 	.set_player_app_value_cb = set_player_app_value_cb,
 	.get_element_attr_cb = get_element_attr_cb,
 	.register_notification_cb = register_notification_cb,
-- 
1.8.3.2

