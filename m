Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 05/26] android/hal-audio: Make RTP header optional
Date: Mon, 26 May 2014 15:16:31 +0200
Message-ID: <1401110212-11526-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Not every codec on A2DP will use RTP so it's now optional - codec can
be defined to use it and core will take care of filling the data.
---
 android/hal-audio-sbc.c |  3 ++-
 android/hal-audio.c     | 30 ++++++++++++++++++++++--------
 android/hal-audio.h     |  5 +++++
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/android/hal-audio-sbc.c b/android/hal-audio-sbc.c
index 8366978..ad20f51 100644
--- a/android/hal-audio-sbc.c
+++ b/android/hal-audio-sbc.c
@@ -56,7 +56,7 @@ struct rtp_payload {
 #endif
 
 struct media_packet_sbc {
-	struct media_packet hdr;
+	struct media_packet_rtp hdr;
 	struct rtp_payload payload;
 	uint8_t data[0];
 };
@@ -405,6 +405,7 @@ static bool sbc_update_qos(void *codec_data, uint8_t op)
 
 static const struct audio_codec codec = {
 	.type = A2DP_CODEC_SBC,
+	.use_rtp = true,
 
 	.get_presets = sbc_get_presets,
 
diff --git a/android/hal-audio.c b/android/hal-audio.c
index 49393e2..946a835 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -467,7 +467,9 @@ static bool open_endpoint(struct audio_endpoint *ep,
 
 	DBG("mtu=%u", mtu);
 
-	payload_len = mtu - sizeof(*ep->mp);
+	payload_len = mtu;
+	if (ep->codec->use_rtp)
+		payload_len -= sizeof(struct rtp_header);
 
 	ep->fd = fd;
 
@@ -478,9 +480,14 @@ static bool open_endpoint(struct audio_endpoint *ep,
 	ep->mp = calloc(mtu, 1);
 	if (!ep->mp)
 		goto failed;
-	ep->mp->hdr.v = 2;
-	ep->mp->hdr.pt = 0x60;
-	ep->mp->hdr.ssrc = htonl(1);
+
+	if (ep->codec->use_rtp) {
+		struct media_packet_rtp *mp_rtp =
+					(struct media_packet_rtp *) ep->mp;
+		mp_rtp->hdr.v = 2;
+		mp_rtp->hdr.pt = 0x60;
+		mp_rtp->hdr.ssrc = htonl(1);
+	}
 
 	ep->mp_data_len = payload_len;
 
@@ -574,7 +581,7 @@ static bool write_to_endpoint(struct audio_endpoint *ep, size_t bytes)
 	int ret;
 
 	while (true) {
-		ret = write(ep->fd, mp, sizeof(*mp) + bytes);
+		ret = write(ep->fd, mp, bytes);
 
 		if (ret >= 0)
 			break;
@@ -604,6 +611,7 @@ static bool write_data(struct a2dp_stream_out *out, const void *buffer,
 {
 	struct audio_endpoint *ep = out->ep;
 	struct media_packet *mp = (struct media_packet *) ep->mp;
+	struct media_packet_rtp *mp_rtp = (struct media_packet_rtp *) ep->mp;
 	size_t free_space = ep->mp_data_len;
 	size_t consumed = 0;
 
@@ -620,8 +628,10 @@ static bool write_data(struct a2dp_stream_out *out, const void *buffer,
 		 * prepare media packet in advance so we don't waste time after
 		 * wakeup
 		 */
-		mp->hdr.sequence_number = htons(ep->seq++);
-		mp->hdr.timestamp = htonl(ep->samples);
+		if (ep->codec->use_rtp) {
+			mp_rtp->hdr.sequence_number = htons(ep->seq++);
+			mp_rtp->hdr.timestamp = htonl(ep->samples);
+		}
 		read = ep->codec->encode_mediapacket(ep->codec_data,
 						buffer + consumed,
 						bytes - consumed, mp,
@@ -687,9 +697,13 @@ static bool write_data(struct a2dp_stream_out *out, const void *buffer,
 			if (!wait_for_endpoint(ep, &do_write))
 				return false;
 
-			if (do_write)
+			if (do_write) {
+				if (ep->codec->use_rtp)
+					written += sizeof(struct rtp_header);
+
 				if (!write_to_endpoint(ep, written))
 					return false;
+			}
 		}
 
 		/*
diff --git a/android/hal-audio.h b/android/hal-audio.h
index dc1a812..be71473 100644
--- a/android/hal-audio.h
+++ b/android/hal-audio.h
@@ -57,6 +57,10 @@ struct rtp_header {
 #endif
 
 struct media_packet {
+	uint8_t data[0];
+};
+
+struct media_packet_rtp {
 	struct rtp_header hdr;
 	uint8_t data[0];
 };
@@ -69,6 +73,7 @@ struct audio_input_config {
 
 struct audio_codec {
 	uint8_t type;
+	bool use_rtp;
 
 	int (*get_presets) (struct audio_preset *preset, size_t *len);
 
-- 
1.9.3

