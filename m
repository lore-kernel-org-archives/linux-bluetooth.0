Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A26C001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 22:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbjG1WnG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 18:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjG1WnF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 18:43:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A1E44B1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 15:43:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6862842a028so1937632b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 15:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690584180; x=1691188980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mvKrKUkOuXPlRJMRwTzdHt7gSh8VQHDYyBf1xu4Gs/w=;
        b=etcd/fdzTnfzQyn3HCGQlYPGRD+dz8hMrL5ze33HT7dmRbJ9Cu5tMtM/r/ntz2ZzeF
         d3sMwKQ+vG8dlZKenT8gZAkBBkhQRBgsRwnl04R/R87eHJL/9aI40NNx13u3KX6aEnAR
         eG41b4uQKF/cfJhNq9YALD5QxG3uKjw2Zc61uqmZCe7sVjZ+z8GE3HSR5jbfdJn2NdwT
         aN6kmxPqMOi7yO4s0UFP5KwOvpyZ5a0qANyfP01be5zcc4AGCETFMrRUGH7TerinxD0Y
         qsOXdM/GGOemT6B0Ls2zWwyp9F4JB8ox3bkaoqT2U34dsEageXge17A2h7MtXJpv+dou
         8Kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690584180; x=1691188980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvKrKUkOuXPlRJMRwTzdHt7gSh8VQHDYyBf1xu4Gs/w=;
        b=YV3VuFPPILT1KNLAyy2Tj7pEg7ZkOomrATE89jVSZmfe8P7Pdr6R9c6uQojP9bO1fi
         YQM+KFLIF5FD91ookCwZf/O+w70RgAUBWU25sPFmk/B4EytizS6m8AFgD/qm+N0scqdq
         np74+1iAaIQS9wJuJSgtYPpDpqlCgAuae/G1DR59uthiRIA2PqBI89Ybze7lui2Ywx5D
         wWyzloYcYuyJmrvLyNK0nDhr+CGFeqdz4MeMY32tf6y8eJfDxb1o09hKqmUYV6Fb8IDv
         /0iND7+6vm2XFg4L/PnVfBP1IHvGA0mC6mXm38HySifFKbpqzIQXRs0EK43OOqKBQI5f
         Aq1A==
X-Gm-Message-State: ABy/qLbM6YsSvv0zMRL5gyxijf7TBDNLTsG2ZVNuPuLu32H38RxvNZMc
        /hZ2xQvqaBUoZogVivMYqK+Yd/oDTr0=
X-Google-Smtp-Source: APBJJlFwZ6/WCr8raXPzEhGZMCBpf5L0YEM3fKRSsAyucVyeeSi5QEMGpp9yo6NV2HG723SDalcMmw==
X-Received: by 2002:a05:6a00:1953:b0:687:189c:4e3d with SMTP id s19-20020a056a00195300b00687189c4e3dmr1699520pfk.10.1690584179930;
        Fri, 28 Jul 2023 15:42:59 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id x41-20020a056a000be900b0068703879d3esm2731041pfu.113.2023.07.28.15.42.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 15:42:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v5 7/7] monitor/analyze: Fix not calculating latency for ISO/SCO packets
Date:   Fri, 28 Jul 2023 15:42:47 -0700
Message-ID: <20230728224247.102057-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728224247.102057-1-luiz.dentz@gmail.com>
References: <20230728224247.102057-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ISO/SCO packets latency was not being calculated because no connection was
being assigned to them.
---
 monitor/analyze.c | 56 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index c8192ffa7d2a..b4a7cf726ac9 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -652,10 +652,28 @@ static void acl_pkt(struct timeval *tv, uint16_t index, bool out,
 	}
 }
 
-static void sco_pkt(struct timeval *tv, uint16_t index,
+static void conn_pkt_tx(struct hci_conn *conn, struct timeval *tv,
+					uint16_t size)
+{
+	struct timeval *last_tx;
+
+	last_tx = new0(struct timeval, 1);
+	memcpy(last_tx, tv, sizeof(*tv));
+	queue_push_tail(conn->tx_queue, last_tx);
+	conn->tx_bytes += size;
+
+	if (!conn->tx_pkt_min || size < conn->tx_pkt_min)
+		conn->tx_pkt_min = size;
+	if (!conn->tx_pkt_max || size > conn->tx_pkt_max)
+		conn->tx_pkt_max = size;
+}
+
+static void sco_pkt(struct timeval *tv, uint16_t index, bool out,
 					const void *data, uint16_t size)
 {
+	const struct bt_hci_acl_hdr *hdr = data;
 	struct hci_dev *dev;
+	struct hci_conn *conn;
 
 	dev = dev_lookup(index);
 	if (!dev)
@@ -663,6 +681,18 @@ static void sco_pkt(struct timeval *tv, uint16_t index,
 
 	dev->num_hci++;
 	dev->num_sco++;
+
+	conn = conn_lookup_type(dev, le16_to_cpu(hdr->handle) & 0x0fff,
+								CONN_BR_SCO);
+	if (!conn)
+		return;
+
+	if (out) {
+		conn->tx_num++;
+		conn_pkt_tx(conn, tv, size - sizeof(*hdr));
+	} else {
+		conn->rx_num++;
+	}
 }
 
 static void info_index(struct timeval *tv, uint16_t index,
@@ -726,9 +756,11 @@ static void ctrl_msg(struct timeval *tv, uint16_t index,
 	dev->ctrl_msg++;
 }
 
-static void iso_pkt(struct timeval *tv, uint16_t index,
+static void iso_pkt(struct timeval *tv, uint16_t index, bool out,
 					const void *data, uint16_t size)
 {
+	const struct bt_hci_iso_hdr *hdr = data;
+	struct hci_conn *conn;
 	struct hci_dev *dev;
 
 	dev = dev_lookup(index);
@@ -737,6 +769,18 @@ static void iso_pkt(struct timeval *tv, uint16_t index,
 
 	dev->num_hci++;
 	dev->num_iso++;
+
+	conn = conn_lookup_type(dev, le16_to_cpu(hdr->handle) & 0x0fff,
+								CONN_LE_ISO);
+	if (!conn)
+		return;
+
+	if (out) {
+		conn->tx_num++;
+		conn_pkt_tx(conn, tv, size - sizeof(*hdr));
+	} else {
+		conn->rx_num++;
+	}
 }
 
 static void unknown_opcode(struct timeval *tv, uint16_t index,
@@ -804,8 +848,10 @@ void analyze_trace(const char *path)
 			acl_pkt(&tv, index, false, buf, pktlen);
 			break;
 		case BTSNOOP_OPCODE_SCO_TX_PKT:
+			sco_pkt(&tv, index, true, buf, pktlen);
+			break;
 		case BTSNOOP_OPCODE_SCO_RX_PKT:
-			sco_pkt(&tv, index, buf, pktlen);
+			sco_pkt(&tv, index, false, buf, pktlen);
 			break;
 		case BTSNOOP_OPCODE_OPEN_INDEX:
 		case BTSNOOP_OPCODE_CLOSE_INDEX:
@@ -829,8 +875,10 @@ void analyze_trace(const char *path)
 			ctrl_msg(&tv, index, buf, pktlen);
 			break;
 		case BTSNOOP_OPCODE_ISO_TX_PKT:
+			iso_pkt(&tv, index, true, buf, pktlen);
+			break;
 		case BTSNOOP_OPCODE_ISO_RX_PKT:
-			iso_pkt(&tv, index, buf, pktlen);
+			iso_pkt(&tv, index, false, buf, pktlen);
 			break;
 		default:
 			unknown_opcode(&tv, index, buf, pktlen);
-- 
2.41.0

