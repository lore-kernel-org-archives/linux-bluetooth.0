Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/3] android/gatt: Fix state of pending request for prep write
Date: Thu,  5 Jun 2014 11:38:51 +0200
Message-Id: <1401961132-29459-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1401961132-29459-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401961132-29459-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>

State PENDING is used when we send request to upper layer and this is
how we do with prep write request
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index f450eac..ddba505 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5219,7 +5219,7 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 
 	data->handle = handle;
 	data->offset = offset;
-	data->state = REQUEST_INIT;
+	data->state = REQUEST_PENDING;
 
 	if (!queue_push_tail(dev->pending_requests, data)) {
 		free(data);
-- 
1.9.3

