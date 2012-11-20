Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio: Auto connect AVRCP in case of A2DP source is connected
Date: Tue, 20 Nov 2012 11:13:01 +0200
Message-Id: <1353402781-21791-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables the same logic used for A2DP sink, so it attempt to
connect AVRCP if remote device support it.

Note this is necessary for some devices e.g. WP7 that don't connect
even when being the initiator because it is not mandatory for target
to do so even though it is recommended to avoid collisions while trying
to estabilish the connection.
---
 profiles/audio/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index df57d81..5176a60 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -269,7 +269,7 @@ static void device_avdtp_cb(struct audio_device *dev, struct avdtp *session,
 				avdtp_session_state_t new_state,
 				void *user_data)
 {
-	if (!dev->sink || !dev->control)
+	if (!dev->control)
 		return;
 
 	if (new_state == AVDTP_SESSION_STATE_CONNECTED) {
-- 
1.7.11.7

