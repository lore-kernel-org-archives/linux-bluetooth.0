Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/2] android/gatt: Minor whitespace fixes
Date: Mon, 14 Apr 2014 12:39:51 +0200
Message-Id: <1397471991-21200-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1397471991-21200-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1397471991-21200-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index f303aea..150f7b5 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1249,7 +1249,7 @@ static void handle_client_disconnect(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	/*Check if client owns this connection */
+	/* Check if client owns this connection */
 	if (!queue_remove_if(dev->clients, match_by_value,
 						INT_TO_PTR(cmd->client_if))) {
 		error("gatt: cannot remove conn_id=%d", cmd->client_if);
@@ -1269,7 +1269,8 @@ reply:
 	 * device then this is what we shall to do.
 	 * If this is last client, this is still OK to do because on connect
 	 * request we do le scan and wait until remote device start
-	 * advertisement */
+	 * advertisement
+	 */
 	send_client_disconnect_notify(cmd->client_if, dev, GATT_SUCCESS);
 
 	/* If there is more clients just return */
@@ -1336,7 +1337,7 @@ static void handle_client_search_service(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	/*TODO:  Handle filter uuid */
+	/* TODO:  Handle filter uuid */
 
 	/* Use cache if possible */
 	if (!queue_isempty(dev->services)) {
-- 
1.9.1

