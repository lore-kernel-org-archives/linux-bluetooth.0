Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/2] android/hal: Verify command status response before processing
Date: Mon, 18 Nov 2013 13:58:40 +0100
Message-Id: <1384779520-2104-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384779520-2104-1-git-send-email-szymon.janc@tieto.com>
References: <1384779520-2104-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes HAL IPC code verify error reply before processing it. It
also verify if success status was reported according to IPC spec.
---
 android/hal-ipc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 026e245..5155e04 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -367,6 +367,17 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 
 	if (cmd.opcode == HAL_OP_STATUS) {
 		struct hal_status *s = rsp;
+
+		if (sizeof(*s) != cmd.len) {
+			error("Invalid status length, aborting");
+			exit(EXIT_FAILURE);
+		}
+
+		if (s->code == HAL_STATUS_SUCCESS) {
+			error("Invalid success status response, aborting");
+			exit(EXIT_FAILURE);
+		}
+
 		return s->code;
 	}
 
-- 
1.8.4.2

