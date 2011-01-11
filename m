Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2 v2] Fix memory leak when calling endpoint method
Date: Tue, 11 Jan 2011 14:21:51 +0200
Message-Id: <1294748511-8393-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

The pending call must be unrefed in those cases
---
 audio/media.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 97a60a1..402709a 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -87,12 +87,23 @@ static GSList *adapters = NULL;
 static void endpoint_request_free(struct endpoint_request *request)
 {
 	if (request->call)
-		dbus_pending_call_cancel(request->call);
+		dbus_pending_call_unref(request->call);
 
 	dbus_message_unref(request->msg);
 	g_free(request);
 }
 
+static void media_endpoint_cancel(struct media_endpoint *endpoint)
+{
+	struct endpoint_request *request = endpoint->request;
+
+	if (request->call)
+		dbus_pending_call_cancel(request->call);
+
+	endpoint_request_free(request);
+	endpoint->request = NULL;
+}
+
 static void media_endpoint_remove(struct media_endpoint *endpoint)
 {
 	struct media_adapter *adapter = endpoint->adapter;
@@ -109,7 +120,7 @@ static void media_endpoint_remove(struct media_endpoint *endpoint)
 		headset_remove_state_cb(endpoint->hs_watch);
 
 	if (endpoint->request)
-		endpoint_request_free(endpoint->request);
+		media_endpoint_cancel(endpoint);
 
 	if (endpoint->transport)
 		media_transport_remove(endpoint->transport);
@@ -613,10 +624,8 @@ void media_endpoint_clear_configuration(struct media_endpoint *endpoint)
 	if (endpoint->transport == NULL)
 		return;
 
-	if (endpoint->request) {
-		endpoint_request_free(endpoint->request);
-		endpoint->request = NULL;
-	}
+	if (endpoint->request)
+		media_endpoint_cancel(endpoint);
 
 	conn = endpoint->adapter->conn;
 
-- 
1.7.1

