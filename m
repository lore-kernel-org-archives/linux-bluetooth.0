Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 5/8] android/client: Add AVRCP get_player_app_value_cb support
Date: Fri, 14 Mar 2014 11:16:44 +0200
Message-Id: <1394788607-29075-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394788607-29075-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394788607-29075-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-rc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index cb3280d..fb98fe6 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -68,6 +68,12 @@ static void get_play_status_cb(void)
 	haltest_info("%s\n", __func__);
 }
 
+static void get_player_app_value_cb(uint8_t num_attr,
+						btrc_player_attr_t *p_attrs)
+{
+	haltest_info("%s, num_attr=%d attrs=%u\n", __func__, num_attr, p_attrs);
+}
+
 static void get_player_app_values_text_cb(uint8_t attr_id, uint8_t num_val,
 								uint8_t *p_vals)
 {
@@ -109,6 +115,7 @@ static btrc_callbacks_t rc_cbacks = {
 	.size = sizeof(rc_cbacks),
 	.remote_features_cb = remote_features_cb,
 	.get_play_status_cb = get_play_status_cb,
+	.get_player_app_value_cb = get_player_app_value_cb,
 	.get_player_app_values_text_cb = get_player_app_values_text_cb,
 	.set_player_app_value_cb = set_player_app_value_cb,
 	.get_element_attr_cb = get_element_attr_cb,
-- 
1.8.3.2

