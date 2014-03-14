Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 3/8] android/client: Add AVRCP set_player_app_value_cb support
Date: Fri, 14 Mar 2014 11:16:42 +0200
Message-Id: <1394788607-29075-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394788607-29075-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394788607-29075-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-rc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index f1cdbc5..df172d3 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -68,6 +68,11 @@ static void get_play_status_cb(void)
 	haltest_info("%s\n", __func__);
 }
 
+static void set_player_app_value_cb(btrc_player_settings_t *p_vals)
+{
+	haltest_info("%s, settings=%u\n", __func__, p_vals);
+}
+
 static void get_element_attr_cb(uint8_t num_attr, btrc_media_attr_t *attrs)
 {
 	uint8_t i;
@@ -97,6 +102,7 @@ static btrc_callbacks_t rc_cbacks = {
 	.size = sizeof(rc_cbacks),
 	.remote_features_cb = remote_features_cb,
 	.get_play_status_cb = get_play_status_cb,
+	.set_player_app_value_cb = set_player_app_value_cb,
 	.get_element_attr_cb = get_element_attr_cb,
 	.register_notification_cb = register_notification_cb,
 	.volume_change_cb = volume_change_cb,
-- 
1.8.3.2

