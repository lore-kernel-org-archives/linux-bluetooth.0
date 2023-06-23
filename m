Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E6AEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 21:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjFWV0q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 17:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjFWVYf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 17:24:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFE41997
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 14:24:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b53e1cd0ffso7255445ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 14:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687555472; x=1690147472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y0+JcJh53G8KrzGIubrj8DDWH3139d9wNlcvJVBjv+s=;
        b=qB71/EcRl4VIvsMsdYsQNyGrIX9dEtEetSLtXGLFZYss0bSIwbOebeObgZlXv6Ib3a
         rVq5egXma8ZBcziDDZjGm2H2WI796gfp+3wYSVrgzeS2oJinIhvNvlM0xTwtkl+O0ybL
         +eX/OUpsocs8/dY1BTNJiHLY0Idb6ymJJxhT7jcSzhJ1aHRGTbDSa59PRDWeyNDGnaYW
         AZQcbKWUlyLSE2FZFlJEZ5dPqjpZJzBwvbf3g4CZHqBLsAAW+R/QBHUX56SrdyCK351y
         DS/PPSuBKDJfpC2P9wklhq0+9I+4Iw+fSQU+ZxEa1diUvS+8YHvs3k36rqW6bf0KGmIx
         fmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687555472; x=1690147472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0+JcJh53G8KrzGIubrj8DDWH3139d9wNlcvJVBjv+s=;
        b=JN78KO0JatoSHSQLBfkFIaQLRZQJA2oafC0gsh1E2nbKoptUZOE51pFdi5l/WsgxVK
         5jRSL0AZvaobMXx0Kqtlv50HqnXc+csR1m7gWHRgm6RRyPF1ftIi5pm/yVneRH+J41Q1
         IU5hAbyNhCM2dtA/Ouo+SsRr76DrZljb/CRPBKL72jMe7o0vfywyv0M2IcNSvYUZC9LH
         KCf3TAfxa+hKofZuNSGh5jB4xNX2W/ncVGqyRceFAmaAhRbVWoROpWkCmPPdPpr0r+5Z
         T0M+Xy6NNKBc9hUR3UK6WzxFKs/S80GhyKrxLyWkIWSjgyhZZZ+MNsS6Dq7Pret2kkXl
         gMgw==
X-Gm-Message-State: AC+VfDxeEZnnaBe6Emb5ClirbzmF910mrigWI+ZhOi2G4SdjkUAM3hPl
        KPSVQi4BrIlMgc7nIW6c2VeiywIo6DhoHQ==
X-Google-Smtp-Source: ACHHUZ7zdO9elpNEBj2Nk1A4OleNVk747aRBMwyaYPn/71NaqJL3ZIQZFww/E10/aGTRd4/6OuiN+g==
X-Received: by 2002:a17:902:f689:b0:1b2:1943:e291 with SMTP id l9-20020a170902f68900b001b21943e291mr243655plg.57.1687555472388;
        Fri, 23 Jun 2023 14:24:32 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001b694140d96sm20481plb.170.2023.06.23.14.24.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 14:24:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] btdev: Fix CIS Established Event parameters
Date:   Fri, 23 Jun 2023 14:24:29 -0700
Message-Id: <20230623212430.1702254-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ISO Interval and Transport Latency were inverted.
---
 emulator/btdev.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d5450190c38e..637f0bb98057 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5940,8 +5940,14 @@ static int cmd_create_cis(struct btdev *dev, const void *data, uint8_t len)
 	return 0;
 }
 
-static uint32_t le_cis_transport_latecy(uint8_t ft, uint8_t iso_interval,
-						uint8_t sdu_interval[3])
+static uint8_t le_cis_interval(uint8_t sdu_interval[3])
+{
+	/* ISO Interval (slots of 1.25 ms) = SDU_Interval (us) */
+	return get_le24(sdu_interval) / 1250;
+}
+
+static uint32_t le_cis_latecy(uint8_t ft, uint8_t iso_interval,
+					uint8_t sdu_interval[3])
 {
 	uint32_t latency;
 	uint32_t interval = get_le24(sdu_interval);
@@ -5949,7 +5955,7 @@ static uint32_t le_cis_transport_latecy(uint8_t ft, uint8_t iso_interval,
 	/* Transport_Latency = FT × ISO_Interval - SDU_Interval */
 	latency = ft * (iso_interval * 1250) - interval;
 
-	return latency <= interval ? latency : interval;
+	return latency >= interval ? latency : interval;
 }
 
 static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
@@ -5983,7 +5989,7 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 		evt.p_ft = 0x02;
 		evt.c_mtu = le_cig->cis[cis_idx].c_sdu;
 		evt.p_mtu = le_cig->cis[cis_idx].p_sdu;
-		evt.interval = (le_cig->params.c_latency + 0.625) / 1.25;
+		evt.interval = le_cis_interval(le_cig->params.c_interval);
 
 		/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part G
 		 * page 3050:
@@ -5993,9 +5999,9 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 		 * Transport_Latency_P_To_C = CIG_Sync_Delay + FT_P_To_C ×
 		 * ISO_Interval - SDU_Interval_P_To_C
 		 */
-		put_le24(le_cis_transport_latecy(evt.c_ft, evt.interval,
+		put_le24(le_cis_latecy(evt.c_ft, evt.interval,
 				le_cig->params.c_interval), evt.c_latency);
-		put_le24(le_cis_transport_latecy(evt.p_ft, evt.interval,
+		put_le24(le_cis_latecy(evt.p_ft, evt.interval,
 				le_cig->params.p_interval), evt.p_latency);
 	}
 
-- 
2.40.1

