Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] audio: Fix calling device_profile_connected on disconnected cases
Date: Wed, 19 Dec 2012 13:27:01 +0200
Message-Id: <1355916421-29304-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355916421-29304-1-git-send-email-luiz.dentz@gmail.com>
References: <1355916421-29304-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 1f49aa3..0f6a4f7 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -485,7 +485,7 @@ void audio_sink_connected(struct btd_device *dev, int err)
 
 void audio_sink_disconnected(struct btd_device *dev, int err)
 {
-	device_profile_connected(dev, &a2dp_sink_profile, err);
+	device_profile_disconnected(dev, &a2dp_sink_profile, err);
 }
 
 void audio_source_connected(struct btd_device *dev, int err)
@@ -495,7 +495,7 @@ void audio_source_connected(struct btd_device *dev, int err)
 
 void audio_source_disconnected(struct btd_device *dev, int err)
 {
-	device_profile_connected(dev, &a2dp_source_profile, err);
+	device_profile_disconnected(dev, &a2dp_source_profile, err);
 }
 
 void audio_control_connected(struct btd_device *dev, int err)
-- 
1.7.11.7

