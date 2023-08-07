Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B253EC41513
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 21:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjHGV6c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 17:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjHGV6b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 17:58:31 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C6FC1
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 14:58:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc7e65ea44so2021645ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Aug 2023 14:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691445508; x=1692050308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6SOAVMqMpOLZsaLwtI1hyIAM2BcgaSxDZZkckTXhdA8=;
        b=Iog0LGrXRrX3bJrFDTk6aKBQ318v1Fyiy9SqbAkSIqfUMHy4b8IdHfJdz0Zfdvx40e
         Zzmt7tZxSYXWWzjSNepOOzGO6Zxzc+VCt5fIkeAB3AMtvL6BrLKBjKnbATXruq1ThTuH
         U3oNB25qeH1ktkfImC4rmTnE0eICnJijkxXF/A9PFiV1QZ0OAnHeBTl2hGTVXb4WTb3v
         MqJkXi3SgxMd7d0Elh+G4x7HLm71fZ/1p13lY623MyRPPJdT73TCBnm9MbpaUz+Zb66P
         yGddtvIrbJxZ51EExlIQCH3/t4F3LED4KRMHvgVTk42vcLnPxyJNw0bJeHdsZnJWjQO0
         B2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691445508; x=1692050308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6SOAVMqMpOLZsaLwtI1hyIAM2BcgaSxDZZkckTXhdA8=;
        b=SYLDRRLg/z5hSO5vjLoqlIlahd9WMoDe0LOOq/CWZKkgsshLGcaE6mnt5A9C7oNzDZ
         Qvsid05OiGLlfMArGWxRuUPthM4yKvgtfxFySoMJu8CG6wC6BmgLrVotGfl3pXnHRjVC
         57mkTUTAKJt7RqsYJNT6epaeeP+iNhbDIerU+urkQsiSXlbwb/xTdyViVs0tUSBei9e4
         oX5AV80dIAEbzMMrAG4IQSeTdDxrC0wilrPhO9QT3StUioecuonl00JrARd8LJE/79iP
         obQIbGKZ2kgZdhRDhoU9z3lVzab9zgq+Tife9zeyCS9WPo+7mF2+pK8WzDUie2rxo4bc
         uu8Q==
X-Gm-Message-State: AOJu0Yz+YY4hWWmYgiHBIvko3ktIs1Y1mMg90dK6DyrfyMX1aptOCnG7
        yWTbyABQO+gPiyOrKqqgrMITw0lXL0s=
X-Google-Smtp-Source: AGHT+IHrcqUTGGpHUb1kX4E4tVtnhPQnMmQRB/K8tzrnkQNWclbAVJwkRV3Bh+U3owtYXht1u1i4tw==
X-Received: by 2002:a17:902:a3c8:b0:1b8:8702:1e7c with SMTP id q8-20020a170902a3c800b001b887021e7cmr8391148plb.33.1691445507916;
        Mon, 07 Aug 2023 14:58:27 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id kb14-20020a170903338e00b001bbbc655ca1sm7382986plb.219.2023.08.07.14.58.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:58:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Plot RX information with -a/--analyze
Date:   Mon,  7 Aug 2023 14:58:25 -0700
Message-ID: <20230807215825.1251961-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to plot the RX information just as TX:

  Found BR-ACL connection with handle 256
        Address: XX:XX:XX:XX:XX:XX
        RX packets: 60/60
        RX Latency: 0-39040 msec (~20294 msec)
        RX size: 6-344 octets (~34 octets)
        RX speed: ~0 Kb/s

  100 +-+------------------------------------------------------------------+
       +|                                                                  |
       +|                                                       RX +-----+ |
       +|                                                                  |
       +|                                                                  |
       +|                                                                  |
        |                                                                  |
        |                                                                  |
   10 +-|                                                                  |
       +|                                                                  |
       +|                                                                  |
       +|                                                                  |
       +|                                                                  |
       +|                                                                  |
        |                                                                  |
        |                                                                  |
    1 +-|  + +                                                           + |
       +|  | |                                                           | |
       ++------------------------------------------------------------------+
        +       +        +       +        +       +       +        +       +
        0      5000    10000   15000    20000   25000   30000    35000   40000
                                   Latency (ms)

        TX packets: 22548/22547
        TX Latency: 3-73 msec (~11 msec)
        TX size: 6-850 octets (~847 octets)
        TX speed: ~568 Kb/s
---
 monitor/analyze.c | 177 +++++++++++++++++++++++++++-------------------
 1 file changed, 103 insertions(+), 74 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 9f882a6c8b71..608ef4d77c85 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -59,23 +59,27 @@ struct hci_dev {
 #define CONN_LE_ACL	0x04
 #define CONN_LE_ISO	0x05
 
+struct hci_stats {
+	size_t bytes;
+	size_t num;
+	size_t num_comp;
+	struct packet_latency latency;
+	struct queue *plot;
+	uint16_t min;
+	uint16_t max;
+};
+
 struct hci_conn {
 	uint16_t handle;
 	uint8_t type;
 	uint8_t bdaddr[6];
 	bool setup_seen;
 	bool terminated;
-	unsigned long rx_num;
-	unsigned long tx_num;
-	unsigned long tx_num_comp;
-	size_t tx_bytes;
 	struct queue *tx_queue;
-	struct packet_latency tx_l;
-	struct queue *plot;
-	uint16_t tx_pkt_min;
-	uint16_t tx_pkt_max;
-	uint16_t tx_pkt_med;
+	struct timeval last_rx;
 	struct queue *chan_list;
+	struct hci_stats rx;
+	struct hci_stats tx;
 };
 
 struct hci_conn_tx {
@@ -92,12 +96,9 @@ struct l2cap_chan {
 	uint16_t cid;
 	uint16_t psm;
 	bool out;
-	unsigned long num;
-	size_t tx_bytes;
-	struct packet_latency tx_l;
-	struct queue *plot;
-	uint16_t tx_pkt_min;
-	uint16_t tx_pkt_max;
+	struct timeval last_rx;
+	struct hci_stats rx;
+	struct hci_stats tx;
 };
 
 static struct queue *dev_list;
@@ -110,7 +111,7 @@ static void tmp_write(void *data, void *user_data)
 	fprintf(tmp, "%lld %zu\n", plot->x_msec, plot->y_count);
 }
 
-static void plot_draw(struct queue *queue)
+static void plot_draw(struct queue *queue, const char *tittle)
 {
 	FILE *gplot;
 
@@ -130,37 +131,48 @@ static void plot_draw(struct queue *queue)
 	fprintf(gplot, "set tics out nomirror\n");
 	fprintf(gplot, "set log y\n");
 	fprintf(gplot, "set yrange [0.5:*]\n");
-	fprintf(gplot, "plot $data using 1:2 t 'Packets' w impulses\n");
+	fprintf(gplot, "plot $data using 1:2 t '%s' w impulses\n", tittle);
 	fflush(gplot);
 
 	pclose(gplot);
 }
 
+static void print_stats(struct hci_stats *stats, const char *label)
+{
+	if (!stats->num)
+		return;
+
+	print_field("%s packets: %zu/%zu", label, stats->num, stats->num_comp);
+	print_field("%s Latency: %lld-%lld msec (~%lld msec)", label,
+			TV_MSEC(stats->latency.min),
+			TV_MSEC(stats->latency.max),
+			TV_MSEC(stats->latency.med));
+	print_field("%s size: %u-%u octets (~%zd octets)", label,
+			stats->min, stats->max, stats->bytes / stats->num);
+
+	if (TV_MSEC(stats->latency.total))
+		print_field("%s speed: ~%lld Kb/s", label,
+			stats->bytes * 8 / TV_MSEC(stats->latency.total));
+
+	plot_draw(stats->plot, label);
+}
+
 static void chan_destroy(void *data)
 {
 	struct l2cap_chan *chan = data;
 
+	if (!chan->rx.num && !chan->tx.num)
+		goto done;
+
 	printf("  Found %s L2CAP channel with CID %u\n",
 					chan->out ? "TX" : "RX", chan->cid);
 	if (chan->psm)
 		print_field("PSM %u", chan->psm);
 
-	print_field("%lu packets", chan->num);
-
-	if (!queue_isempty(chan->plot)) {
-		print_field("%lld-%lld msec (~%lld msec) TX Latency",
-			TV_MSEC(chan->tx_l.min), TV_MSEC(chan->tx_l.max),
-			TV_MSEC(chan->tx_l.med));
-		print_field("%u-%u octets TX packet size",
-				chan->tx_pkt_min, chan->tx_pkt_max);
-	}
-
-	if (TV_MSEC(chan->tx_l.total))
-		print_field("~%lld Kb/s TX transfer speed",
-				chan->tx_bytes * 8 / TV_MSEC(chan->tx_l.total));
-
-	plot_draw(chan->plot);
+	print_stats(&chan->rx, "RX");
+	print_stats(&chan->tx, "TX");
 
+done:
 	free(chan);
 }
 
@@ -173,7 +185,8 @@ static struct l2cap_chan *chan_alloc(struct hci_conn *conn, uint16_t cid,
 
 	chan->cid = cid;
 	chan->out = out;
-	chan->plot = queue_new();
+	chan->rx.plot = queue_new();
+	chan->tx.plot = queue_new();
 
 	return chan;
 }
@@ -229,30 +242,16 @@ static void conn_destroy(void *data)
 		break;
 	}
 
-	if (conn->tx_num > 0)
-		conn->tx_pkt_med = conn->tx_bytes / conn->tx_num;
-
 	printf("  Found %s connection with handle %u\n", str, conn->handle);
 	/* TODO: Store address type */
 	packet_print_addr("Address", conn->bdaddr, 0x00);
 	if (!conn->setup_seen)
 		print_field("Connection setup missing");
-	print_field("%lu RX packets", conn->rx_num);
-	print_field("%lu TX packets", conn->tx_num);
-	print_field("%lu TX completed packets", conn->tx_num_comp);
-	print_field("%lld-%lld msec (~%lld msec) TX Latency",
-			TV_MSEC(conn->tx_l.min), TV_MSEC(conn->tx_l.max),
-			TV_MSEC(conn->tx_l.med));
-	print_field("%u-%u octets (~%u octets) TX packet size",
-			conn->tx_pkt_min, conn->tx_pkt_max, conn->tx_pkt_med);
+	print_stats(&conn->rx, "RX");
+	print_stats(&conn->tx, "TX");
 
-	if (TV_MSEC(conn->tx_l.total))
-		print_field("~%lld Kb/s TX transfer speed",
-			conn->tx_bytes * 8 / TV_MSEC(conn->tx_l.total));
-
-	plot_draw(conn->plot);
-
-	queue_destroy(conn->plot, free);
+	queue_destroy(conn->rx.plot, free);
+	queue_destroy(conn->tx.plot, free);
 	queue_destroy(conn->chan_list, chan_destroy);
 
 	queue_destroy(conn->tx_queue, free);
@@ -269,7 +268,8 @@ static struct hci_conn *conn_alloc(struct hci_dev *dev, uint16_t handle,
 	conn->handle = handle;
 	conn->type = type;
 	conn->tx_queue = queue_new();
-	conn->plot = queue_new();
+	conn->tx.plot = queue_new();
+	conn->rx.plot = queue_new();
 
 	conn->chan_list = queue_new();
 
@@ -566,7 +566,7 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 		if (!conn)
 			continue;
 
-		conn->tx_num_comp += count;
+		conn->tx.num_comp += count;
 
 		for (j = 0; j < count; j++) {
 			last_tx = queue_pop_head(conn->tx_queue);
@@ -575,12 +575,14 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 
 				timersub(tv, &last_tx->tv, &res);
 
-				packet_latency_add(&conn->tx_l, &res);
-				plot_add(conn->plot, &res, 1);
+				packet_latency_add(&conn->tx.latency, &res);
+				plot_add(conn->tx.plot, &res, 1);
 
 				if (chan) {
-					packet_latency_add(&chan->tx_l, &res);
-					plot_add(chan->plot, &res, 1);
+					chan->tx.num_comp += count;
+					packet_latency_add(&chan->tx.latency,
+									&res);
+					plot_add(chan->tx.plot, &res, 1);
 				}
 
 				free(last_tx);
@@ -733,31 +735,60 @@ static void event_pkt(struct timeval *tv, uint16_t index,
 	}
 }
 
+static void stats_add(struct hci_stats *stats, uint16_t size)
+{
+	stats->num++;
+	stats->bytes += size;
+
+	if (!stats->min || size < stats->min)
+		stats->min = size;
+	if (!stats->max || size > stats->max)
+		stats->max = size;
+}
+
 static void conn_pkt_tx(struct hci_conn *conn, struct timeval *tv,
 				uint16_t size, struct l2cap_chan *chan)
 {
 	struct hci_conn_tx *last_tx;
 
-	conn->tx_num++;
-
 	last_tx = new0(struct hci_conn_tx, 1);
 	memcpy(last_tx, tv, sizeof(*tv));
 	last_tx->chan = chan;
 	queue_push_tail(conn->tx_queue, last_tx);
-	conn->tx_bytes += size;
 
-	if (!conn->tx_pkt_min || size < conn->tx_pkt_min)
-		conn->tx_pkt_min = size;
-	if (!conn->tx_pkt_max || size > conn->tx_pkt_max)
-		conn->tx_pkt_max = size;
+	stats_add(&conn->tx, size);
+
+	if (chan)
+		stats_add(&chan->tx, size);
+}
+
+static void conn_pkt_rx(struct hci_conn *conn, struct timeval *tv,
+				uint16_t size, struct l2cap_chan *chan)
+{
+	struct timeval res;
+
+	if (timerisset(&conn->last_rx)) {
+		timersub(tv, &conn->last_rx, &res);
+		packet_latency_add(&conn->rx.latency, &res);
+		plot_add(conn->rx.plot, &res, 1);
+	}
+
+	conn->last_rx = *tv;
+
+	stats_add(&conn->rx, size);
+	conn->rx.num_comp++;
 
 	if (chan) {
-		chan->tx_bytes += size;
+		if (timerisset(&chan->last_rx)) {
+			timersub(tv, &chan->last_rx, &res);
+			packet_latency_add(&chan->rx.latency, &res);
+			plot_add(chan->rx.plot, &res, 1);
+		}
 
-		if (!chan->tx_pkt_min || size < chan->tx_pkt_min)
-			chan->tx_pkt_min = size;
-		if (!chan->tx_pkt_max || size > chan->tx_pkt_max)
-			chan->tx_pkt_max = size;
+		chan->last_rx = *tv;
+
+		stats_add(&chan->rx, size);
+		chan->rx.num_comp++;
 	}
 }
 
@@ -790,8 +821,6 @@ static void acl_pkt(struct timeval *tv, uint16_t index, bool out,
 	case 0x02:
 		cid = get_le16(data + 2);
 		chan = chan_lookup(conn, cid, out);
-		if (chan)
-			chan->num++;
 		if (cid == 1)
 			l2cap_sig(conn, out, data + 4, size - 4);
 		break;
@@ -800,7 +829,7 @@ static void acl_pkt(struct timeval *tv, uint16_t index, bool out,
 	if (out) {
 		conn_pkt_tx(conn, tv, size, chan);
 	} else {
-		conn->rx_num++;
+		conn_pkt_rx(conn, tv, size, chan);
 	}
 }
 
@@ -826,7 +855,7 @@ static void sco_pkt(struct timeval *tv, uint16_t index, bool out,
 	if (out) {
 		conn_pkt_tx(conn, tv, size - sizeof(*hdr), NULL);
 	} else {
-		conn->rx_num++;
+		conn_pkt_rx(conn, tv, size - sizeof(*hdr), NULL);
 	}
 }
 
@@ -913,7 +942,7 @@ static void iso_pkt(struct timeval *tv, uint16_t index, bool out,
 	if (out) {
 		conn_pkt_tx(conn, tv, size - sizeof(*hdr), NULL);
 	} else {
-		conn->rx_num++;
+		conn_pkt_rx(conn, tv, size - sizeof(*hdr), NULL);
 	}
 }
 
-- 
2.41.0

