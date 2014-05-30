Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/2] android/gatt: Fix not setting request as done on direct db read
Date: Fri, 30 May 2014 15:19:42 +0200
Message-Id: <1401455982-31339-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401455982-31339-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401455982-31339-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously if read was succesfull - request was not marked as completed
because no callback was called for direct db read.
---
 android/gatt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index a61d702..46dc7f6 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4086,10 +4086,11 @@ static void read_requested_attributes(void *data, void *user_data)
 
 	/* We have value here already if no callback will be called */
 	if (value_len >= 0) {
+		resp_data->state = REQUEST_DONE;
+
 		resp_data->value = malloc0(value_len);
 		if (!resp_data->value) {
 			/* If data cannot be copied, act like when read fails */
-			resp_data->state = REQUEST_DONE;
 			resp_data->error = ATT_ECODE_INSUFF_RESOURCES;
 			return;
 		}
-- 
1.9.3

