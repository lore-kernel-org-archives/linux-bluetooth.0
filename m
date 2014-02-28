Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 6/6] android/client: Add AVRCP volume_change_cb support
Date: Fri, 28 Feb 2014 20:58:48 +0200
Message-Id: <1393613928-22264-7-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1393613928-22264-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1393613928-22264-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-rc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index 57f7082..02e1de3 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -61,10 +61,16 @@ static void get_element_attr_cb(uint8_t num_attr, btrc_media_attr_t *attrs)
 		haltest_info("attr id=%s", btrc_media_attr_t2str(attrs[i]));
 }
 
+static void volume_change_cb(uint8_t volume, uint8_t ctype)
+{
+	haltest_info("%s, volume=%d ctype=%d", __func__, volume, ctype);
+}
+
 static btrc_callbacks_t rc_cbacks = {
 	.size = sizeof(rc_cbacks),
 	.get_play_status_cb = get_play_status_cb,
 	.get_element_attr_cb = get_element_attr_cb,
+	.volume_change_cb = volume_change_cb,
 };
 
 /* init */
-- 
1.8.3.2

