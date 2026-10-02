Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A73F5BC3
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969293; cv=none; b=cGY0Sr3J+3sQuIm3lVnZWaet/Uk3JCiEU4aehiXFVl25o09cXNttjvMUeEZqahH5tk/gj3TnjTFQoy5Nj0Cc+omFTlpbPuTg+CmHj2c0wYA+94N8hG45yrxDNFcGQsrtzC24mAAP91MU3hf+KczdTfk0Yf7a/n2ltTWxOQgKqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969293; c=relaxed/simple;
	bh=IUCU0dwd1Dcw8XkTS1FERfZix7eJrMJIG58YxlNLJt0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Iku1mNSfWhJxxqphrIrRQ/Lm3+vBgisEHzA6U6pGe/RbDwsngzqQRdX8KS4n1aKx0lTfAElk5rIlGgEMsz5cEqEXjCOMvwC7SrMqmTWlhgkf1CPuyc7iq31GxsWb8uaqsEe9POwWL+jBcnbo/jxRvYMXUe0IexN94qpDZQ4LSmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qDFxWjEL; arc=none smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDFxWjEL"
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5da1bc55abfso627368e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 12:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790969287; x=1791574087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t+OBNsTmRbBsMW/SDwQyNuKtNb4XDoJmAW3nQKDnF7U=;
        b=qDFxWjELJmMhPxrNEPNKR9etcAwDbJKagmMYcB+WHznzs2fJV/kYrk0E7lq7iooVDv
         dAPxeM9Bb5rIYw2k04NDIEaWlTNRlJBqNe9XKDXJSUYOaCZ/KPUvwNN2wHxdvyDgcIGa
         lrW0V+KZxLpSm3Mlqgrli/i8HwTJRNGZuL79ZocwgJxM7tMRIIfO5+zjCHf7blMFHARk
         ADyOWntZSBdu/dkwP/oqmtiZrnry8+Yj4/L64e2K3Hv1auISVq3V2cC60iBNOwebWMCj
         RFjeVE2g32QQVFpopYPJdZoCFWZ2q1MjLeperDR027PrSkxP/9qZ8drYZuVswhr5pUjw
         nYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790969287; x=1791574087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t+OBNsTmRbBsMW/SDwQyNuKtNb4XDoJmAW3nQKDnF7U=;
        b=DiCv/420p3dp4MfYR29IOaAFMiLSQYkqfHdSiKmfGcgxfNL34KTYCIzapvN4l3atwy
         OGwOK4oUZXUb0xInVBvux3rn9PryinlXKvljImJlrZ+HMbYPc6HvpRoGwXGfkPN/HLha
         QQ01+C8GZTMXX6n5QLCTmHp323rpmtI1Vaw+d6t9PIuCyFYISzw0LgdsA5usWA65VuCw
         qBSb3FsDHH4WzGaag+gn9kyEAoZJbBekAqKqmge6e+0kuet+4WSvwIOdeu/dxDLeIQEc
         xll11+0YP/xPjCzMF2uGv++/V2ZDm87EbHuXJLKecXooC/D+UxCvImFC1Xd+/hwr3uya
         SCxg==
X-Gm-Message-State: AFq9FYLi+utFJoN2pqZ8UoEmAybCcDaIZWpCxbadf6X7G1FKhVU3Wpbq
	jGjEVtkb4AcxjgcSR3V62Aj0T5D7AbqNgD7mcdpjW+JInzaivhqq4TH6lijfLkQ5
X-Gm-Gg: AYBFou2hcxcIda0NOyk+Jz3i5nH8aYRxT9MhLz4G2zi5QZASoX00F3DrKZztxQxIEB+
	FSGiXW4BQ7yBtjtwB5lIkCenRU6upYEU9OuPULztXRgk3fxYw/31+14D0I5tJxJgvLwmvb5Mcq4
	k9bp5vfxC2msVD0suIRf0y/4Mqad6FaoqBhER9zQx28wQ49Z4+hYke3d/hY7osyyhHgbnyO5ZgX
	CbdDPHvIxtJJbR2izRciOPTn4Q7ARwKbyWAYdrC3xCZ8yJdzd4n13cCyEawqUETi73xf9QwxssE
	PYU6S9BzAHztObLr50XH3LwcPDeAUAP47UjOaIhUb9w1z+GJUeW5ZfR4+I8VOWUBNNQV88OZAFh
	AzhCGbwzMVKjbX/EIyviPmy7xOFbh1kB48iuJhKRoj++yvNbJZ9foUbmT14XxemNhbZ5M0oEdGv
	ZfNC+iMfImlLOGgz5Fq0EqbYq1QuHJdf2613vjfmXPpOXLaoMdEQL9mHIjQvCJz4u0hbeVPeZ0w
	3NAGV1SxULGadyTKxHINYZoajYAK9BtHd0VT2dJVBcB/q05GA3OQw2RYE/iQbv/
X-Received: by 2002:a67:e7c8:0:b0:7a8:2a34:432e with SMTP id ada2fe7eead31-7c0f3f6942dmr854940137.9.1790969286564;
        Fri, 02 Oct 2026 12:28:06 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98b2f15ef60sm3857759241.12.2026.10.02.12.28.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:28:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ vRFC 1/7] monitor: Add audio quality statistics for ISO streams
Date: Fri,  2 Oct 2026 15:27:53 -0400
Message-ID: <20261002192759.3071262-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Track the bursts of erased samples, the Gilbert model burst ratio and the
RFC 3550 interarrival jitter of received ISO data, using the controller
timestamp when present or the SN paced at ISO Interval over BN otherwise.

Live decoding now prints the loss only for the sample revealing it, along
with late samples:

> LE-CIS: Handle 2304 SN... flags 0x02 dlen 4 sflags 2  #302 [hci0] 83.728300
        Lost: 0/34 (0.00%) dropped 1 invalid 0 burst 1
        Late: +7.50 msec (interval 7.50 msec)

The new --quality option prints a periodic summary per stream:

= Quality: LE-CIS 2304                                       [hci0] 55.004307
        RX loss: 5/101 (4.95%) burst max 4
        RX jitter: 1.10 msec late 2

The analyze mode reports the bursts and the jitter per connection:

  Found LE-CIS connection with handle 2304
        ...
        RX loss: 2896/30733 (9.42%) dropped 0 invalid 0
        RX bursts: 1304 (max 7) [1: 799, 2: 52, 3-5: 326, 6-10: 127, >10: 0]
        RX burstiness: p 0.0468 q 0.4503 BurstR 2.01
        RX jitter: 6.66 msec (max 13.06 msec, late 4275)
        RX interval: 10.00 msec (0-91 msec, ~8 msec +/- 10 msec)

A reordered sample is no longer accounted as lost.

Assisted-by: OpenCode:claude-opus-5.5
---
 doc/btmon.rst     |   6 +
 monitor/analyze.c |  42 +++--
 monitor/main.c    |  12 +-
 monitor/packet.c  | 387 ++++++++++++++++++++++++++++++++++++++++++++--
 monitor/packet.h  |  46 ++++++
 5 files changed, 465 insertions(+), 28 deletions(-)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index 1129ceb2e616..fd19b73b22b3 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -93,6 +93,12 @@ OPTIONS
 -I, --iso                   Dump ISO stream traffic in raw hex format. Required
                             to see LE Audio isochronous data in the output.
 
+-Q MSEC, --quality MSEC     Print a summary of the received audio stream
+                            quality every MSEC milliseconds: erasures, the
+                            longest burst of erasures, jitter and late
+                            samples. Only LE Audio isochronous streams are
+                            currently supported.
+
 -E IP, --ellisys IP         Send Ellisys HCI Injection.
 
 -P, --no-pager              Disable pager usage while reading the log file.
diff --git a/monitor/analyze.c b/monitor/analyze.c
index 5d54ad61b7b6..13d470ff566d 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -107,6 +107,7 @@ struct hci_conn {
 	struct hci_stats rx;
 	struct hci_stats tx;
 	struct packet_loss rx_loss;
+	struct packet_jitter rx_jitter;
 };
 
 struct hci_conn_tx {
@@ -380,14 +381,8 @@ static void conn_destroy(void *data)
 	print_stats(&conn->rx, "RX");
 	print_stats(&conn->tx, "TX");
 
-	if (conn->rx_loss.total)
-		print_field("RX loss: %zu/%zu (%zu.%02zu%%) "
-				"dropped %zu invalid %zu",
-				conn->rx_loss.lost, conn->rx_loss.total,
-				conn->rx_loss.lost * 100 / conn->rx_loss.total,
-				(conn->rx_loss.lost * 10000 /
-					conn->rx_loss.total) % 100,
-				conn->rx_loss.dropped, conn->rx_loss.invalid);
+	packet_loss_print(&conn->rx_loss, "RX");
+	packet_jitter_print(&conn->rx_jitter, "RX");
 
 	if (conn->setup_seen) {
 		print_field("Connected: #%lu", conn->frame_connected);
@@ -1060,6 +1055,15 @@ static void evt_sync_conn_complete(struct hci_dev *dev, struct timeval *tv,
 	conn->setup_seen = true;
 }
 
+/* Nominal SDU interval of an unframed stream: ISO Interval over BN */
+static void set_iso_interval(struct hci_conn *conn, uint16_t interval,
+								uint8_t bn)
+{
+	if (bn)
+		conn->rx_jitter.interval = (uint32_t)le16_to_cpu(interval) *
+								1250 / bn;
+}
+
 static void evt_le_cis_established(struct hci_dev *dev, struct timeval *tv,
 					unsigned long frame,
 					struct iovec *iov)
@@ -1082,6 +1086,9 @@ static void evt_le_cis_established(struct hci_dev *dev, struct timeval *tv,
 	link = link_lookup(dev, conn->handle);
 	if (link)
 		memcpy(conn->bdaddr, link->bdaddr, 6);
+
+	/* Only the Peripheral gets a CIS Request for the handle */
+	set_iso_interval(conn, evt->interval, link ? evt->c_bn : evt->p_bn);
 }
 
 static void evt_le_cis_req(struct hci_dev *dev, struct timeval *tv,
@@ -1123,6 +1130,7 @@ static void evt_le_big_complete(struct hci_dev *dev, struct timeval *tv,
 		if (conn) {
 			conn->setup_seen = true;
 			conn->frame_connected = frame;
+			set_iso_interval(conn, evt->interval, evt->bn);
 		}
 	}
 }
@@ -1149,6 +1157,7 @@ static void evt_le_big_sync_established(struct hci_dev *dev, struct timeval *tv,
 		if (conn) {
 			conn->setup_seen = true;
 			conn->frame_connected = frame;
+			set_iso_interval(conn, evt->interval, evt->bn);
 		}
 	}
 }
@@ -1459,6 +1468,7 @@ static void iso_pkt(struct timeval *tv, uint16_t index, bool out,
 {
 	const struct bt_hci_iso_hdr *hdr = data;
 	struct iovec iov = { .iov_base = (void *)data, .iov_len = size };
+	const void *ts = NULL;
 	struct hci_conn *conn;
 	struct hci_dev *dev;
 	uint16_t handle;
@@ -1492,12 +1502,22 @@ static void iso_pkt(struct timeval *tv, uint16_t index, bool out,
 
 		/* Skip the timestamp when present */
 		if (ISO_FLAGS_TS(flags))
-			util_iov_pull_mem(&iov, sizeof(uint32_t));
+			ts = util_iov_pull_mem(&iov, sizeof(uint32_t));
 
 		start = util_iov_pull_mem(&iov, sizeof(*start));
-		if (start)
-			packet_loss_add(&conn->rx_loss, le16_to_cpu(start->sn),
+		if (start) {
+			uint16_t sn = le16_to_cpu(start->sn);
+
+			packet_loss_add(&conn->rx_loss, sn,
 				ISO_DATA_FLAGS(le16_to_cpu(start->slen)));
+
+			/* Prefer the controller timestamp over the SN */
+			if (ts)
+				packet_jitter_add_ts(&conn->rx_jitter, tv,
+								get_le32(ts));
+			else
+				packet_jitter_add_sn(&conn->rx_jitter, tv, sn);
+		}
 	}
 
 	if (out) {
diff --git a/monitor/main.c b/monitor/main.c
index 1a7a25713de1..c285832612b8 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -68,6 +68,8 @@ static void usage(void)
 		"\t-S, --sco              Dump SCO traffic\n"
 		"\t-A, --a2dp             Dump A2DP stream traffic\n"
 		"\t-I, --iso              Dump ISO traffic\n"
+		"\t-Q, --quality <msec>   Print a periodic quality summary\n"
+		"\t                       of the audio streams\n"
 		"\t-E, --ellisys [ip]     Send Ellisys HCI Injection\n"
 		"\t-P, --no-pager         Disable pager usage\n"
 		"\t-0, --print0           Separate frames with a NUL, for a\n"
@@ -99,6 +101,7 @@ static const struct option main_options[] = {
 	{ "sco",       no_argument,       NULL, 'S' },
 	{ "a2dp",      no_argument,       NULL, 'A' },
 	{ "iso",       no_argument,       NULL, 'I' },
+	{ "quality",   required_argument, NULL, 'Q' },
 	{ "ellisys",   required_argument, NULL, 'E' },
 	{ "no-pager",  no_argument,       NULL, 'P' },
 	{ "print0",    no_argument,       NULL, '0' },
@@ -137,7 +140,7 @@ int main(int argc, char *argv[])
 		struct sockaddr_un addr;
 
 		opt = getopt_long(argc, argv,
-				"r:w:a:s:p:i:d:B:V:MKNtTSAIE:P0J:R:C:c:vh",
+				"r:w:a:s:p:i:d:B:V:MKNtTSAIQ:E:P0J:R:C:c:vh",
 				main_options, NULL);
 		if (opt < 0)
 			break;
@@ -214,6 +217,13 @@ int main(int argc, char *argv[])
 		case 'I':
 			filter_mask |= PACKET_FILTER_SHOW_ISO_DATA;
 			break;
+		case 'Q':
+			if (atoi(optarg) <= 0) {
+				usage();
+				return EXIT_FAILURE;
+			}
+			packet_set_quality_period(atoi(optarg));
+			break;
 		case 'E':
 			ellisys_server = optarg;
 			ellisys_port = 24352;
diff --git a/monitor/packet.c b/monitor/packet.c
index 8450347fc56b..09603c19e05e 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -114,6 +114,7 @@
 static time_t time_offset = ((time_t) -1);
 static int priority_level = BTSNOOP_PRIORITY_DEBUG;
 static unsigned long filter_mask = 0;
+static unsigned int quality_period;
 static bool index_filter = false;
 static uint16_t index_current = 0;
 static uint16_t fallback_manufacturer = COMPANY_ID_UNKNOWN;
@@ -11974,8 +11975,62 @@ long long packet_latency_stddev(const struct packet_latency *latency)
 	return (long long)sqrt(var);
 }
 
+static void loss_burst_end(struct packet_loss *loss)
+{
+	size_t len = loss->burst;
+
+	if (!len)
+		return;
+
+	loss->bursts++;
+	loss->burst_last = len;
+
+	if (len == 1)
+		loss->burst_hist[0]++;
+	else if (len == 2)
+		loss->burst_hist[1]++;
+	else if (len <= 5)
+		loss->burst_hist[2]++;
+	else if (len <= 10)
+		loss->burst_hist[3]++;
+	else
+		loss->burst_hist[4]++;
+
+	loss->burst = 0;
+}
+
+static void loss_sample(struct packet_loss *loss, bool erased, size_t count)
+{
+	if (!count)
+		return;
+
+	if (loss->have_prev && loss->prev_erased != erased) {
+		if (erased)
+			loss->good_lost++;
+		else
+			loss->lost_good++;
+	}
+
+	if (erased) {
+		loss->erased += count;
+		loss->burst += count;
+		if (loss->burst > loss->burst_max)
+			loss->burst_max = loss->burst;
+	} else {
+		loss_burst_end(loss);
+	}
+
+	loss->prev_erased = erased;
+	loss->have_prev = true;
+}
+
+/* How far back a sequence number may go to be considered a reorder */
+#define LOSS_REORDER_MAX 16
+
 void packet_loss_add(struct packet_loss *loss, uint16_t sn, uint8_t sflags)
 {
+	bool advanced = true;
+
 	loss->total++;
 
 	switch (sflags) {
@@ -11998,13 +12053,188 @@ void packet_loss_add(struct packet_loss *loss, uint16_t sn, uint8_t sflags)
 		if (sn != loss->last_sn && gap < 0x8000) {
 			loss->lost += gap;
 			loss->total += gap;
+			loss_sample(loss, true, gap);
+		} else if ((uint16_t)(loss->last_sn - sn) < LOSS_REORDER_MAX) {
+			advanced = false;
+
+			/* A late arrival of a sample already counted as lost */
+			if (sn != loss->last_sn && loss->lost) {
+				loss->lost--;
+				loss->total--;
+			}
 		}
 	}
 
+	/* Duplicates and reorders do not take part in the bursts */
+	if (!advanced)
+		return;
+
+	loss_sample(loss, sflags == 0x02, 1);
+
+	/* Anything further back than a reorder restarts the sequence */
 	loss->last_sn = sn;
 	loss->have_sn = true;
 }
 
+size_t packet_loss_burst_max(const struct packet_loss *loss)
+{
+	return loss->burst_max;
+}
+
+/*
+ * Two state Gilbert model of the erasures: p is the probability of going
+ * from received to erased and q the one of going back, the burst ratio
+ * being how much burstier the erasures are than random ones.
+ */
+bool packet_loss_burst_ratio(const struct packet_loss *loss, double *p,
+						double *q, double *ratio)
+{
+	size_t good = loss->total - loss->erased;
+
+	if (!loss->erased || !good)
+		return false;
+
+	*p = (double)loss->good_lost / good;
+	*q = (double)loss->lost_good / loss->erased;
+
+	if (*p + *q <= 0)
+		return false;
+
+	*ratio = 1 / (*p + *q);
+
+	return true;
+}
+
+void packet_loss_print(const struct packet_loss *loss, const char *label)
+{
+	struct packet_loss tmp = *loss;
+	double p, q, ratio;
+
+	if (!loss->total)
+		return;
+
+	print_field("%s loss: %zu/%zu (%zu.%02zu%%) dropped %zu invalid %zu",
+				label, loss->lost, loss->total,
+				loss->lost * 100 / loss->total,
+				(loss->lost * 10000 / loss->total) % 100,
+				loss->dropped, loss->invalid);
+
+	/* Account for the burst still in progress */
+	loss_burst_end(&tmp);
+
+	if (!tmp.bursts)
+		return;
+
+	print_field("%s bursts: %zu (max %zu) [1: %zu, 2: %zu, 3-5: %zu, "
+			"6-10: %zu, >10: %zu]", label, tmp.bursts,
+			tmp.burst_max, tmp.burst_hist[0], tmp.burst_hist[1],
+			tmp.burst_hist[2], tmp.burst_hist[3],
+			tmp.burst_hist[4]);
+
+	if (packet_loss_burst_ratio(loss, &p, &q, &ratio))
+		print_field("%s burstiness: p %.4f q %.4f BurstR %.2f", label,
+								p, q, ratio);
+}
+
+static void jitter_add(struct packet_jitter *jitter, struct timeval *tv,
+							int64_t expected)
+{
+	struct timeval delta;
+	int64_t arrival, d;
+
+	timersub(tv, &jitter->prev_tv, &delta);
+	jitter->prev_tv = *tv;
+
+	packet_latency_add(&jitter->delta, &delta);
+
+	/*
+	 * RFC 3550 interarrival jitter: the difference of the transit times
+	 * of two consecutive samples, smoothed with a gain of 1/16.
+	 */
+	arrival = (int64_t)delta.tv_sec * 1000000 + delta.tv_usec;
+	d = arrival - expected;
+	jitter->last_dev = d;
+
+	/* A sample arriving an interval or more later than expected */
+	if (jitter->interval && d >= jitter->interval)
+		jitter->late++;
+
+	if (d < 0)
+		d = -d;
+
+	if ((uint64_t)d > jitter->max_dev)
+		jitter->max_dev = d;
+
+	jitter->jitter16 += (uint64_t)d - ((jitter->jitter16 + 8) >> 4);
+}
+
+void packet_jitter_add_sn(struct packet_jitter *jitter, struct timeval *tv,
+								uint16_t sn)
+{
+	uint16_t diff = sn - jitter->prev_sn;
+
+	if (!jitter->interval)
+		return;
+
+	if (!jitter->have_prev) {
+		jitter->prev_tv = *tv;
+		jitter->prev_sn = sn;
+		jitter->have_prev = true;
+		return;
+	}
+
+	/* Leave the duplicates and the reorders out */
+	if (!diff || diff >= 0x8000)
+		return;
+
+	jitter->prev_sn = sn;
+	jitter_add(jitter, tv, (int64_t)diff * jitter->interval);
+}
+
+void packet_jitter_add_ts(struct packet_jitter *jitter, struct timeval *tv,
+								uint32_t ts)
+{
+	uint32_t diff = ts - jitter->prev_ts;
+
+	if (!jitter->have_prev) {
+		jitter->prev_tv = *tv;
+		jitter->prev_ts = ts;
+		jitter->have_prev = true;
+		return;
+	}
+
+	if (!diff || diff >= 0x80000000)
+		return;
+
+	jitter->prev_ts = ts;
+	jitter_add(jitter, tv, diff);
+}
+
+void packet_jitter_print(const struct packet_jitter *jitter,
+							const char *label)
+{
+	uint64_t j = jitter->jitter16 >> 4;
+
+	if (!jitter->delta.count)
+		return;
+
+	print_field("%s jitter: %" PRIu64 ".%02" PRIu64 " msec (max %"
+			PRIu64 ".%02" PRIu64 " msec, late %zu)", label,
+			j / 1000, (j % 1000) / 10,
+			jitter->max_dev / 1000, (jitter->max_dev % 1000) / 10,
+			jitter->late);
+
+	if (jitter->interval)
+		print_field("%s interval: %u.%02u msec (%lld-%lld msec, "
+				"~%lld msec +/- %lld msec)", label,
+				jitter->interval / 1000,
+				(jitter->interval % 1000) / 10,
+				TV_MSEC(jitter->delta.min),
+				TV_MSEC(jitter->delta.max),
+				TV_MSEC(jitter->delta.med),
+				packet_latency_stddev(&jitter->delta));
+}
+
 /*
  * Timestamp and frame number of the packet being decoded. btmon decodes one
  * packet at a time, so this lets the upper layers reference the frame that
@@ -13338,6 +13568,17 @@ static void le_past_received_evt(struct timeval *tv, uint16_t index,
 	print_clock_accuracy(evt->clock_accuracy);
 }
 
+/* Nominal SDU interval of an unframed stream: ISO Interval over BN */
+static void set_iso_interval(uint16_t handle, uint16_t interval, uint8_t bn)
+{
+	struct packet_conn_data *conn = packet_get_conn_data(handle);
+
+	if (!conn || !bn)
+		return;
+
+	conn->rx_jitter.interval = (uint32_t)le16_to_cpu(interval) * 1250 / bn;
+}
+
 static void le_cis_established_evt(struct timeval *tv, uint16_t index,
 					const void *data, uint8_t size)
 {
@@ -13360,10 +13601,16 @@ static void le_cis_established_evt(struct timeval *tv, uint16_t index,
 	print_field("Peripheral to Central MTU: %u", le16_to_cpu(evt->p_mtu));
 	print_slot_125("ISO Interval", evt->interval);
 
-	if (!evt->status)
-		assign_handle(index, le16_to_cpu(evt->conn_handle),
-					BTMON_CONN_CIS,
-					NULL, BDADDR_LE_PUBLIC);
+	if (!evt->status) {
+		uint16_t handle = le16_to_cpu(evt->conn_handle);
+
+		assign_handle(index, handle, BTMON_CONN_CIS, NULL,
+							BDADDR_LE_PUBLIC);
+
+		/* Only the Peripheral gets a CIS Request for the handle */
+		set_iso_interval(handle, evt->interval,
+				lookup_parent(handle) ? evt->c_bn : evt->p_bn);
+	}
 }
 
 static void le_req_cis_evt(struct timeval *tv, uint16_t index,
@@ -13411,10 +13658,13 @@ static void le_big_complete_evt(struct timeval *tv, uint16_t index,
 	if (!evt->status) {
 		int i;
 
-		for (i = 0; i < evt->num_bis; i++)
+		for (i = 0; i < evt->num_bis; i++) {
 			assign_handle(index, le16_to_cpu(evt->bis_handle[i]),
 					BTMON_CONN_BIS, NULL,
 					BDADDR_LE_PUBLIC);
+			set_iso_interval(le16_to_cpu(evt->bis_handle[i]),
+						evt->interval, evt->bn);
+		}
 	}
 }
 
@@ -13447,9 +13697,12 @@ static void le_big_sync_estabilished_evt(struct timeval *tv, uint16_t index,
 	if (!evt->status) {
 		int i;
 
-		for (i = 0; i < evt->num_bis; i++)
+		for (i = 0; i < evt->num_bis; i++) {
 			assign_handle(index, le16_to_cpu(evt->bis[i]),
 					BTMON_CONN_BIS, NULL, BDADDR_LE_PUBLIC);
+			set_iso_interval(le16_to_cpu(evt->bis[i]),
+						evt->interval, evt->bn);
+		}
 	}
 }
 
@@ -15149,6 +15402,95 @@ void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 		packet_hexdump(data, size);
 }
 
+static void print_rx_quality(struct packet_conn_data *conn, size_t erased,
+				size_t late, uint8_t sflags, size_t burst)
+{
+	struct packet_loss *loss = &conn->rx_loss;
+	struct packet_jitter *jitter = &conn->rx_jitter;
+
+	/* Only report the samples that revealed a loss or arrived late */
+	if (loss->erased != erased || sflags)
+		print_field("Lost: %zu/%zu (%zu.%02zu%%) dropped %zu "
+				"invalid %zu burst %zu",
+				loss->lost, loss->total,
+				loss->lost * 100 / loss->total,
+				(loss->lost * 10000 / loss->total) % 100,
+				loss->dropped, loss->invalid, burst);
+
+	if (jitter->late != late)
+		print_field("Late: +%" PRId64 ".%02" PRId64 " msec "
+				"(interval %u.%02u msec)",
+				jitter->last_dev / 1000,
+				(jitter->last_dev % 1000) / 10,
+				jitter->interval / 1000,
+				(jitter->interval % 1000) / 10);
+}
+
+void packet_set_quality_period(unsigned int msec)
+{
+	quality_period = msec;
+}
+
+static void quality_summary(struct timeval *tv, struct ucred *cred,
+				uint16_t index, struct packet_conn_data *conn,
+				size_t burst)
+{
+	struct packet_quality *q = &conn->rx_quality;
+	struct packet_loss *loss = &conn->rx_loss;
+	struct packet_jitter *jitter = &conn->rx_jitter;
+	char str[32];
+	struct timeval delta;
+	size_t erased, total;
+	uint64_t j;
+
+	if (!quality_period || !tv)
+		return;
+
+	if (burst > q->burst_max)
+		q->burst_max = burst;
+
+	if (!timerisset(&q->start)) {
+		q->start = *tv;
+		q->erased = loss->erased;
+		q->total = loss->total;
+		q->late = jitter->late;
+		return;
+	}
+
+	timersub(tv, &q->start, &delta);
+	if (TV_MSEC(delta) < quality_period)
+		return;
+
+	erased = loss->erased - q->erased;
+	total = loss->total - q->total;
+	j = jitter->jitter16 >> 4;
+
+	snprintf(str, sizeof(str), "%s %u", conn_type_str(conn->type),
+							conn->handle);
+	print_packet(tv, cred, '=', index, NULL, COLOR_SYSTEM_NOTE,
+						"Quality", str, NULL);
+
+	print_field("RX loss: %zu/%zu (%zu.%02zu%%) burst max %zu", erased,
+			total, total ? erased * 100 / total : 0,
+			total ? (erased * 10000 / total) % 100 : 0,
+			q->burst_max);
+
+	if (jitter->delta.count)
+		print_field("RX jitter: %" PRIu64 ".%02" PRIu64 " msec "
+				"late %zu", j / 1000, (j % 1000) / 10,
+				jitter->late - q->late);
+
+	if (conn->tx_l.count)
+		print_field("TX latency: ~%lld msec",
+						TV_MSEC(conn->tx_l.med));
+
+	q->start = *tv;
+	q->erased = loss->erased;
+	q->total = loss->total;
+	q->late = jitter->late;
+	q->burst_max = loss->burst;
+}
+
 void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				bool in, const void *data, uint16_t size)
 {
@@ -15164,6 +15506,8 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	bool have_hdr;
 	uint16_t sn = 0;
 	uint8_t sflags = 0;
+	uint32_t ts = 0;
+	size_t erased = 0, late = 0;
 
 	if (index >= MAX_INDEX) {
 		print_field("Invalid index (%d).", index);
@@ -15194,7 +15538,8 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 		if (size < ts_size || !have_hdr)
 			goto malformed;
 
-		snprintf(ts_str, sizeof(ts_str), " ts %u", get_le32(data));
+		ts = get_le32(data);
+		snprintf(ts_str, sizeof(ts_str), " ts %u", ts);
 
 		data += ts_size;
 		size -= ts_size;
@@ -15223,9 +15568,19 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 
 	conn = packet_get_conn_data(handle);
 
-	if (in && have_hdr && conn)
+	if (in && have_hdr && conn) {
+		erased = conn->rx_loss.erased;
+		late = conn->rx_jitter.late;
+
 		packet_loss_add(&conn->rx_loss, sn, sflags);
 
+		/* Prefer the controller timestamp over the SN pacing */
+		if (tv && ts_size)
+			packet_jitter_add_ts(&conn->rx_jitter, tv, ts);
+		else if (tv)
+			packet_jitter_add_sn(&conn->rx_jitter, tv, sn);
+	}
+
 	if (!in && pool->total)
 		sprintf(handle_str, "Handle %d [%u/%u]%s",
 			acl_handle(handle), ++pool->tx, pool->total, sn_str);
@@ -15245,16 +15600,16 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_ISODATA,
 				label, handle_str, extra_str);
 
-	if (in && conn) {
+	if (in && have_hdr && conn) {
 		struct packet_loss *loss = &conn->rx_loss;
+		size_t burst = loss->burst;
 
-		if (loss->lost || loss->dropped || loss->invalid)
-			print_field("Lost: %zu/%zu (%zu.%02zu%%) "
-				"dropped %zu invalid %zu",
-				loss->lost, loss->total,
-				loss->lost * 100 / loss->total,
-				(loss->lost * 10000 / loss->total) % 100,
-				loss->dropped, loss->invalid);
+		/* A burst that this sample has just ended */
+		if (!burst && loss->erased != erased)
+			burst = loss->burst_last;
+
+		print_rx_quality(conn, erased, late, sflags, burst);
+		quality_summary(tv, cred, index, conn, burst);
 	}
 
 	if (!in)
diff --git a/monitor/packet.h b/monitor/packet.h
index 3559f52719cb..c3e3608bdede 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -43,6 +43,39 @@ struct packet_loss {
 	size_t invalid;		/* Samples flagged possibly invalid */
 	size_t dropped;		/* Samples flagged as lost data */
 	size_t total;		/* Samples seen, including the lost ones */
+	/* Bursts of erased samples, either missing or flagged as lost */
+	size_t erased;		/* Erased samples */
+	size_t burst;		/* Length of the burst in progress */
+	size_t burst_max;	/* Longest burst */
+	size_t burst_last;	/* Length of the last burst ended */
+	size_t bursts;		/* Bursts ended so far */
+	size_t burst_hist[5];	/* Burst lengths: 1, 2, 3-5, 6-10, >10 */
+	size_t good_lost;	/* Transitions from received to erased */
+	size_t lost_good;	/* Transitions from erased to received */
+	bool have_prev;
+	bool prev_erased;
+};
+
+struct packet_jitter {
+	uint32_t interval;	/* Nominal interval in usec, 0 if unknown */
+	bool have_prev;
+	struct timeval prev_tv;
+	uint32_t prev_ts;
+	uint16_t prev_sn;
+	uint64_t jitter16;	/* RFC 3550 jitter in usec, scaled by 16 */
+	int64_t last_dev;	/* Deviation of the last sample in usec */
+	uint64_t max_dev;	/* Largest deviation in usec */
+	size_t late;		/* Samples deviating more than an interval */
+	struct packet_latency delta;	/* Arrival intervals */
+};
+
+/* Window of the periodic quality summary */
+struct packet_quality {
+	struct timeval start;
+	size_t erased;
+	size_t total;
+	size_t burst_max;
+	size_t late;
 };
 
 /* Protocols tracked for request and response matching */
@@ -83,6 +116,8 @@ struct packet_conn_data {
 	struct queue *chan_q;
 	struct packet_latency tx_l;
 	struct packet_loss rx_loss;
+	struct packet_jitter rx_jitter;
+	struct packet_quality rx_quality;
 	struct queue *req_q;
 	void     *data;
 	void     (*destroy)(struct packet_conn_data *conn, void *data);
@@ -92,6 +127,17 @@ struct packet_conn_data *packet_get_conn_data(uint16_t handle);
 void packet_latency_add(struct packet_latency *latency, struct timeval *delta);
 long long packet_latency_stddev(const struct packet_latency *latency);
 void packet_loss_add(struct packet_loss *loss, uint16_t sn, uint8_t sflags);
+size_t packet_loss_burst_max(const struct packet_loss *loss);
+bool packet_loss_burst_ratio(const struct packet_loss *loss, double *p,
+						double *q, double *ratio);
+void packet_loss_print(const struct packet_loss *loss, const char *label);
+void packet_jitter_add_sn(struct packet_jitter *jitter, struct timeval *tv,
+								uint16_t sn);
+void packet_jitter_add_ts(struct packet_jitter *jitter, struct timeval *tv,
+								uint32_t ts);
+void packet_jitter_print(const struct packet_jitter *jitter,
+							const char *label);
+void packet_set_quality_period(unsigned int msec);
 
 void packet_get_context(struct timeval *tv, size_t *num);
 void packet_req_add(uint16_t handle, uint16_t cid, uint8_t proto, uint16_t id,
-- 
2.55.0

