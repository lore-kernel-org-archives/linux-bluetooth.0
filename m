Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] android/hal-audio: Check calloc return value
Date: Fri, 31 Jan 2014 16:18:46 +0200
Message-Id: <1391177929-31416-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

calloc() might return NULL and is usually checked for NULL in BlueZ.
---
 android/hal-audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index b1323b0..35bafe7 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -313,6 +313,8 @@ static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
 	}
 
 	sbc_data = calloc(sizeof(struct sbc_data), 1);
+	if (!sbc_data)
+		return AUDIO_STATUS_FAILED;
 
 	memcpy(&sbc_data->sbc, preset->data, preset->len);
 
-- 
1.8.3.2

