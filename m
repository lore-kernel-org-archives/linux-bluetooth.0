Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0853290DE
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286712; cv=none; b=ZBstA+7T/HsjGDpC5pTUM3AX9vXegCH2/ak8KAgtwU2Yl63EWNj0ql1HVTcvNSr3lzStl9ZE1uTR812wsY6XSjtllxs7MnCJURVw7mp7/La1dLvrIVir+qZVI19p2ZjOl77KQYy6j/niLCAkI0qmYQRIxucTWwMwP3U9iBIryOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286712; c=relaxed/simple;
	bh=570iHrifgu/Sgabn8s4uNI2Up5PuSqocV+O+Xbax+/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vis/5oq1k9ssBLYpjkyEOyKSbR2khDoKh+N46TMCQWKyDOsEw0CTkhrsVDmPt4K2LHB4EAglQMS2PRQciXlLuHT3N7hy8OqH1KRpByZSFcI25P4AEIS6VjThoCDRXEKODzUacNu1WOUPhyrpld8LoH9M2oASL/qE4BMCMoYOOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJA7zDTJ; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJA7zDTJ"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso5511125e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 13:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776286710; x=1776891510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRzE/EMkiSJE59A04Zcqh2pdNrsCho4p1F8UNIzOWKY=;
        b=FJA7zDTJ5Eq6BX4pMeD0UyGKi9qHoE9rZa85bqRiUXGQn5b2SgkRQ6TMfZ0kEnehm4
         6LWsZNtilEZaqV5W28RC+nnATAeu7IUOuHUGM6YnGgg1UcTNb50K7RnZpNSvAVCkgGtd
         bQu2feqDrWWiRLCSHROk8ow8IYV/ME03HJNA56uqH/jhrvOq70iFoSU37TuhByj/ThKR
         a64ddDTOgBx0pxhWnjI1Yr77xocV5FrVCVLVmYX8JVSIoxD+i78/4403G7ykVUjopcSw
         0nvRMJ1XQPMb1uNciqyiiB658Wzsz33LzmksBNCWk+c1hAbgYpkJ+SYmkTQTgNJWlBOQ
         +z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286710; x=1776891510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IRzE/EMkiSJE59A04Zcqh2pdNrsCho4p1F8UNIzOWKY=;
        b=otFsMccWBRsre/5MYe7gwQ8eqJhCAX1Cn+KyHJSNcorcn7jYiSGtGlbODazXX22mVa
         02meN62Djr5Z7ZNox3at6JBYg3y/brk/mqzsNu+778jXBzeOzv8AYJZFtaZse1dN7d+J
         87RAj86QX2kO/juadSDk6Qdxy1Vs1ybsW125C2uFzjB5ueCZfUvKrReaAYHOCfv/IXjF
         qfc2Ujd+k+lP/eKdaaF5vdjdyV1kVXVvE/MGjpT5d/XDqKoMpxHOTv/gJuCNE47lxZ0s
         9QHn/bdEM//YdWUGTJe1CTozbT0gr012YTV5dsaTlFx9YkaHExQgHVgtDPcyyX9ywuIe
         xgeA==
X-Gm-Message-State: AOJu0YwLpYb2OKXVAJyXcYP6tCZxs4QvMybcpBU3Xlj4ZNttHg2QLrOs
	7SR/TLDEkRvxsWXdQNZFcPEHHeZfJvVEuypT48iGnDtWKOlB6yqf529TiUpbzQH97Bw=
X-Gm-Gg: AeBDievoTDfGHL0pkgeDSP72lMhNB5klmQNtPiGoB/zzkXfntpdkL3hGTcn0lUeWW+S
	36S6t0gmR35beHW6kaizv1PCIUNFSOWO+JYfcMVjnCqPMAOkxIZ83mIXnEV2Pf6oE812qr356im
	CBaFcXCp6Y3T+0wYiaeqTXQCP/ZuSiAAdwd8nwcuKKPcTyW5MPM7SbvlTox26kEFX063T983uRv
	DR7rxEPQg6aRWCGyT4Ohcux1v2Ug8xa9oHOlgVAmy4Av6h6qe6rPYUW2awHsGFbARCA7ylx4/nI
	hMvWoYuw/rtPfXGpqTHWDGd9QKNpswfmOl7grjepHpK4BHcunFir8shgABOMmiE1o2ET8FhigGo
	NqS8EcXr+jYV+WnkMNjiRi1Ylsh6v68pL3d/hI9kyZ/thnZm75Rr16egOQln2iNOsg4dUdSfcio
	rTbO4DspTYD3z12Mt3wC3MM3mdRan66s77zKao6EHFW0OPle0dmqXpyY+8iqAbzcnh2wpLEd5Pz
	b36MNBFLKHSvKnuNRgjViw/Ohe1
X-Received: by 2002:a05:6122:e44c:b0:56b:7023:1393 with SMTP id 71dfb90a1353d-56f3bce3ad3mr12158012e0c.11.1776286709823;
        Wed, 15 Apr 2026 13:58:29 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f8a032227sm2059622e0c.18.2026.04.15.13.58.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:58:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] monitor: Use wall-clock duration for throughput and add min/max speed
Date: Wed, 15 Apr 2026 16:58:17 -0400
Message-ID: <20260415205818.594024-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415205818.594024-1-luiz.dentz@gmail.com>
References: <20260415205818.594024-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The previous speed calculation used the sum of per-packet latencies as
the denominator.  For TX, each latency measures the time from command
submission to completion event -- when multiple packets are in-flight
simultaneously these overlap, making the sum much larger than wall-clock
time and deflating the reported speed.  For RX the inter-arrival sum
roughly equals wall-clock time.  This asymmetry caused the same data
stream to report vastly different speeds depending on direction.

Fix by computing speed from wall-clock duration (last packet timestamp
minus first packet timestamp), which gives consistent results regardless
of direction.  Also add 1-second windowed throughput tracking to report
min and max speed alongside the average.
---
 monitor/analyze.c | 92 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 8 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 68e4910325e5..de9c23603a21 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -61,6 +61,14 @@ struct hci_stats {
 	struct queue *plot;
 	uint16_t min;
 	uint16_t max;
+	/* Wall-clock throughput tracking */
+	struct timeval first_ts;
+	struct timeval last_ts;
+	/* Windowed throughput (1-second windows) */
+	struct timeval window_start;
+	size_t window_bytes;
+	long long speed_min;	/* Kb/s, 0 = not set */
+	long long speed_max;	/* Kb/s */
 };
 
 struct hci_conn {
@@ -141,6 +149,8 @@ static void plot_draw(struct queue *queue, const char *title)
 
 static void print_stats(struct hci_stats *stats, const char *label)
 {
+	long long duration_ms;
+
 	if (!stats->num)
 		return;
 
@@ -152,9 +162,41 @@ static void print_stats(struct hci_stats *stats, const char *label)
 	print_field("%s size: %u-%u octets (~%zd octets)", label,
 			stats->min, stats->max, stats->bytes / stats->num);
 
-	if (TV_MSEC(stats->latency.total))
-		print_field("%s speed: ~%lld Kb/s", label,
-			stats->bytes * 8 / TV_MSEC(stats->latency.total));
+	/* Compute wall-clock speed from first/last packet timestamps */
+	duration_ms = TV_MSEC(stats->last_ts) - TV_MSEC(stats->first_ts);
+	if (duration_ms > 0) {
+		long long avg_speed = stats->bytes * 8 / duration_ms;
+
+		/* Close the last window for min/max if it has data */
+		if (stats->window_bytes > 0 && stats->num > 1) {
+			struct timeval delta;
+			long long last_win_ms;
+
+			timersub(&stats->last_ts, &stats->window_start,
+								&delta);
+			last_win_ms = TV_MSEC(delta);
+			if (last_win_ms > 0) {
+				long long speed;
+
+				speed = stats->window_bytes * 8 /
+								last_win_ms;
+				if (!stats->speed_min ||
+						speed < stats->speed_min)
+					stats->speed_min = speed;
+				if (speed > stats->speed_max)
+					stats->speed_max = speed;
+			}
+		}
+
+		if (stats->speed_min && stats->speed_max)
+			print_field("%s speed: ~%lld Kb/s "
+				"(min ~%lld Kb/s max ~%lld Kb/s)",
+				label, avg_speed,
+				stats->speed_min, stats->speed_max);
+		else
+			print_field("%s speed: ~%lld Kb/s", label,
+								avg_speed);
+	}
 
 	plot_draw(stats->plot, label);
 }
@@ -1066,7 +1108,8 @@ static void event_pkt(struct timeval *tv, uint16_t index,
 	}
 }
 
-static void stats_add(struct hci_stats *stats, uint16_t size)
+static void stats_add(struct hci_stats *stats, struct timeval *tv,
+							uint16_t size)
 {
 	stats->num++;
 	stats->bytes += size;
@@ -1075,6 +1118,39 @@ static void stats_add(struct hci_stats *stats, uint16_t size)
 		stats->min = size;
 	if (!stats->max || size > stats->max)
 		stats->max = size;
+
+	/* Wall-clock timestamp tracking */
+	if (!timerisset(&stats->first_ts))
+		stats->first_ts = *tv;
+	stats->last_ts = *tv;
+
+	/* Windowed throughput: 1-second windows */
+	if (!timerisset(&stats->window_start)) {
+		stats->window_start = *tv;
+		stats->window_bytes = size;
+	} else {
+		struct timeval delta;
+
+		timersub(tv, &stats->window_start, &delta);
+		if (TV_MSEC(delta) >= 1000) {
+			/* Close current window, compute speed */
+			long long speed;
+
+			speed = stats->window_bytes * 8 /
+						TV_MSEC(delta);
+
+			if (!stats->speed_min || speed < stats->speed_min)
+				stats->speed_min = speed;
+			if (speed > stats->speed_max)
+				stats->speed_max = speed;
+
+			/* Start new window */
+			stats->window_start = *tv;
+			stats->window_bytes = size;
+		} else {
+			stats->window_bytes += size;
+		}
+	}
 }
 
 static void conn_pkt_tx(struct hci_conn *conn, struct timeval *tv,
@@ -1087,10 +1163,10 @@ static void conn_pkt_tx(struct hci_conn *conn, struct timeval *tv,
 	last_tx->chan = chan;
 	queue_push_tail(conn->tx_queue, last_tx);
 
-	stats_add(&conn->tx, size);
+	stats_add(&conn->tx, tv, size);
 
 	if (chan)
-		stats_add(&chan->tx, size);
+		stats_add(&chan->tx, tv, size);
 }
 
 static void conn_pkt_rx(struct hci_conn *conn, struct timeval *tv,
@@ -1106,7 +1182,7 @@ static void conn_pkt_rx(struct hci_conn *conn, struct timeval *tv,
 
 	conn->last_rx = *tv;
 
-	stats_add(&conn->rx, size);
+	stats_add(&conn->rx, tv, size);
 	conn->rx.num_comp++;
 
 	if (chan) {
@@ -1118,7 +1194,7 @@ static void conn_pkt_rx(struct hci_conn *conn, struct timeval *tv,
 
 		chan->last_rx = *tv;
 
-		stats_add(&chan->rx, size);
+		stats_add(&chan->rx, tv, size);
 		chan->rx.num_comp++;
 	}
 }
-- 
2.53.0

