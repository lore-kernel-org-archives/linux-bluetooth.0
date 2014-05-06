Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] android/gatt: Remove redundant lines
Date: Tue,  6 May 2014 11:57:06 +0200
Message-Id: <1399370226-19126-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1399370226-19126-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399370226-19126-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 810a8c7..3064b7f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -795,7 +795,6 @@ static void send_client_all_primary(struct app_connection *connection,
 	ev.conn_id = connection->id;
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 			HAL_EV_GATT_CLIENT_SEARCH_COMPLETE, sizeof(ev), &ev);
-
 }
 
 static struct service *create_service(uint8_t id, bool primary, char *uuid,
@@ -2393,7 +2392,6 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 			HAL_OP_GATT_CLIENT_WRITE_CHARACTERISTIC, status);
 
-- 
1.9.2

