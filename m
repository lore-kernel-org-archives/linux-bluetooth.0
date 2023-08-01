Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD111EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Aug 2023 23:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjHAXVr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 19:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjHAXVp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 19:21:45 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AE3269A
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 16:21:43 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f94328a4so233659b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Aug 2023 16:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690932101; x=1691536901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGdN2bLVyroX7eOEJoTxXxLAwDoSogPhY6dWkJKYs4U=;
        b=aanq8ahmlrIRNr+UMYnkqq990pIcZLhrPRiqRneKLUjyczsZEwvsHJu/ONKYd/ZGqa
         k5pIvHa2NL1Yzl/KjnPqFTeLpr9Q4b1U73h1dS41FdFemYvTUQl6PN7gUkD/lomAnPVu
         nlcvONQDNaPtFnA/59HUZcw/scj85mKoQG5+7zLlpLwA01g/33wYg1598pZTiE8/Xjyk
         wkQf7T3zThxu0Fc29pvqTwTalLxOgLsM4K0+TSF+iBXPEzuOHQugv5+9EvfTIe1twD9C
         NQlRKDLHz8ekz2tEIqS4OYQgSheSKcxyYqIAcZJ/mzMvdRazcQ+F8iSwStDLc3kvVsZS
         eV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690932101; x=1691536901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGdN2bLVyroX7eOEJoTxXxLAwDoSogPhY6dWkJKYs4U=;
        b=FbcvXqPIOzG8CPSCMNgn+f12Eb72R8BfTatdgIkg9qihcVzQYb4veNSfVHp8/u58wm
         Oi6PLH25JM7n8qv6s2V4LQN+NRX52mPF9T/HdJQkSgEBC24cXka9migyjaWFTQXUxDBS
         NWuXsOzUCiq25z2KWlma5DpQ3qUVs2j4mH3Nm1Ovwc+hEBCbmJJzRCy84prZ9Pq9Anz9
         BAEJVyRi7cs7YWdv81FsRqow2Sbu2flSHbv/G/dcHfRYlcL0tRyxhpi4piddStr2lGXp
         03Uh1MYPb0Sl5mAsDqr8ShYYSFSD7rKd4K6P3OMsyaYeNlg3Y/o/X0yPvNxDza9AP17F
         lRrw==
X-Gm-Message-State: ABy/qLauvn7glwkKwo8VaHrzD6uZxNhTuvyB0x2uxIH6AhX/DqmXbnRb
        1ui3suAnA8v9EN78WBAR42yitEkD6EM=
X-Google-Smtp-Source: APBJJlHdeJ3FcBTKdwWhlwhrrbUBMsvQIAyzY3UNAnV89Kt8QLMQHKupmKVCZMj3XLuYTNs7zfl9wA==
X-Received: by 2002:a05:6a00:847:b0:67a:52a7:b278 with SMTP id q7-20020a056a00084700b0067a52a7b278mr18575166pfk.9.1690932101358;
        Tue, 01 Aug 2023 16:21:41 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id fk25-20020a056a003a9900b00682a8e600f0sm9856157pfb.35.2023.08.01.16.21.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 16:21:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 3/5] monitor: Print channel latency information with -a/--analyze
Date:   Tue,  1 Aug 2023 16:21:33 -0700
Message-ID: <20230801232135.535733-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801232135.535733-1-luiz.dentz@gmail.com>
References: <20230801232135.535733-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints channel latency information and use gnuplot when using
-a/--analyze to plot a graph of channels:

  Found TX L2CAP channel with CID 68
        PSM 25
        22490 packets
        7-50 msec (~11 msec) TX Latency
        850-850 octets TX packet size
        ~569 Kb/s TX transfer speed

  10000 +-+----------------------------------------------------------------+
         +|     ++                                                         |
         +|     || +                                       Packets +-----+ |
         +|   + || |                                                       |
   1000 +-|   | || |+ ++                                                   |
         +|   | || || ||   +                                               |
         +|   | || || ||+ +|                                               |
         +|   | || || ||| || ++ ++                                         |
    100 +-|   | || || ||| || || ||   +                                     |
         +|   | || || ||| || || || ++| +   +                               |
         +|   | || || ||| || || || ||| |   |                               |
         +|   | || || ||| || || || ||| |+ +| +                             |
          |   | || || ||| || || || ||| || || |+ +                          |
     10 +-|   | || || ||| || || || ||| || || || |+                         |
         +|   | || || ||| || || || ||| || || || ||     +                   |
         +|  +| || || ||| || || || ||| || || || ||+ ++ |+ ++ +             |
          |  || || || ||| || || || ||| || || || ||| || || || |             |
      1 +-|  || || || ||| || || || ||| || || || ||| || || || |   +     +   |
         ++----------------------------------------------------------------+
          +      +      +       +      +      +      +       +      +      +
          5      10     15      20     25     30     35      40     45     50
                                    Latency (ms)
---
 monitor/analyze.c | 169 +++++++++++++++++++++++++++++-----------------
 1 file changed, 107 insertions(+), 62 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index a016e26e31ac..89b0382825dc 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -78,6 +78,11 @@ struct hci_conn {
 	struct queue *chan_list;
 };
 
+struct hci_conn_tx {
+	struct timeval tv;
+	struct l2cap_chan *chan;
+};
+
 struct plot {
 	long long x_msec;
 	size_t y_count;
@@ -88,61 +93,15 @@ struct l2cap_chan {
 	uint16_t psm;
 	bool out;
 	unsigned long num;
+	size_t tx_bytes;
+	struct packet_latency tx_l;
+	struct queue *plot;
+	uint16_t tx_pkt_min;
+	uint16_t tx_pkt_max;
 };
 
 static struct queue *dev_list;
 
-static void chan_destroy(void *data)
-{
-	struct l2cap_chan *chan = data;
-
-	printf("    Found %s L2CAP channel with CID %u\n",
-					chan->out ? "TX" : "RX", chan->cid);
-	if (chan->psm)
-		printf("      PSM %u\n", chan->psm);
-	printf("      %lu packets\n", chan->num);
-
-	free(chan);
-}
-
-static struct l2cap_chan *chan_alloc(struct hci_conn *conn, uint16_t cid,
-								bool out)
-{
-	struct l2cap_chan *chan;
-
-	chan = new0(struct l2cap_chan, 1);
-
-	chan->cid = cid;
-	chan->out = out;
-
-	return chan;
-}
-
-static bool chan_match_cid(const void *a, const void *b)
-{
-	const struct l2cap_chan *chan = a;
-	uint32_t val = PTR_TO_UINT(b);
-	uint16_t cid = val & 0xffff;
-	bool out = val & 0x10000;
-
-	return chan->cid == cid && chan->out == out;
-}
-
-static struct l2cap_chan *chan_lookup(struct hci_conn *conn, uint16_t cid,
-								bool out)
-{
-	struct l2cap_chan *chan;
-	uint32_t val = cid | (out ? 0x10000 : 0);
-
-	chan = queue_find(conn->chan_list, chan_match_cid, UINT_TO_PTR(val));
-	if (!chan) {
-		chan = chan_alloc(conn, cid, out);
-		queue_push_tail(conn->chan_list, chan);
-	}
-
-	return chan;
-}
-
 static void tmp_write(void *data, void *user_data)
 {
 	struct plot *plot = data;
@@ -184,6 +143,74 @@ done:
 	unlink(filename);
 }
 
+static void chan_destroy(void *data)
+{
+	struct l2cap_chan *chan = data;
+
+	printf("  Found %s L2CAP channel with CID %u\n",
+					chan->out ? "TX" : "RX", chan->cid);
+	if (chan->psm)
+		print_field("PSM %u", chan->psm);
+
+	print_field("%lu packets", chan->num);
+
+	if (!queue_isempty(chan->plot)) {
+		print_field("%lld-%lld msec (~%lld msec) TX Latency",
+			TV_MSEC(chan->tx_l.min), TV_MSEC(chan->tx_l.max),
+			TV_MSEC(chan->tx_l.med));
+		print_field("%u-%u octets TX packet size",
+				chan->tx_pkt_min, chan->tx_pkt_max);
+	}
+
+	if (TV_MSEC(chan->tx_l.total))
+		print_field("~%lld Kb/s TX transfer speed",
+				chan->tx_bytes * 8 / TV_MSEC(chan->tx_l.total));
+
+	if (chan->num > 1)
+		plot_draw(chan->plot);
+
+	free(chan);
+}
+
+static struct l2cap_chan *chan_alloc(struct hci_conn *conn, uint16_t cid,
+								bool out)
+{
+	struct l2cap_chan *chan;
+
+	chan = new0(struct l2cap_chan, 1);
+
+	chan->cid = cid;
+	chan->out = out;
+	chan->plot = queue_new();
+
+	return chan;
+}
+
+static bool chan_match_cid(const void *a, const void *b)
+{
+	const struct l2cap_chan *chan = a;
+	uint32_t val = PTR_TO_UINT(b);
+	uint16_t cid = val & 0xffff;
+	bool out = val & 0x10000;
+
+	return chan->cid == cid && chan->out == out;
+}
+
+static struct l2cap_chan *chan_lookup(struct hci_conn *conn, uint16_t cid,
+								bool out)
+{
+	struct l2cap_chan *chan;
+	uint32_t val = cid | (out ? 0x10000 : 0);
+
+	chan = queue_find(conn->chan_list, chan_match_cid, UINT_TO_PTR(val));
+	if (!chan) {
+		chan = chan_alloc(conn, cid, out);
+		queue_push_tail(conn->chan_list, chan);
+	}
+
+	return chan;
+}
+
 static void conn_destroy(void *data)
 {
 	struct hci_conn *conn = data;
@@ -506,9 +533,11 @@ static void plot_add(struct queue *queue, struct timeval *latency,
 {
 	struct plot *plot;
 
-	plot = queue_find(queue, match_plot_latency, latency);
+	/* Use LRU ordering */
+	plot = queue_remove_if(queue, match_plot_latency, latency);
 	if (plot) {
 		plot->y_count += count;
+		queue_push_head(queue, plot);
 		return;
 	}
 
@@ -533,7 +562,7 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 		uint16_t count = get_le16(data + 2);
 		struct hci_conn *conn;
 		struct timeval res;
-		struct timeval *last_tx;
+		struct hci_conn_tx *last_tx;
 		int j;
 
 		data += 4;
@@ -548,11 +577,17 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 		for (j = 0; j < count; j++) {
 			last_tx = queue_pop_head(conn->tx_queue);
 			if (last_tx) {
-				timersub(tv, last_tx, &res);
+				struct l2cap_chan *chan = last_tx->chan;
+
+				timersub(tv, &last_tx->tv, &res);
 
 				packet_latency_add(&conn->tx_l, &res);
+				plot_add(conn->plot, &res, 1);
 
-				plot_add(conn->plot, &res, count);
+				if (chan) {
+					packet_latency_add(&chan->tx_l, &res);
+					plot_add(chan->plot, &res, 1);
+				}
 
 				free(last_tx);
 			}
@@ -601,14 +636,15 @@ static void event_pkt(struct timeval *tv, uint16_t index,
 }
 
 static void conn_pkt_tx(struct hci_conn *conn, struct timeval *tv,
-					uint16_t size)
+				uint16_t size, struct l2cap_chan *chan)
 {
-	struct timeval *last_tx;
+	struct hci_conn_tx *last_tx;
 
 	conn->tx_num++;
 
-	last_tx = new0(struct timeval, 1);
+	last_tx = new0(struct hci_conn_tx, 1);
 	memcpy(last_tx, tv, sizeof(*tv));
+	last_tx->chan = chan;
 	queue_push_tail(conn->tx_queue, last_tx);
 	conn->tx_bytes += size;
 
@@ -616,6 +652,15 @@ static void conn_pkt_tx(struct hci_conn *conn, struct timeval *tv,
 		conn->tx_pkt_min = size;
 	if (!conn->tx_pkt_max || size > conn->tx_pkt_max)
 		conn->tx_pkt_max = size;
+
+	if (chan) {
+		chan->tx_bytes += size;
+
+		if (!chan->tx_pkt_min || size < chan->tx_pkt_min)
+			chan->tx_pkt_min = size;
+		if (!chan->tx_pkt_max || size > chan->tx_pkt_max)
+			chan->tx_pkt_max = size;
+	}
 }
 
 static void acl_pkt(struct timeval *tv, uint16_t index, bool out,
@@ -624,7 +669,7 @@ static void acl_pkt(struct timeval *tv, uint16_t index, bool out,
 	const struct bt_hci_acl_hdr *hdr = data;
 	struct hci_dev *dev;
 	struct hci_conn *conn;
-	struct l2cap_chan *chan;
+	struct l2cap_chan *chan = NULL;
 	uint16_t cid;
 
 	data += sizeof(*hdr);
@@ -655,7 +700,7 @@ static void acl_pkt(struct timeval *tv, uint16_t index, bool out,
 	}
 
 	if (out) {
-		conn_pkt_tx(conn, tv, size);
+		conn_pkt_tx(conn, tv, size, chan);
 	} else {
 		conn->rx_num++;
 	}
@@ -681,7 +726,7 @@ static void sco_pkt(struct timeval *tv, uint16_t index, bool out,
 		return;
 
 	if (out) {
-		conn_pkt_tx(conn, tv, size - sizeof(*hdr));
+		conn_pkt_tx(conn, tv, size - sizeof(*hdr), NULL);
 	} else {
 		conn->rx_num++;
 	}
@@ -768,7 +813,7 @@ static void iso_pkt(struct timeval *tv, uint16_t index, bool out,
 		return;
 
 	if (out) {
-		conn_pkt_tx(conn, tv, size - sizeof(*hdr));
+		conn_pkt_tx(conn, tv, size - sizeof(*hdr), NULL);
 	} else {
 		conn->rx_num++;
 	}
-- 
2.41.0

