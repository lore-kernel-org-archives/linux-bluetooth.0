Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/hal: Fix receiving of commands with no response parameter
Date: Tue, 22 Oct 2013 14:03:58 +0200
Message-Id: <1382443438-28452-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix receiving of error response in case command has no reply
parameters.
---
 android/hal-ipc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 041441d..b264bfe 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -260,6 +260,7 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 
 	if (!rsp || rsp_len == 0) {
 		memset(&err, 0, sizeof(err));
+		rsp_len = sizeof(err);
 		rsp = &err;
 	}
 
-- 
1.8.4

