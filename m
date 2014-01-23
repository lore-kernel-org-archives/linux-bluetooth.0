Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/hal-audio: Check calloc return value
Date: Thu, 23 Jan 2014 17:43:26 +0200
Message-Id: <1390491807-11095-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

calloc() might return NULL and is usually checked for NULL in BlueZ.
---
 android/hal-audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 4326ccd..2fbb956 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -320,6 +320,8 @@ static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
 	}
 
 	sbc_data = calloc(sizeof(struct sbc_data), 1);
+	if (!sbc_data)
+		return AUDIO_STATUS_FAILED;
 
 	memcpy(&sbc_data->sbc, preset->data, preset->len);
 
-- 
1.8.3.2

