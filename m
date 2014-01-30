Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 10/15] android/client-audio: Add get_parameters for output
Date: Thu, 30 Jan 2014 12:23:16 +0100
Message-Id: <1391081001-30723-11-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Get current parameters for the audio stream.

---
 android/client/if-audio.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index 4a45cac..0746124 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -388,6 +388,25 @@ static void get_sample_rate_p(int argc, const char **argv)
 		stream_out->common.get_sample_rate(&stream_out->common));
 }
 
+static void get_parameters_p(int argc, const char **argv)
+{
+	const char *keystr;
+
+	RETURN_IF_NULL(if_audio);
+	RETURN_IF_NULL(stream_out);
+
+	if (argc < 3) {
+		haltest_info("No keys given.\n");
+		keystr = "";
+	} else {
+		keystr = argv[2];
+	}
+
+	haltest_info("Current parameters: %s\n",
+			stream_out->common.get_parameters(&stream_out->common,
+								keystr));
+}
+
 static struct method methods[] = {
 	STD_METHOD(init),
 	STD_METHOD(cleanup),
@@ -402,6 +421,7 @@ static struct method methods[] = {
 	STD_METHOD(get_channels),
 	STD_METHOD(get_format),
 	STD_METHOD(get_sample_rate),
+	STD_METHODH(get_parameters, "<A2dpSuspended;closing>"),
 	END_METHOD
 };
 
-- 
1.8.5.2

