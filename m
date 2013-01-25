Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ] avctp: Handle Vol Up/Down operations
Date: Fri, 25 Jan 2013 14:54:58 -0300
Message-Id: <1359136498-18725-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The AVRCP spec mandates to support 'volume up' and 'volume down'
operations when claiming support for Category 2 TG.
---
 profiles/audio/avctp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index d2dce3e..28c414d 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -213,6 +213,8 @@ static struct {
 	uint8_t avc;
 	uint16_t uinput;
 } key_map[] = {
+	{ "VOLUME UP",		AVC_VOLUME_UP,		KEY_VOLUMEUP},
+	{ "VOLUME DOWN",	AVC_VOLUME_DOWN,	KEY_VOLUMEDOWN},
 	{ "PLAY",		AVC_PLAY,		KEY_PLAYCD },
 	{ "STOP",		AVC_STOP,		KEY_STOPCD },
 	{ "PAUSE",		AVC_PAUSE,		KEY_PAUSECD },
-- 
1.7.11.7

