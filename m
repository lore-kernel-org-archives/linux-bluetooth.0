Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 03/10] android/hal-audio: Rename sbc_init to avoid collision with libsbc
Date: Wed, 22 Jan 2014 11:34:46 +0100
Message-ID: <1390386893-8212-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1390386893-8212-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1390386893-8212-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 2f6f8c2..f53dba0 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -56,7 +56,7 @@ struct sbc_data {
 };
 
 static int sbc_get_presets(struct audio_preset *preset, size_t *len);
-static int sbc_init(struct audio_preset *preset, void **codec_data);
+static int sbc_codec_init(struct audio_preset *preset, void **codec_data);
 static int sbc_cleanup(void *codec_data);
 static int sbc_get_config(void *codec_data,
 					struct audio_input_config *config);
@@ -80,7 +80,7 @@ static const struct audio_codec audio_codecs[] = {
 
 		.get_presets = sbc_get_presets,
 
-		.init = sbc_init,
+		.init = sbc_codec_init,
 		.cleanup = sbc_cleanup,
 		.get_config = sbc_get_config,
 	}
@@ -184,7 +184,7 @@ static int sbc_get_presets(struct audio_preset *preset, size_t *len)
 	return i;
 }
 
-static int sbc_init(struct audio_preset *preset, void **codec_data)
+static int sbc_codec_init(struct audio_preset *preset, void **codec_data)
 {
 	struct sbc_data *sbc_data;
 
-- 
1.8.5.2

