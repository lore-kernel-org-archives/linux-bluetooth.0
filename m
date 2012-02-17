Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC obexd 1/3] core: Fix queueing packet containing error while suspended
Date: Fri, 17 Feb 2012 15:11:46 +0200
Message-Id: <1329484308-8417-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Queueing the error won't remove the original packet created by transfer
from the queue so upon resume gobex will attempt to send it again.

To fix this we no longer create a error packet instead the session is
market as aborted and the error stored so when gobex finally resumes the
error is forward properly.
---
 src/obex-priv.h |    1 +
 src/obex.c      |   10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/obex-priv.h b/src/obex-priv.h
index 5b72942..41854bc 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -43,6 +43,7 @@ struct obex_session {
 	int64_t size;
 	void *object;
 	gboolean aborted;
+	int err;
 	struct obex_service_driver *service;
 	void *service_data;
 	struct obex_server *server;
diff --git a/src/obex.c b/src/obex.c
index 05cc068..a028156 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -554,7 +554,7 @@ static gssize send_data(void *buf, gsize size, gpointer user_data)
 									size);
 
 	if (os->aborted)
-		return -EPERM;
+		return os->err < 0 ? os->err : -EPERM;
 
 	return driver_read(os, buf, size);
 }
@@ -594,7 +594,7 @@ static int driver_get_headers(struct obex_session *os)
 	DBG("name=%s type=%s object=%p", os->name, os->type, os->object);
 
 	if (os->aborted)
-		return -EPERM;
+		return os->err < 0 ? os->err : -EPERM;
 
 	if (os->object == NULL)
 		return -EIO;
@@ -661,8 +661,10 @@ static gboolean handle_async_io(void *object, int flags, int err,
 		return TRUE;
 
 done:
-	if (err < 0)
-		os_set_response(os, err);
+	if (err < 0) {
+		os->err = err;
+		os->aborted = TRUE;
+	}
 
 	g_obex_resume(os->obex);
 
-- 
1.7.7.6

