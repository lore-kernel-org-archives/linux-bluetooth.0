Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 7/8] android/client: Add AVRCP list_player_app_values_cb support
Date: Tue, 18 Mar 2014 15:29:58 +0200
Message-Id: <1395149399-27531-7-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1395149399-27531-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1395149399-27531-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-rc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index 4ae4fcd..7cdc07d 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -68,6 +68,11 @@ static void get_play_status_cb(void)
 	haltest_info("%s\n", __func__);
 }
 
+static void list_player_app_values_cb(btrc_player_attr_t attr_id)
+{
+	haltest_info("%s, attr_id=%d\n", __func__, attr_id);
+}
+
 static void get_player_app_value_cb(uint8_t num_attr,
 						btrc_player_attr_t *p_attrs)
 {
@@ -138,6 +143,7 @@ static btrc_callbacks_t rc_cbacks = {
 	.size = sizeof(rc_cbacks),
 	.remote_features_cb = remote_features_cb,
 	.get_play_status_cb = get_play_status_cb,
+	.list_player_app_values_cb = list_player_app_values_cb,
 	.get_player_app_value_cb = get_player_app_value_cb,
 	.get_player_app_attrs_text_cb = get_player_app_attrs_text_cb,
 	.get_player_app_values_text_cb = get_player_app_values_text_cb,
-- 
1.8.3.2

