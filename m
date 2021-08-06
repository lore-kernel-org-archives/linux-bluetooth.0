Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5960EC432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 21:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4249061186
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 21:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245266AbhHFVgS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 17:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245263AbhHFVgS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 17:36:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003F4C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 14:36:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u16so8850104ple.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 14:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gdVERoANZ0tlHyrIe2eSl8nR3RSsn9oSS1Ntfv4qMVw=;
        b=so1EHZgEx0oSyQgH+cot1Yt2+IBCcAz6z5m2lZ0zSDqToDzrNBjAipX2OS9IFPCvAY
         bPCpKD0siETzvBdeTJCSMDhM4igPnkufWjXaRqEqy+jzeI4NBSBGfXuNr3hExU1vBkQ1
         WKJY65zHbA0gXhbYMJpgwWp01g64N8kVEqu7NWaQyfCLHfsKTnoodTF0i+QscXOXzk13
         9+gpbmq2vx25T545kvgOwKt6XLHrgYdrkcVP7FHlI/flykvzna4911qjkDgZG5ohUDAR
         qKkWsWkkoOdpSUqWI8knqu7rYsuFNztCMh/c1IHm4WANMVlsUHzWelAh9iv6dS/MPwd8
         H6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gdVERoANZ0tlHyrIe2eSl8nR3RSsn9oSS1Ntfv4qMVw=;
        b=dyri1L3jP7jzED38nhi+5K/yF2kuexxJcQ6EEpCNVUc7pmNau0TZCnns30f+aug2D2
         tjddOQ55xBhaRQQhsy5oMXnWGwr7kKHV+TlmNgE0ebj5YPFM0kVMl1kL4V/18aASc3qS
         e5uK5GM3gpB82SFUR9dhzS4gzA7dFOxfXPs6ka7TUKqjopYTHbTf4wKBYUQ6QIYDbpQ0
         F8Sg+WKuhSF1ybsKLGK9Ciywbe1PLqo0dcIcRN/2a6+Px0FBkhmuZ96Depdyat9Sw3z0
         XFMQLg/PlqSSLihwuGIyk90w/22B2uy0xrC3tRFoc/aMsnVTj3C0NDIt4gmgY7VPAO8e
         pWHQ==
X-Gm-Message-State: AOAM531hESelFJ2KRdm+iorPsiO751ObqfAOV0a7aymz3VTcgCScAZgr
        4jAR88vdZGAbX/O9bT8sPqLreGZLZjo=
X-Google-Smtp-Source: ABdhPJx5szF57bJCDJYRlJ+hL9KjnsdNi6a97QmHHccpXga3Ih8rjwYAcyJU/P19DKHE1yuSoGTEuQ==
X-Received: by 2002:a17:90a:e2c8:: with SMTP id fr8mr11921745pjb.131.1628285761361;
        Fri, 06 Aug 2021 14:36:01 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h20sm11765201pfn.173.2021.08.06.14.36.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:36:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] monitor: Fix not accouting for multiple outstanding packets
Date:   Fri,  6 Aug 2021 14:35:57 -0700
Message-Id: <20210806213558.16442-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806213558.16442-1-luiz.dentz@gmail.com>
References: <20210806213558.16442-1-luiz.dentz@gmail.com>
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

