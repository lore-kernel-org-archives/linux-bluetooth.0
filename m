Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v1 5/5] media: Enable parallel requests to endpoint
Date: Fri, 27 Apr 2012 12:59:47 +0200
Message-Id: <1335524387-22831-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1335524387-22831-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1335524387-22831-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

If endpoint is handling several devices, it should be able to handle
multiple requests, one per each.
---
 audio/media.c |   46 ++++++++++++++++++++++++----------------------
 1 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 5cbf4a2..15f0a6e 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -67,6 +67,7 @@ struct media_adapter {
 };
 
 struct endpoint_request {
+	struct media_endpoint	*endpoint;
 	DBusMessage		*msg;
 	DBusPendingCall		*call;
 	media_endpoint_cb_t	cb;
@@ -85,7 +86,7 @@ struct media_endpoint {
 	guint			hs_watch;
 	guint			ag_watch;
 	guint			watch;
-	struct endpoint_request *request;
+	GSList			*requests;
 	struct media_adapter	*adapter;
 	GSList			*transports;
 };
@@ -127,15 +128,22 @@ static void endpoint_request_free(struct endpoint_request *request)
 	g_free(request);
 }
 
-static void media_endpoint_cancel(struct media_endpoint *endpoint)
+static void media_endpoint_cancel(struct endpoint_request *request)
 {
-	struct endpoint_request *request = endpoint->request;
+	struct media_endpoint *endpoint = request->endpoint;
 
 	if (request->call)
 		dbus_pending_call_cancel(request->call);
 
+	endpoint->requests = g_slist_remove(endpoint->requests, request);
+
 	endpoint_request_free(request);
-	endpoint->request = NULL;
+}
+
+static void media_endpoint_cancel_all(struct media_endpoint *endpoint)
+{
+	while (endpoint->requests != NULL)
+		media_endpoint_cancel(endpoint->requests->data);
 }
 
 static void media_endpoint_destroy(struct media_endpoint *endpoint)
@@ -150,8 +158,7 @@ static void media_endpoint_destroy(struct media_endpoint *endpoint)
 	if (endpoint->ag_watch)
 		gateway_remove_state_cb(endpoint->ag_watch);
 
-	if (endpoint->request)
-		media_endpoint_cancel(endpoint);
+	media_endpoint_cancel_all(endpoint);
 
 	g_slist_free_full(endpoint->transports,
 				(GDestroyNotify) media_transport_destroy);
@@ -228,8 +235,7 @@ done:
 
 static void clear_endpoint(struct media_endpoint *endpoint)
 {
-	if (endpoint->request)
-		media_endpoint_cancel(endpoint);
+	media_endpoint_cancel_all(endpoint);
 
 	while (endpoint->transports != NULL)
 		clear_configuration(endpoint, endpoint->transports->data);
@@ -237,8 +243,8 @@ static void clear_endpoint(struct media_endpoint *endpoint)
 
 static void endpoint_reply(DBusPendingCall *call, void *user_data)
 {
-	struct media_endpoint *endpoint = user_data;
-	struct endpoint_request *request = endpoint->request;
+	struct endpoint_request *request = user_data;
+	struct media_endpoint *endpoint = request->endpoint;
 	DBusMessage *reply;
 	DBusError err;
 	gboolean value;
@@ -299,9 +305,8 @@ done:
 	if (request->cb)
 		request->cb(endpoint, ret, size, request->user_data);
 
-	if (endpoint->request)
-		endpoint_request_free(endpoint->request);
-	endpoint->request = NULL;
+	endpoint->requests = g_slist_remove(endpoint->requests, request);
+	endpoint_request_free(request);
 }
 
 static gboolean media_endpoint_async_call(DBusConnection *conn,
@@ -313,9 +318,6 @@ static gboolean media_endpoint_async_call(DBusConnection *conn,
 {
 	struct endpoint_request *request;
 
-	if (endpoint->request)
-		return FALSE;
-
 	request = g_new0(struct endpoint_request, 1);
 
 	/* Timeout should be less than avdtp request timeout (4 seconds) */
@@ -326,13 +328,16 @@ static gboolean media_endpoint_async_call(DBusConnection *conn,
 		return FALSE;
 	}
 
-	dbus_pending_call_set_notify(request->call, endpoint_reply, endpoint, NULL);
+	dbus_pending_call_set_notify(request->call, endpoint_reply, request,
+									NULL);
 
+	request->endpoint = endpoint;
 	request->msg = msg;
 	request->cb = cb;
 	request->destroy = destroy;
 	request->user_data = user_data;
-	endpoint->request = request;
+
+	endpoint->requests = g_slist_append(endpoint->requests, request);
 
 	DBG("Calling %s: name = %s path = %s", dbus_message_get_member(msg),
 			dbus_message_get_destination(msg),
@@ -351,9 +356,6 @@ static gboolean select_configuration(struct media_endpoint *endpoint,
 	DBusConnection *conn;
 	DBusMessage *msg;
 
-	if (endpoint->request != NULL)
-		return FALSE;
-
 	conn = endpoint->adapter->conn;
 
 	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
@@ -412,7 +414,7 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 
 	transport = find_device_transport(endpoint, device);
 
-	if (transport != NULL || endpoint->request != NULL)
+	if (transport != NULL)
 		return FALSE;
 
 	conn = endpoint->adapter->conn;
-- 
1.7.7.6

