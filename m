Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Wait SCO socket to HUP before changing state
Date: Thu, 24 Mar 2011 14:09:53 +0200
Message-Id: <1300968593-25442-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1300968593-25442-1-git-send-email-luiz.dentz@gmail.com>
References: <1300968593-25442-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

In situations where application wants to switch profiles e.g hfp to a2dp
it normally needs to wait SCO to be disconnected to resume a2dp due to
resource limitations on headset.

There seems to be an issue in the kernel side which prevent this to work
properly, apparently shutdown does not wait the link to be disconnected,
but it is under investigation.
---
 audio/headset.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index bdaa8da..dff10d1 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1345,6 +1345,7 @@ static gboolean sco_cb(GIOChannel *chan, GIOCondition cond,
 
 	error("Audio connection got disconnected");
 
+	pending_connect_finalize(device);
 	headset_set_state(device, HEADSET_STATE_CONNECTED);
 
 	return FALSE;
@@ -2385,6 +2386,7 @@ unsigned int headset_suspend_stream(struct audio_device *dev,
 {
 	struct headset *hs = dev->headset;
 	unsigned int id;
+	int sock;
 
 	if (hs->state == HEADSET_STATE_DISCONNECTED ||
 				hs->state == HEADSET_STATE_CONNECTING)
@@ -2395,10 +2397,12 @@ unsigned int headset_suspend_stream(struct audio_device *dev,
 		hs->dc_timer = 0;
 	}
 
-	headset_set_state(dev, HEADSET_STATE_CONNECTED);
+	sock = g_io_channel_unix_get_fd(hs->sco);
+
+	/* shutdown but leave the socket open and wait for hup */
+	shutdown(sock, SHUT_RDWR);
 
 	id = connect_cb_new(hs, HEADSET_STATE_CONNECTED, cb, user_data);
-	g_idle_add((GSourceFunc) dummy_connect_complete, dev);
 
 	return id;
 }
-- 
1.7.1

