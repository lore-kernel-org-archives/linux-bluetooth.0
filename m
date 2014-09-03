Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] obexd/mas: Fix parsing of application parameters
Date: Wed,  3 Sep 2014 12:48:00 +0300
Message-Id: <1409737684-16002-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1409737684-16002-1-git-send-email-luiz.dentz@gmail.com>
References: <1409737684-16002-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some commands don't have any mandatory application parameter which means
inparams can be NULL which should not be treated as a bad request.
---
 obexd/plugins/mas.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
index 5729c22..24b26ae 100644
--- a/obexd/plugins/mas.c
+++ b/obexd/plugins/mas.c
@@ -83,8 +83,8 @@ static int get_params(struct obex_session *os, struct mas_session *mas)
 	ssize_t size;
 
 	size = obex_get_apparam(os, &buffer);
-	if (size < 0)
-		size = 0;
+	if (size <= 0)
+		return 0;
 
 	mas->inparams = g_obex_apparam_decode(buffer, size);
 	if (mas->inparams == NULL) {
@@ -249,7 +249,9 @@ static void get_messages_listing_cb(void *session, int err, uint16_t size,
 		return;
 	}
 
-	g_obex_apparam_get_uint16(mas->inparams, MAP_AP_MAXLISTCOUNT, &max);
+	if (mas->inparams)
+		g_obex_apparam_get_uint16(mas->inparams, MAP_AP_MAXLISTCOUNT,
+									&max);
 
 	if (max == 0) {
 		if (!entry)
@@ -397,7 +399,9 @@ static void get_folder_listing_cb(void *session, int err, uint16_t size,
 		return;
 	}
 
-	g_obex_apparam_get_uint16(mas->inparams, MAP_AP_MAXLISTCOUNT, &max);
+	if (mas->inparams)
+		g_obex_apparam_get_uint16(mas->inparams, MAP_AP_MAXLISTCOUNT,
+									&max);
 
 	if (max == 0) {
 		if (err != -EAGAIN)
@@ -493,8 +497,12 @@ static void *folder_listing_open(const char *name, int oflag, mode_t mode,
 
 	DBG("name = %s", name);
 
-	g_obex_apparam_get_uint16(mas->inparams, MAP_AP_MAXLISTCOUNT, &max);
-	g_obex_apparam_get_uint16(mas->inparams, MAP_AP_STARTOFFSET, &offset);
+	if (mas->inparams) {
+		g_obex_apparam_get_uint16(mas->inparams, MAP_AP_MAXLISTCOUNT,
+									&max);
+		g_obex_apparam_get_uint16(mas->inparams, MAP_AP_STARTOFFSET,
+								&offset);
+	}
 
 	*err = messages_get_folder_listing(mas->backend_data, name, max,
 					offset, get_folder_listing_cb, mas);
@@ -526,6 +534,9 @@ static void *msg_listing_open(const char *name, int oflag, mode_t mode,
 		return NULL;
 	}
 
+	if (!mas->inparams)
+		goto done;
+
 	g_obex_apparam_get_uint16(mas->inparams, MAP_AP_MAXLISTCOUNT, &max);
 	g_obex_apparam_get_uint16(mas->inparams, MAP_AP_STARTOFFSET, &offset);
 	g_obex_apparam_get_uint8(mas->inparams, MAP_AP_SUBJECTLENGTH,
@@ -548,6 +559,7 @@ static void *msg_listing_open(const char *name, int oflag, mode_t mode,
 	g_obex_apparam_get_uint8(mas->inparams, MAP_AP_FILTERPRIORITY,
 						&filter.priority);
 
+done:
 	*err = messages_get_messages_listing(mas->backend_data, name, max,
 			offset, subject_len, &filter,
 			get_messages_listing_cb, mas);
-- 
1.9.3

