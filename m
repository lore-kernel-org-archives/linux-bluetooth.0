Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 26/28] android/hal-sco: Connect SCO audio on demand
Date: Wed,  4 Jun 2014 17:17:57 +0300
Message-Id: <1401891479-11965-26-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 955f511..b4667e5 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -280,15 +280,16 @@ failed:
 
 static int ipc_connect_sco(void)
 {
-	struct sco_rsp_connect rsp;
-	size_t rsp_len = sizeof(rsp);
 	int ret = SCO_STATUS_SUCCESS;
 
-	DBG("");
-
 	pthread_mutex_lock(&sco_mutex);
 
 	if (sco_fd < 0) {
+		struct sco_rsp_connect rsp;
+		size_t rsp_len = sizeof(rsp);
+
+		DBG("Connecting SCO");
+
 		ret = sco_ipc_cmd(SCO_SERVICE_ID, SCO_OP_CONNECT, 0, NULL,
 						&rsp_len, &rsp, &sco_fd);
 
@@ -443,7 +444,7 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 
 	DBG("write to fd %d bytes %zu", sco_fd, bytes);
 
-	if (sco_fd < 0)
+	if (ipc_connect_sco() != SCO_STATUS_SUCCESS)
 		return -1;
 
 	if (!out->downmix_buf) {
@@ -1007,7 +1008,7 @@ static ssize_t in_read(struct audio_stream_in *stream, void *buffer,
 
 	DBG("Read from fd %d bytes %zu", sco_fd, bytes);
 
-	if (sco_fd < 0)
+	if (ipc_connect_sco() != SCO_STATUS_SUCCESS)
 		return -1;
 
 	if (!in->resampler && in->cfg.rate != AUDIO_STREAM_SCO_RATE) {
-- 
1.8.3.2

