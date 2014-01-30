Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 07/15] android/client-audio: Add get_channels
Date: Thu, 30 Jan 2014 12:23:13 +0100
Message-Id: <1391081001-30723-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Get audio channels configuration.

---
 android/client/if-audio.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index 2b158a5..1c9baff 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -36,6 +36,39 @@ enum state {
 	STATE_MAX
 };
 
+SINTMAP(audio_channel_mask_t, -1, "(AUDIO_CHANNEL_INVALID)")
+	DELEMENT(AUDIO_CHANNEL_OUT_FRONT_LEFT),
+	DELEMENT(AUDIO_CHANNEL_OUT_FRONT_RIGHT),
+	DELEMENT(AUDIO_CHANNEL_OUT_FRONT_CENTER),
+	DELEMENT(AUDIO_CHANNEL_OUT_LOW_FREQUENCY),
+	DELEMENT(AUDIO_CHANNEL_OUT_BACK_LEFT),
+	DELEMENT(AUDIO_CHANNEL_OUT_BACK_RIGHT),
+	DELEMENT(AUDIO_CHANNEL_OUT_FRONT_LEFT_OF_CENTER),
+	DELEMENT(AUDIO_CHANNEL_OUT_FRONT_RIGHT_OF_CENTER),
+	DELEMENT(AUDIO_CHANNEL_OUT_BACK_CENTER),
+	DELEMENT(AUDIO_CHANNEL_OUT_SIDE_LEFT),
+	DELEMENT(AUDIO_CHANNEL_OUT_SIDE_RIGHT),
+	DELEMENT(AUDIO_CHANNEL_OUT_TOP_CENTER),
+	DELEMENT(AUDIO_CHANNEL_OUT_TOP_FRONT_LEFT),
+	DELEMENT(AUDIO_CHANNEL_OUT_TOP_FRONT_CENTER),
+	DELEMENT(AUDIO_CHANNEL_OUT_TOP_FRONT_RIGHT),
+	DELEMENT(AUDIO_CHANNEL_OUT_TOP_BACK_LEFT),
+	DELEMENT(AUDIO_CHANNEL_OUT_TOP_BACK_CENTER),
+	DELEMENT(AUDIO_CHANNEL_OUT_TOP_BACK_RIGHT),
+	DELEMENT(AUDIO_CHANNEL_OUT_MONO),
+	DELEMENT(AUDIO_CHANNEL_OUT_STEREO),
+	DELEMENT(AUDIO_CHANNEL_OUT_QUAD),
+	DELEMENT(AUDIO_CHANNEL_OUT_SURROUND),
+	DELEMENT(AUDIO_CHANNEL_OUT_5POINT1),
+	DELEMENT(AUDIO_CHANNEL_OUT_7POINT1),
+	DELEMENT(AUDIO_CHANNEL_OUT_ALL),
+	DELEMENT(AUDIO_CHANNEL_OUT_FRONT_LEFT),
+	DELEMENT(AUDIO_CHANNEL_OUT_FRONT_LEFT),
+	DELEMENT(AUDIO_CHANNEL_OUT_FRONT_LEFT),
+	DELEMENT(AUDIO_CHANNEL_OUT_FRONT_LEFT),
+	DELEMENT(AUDIO_CHANNEL_OUT_FRONT_LEFT),
+ENDMAP
+
 static int current_state = STATE_STOPPED;
 
 static void init_p(int argc, const char **argv)
@@ -304,6 +337,18 @@ static void get_buffer_size_p(int argc, const char **argv)
 		stream_out->common.get_buffer_size(&stream_out->common));
 }
 
+static void get_channels_p(int argc, const char **argv)
+{
+	audio_channel_mask_t channels;
+
+	RETURN_IF_NULL(if_audio);
+	RETURN_IF_NULL(stream_out);
+
+	channels = stream_out->common.get_channels(&stream_out->common);
+
+	haltest_info("Channels: %s\n", audio_channel_mask_t2str(channels));
+}
+
 static struct method methods[] = {
 	STD_METHOD(init),
 	STD_METHOD(cleanup),
@@ -315,6 +360,7 @@ static struct method methods[] = {
 	STD_METHOD(resume),
 	STD_METHOD(get_latency),
 	STD_METHOD(get_buffer_size),
+	STD_METHOD(get_channels),
 	END_METHOD
 };
 
-- 
1.8.5.2

