Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] android/hal-sco: Use bdaddr parameter in Get SCO fd command
Date: Wed,  5 Nov 2014 10:41:22 +0200
Message-Id: <1415176882-12397-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415176882-12397-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415176882-12397-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 442e2d0..6c4e975 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -281,20 +281,23 @@ failed:
 	return SCO_STATUS_FAILED;
 }
 
-static int ipc_get_sco_fd(void)
+static int ipc_get_sco_fd(bt_bdaddr_t *bd_addr)
 {
 	int ret = SCO_STATUS_SUCCESS;
 
 	pthread_mutex_lock(&sco_mutex);
 
 	if (sco_fd < 0) {
+		struct sco_cmd_get_fd cmd;
 		struct sco_rsp_get_fd rsp;
 		size_t rsp_len = sizeof(rsp);
 
 		DBG("Getting SCO fd");
 
-		ret = sco_ipc_cmd(SCO_SERVICE_ID, SCO_OP_GET_FD, 0, NULL,
-						&rsp_len, &rsp, &sco_fd);
+		memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+		ret = sco_ipc_cmd(SCO_SERVICE_ID, SCO_OP_GET_FD, sizeof(cmd),
+						&cmd, &rsp_len, &rsp, &sco_fd);
 
 		/* Sometimes mtu returned is wrong */
 		sco_mtu = /* rsp.mtu */ 48;
@@ -453,7 +456,7 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 
 	DBG("write to fd %d bytes %zu", sco_fd, bytes);
 
-	if (ipc_get_sco_fd() != SCO_STATUS_SUCCESS)
+	if (ipc_get_sco_fd(&out->bd_addr) != SCO_STATUS_SUCCESS)
 		return -1;
 
 	if (!out->downmix_buf) {
@@ -645,9 +648,6 @@ static int sco_open_output_stream_real(struct audio_hw_device *dev,
 		return -EIO;
 	}
 
-	if (ipc_get_sco_fd() != SCO_STATUS_SUCCESS)
-		DBG("SCO is not connected yet; get fd on write()");
-
 	out = calloc(1, sizeof(struct sco_stream_out));
 	if (!out)
 		return -ENOMEM;
@@ -679,6 +679,9 @@ static int sco_open_output_stream_real(struct audio_hw_device *dev,
 	}
 #endif
 
+	if (ipc_get_sco_fd(&out->bd_addr) != SCO_STATUS_SUCCESS)
+		DBG("SCO is not connected yet; get fd on write()");
+
 	if (config) {
 		DBG("config: rate %u chan mask %x format %d offload %p",
 				config->sample_rate, config->channel_mask,
@@ -1063,7 +1066,7 @@ static ssize_t in_read(struct audio_stream_in *stream, void *buffer,
 
 	DBG("Read from fd %d bytes %zu", sco_fd, bytes);
 
-	if (ipc_get_sco_fd() != SCO_STATUS_SUCCESS)
+	if (ipc_get_sco_fd(&in->bd_addr) != SCO_STATUS_SUCCESS)
 		return -1;
 
 	if (!in->resampler && in->cfg.rate != AUDIO_STREAM_SCO_RATE) {
-- 
1.9.1

