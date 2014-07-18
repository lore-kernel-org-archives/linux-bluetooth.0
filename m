Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 15/21] android/hal-sco: Get SCO audio fd on demand
Date: Fri, 18 Jul 2014 12:48:14 +0300
Message-Id: <1405676900-17703-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When SCO fd is not known try to get it from the daemon. SCO is
established via handsfree HAL independently from Audio HAL.
---
 android/hal-sco.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 79c13dc..1627b83 100644
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
 
@@ -445,7 +446,7 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 
 	DBG("write to fd %d bytes %zu", sco_fd, bytes);
 
-	if (sco_fd < 0)
+	if (ipc_connect_sco() != SCO_STATUS_SUCCESS)
 		return -1;
 
 	if (!out->downmix_buf) {
@@ -1009,7 +1010,7 @@ static ssize_t in_read(struct audio_stream_in *stream, void *buffer,
 
 	DBG("Read from fd %d bytes %zu", sco_fd, bytes);
 
-	if (sco_fd < 0)
+	if (ipc_connect_sco() != SCO_STATUS_SUCCESS)
 		return -1;
 
 	if (!in->resampler && in->cfg.rate != AUDIO_STREAM_SCO_RATE) {
-- 
1.9.1

