Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 05/15] android/client-audio: Add get_latency for output
Date: Thu, 30 Jan 2014 12:23:11 +0100
Message-Id: <1391081001-30723-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Get output stream latency.

---
 android/client/if-audio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index 985b60c..1ca84f5 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -286,6 +286,15 @@ static void resume_p(int argc, const char **argv)
 	pthread_mutex_unlock(&state_mutex);
 }
 
+static void get_latency_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_audio);
+	RETURN_IF_NULL(stream_out);
+
+	haltest_info("Output audio stream latency: %d\n",
+					stream_out->get_latency(stream_out));
+}
+
 static struct method methods[] = {
 	STD_METHOD(init),
 	STD_METHOD(cleanup),
@@ -295,6 +304,7 @@ static struct method methods[] = {
 	STD_METHOD(stop),
 	STD_METHOD(suspend),
 	STD_METHOD(resume),
+	STD_METHOD(get_latency),
 	END_METHOD
 };
 
-- 
1.8.5.2

