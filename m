Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/2] android/pan: Fix wrong HAL service id
Date: Fri, 15 Nov 2013 11:59:24 +0200
Message-Id: <1384509565-27465-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/pan.c b/android/pan.c
index 061e611..46b3700 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -87,7 +87,7 @@ void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 		break;
 	}
 
-	ipc_send_rsp(sk, HAL_SERVICE_ID_A2DP, status);
+	ipc_send_rsp(sk, HAL_SERVICE_ID_PAN, status);
 }
 
 bool bt_pan_register(int sk, const bdaddr_t *addr)
-- 
1.8.3.2

