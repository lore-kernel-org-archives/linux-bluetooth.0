Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/6] android: Fix error response for unknown command
Date: Tue, 22 Oct 2013 18:47:55 +0200
Message-Id: <1382460476-6604-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382460476-6604-1-git-send-email-szymon.janc@tieto.com>
References: <1382460476-6604-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use "bluetooth" service id when replying to adapter commands.
---
 android/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/adapter.c b/android/adapter.c
index f891bc2..5621e67 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -295,7 +295,7 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 {
 	switch (opcode) {
 	default:
-		ipc_send_error(io, HAL_SERVICE_ID_CORE, HAL_ERROR_FAILED);
+		ipc_send_error(io, HAL_SERVICE_ID_BLUETOOTH, HAL_ERROR_FAILED);
 		break;
 	}
 }
-- 
1.8.4

