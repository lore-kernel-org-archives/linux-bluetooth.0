Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 27/28] android/hal-sco: Disconnect SCO audio on standby()
Date: Wed,  4 Jun 2014 17:17:58 +0300
Message-Id: <1401891479-11965-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index b4667e5..fc12b50 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -545,7 +545,11 @@ static int out_set_format(struct audio_stream *stream, audio_format_t format)
 
 static int out_standby(struct audio_stream *stream)
 {
-	DBG("");
+	DBG("stream %p", stream);
+
+	pthread_mutex_lock(&sco_mutex);
+	sco_close_socket();
+	pthread_mutex_unlock(&sco_mutex);
 
 	return 0;
 }
-- 
1.8.3.2

