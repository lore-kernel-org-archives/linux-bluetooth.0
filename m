Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 13/15] android/client-audio: Add init_check
Date: Thu, 30 Jan 2014 12:23:19 +0100
Message-Id: <1391081001-30723-14-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add calling init check for audio device.

---
 android/client/if-audio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index 48b973b..b481461 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -431,6 +431,13 @@ static void set_sample_rate_p(int argc, const char **argv)
 	stream_out->common.set_sample_rate(&stream_out->common, atoi(argv[2]));
 }
 
+static void init_check_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_audio);
+
+	haltest_info("Init check result: %d\n", if_audio->init_check(if_audio));
+}
+
 static struct method methods[] = {
 	STD_METHOD(init),
 	STD_METHOD(cleanup),
@@ -448,6 +455,7 @@ static struct method methods[] = {
 	STD_METHODH(get_parameters, "<A2dpSuspended;closing>"),
 	STD_METHODH(set_parameters, "<A2dpSuspended=value;closing=value>"),
 	STD_METHODH(set_sample_rate, "<sample rate>"),
+	STD_METHOD(init_check),
 	END_METHOD
 };
 
-- 
1.8.5.2

