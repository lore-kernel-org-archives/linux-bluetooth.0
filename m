Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44E2C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 May 2023 20:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjEWU7G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 May 2023 16:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEWU7E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 May 2023 16:59:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA93818F
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 13:58:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae615d5018so1133615ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 13:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684875537; x=1687467537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Fr+9k0Omn8bToQ3LZevXXY7G+azW6ViA49JZOQx8Bw=;
        b=ozNLECx4HEqlO77MFR4qKoG98mJybpt1RNsgFV2RZFB8R1ZT+G3XXoI+APVc5Gpf//
         c1nboUZooTWMd/vK+RYXd96t0XDfgfluXP78EbpLiRhZcXfEU/c8Gz495cldZ3P9QB17
         abiUnCLBFP8nX4SIbvQHugwYROW3aOpY0i+gG4CrTUf9PPOBNLo0vh1wh7zBe8HKEdzW
         aRsUnf0UA/l5mXS/OEEJMQqtZQPagHwhmYSK+3lZ8xvPAJvWQXY0kMshn4yG3OfIom3a
         TtorEVsbVIGNH3m8t4lQdGWIC1/9YWEhqyCaMCVLuzMiPULMXrxVo7VlQjFdoPQ9o8RC
         lsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684875537; x=1687467537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Fr+9k0Omn8bToQ3LZevXXY7G+azW6ViA49JZOQx8Bw=;
        b=YOhbxRV8Sljr+bbGjJ8z34Pqy60b0aQL82/39DHVopHHPmJQGE/ibTwJ6aBVOKfYSP
         l0FhB7RzMtMQQg+D6N9RNWhkCNPgjnIaW8AVZ9gt7KTxJ2SwIINCZNld+sQZ2e1ochCZ
         faJlhwgIYOgPcBA0h2su98839FnCQ2EynAz7SQkQTiwGv/1gcVU/CE81OrZbSedShzwF
         ubQNExhJ1Lz/0nvg6s3V1wh7sFlzZpdVaZB1P3bH6BXewUdPbC+DbAiyVhEmisnM2oAE
         5eB3RdQLcsK2fRUfa9FrNGvg5DWXi+SKFPBsfjDEQTTBqCCOOH8EPlEP8gt1nFAEQGV2
         Nr0A==
X-Gm-Message-State: AC+VfDwRrsu9JgObo3mYo8U8qVZKKxVhdb/pzQ/qAPvUksqmK1LzPrJK
        GEtAayQuOM0qeE7kTBn16vEsU0RFBxg=
X-Google-Smtp-Source: ACHHUZ5oW/WITYvfcqySL+GCoI7GD+KH3vJblKMuvcP7LW6+gVKQRW68QlhCq+5bJQuI8A7iXRK2og==
X-Received: by 2002:a17:903:2796:b0:1ac:65ab:cf7b with SMTP id jw22-20020a170903279600b001ac65abcf7bmr15630610plb.9.1684875537299;
        Tue, 23 May 2023 13:58:57 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902e84c00b001a216d44440sm3836376plg.200.2023.05.23.13.58.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 13:58:56 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Add latency information per channel
Date:   Tue, 23 May 2023 13:58:55 -0700
Message-Id: <20230523205855.2821370-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to print latency information per channel in addition to
per connection/handle:

> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 256 Address: XX:XX:XX:XX:XX:XX
        Count: 1
        Latency: 15 msec (3-39 msec ~18 msec)
        Channel: 68 [PSM 25 mode Basic (0x00)] {chan 2}
        Channel Latency: 15 msec (6-35 msec ~18 msec)
---
 monitor/l2cap.c  | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 monitor/l2cap.h  |  2 ++
 monitor/packet.c |  7 ++++-
 monitor/packet.h |  1 +
 4 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 3f5554e5e33f..8258475d26dc 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -23,6 +23,7 @@
 #include "lib/uuid.h"
 
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 #include "bt.h"
 #include "packet.h"
 #include "display.h"
@@ -99,6 +100,9 @@ struct chan_data {
 	uint8_t  ext_ctrl;
 	uint8_t  seq_num;
 	uint16_t sdu;
+	struct timeval tx_min;
+	struct timeval tx_max;
+	struct timeval tx_med;
 };
 
 static struct chan_data chan_list[MAX_CHAN];
@@ -1538,6 +1542,23 @@ static const struct sig_opcode_data le_sig_opcode_table[] = {
 	{ },
 };
 
+static void l2cap_queue_frame(struct l2cap_frame *frame)
+{
+	struct packet_conn_data *conn;
+	struct l2cap_frame *tx;
+
+	conn = packet_get_conn_data(frame->handle);
+	if (!conn)
+		return;
+
+	if (!conn->chan_q)
+		conn->chan_q = queue_new();
+
+	tx = new0(struct l2cap_frame, 1);
+	memcpy(tx, frame, sizeof(*frame));
+	queue_push_tail(conn->chan_q, tx);
+}
+
 void l2cap_frame_init(struct l2cap_frame *frame, uint16_t index, bool in,
 				uint16_t handle, uint8_t ident,
 				uint16_t cid, uint16_t psm,
@@ -1554,6 +1575,9 @@ void l2cap_frame_init(struct l2cap_frame *frame, uint16_t index, bool in,
 	frame->psm     = psm ? psm : get_psm(frame);
 	frame->mode    = get_mode(frame);
 	frame->seq_num = psm ? 1 : get_seq_num(frame);
+
+	if (!in)
+		l2cap_queue_frame(frame);
 }
 
 static void bredr_sig_packet(uint16_t index, bool in, uint16_t handle,
@@ -2773,3 +2797,55 @@ void l2cap_packet(uint16_t index, bool in, uint16_t handle, uint8_t flags,
 		return;
 	}
 }
+
+#define TV_MSEC(_tv) (long long)((_tv)->tv_sec * 1000 + (_tv)->tv_usec / 1000)
+
+void l2cap_dequeue_frame(struct timeval *delta, struct packet_conn_data *conn)
+{
+	struct l2cap_frame *frame;
+	struct chan_data *chan;
+
+	frame = queue_pop_head(conn->chan_q);
+	if (!frame)
+		return;
+
+	chan = get_chan(frame);
+	if (!chan)
+		return;
+
+	if ((!timerisset(&chan->tx_min) || timercmp(delta, &chan->tx_min, <))
+				&& delta->tv_sec >= 0 && delta->tv_usec >= 0)
+		chan->tx_min = *delta;
+
+	if (!timerisset(&chan->tx_max) || timercmp(delta, &chan->tx_max, >))
+		chan->tx_max = *delta;
+
+	if (timerisset(&chan->tx_med)) {
+		struct timeval tmp;
+
+		timeradd(&chan->tx_med, delta, &tmp);
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
+		chan->tx_med = tmp;
+	} else
+		chan->tx_med = *delta;
+
+	print_field("Channel: %d [PSM %d mode %s (0x%02x)] {chan %d}",
+			frame->cid, frame->psm, mode2str(frame->mode),
+			frame->mode, frame->chan);
+
+	print_field("Channel Latency: %lld msec (%lld-%lld msec ~%lld msec)",
+			TV_MSEC(delta), TV_MSEC(&chan->tx_min),
+			TV_MSEC(&chan->tx_max), TV_MSEC(&chan->tx_med));
+
+	free(frame);
+}
diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index 935066e6e7dc..b545bf686c05 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -355,3 +355,5 @@ void l2cap_packet(uint16_t index, bool in, uint16_t handle, uint8_t flags,
 					const void *data, uint16_t size);
 
 void rfcomm_packet(const struct l2cap_frame *frame);
+
+void l2cap_dequeue_frame(struct timeval *delta, struct packet_conn_data *conn);
diff --git a/monitor/packet.c b/monitor/packet.c
index 67d1c7acff33..b492b8a757a5 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -40,13 +40,13 @@
 #include "ll.h"
 #include "hwdb.h"
 #include "keys.h"
+#include "packet.h"
 #include "l2cap.h"
 #include "control.h"
 #include "vendor.h"
 #include "msft.h"
 #include "intel.h"
 #include "broadcom.h"
-#include "packet.h"
 
 #define COLOR_CHANNEL_LABEL		COLOR_WHITE
 #define COLOR_FRAME_LABEL		COLOR_WHITE
@@ -210,6 +210,7 @@ static void release_handle(uint16_t handle)
 				conn->destroy(conn->data);
 
 			queue_destroy(conn->tx_q, free);
+			queue_destroy(conn->chan_q, free);
 			memset(conn, 0, sizeof(*conn));
 			break;
 		}
@@ -10353,6 +10354,10 @@ static void packet_dequeue_tx(struct timeval *tv, uint16_t handle)
 	print_field("Latency: %lld msec (%lld-%lld msec ~%lld msec)",
 			TV_MSEC(delta), TV_MSEC(conn->tx_min),
 			TV_MSEC(conn->tx_max), TV_MSEC(conn->tx_med));
+
+	l2cap_dequeue_frame(&delta, conn);
+
+	free(tx);
 }
 
 static void num_completed_packets_evt(struct timeval *tv, uint16_t index,
diff --git a/monitor/packet.h b/monitor/packet.h
index 8c47a542bca7..88f4c8241ff6 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -32,6 +32,7 @@ struct packet_conn_data {
 	uint8_t  dst[6];
 	uint8_t  dst_type;
 	struct queue *tx_q;
+	struct queue *chan_q;
 	struct timeval tx_min;
 	struct timeval tx_max;
 	struct timeval tx_med;
-- 
2.40.1

