Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 04/17] audio/PCM: Fix errno handling convention
Date: Wed, 16 Nov 2011 09:19:51 -0400
Message-Id: <1321449604-4188-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variables which are assigned to the errno variable (usually called
"err") should be negative, and "-err" should be used where a positive
value is needed.
---
 audio/pcm_bluetooth.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index e633d1a..4d85f33 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -420,9 +420,10 @@ static int bluetooth_prepare(snd_pcm_ioplug_t *io)
 	}
 
 	/* wake up any client polling at us */
-	err = write(data->pipefd[1], &c, 1);
-	if (err < 0)
+	if (write(data->pipefd[1], &c, 1) < 0) {
+		err = -errno;
 		return err;
+	}
 
 	return 0;
 }
@@ -968,7 +969,7 @@ static snd_pcm_sframes_t bluetooth_a2dp_read(snd_pcm_ioplug_t *io,
 
 static int avdtp_write(struct bluetooth_data *data)
 {
-	int ret = 0;
+	int err;
 	struct rtp_header *header;
 	struct rtp_payload *payload;
 	struct bluetooth_a2dp *a2dp = &data->a2dp;
@@ -985,10 +986,10 @@ static int avdtp_write(struct bluetooth_data *data)
 	header->timestamp = htonl(a2dp->nsamples);
 	header->ssrc = htonl(1);
 
-	ret = send(data->stream.fd, a2dp->buffer, a2dp->count, MSG_DONTWAIT);
-	if (ret < 0) {
-		DBG("send returned %d errno %s.", ret, strerror(errno));
-		ret = -errno;
+	err = send(data->stream.fd, a2dp->buffer, a2dp->count, MSG_DONTWAIT);
+	if (err < 0) {
+		err = -errno;
+		DBG("send failed: %s (%d)", strerror(-err), -err);
 	}
 
 	/* Reset buffer of data to send */
@@ -997,7 +998,7 @@ static int avdtp_write(struct bluetooth_data *data)
 	a2dp->samples = 0;
 	a2dp->seq_num++;
 
-	return ret;
+	return err;
 }
 
 static snd_pcm_sframes_t bluetooth_a2dp_write(snd_pcm_ioplug_t *io,
@@ -1546,7 +1547,7 @@ static int audioservice_send(int sk, const bt_audio_msg_header_t *msg)
 	else {
 		err = -errno;
 		SNDERR("Error sending data to audio service: %s(%d)",
-			strerror(errno), errno);
+			strerror(-err), -err);
 	}
 
 	return err;
@@ -1567,7 +1568,7 @@ static int audioservice_recv(int sk, bt_audio_msg_header_t *inmsg)
 	if (ret < 0) {
 		err = -errno;
 		SNDERR("Error receiving IPC data from bluetoothd: %s (%d)",
-						strerror(errno), errno);
+						strerror(-err), -err);
 	} else if ((size_t) ret < sizeof(bt_audio_msg_header_t)) {
 		SNDERR("Too short (%d bytes) IPC packet from bluetoothd", ret);
 		err = -EINVAL;
-- 
1.7.0.4

