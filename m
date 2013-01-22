Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 2/2] avctp: Receive and silent ignore Vol Up/Down operations
Date: Tue, 22 Jan 2013 15:18:23 -0300
Message-Id: <1358878703-8100-3-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1358878703-8100-1-git-send-email-jprvita@openbossa.org>
References: <1358878703-8100-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The AVRCP spec mandates to support 'volume up' and 'volume down'
operations when claiming support for Category 2 TG.
---
 profiles/audio/avctp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index f7e607e..4ab6d6d 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -214,6 +214,8 @@ static struct {
 	uint8_t avc;
 	uint16_t uinput;
 } key_map[] = {
+	{ "VOLUME UP",		AVC_VOLUME_UP,		KEY_VOLUMEUP},
+	{ "VOLUME DOWN",	AVC_VOLUME_DOWN,	KEY_VOLUMEDOWN},
 	{ "PLAY",		AVC_PLAY,		KEY_PLAYCD },
 	{ "STOP",		AVC_STOP,		KEY_STOPCD },
 	{ "PAUSE",		AVC_PAUSE,		KEY_PAUSECD },
@@ -968,6 +970,9 @@ static void init_uinput(struct avctp *session)
 
 	dev = manager_get_audio_device(session->device, FALSE);
 
+	session->key_quirks[AVC_VOLUME_UP] |= QUIRK_IGNORE;
+	session->key_quirks[AVC_VOLUME_DOWN] |= QUIRK_IGNORE;
+
 	device_get_name(dev->btd_dev, name, sizeof(name));
 	if (g_str_equal(name, "Nokia CK-20W")) {
 		session->key_quirks[AVC_FORWARD] |= QUIRK_NO_RELEASE;
-- 
1.7.11.7

