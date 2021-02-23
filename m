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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FB2C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA8F60231
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhBWTJu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhBWTJr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 14:09:47 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8870C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 11:09:06 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id r5so3447084pfh.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 11:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OHYQCOa+3OW1e8lofNd9FP8wdsvSCwVLtUHhY5HUv8o=;
        b=C/tBg5ni52rqi/Z7aukDfFrxOHrGXJ0AvLvrRA+oMn7I944k7Wt+gDWRzp4hcMD5tV
         HUYppp9TXI0LR8HDopLXdprV6l7LXRO2f+9LeobccMKUty7CBjpR/J5+Id7muWHkb6w3
         AQaxeEXDVGe7ndg5YthyRJmdT51E7/8Vt6OKSmwhLWpTcwFqZHwWrMD9J+M4G0C0gf0t
         JNIyQEzCQj9jADkKHMog8ASiDtvp3Wp8vVNX0MNvJqsnUOcwk3NMI8xdcfkhkVe1WfBm
         JervhiTEfRgkKnmHWEppfPWSaxsrJ60vQ6hyoXC7MZxMB3wt2sf4NwnP4S7iKqoWCZPV
         Sf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OHYQCOa+3OW1e8lofNd9FP8wdsvSCwVLtUHhY5HUv8o=;
        b=HPWr1nB+8BTIphMco1FF01vSWtPUZoo+IxDG6Xk7IWhPpU0KV3UBKUpqljLcsxp7WI
         hHEx0hkx1e7iNQqVb3nT16nSZcCQruYWrdnE3+x+pkudNvPuczphaPVzg1QbbhEmsdWt
         YLM3K2UE7A+48R6AMfll9+hX0ZbERvNGytyyOrPEGbI76fGcjz5whXC68AWmowAAVKWh
         CSrK8/bIZJh3PLdFfyt/Eq1pk0mDMgKFBZobC0rhMu4NfmifJN6jObRN0ItwKTtdU6iz
         l/nSBjTCVUxEMxGsyQ66NkAHz9vR4I+t9klPqxZeYverN97iZgPnwyfoSmJsRIiQSPHn
         /7kg==
X-Gm-Message-State: AOAM530/dojo9botsUcEIF4F2x3v7hw/cGswOiekFJcbHzMch3uby4EJ
        I8hHIEMi0luYHvAzhnqZ7GN22cT40Z4=
X-Google-Smtp-Source: ABdhPJz09EtLUjZaEMXH94BiZtvX8ZwrKgojZo6fQSBCFYugPPARn7rTIR39Sxhlqu1Fy5RU4kA74w==
X-Received: by 2002:a63:1a03:: with SMTP id a3mr9456329pga.45.1614107345992;
        Tue, 23 Feb 2021 11:09:05 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x12sm24478391pfp.214.2021.02.23.11.09.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:09:05 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] monitor: Fix handling of BT_HCI_EVT_LE_BIG_COMPLETE
Date:   Tue, 23 Feb 2021 11:09:03 -0800
Message-Id: <20210223190904.1718994-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the missing fields for BT_HCI_EVT_LE_BIG_COMPLETE event.
---
 monitor/bt.h     | 6 ++++++
 monitor/packet.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index aca847d7c..394dd7a2d 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3533,6 +3533,12 @@ struct bt_hci_evt_le_big_complete {
 	uint8_t  sync_delay[3];
 	uint8_t  latency[3];
 	uint8_t  phy;
+	uint8_t  nse;
+	uint8_t  bn;
+	uint8_t  pto;
+	uint8_t  irc;
+	uint16_t max_pdu;
+	uint16_t interval;
 	uint8_t  num_bis;
 	uint16_t handle[0];
 } __attribute__ ((packed));
diff --git a/monitor/packet.c b/monitor/packet.c
index fcd698d92..55ba16ccc 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10575,6 +10575,12 @@ static void le_big_complete_evt(const void *data, uint8_t size)
 	print_usec_interval("BIG Synchronization Delay", evt->sync_delay);
 	print_usec_interval("Transport Latency", evt->latency);
 	print_le_phy("PHY", evt->phy);
+	print_field("NSE: %u", evt->nse);
+	print_field("BN: %u", evt->bn);
+	print_field("PTO: %u", evt->bn);
+	print_field("IRC: %u", evt->irc);
+	print_field("Maximum PDU: %u", evt->max_pdu);
+	print_slot_125("ISO Interval", evt->interval);
 	print_list(evt->handle, size, evt->num_bis, sizeof(*evt->handle),
 						print_bis_handle);
 }
-- 
2.29.2

