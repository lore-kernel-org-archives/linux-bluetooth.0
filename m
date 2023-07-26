Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18F8C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 22:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjGZWSK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 18:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGZWSJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 18:18:09 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CD31BE4
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 15:18:08 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so247422276.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690409886; x=1691014686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJzmWan6IrkSvFs+orQUf3ob43g02/zIqj1ohsoycA8=;
        b=VQC6BVJP4sPWgZL9fW2c928ZbvRryxCz3szvXJShDyo2jhqBIfmVxjK9GS+/RqGe2L
         PUcuS0OnV5sulaLfW6tXfqi+TjOkSigHpoGnMZ7BseEV774vSXAIJhb8Y0acjA42Cfqg
         h2Vp7iUNSZFtBM6BiPSwBuWSzdCt6oLq4wK+h2IxeyRNxbXQ3Up+AZIzm6yHvXhK1DCD
         kJmDjfpHMqZEma09dwXDnXJYRS1rViQLhKDyUGsRN+yLUehgBnlnU0iO8KSdvoxKGPBg
         DZTEfJvQsHaKpqz8BwnOqGD39Lb2R7Oqbt2Vh1KZN5gehSI2Mfwm0e1eUqURCDVZFB/k
         nhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690409886; x=1691014686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJzmWan6IrkSvFs+orQUf3ob43g02/zIqj1ohsoycA8=;
        b=fh94LuqhTXE0UPiPMcOlWZ3vtJtccxFBMeFyw2MKp1yqjGt/3bU+8ByaqGR6bYeYfm
         xsHDXJhl4RVMcurcB0ObOlv6tEgJseOuTeEvgJOW5S7d9tIdtIf+fidzx50hRoe4PKwT
         jUtaCmk6xxf39oo0i/AqeLUyg8hgxODCNuNt187EvEKzjKiwCqVBXKbUbhI4hk0skbYu
         pIph7GJ3EIjfbGa3YH/X074CMDX13D39pI0W+N7R5PtPx61Ey22ssMfmwpQMMH2xN5hi
         8XSsZtmLbkyG0d3FTLitdN7SxtqhqbVAqJsbDm6mvI1J5BJ6FJ1tKU4RTIKyx4gwXXr8
         N6gg==
X-Gm-Message-State: ABy/qLYWpyztPNmViFfwBhIRah01U3SqAg7LYp8dW8jepHYzLPHu/6bx
        adsqsovKF9g27pQEzFqUTl5Tx2wZ/qA=
X-Google-Smtp-Source: APBJJlEggOMleWsBr85XSQ/3wMGRGV5n2p58qF2QEzpPpJhCCSY7gPsXHWbnaKWvsX9nHG9yn2d68g==
X-Received: by 2002:a25:ce07:0:b0:d17:6abc:4695 with SMTP id x7-20020a25ce07000000b00d176abc4695mr3177965ybe.62.1690409886571;
        Wed, 26 Jul 2023 15:18:06 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id y1-20020a056902052100b00d0fe6cb4741sm1862898ybs.25.2023.07.26.15.18.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 15:18:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Use gnuplot to plot graph of Latency-Packets
Date:   Wed, 26 Jul 2023 15:18:03 -0700
Message-ID: <20230726221803.975865-1-luiz.dentz@gmail.com>
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
       |        A                                          Packets    A    |
  6000 |-+     A                                                         +-|
       |                                                                   |
  5000 |-+                                                               +-|
       |                                                                   |
       |                                                                   |
  4000 |-+                                                               +-|
       |                                                                   |
       |                                                                   |
  3000 |-+      A                                                        +-|
       |                                                                   |
       |                                                                   |
  2000 |-+                                                               +-|
       |      A                                                            |
  1000 |-+       AA                                                      +-|
       |           A A                                                     |
       |        +   AAAA+        +       +        +       +        +       |
     0 +-------------------------------------------------------------------+
       0        10      20       30      40       50      60       70      80
                                      Latency
---
 monitor/analyze.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index a20ba98b0be4..6fdb32f2dc55 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -28,6 +28,9 @@
 #include "monitor/packet.h"
 #include "monitor/analyze.h"
 
+#define TIMEVAL_MSEC(_tv) \
+	(long long)((_tv)->tv_sec * 1000 + (_tv)->tv_usec / 1000)
+
 struct hci_dev {
 	uint16_t index;
 	uint8_t type;
@@ -69,12 +72,18 @@ struct hci_conn {
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
@@ -135,6 +144,42 @@ static struct l2cap_chan *chan_lookup(struct hci_conn *conn, uint16_t cid,
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
+	const char *filename = "plot.tmp";
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
+	fprintf(gplot, "set terminal dumb\n");
+	fprintf(gplot, "set xlabel 'Latency'\n");
+	fprintf(gplot, "plot './%s' using 1:2 t 'Packets'\n", filename);
+	fflush(gplot);
+
+	fclose(tmp);
+done:
+	pclose(gplot);
+}
+
 static void conn_destroy(void *data)
 {
 	struct hci_conn *conn = data;
@@ -187,6 +232,10 @@ static void conn_destroy(void *data)
 	print_field("%u octets TX min packet size", conn->tx_pkt_min);
 	print_field("%u octets TX max packet size", conn->tx_pkt_max);
 	print_field("%u octets TX median packet size", conn->tx_pkt_med);
+
+	conn_plot_draw(conn);
+
+	queue_destroy(conn->plot, free);
 	queue_destroy(conn->chan_list, chan_destroy);
 
 	queue_destroy(conn->tx_queue, free);
@@ -447,6 +496,35 @@ static void evt_cmd_complete(struct hci_dev *dev, struct timeval *tv,
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
@@ -504,6 +582,8 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 			} else
 				conn->tx_lat_med = res;
 
+			conn_plot_add(conn, &res, count);
+
 			free(last_tx);
 		}
 	}
-- 
2.41.0

