Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3193AEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 21:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjG0VKW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 17:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjG0VKQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 17:10:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CA230E0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 14:10:14 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8ad356fe4so9118745ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 14:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690492213; x=1691097013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9QYMljA49yaTSa3X/JOrYWbbF31/d8XdDkCc11R7mxo=;
        b=h374X7Wmr7BAzNsnnCuZATShp8k2i4MFS8DH7ZN84zZpt1pqXWOIaKHbQyG9BbUL5E
         zDngclGkIMgQoIoiPCt7lTAm/xwI+fCcjsI0iSOiaGiwzcAnYy7Q9Xj0F1D0BPfViTwG
         BnZ2W4XPPBjl2njBs7khBc2JG7hHggI5t2PCPs233L9Iu/iLanLaoFe7VWPK9yuoYqV9
         o9Gp2qE/eCWadan2zIlpg9aGvLZLPWcJkzc9i1oms6nnM6VY5Kh6AVh7LJovUX5hJfdq
         5ph/6UrkC1DG9xLeuKqnXytO44wBi1wmyum9aJJh2hKn0ztepMGVwnWJHyWmyuAeCk1+
         gGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690492213; x=1691097013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QYMljA49yaTSa3X/JOrYWbbF31/d8XdDkCc11R7mxo=;
        b=j1+Q7vSGmx2lIMa1F4Y2g2zXUpXo9UyyL28mnHPukLc5v5AiuAihKFMC9VoCbWrIbE
         NqGsceBqOTTtCslSKTEI3aw2QlU51ClLZtQoyZX3HVjXvC7TZUXeCp5SnlaWc8vhnUXY
         gY/BpFFBRQBoE17ctmQ4+uWAgQi+ZFjOSjM905e2NBr0j0jj1dLkQ3NtrYBXcy2oc3LY
         e6Xem6vRUTXwX9jfbdylxbdkzDd2QJwJJAte0mOxvcR177PcQdI9DI+NUd3rETATIpnL
         pEkNYky/tqevv2k1J/tIf+AGceZfSe924yOlsYWhvqYjhd8e4tm9y8JFp5jOz0uXD1c7
         cJ1A==
X-Gm-Message-State: ABy/qLYd/RRoHaxZkTeQQzqbSB7yVXZIPgPpxoVsMPVZDFKIrIEnqq5P
        fAGMwWDsYJkF+CXyHYGj0MV8fwcy49Q=
X-Google-Smtp-Source: APBJJlGs4GqCI+JshR46FqJXDNCg5tMz2iIW1BcO6v3tjgRm8eTJIG3D4QrUQGjEh8j4u3JfrMN6Sg==
X-Received: by 2002:a17:903:228b:b0:1b9:ce7a:88b4 with SMTP id b11-20020a170903228b00b001b9ce7a88b4mr423721plh.42.1690492212863;
        Thu, 27 Jul 2023 14:10:12 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id ja17-20020a170902efd100b001b9c960ff9bsm2095639plb.78.2023.07.27.14.10.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:10:11 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3] monitor: Use gnuplot to plot graph of Latency-Packets
Date:   Thu, 27 Jul 2023 14:10:10 -0700
Message-ID: <20230727211010.1046099-1-luiz.dentz@gmail.com>
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

