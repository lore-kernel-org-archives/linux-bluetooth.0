Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 3/3] MAP: Output parameters for GetMessagesListing
Date: Mon,  9 Apr 2012 23:03:00 +0200
Message-Id: <1334005380-31302-3-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1334005380-31302-1-git-send-email-lkslawek@gmail.com>
References: <1334005380-31302-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/mas.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 76dc8e9..576c206 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -282,12 +282,22 @@ static void get_messages_listing_cb(void *session, int err, uint16_t size,
 					void *user_data)
 {
 	struct mas_session *mas = user_data;
+	uint16_t max = 1024;
 
 	if (err < 0 && err != -EAGAIN) {
 		obex_object_set_io_flags(mas, G_IO_ERR, err);
 		return;
 	}
 
+	map_ap_get_u16(mas->inparams, MAP_AP_MAXLISTCOUNT, &max);
+
+	if (max == 0) {
+		if (!entry)
+			mas->finished = TRUE;
+
+		goto proceed;
+	}
+
 	if (!mas->nth_call) {
 		g_string_append(mas->buffer, ML_BODY_BEGIN);
 		mas->nth_call = TRUE;
@@ -379,6 +389,13 @@ static void get_messages_listing_cb(void *session, int err, uint16_t size,
 	g_string_append(mas->buffer, "/>\n");
 
 proceed:
+	if (!entry) {
+		map_ap_set_u16(mas->outparams, MAP_AP_MESSAGESLISTINGSIZE,
+							size);
+		map_ap_set_u8(mas->outparams, MAP_AP_NEWMESSAGE,
+							newmsg ? 1 : 0);
+	}
+
 	if (err != -EAGAIN)
 		obex_object_set_io_flags(mas, G_IO_IN, 0);
 }
-- 
1.7.5.1

