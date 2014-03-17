Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/2] android/hal-ipc: Make opcode debug print more readable
Date: Mon, 17 Mar 2014 09:20:42 +0100
Message-Id: <1395044442-14350-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1395044442-14350-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1395044442-14350-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 8e817c9..5bef281 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -401,7 +401,7 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 	}
 
 	if (cmd.service_id != service_id) {
-		error("Invalid service id (%u vs %u), aborting",
+		error("Invalid service id (0x%x vs 0x%x), aborting",
 						cmd.service_id, service_id);
 		exit(EXIT_FAILURE);
 	}
@@ -412,7 +412,7 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 	}
 
 	if (cmd.opcode != opcode && cmd.opcode != HAL_OP_STATUS) {
-		error("Invalid opcode received (%u vs %u), aborting",
+		error("Invalid opcode received (0x%x vs 0x%x), aborting",
 						cmd.opcode, opcode);
 		exit(EXIT_FAILURE);
 	}
-- 
1.9.0

