Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EB6C41513
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 18:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjG0ShX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 14:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjG0ShV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 14:37:21 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A667126B2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 11:37:20 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686e0213c0bso991572b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690483039; x=1691087839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NooYqgMuLQmvvk9sLNuz16j/q9TGsAcMpTc382jvOGI=;
        b=shFgTu3n0JwamrZ2823YwjzyJAvNLDMeZ1bY+10HslOoNtpjci+pBKSAU03ci8UJZd
         t+ERo1LFG+6Wf+CUC24GMgM1i754UZe1sYr1J5x2OTMbQa6xZe4U5ejzbiWSrNEwsEWb
         b5Vu2Dn49KDJZJKRno2XbVSZTX6p95loCslLAbLjf6ZOO4erHMWR6N81ao1Lotd29O88
         Q1lQz4mPx/YMTf74XWQMXH3XWS6oGDgfEg16t3RVWN0bL0kZXaz9oO4OI1dgRwFcxwpC
         uU5tfWlxktw91gOfS13b/NpojTsv7SU5H+ZNfRtVrmXIkipJ/NEPoEkHkjI9bdJLVXlX
         rfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690483039; x=1691087839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NooYqgMuLQmvvk9sLNuz16j/q9TGsAcMpTc382jvOGI=;
        b=U3g28B01RnDps1N9IoivxogdqBDv+MCNN51Cl0pIwXEXas7IrtlxEQuRDb6w1mD/Lj
         NMGSZDMJmDhqwyR2C5PcDJTQWtr7kFrdPKoFNGKlBLV9JHlZvxS8BSY218HwVnKKEpDF
         bOHZSt3rx0ZT8qHedZh7VyNLVMj9uBUFuOm5ZcL0OVwCsbrtjvgWysJ5hyrfCJsn69um
         ST5jUdTwdtX2OOo/AWTGQMmvorwuaQrNQKtbwW7/tMSX19D4mIz4/oAKnhb3YgHXw4Gx
         A0ZB+XKChGMA30GKjHabyBJUpWBH27fik+UJaMMUorqr0K10hCOhv+9eimPLEoBtc8UM
         68ng==
X-Gm-Message-State: ABy/qLbMuM3I1DntK0lDARvQLrF5zcUq1CTdWNM4T3AroUi6npiT9j7H
        gw7l+yU95FKCXa3oZ7bW2lX6xIN8qzY=
X-Google-Smtp-Source: APBJJlGfB8TQJPqtsbyzRIHUj8z8tkiHuhGJgf3uRa2cFtfaSLj6JZ7QX+zjQIdWq2XQgiEv1pPtcQ==
X-Received: by 2002:a05:6a00:1a0a:b0:664:aff0:240 with SMTP id g10-20020a056a001a0a00b00664aff00240mr6496112pfv.33.1690483039193;
        Thu, 27 Jul 2023 11:37:19 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id y2-20020aa78542000000b0066a31111ccdsm1796332pfn.65.2023.07.27.11.37.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 11:37:18 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2] monitor: Use gnuplot to plot graph of Latency-Packets
Date:   Thu, 27 Jul 2023 11:37:17 -0700
Message-ID: <20230727183717.1026331-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make use of gnuplot when using -a/--analyze to plot a graph of
Latency-Packets:

  Found BR-ACL connection with handle 256
        Address: XX:XX:XX:XX:XX:XX (Sony Home Entertainment&Sound Products Inc)
        60 RX packets
        22548 TX packets
        22547 TX completed packets
        3 msec min latency
        73 msec max latency
        11 msec median latency
        6 octets TX min packet size
        850 octets TX max packet size
        847 octets TX median packet size

  7000 +-------------------------------------------------------------------+
       |        +       +        +       +        +       +        +       |
       |        +                                          Packets +-----+ |
  6000 |-+     +|                                                        +-|
       |       ||                                                          |
  5000 |-+     ||                                                        +-|
       |       ||                                                          |
       |       ||                                                          |
  4000 |-+     ||                                                        +-|
       |       ||                                                          |
       |       ||                                                          |
  3000 |-+     |+                                                        +-|
       |       ||                                                          |
       |       ||                                                          |
  2000 |-+     ||                                                        +-|
       |      +||                                                          |
  1000 |-+    |||++                                                      +-|
       |      |||||+ +                                                     |
       |      ||||||+|+++        +       +        +       +        +       |
     0 +-------------------------------------------------------------------+
       0        10      20       30      40       50      60       70      80
                                   Latency (ms)
---
 monitor/analyze.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index a20ba98b0be4..c7c274fb25fe 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -17,6 +17,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/time.h>
+#include <unistd.h>
 
 #include "lib/bluetooth.h"
 
@@ -28,6 +29,9 @@
 #include "monitor/packet.h"
 #include "monitor/analyze.h"
 
+#define TIMEVAL_MSEC(_tv) \
+	(long long)((_tv)->tv_sec * 1000 + (_tv)->tv_usec / 1000)
+
 struct hci_dev {
 	uint16_t index;
 	uint8_t type;
@@ -69,12 +73,18 @@ struct hci_conn {
 	struct timeval tx_lat_min;
 	struct timeval tx_lat_max;
 	struct timeval tx_lat_med;
+	struct queue *plot;
 	uint16_t tx_pkt_min;
 	uint16_t tx_pkt_max;
 	uint16_t tx_pkt_med;
 	struct queue *chan_list;
 };
 
+struct conn_plot {
+	long long x_msec;
+	size_t y_count;
+};
+
 struct l2cap_chan {
 	uint16_t cid;
 	uint16_t psm;
@@ -135,6 +145,44 @@ static struct l2cap_chan *chan_lookup(struct hci_conn *conn, uint16_t cid,
 	return chan;
 }
 
+static void tmp_write(void *data, void *user_data)
+{
+	struct conn_plot *plot = data;
+	FILE *tmp = user_data;
+
+	fprintf(tmp, "%lld %zu\n", plot->x_msec, plot->y_count);
+}
+
+static void conn_plot_draw(struct hci_conn *conn)
+{
+	const char *filename = "analyze.tmp";
+	FILE *gplot = popen("gnuplot", "w");
+	FILE *tmp;
+
+	if (!gplot)
+		return;
+
+	if (queue_isempty(conn->plot))
+		goto done;
+
+	tmp = fopen(filename, "w");
+	if (!tmp)
+		goto done;
+
+	queue_foreach(conn->plot, tmp_write, tmp);
+
+	fprintf(gplot, "set terminal dumb enhanced ansi\n");
+	fprintf(gplot, "set xlabel 'Latency (ms)'\n");
+	fprintf(gplot, "plot './%s' using 1:2 t 'Packets' w impulses\n",
+								filename);
+	fflush(gplot);
+
+	fclose(tmp);
+done:
+	pclose(gplot);
+	unlink(filename);
+}
+
 static void conn_destroy(void *data)
 {
 	struct hci_conn *conn = data;
@@ -187,6 +235,10 @@ static void conn_destroy(void *data)
 	print_field("%u octets TX min packet size", conn->tx_pkt_min);
 	print_field("%u octets TX max packet size", conn->tx_pkt_max);
 	print_field("%u octets TX median packet size", conn->tx_pkt_med);
+
+	conn_plot_draw(conn);
+
+	queue_destroy(conn->plot, free);
 	queue_destroy(conn->chan_list, chan_destroy);
 
 	queue_destroy(conn->tx_queue, free);
@@ -447,6 +499,35 @@ static void evt_cmd_complete(struct hci_dev *dev, struct timeval *tv,
 	}
 }
 
+static bool match_plot_latency(const void *data, const void *user_data)
+{
+	const struct conn_plot *plot = data;
+	const struct timeval *latency = user_data;
+
+	return TIMEVAL_MSEC(latency) == plot->x_msec;
+}
+
+static void conn_plot_add(struct hci_conn *conn, struct timeval *latency,
+						uint16_t count)
+{
+	struct conn_plot *plot;
+
+	plot = queue_find(conn->plot, match_plot_latency, latency);
+	if (plot) {
+		plot->y_count += count;
+		return;
+	}
+
+	if (!conn->plot)
+		conn->plot = queue_new();
+
+	plot = new0(struct conn_plot, 1);
+	plot->x_msec = TIMEVAL_MSEC(latency);
+	plot->y_count = count;
+
+	queue_push_tail(conn->plot, plot);
+}
+
 static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 					const void *data, uint16_t size)
 {
@@ -504,6 +585,8 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 			} else
 				conn->tx_lat_med = res;
 
+			conn_plot_add(conn, &res, count);
+
 			free(last_tx);
 		}
 	}
-- 
2.41.0

