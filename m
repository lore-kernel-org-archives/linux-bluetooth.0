Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B7AEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Aug 2023 23:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjHAXVm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 19:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjHAXVk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 19:21:40 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868472103
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 16:21:38 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686b643df5dso4426267b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Aug 2023 16:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690932097; x=1691536897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ6YRW/+NBQYYZauJ1pKe2cpcAAs1iTDa7rLKeHdW6k=;
        b=jNRpF089QA/ZiNCEAegP22R2mnGtGPW+XsA7R6kY/h7AAQW8DgVEjAZClH19IAV4rr
         CWlcr2WmGuagCzCknw20T2xLww6BOjUag16mwmgdynS+ESrG+RDhHVry22CxwWlxeP12
         auNvH+jGkbU8XSKMHWvYwH8sxAgptpbe7Oem9sSeGUHNZ6AYdTu63dtfa1XWbvkfhn7O
         FYKUkgnxVyM0LciHyv1Xv7mXbVj5XGea1KoCN2XCoLrpf1rAK6ikQjXSyu3hmhG6137O
         mJS9IVh/y/iuMKbYtyUV4vDbW3r77WBeLb99ZA1+3WVbuYLofGIwWFzO6ZfXd1J33Jsd
         hzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690932097; x=1691536897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ6YRW/+NBQYYZauJ1pKe2cpcAAs1iTDa7rLKeHdW6k=;
        b=CDy6tLEZeV1yB6nn1mIFvgeKQMZz+VvJC1I6ouTD096U3Cms4iXFZO8b+oFdzWKWh3
         T9Nh6Hj36NKmQ4sDDIUiuEFnL7zwsQ1/SuymxLEsUSYL1YfS5tDEWbFJ+aGxtUcra6OO
         SnulQMXZuoWpaqowXEZ2o3ogh2u/f2yDicyjbJViQ3f1+OOwmZOafheZlHBG33Sg4/DP
         +Ja7E8I1iNnE3urfO4yY8GL0bse8RjGKZ1xNKB6u2KIViiTbpn3wKObXPJ+XdRJuWE8x
         MP/hZ/c8jFy0QkP0pn7r4mULQtU5qcT7gno3OevCxJ2c0wXTlRmw8CpGtxTEtQhIfGS9
         ujaw==
X-Gm-Message-State: ABy/qLbQWHaasyNRvzmBYhznf+N1YFDDEihYz19EbM/KEug6glRmkfgf
        ins+Pdncd2/G9DIvMJINhdJYdKvvi20=
X-Google-Smtp-Source: APBJJlHRhsdxKMv4KMTLfS46yPrparet9ffSedGAYAJMH0c+TnZaQxOoPtC36ZFW/Zr7lc5WGjTFRg==
X-Received: by 2002:a05:6a00:1785:b0:679:bc89:e45 with SMTP id s5-20020a056a00178500b00679bc890e45mr16554303pfg.6.1690932097193;
        Tue, 01 Aug 2023 16:21:37 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id fk25-20020a056a003a9900b00682a8e600f0sm9856157pfb.35.2023.08.01.16.21.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 16:21:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 1/5] monitor: Add TX frame number and speed estimation
Date:   Tue,  1 Aug 2023 16:21:31 -0700
Message-ID: <20230801232135.535733-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the frame information while decoding:

> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 256 Address: XX:XX:XX:XX:XX:XX
        Count: 1
        #188: len 850 (755 Kb/s)
        Latency: 9 msec (3-21 msec ~6 msec)
        Channel: 68 [PSM 25 mode Basic (0x00)] {chan 4}
        Channel Latency: 9 msec (7-21 msec ~9 msec)

Or the speed estimation while analyzing:

  Found BR-ACL connection with handle 256
        Address: XX:XX:XX:XX:XX:XX
        60 RX packets
        22548 TX packets
        22547 TX completed packets
        3-73 msec (~11 msec) TX Latency
        6-850 octets (~847 octets) TX packet size
        ~568 Kb/s TX transfer speed
---
 monitor/analyze.c |  2 ++
 monitor/packet.c  | 37 ++++++++++++++++++++++++-------------
 monitor/packet.h  |  7 +++++++
 3 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index b4a7cf726ac9..db026190701d 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -226,6 +226,8 @@ static void conn_destroy(void *data)
 			TV_MSEC(conn->tx_l.med));
 	print_field("%u-%u octets (~%u octets) TX packet size",
 			conn->tx_pkt_min, conn->tx_pkt_max, conn->tx_pkt_med);
+	print_field("~%lld Kb/s TX transfer speed",
+			conn->tx_bytes * 8 / TV_MSEC(conn->tx_l.total));
 
 	plot_draw(conn->plot);
 
diff --git a/monitor/packet.c b/monitor/packet.c
index fb469cdeafed..84af03a0011f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10397,6 +10397,8 @@ static void role_change_evt(struct timeval *tv, uint16_t index,
 
 void packet_latency_add(struct packet_latency *latency, struct timeval *delta)
 {
+	timeradd(&latency->total, delta, &latency->total);
+
 	if ((!timerisset(&latency->min) || timercmp(delta, &latency->min, <))
 				&& delta->tv_sec >= 0 && delta->tv_usec >= 0)
 		latency->min = *delta;
@@ -10427,28 +10429,30 @@ void packet_latency_add(struct packet_latency *latency, struct timeval *delta)
 static void packet_dequeue_tx(struct timeval *tv, uint16_t handle)
 {
 	struct packet_conn_data *conn;
-	struct timeval *tx;
+	struct packet_frame *frame;
 	struct timeval delta;
 
 	conn = packet_get_conn_data(handle);
 	if (!conn)
 		return;
 
-	tx = queue_pop_head(conn->tx_q);
-	if (!tx)
+	frame = queue_pop_head(conn->tx_q);
+	if (!frame)
 		return;
 
-	timersub(tv, tx, &delta);
+	timersub(tv, &frame->tv, &delta);
 
 	packet_latency_add(&conn->tx_l, &delta);
 
+	print_field("#%zu: len %zu (%lld Kb/s)", frame->num, frame->len,
+					frame->len * 8 / TV_MSEC(delta));
 	print_field("Latency: %lld msec (%lld-%lld msec ~%lld msec)",
 			TV_MSEC(delta), TV_MSEC(conn->tx_l.min),
 			TV_MSEC(conn->tx_l.max), TV_MSEC(conn->tx_l.med));
 
 	l2cap_dequeue_frame(&delta, conn);
 
-	free(tx);
+	free(frame);
 }
 
 static void num_completed_packets_evt(struct timeval *tv, uint16_t index,
@@ -12442,10 +12446,11 @@ void packet_hci_event(struct timeval *tv, struct ucred *cred, uint16_t index,
 	event_data->func(tv, index, data, hdr->plen);
 }
 
-static void packet_queue_tx(struct timeval *tv, uint16_t handle)
+static void packet_enqueue_tx(struct timeval *tv, uint16_t handle,
+				size_t num, uint16_t len)
 {
 	struct packet_conn_data *conn;
-	struct timeval *tx;
+	struct packet_frame *frame;
 
 	conn = packet_get_conn_data(handle);
 	if (!conn)
@@ -12454,9 +12459,12 @@ static void packet_queue_tx(struct timeval *tv, uint16_t handle)
 	if (!conn->tx_q)
 		conn->tx_q = queue_new();
 
-	tx = new0(struct timeval, 1);
-	memcpy(tx, tv, sizeof(*tv));
-	queue_push_tail(conn->tx_q, tx);
+	frame = new0(struct packet_frame, 1);
+	if (tv)
+		memcpy(&frame->tv, tv, sizeof(*tv));
+	frame->num = num;
+	frame->len = len;
+	queue_push_tail(conn->tx_q, frame);
 }
 
 void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
@@ -12497,7 +12505,8 @@ void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
 						handle_str, extra_str);
 
 	if (!in)
-		packet_queue_tx(tv, acl_handle(handle));
+		packet_enqueue_tx(tv, acl_handle(handle),
+					index_list[index].frame, dlen);
 
 	if (size != dlen) {
 		print_text(COLOR_ERROR, "invalid packet size (%d != %d)",
@@ -12549,7 +12558,8 @@ void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 						handle_str, extra_str);
 
 	if (!in)
-		packet_queue_tx(tv, acl_handle(handle));
+		packet_enqueue_tx(tv, acl_handle(handle),
+					index_list[index].frame, hdr->dlen);
 
 	if (size != hdr->dlen) {
 		print_text(COLOR_ERROR, "invalid packet size (%d != %d)",
@@ -12599,7 +12609,8 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 						handle_str, extra_str);
 
 	if (!in)
-		packet_queue_tx(tv, acl_handle(handle));
+		packet_enqueue_tx(tv, acl_handle(handle),
+					index_list[index].frame, hdr->dlen);
 
 	if (size != hdr->dlen) {
 		print_text(COLOR_ERROR, "invalid packet size (%d != %d)",
diff --git a/monitor/packet.h b/monitor/packet.h
index 12cb68d508f8..750ce405e4bc 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -26,11 +26,18 @@
 #define TV_MSEC(_tv) (long long)((_tv).tv_sec * 1000 + (_tv).tv_usec / 1000)
 
 struct packet_latency {
+	struct timeval total;
 	struct timeval min;
 	struct timeval max;
 	struct timeval med;
 };
 
+struct packet_frame {
+	struct timeval tv;
+	size_t num;
+	size_t len;
+};
+
 struct packet_conn_data {
 	uint16_t index;
 	uint8_t  src[6];
-- 
2.41.0

