Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 12/15] android/client-audio: Add setting sample rate
Date: Thu, 30 Jan 2014 12:23:18 +0100
Message-Id: <1391081001-30723-13-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add setting sample rate for output stream.

---
 android/client/if-audio.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index bbd6a8c..48b973b 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -420,6 +420,17 @@ static void set_parameters_p(int argc, const char **argv)
 	stream_out->common.set_parameters(&stream_out->common, argv[2]);
 }
 
+static void set_sample_rate_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_audio);
+	RETURN_IF_NULL(stream_out);
+
+	if (argc < 3)
+		return;
+
+	stream_out->common.set_sample_rate(&stream_out->common, atoi(argv[2]));
+}
+
 static struct method methods[] = {
 	STD_METHOD(init),
 	STD_METHOD(cleanup),
@@ -436,6 +447,7 @@ static struct method methods[] = {
 	STD_METHOD(get_sample_rate),
 	STD_METHODH(get_parameters, "<A2dpSuspended;closing>"),
 	STD_METHODH(set_parameters, "<A2dpSuspended=value;closing=value>"),
+	STD_METHODH(set_sample_rate, "<sample rate>"),
 	END_METHOD
 };
 
-- 
1.8.5.2

