Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH obexd v2 2/4] Split up session_create in separate functions
Date: Wed, 29 Jun 2011 00:40:40 +0300
Message-Id: <1309297242-4154-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1309297242-4154-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1309297242-4154-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Connection of RFCOMM and SDP are extracted from session_create function
into session_connect. Such allows making asynchronous calls before
creating connections.
---
 client/session.c |   41 ++++++++++++++++++++++++-----------------
 1 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/client/session.c b/client/session.c
index c894526..e6b95de 100644
--- a/client/session.c
+++ b/client/session.c
@@ -533,6 +533,29 @@ static struct session_data *session_find(const char *source,
 	return NULL;
 }
 
+static int session_connect(struct session_data *session,
+						struct callback_data *callback)
+{
+	int err;
+
+	if (session->obex) {
+		g_idle_add(connection_complete, callback);
+		err = 0;
+	} else if (session->channel > 0) {
+		session->io = rfcomm_connect(&session->src, &session->dst,
+							session->channel,
+							rfcomm_callback,
+							callback);
+		err = (session->io == NULL) ? -EINVAL : 0;
+	} else {
+		callback->sdp = service_connect(&session->src, &session->dst,
+						service_callback, callback);
+		err = (callback->sdp == NULL) ? -ENOMEM : 0;
+	}
+
+	return err;
+}
+
 struct session_data *session_create(const char *source,
 						const char *destination,
 						const char *service,
@@ -543,7 +566,6 @@ struct session_data *session_create(const char *source,
 {
 	struct session_data *session;
 	struct callback_data *callback;
-	int err;
 
 	if (destination == NULL)
 		return NULL;
@@ -612,22 +634,7 @@ proceed:
 	callback->func = function;
 	callback->data = user_data;
 
-	if (session->obex) {
-		g_idle_add(connection_complete, callback);
-		err = 0;
-	} else if (session->channel > 0) {
-		session->io = rfcomm_connect(&session->src, &session->dst,
-							session->channel,
-							rfcomm_callback,
-							callback);
-		err = (session->io == NULL) ? -EINVAL : 0;
-	} else {
-		callback->sdp = service_connect(&session->src, &session->dst,
-						service_callback, callback);
-		err = (callback->sdp == NULL) ? -ENOMEM : 0;
-	}
-
-	if (err < 0) {
+	if (session_connect(session, callback) < 0) {
 		session_unref(session);
 		g_free(callback);
 		return NULL;
-- 
1.7.4.1

