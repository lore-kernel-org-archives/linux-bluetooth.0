Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADFAEB64D8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jun 2023 19:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjFVTIt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jun 2023 15:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVTIs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jun 2023 15:08:48 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376701FC6
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jun 2023 12:08:47 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-39ea511930eso4973042b6e.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jun 2023 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687460926; x=1690052926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MMpSuSZp5bN/57iTSFy0rMI4tshkhQTtmO4///5qTBE=;
        b=CtIaOVhYhFfEJ1wGqcWD7fS65hz4vDSRy/2AgNGRLw9lD3ZQouQdcy/zGODCbY90Dk
         rOFWxx8Adb58K263clvA0/ki7kmF1gvP2biS19JettJuQQdHH8joPCkhfbbo9Go0VHgr
         UQMjUkkbQEYeg+F3LoHV1uFgosr/DECl/1QuJvCQnuZnXPHpdLQ77emWtvDIjNJ7gWUq
         jOPIFaxOOooX8+pAfjFgYbeHiBd2jC14MG+12dngrfDFW4TI1hv65nhkY39f/cBRBOQa
         CKDtduh1pStwPPYAazdp2wmDUzijxcDArLjt/rVjWTO6LElwdMX8yRHjgGhZ0BvkPxog
         JiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460926; x=1690052926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMpSuSZp5bN/57iTSFy0rMI4tshkhQTtmO4///5qTBE=;
        b=XniG5I4sz6jYiwegPZJuoLaDxHfJn0++ynk192RxLl9RVixIZZn3QF3CAXkQywLB/z
         hJj5yC71Cp+BwfiJAS7HKAAM7vWnVeadvFeG9OhHnhk1wenaxX+5qDh/9UEvws6bvBmJ
         nE88h+IG63ZC1tmdjHcxU0NQjxEPIzPxbGRfR+D370h1Gc+dpe1Nrv/OCiSl6ZuW3h65
         aDUvPo25yCmZHuJdpFEOkHTYK71eDNrPJLBkQMo+l4rK9F5qghvj+81rLWH5weBiJ6Zr
         pDo3x6ggPxyxVmFYXin6yBZQfwwV7FzLCwBCf5qy0BoaE/xQDFvolyoRKabOw6K49D95
         QcWQ==
X-Gm-Message-State: AC+VfDzBaeebeyC9u7jF8FJvJuTc7ssaXi6HqYwrGHgmquFV8+b9x/yc
        8EuyNem7Q2/T4Pj2gmRo2Bb4am37l0WcwA==
X-Google-Smtp-Source: ACHHUZ73efKZEu4DOKRmFlPtEgo6XIZ6M9X7UygvhdKWniKmyV4RjB9cR58hjaLCYnBSTCrDQc4rXg==
X-Received: by 2002:a05:6808:1584:b0:3a1:a191:d454 with SMTP id t4-20020a056808158400b003a1a191d454mr405170oiw.29.1687460925716;
        Thu, 22 Jun 2023 12:08:45 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id lb10-20020a17090b4a4a00b002609cadc56esm99784pjb.11.2023.06.22.12.08.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 12:08:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] btdev: Fix LE CIS Established Event
Date:   Thu, 22 Jun 2023 12:08:43 -0700
Message-Id: <20230622190843.1242967-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

LE CIS Established Event Transport Latency shall follow the formula from
the spec:

 BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part G
 page 3050:

 Transport_Latency_C_To_P = CIG_Sync_Delay + FT_C_To_P ×
 ISO_Interval - SDU_Interval_C_To_P
 Transport_Latency_P_To_C = CIG_Sync_Delay + FT_P_To_C ×
 ISO_Interval - SDU_Interval_P_To_C
---
 emulator/btdev.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 0a375febad68..d5450190c38e 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5940,6 +5940,18 @@ static int cmd_create_cis(struct btdev *dev, const void *data, uint8_t len)
 	return 0;
 }
 
+static uint32_t le_cis_transport_latecy(uint8_t ft, uint8_t iso_interval,
+						uint8_t sdu_interval[3])
+{
+	uint32_t latency;
+	uint32_t interval = get_le24(sdu_interval);
+
+	/* Transport_Latency = FT × ISO_Interval - SDU_Interval */
+	latency = ft * (iso_interval * 1250) - interval;
+
+	return latency <= interval ? latency : interval;
+}
+
 static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 						uint8_t status)
 {
@@ -5959,25 +5971,32 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 		struct btdev *remote = conn->link->dev;
 		struct le_cig *le_cig = &remote->le_cig[cig_idx];
 
-		/* TODO: Figure out if these values makes sense */
-		memcpy(evt.cig_sync_delay, le_cig->params.c_interval,
-				sizeof(le_cig->params.c_interval));
-		memcpy(evt.cis_sync_delay, le_cig->params.p_interval,
-				sizeof(le_cig->params.p_interval));
-		memcpy(evt.c_latency, &le_cig->params.c_interval,
-				sizeof(le_cig->params.c_interval));
-		memcpy(evt.p_latency, &le_cig->params.p_interval,
-				sizeof(le_cig->params.p_interval));
+		memset(evt.cig_sync_delay, 0, sizeof(evt.cig_sync_delay));
+		memset(evt.cis_sync_delay, 0, sizeof(evt.cis_sync_delay));
+
 		evt.c_phy = le_cig->cis[cis_idx].c_phy;
 		evt.p_phy = le_cig->cis[cis_idx].p_phy;
 		evt.nse = 0x01;
 		evt.c_bn = 0x01;
 		evt.p_bn = 0x01;
-		evt.c_ft = 0x01;
-		evt.p_ft = 0x01;
+		evt.c_ft = 0x02;
+		evt.p_ft = 0x02;
 		evt.c_mtu = le_cig->cis[cis_idx].c_sdu;
 		evt.p_mtu = le_cig->cis[cis_idx].p_sdu;
-		evt.interval = (le_cig->params.c_latency + 1) / 1.25;
+		evt.interval = (le_cig->params.c_latency + 0.625) / 1.25;
+
+		/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part G
+		 * page 3050:
+		 *
+		 * Transport_Latency_C_To_P = CIG_Sync_Delay + FT_C_To_P ×
+		 * ISO_Interval - SDU_Interval_C_To_P
+		 * Transport_Latency_P_To_C = CIG_Sync_Delay + FT_P_To_C ×
+		 * ISO_Interval - SDU_Interval_P_To_C
+		 */
+		put_le24(le_cis_transport_latecy(evt.c_ft, evt.interval,
+				le_cig->params.c_interval), evt.c_latency);
+		put_le24(le_cis_transport_latecy(evt.p_ft, evt.interval,
+				le_cig->params.p_interval), evt.p_latency);
 	}
 
 	le_meta_event(dev, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt, sizeof(evt));
-- 
2.40.1

