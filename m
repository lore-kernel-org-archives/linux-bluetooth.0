Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 08/10] android/pan: Fix minor white space
Date: Wed, 11 Dec 2013 12:13:43 +0200
Message-Id: <1386756825-934-9-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/pan.c b/android/pan.c
index 1ed7b04..0783357 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -257,7 +257,7 @@ static void bt_pan_connect(const void *buf, uint16_t len)
 	devices = g_slist_append(devices, dev);
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_CONNECTING);
 
-	status =  HAL_STATUS_SUCCESS;
+	status = HAL_STATUS_SUCCESS;
 
 failed:
 	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_CONNECT, status);
-- 
1.8.3.2

