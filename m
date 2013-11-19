Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/5] android/pan: Fix wrong struct parameter in disconnect function call
Date: Tue, 19 Nov 2013 14:21:12 +0200
Message-Id: <1384863676-12358-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/pan.c b/android/pan.c
index 2a11f46..fba86b8 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -58,7 +58,8 @@ static uint8_t bt_pan_connect(struct hal_cmd_pan_connect *cmd, uint16_t len)
 	return HAL_STATUS_FAILED;
 }
 
-static uint8_t bt_pan_disconnect(struct hal_cmd_pan_connect *cmd, uint16_t len)
+static uint8_t bt_pan_disconnect(struct hal_cmd_pan_disconnect *cmd,
+								uint16_t len)
 {
 	DBG("Not Implemented");
 
-- 
1.8.3.2

