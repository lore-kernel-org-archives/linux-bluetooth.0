Return-Path: <cyrus@holtmann.org>
From: Divya Yadav <divya.yadav@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Divya Yadav <divya.yadav@samsung.com>
Subject: [PATCH obexd 2/3] MAP: Implement application parameter parsing in
 get/put requests
Date: Thu, 08 Mar 2012 14:14:18 +0530
Message-id: <1331196259-16010-2-git-send-email-divya.yadav@samsung.com>
In-reply-to: <1331196259-16010-1-git-send-email-divya.yadav@samsung.com>
References: <1331196259-16010-1-git-send-email-divya.yadav@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/mas.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 23b1823..ade28c5 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -40,6 +40,7 @@
 #include "manager.h"
 
 #include "messages.h"
+#include "map_ap.h"
 
 /* Channel number according to bluez doc/assigned-numbers.txt */
 #define MAS_CHANNEL	16
@@ -108,6 +109,7 @@ struct mas_session {
 	gboolean finished;
 	gboolean nth_call;
 	GString *buffer;
+	map_ap_t *ap;
 };
 
 static const uint8_t MAS_TARGET[TARGET_SIZE] = {
@@ -120,6 +122,8 @@ static void reset_request(struct mas_session *mas)
 		g_string_free(mas->buffer, TRUE);
 		mas->buffer = NULL;
 	}
+	map_ap_free(mas->ap);
+	mas->ap = NULL;
 
 	mas->nth_call = FALSE;
 	mas->finished = FALSE;
@@ -171,6 +175,8 @@ static int mas_get(struct obex_session *os, void *user_data)
 	const char *type = obex_get_type(os);
 	const char *name = obex_get_name(os);
 	int ret;
+	const uint8_t *buffer = NULL;
+	ssize_t rsize = 0;
 
 	DBG("GET: name %s type %s mas %p",
 			name, type, mas);
@@ -178,6 +184,20 @@ static int mas_get(struct obex_session *os, void *user_data)
 	if (type == NULL)
 		return -EBADR;
 
+	rsize = obex_get_apparam(os, &buffer);
+
+	if (rsize < 0) {
+		if (g_ascii_strcasecmp(type, "x-bt/message") == 0) {
+			ret = -EBADR;
+			goto failed;
+		}
+	} else {
+		mas->ap = map_ap_decode(buffer, rsize);
+		if (mas->ap == NULL) {
+			ret = -EBADR;
+			goto failed;
+		}
+	}
 	ret = obex_get_stream_start(os, name);
 	if (ret < 0)
 		goto failed;
@@ -196,12 +216,28 @@ static int mas_put(struct obex_session *os, void *user_data)
 	const char *type = obex_get_type(os);
 	const char *name = obex_get_name(os);
 	int ret;
+	const uint8_t *buffer = NULL;
+	ssize_t rsize = 0;
 
 	DBG("PUT: name %s type %s mas %p", name, type, mas);
 
 	if (type == NULL)
 		return -EBADR;
 
+	rsize = obex_get_apparam(os, &buffer);
+	if (rsize < 0) {
+		if (g_ascii_strcasecmp(type, "x-bt/messageStatus") == 0 ||
+			g_ascii_strcasecmp(type, "x-bt/message") == 0) {
+			ret = -EBADR;
+			goto failed;
+		}
+	} else {
+		mas->ap = map_ap_decode(buffer, rsize);
+		if (mas->ap == NULL) {
+			ret = -EBADR;
+			goto failed;
+		}
+	}
 	ret = obex_put_stream_start(os, name);
 	if (ret < 0)
 		goto failed;
-- 
1.7.0.4

