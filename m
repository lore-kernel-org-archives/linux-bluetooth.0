Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v5 3/4] media: Automatically release transport when HUP
Date: Fri, 14 Sep 2012 14:55:59 +0200
Message-Id: <1347627360-13997-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1347627360-13997-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1347627360-13997-1-git-send-email-mikel.astiz.oss@gmail.com>
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
 audio/transport.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 742cc72..4653cc7 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -60,7 +60,7 @@ typedef enum {
 	TRANSPORT_STATE_IDLE,		/* Not acquired and suspended */
 	TRANSPORT_STATE_PENDING,	/* Playing but not acquired */
 	TRANSPORT_STATE_REQUESTING,	/* Acquire in progress */
-	TRANSPORT_STATE_ACTIVE,		/* Acquired (not necessarily playing) */
+	TRANSPORT_STATE_ACTIVE,		/* Acquired and playing */
 	TRANSPORT_STATE_SUSPENDING,     /* Release in progress */
 } transport_state_t;
 
@@ -1178,6 +1178,18 @@ static void transport_update_playing(struct media_transport *transport,
 	if (playing == FALSE) {
 		if (transport->state == TRANSPORT_STATE_PENDING)
 			transport_set_state(transport, TRANSPORT_STATE_IDLE);
+		else if (transport->state == TRANSPORT_STATE_ACTIVE) {
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
+		}
 	} else if (transport->state == TRANSPORT_STATE_IDLE)
 		transport_set_state(transport, TRANSPORT_STATE_PENDING);
 }
-- 
1.7.7.6

