Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/4] android/client: Add AVRCP remote_features_cb support
Date: Thu,  6 Mar 2014 15:45:25 +0200
Message-Id: <1394113527-4398-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1394113527-4398-1-git-send-email-luiz.dentz@gmail.com>
References: <1394113527-4398-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/client/if-rc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index 55fdf1d..60c3247 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -46,6 +46,15 @@ SINTMAP(btrc_media_attr_t, -1, "(unknown)")
 	DELEMENT(BTRC_MEDIA_ATTR_PLAYING_TIME),
 ENDMAP
 
+static char last_addr[MAX_ADDR_STR_LEN];
+
+static void remote_features_cb(bt_bdaddr_t *bd_addr,
+					btrc_remote_features_t features)
+{
+	haltest_info("%s: remote_bd_addr=%s features=%u\n", __func__,
+				bt_bdaddr_t2str(bd_addr, last_addr), features);
+}
+
 static void get_play_status_cb(void)
 {
 	haltest_info("%s\n", __func__);
@@ -73,6 +82,7 @@ static void volume_change_cb(uint8_t volume, uint8_t ctype)
 
 static btrc_callbacks_t rc_cbacks = {
 	.size = sizeof(rc_cbacks),
+	.remote_features_cb = remote_features_cb,
 	.get_play_status_cb = get_play_status_cb,
 	.get_element_attr_cb = get_element_attr_cb,
 	.register_notification_cb = register_notification_cb,
-- 
1.8.5.3

