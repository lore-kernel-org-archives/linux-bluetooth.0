Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 21/28] android/haltest: Correct check for similar buffer size
Date: Wed,  4 Jun 2014 17:17:52 +0300
Message-Id: <1401891479-11965-21-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The new check takes into account number of channels.
---
 android/client/if-sco.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index 555c6f9..35ed3b0 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -354,16 +354,21 @@ fail:
 
 static void loop_p(int argc, const char **argv)
 {
+	int chan_out, chan_in;
+
 	RETURN_IF_NULL(if_audio_sco);
 	RETURN_IF_NULL(stream_out);
 	RETURN_IF_NULL(stream_in);
 
+	chan_out = popcount(stream_out->common.get_channels(&stream_out->common));
+	chan_in = popcount(stream_in->common.get_channels(&stream_in->common));
+
 	if (!buffer_size || !buffer_size_in) {
 		haltest_error("Invalid buffer sizes. Streams opened\n");
 		return;
 	}
 
-	if (buffer_size != buffer_size_in) {
+	if (buffer_size / chan_out != buffer_size_in / chan_in) {
 		haltest_error("read/write buffers differ, not supported\n");
 		return;
 	}
-- 
1.8.3.2

