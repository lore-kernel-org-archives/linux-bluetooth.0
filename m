Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 4/5] Modify pbap plugin to utilize get_next_header()
Date: Mon, 27 Jun 2011 16:20:54 +0200
Message-Id: <1309184455-29752-5-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1309184455-29752-1-git-send-email-lkslawek@gmail.com>
References: <1309184455-29752-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/pbap.c |   97 +++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 62 insertions(+), 35 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 0208731..dc43867 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -963,6 +963,26 @@ static ssize_t array_read(GByteArray *array, void *buf, size_t count)
 	return len;
 }
 
+static ssize_t vobject_pull_get_next_header(void *object, void *buf, size_t mtu,
+								uint8_t *hi)
+{
+	struct pbap_object *obj = object;
+	struct pbap_session *pbap = obj->session;
+
+	if (!obj->buffer && !obj->aparams)
+		return -EAGAIN;
+
+	*hi = OBEX_HDR_APPARAM;
+
+	if (pbap->params->maxlistcount == 0 || obj->firstpacket) {
+		obj->firstpacket = FALSE;
+
+		return array_read(obj->aparams, buf, mtu);
+	}
+
+	return 0;
+}
+
 static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
 								uint8_t *hi)
 {
@@ -976,33 +996,43 @@ static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
 	if (!obj->buffer && !obj->aparams)
 		return -EAGAIN;
 
-	if (pbap->params->maxlistcount == 0) {
-		/* PhoneBookSize */
-		*hi = obj->aparams->len ? OBEX_HDR_APPARAM : OBEX_HDR_BODY;
-		return array_read(obj->aparams, buf, count);
-	} else if (obj->firstpacket) {
-		/* NewMissedCalls */
-		*hi = obj->aparams->len ? OBEX_HDR_APPARAM : OBEX_HDR_BODY;
-		obj->firstpacket = FALSE;
-		return array_read(obj->aparams, buf, count);
-	} else {
-		/* Stream data */
-		*hi = OBEX_HDR_BODY;
-		len = string_read(obj->buffer, buf, count);
-		if (len == 0 && !obj->lastpart) {
-			/* in case when buffer is empty and we know that more
-			 * data is still available in backend, requesting new
-			 * data part via phonebook_pull_read and returning
-			 * -EAGAIN to suspend request for now */
-			ret = phonebook_pull_read(obj->request);
-			if (ret)
-				return -EPERM;
-
-			return -EAGAIN;
-		}
+	if (pbap->params->maxlistcount == 0)
+		return -ENOSTR;
+
+	*hi = OBEX_HDR_BODY;
 
-		return len;
+	len = string_read(obj->buffer, buf, count);
+	if (len == 0 && !obj->lastpart) {
+		/* in case when buffer is empty and we know that more
+		 * data is still available in backend, requesting new
+		 * data part via phonebook_pull_read and returning
+		 * -EAGAIN to suspend request for now */
+		ret = phonebook_pull_read(obj->request);
+		if (ret)
+			return -EPERM;
+
+		return -EAGAIN;
 	}
+
+	return len;
+}
+
+static ssize_t vobject_list_get_next_header(void *object, void *buf, size_t mtu,
+								uint8_t *hi)
+{
+	struct pbap_object *obj = object;
+	struct pbap_session *pbap = obj->session;
+
+	/* Backend still busy reading contacts */
+	if (!pbap->cache.valid)
+		return -EAGAIN;
+
+	*hi = OBEX_HDR_APPARAM;
+
+	if (pbap->params->maxlistcount == 0)
+		return array_read(obj->aparams, buf, mtu);
+
+	return 0;
 }
 
 static ssize_t vobject_list_read(void *object, void *buf, size_t count,
@@ -1014,17 +1044,12 @@ static ssize_t vobject_list_read(void *object, void *buf, size_t count,
 	DBG("valid %d maxlistcount %d", pbap->cache.valid,
 						pbap->params->maxlistcount);
 
-	/* Backend still busy reading contacts */
-	if (!pbap->cache.valid)
-		return -EAGAIN;
+	if (pbap->params->maxlistcount == 0)
+		return -ENOSTR;
 
-	if (pbap->params->maxlistcount == 0) {
-		*hi = obj->aparams->len ? OBEX_HDR_APPARAM : OBEX_HDR_BODY;
-		return array_read(obj->aparams, buf, count);
-	} else {
-		*hi = OBEX_HDR_BODY;
-		return string_read(obj->buffer, buf, count);
-	}
+	*hi = OBEX_HDR_BODY;
+
+	return string_read(obj->buffer, buf, count);
 }
 
 static ssize_t vobject_vcard_read(void *object, void *buf, size_t count,
@@ -1048,6 +1073,7 @@ static struct obex_mime_type_driver mime_pull = {
 	.open = vobject_pull_open,
 	.close = vobject_close,
 	.read = vobject_pull_read,
+	.get_next_header = vobject_pull_get_next_header,
 };
 
 static struct obex_mime_type_driver mime_list = {
@@ -1057,6 +1083,7 @@ static struct obex_mime_type_driver mime_list = {
 	.open = vobject_list_open,
 	.close = vobject_close,
 	.read = vobject_list_read,
+	.get_next_header = vobject_list_get_next_header,
 };
 
 static struct obex_mime_type_driver mime_vcard = {
-- 
1.7.4.1

