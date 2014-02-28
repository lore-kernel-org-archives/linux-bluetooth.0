Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 5/6] android/client: Add AVRCP get_element_attr_cb support
Date: Fri, 28 Feb 2014 20:58:47 +0200
Message-Id: <1393613928-22264-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1393613928-22264-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1393613928-22264-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-rc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index b8174dd..57f7082 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -51,9 +51,20 @@ static void get_play_status_cb(void)
 	haltest_info("%s", __func__);
 }
 
+static void get_element_attr_cb(uint8_t num_attr, btrc_media_attr_t *attrs)
+{
+	uint8_t i;
+
+	haltest_info("%s, num_of_attributes=%d", __func__, num_attr);
+
+	for (i = 0; i < num_attr; i++)
+		haltest_info("attr id=%s", btrc_media_attr_t2str(attrs[i]));
+}
+
 static btrc_callbacks_t rc_cbacks = {
 	.size = sizeof(rc_cbacks),
 	.get_play_status_cb = get_play_status_cb,
+	.get_element_attr_cb = get_element_attr_cb,
 };
 
 /* init */
-- 
1.8.3.2

