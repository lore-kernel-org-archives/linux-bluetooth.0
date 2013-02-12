Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0] transport: Fix inconsistent transport state
Date: Tue, 12 Feb 2013 09:23:35 +0100
Message-Id: <1360657415-12864-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

If a2dp_resume() fails, the transport state should not be modified. It
would otherwise enter an incosistent state where the transport will be
impossible to resume, since acquire() will see the transport in
TRANSPORT_STATE_REQUESTING state and will thus return
btd_error_not_authorized().
---
 profiles/audio/transport.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 5b3fcbc..32ba50b 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -329,6 +329,7 @@ static guint resume_a2dp(struct media_transport *transport,
 	struct a2dp_transport *a2dp = transport->data;
 	struct media_endpoint *endpoint = transport->endpoint;
 	struct a2dp_sep *sep = media_endpoint_get_sep(endpoint);
+	guint id;
 
 	if (a2dp->session == NULL) {
 		a2dp->session = avdtp_get(transport->device);
@@ -337,16 +338,23 @@ static guint resume_a2dp(struct media_transport *transport,
 	}
 
 	if (state_in_use(transport->state))
-		goto done;
+		return a2dp_resume(a2dp->session, sep, a2dp_resume_complete,
+									owner);
 
 	if (a2dp_sep_lock(sep, a2dp->session) == FALSE)
 		return 0;
 
+	id = a2dp_resume(a2dp->session, sep, a2dp_resume_complete, owner);
+
+	if (id == 0) {
+		a2dp_sep_unlock(sep, a2dp->session);
+		return 0;
+	}
+
 	if (transport->state == TRANSPORT_STATE_IDLE)
 		transport_set_state(transport, TRANSPORT_STATE_REQUESTING);
 
-done:
-	return a2dp_resume(a2dp->session, sep, a2dp_resume_complete, owner);
+	return id;
 }
 
 static void a2dp_suspend_complete(struct avdtp *session,
-- 
1.8.1

