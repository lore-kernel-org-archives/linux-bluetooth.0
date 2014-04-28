Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/3] android/gatt: Send app uuid also for failure response
Date: Mon, 28 Apr 2014 15:17:50 +0200
Message-Id: <1398691070-25530-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1398691070-25530-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1398691070-25530-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Framework should know which request failed.
---
 android/gatt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 7c59e12..a7b8659 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3105,7 +3105,6 @@ static void handle_server_register(const void *buf, uint16_t len)
 
 	ev.status = GATT_SUCCESS;
 	ev.server_if = server->id;
-	memcpy(ev.uuid, server->uuid, sizeof(server->uuid));
 
 	status = HAL_STATUS_SUCCESS;
 
@@ -3113,6 +3112,8 @@ failed:
 	if (status != HAL_STATUS_SUCCESS)
 		ev.status = GATT_FAILURE;
 
+	memcpy(ev.uuid, cmd->uuid, sizeof(ev.uuid));
+
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_EV_GATT_SERVER_REGISTER, sizeof(ev), &ev);
 
-- 
1.9.1

