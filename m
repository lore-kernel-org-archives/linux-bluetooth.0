Return-Path: <cyrus@holtmann.org>
From: Sunil Kumar Behera <sunil.behera@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sunil Kumar Behera <sunil.behera@samsung.com>
Subject: [PATCH obexd 1/3] Add get next header function in message listing.
Date: Thu, 08 Nov 2012 16:12:58 +0530
Message-id: <1352371378-18038-1-git-send-email-sunil.behera@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of message listing we need to send application
parameters in response and also it is required for sending
response to message listing size request.
---
 plugins/mas.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/mas.c b/plugins/mas.c
index 186d267..319c87f 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -810,6 +810,7 @@ static struct obex_mime_type_driver mime_msg_listing = {
 	.target = MAS_TARGET,
 	.target_size = TARGET_SIZE,
 	.mimetype = "x-bt/MAP-msg-listing",
+	.get_next_header = any_get_next_header,
 	.open = msg_listing_open,
 	.close = any_close,
 	.read = any_read,
-- 
1.7.9.5

