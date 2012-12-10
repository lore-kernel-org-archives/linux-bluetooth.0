Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ] audio: remove unused field from audio_device
Date: Mon, 10 Dec 2012 15:52:26 -0300
Message-Id: <1355165546-20587-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/device.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/audio/device.h b/profiles/audio/device.h
index a45ef21..2c98355 100644
--- a/profiles/audio/device.h
+++ b/profiles/audio/device.h
@@ -39,7 +39,6 @@ struct audio_device {
 	struct sink *sink;
 	struct source *source;
 	struct control *control;
-	struct target *target;
 
 	struct dev_priv *priv;
 };
-- 
1.7.11.7

