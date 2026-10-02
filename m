Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B291F3F5BE4
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969299; cv=none; b=uPFWrViVggXh1qwLZB13B5QFGB/1euNfP9bizdofXQU6l66aJ324Z+yejdzfd4IzB0Mi8Br3EbPj2K7HBVf/EJbfVccQuvnFLIHqNQ4CyRgYsjbWRrQUeVBLL3jxbkFuRj+QIWrcHoFPY7Oaet288vEL+mbYI5aSeAUiW3B5Cao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969299; c=relaxed/simple;
	bh=bAEQkmjYmOKvNNUkyHWpf6tPpqkICGylQ+Va+ipSkAE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfJDFQFWiSCGgNSpo7b9SkQy66p8gScQTzfGR8hXE81JhCu6W0Cj9TW0Trt20htFDGdX6JEmdp03tJR8QS22egJ8BjJas70NCwad3ePCNlLpkDqUaAEdtlR6FDn/CkyI0J2/5daL6d2UsQBu5ctNiMmEjwtNERChHmFfFBt+P+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDloNfmI; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDloNfmI"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-988d2fdcdc4so1056277241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790969292; x=1791574092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bX5LYA0Hl1QGjqEYe8sWizkHMjNRvkkNPfo9sDNETx8=;
        b=BDloNfmICR7dsmWbxop2MmvqO9pjlqg5xQUoerHvD4BwUHpn5RDWeYdH7Lb7VgQaCZ
         0//LbURFyUY6zimsa3e+fpCwDhVr2g6VrzGYdK+StPxMtCQ0DHOTujD1aw7Y8f1VVM70
         +j3RXeIYP2ZJ9V38npRKgvKp1eVs1JMoRDZK8C2MJC7pgan6ijV1SlIfQ2bfT9B3MNhY
         P6nvgZgb2/5OIJylNpn3fJHQch1K++lapKOXA2e5sejCsLWuc+6av1rlNSeqW5R8NViV
         X0dgbVtYyTBhZsuTJxYo5qUz3hqjwppgriX5iVxc2UmoZ53tRa3SMh4W/ZfjkUCHqabQ
         uj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790969292; x=1791574092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bX5LYA0Hl1QGjqEYe8sWizkHMjNRvkkNPfo9sDNETx8=;
        b=WITFibtntMQKmw4sDTCobKhd8xZL68goSUL9UPBFm1n4omM6y+mNmN8ZNp94knvx+C
         ONkCAuVcmKlvwnyiJBKPtowxp6RFUQ+QyvKQ584GPhe1IozY/bXdUy3N2ot9vBKhsPxu
         8T4WUoU8EeZzy85UeDtZQMtf23OACJz56N63nfVjF+aC8UYdxpu/aEL+Hpq9mfjGr6Wh
         9cuQwbgtBiHQsYiuyKNAE+vs6pr6l7PbChW9IvvXFTkYRR/iz0IuLGKh/lWwG9C0OmYX
         01suqROB/fEVsYOsk1okMhoShFMNVOhLJRG4ZlGey7Kpsa/5IXjARppswJJUItdOECXf
         SX9g==
X-Gm-Message-State: AFq9FYKUds9Jbr09x5AnC1AaGbiiW8a9wRn5A0U7ch+mLrzlULVyeaBJ
	lAIg6QAaisr1KaWOvPuckKdQwgWa4G9PyluEH5SVhQqO/xkQxOoxkD/DnJ1GFH9C
X-Gm-Gg: AYBFou39xfvmYPnGK9vf4hOaOi5LYQte4jdWtgvVkrlcSFUKCAcHfwu/MDw9koDTK04
	po0jbh4f4t1CEQ7XSfTUlBN+LSMOPRoJ35KoYhdUN8d0ogSceAyWYdpOvGmRq79D9G2syGM4U3g
	vHhSHz5e2NQ9frgot3dwJumDBkKGesfhAH+FjATKihYGIP8pZ5+mAJdp1T6jRhHvRvVIkD1UYkB
	d9b0rIIOOT73+RgP9/wfP+wNN3uhqFh+iWyhbGlBzfXWJimvkd133xFSHIXIrrvt97iKlia2tsT
	MKJpIQk1ICPAHMwQ67RyfkSTb8MXNQkSSfffA3Xo0UWSeWXLxPxraehf/3M2XR/byR5P4eHVKxp
	4vufT7XQzZnZf3umCuQwJ1TpCadpRjSyOUWmqJAeloZwfzb8eN6xduNEH3yvGAzqX828pjsKYkY
	hgqysd5Cngp+Fb1d858Eu+bH9Tu0LJu3WnW4muIZ+alTsq7uoDuXrKmIIr/bZfGglTZE+EM3cd0
	xmvRBRNjcbHq+ssZaFblyK94iTST0E9gBj/bw6sUdw3gGiVifpOuUmLFnofjR+N
X-Received: by 2002:a05:6102:5805:b0:7b2:43df:ca61 with SMTP id ada2fe7eead31-7c245ee2275mr150058137.30.1790969291889;
        Fri, 02 Oct 2026 12:28:11 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98b2f15ef60sm3857759241.12.2026.10.02.12.28.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:28:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ vRFC 7/7] monitor: Add audio quality statistics for A2DP streams
Date: Fri,  2 Oct 2026 15:27:59 -0400
Message-ID: <20261002192759.3071262-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002192759.3071262-1-luiz.dentz@gmail.com>
References: <20261002192759.3071262-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Track the RTP sequence numbers and timestamps of AVDTP media channels, in
both directions, with the clock rate derived from the arrival times. A
pause in the arrivals of a second or more, such as a suspended stream,
restarts the pacing instead of reporting a late packet:

< BR-ACL: Handle 256 [E8:EE:C.. flags 0x02 dlen 602  #15682 [hci0] 141.214796
      Channel: 41024 len 598 [PSM 25 mode Basic (0x00)] {chan 3}
        Late: +374.81 msec (interval 14.51 msec)

= Quality: A2DP 256 CID 0xa040                               [hci0] 36.379012
        TX loss: 0/345 (0.00%) burst max 0
        TX jitter: 0.12 msec late 0

  Found TX L2CAP channel with CID 41024
        ...
        TX RTP: payload type 96 clock 44100 Hz gaps 1
        TX loss: 0/14786 (0.00%) missing 0 dropped 0 invalid 0 partial 0
        TX jitter: 0.06 msec (max 915.34 msec, late 2)
        TX interval: 14.51 msec (0-929 msec, ~14 msec +/- 8 msec)

Assisted-by: OpenCode:claude-opus-5.5
---
 doc/btmon.rst     |   5 +-
 monitor/analyze.c |  13 +++
 monitor/avdtp.c   |  59 ++++++++++++
 monitor/packet.c  | 229 +++++++++++++++++++++++++++++++++++++---------
 monitor/packet.h  |  20 ++++
 5 files changed, 283 insertions(+), 43 deletions(-)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index fd19b73b22b3..9383fe74941b 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -96,8 +96,9 @@ OPTIONS
 -Q MSEC, --quality MSEC     Print a summary of the received audio stream
                             quality every MSEC milliseconds: erasures, the
                             longest burst of erasures, jitter and late
-                            samples. Only LE Audio isochronous streams are
-                            currently supported.
+                            samples. Covers LE Audio isochronous streams,
+                            SCO/eSCO data over HCI and the RTP of A2DP media
+                            channels.
 
 -E IP, --ellisys IP         Send Ellisys HCI Injection.
 
diff --git a/monitor/analyze.c b/monitor/analyze.c
index 2b5e3087197c..7e19b61978f9 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -132,6 +132,7 @@ struct l2cap_chan {
 	uint8_t mode;
 	bool out;
 	struct timeval last_rx;
+	struct packet_rtp rtp;
 	struct hci_stats rx;
 	struct hci_stats tx;
 };
@@ -301,6 +302,7 @@ static void chan_destroy(void *data)
 
 	print_stats(&chan->rx, "RX");
 	print_stats(&chan->tx, "TX");
+	packet_rtp_print(&chan->rtp, chan->out ? "TX" : "RX");
 
 done:
 	queue_destroy(chan->rx.plot, free);
@@ -1444,12 +1446,23 @@ static void acl_pkt(struct timeval *tv, uint16_t index, bool out,
 	switch (le16_to_cpu(hdr->handle) >> 12) {
 	case 0x00:
 	case 0x02:
+		/* The start of a frame carries the L2CAP header */
+		if (size < 4)
+			break;
+
 		cid = get_le16(data + 2);
 		chan = chan_lookup(conn, cid, out);
 		if (cid == 1)
 			l2cap_sig(conn, out, data + 4, size - 4);
 		else if (cid == 5)
 			l2cap_le_sig(conn, out, data + 4, size - 4);
+		else if (chan && cid >= 0x0040 &&
+				(chan->psm == 0x0019 || !chan->psm))
+			/*
+			 * AVDTP media transport, also attempted on channels
+			 * whose setup was not captured.
+			 */
+			packet_rtp_add(&chan->rtp, tv, data + 4, size - 4);
 		break;
 	}
 
diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index 9d0016d6bc56..4f08edf5ca95 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -768,6 +768,64 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 	return true;
 }
 
+#define MAX_STREAM 8
+
+/* Media transport channels, tracked for their RTP quality */
+static struct avdtp_stream {
+	bool used;
+	uint16_t index;
+	uint16_t handle;
+	uint16_t cid;
+	bool in;
+	struct packet_rtp rtp;
+	struct packet_quality q;
+} stream_list[MAX_STREAM];
+
+static struct avdtp_stream *stream_lookup(const struct l2cap_frame *frame)
+{
+	struct avdtp_stream *stream;
+	static unsigned int next;
+	int i;
+
+	for (i = 0; i < MAX_STREAM; i++) {
+		stream = &stream_list[i];
+
+		if (stream->used && stream->index == frame->index &&
+				stream->handle == frame->handle &&
+				stream->cid == frame->cid &&
+				stream->in == frame->in)
+			return stream;
+	}
+
+	/* Take over the oldest stream when all are used */
+	stream = &stream_list[next++ % MAX_STREAM];
+	memset(stream, 0, sizeof(*stream));
+	stream->used = true;
+	stream->index = frame->index;
+	stream->handle = frame->handle;
+	stream->cid = frame->cid;
+	stream->in = frame->in;
+
+	return stream;
+}
+
+static void avdtp_media_packet(const struct l2cap_frame *frame)
+{
+	struct avdtp_stream *stream = stream_lookup(frame);
+	struct timeval tv = frame->tv;
+	size_t erased = stream->rtp.loss.erased;
+	size_t late = stream->rtp.jitter.late;
+
+	if (!packet_rtp_add(&stream->rtp, timerisset(&tv) ? &tv : NULL,
+						frame->data, frame->size))
+		return;
+
+	packet_rtp_quality(timerisset(&tv) ? &tv : NULL, frame->index,
+				frame->handle, frame->cid,
+				frame->in, &stream->rtp, &stream->q, erased,
+				late);
+}
+
 void avdtp_packet(const struct l2cap_frame *frame)
 {
 	struct avdtp_frame avdtp_frame;
@@ -780,6 +838,7 @@ void avdtp_packet(const struct l2cap_frame *frame)
 		ret = avdtp_signalling_packet(&avdtp_frame);
 		break;
 	default:
+		avdtp_media_packet(frame);
 		if (packet_has_filter(PACKET_FILTER_SHOW_A2DP_STREAM))
 			packet_hexdump(frame->data, frame->size);
 		return;
diff --git a/monitor/packet.c b/monitor/packet.c
index c21c79f75971..def24c1c47d3 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12256,6 +12256,125 @@ void packet_jitter_add_ts(struct packet_jitter *jitter, struct timeval *tv,
 	jitter_add(jitter, tv, diff);
 }
 
+static const uint32_t rtp_rates[] = {
+	8000, 16000, 22050, 24000, 32000, 44100, 48000, 88200, 90000, 96000,
+};
+
+/* Number of samples to derive the RTP clock rate from */
+#define RTP_PROBE 100
+
+/* Pause in the arrivals that restarts the pacing, in seconds */
+#define RTP_GAP_SEC 1
+
+static uint32_t rtp_rate(uint64_t ts, uint64_t usec)
+{
+	uint32_t best = 0;
+	uint64_t rate, best_diff = UINT64_MAX;
+	size_t i;
+
+	if (!usec)
+		return 0;
+
+	rate = ts * 1000000 / usec;
+
+	for (i = 0; i < ARRAY_SIZE(rtp_rates); i++) {
+		uint64_t diff = rate > rtp_rates[i] ? rate - rtp_rates[i] :
+							rtp_rates[i] - rate;
+
+		if (diff < best_diff) {
+			best_diff = diff;
+			best = rtp_rates[i];
+		}
+	}
+
+	return best;
+}
+
+/*
+ * Account a RTP packet, which is recognized by its version and a dynamic
+ * payload type, the latter never matching an AVDTP signal identifier.
+ */
+bool packet_rtp_add(struct packet_rtp *rtp, struct timeval *tv,
+					const void *data, uint16_t size)
+{
+	const uint8_t *hdr = data;
+	uint16_t seq;
+	uint32_t ts, diff;
+	struct timeval delta;
+
+	if (size < 12 || (hdr[0] & 0xc0) != 0x80 || (hdr[1] & 0x7f) < 96)
+		return false;
+
+	seq = get_be16(hdr + 2);
+	ts = get_be32(hdr + 4);
+
+	packet_loss_add(&rtp->loss, seq, 0);
+	rtp->pt = hdr[1] & 0x7f;
+
+	if (!tv)
+		return true;
+
+	if (!rtp->probe++) {
+		rtp->first_tv = *tv;
+		rtp->first_ts = ts;
+		rtp->prev_ts = ts;
+		return true;
+	}
+
+	if (!rtp->rate) {
+		if (rtp->probe < RTP_PROBE)
+			return true;
+
+		timersub(tv, &rtp->first_tv, &delta);
+		rtp->rate = rtp_rate(ts - rtp->first_ts,
+				(uint64_t)delta.tv_sec * 1000000 +
+				delta.tv_usec);
+		if (!rtp->rate)
+			return true;
+
+		rtp->jitter.prev_tv = *tv;
+		rtp->jitter.have_prev = true;
+		rtp->prev_ts = ts;
+		return true;
+	}
+
+	diff = ts - rtp->prev_ts;
+
+	/* Leave the duplicates and the reorders out */
+	if (!diff || diff >= 0x80000000)
+		return true;
+
+	rtp->prev_ts = ts;
+
+	/*
+	 * A pause, such as the stream being suspended and started again,
+	 * restarts the pacing instead of accounting the packet as late.
+	 */
+	timersub(tv, &rtp->jitter.prev_tv, &delta);
+	if (delta.tv_sec >= RTP_GAP_SEC) {
+		rtp->jitter.prev_tv = *tv;
+		rtp->gaps++;
+		return true;
+	}
+
+	/* A packet is late once it misses the time its data takes to play */
+	rtp->jitter.interval = (uint64_t)diff * 1000000 / rtp->rate;
+	jitter_add(&rtp->jitter, tv, rtp->jitter.interval);
+
+	return true;
+}
+
+void packet_rtp_print(const struct packet_rtp *rtp, const char *label)
+{
+	if (!rtp->loss.total)
+		return;
+
+	print_field("%s RTP: payload type %u clock %u Hz gaps %zu", label,
+						rtp->pt, rtp->rate, rtp->gaps);
+	packet_loss_print(&rtp->loss, label);
+	packet_jitter_print(&rtp->jitter, label);
+}
+
 void packet_jitter_print(const struct packet_jitter *jitter,
 							const char *label)
 {
@@ -15391,14 +15510,12 @@ void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	packet_set_context(NULL, 0);
 }
 
-static void print_rx_quality(struct packet_conn_data *conn, size_t erased,
-				size_t late, uint8_t sflags, size_t burst)
+static void print_quality(struct packet_loss *loss,
+				struct packet_jitter *jitter, size_t erased,
+				size_t late, uint8_t status, size_t burst)
 {
-	struct packet_loss *loss = &conn->rx_loss;
-	struct packet_jitter *jitter = &conn->rx_jitter;
-
 	/* Only report the samples that revealed a loss or arrived late */
-	if (loss->erased != erased || sflags)
+	if (loss->erased != erased || status)
 		print_field("Lost: %zu/%zu (%zu.%02zu%%) missing %zu "
 				"dropped %zu invalid %zu partial %zu burst %zu",
 				loss->erased, loss->total,
@@ -15421,14 +15538,24 @@ void packet_set_quality_period(unsigned int msec)
 	quality_period = msec;
 }
 
-static void quality_summary(struct timeval *tv, struct ucred *cred,
-				uint16_t index, struct packet_conn_data *conn,
-				size_t burst)
+static void quality_window(struct packet_quality *q, struct timeval *tv,
+				struct packet_loss *loss,
+				struct packet_jitter *jitter)
+{
+	q->start = *tv;
+	q->erased = loss->erased;
+	q->total = loss->total;
+	q->late = jitter->late;
+	q->burst_max = loss->burst;
+}
+
+static void quality_summary(struct timeval *tv, uint16_t index,
+				const char *name, const char *dir,
+				struct packet_quality *q,
+				struct packet_loss *loss,
+				struct packet_jitter *jitter,
+				struct packet_latency *tx_l, size_t burst)
 {
-	struct packet_quality *q = &conn->rx_quality;
-	struct packet_loss *loss = &conn->rx_loss;
-	struct packet_jitter *jitter = &conn->rx_jitter;
-	char str[32];
 	struct timeval delta;
 	size_t erased, total;
 	uint64_t j;
@@ -15440,10 +15567,7 @@ static void quality_summary(struct timeval *tv, struct ucred *cred,
 		q->burst_max = burst;
 
 	if (!timerisset(&q->start)) {
-		q->start = *tv;
-		q->erased = loss->erased;
-		q->total = loss->total;
-		q->late = jitter->late;
+		quality_window(q, tv, loss, jitter);
 		return;
 	}
 
@@ -15455,45 +15579,68 @@ static void quality_summary(struct timeval *tv, struct ucred *cred,
 	total = loss->total - q->total;
 	j = jitter->jitter16 >> 4;
 
-	snprintf(str, sizeof(str), "%s %u", conn_type_str(conn->type),
-							conn->handle);
-	print_packet(tv, cred, '=', index, NULL, COLOR_SYSTEM_NOTE,
-						"Quality", str, NULL);
+	print_packet(tv, NULL, '=', index, NULL, COLOR_SYSTEM_NOTE,
+						"Quality", name, NULL);
 
-	print_field("RX loss: %zu/%zu (%zu.%02zu%%) burst max %zu", erased,
-			total, total ? erased * 100 / total : 0,
+	print_field("%s loss: %zu/%zu (%zu.%02zu%%) burst max %zu", dir,
+			erased, total, total ? erased * 100 / total : 0,
 			total ? (erased * 10000 / total) % 100 : 0,
 			q->burst_max);
 
 	if (jitter->delta.count)
-		print_field("RX jitter: %" PRIu64 ".%02" PRIu64 " msec "
-				"late %zu", j / 1000, (j % 1000) / 10,
+		print_field("%s jitter: %" PRIu64 ".%02" PRIu64 " msec "
+				"late %zu", dir, j / 1000, (j % 1000) / 10,
 				jitter->late - q->late);
 
-	if (conn->tx_l.count)
-		print_field("TX latency: ~%lld msec",
-						TV_MSEC(conn->tx_l.med));
+	if (tx_l && tx_l->count)
+		print_field("TX latency: ~%lld msec", TV_MSEC(tx_l->med));
 
-	q->start = *tv;
-	q->erased = loss->erased;
-	q->total = loss->total;
-	q->late = jitter->late;
-	q->burst_max = loss->burst;
+	quality_window(q, tv, loss, jitter);
 }
 
-static void rx_quality(struct timeval *tv, struct ucred *cred,
-				uint16_t index, struct packet_conn_data *conn,
-				size_t erased, size_t late, uint8_t status)
+static void stream_quality(struct timeval *tv, uint16_t index,
+				const char *name, const char *dir,
+				struct packet_quality *q,
+				struct packet_loss *loss,
+				struct packet_jitter *jitter,
+				struct packet_latency *tx_l, size_t erased,
+				size_t late, uint8_t status)
 {
-	struct packet_loss *loss = &conn->rx_loss;
 	size_t burst = loss->burst;
 
 	/* A burst that this sample has just ended */
 	if (!burst && loss->erased != erased)
 		burst = loss->burst_last;
 
-	print_rx_quality(conn, erased, late, status, burst);
-	quality_summary(tv, cred, index, conn, burst);
+	print_quality(loss, jitter, erased, late, status, burst);
+	quality_summary(tv, index, name, dir, q, loss, jitter, tx_l, burst);
+}
+
+static void rx_quality(struct timeval *tv, uint16_t index,
+				struct packet_conn_data *conn, size_t erased,
+				size_t late, uint8_t status)
+{
+	char name[32];
+
+	snprintf(name, sizeof(name), "%s %u", conn_type_str(conn->type),
+							conn->handle);
+
+	stream_quality(tv, index, name, "RX", &conn->rx_quality,
+				&conn->rx_loss, &conn->rx_jitter, &conn->tx_l,
+				erased, late, status);
+}
+
+void packet_rtp_quality(struct timeval *tv, uint16_t index, uint16_t handle,
+				uint16_t cid, bool in, struct packet_rtp *rtp,
+				struct packet_quality *q, size_t erased,
+				size_t late)
+{
+	char name[32];
+
+	snprintf(name, sizeof(name), "A2DP %u CID 0x%4.4x", handle, cid);
+
+	stream_quality(tv, index, name, in ? "RX" : "TX", q, &rtp->loss,
+				&rtp->jitter, NULL, erased, late, 0);
 }
 
 static void sco_rx_quality(struct timeval *tv, struct ucred *cred,
@@ -15622,7 +15769,7 @@ static void sco_rx_quality(struct timeval *tv, struct ucred *cred,
 						conn->rx_jitter.interval);
 	}
 
-	rx_quality(tv, cred, index, conn, erased, late, status);
+	rx_quality(tv, index, conn, erased, late, status);
 }
 
 void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
@@ -15735,7 +15882,7 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				label, handle_str, extra_str);
 
 	if (in && have_hdr && conn)
-		rx_quality(tv, cred, index, conn, erased, late, sflags);
+		rx_quality(tv, index, conn, erased, late, sflags);
 
 	if (!in)
 		packet_enqueue_tx(tv, acl_handle(handle),
diff --git a/monitor/packet.h b/monitor/packet.h
index 77921af39263..3c57fa3f8e34 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -72,6 +72,19 @@ struct packet_jitter {
 	struct packet_latency delta;	/* Arrival intervals */
 };
 
+/* RTP media stream, the clock rate is derived from the arrival times */
+struct packet_rtp {
+	struct packet_loss loss;
+	struct packet_jitter jitter;
+	uint32_t rate;		/* Clock rate in Hz, 0 until known */
+	size_t probe;		/* Samples taken to derive the rate */
+	struct timeval first_tv;
+	uint32_t first_ts;
+	uint32_t prev_ts;
+	uint8_t pt;		/* Payload type */
+	size_t gaps;		/* Pauses, such as a suspended stream */
+};
+
 /* Window of the periodic quality summary */
 struct packet_quality {
 	struct timeval start;
@@ -145,6 +158,13 @@ void packet_jitter_add_ts(struct packet_jitter *jitter, struct timeval *tv,
 								uint32_t ts);
 void packet_jitter_print(const struct packet_jitter *jitter,
 							const char *label);
+bool packet_rtp_add(struct packet_rtp *rtp, struct timeval *tv,
+					const void *data, uint16_t size);
+void packet_rtp_print(const struct packet_rtp *rtp, const char *label);
+void packet_rtp_quality(struct timeval *tv, uint16_t index, uint16_t handle,
+				uint16_t cid, bool in, struct packet_rtp *rtp,
+				struct packet_quality *q, size_t erased,
+				size_t late);
 void packet_set_quality_period(unsigned int msec);
 
 void packet_get_context(struct timeval *tv, size_t *num);
-- 
2.55.0

