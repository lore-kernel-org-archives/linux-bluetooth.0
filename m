Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/10] android/hal-ipc: Fix missing mutex unlock
Date: Wed, 11 Jun 2014 16:32:45 +0200
Message-Id: <1402497172-12436-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
References: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a preparation for destroy callback.
---
 android/hal-ipc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 81d3a1b..ee3a04c 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -366,6 +366,7 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 	/* socket was shutdown */
 	if (ret == 0) {
 		error("Command socket closed, aborting");
+		pthread_mutex_unlock(&cmd_sk_mutex);
 		exit(EXIT_FAILURE);
 	}
 
-- 
1.9.1

