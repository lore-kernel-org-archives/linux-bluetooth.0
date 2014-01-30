Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 09/15] android/client-audio: Add getting sample rate
Date: Thu, 30 Jan 2014 12:23:15 +0100
Message-Id: <1391081001-30723-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Get current sample rate for output stream.

---
 android/client/if-audio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index 45c00f3..4a45cac 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -379,6 +379,15 @@ static void get_format_p(int argc, const char **argv)
 	haltest_info("Format: %s\n", audio_format_t2str(format));
 }
 
+static void get_sample_rate_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_audio);
+	RETURN_IF_NULL(stream_out);
+
+	haltest_info("Current sample rate: %d\n",
+		stream_out->common.get_sample_rate(&stream_out->common));
+}
+
 static struct method methods[] = {
 	STD_METHOD(init),
 	STD_METHOD(cleanup),
@@ -392,6 +401,7 @@ static struct method methods[] = {
 	STD_METHOD(get_buffer_size),
 	STD_METHOD(get_channels),
 	STD_METHOD(get_format),
+	STD_METHOD(get_sample_rate),
 	END_METHOD
 };
 
-- 
1.8.5.2

