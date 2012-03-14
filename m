Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 6/6] MAP: Output parameters in folder listing reply
Date: Wed, 14 Mar 2012 23:54:33 +0100
Message-Id: <1331765673-12860-6-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1331765673-12860-1-git-send-email-lkslawek@gmail.com>
References: <1331765673-12860-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This also introduces reusable any_get_next_header() that will be further
utilised in other requests returning application parameters header.
---
 plugins/mas.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index ea2b4b2..5d00ed1 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -25,11 +25,14 @@
 #include <config.h>
 #endif
 
+#include <string.h>
 #include <errno.h>
 #include <glib.h>
 #include <fcntl.h>
 #include <inttypes.h>
 
+#include <gobex/gobex.h>
+
 #include "obexd.h"
 #include "plugin.h"
 #include "log.h"
@@ -111,6 +114,7 @@ struct mas_session {
 	GString *buffer;
 	map_ap_t *inparams;
 	map_ap_t *outparams;
+	gboolean ap_sent;
 };
 
 static const uint8_t MAS_TARGET[TARGET_SIZE] = {
@@ -407,12 +411,26 @@ static void get_folder_listing_cb(void *session, int err, uint16_t size,
 					const char *name, void *user_data)
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
+		if (!err != -EAGAIN)
+			map_ap_set_u16(mas->outparams,
+					MAP_AP_FOLDERLISTINGSIZE, size);
+
+		if (!name)
+			mas->finished = TRUE;
+
+		goto proceed;
+	}
+
 	if (!mas->nth_call) {
 		g_string_append(mas->buffer, XML_DECL);
 		g_string_append(mas->buffer, FL_DTD);
@@ -578,6 +596,38 @@ static void *message_update_open(const char *name, int oflag, mode_t mode,
 		return mas;
 }
 
+static ssize_t any_get_next_header(void *object, void *buf, size_t mtu,
+								uint8_t *hi)
+{
+	struct mas_session *mas = object;
+	size_t len;
+	uint8_t *apbuf;
+
+	DBG("");
+
+	if (mas->buffer->len == 0 && !mas->finished)
+		return -EAGAIN;
+
+	*hi = G_OBEX_HDR_APPARAM;
+
+	if (mas->ap_sent)
+		return 0;
+
+	mas->ap_sent = TRUE;
+	apbuf = map_ap_encode(mas->outparams, &len);
+
+	if (len > mtu) {
+		DBG("MTU is to small to fit application parameters header!");
+		g_free(apbuf);
+
+		return -EIO;
+	}
+
+	memcpy(buf, apbuf, len);
+
+	return len;
+}
+
 static void *any_open(const char *name, int oflag, mode_t mode,
 				void *driver_data, size_t *size, int *err)
 {
@@ -663,6 +713,7 @@ static struct obex_mime_type_driver mime_folder_listing = {
 	.target = MAS_TARGET,
 	.target_size = TARGET_SIZE,
 	.mimetype = "x-obex/folder-listing",
+	.get_next_header = any_get_next_header,
 	.open = folder_listing_open,
 	.close = any_close,
 	.read = any_read,
-- 
1.7.5.1

