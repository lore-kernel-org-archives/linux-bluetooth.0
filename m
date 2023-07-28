Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233E5C0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 17:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjG1R7o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 13:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbjG1R7l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 13:59:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0F2421D
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 10:59:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686b879f605so1695068b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690567179; x=1691171979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9QYMljA49yaTSa3X/JOrYWbbF31/d8XdDkCc11R7mxo=;
        b=Ihsw1MBP/XSBhYI1JIzzA4EK3q4Gs9lHkh9lo0Z/8DTVuOb7fC/Em5LeL6G3fqdpqF
         olPgEoMCIdL3LpMWYMJFM2iLTbPskivQUxvwGy5tClI6IQ/Vvq5ZG2SGFdchqTRIJOKG
         6MgGMhvLBmSfT2A0YdR4WSmIiQL4SLtz0YvJ57EGD0DsBz0Fh811k+BbnQz1/2m7nKZi
         ZXsgUnxpBNuCWWyZ85x4ajqXprf6cnNJi74/OmfsZoAQ/rgLMf81EVAKvPfk1zZgZKH2
         IqUek9yS1IV8XQACJtZmcYU8iyaezoZCFhWF3y/9l5vsR+3/QelTCTmUdG+DOtM+b1d7
         uYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690567179; x=1691171979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QYMljA49yaTSa3X/JOrYWbbF31/d8XdDkCc11R7mxo=;
        b=SdvfsaTpH682Q3iSxeye+enYQkd1uDX7th9UBwCmR4VMcPoYPeX7odWjuxX7JCA2zl
         AzaYMVM4VgJesYZ1DroX1ECw/5rKdKPGc6/AiObKucLENnbcIsF6/oh3/0bl6CvmRb4S
         g0jU4gxaG+hpauipSDw5f6Ux003Zu7Gr8Uw6rDbv1eDxXNB4ZeWxe8SKx/cvQLpjsIW/
         DSPKJ0LpfwkPod03O5zgFlP0HjFxHYG7qPVh+WKa5+5sVBsnmwICZdp9IWVHn8s8mGwd
         quV0bl2uSB0OIHXG6YbsP7fPvR1rMeqqQHHCk4iQpvpSazV84Fw7qm5LLOGQXQ88e2Uw
         6tVg==
X-Gm-Message-State: ABy/qLbYGkNg12ahKAa8o/TApUZO7pflKf2PfEtgYLeFJnwaSN39KM0g
        BOoUwdkbDfb+EAg6iGDfWnK0IaCAG8U=
X-Google-Smtp-Source: APBJJlF1N7sgL/JuoOtD/PcjgxgU7B2Uq1LGDQUmU804qzEuqdKXC8faAt5tUfA2ILwOOhsTNTXvkg==
X-Received: by 2002:a05:6a00:1150:b0:675:ef91:7922 with SMTP id b16-20020a056a00115000b00675ef917922mr2354967pfm.4.1690567178768;
        Fri, 28 Jul 2023 10:59:38 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id d7-20020aa78147000000b0068718aadda7sm427796pfn.108.2023.07.28.10.59.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 10:59:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v4 1/3] monitor: Use gnuplot to plot graph of Latency-Packets
Date:   Fri, 28 Jul 2023 10:59:35 -0700
Message-ID: <20230728175937.42818-1-luiz.dentz@gmail.com>
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

  10000 +------------------------------------------------------------------+
        |+      +                                                          |
        |+      |+                                         Packets +-----+ |
        |+      ||                                                         |
   1000 |-+    +||++                                                       |
        |+     |||||+ +                                                    |
        |+     ||||||+|                                                    |
        |+     ||||||||+                                                   |
        |+     |||||||||+++                                                |
    100 |-+    |||||||||||++++                                             |
        |+     ||||||||||||||| +                                           |
        |+     ||||||||||||||| ++                                          |
        |+ +   |||||||||||||||+||                                          |
     10 |-+|   ||||||||||||||||||+++                                       |
        |+ |   |||||||||||||||||||||                                       |
        |+ |   |||||||||||||||||||||  +                                    |
        |+ | ++|||||||||||||||||||||++|++++       +                        |
        |  | ||||||||||||||||||||||||||||||       |                        |
      1 |-+|+|||||||||||||||||||||||||||||| +  +  |       +        + +     |
        +------------------------------------------------------------------+
        0       10       20      30       40      50      60       70      80
                                   Latency (ms)
---
 monitor/analyze.c | 98 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 87 insertions(+), 11 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index a20ba98b0be4..29aee5ad1680 100644
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
 
+struct plot {
+	long long x_msec;
+	size_t y_count;
+};
+
 struct l2cap_chan {
 	uint16_t cid;
 	uint16_t psm;
@@ -135,6 +145,47 @@ static struct l2cap_chan *chan_lookup(struct hci_conn *conn, uint16_t cid,
 	return chan;
 }
 
+static void tmp_write(void *data, void *user_data)
+{
+	struct plot *plot = data;
+	FILE *tmp = user_data;
+
+	fprintf(tmp, "%lld %zu\n", plot->x_msec, plot->y_count);
+}
+
+static void plot_draw(struct queue *queue)
+{
+	const char *filename = "analyze.tmp";
+	FILE *gplot = popen("gnuplot", "w");
+	FILE *tmp;
+
+	if (!gplot)
+		return;
+
+	if (queue_isempty(queue))
+		goto done;
+
+	tmp = fopen(filename, "w");
+	if (!tmp)
+		goto done;
+
+	queue_foreach(queue, tmp_write, tmp);
+
+	fprintf(gplot, "set terminal dumb enhanced ansi\n");
+	fprintf(gplot, "set xlabel 'Latency (ms)'\n");
+	fprintf(gplot, "set tics nomirror\n");
+	fprintf(gplot, "set log y\n");
+	fprintf(gplot, "set yrange [0.5:*]\n");
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
@@ -172,21 +223,17 @@ static void conn_destroy(void *data)
 	print_field("%lu RX packets", conn->rx_num);
 	print_field("%lu TX packets", conn->tx_num);
 	print_field("%lu TX completed packets", conn->tx_num_comp);
-	print_field("%lld msec min latency",
-			(long long)
-			(conn->tx_lat_min.tv_sec * 1000 +
-			conn->tx_lat_min.tv_usec / 1000));
-	print_field("%lld msec max latency",
-			(long long)
-			(conn->tx_lat_max.tv_sec * 1000 +
-			conn->tx_lat_max.tv_usec / 1000));
+	print_field("%lld msec min latency", TIMEVAL_MSEC(&conn->tx_lat_min));
+	print_field("%lld msec max latency", TIMEVAL_MSEC(&conn->tx_lat_max));
 	print_field("%lld msec median latency",
-			(long long)
-			(conn->tx_lat_med.tv_sec * 1000 +
-			conn->tx_lat_med.tv_usec / 1000));
+			TIMEVAL_MSEC(&conn->tx_lat_med));
 	print_field("%u octets TX min packet size", conn->tx_pkt_min);
 	print_field("%u octets TX max packet size", conn->tx_pkt_max);
 	print_field("%u octets TX median packet size", conn->tx_pkt_med);
+
+	plot_draw(conn->plot);
+
+	queue_destroy(conn->plot, free);
 	queue_destroy(conn->chan_list, chan_destroy);
 
 	queue_destroy(conn->tx_queue, free);
@@ -203,6 +250,7 @@ static struct hci_conn *conn_alloc(struct hci_dev *dev, uint16_t handle,
 	conn->handle = handle;
 	conn->type = type;
 	conn->tx_queue = queue_new();
+	conn->plot = queue_new();
 
 	conn->chan_list = queue_new();
 
@@ -447,6 +495,32 @@ static void evt_cmd_complete(struct hci_dev *dev, struct timeval *tv,
 	}
 }
 
+static bool match_plot_latency(const void *data, const void *user_data)
+{
+	const struct plot *plot = data;
+	const struct timeval *latency = user_data;
+
+	return TIMEVAL_MSEC(latency) == plot->x_msec;
+}
+
+static void plot_add(struct queue *queue, struct timeval *latency,
+						uint16_t count)
+{
+	struct plot *plot;
+
+	plot = queue_find(queue, match_plot_latency, latency);
+	if (plot) {
+		plot->y_count += count;
+		return;
+	}
+
+	plot = new0(struct plot, 1);
+	plot->x_msec = TIMEVAL_MSEC(latency);
+	plot->y_count = count;
+
+	queue_push_tail(queue, plot);
+}
+
 static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 					const void *data, uint16_t size)
 {
@@ -504,6 +578,8 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 			} else
 				conn->tx_lat_med = res;
 
+			plot_add(conn->plot, &res, count);
+
 			free(last_tx);
 		}
 	}
-- 
2.41.0

