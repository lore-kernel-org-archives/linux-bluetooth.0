Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH] audio: Fix typo
Date: Sat,  5 Jun 2010 23:46:43 -0300
Message-Id: <1275792403-5535-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index dfe7145..1dd3f5b 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -204,7 +204,7 @@ static void newconnection_reply(DBusPendingCall *call, void *data)
 
 	dbus_error_init(&derr);
 	if (!dbus_set_error_from_message(&derr, reply)) {
-		DBG("Agent reply: file descriptor passed successfuly");
+		DBG("Agent reply: file descriptor passed successfully");
 		change_state(dev, GATEWAY_STATE_CONNECTED);
 		goto done;
 	}
@@ -234,7 +234,7 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
 	}
 
 	if (!gw->agent) {
-		error("Handfree Agent not registered");
+		error("Handsfree Agent not registered");
 		goto fail;
 	}
 
-- 
1.7.1

