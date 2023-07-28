Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FB1C001DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 22:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjG1Wm4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 18:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjG1Wmz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 18:42:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754FE421C
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 15:42:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686f090310dso2458803b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 15:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690584173; x=1691188973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvlh7azK0k6mHhSmylrvFhEeH7R3U1pM9PhXU1dT/zA=;
        b=QvhSum4AOtA0p91ZdxvKeinusRmV07P1pbf7Nk7IiAifjL5t0zEV4QevvE0IfrA2gu
         rKCLEclotJzgzNnIgNXO9QziQAwytdax1h75MLvzELwwvNhDLs3y+c/PVso9gUWXqFAS
         QsVVgVL4+FRUFrXx9O5J7Fp/152WvWeKJN9Z3+Mrz+MZOtosxw+TEd9pbhocSgeh2rmf
         O9N7SuNoZoVHP91SNQKLC/+4hRr2AQ050fCvykVP2hR5oeqkNclW/8/ocWuqw5loWYnA
         k8OSfuph+dPNHcmVHf3+tzcvadVY3WIER6zgDSIEUg3qlIONS1h/jDU/T2fTWsi8Nll5
         hWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690584173; x=1691188973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvlh7azK0k6mHhSmylrvFhEeH7R3U1pM9PhXU1dT/zA=;
        b=ZzfxO0JRLNaXOtrkOnRjaKxE32tn96YCHqXxoi+rv1eYB/TGanrNraO+cJMdEDX05Q
         bImlSsfVX47t6vGH4geezXe2tUPMlBkYronqbMWgGI7nNtqpIM3ilG+TzYzcamDmtz4R
         ALEC0V72xSjip9SESpKW9+taUL4JpWyhNEI5VcqQuyQjQ8YBumzeWqMSe+CJweBrctcN
         oqLSUni0DULsueh0/gyj+priyEqV3Hw5jXyBqAkUb4eS3StT7Eo7YID6UIPnD/RPBVn8
         +5QyTiGGnIK3552GMMqJBz8ENs6Q3h4+8iNa9GqFzadVSrjDC8NHWggv+n/fQzxsU9+N
         noHQ==
X-Gm-Message-State: ABy/qLaKoqHbUNPCZRLM52w5pl5OZvB+NVhcYbv8ktlG4KKhbvfykN6C
        5qk9b8/Jqqi6iWjKbArkxqZKFis3+ts=
X-Google-Smtp-Source: APBJJlEKC/1jf+2LebI3WaEsIk2bgGLWf84L7b5tRZbBAlRFIex+FgfcFxWkLgY672E7FM2mYh8jLQ==
X-Received: by 2002:a05:6a20:6a0f:b0:130:45cc:9ae7 with SMTP id p15-20020a056a206a0f00b0013045cc9ae7mr3998991pzk.38.1690584173196;
        Fri, 28 Jul 2023 15:42:53 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id x41-20020a056a000be900b0068703879d3esm2731041pfu.113.2023.07.28.15.42.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 15:42:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v5 3/7] monitor: Consolidate code around latency calculation
Date:   Fri, 28 Jul 2023 15:42:43 -0700
Message-ID: <20230728224247.102057-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728224247.102057-1-luiz.dentz@gmail.com>
References: <20230728224247.102057-1-luiz.dentz@gmail.com>
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
index 991373dbb348..ddaaf6942035 100644
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

