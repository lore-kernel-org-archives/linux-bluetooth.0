Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v4 09/12] android/hid: Replace header checking magic number with defines
Date: Tue,  5 Nov 2013 23:09:15 +0200
Message-Id: <1383685758-3900-10-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383685758-3900-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383685758-3900-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hid.c b/android/hid.c
index 5411922..999f5d6 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -200,7 +200,7 @@ static gboolean intr_io_watch_cb(GIOChannel *chan, gpointer data)
 	}
 
 	/* Discard non-data packets */
-	if (bread == 0 || buf[0] != 0xA1)
+	if (bread == 0 || buf[0] != (HID_MSG_DATA | HID_DATA_TYPE_INPUT))
 		return TRUE;
 
 	/* send data to uHID device skipping HIDP header byte */
-- 
1.8.1.2

