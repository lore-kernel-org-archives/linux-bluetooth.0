Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 06/15] android/client-audio: Add get_buffer_size for output
Date: Thu, 30 Jan 2014 12:23:12 +0100
Message-Id: <1391081001-30723-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Get buffer size for output stream.

---
 android/client/if-audio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index 1ca84f5..2b158a5 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -295,6 +295,15 @@ static void get_latency_p(int argc, const char **argv)
 					stream_out->get_latency(stream_out));
 }
 
+static void get_buffer_size_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_audio);
+	RETURN_IF_NULL(stream_out);
+
+	haltest_info("Current output buffer size: %d\n",
+		stream_out->common.get_buffer_size(&stream_out->common));
+}
+
 static struct method methods[] = {
 	STD_METHOD(init),
 	STD_METHOD(cleanup),
@@ -305,6 +314,7 @@ static struct method methods[] = {
 	STD_METHOD(suspend),
 	STD_METHOD(resume),
 	STD_METHOD(get_latency),
+	STD_METHOD(get_buffer_size),
 	END_METHOD
 };
 
-- 
1.8.5.2

