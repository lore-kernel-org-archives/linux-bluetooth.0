Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/4] android: Use payload member to access message data
Date: Thu, 7 Nov 2013 10:10:37 +0100
Message-ID: <1383815437-521-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383815437-521-1-git-send-email-szymon.janc@tieto.com>
References: <1383815437-521-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This make it similar to other places in code.
---
 android/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/main.c b/android/main.c
index 2c587b1..71fc60b 100644
--- a/android/main.c
+++ b/android/main.c
@@ -254,7 +254,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 
 	switch (msg->service_id) {
 	case HAL_SERVICE_ID_CORE:
-		handle_service_core(msg->opcode, buf + sizeof(*msg), msg->len);
+		handle_service_core(msg->opcode, msg->payload, msg->len);
 		break;
 	case HAL_SERVICE_ID_BLUETOOTH:
 		bt_adapter_handle_cmd(fd, msg->opcode, msg->payload, msg->len);
-- 
1.8.4.2

