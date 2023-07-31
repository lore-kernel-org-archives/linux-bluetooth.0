Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1043C001E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 20:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjGaUIu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 16:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaUIt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 16:08:49 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7D710E
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 13:08:48 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-34916d419a3so3880075ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 13:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690834127; x=1691438927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zAisdvmYOGIL7GH+7tWPlzo+7zINYpaH/xzNielVMYo=;
        b=p7ZDNqMtpZ8NcYsHpaPOhe4Nz6F8d0vqlW3Nx4Skl6/6mms/KD+gG7uNMwYgiwZA1I
         ZCxy5MnXLWzFiRWXlhL1m0DnN18tbukrBFoP+NZGdaNwaDgrYQEbByt5Z45oQ9pKeXSx
         LDqZAU9W3Dvw1p/+J2zAzFnwmLzvAkk4q53o0aypCWSlZnrP4yIIE6uhUny+018ZlqbM
         IgrlRXwEgIk5+ITDi2jvmQXvt4gLUAcMLlB1VPJqLB61tD5BCQZ0mcf8/R3lhqLegq3p
         MWxIFbrCBdqJUtxY/Eutci1HeGuLfRBmL483xhCFvR6QSqPkW+P5BpBD6bqZ/RRhoV97
         2/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690834127; x=1691438927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAisdvmYOGIL7GH+7tWPlzo+7zINYpaH/xzNielVMYo=;
        b=XZOf4dey3nCjCca3hIRy/YaeccpcIVZsXtJ/KRw96YkY5JK4dKLNb56Khm/Pled7sS
         eFKPusrpWvnjO0d5h3d7eL9f4ZP3l1CLhIB3y3htkqnRvNdqCXvqG3JxoZMsY+axWmol
         EZtHntK9U/3fTGTPfhCNQwiV5HNM+AG7KQcE+VVSSYQNuZWIdcDEfupHnFc2b5sSPaZp
         QIPJIUib9KdTDCu7b/Oof698ZH8g++hP3lh/YsylKPqhH+j8g/ndpyhTXCSOce74UaoE
         u7utscJbZgs9ZC8M/G9HdR+d9qK4TCLkITSvUPKFdC7znrbOZgH9uDMXtt6Dp9cHlxf+
         PBBA==
X-Gm-Message-State: ABy/qLYpQ1YUtJxYI15c6JMaW8GmolbjvWeO9khytRPCUJs1MU1ND1fI
        qqfTxHV+b+cYfS1bwbcdrSAOFFwOj8A=
X-Google-Smtp-Source: APBJJlG//abH5218hlVjix7dFSOF6o6SyBzZpQzDltJQcgkfssxgDp0E7Vsg2X0Y4KzFJ3JYry9/Kg==
X-Received: by 2002:a05:6e02:1a47:b0:345:fe2d:56f with SMTP id u7-20020a056e021a4700b00345fe2d056fmr10329257ilv.14.1690834126592;
        Mon, 31 Jul 2023 13:08:46 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id k6-20020a02ccc6000000b0042b1d495aecsm3318971jaq.123.2023.07.31.13.08.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:08:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Add TX frame number and speed estimation
Date:   Mon, 31 Jul 2023 13:08:44 -0700
Message-ID: <20230731200844.384507-1-luiz.dentz@gmail.com>
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
 monitor/analyze.c |  4 +++-
 monitor/packet.c  | 37 ++++++++++++++++++++++++-------------
 monitor/packet.h  |  7 +++++++
 3 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index b4a7cf726ac9..ff3b419c4c38 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -221,11 +221,13 @@ static void conn_destroy(void *data)
 	print_field("%lu RX packets", conn->rx_num);
 	print_field("%lu TX packets", conn->tx_num);
 	print_field("%lu TX completed packets", conn->tx_num_comp);
-	print_field("%lld-%lld msec (~%lld msec) TX Latency",
+	print_field("%lld-%lld msec (~%lld msec/~lld Kb/s) TX Latency",
 			TV_MSEC(conn->tx_l.min), TV_MSEC(conn->tx_l.max),
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

