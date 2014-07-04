Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 27/32] android/hal-sco: Disconnect SCO audio on standby()
Date: Fri,  4 Jul 2014 16:47:12 +0300
Message-Id: <1404481637-900-28-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 1627b83..4cec753 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -547,7 +547,11 @@ static int out_set_format(struct audio_stream *stream, audio_format_t format)
 
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
1.9.1

