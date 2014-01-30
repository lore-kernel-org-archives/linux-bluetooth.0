Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 11/15] android/client-audio: Add set_parameters
Date: Thu, 30 Jan 2014 12:23:17 +0100
Message-Id: <1391081001-30723-12-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add seting output stream parameters using key=value pairs string
(key1=value1;key2=value2).

---
 android/client/if-audio.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index 0746124..bbd6a8c 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -407,6 +407,19 @@ static void get_parameters_p(int argc, const char **argv)
 								keystr));
 }
 
+static void set_parameters_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_audio);
+	RETURN_IF_NULL(stream_out);
+
+	if (argc < 3) {
+		haltest_error("No key=value; pairs given.\n");
+		return;
+	}
+
+	stream_out->common.set_parameters(&stream_out->common, argv[2]);
+}
+
 static struct method methods[] = {
 	STD_METHOD(init),
 	STD_METHOD(cleanup),
@@ -422,6 +435,7 @@ static struct method methods[] = {
 	STD_METHOD(get_format),
 	STD_METHOD(get_sample_rate),
 	STD_METHODH(get_parameters, "<A2dpSuspended;closing>"),
+	STD_METHODH(set_parameters, "<A2dpSuspended=value;closing=value>"),
 	END_METHOD
 };
 
-- 
1.8.5.2

