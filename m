Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 8/9] MAP: Make use of GObexApparam API
Date: Thu,  9 Aug 2012 13:32:32 +0300
Message-Id: <1344508353-24647-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1344508353-24647-1-git-send-email-luiz.dentz@gmail.com>
References: <1344508353-24647-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/mas.c | 81 ++++++++++++++++++++++++++++-------------------------------
 1 file changed, 38 insertions(+), 43 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 576c206..30e529f 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -32,6 +32,7 @@
 #include <inttypes.h>
 
 #include <gobex/gobex.h>
+#include <gobex/gobex-apparam.h>
 
 #include "obexd.h"
 #include "plugin.h"
@@ -112,8 +113,8 @@ struct mas_session {
 	gboolean finished;
 	gboolean nth_call;
 	GString *buffer;
-	map_ap_t *inparams;
-	map_ap_t *outparams;
+	GObexApparam *inparams;
+	GObexApparam *outparams;
 	gboolean ap_sent;
 };
 
@@ -130,14 +131,12 @@ static int get_params(struct obex_session *os, struct mas_session *mas)
 	if (size < 0)
 		size = 0;
 
-	mas->inparams = map_ap_decode(buffer, size);
+	mas->inparams = g_obex_apparam_decode(buffer, size);
 	if (mas->inparams == NULL) {
 		DBG("Error when parsing parameters!");
 		return -EBADR;
 	}
 
-	mas->outparams = map_ap_new();
-
 	return 0;
 }
 
@@ -148,10 +147,15 @@ static void reset_request(struct mas_session *mas)
 		mas->buffer = NULL;
 	}
 
-	map_ap_free(mas->inparams);
-	mas->inparams = NULL;
-	map_ap_free(mas->outparams);
-	mas->outparams = NULL;
+	if (mas->inparams) {
+		g_obex_apparam_free(mas->inparams);
+		mas->inparams = NULL;
+	}
+
+	if (mas->outparams) {
+		g_obex_apparam_free(mas->outparams);
+		mas->outparams = NULL;
+	}
 
 	mas->nth_call = FALSE;
 	mas->finished = FALSE;
@@ -289,7 +293,7 @@ static void get_messages_listing_cb(void *session, int err, uint16_t size,
 		return;
 	}
 
-	map_ap_get_u16(mas->inparams, MAP_AP_MAXLISTCOUNT, &max);
+	g_obex_apparam_get_uint16(mas->inparams, MAP_AP_MAXLISTCOUNT, &max);
 
 	if (max == 0) {
 		if (!entry)
@@ -390,10 +394,12 @@ static void get_messages_listing_cb(void *session, int err, uint16_t size,
 
 proceed:
 	if (!entry) {
-		map_ap_set_u16(mas->outparams, MAP_AP_MESSAGESLISTINGSIZE,
-							size);
-		map_ap_set_u8(mas->outparams, MAP_AP_NEWMESSAGE,
-							newmsg ? 1 : 0);
+		mas->outparams = g_obex_apparam_set_uint16(mas->outparams,
+						MAP_AP_MESSAGESLISTINGSIZE,
+						size);
+		mas->outparams = g_obex_apparam_set_uint8(mas->outparams,
+						MAP_AP_NEWMESSAGE,
+						newmsg ? 1 : 0);
 	}
 
 	if (err != -EAGAIN)
@@ -435,12 +441,14 @@ static void get_folder_listing_cb(void *session, int err, uint16_t size,
 		return;
 	}
 
-	map_ap_get_u16(mas->inparams, MAP_AP_MAXLISTCOUNT, &max);
+	g_obex_apparam_get_uint16(mas->inparams, MAP_AP_MAXLISTCOUNT, &max);
 
 	if (max == 0) {
 		if (err != -EAGAIN)
-			map_ap_set_u16(mas->outparams,
-					MAP_AP_FOLDERLISTINGSIZE, size);
+			mas->outparams = g_obex_apparam_set_uint16(
+						mas->outparams,
+						MAP_AP_FOLDERLISTINGSIZE,
+						size);
 
 		if (!name)
 			mas->finished = TRUE;
@@ -529,8 +537,8 @@ static void *folder_listing_open(const char *name, int oflag, mode_t mode,
 
 	DBG("name = %s", name);
 
-	map_ap_get_u16(mas->inparams, MAP_AP_MAXLISTCOUNT, &max);
-	map_ap_get_u16(mas->inparams, MAP_AP_STARTOFFSET, &offset);
+	g_obex_apparam_get_uint16(mas->inparams, MAP_AP_MAXLISTCOUNT, &max);
+	g_obex_apparam_get_uint16(mas->inparams, MAP_AP_STARTOFFSET, &offset);
 
 	*err = messages_get_folder_listing(mas->backend_data, name, max,
 					offset, get_folder_listing_cb, mas);
@@ -559,24 +567,24 @@ static void *msg_listing_open(const char *name, int oflag, mode_t mode,
 		return NULL;
 	}
 
-	map_ap_get_u16(mas->inparams, MAP_AP_MAXLISTCOUNT, &max);
-	map_ap_get_u16(mas->inparams, MAP_AP_STARTOFFSET, &offset);
+	g_obex_apparam_get_uint16(mas->inparams, MAP_AP_MAXLISTCOUNT, &max);
+	g_obex_apparam_get_uint16(mas->inparams, MAP_AP_STARTOFFSET, &offset);
 
-	map_ap_get_u32(mas->inparams, MAP_AP_PARAMETERMASK,
+	g_obex_apparam_get_uint32(mas->inparams, MAP_AP_PARAMETERMASK,
 						&filter.parameter_mask);
-	map_ap_get_u8(mas->inparams, MAP_AP_FILTERMESSAGETYPE,
+	g_obex_apparam_get_uint8(mas->inparams, MAP_AP_FILTERMESSAGETYPE,
 						&filter.type);
-	filter.period_begin = map_ap_get_string(mas->inparams,
+	filter.period_begin = g_obex_apparam_get_string(mas->inparams,
 						MAP_AP_FILTERPERIODBEGIN);
-	filter.period_end = map_ap_get_string(mas->inparams,
+	filter.period_end = g_obex_apparam_get_string(mas->inparams,
 						MAP_AP_FILTERPERIODEND);
-	map_ap_get_u8(mas->inparams, MAP_AP_FILTERREADSTATUS,
+	g_obex_apparam_get_uint8(mas->inparams, MAP_AP_FILTERREADSTATUS,
 						&filter.read_status);
-	filter.recipient = map_ap_get_string(mas->inparams,
+	filter.recipient = g_obex_apparam_get_string(mas->inparams,
 						MAP_AP_FILTERRECIPIENT);
-	filter.originator = map_ap_get_string(mas->inparams,
+	filter.originator = g_obex_apparam_get_string(mas->inparams,
 						MAP_AP_FILTERORIGINATOR);
-	map_ap_get_u8(mas->inparams, MAP_AP_FILTERPRIORITY,
+	g_obex_apparam_get_uint8(mas->inparams, MAP_AP_FILTERPRIORITY,
 						&filter.priority);
 
 	*err = messages_get_messages_listing(mas->backend_data, name, max,
@@ -640,8 +648,6 @@ static ssize_t any_get_next_header(void *object, void *buf, size_t mtu,
 								uint8_t *hi)
 {
 	struct mas_session *mas = object;
-	size_t len;
-	uint8_t *apbuf;
 
 	DBG("");
 
@@ -654,18 +660,7 @@ static ssize_t any_get_next_header(void *object, void *buf, size_t mtu,
 		return 0;
 
 	mas->ap_sent = TRUE;
-	apbuf = map_ap_encode(mas->outparams, &len);
-
-	if (len > mtu) {
-		DBG("MTU is to small to fit application parameters header!");
-		g_free(apbuf);
-
-		return -EIO;
-	}
-
-	memcpy(buf, apbuf, len);
-
-	return len;
+	return g_obex_apparam_encode(mas->outparams, buf, mtu);
 }
 
 static void *any_open(const char *name, int oflag, mode_t mode,
-- 
1.7.11.2

