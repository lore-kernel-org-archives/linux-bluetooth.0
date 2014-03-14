Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/8] android/client: Add AVRCP passthrough_cmd_cb support
Date: Fri, 14 Mar 2014 11:16:41 +0200
Message-Id: <1394788607-29075-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394788607-29075-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394788607-29075-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-rc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index 2e93c02..f1cdbc5 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -88,6 +88,11 @@ static void volume_change_cb(uint8_t volume, uint8_t ctype)
 	haltest_info("%s, volume=%d ctype=%d\n", __func__, volume, ctype);
 }
 
+static void passthrough_cmd_cb(int id, int key_state)
+{
+	haltest_info("%s, id=%d key_state=%d\n", __func__, id, key_state);
+}
+
 static btrc_callbacks_t rc_cbacks = {
 	.size = sizeof(rc_cbacks),
 	.remote_features_cb = remote_features_cb,
@@ -95,6 +100,7 @@ static btrc_callbacks_t rc_cbacks = {
 	.get_element_attr_cb = get_element_attr_cb,
 	.register_notification_cb = register_notification_cb,
 	.volume_change_cb = volume_change_cb,
+	.passthrough_cmd_cb = passthrough_cmd_cb,
 };
 
 /* init */
-- 
1.8.3.2

