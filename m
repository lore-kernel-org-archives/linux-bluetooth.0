Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Simplify media_owner_remove
Date: Mon, 28 Mar 2011 18:52:20 +0300
Message-Id: <1301327540-5699-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Since there is only one pending request and is directly acessible via
owner pointer there is no need for media_owner_remove to take the
request as parameter.
---
 audio/transport.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 795b794..8ff6c85 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -154,10 +154,13 @@ static gboolean media_transport_release(struct media_transport *transport,
 	return TRUE;
 }
 
-static void media_owner_remove(struct media_owner *owner,
-						struct media_request *req)
+static void media_owner_remove(struct media_owner *owner)
 {
 	struct media_transport *transport = owner->transport;
+	struct media_request *req = owner->pending;
+
+	if (!req)
+		return;
 
 	DBG("Owner %s Request %s", owner->name,
 					dbus_message_get_member(req->msg));
@@ -176,8 +179,7 @@ static void media_owner_free(struct media_owner *owner)
 {
 	DBG("Owner %s", owner->name);
 
-	if (owner->pending)
-		media_owner_remove(owner, owner->pending);
+	media_owner_remove(owner);
 
 	g_free(owner->name);
 	g_free(owner->accesstype);
@@ -272,7 +274,7 @@ static void a2dp_resume_complete(struct avdtp *session,
 	if (ret == FALSE)
 		goto fail;
 
-	media_owner_remove(owner, req);
+	media_owner_remove(owner);
 
 	return;
 
@@ -317,7 +319,7 @@ static void a2dp_suspend_complete(struct avdtp *session,
 	if (owner->pending) {
 		owner->pending->id = 0;
 		media_request_reply(owner->pending, transport->conn, 0);
-		media_owner_remove(owner, owner->pending);
+		media_owner_remove(owner);
 	}
 
 	a2dp_sep_unlock(sep, transport->session);
@@ -383,7 +385,7 @@ static void headset_resume_complete(struct audio_device *dev, void *user_data)
 	if (ret == FALSE)
 		goto fail;
 
-	media_owner_remove(owner, req);
+	media_owner_remove(owner);
 
 	return;
 
@@ -418,7 +420,7 @@ static void headset_suspend_complete(struct audio_device *dev, void *user_data)
 	if (owner->pending) {
 		owner->pending->id = 0;
 		media_request_reply(owner->pending, transport->conn, 0);
-		media_owner_remove(owner, owner->pending);
+		media_owner_remove(owner);
 	}
 
 	headset_unlock(dev, HEADSET_LOCK_READ | HEADSET_LOCK_WRITE);
@@ -451,8 +453,7 @@ static void media_owner_exit(DBusConnection *connection, void *user_data)
 
 	owner->watch = 0;
 
-	if (owner->pending != NULL)
-		media_owner_remove(owner, owner->pending);
+	media_owner_remove(owner);
 
 	media_transport_remove(owner->transport, owner);
 }
@@ -615,7 +616,7 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 			member = dbus_message_get_member(owner->pending->msg);
 			/* Cancel Acquire request if that exist */
 			if (g_str_equal(member, "Acquire"))
-				media_owner_remove(owner, owner->pending);
+				media_owner_remove(owner);
 			else
 				return btd_error_in_progress(msg);
 		}
-- 
1.7.1

