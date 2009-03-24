Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Remove loads of code and use GString
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-LQoxLfTCMAh9UH22RLCz"
Date: Tue, 24 Mar 2009 12:06:46 +0000
Message-Id: <1237896406.14805.736.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-LQoxLfTCMAh9UH22RLCz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Much easier than a home-made function.

Cheers

--=-LQoxLfTCMAh9UH22RLCz
Content-Disposition: attachment; filename="0001-Remove-append_and_grow-code-and-just-use-GString.patch"
Content-Type: text/x-patch; name="0001-Remove-append_and_grow-code-and-just-use-GString.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 04c74b471bb2d6505206b31d87931c8a2c79373a Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 24 Mar 2009 12:04:32 +0000
Subject: [PATCH] Remove "append_and_grow" code and just use GString

Less code for us to maintain.
---
 src/device.c |   52 ++++++++--------------------------------------------
 1 files changed, 8 insertions(+), 44 deletions(-)

diff --git a/src/device.c b/src/device.c
index 48ac512..3734c29 100644
--- a/src/device.c
+++ b/src/device.c
@@ -987,41 +987,6 @@ static void iter_append_record(DBusMessageIter *dict, uint32_t handle,
 	dbus_message_iter_close_container(dict, &entry);
 }
 
-static void append_and_grow_string(void *data, const char *str)
-{
-	sdp_buf_t *buff = data;
-	int len;
-
-	len = strlen(str);
-
-	if (!buff->data) {
-		buff->data = malloc(DEFAULT_XML_BUF_SIZE);
-		if (!buff->data)
-			return;
-		buff->buf_size = DEFAULT_XML_BUF_SIZE;
-	}
-
-	/* Grow string */
-	while (buff->buf_size < (buff->data_size + len + 1)) {
-		void *tmp;
-		uint32_t new_size;
-
-		/* Grow buffer by a factor of 2 */
-		new_size = (buff->buf_size << 1);
-
-		tmp = realloc(buff->data, new_size);
-		if (!tmp)
-			return;
-
-		buff->data = tmp;
-		buff->buf_size = new_size;
-	}
-
-	/* Include the NULL character */
-	memcpy(buff->data + buff->data_size, str, len + 1);
-	buff->data_size += len;
-}
-
 static void discover_services_reply(struct browse_req *req, int err,
 							sdp_list_t *recs)
 {
@@ -1056,21 +1021,20 @@ static void discover_services_reply(struct browse_req *req, int err,
 
 	for (seq = recs; seq; seq = seq->next) {
 		sdp_record_t *rec = (sdp_record_t *) seq->data;
-		sdp_buf_t result;
+		GString *result;
 
 		if (!rec)
 			break;
 
-		memset(&result, 0, sizeof(sdp_buf_t));
+		result = g_string_new(NULL);
 
-		convert_sdp_record_to_xml(rec, &result,
-				append_and_grow_string);
+		convert_sdp_record_to_xml(rec, result,
+				(void *) g_string_append);
 
-		if (result.data) {
-			const char *val = (char *) result.data;
-			iter_append_record(&dict, rec->handle, val);
-			free(result.data);
-		}
+		if (result->len)
+			iter_append_record(&dict, rec->handle, result->str);
+
+		g_string_free(result, TRUE);
 	}
 
 	dbus_message_iter_close_container(&iter, &dict);
-- 
1.6.0.6


--=-LQoxLfTCMAh9UH22RLCz--

