Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4CFEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 22:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjG1WnC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 18:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjG1WnB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 18:43:01 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F105449E
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 15:42:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686b9964ae2so1911604b3a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690584178; x=1691188978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1Cxubman+YQUXa8gTY/9HAG3R/1Rik0Xg7kE1cKTME=;
        b=A58J/rIjlHGf0zstdvGHXA4U0nYgMH0hvIsSA4tgTc6uspkAX2SkcwpBbzuHUjlXLN
         JHy5LmEToPHhiOV1uswiPTdy+I/Mdmel4tohL5Gad52Sr00BlZOxsx08a2wQPwm7YTqe
         D7qFukcN5+v/GSJ3Fn88/aHMJCeogSEqC3V1V398mn8/gEGNPYWBW/2qepZbIGZ7Dlkr
         64FXVswFBEkhyyyUGdwl+6J80i50/ZdoVtW4zddte9N8vGHoMLH32GAnCRbdR51UIwop
         CouJ2rw0jnyyScrbHxsvQtnpCh3p3vFjVIgeRWfkkO4T6QPl3ttBjul0ufUymPZ3qpSC
         nFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690584178; x=1691188978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1Cxubman+YQUXa8gTY/9HAG3R/1Rik0Xg7kE1cKTME=;
        b=YK5yEOWo/8E+Q1x7RdR+zQcRt8xysvzm0aobINaqPPL4WNTM0XFkG3awRmgyY5DAUg
         J7wth77M3yqcgkJvppn+qHVfdTStLZNF3W/n+PLQsi9usZTqVLEclNVXFJRQvWDjTpXu
         c4P7NCr5pkex1g2i+x3NM33Vmv2JDXxtt4vaIgmPY05r2OLw9t+NHvrRPzKDNkwOhAfV
         i+A3ONu38R0zTrm/7djIpMtTAmckirE9G/8afAbY4U8I5wVsD5wKsBtMSdWf3hX9gLuI
         lYK5tyj6UnM1dIruY5pTO5RGnCJ0CwWABJxDAfSXaawwJp2sC8C6cbR1m6O85fwA6PT4
         m7Kg==
X-Gm-Message-State: ABy/qLaELkD1Tl3dd64Z4t+1rWI5AssjYZaSkJyXunE0dL+/qJq6QYsT
        t+zE3STcoblAFOIqxALRrW/P0tXL3bs=
X-Google-Smtp-Source: APBJJlHsFLro6tLLtrHrAVWg+ou4Rk7pSB8y8tgRsTWgu0Ae4WknISpHBdqm4IdZszTyJJ6GvmT1NQ==
X-Received: by 2002:a05:6a20:840b:b0:137:514a:9835 with SMTP id c11-20020a056a20840b00b00137514a9835mr3565822pzd.9.1690584178265;
        Fri, 28 Jul 2023 15:42:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id x41-20020a056a000be900b0068703879d3esm2731041pfu.113.2023.07.28.15.42.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 15:42:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v5 6/7] monitor/analyze: Fix not dequeing TX packet properly
Date:   Fri, 28 Jul 2023 15:42:46 -0700
Message-ID: <20230728224247.102057-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728224247.102057-1-luiz.dentz@gmail.com>
References: <20230728224247.102057-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

num_completed_packets_evt contain a count for how many packets have been
completed per handle.
---
 monitor/analyze.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index ddaaf6942035..c8192ffa7d2a 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -532,6 +532,7 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 		struct hci_conn *conn;
 		struct timeval res;
 		struct timeval *last_tx;
+		int j;
 
 		data += 4;
 		size -= 4;
@@ -542,15 +543,17 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 
 		conn->tx_num_comp += count;
 
-		last_tx = queue_pop_head(conn->tx_queue);
-		if (last_tx) {
-			timersub(tv, last_tx, &res);
+		for (j = 0; j < count; j++) {
+			last_tx = queue_pop_head(conn->tx_queue);
+			if (last_tx) {
+				timersub(tv, last_tx, &res);
 
-			packet_latency_add(&conn->tx_l, &res);
+				packet_latency_add(&conn->tx_l, &res);
 
-			plot_add(conn->plot, &res, count);
+				plot_add(conn->plot, &res, count);
 
-			free(last_tx);
+				free(last_tx);
+			}
 		}
 	}
 }
-- 
2.41.0

