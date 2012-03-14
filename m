Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 1/6] MAP: Process incoming parameters in GET/PUT
Date: Wed, 14 Mar 2012 23:54:28 +0100
Message-Id: <1331765673-12860-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/mas.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 23b1823..8eefe5f 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -38,6 +38,7 @@
 #include "mimetype.h"
 #include "filesystem.h"
 #include "manager.h"
+#include "map_ap.h"
 
 #include "messages.h"
 
@@ -108,12 +109,31 @@ struct mas_session {
 	gboolean finished;
 	gboolean nth_call;
 	GString *buffer;
+	map_ap_t *inparams;
 };
 
 static const uint8_t MAS_TARGET[TARGET_SIZE] = {
 			0xbb, 0x58, 0x2b, 0x40, 0x42, 0x0c, 0x11, 0xdb,
 			0xb0, 0xde, 0x08, 0x00, 0x20, 0x0c, 0x9a, 0x66  };
 
+static int get_params(struct obex_session *os, struct mas_session *mas)
+{
+	const uint8_t *buffer;
+	ssize_t size;
+
+	size = obex_get_apparam(os, &buffer);
+	if (size < 0)
+		size = 0;
+
+	mas->inparams = map_ap_decode(buffer, size);
+	if (mas->inparams == NULL) {
+		DBG("Error when parsing parameters!");
+		return -EBADR;
+	}
+
+	return 0;
+}
+
 static void reset_request(struct mas_session *mas)
 {
 	if (mas->buffer) {
@@ -121,6 +141,9 @@ static void reset_request(struct mas_session *mas)
 		mas->buffer = NULL;
 	}
 
+	map_ap_free(mas->inparams);
+	mas->inparams = NULL;
+
 	mas->nth_call = FALSE;
 	mas->finished = FALSE;
 }
@@ -178,6 +201,10 @@ static int mas_get(struct obex_session *os, void *user_data)
 	if (type == NULL)
 		return -EBADR;
 
+	ret = get_params(os, mas);
+	if (ret < 0)
+		goto failed;
+
 	ret = obex_get_stream_start(os, name);
 	if (ret < 0)
 		goto failed;
@@ -202,6 +229,10 @@ static int mas_put(struct obex_session *os, void *user_data)
 	if (type == NULL)
 		return -EBADR;
 
+	ret = get_params(os, mas);
+	if (ret < 0)
+		goto failed;
+
 	ret = obex_put_stream_start(os, name);
 	if (ret < 0)
 		goto failed;
-- 
1.7.5.1

