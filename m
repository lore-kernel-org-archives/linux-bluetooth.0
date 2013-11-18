Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 6/6] android/hal: Check if command socket was shutdown by peer
Date: Mon, 18 Nov 2013 15:35:05 +0100
Message-Id: <1384785305-17084-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384785305-17084-1-git-send-email-szymon.janc@tieto.com>
References: <1384785305-17084-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to print proper error before exiting.
---
 android/hal-ipc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 5d622e1..b19704a 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -356,6 +356,12 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 		exit(EXIT_FAILURE);
 	}
 
+	/* socket was shutdown */
+	if (ret == 0) {
+		error("Command socket closed, aborting");
+		exit(EXIT_FAILURE);
+	}
+
 	memset(&msg, 0, sizeof(msg));
 	memset(&cmd, 0, sizeof(cmd));
 
-- 
1.8.4.2

