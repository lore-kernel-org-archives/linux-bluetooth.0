Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/2] android/gatt: Minor coding style fix
Date: Wed, 18 Jun 2014 14:58:54 +0200
Message-Id: <1403096334-23297-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1403096334-23297-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1403096334-23297-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 7dd37ab..30328b9 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3773,8 +3773,9 @@ static void handle_server_register(const void *buf, uint16_t len)
 	if (app) {
 		ev.server_if = app->id;
 		ev.status = GATT_SUCCESS;
-	} else
+	} else {
 		ev.status = GATT_FAILURE;
+	}
 
 	memcpy(ev.uuid, cmd->uuid, sizeof(ev.uuid));
 
-- 
2.0.0

