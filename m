Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 03/11] android/hidhost: Remove unnecessary check
Date: Fri, 17 Jan 2014 01:25:43 +0200
Message-Id: <1389914751-18545-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HID device will return unsupported or invalid response for unsupported
or invalid get/set protocol request. Need not to check prior to that.
---
 android/hidhost.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 8a2668c..968b6f2 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -900,11 +900,6 @@ static void bt_hid_get_protocol(const void *buf, uint16_t len)
 
 	dev = l->data;
 
-	if (dev->boot_dev) {
-		status = HAL_STATUS_UNSUPPORTED;
-		goto failed;
-	}
-
 	hdr = HID_MSG_GET_PROTOCOL | cmd->mode;
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
 
@@ -955,11 +950,6 @@ static void bt_hid_set_protocol(const void *buf, uint16_t len)
 
 	dev = l->data;
 
-	if (dev->boot_dev) {
-		status = HAL_STATUS_UNSUPPORTED;
-		goto failed;
-	}
-
 	hdr = HID_MSG_SET_PROTOCOL | cmd->mode;
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
 
-- 
1.8.3.2

