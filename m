Return-Path: <cyrus@holtmann.org>
From: lkslawek@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH 4/4] Add detecting of MAP function in OBEX request
Date: Wed,  2 Mar 2011 10:36:54 +0100
Message-Id: <1299058614-8904-5-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1299058614-8904-1-git-send-email-lkslawek@gmail.com>
References: <1299058614-8904-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Slawomir Bochenski <lkslawek@gmail.com>

There is also first part of mas.c <-> backend API. The mas_request
structure will be used when calling backend functions.
---
 plugins/mas.c      |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 plugins/messages.h |   15 ++++++++++++++
 2 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 6636b75..36b4b64 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <string.h>
 #include <errno.h>
 #include <glib.h>
 #include <openobex/obex.h>
@@ -38,6 +39,14 @@
 
 #include "messages.h"
 
+#define EVENT_TYPE		"x-bt/MAP-event-report"
+#define MESSAGE_TYPE		"x-bt/message"
+#define FOLDER_LISTING_TYPE	"x-obex/folder-listing"
+#define MESSAGES_LISTING_TYPE	"x-bt/MAP-msg-listing"
+#define NOTIFICATION_TYPE	"x-bt/MAP-NotificationRegistration"
+#define STATUS_TYPE		"x-bt/messageStatus"
+#define UPDATE_TYPE		"x-bt/MAP-messageUpdate"
+
 /* Channel number according to bluez doc/assigned-numbers.txt */
 #define MAS_CHANNEL	16
 
@@ -99,6 +108,14 @@ static void mas_clean(struct mas_session *mas)
 	g_free(mas);
 }
 
+static void reset_request(struct mas_session *mas)
+{
+	if (mas->request) {
+		g_free(mas->request);
+		mas->request = NULL;
+	}
+}
+
 static void *mas_connect(struct obex_session *os, int *err)
 {
 	struct mas_session *mas;
@@ -139,6 +156,21 @@ static int mas_get(struct obex_session *os, obex_object_t *obj,
 	if (type == NULL)
 		return -EBADR;
 
+	mas->request = g_new0(struct mas_request, 1);
+
+	/* NOTE: type is case-insensitive! */
+	if (g_ascii_strcasecmp(type, FOLDER_LISTING_TYPE) == 0)
+		mas->request->fid = MFID_GET_FOLDER_LISTING;
+	else if (g_ascii_strcasecmp(type, MESSAGES_LISTING_TYPE) == 0)
+		mas->request->fid = MFID_GET_MESSAGES_LISTING;
+	else if (g_ascii_strcasecmp(type, MESSAGE_TYPE) == 0)
+		mas->request->fid = MFID_GET_MESSAGE;
+	else {
+		DBG("Incorrect type: %s", type);
+		ret = -EBADR;
+		goto fail;
+	}
+
 	*stream = FALSE;
 
 	ret = obex_get_stream_start(os, name);
@@ -147,6 +179,7 @@ static int mas_get(struct obex_session *os, obex_object_t *obj,
 
 	return 0;
 fail:
+	reset_request(mas);
 	return ret;
 }
 
@@ -162,12 +195,30 @@ static int mas_put(struct obex_session *os, obex_object_t *obj, void *user_data)
 	if (type == NULL)
 		return -EBADR;
 
+	mas->request = g_new0(struct mas_request, 1);
+
+	/* NOTE: type is case-insensitive! */
+	if (g_ascii_strcasecmp(type, NOTIFICATION_TYPE) == 0)
+		mas->request->fid = MFID_SET_NOTIFICATION_REGISTRATION;
+	else if (g_ascii_strcasecmp(type, STATUS_TYPE) == 0)
+		mas->request->fid = MFID_SET_MESSAGE_STATUS;
+	else if (g_ascii_strcasecmp(type, MESSAGE_TYPE) == 0)
+		mas->request->fid = MFID_PUSH_MESSAGE;
+	else if (g_ascii_strcasecmp(type, UPDATE_TYPE) == 0)
+		mas->request->fid = MFID_UPDATE_INBOX;
+	else {
+		DBG("Incorrect type: %s", type);
+		ret = -EBADR;
+		goto fail;
+	}
+
 	ret = obex_put_stream_start(os, name);
 	if (ret < 0)
 		goto fail;
 
 	return 0;
 fail:
+	reset_request(mas);
 	return ret;
 }
 
@@ -225,8 +276,12 @@ static ssize_t any_read(void *obj, void *buf, size_t count,
 
 static int any_close(void *obj)
 {
+	struct mas_session *mas = obj;
+
 	DBG("");
 
+	reset_request(mas);
+
 	return 0;
 }
 
diff --git a/plugins/messages.h b/plugins/messages.h
index 2a41ea7..ccbb0af 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -20,3 +20,18 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
+
+enum messages_function_id {
+	MFID_INVALID = 0,
+	MFID_SET_NOTIFICATION_REGISTRATION,
+	MFID_GET_FOLDER_LISTING,
+	MFID_GET_MESSAGES_LISTING,
+	MFID_GET_MESSAGE,
+	MFID_SET_MESSAGE_STATUS,
+	MFID_PUSH_MESSAGE,
+	MFID_UPDATE_INBOX,
+};
+
+struct mas_request {
+	enum messages_function_id fid;
+};
-- 
1.7.1

