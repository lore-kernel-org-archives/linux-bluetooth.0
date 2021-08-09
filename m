Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5317C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 22:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8EB860FC2
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 22:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbhHIWuI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhHIWuG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Aug 2021 18:50:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E4BC0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Aug 2021 15:49:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j1so30304110pjv.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Aug 2021 15:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gdVERoANZ0tlHyrIe2eSl8nR3RSsn9oSS1Ntfv4qMVw=;
        b=lhjV55QQ5WIXsRp6oz+talGjUNIu8WZXtjvrIZAb0OKqbYFiM2sDN+PLmhPFA5rXq9
         wWs3f8ZFvnod4iQy16OvmYgDaAT3spfEB1r5k5hzYdkL/razLGa9J6wLrUXrD8u1hjj/
         X7xVSgnjy5oiQWTejvauR6GkZP6PnzolDC6sWAwFjlUVX66iDZg3XbZiUH8SNhaWhOPl
         qkfInn5UUTYSYYuWxgK2BRukBxtENJmW0CERRFvLQVsaG566EGGf0CfGwz/TFWyx1Hed
         o5OgwlP7x6zcD9d8khnvfpdF6oad+xRdmY/xv0UFiHr1MIjjz/AeCD7o+za8cfzgdXFO
         W7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gdVERoANZ0tlHyrIe2eSl8nR3RSsn9oSS1Ntfv4qMVw=;
        b=DPw6GmODaoOQx18PY4W460P6ZsZ2urED8YuYJVhmiFurQSSvUmQaLfxzy5RYkoVPSy
         l38RKICYJh15Ql1xMeDrWQdmN6xaqBC97NSaRgGNd8y2366mdw8fLV6hrAiUTLomV2WO
         eN0hp22FnQDKKHRIdvv2hjdx+r0uqYIvv/HQuEl+j2IOZ+rOKPRQ5h6nfVGo+uDcDY3/
         IVRgljOXVB8CHeNz9olUy+dQYSl8Wv76idpDtuQQYxg19HmFW/e5tFAtJukE1Srnncl6
         mrr16xuAI1rhP6+HmIBfl6kNaAhk1e/cpQ6yHm+Q85lcJHLNAiyePhj+M57T0VdWYSZo
         /jBw==
X-Gm-Message-State: AOAM532bWRz39lv2B2s6zdGNb6VN3xOlifH5BXHMZXO5OxqZJaJV0fF0
        MCw6SznZmJfUpJKrPuSk9VNXnhH5n1g=
X-Google-Smtp-Source: ABdhPJzTZ/a0Ty7NRKLWAP0QVuxEJerVSQHoRnuuZeXYu3kZbGdLpVeyyGWzYP0aMV8MY7alif2bOQ==
X-Received: by 2002:a63:460d:: with SMTP id t13mr2800pga.41.1628549385351;
        Mon, 09 Aug 2021 15:49:45 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n35sm20826891pfv.152.2021.08.09.15.49.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 15:49:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 3/5] monitor: Fix not accouting for multiple outstanding packets
Date:   Mon,  9 Aug 2021 15:49:40 -0700
Message-Id: <20210809224942.225915-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210809224942.225915-1-luiz.dentz@gmail.com>
References: <20210809224942.225915-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Analyze code was not accounting for the fact that multiple outstanding
packets could be pending which will cause the last_tx to be overwritten
but its latency would be calculated against the very first packet
complete.
---
 monitor/analyze.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index d504c8d84..aae153f94 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -62,8 +62,7 @@ struct hci_conn {
 	unsigned long tx_num;
 	unsigned long tx_num_comp;
 	size_t tx_bytes;
-	struct timeval last_tx;
-	struct timeval last_tx_comp;
+	struct queue *tx_queue;
 	struct timeval tx_lat_min;
 	struct timeval tx_lat_max;
 	struct timeval tx_lat_med;
@@ -121,6 +120,7 @@ static void conn_destroy(void *data)
 	printf("    %u octets TX max packet size\n", conn->tx_pkt_max);
 	printf("    %u octets TX median packet size\n", conn->tx_pkt_med);
 
+	queue_destroy(conn->tx_queue, free);
 	free(conn);
 }
 
@@ -133,6 +133,7 @@ static struct hci_conn *conn_alloc(struct hci_dev *dev, uint16_t handle,
 
 	conn->handle = handle;
 	conn->type = type;
+	conn->tx_queue = queue_new();
 
 	return conn;
 }
@@ -372,6 +373,7 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 		uint16_t count = get_le16(data + 2);
 		struct hci_conn *conn;
 		struct timeval res;
+		struct timeval *last_tx;
 
 		data += 4;
 		size -= 4;
@@ -381,10 +383,10 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 			continue;
 
 		conn->tx_num_comp += count;
-		conn->last_tx_comp = *tv;
 
-		if (timerisset(&conn->last_tx)) {
-			timersub(&conn->last_tx_comp, &conn->last_tx, &res);
+		last_tx = queue_pop_head(conn->tx_queue);
+		if (last_tx) {
+			timersub(tv, last_tx, &res);
 
 			if ((!timerisset(&conn->tx_lat_min) ||
 					timercmp(&res, &conn->tx_lat_min, <)) &&
@@ -414,7 +416,7 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 			} else
 				conn->tx_lat_med = res;
 
-			timerclear(&conn->last_tx);
+			free(last_tx);
 		}
 	}
 }
@@ -489,8 +491,12 @@ static void acl_pkt(struct timeval *tv, uint16_t index, bool out,
 		return;
 
 	if (out) {
+		struct timeval *last_tx;
+
 		conn->tx_num++;
-		conn->last_tx = *tv;
+		last_tx = new0(struct timeval, 1);
+		memcpy(last_tx, tv, sizeof(*tv));
+		queue_push_tail(conn->tx_queue, last_tx);
 		conn->tx_bytes += size;
 
 		if (!conn->tx_pkt_min || size < conn->tx_pkt_min)
-- 
2.31.1

