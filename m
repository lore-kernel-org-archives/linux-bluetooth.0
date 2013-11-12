Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 3/3] android/hidhost: Set info request from HAL is not supported
Date: Tue, 12 Nov 2013 17:07:15 +0200
Message-Id: <1384268835-7570-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1384268835-7570-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1384268835-7570-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data from hal_cmd_hidhost_set_info is usefull only when we create
UHID device. Once device is created all the transactions will be
done through the fd. There is no way to use this information
once device is created with HID internals.
---
 android/hidhost.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 556e5a5..95a98c3 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -839,9 +839,13 @@ static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hidhost_virtual_unplug *cmd,
 
 static uint8_t bt_hid_info(struct hal_cmd_hidhost_set_info *cmd, uint16_t len)
 {
-	DBG("Not Implemented");
+	/* Data from hal_cmd_hidhost_set_info is usefull only when we create
+	 * UHID device. Once device is created all the transactions will be
+	 * done through the fd. There is no way to use this information
+	 * once device is created with HID internals. */
+	DBG("Not supported");
 
-	return HAL_STATUS_FAILED;
+	return HAL_STATUS_UNSUPPORTED;
 }
 
 static uint8_t bt_hid_get_protocol(struct hal_cmd_hidhost_get_protocol *cmd,
-- 
1.8.3.2

