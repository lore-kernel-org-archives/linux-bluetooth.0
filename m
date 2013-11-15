Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/2] android/hal-ipc: Add pan notification call to hal-ipc dispatch handler
Date: Fri, 15 Nov 2013 11:59:25 +0200
Message-Id: <1384509565-27465-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1384509565-27465-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1384509565-27465-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index e1c8dd7..026e245 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -55,6 +55,9 @@ static void notification_dispatch(struct hal_hdr *msg, int fd)
 	case HAL_SERVICE_ID_A2DP:
 		bt_notify_a2dp(msg->opcode, msg->payload, msg->len);
 		break;
+	case HAL_SERVICE_ID_PAN:
+		bt_notify_pan(msg->opcode, msg->payload, msg->len);
+		break;
 	default:
 		DBG("Unhandled notification service=%d opcode=0x%x",
 						msg->service_id, msg->opcode);
-- 
1.8.3.2

