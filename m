Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/gatt: Don't try send responses after process_dev_pending_req()
Date: Fri, 16 May 2014 10:37:39 +0200
Message-Id: <1400229459-21617-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400229459-21617-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400229459-21617-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Process_dev_pending_requests call send_pending_respone, so we don't
have to call it again.
---
 android/gatt.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index f2fd17d..9bbcc48 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4346,11 +4346,6 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 
 	process_dev_pending_requests(device, ATT_OP_READ_BY_TYPE_REQ);
 
-	/* We send immediate if no data left to be filled by async callbacks */
-	if (!queue_find(device->pending_requests, match_pending_dev_request,
-									NULL))
-		send_dev_pending_response(device, ATT_OP_READ_BY_TYPE_REQ);
-
 	return 0;
 }
 
@@ -4565,11 +4560,6 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 
 	process_dev_pending_requests(device, ATT_OP_FIND_BY_TYPE_REQ);
 
-	/* Send if no response_data elements left to be filled by callbacks */
-	if (!queue_find(device->pending_requests, match_pending_dev_request,
-									NULL))
-		send_dev_pending_response(device, cmd[0]);
-
 	return 0;
 }
 
-- 
1.9.0

