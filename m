Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 6/8] android/client: Add AVRCP get_player_app_attrs_text_cb support
Date: Tue, 18 Mar 2014 15:29:57 +0200
Message-Id: <1395149399-27531-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1395149399-27531-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1395149399-27531-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-rc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index 4a17e11..4ae4fcd 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -79,6 +79,18 @@ static void get_player_app_value_cb(uint8_t num_attr,
 		haltest_info("attribute=%u\n", p_attrs[i]);
 }
 
+static void get_player_app_attrs_text_cb(uint8_t num_attr,
+						btrc_player_attr_t *p_attrs)
+{
+	int i;
+
+	haltest_info("%s, num_attr=%d\n", __func__, num_attr);
+
+	for (i = 0; i < num_attr; i++)
+		haltest_info("attribute=%u\n", p_attrs[i]);
+
+}
+
 static void get_player_app_values_text_cb(uint8_t attr_id, uint8_t num_val,
 								uint8_t *p_vals)
 {
@@ -127,6 +139,7 @@ static btrc_callbacks_t rc_cbacks = {
 	.remote_features_cb = remote_features_cb,
 	.get_play_status_cb = get_play_status_cb,
 	.get_player_app_value_cb = get_player_app_value_cb,
+	.get_player_app_attrs_text_cb = get_player_app_attrs_text_cb,
 	.get_player_app_values_text_cb = get_player_app_values_text_cb,
 	.set_player_app_value_cb = set_player_app_value_cb,
 	.get_element_attr_cb = get_element_attr_cb,
-- 
1.8.3.2

