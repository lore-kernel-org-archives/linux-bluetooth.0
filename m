Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH 5/5] Send new missed calls count in first packet
Date: Thu,  2 Jun 2011 15:23:23 +0200
Message-Id: <1307021003-15418-6-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1307021003-15418-1-git-send-email-lkslawek@gmail.com>
References: <1307021003-15418-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes the order in which OBEX headers were sent in case of PBAP
session to comply to PBAP specification, ch. 6.2.2. This is achieved by
telling pbap_get caller to not to start OpenOBEX streaming mode and then
starting it later, after sending appropriate application parameters
header. It also utilizes preexistent obex_aparam_write function.
---
 plugins/pbap.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 84661cc..21ae278 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -142,12 +142,14 @@ struct pbap_session {
 	uint32_t find_handle;
 	struct cache cache;
 	struct pbap_object *obj;
+	struct obex_session *obex_session;
+	obex_object_t *obex_obj;
+	gboolean needstart;
 };
 
 struct pbap_object {
 	GString *buffer;
 	GByteArray *aparams;
-	gboolean firstpacket;
 	gboolean lastpart;
 	struct pbap_session *session;
 	void *request;
@@ -315,14 +317,20 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 	if (missed > 0)	{
 		DBG("missed %d", missed);
 
-		pbap->obj->firstpacket = TRUE;
-
 		pbap->obj->aparams = g_byte_array_new();
 		pbap->obj->aparams = append_aparam_header(pbap->obj->aparams,
 						NEWMISSEDCALLS_TAG, &missed);
+		obex_aparam_write(pbap->obex_session, pbap->obex_obj,
+				pbap->obj->aparams->data,
+				pbap->obj->aparams->len);
+
 	}
 
-	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
+	if (pbap->needstart) {
+		obex_start_streaming(pbap->obex_session, pbap->obex_obj);
+		pbap->needstart = FALSE;
+	} else
+		obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
 
 static void cache_entry_notify(const char *id, uint32_t handle,
@@ -655,6 +663,8 @@ static int pbap_get(struct obex_session *os, obex_object_t *obj,
 	}
 
 	pbap->params = params;
+	pbap->obex_session = os;
+	pbap->obex_obj = obj;
 
 	if (strcmp(type, PHONEBOOK_TYPE) == 0) {
 		/* Always contains the absolute path */
@@ -663,7 +673,9 @@ static int pbap_get(struct obex_session *os, obex_object_t *obj,
 		else
 			path = g_build_filename("/", name, NULL);
 
-		*stream = (params->maxlistcount == 0 ? FALSE : TRUE);
+		*stream = FALSE;
+		if (params->maxlistcount)
+			pbap->needstart = TRUE;
 	} else if (strcmp(type, VCARDLISTING_TYPE) == 0) {
 		/* Always relative */
 		if (!name || strlen(name) == 0)
@@ -983,11 +995,6 @@ static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
 		/* PhoneBookSize */
 		*hi = OBEX_HDR_APPARAM;
 		return array_read(obj->aparams, buf, count);
-	} else if (obj->firstpacket) {
-		/* NewMissedCalls */
-		*hi = OBEX_HDR_APPARAM;
-		obj->firstpacket = FALSE;
-		return array_read(obj->aparams, buf, count);
 	} else {
 		/* Stream data */
 		*hi = OBEX_HDR_BODY;
-- 
1.7.4.1

