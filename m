Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v3 7/9] media: Automatically release transport when HUP
Date: Fri,  7 Sep 2012 17:20:31 +0200
Message-Id: <1347031233-21621-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1347031233-21621-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1347031233-21621-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

When the remote end suspends the audio stream, release the transport
automatically without waiting until the clients call Release().

This affects the D-Bus API since clients will get an error when trying
to release the transport afterwards.

However, this should have no real impact, since most clients (i.e.
PulseAudio) would just log some error trace but otherwise ignore the
issue.
---
 audio/transport.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 8055791..79fa38d 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -61,7 +61,6 @@ typedef enum {
 	TRANSPORT_STATE_PENDING,	/* Playing but not acquired */
 	TRANSPORT_STATE_REQUESTING,	/* Acquire in progress */
 	TRANSPORT_STATE_ACQUIRED,	/* Acquired and playing */
-	TRANSPORT_STATE_POST_ACQUIRE,	/* Acquired but later suspended */
 	TRANSPORT_STATE_SUSPENDING,     /* Release in progress */
 } transport_state_t;
 
@@ -70,7 +69,6 @@ static char *str_state[] = {
 	"TRANSPORT_STATE_PENDING",
 	"TRANSPORT_STATE_REQUESTING",
 	"TRANSPORT_STATE_ACQUIRED",
-	"TRANSPORT_STATE_POST_ACQUIRE",
 	"TRANSPORT_STATE_SUSPENDING",
 };
 
@@ -165,7 +163,6 @@ static gboolean state_in_use(transport_state_t state)
 		return FALSE;
 	case TRANSPORT_STATE_REQUESTING:
 	case TRANSPORT_STATE_ACQUIRED:
-	case TRANSPORT_STATE_POST_ACQUIRE:
 	case TRANSPORT_STATE_SUSPENDING:
 		return TRUE;
 	}
@@ -1150,10 +1147,18 @@ static void transport_update_playing(struct media_transport *transport,
 					str_state[transport->state], playing);
 
 	if (playing == FALSE) {
-		if (transport->state == TRANSPORT_STATE_ACQUIRED)
-			transport_set_state(transport,
-						TRANSPORT_STATE_POST_ACQUIRE);
-		else if (transport->state == TRANSPORT_STATE_PENDING)
+		if (transport->state == TRANSPORT_STATE_ACQUIRED) {
+			/* Remove all owners */
+			while (transport->owners != NULL) {
+				struct media_owner *owner;
+
+				owner = transport->owners->data;
+				media_transport_remove(transport, owner);
+			}
+
+			/* Suspend so that the locks get released */
+			transport->suspend(transport, NULL);
+		} else if (transport->state == TRANSPORT_STATE_PENDING)
 			transport_set_state(transport, TRANSPORT_STATE_IDLE);
 	} else if (transport->state == TRANSPORT_STATE_IDLE)
 		transport_set_state(transport, TRANSPORT_STATE_PENDING);
-- 
1.7.7.6

