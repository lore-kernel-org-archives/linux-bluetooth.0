Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 4/6] android/client: Add AVRCP get_play_status_cb support
Date: Fri, 28 Feb 2014 20:58:46 +0200
Message-Id: <1393613928-22264-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1393613928-22264-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1393613928-22264-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-rc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index 5aab8e0..b8174dd 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -46,8 +46,14 @@ SINTMAP(btrc_media_attr_t, -1, "(unknown)")
 	DELEMENT(BTRC_MEDIA_ATTR_PLAYING_TIME),
 ENDMAP
 
+static void get_play_status_cb(void)
+{
+	haltest_info("%s", __func__);
+}
+
 static btrc_callbacks_t rc_cbacks = {
 	.size = sizeof(rc_cbacks),
+	.get_play_status_cb = get_play_status_cb,
 };
 
 /* init */
-- 
1.8.3.2

