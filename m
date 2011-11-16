Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 10/17] sdp-client: Fix errno handling convention
Date: Wed, 16 Nov 2011 09:19:57 -0400
Message-Id: <1321449604-4188-11-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variables which are assigned to the errno variable (usually called
"err") should be negative, and "-err" should be used where a positive
value is needed.
---
 src/sdp-client.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/sdp-client.c b/src/sdp-client.c
index ebd760e..f119313 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -217,22 +217,22 @@ static gboolean connect_watch(GIOChannel *chan, GIOCondition cond,
 	sdp_list_t *search, *attrids;
 	uint32_t range = 0x0000ffff;
 	socklen_t len;
-	int sk, err = 0;
+	int sk, err, sk_err = 0;
 
 	sk = g_io_channel_unix_get_fd(chan);
 	ctxt->io_id = 0;
 
-	len = sizeof(err);
-	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &err, &len) < 0) {
-		err = errno;
-		goto failed;
-	}
+	len = sizeof(sk_err);
+	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
+		err = -errno;
+	else
+		err = -sk_err;
 
 	if (err != 0)
 		goto failed;
 
 	if (sdp_set_notify(ctxt->session, search_completed_cb, ctxt) < 0) {
-		err = EIO;
+		err = -EIO;
 		goto failed;
 	}
 
@@ -242,7 +242,7 @@ static gboolean connect_watch(GIOChannel *chan, GIOCondition cond,
 				search, SDP_ATTR_REQ_RANGE, attrids) < 0) {
 		sdp_list_free(attrids, NULL);
 		sdp_list_free(search, NULL);
-		err = EIO;
+		err = -EIO;
 		goto failed;
 	}
 
@@ -260,7 +260,7 @@ failed:
 	ctxt->session = NULL;
 
 	if (ctxt->cb)
-		ctxt->cb(NULL, -err, ctxt->user_data);
+		ctxt->cb(NULL, err, ctxt->user_data);
 
 	search_context_cleanup(ctxt);
 
-- 
1.7.0.4

