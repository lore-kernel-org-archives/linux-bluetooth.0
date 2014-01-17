Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/9] android: Add MTU data to Open Stream Audio IPC
Date: Fri, 17 Jan 2014 16:40:05 +0100
Message-ID: <1389973213-30251-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389973213-30251-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389973213-30251-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MTU value for transport channel is sent in Open Stream response, which
is required to calculate number of frames which can be packed into
single media packet.

This is to avoid including GPLv2 licensed headers in Audio HAL
implementation.
---
 android/a2dp.c      | 8 ++++++--
 android/audio-msg.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 2288912..e7ca8b8 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -1252,6 +1252,7 @@ static void bt_stream_open(const void *buf, uint16_t len)
 	struct audio_rsp_open_stream *rsp;
 	struct a2dp_setup *setup;
 	int fd;
+	uint16_t omtu;
 
 	DBG("");
 
@@ -1262,14 +1263,17 @@ static void bt_stream_open(const void *buf, uint16_t len)
 		return;
 	}
 
-	if (!avdtp_stream_get_transport(setup->stream, &fd, NULL, NULL, NULL)) {
+	if (!avdtp_stream_get_transport(setup->stream, &fd, NULL, &omtu,
+						NULL)) {
 		error("avdtp_stream_get_transport: failed");
 		audio_ipc_send_rsp(AUDIO_OP_OPEN_STREAM, AUDIO_STATUS_FAILED);
 		return;
 	}
 
-	len = sizeof(struct audio_preset) + setup->preset->len;
+	len = sizeof(struct audio_rsp_open_stream) +
+			sizeof(struct audio_preset) + setup->preset->len;
 	rsp = g_malloc0(len);
+	rsp->mtu = omtu;
 	rsp->preset->len = setup->preset->len;
 	memcpy(rsp->preset->data, setup->preset->data, setup->preset->len);
 
diff --git a/android/audio-msg.h b/android/audio-msg.h
index 8f03274..17cde09 100644
--- a/android/audio-msg.h
+++ b/android/audio-msg.h
@@ -63,6 +63,7 @@ struct audio_cmd_open_stream {
 } __attribute__((packed));
 
 struct audio_rsp_open_stream {
+	uint16_t mtu;
 	struct audio_preset preset[0];
 } __attribute__((packed));
 
-- 
1.8.5.2

