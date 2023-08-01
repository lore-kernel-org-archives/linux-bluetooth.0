Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FF2EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Aug 2023 23:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjHAXbq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 19:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjHAXbo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 19:31:44 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8109D2690
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 16:31:39 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-77acb04309dso311534539f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Aug 2023 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690932698; x=1691537498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ6YRW/+NBQYYZauJ1pKe2cpcAAs1iTDa7rLKeHdW6k=;
        b=TbRnrDjO2z4W5xCHGvv4Zw70gPLYuAD9RIZn7FwE8QN4axW1gqnTRPKkuULfbW0Pv1
         ZlgD607tTyg7gb5oytQ8nyIg3Og73PVJQwaTy4m/ZmrfU/AKU3MP/4Af+TF8VBrkfH2P
         8MeEAAkLoIEvLk8W6mN2d6B/ZOY+CGSc/gRjA309MAzNQWnKlHi6RbIO5EX/KPM4tr/B
         TDe/YaEb/Oz613xwHaG5Tbd3H+z2NeN0PVz+RcNnOtBDAn6yS7P5S2Fhe8mRTTUWEX5k
         IWDknkfZYTUWoV/2dERtByodx5ig3PFP5MAtzK4kVMHUQ9uDOIIYwncCQ/q1ViF3TzJo
         /4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690932698; x=1691537498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ6YRW/+NBQYYZauJ1pKe2cpcAAs1iTDa7rLKeHdW6k=;
        b=bQ27uAWtBhybE/pUyzRJuY5hCwUcRCv925giuWGHQ+7K38/jY7cA4wpo2LdyROSdye
         n9OvwB2pkKkhjuVe60RHOuQB1D651sJOeEvE90xE5cSaLOifwRPonuY0NQ0rBqyEO4MC
         eKAg066CYF0TEUcNfUtv18AtGK7VSNUb9WFwK3RmK4eAe9BP2TXhw0lsfddYcWxoJkw5
         v21iflVSN4uf/T71pgGKXioouV9OmcuRJMbod5PdLLufusmoPSF/l8AqYMZsy+aautik
         GqWajgBNrx0L8fgsUtv+pSOl17dUZGb+RuUQzev9aXJmp/4LV6jqPpV0CPdl583KG2sl
         bdrQ==
X-Gm-Message-State: ABy/qLYLlEDCm+ZjMFw4PQ+YACofUiYUlAoy6ga7lEpcym7S8OYAoSq2
        R4hOAm+a9rZ9ggrHP1i8gWvz15Qpm+w=
X-Google-Smtp-Source: APBJJlHrWZrSRX79rxgJYT2go/GHulyr0RNEZNzNe2eW3lspByAeqaj72YPDGre3sc9QAJ8bPw1Kuw==
X-Received: by 2002:a6b:7116:0:b0:787:34d:f1ea with SMTP id q22-20020a6b7116000000b00787034df1eamr14637686iog.8.1690932697838;
        Tue, 01 Aug 2023 16:31:37 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id d20-20020a5d9bd4000000b00790af7745b1sm1286269ion.20.2023.08.01.16.31.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 16:31:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 1/5] monitor: Add TX frame number and speed estimation
Date:   Tue,  1 Aug 2023 16:31:31 -0700
Message-ID: <20230801233135.537864-1-luiz.dentz@gmail.com>
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

