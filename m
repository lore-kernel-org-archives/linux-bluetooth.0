Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] audio: Remove auto_connect flag from audio-avrcp-target
Date: Thu, 23 May 2013 11:58:29 -0700
Message-Id: <1369335511-8874-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

By the time the profile is registered it is not really possible to
tell which role of AVRCP should be connected, currently this cause
a problem with headsets that normally are controllers/sink but since
it normally also has target record for features related to things like
volume control the target profile is also probed and as it currently
has the auto_connect set it would lead to the wrong profile to start
connecting.
---
 profiles/audio/manager.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 15226e4..1518e5d 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -376,7 +376,6 @@ static struct btd_profile avrcp_target_profile = {
 	.device_probe	= avrcp_probe,
 	.device_remove	= audio_remove,
 
-	.auto_connect	= true,
 	.connect	= avrcp_target_connect,
 	.disconnect	= avrcp_target_disconnect,
 
-- 
1.8.1.4

