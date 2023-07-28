Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37B3C001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 17:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbjG1R7r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 13:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbjG1R7q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 13:59:46 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC193C33
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 10:59:43 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666e97fcc60so1782131b3a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690567182; x=1691171982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibXM07c6qhpBPPubrRU/dg29tXbbaLxY26qKKoP83no=;
        b=ispfaMeyrqAXPdCkImLc8SH6Ix4lUtH23XX3gfzUAI0yrVF7JgLIe437LvfAoq5yQW
         qMwXqXx2i5VVeCU+ugjJvkuKbqSi8IEOoE4D3iWhIlCmsbmLh19uBbDkwE7gmwi2EOI2
         bY2E9iUiNlaSyo2goJUPDax7VXYJVpx2Jo9K7IVr2CyFc2sjKqlemq69MaJJTsNMitmC
         0au6Yz0Tk+Hiz418ns0/N+WvOT4UxlJLmUReDVXPtAi+FTEaW/OfKdFxIcQxUFElAPCc
         ty+E9tEXNTdvoZxO5gCvhBvyiG8PGFmrlHBEvu6wGBYpUOiAg0mTNEg+8mSHR2j4xCm6
         CZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690567182; x=1691171982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibXM07c6qhpBPPubrRU/dg29tXbbaLxY26qKKoP83no=;
        b=Ga/LAUNacUFvwPFYJ4vdSCsvnLAfg+pmJ8md4xdH6Ku76HrQ1AHILmxPmoph8y8h+O
         7xWSSGDyEDxGASHmOjncA6tv26YTkTyoNAl0sgdeE36oOfuPaq+XRER0GhabDI/dnaBR
         CrsoG/Crr+ay5qI6NTfBbcRLMF7PFxiN3UH1wGJA0YX7vRas3BZQM8Ypp+yA2CUzsCXP
         rcGE5fXWrU+WOYFdZMsdgwxntpUBmfdEKJSITTtfyPt/QY+RsSVOt5sVVB85JNCCNTXl
         XHm1MzSEMKyCeku+fIP07WZmB1E10vzc/SsEEapacgrxJ+tkLBaw3ZVBkza+7dtPuslx
         aq+Q==
X-Gm-Message-State: ABy/qLZjuvwshWaXwDA0VjVhkSSXzSufmIfErwdTPEISXWro4/SCKQ9N
        OTyTtnTQ6yqrnStf8QNILIM51h0jBlw=
X-Google-Smtp-Source: APBJJlG9O/1+8KUnAvX+ln+CWhzCl8+bq6johSitQt+41LfQtlZdvWv9EF6HOiU5dKICyb7yTywHnw==
X-Received: by 2002:a05:6a00:1883:b0:666:b254:1c9c with SMTP id x3-20020a056a00188300b00666b2541c9cmr2739459pfh.27.1690567182420;
        Fri, 28 Jul 2023 10:59:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id d7-20020aa78147000000b0068718aadda7sm427796pfn.108.2023.07.28.10.59.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 10:59:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v4 3/3] monitor: Consolidate code around latency calculation
Date:   Fri, 28 Jul 2023 10:59:37 -0700
Message-ID: <20230728175937.42818-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728175937.42818-1-luiz.dentz@gmail.com>
References: <20230728175937.42818-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This move latency calculations to a helper function called
packet_latency_add so it can get reused by the likes of l2cap.c and
analyze.c
---
 monitor/analyze.c | 44 ++++++-----------------------------
 monitor/l2cap.c   | 36 ++++-------------------------
 monitor/packet.c  | 59 +++++++++++++++++++++++++----------------------
 monitor/packet.h  | 12 +++++++---
 4 files changed, 51 insertions(+), 100 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 29aee5ad1680..1c5e2557add5 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -70,9 +70,7 @@ struct hci_conn {
 	unsigned long tx_num_comp;
 	size_t tx_bytes;
 	struct queue *tx_queue;
-	struct timeval tx_lat_min;
-	struct timeval tx_lat_max;
-	struct timeval tx_lat_med;
+	struct packet_latency tx_l;
 	struct queue *plot;
 	uint16_t tx_pkt_min;
 	uint16_t tx_pkt_max;
@@ -223,13 +221,11 @@ static void conn_destroy(void *data)
 	print_field("%lu RX packets", conn->rx_num);
 	print_field("%lu TX packets", conn->tx_num);
 	print_field("%lu TX completed packets", conn->tx_num_comp);
-	print_field("%lld msec min latency", TIMEVAL_MSEC(&conn->tx_lat_min));
-	print_field("%lld msec max latency", TIMEVAL_MSEC(&conn->tx_lat_max));
-	print_field("%lld msec median latency",
-			TIMEVAL_MSEC(&conn->tx_lat_med));
-	print_field("%u octets TX min packet size", conn->tx_pkt_min);
-	print_field("%u octets TX max packet size", conn->tx_pkt_max);
-	print_field("%u octets TX median packet size", conn->tx_pkt_med);
+	print_field("%lld-%lld msec (~%lld msec) TX Latency",
+			TV_MSEC(conn->tx_l.min), TV_MSEC(conn->tx_l.max),
+			TV_MSEC(conn->tx_l.med));
+	print_field("%u-%u octets (~%u octets) TX packet size",
+			conn->tx_pkt_min, conn->tx_pkt_max, conn->tx_pkt_med);
 
 	plot_draw(conn->plot);
 
@@ -550,33 +546,7 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 		if (last_tx) {
 			timersub(tv, last_tx, &res);
 
-			if ((!timerisset(&conn->tx_lat_min) ||
-					timercmp(&res, &conn->tx_lat_min, <)) &&
-					res.tv_sec >= 0 && res.tv_usec >= 0)
-				conn->tx_lat_min = res;
-
-			if (!timerisset(&conn->tx_lat_max) ||
-					timercmp(&res, &conn->tx_lat_max, >))
-				conn->tx_lat_max = res;
-
-			if (timerisset(&conn->tx_lat_med)) {
-				struct timeval tmp;
-
-				timeradd(&conn->tx_lat_med, &res, &tmp);
-
-				tmp.tv_sec /= 2;
-				tmp.tv_usec /= 2;
-				if (tmp.tv_sec % 2) {
-					tmp.tv_usec += 500000;
-					if (tmp.tv_usec >= 1000000) {
-						tmp.tv_sec++;
-						tmp.tv_usec -= 1000000;
-					}
-				}
-
-				conn->tx_lat_med = tmp;
-			} else
-				conn->tx_lat_med = res;
+			packet_latency_add(&conn->tx_l, &res);
 
 			plot_add(conn->plot, &res, count);
 
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 8258475d26dc..8f3d8e65b510 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -100,9 +100,7 @@ struct chan_data {
 	uint8_t  ext_ctrl;
 	uint8_t  seq_num;
 	uint16_t sdu;
-	struct timeval tx_min;
-	struct timeval tx_max;
-	struct timeval tx_med;
+	struct packet_latency tx_l;
 };
 
 static struct chan_data chan_list[MAX_CHAN];
@@ -2798,8 +2796,6 @@ void l2cap_packet(uint16_t index, bool in, uint16_t handle, uint8_t flags,
 	}
 }
 
-#define TV_MSEC(_tv) (long long)((_tv)->tv_sec * 1000 + (_tv)->tv_usec / 1000)
-
 void l2cap_dequeue_frame(struct timeval *delta, struct packet_conn_data *conn)
 {
 	struct l2cap_frame *frame;
@@ -2813,39 +2809,15 @@ void l2cap_dequeue_frame(struct timeval *delta, struct packet_conn_data *conn)
 	if (!chan)
 		return;
 
-	if ((!timerisset(&chan->tx_min) || timercmp(delta, &chan->tx_min, <))
-				&& delta->tv_sec >= 0 && delta->tv_usec >= 0)
-		chan->tx_min = *delta;
-
-	if (!timerisset(&chan->tx_max) || timercmp(delta, &chan->tx_max, >))
-		chan->tx_max = *delta;
-
-	if (timerisset(&chan->tx_med)) {
-		struct timeval tmp;
-
-		timeradd(&chan->tx_med, delta, &tmp);
-
-		tmp.tv_sec /= 2;
-		tmp.tv_usec /= 2;
-		if (tmp.tv_sec % 2) {
-			tmp.tv_usec += 500000;
-			if (tmp.tv_usec >= 1000000) {
-				tmp.tv_sec++;
-				tmp.tv_usec -= 1000000;
-			}
-		}
-
-		chan->tx_med = tmp;
-	} else
-		chan->tx_med = *delta;
+	packet_latency_add(&chan->tx_l, delta);
 
 	print_field("Channel: %d [PSM %d mode %s (0x%02x)] {chan %d}",
 			frame->cid, frame->psm, mode2str(frame->mode),
 			frame->mode, frame->chan);
 
 	print_field("Channel Latency: %lld msec (%lld-%lld msec ~%lld msec)",
-			TV_MSEC(delta), TV_MSEC(&chan->tx_min),
-			TV_MSEC(&chan->tx_max), TV_MSEC(&chan->tx_med));
+			TV_MSEC(*delta), TV_MSEC(chan->tx_l.min),
+			TV_MSEC(chan->tx_l.max), TV_MSEC(chan->tx_l.med));
 
 	free(frame);
 }
diff --git a/monitor/packet.c b/monitor/packet.c
index f581a8e7233d..b905080edc60 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10336,7 +10336,34 @@ static void role_change_evt(struct timeval *tv, uint16_t index,
 	print_role(evt->role);
 }
 
-#define TV_MSEC(_tv) (long long)(_tv.tv_sec * 1000 + _tv.tv_usec / 1000)
+void packet_latency_add(struct packet_latency *latency, struct timeval *delta)
+{
+	if ((!timerisset(&latency->min) || timercmp(delta, &latency->min, <))
+				&& delta->tv_sec >= 0 && delta->tv_usec >= 0)
+		latency->min = *delta;
+
+	if (!timerisset(&latency->max) || timercmp(delta, &latency->max, >))
+		latency->max = *delta;
+
+	if (timerisset(&latency->med)) {
+		struct timeval tmp;
+
+		timeradd(&latency->med, delta, &tmp);
+
+		tmp.tv_sec /= 2;
+		tmp.tv_usec /= 2;
+		if (tmp.tv_sec % 2) {
+			tmp.tv_usec += 500000;
+			if (tmp.tv_usec >= 1000000) {
+				tmp.tv_sec++;
+				tmp.tv_usec -= 1000000;
+			}
+		}
+
+		latency->med = tmp;
+	} else
+		latency->med = *delta;
+}
 
 static void packet_dequeue_tx(struct timeval *tv, uint16_t handle)
 {
@@ -10354,35 +10381,11 @@ static void packet_dequeue_tx(struct timeval *tv, uint16_t handle)
 
 	timersub(tv, tx, &delta);
 
-	if ((!timerisset(&conn->tx_min) || timercmp(&delta, &conn->tx_min, <))
-				&& delta.tv_sec >= 0 && delta.tv_usec >= 0)
-		conn->tx_min = delta;
-
-	if (!timerisset(&conn->tx_max) || timercmp(&delta, &conn->tx_max, >))
-		conn->tx_max = delta;
-
-	if (timerisset(&conn->tx_med)) {
-		struct timeval tmp;
-
-		timeradd(&conn->tx_med, &delta, &tmp);
-
-		tmp.tv_sec /= 2;
-		tmp.tv_usec /= 2;
-		if (tmp.tv_sec % 2) {
-			tmp.tv_usec += 500000;
-			if (tmp.tv_usec >= 1000000) {
-				tmp.tv_sec++;
-				tmp.tv_usec -= 1000000;
-			}
-		}
-
-		conn->tx_med = tmp;
-	} else
-		conn->tx_med = delta;
+	packet_latency_add(&conn->tx_l, &delta);
 
 	print_field("Latency: %lld msec (%lld-%lld msec ~%lld msec)",
-			TV_MSEC(delta), TV_MSEC(conn->tx_min),
-			TV_MSEC(conn->tx_max), TV_MSEC(conn->tx_med));
+			TV_MSEC(delta), TV_MSEC(conn->tx_l.min),
+			TV_MSEC(conn->tx_l.max), TV_MSEC(conn->tx_l.med));
 
 	l2cap_dequeue_frame(&delta, conn);
 
diff --git a/monitor/packet.h b/monitor/packet.h
index 88f4c8241ff6..12cb68d508f8 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -23,6 +23,13 @@
 #define PACKET_FILTER_SHOW_A2DP_STREAM	(1 << 6)
 #define PACKET_FILTER_SHOW_MGMT_SOCKET	(1 << 7)
 #define PACKET_FILTER_SHOW_ISO_DATA	(1 << 8)
+#define TV_MSEC(_tv) (long long)((_tv).tv_sec * 1000 + (_tv).tv_usec / 1000)
+
+struct packet_latency {
+	struct timeval min;
+	struct timeval max;
+	struct timeval med;
+};
 
 struct packet_conn_data {
 	uint16_t index;
@@ -33,14 +40,13 @@ struct packet_conn_data {
 	uint8_t  dst_type;
 	struct queue *tx_q;
 	struct queue *chan_q;
-	struct timeval tx_min;
-	struct timeval tx_max;
-	struct timeval tx_med;
+	struct packet_latency tx_l;
 	void     *data;
 	void     (*destroy)(void *data);
 };
 
 struct packet_conn_data *packet_get_conn_data(uint16_t handle);
+void packet_latency_add(struct packet_latency *latency, struct timeval *delta);
 
 bool packet_has_filter(unsigned long filter);
 void packet_set_filter(unsigned long filter);
-- 
2.41.0

