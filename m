Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 08/15] android/client-audio: Add getting audio format
Date: Thu, 30 Jan 2014 12:23:14 +0100
Message-Id: <1391081001-30723-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Get current audio format for output stream.

---
 android/client/if-audio.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index 1c9baff..45c00f3 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -69,6 +69,24 @@ SINTMAP(audio_channel_mask_t, -1, "(AUDIO_CHANNEL_INVALID)")
 	DELEMENT(AUDIO_CHANNEL_OUT_FRONT_LEFT),
 ENDMAP
 
+SINTMAP(audio_format_t, -1, "(AUDIO_FORMAT_INVALID)")
+	DELEMENT(AUDIO_FORMAT_DEFAULT),
+	DELEMENT(AUDIO_FORMAT_PCM),
+	DELEMENT(AUDIO_FORMAT_MP3),
+	DELEMENT(AUDIO_FORMAT_AMR_NB),
+	DELEMENT(AUDIO_FORMAT_AMR_WB),
+	DELEMENT(AUDIO_FORMAT_AAC),
+	DELEMENT(AUDIO_FORMAT_HE_AAC_V1),
+	DELEMENT(AUDIO_FORMAT_HE_AAC_V2),
+	DELEMENT(AUDIO_FORMAT_VORBIS),
+	DELEMENT(AUDIO_FORMAT_MAIN_MASK),
+	DELEMENT(AUDIO_FORMAT_SUB_MASK),
+	DELEMENT(AUDIO_FORMAT_PCM_16_BIT),
+	DELEMENT(AUDIO_FORMAT_PCM_8_BIT),
+	DELEMENT(AUDIO_FORMAT_PCM_32_BIT),
+	DELEMENT(AUDIO_FORMAT_PCM_8_24_BIT),
+ENDMAP
+
 static int current_state = STATE_STOPPED;
 
 static void init_p(int argc, const char **argv)
@@ -349,6 +367,18 @@ static void get_channels_p(int argc, const char **argv)
 	haltest_info("Channels: %s\n", audio_channel_mask_t2str(channels));
 }
 
+static void get_format_p(int argc, const char **argv)
+{
+	audio_format_t format;
+
+	RETURN_IF_NULL(if_audio);
+	RETURN_IF_NULL(stream_out);
+
+	format = stream_out->common.get_format(&stream_out->common);
+
+	haltest_info("Format: %s\n", audio_format_t2str(format));
+}
+
 static struct method methods[] = {
 	STD_METHOD(init),
 	STD_METHOD(cleanup),
@@ -361,6 +391,7 @@ static struct method methods[] = {
 	STD_METHOD(get_latency),
 	STD_METHOD(get_buffer_size),
 	STD_METHOD(get_channels),
+	STD_METHOD(get_format),
 	END_METHOD
 };
 
-- 
1.8.5.2

