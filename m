Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix not replying Acquire request when resume fails
Date: Mon, 28 Mar 2011 18:27:21 +0300
Message-Id: <1301326041-4905-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Request must be replied before removed.
---
 audio/transport.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 3442e5f..795b794 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -191,6 +191,10 @@ static void media_transport_remove(struct media_transport *transport,
 
 	media_transport_release(transport, owner->accesstype);
 
+	/* Reply if owner has a pending request */
+	if (owner->pending)
+		media_request_reply(owner->pending, transport->conn, EIO);
+
 	transport->owners = g_slist_remove(transport->owners, owner);
 
 	if (owner->watch)
@@ -313,6 +317,7 @@ static void a2dp_suspend_complete(struct avdtp *session,
 	if (owner->pending) {
 		owner->pending->id = 0;
 		media_request_reply(owner->pending, transport->conn, 0);
+		media_owner_remove(owner, owner->pending);
 	}
 
 	a2dp_sep_unlock(sep, transport->session);
@@ -413,6 +418,7 @@ static void headset_suspend_complete(struct audio_device *dev, void *user_data)
 	if (owner->pending) {
 		owner->pending->id = 0;
 		media_request_reply(owner->pending, transport->conn, 0);
+		media_owner_remove(owner, owner->pending);
 	}
 
 	headset_unlock(dev, HEADSET_LOCK_READ | HEADSET_LOCK_WRITE);
-- 
1.7.1

