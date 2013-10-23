Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/6] android: Fix use of invalid service ID in response
Date: Wed, 23 Oct 2013 15:46:26 +0200
Message-ID: <1382535986-30684-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382535986-30684-1-git-send-email-szymon.janc@tieto.com>
References: <1382535986-30684-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adapter should use HAL_SERVICE_ID_BLUETOOTH service ID.
---
 android/adapter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 7a219df..6b0fab2 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -347,7 +347,8 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 		}
 
 		if (set_mode(MGMT_OP_SET_POWERED, 0x01)) {
-			ipc_send(io, HAL_SERVICE_ID_CORE, opcode, 0, NULL, -1);
+			ipc_send(io, HAL_SERVICE_ID_BLUETOOTH, opcode, 0, NULL,
+									-1);
 			return;
 		}
 		break;
@@ -358,7 +359,8 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 		}
 
 		if (set_mode(MGMT_OP_SET_POWERED, 0x00)) {
-			ipc_send(io, HAL_SERVICE_ID_CORE, opcode, 0, NULL, -1);
+			ipc_send(io, HAL_SERVICE_ID_BLUETOOTH, opcode, 0, NULL,
+									-1);
 			return;
 		}
 		break;
-- 
1.8.4

