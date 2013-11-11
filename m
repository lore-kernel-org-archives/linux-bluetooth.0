Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 3/3] android/hidhost: Set info request from HAL is not supported
Date: Mon, 11 Nov 2013 14:15:30 +0200
Message-Id: <1384172130-29837-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1384172130-29837-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1384172130-29837-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data from hal_cmd_hidhost_set_info is usefull only when we create
UHID device. Once device is created all the transactions will be
done through the fd. There is no way to use this information
once device is created with HID internals.
---
 android/hidhost.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 816fe3e..6579ff3 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -857,7 +857,11 @@ static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hidhost_virtual_unplug *cmd,
 
 static uint8_t bt_hid_info(struct hal_cmd_hidhost_set_info *cmd, uint16_t len)
 {
-	DBG("Not Implemented");
+	/* Data from hal_cmd_hidhost_set_info is usefull only when we create
+	 * UHID device. Once device is created all the transactions will be
+	 * done through the fd. There is no way to use this information
+	 * once device is created with HID internals. */
+	DBG("Not supported");
 
 	return HAL_STATUS_FAILED;
 }
-- 
1.8.3.2

