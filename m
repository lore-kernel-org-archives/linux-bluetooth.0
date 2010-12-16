Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix not calling SetConfiguration on hfp/hsp endpoints before connected
Date: Thu, 16 Dec 2010 16:13:20 +0200
Message-Id: <1292508801-15581-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This cause some clients like PulseAudio to fail to find a proper
transport since connected state is send before transport configuration
is set.

To fix this now SetConfiguration is called early on when headset is still
in connecting phase, this matches sink/source where SetConfiguration is
also called before connected.
---
 audio/media.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 0e6ccc9..b28bb33 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -151,16 +151,13 @@ static void headset_state_changed(struct audio_device *dev,
 
 	switch (new_state) {
 	case HEADSET_STATE_DISCONNECTED:
-		if (old_state != HEADSET_STATE_CONNECTING)
-			media_endpoint_clear_configuration(endpoint);
+		media_endpoint_clear_configuration(endpoint);
+		break;
 	case HEADSET_STATE_CONNECTING:
+		media_endpoint_set_configuration(endpoint, dev, NULL, 0,
+						headset_setconf_cb, dev);
 		break;
 	case HEADSET_STATE_CONNECTED:
-		if (old_state != HEADSET_STATE_PLAY_IN_PROGRESS &&
-				old_state != HEADSET_STATE_PLAYING)
-			media_endpoint_set_configuration(endpoint, dev, NULL,
-							0, headset_setconf_cb,
-									dev);
 		break;
 	case HEADSET_STATE_PLAY_IN_PROGRESS:
 		break;
-- 
1.7.1

