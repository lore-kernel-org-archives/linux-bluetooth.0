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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07453C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 18:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9259613B6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 18:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347526AbhDMSE6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Apr 2021 14:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347516AbhDMSE4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Apr 2021 14:04:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68096C061756
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 11:04:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m18so6456478plc.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SFWwRMuo2akBIT2w5hY/P6zE3UrXZB1y7d2zJwvG/zM=;
        b=r2hIz4AtflfGoKOSTnWUVomtyUbgKT6+z1Ah3VXB9bRSdlMJh/XFgeJr3YGKLhetc3
         T79K9/i445oUZRbpP159c6IZ9V8qwh4Ypw4ArDwq2JIwFkTybNryuc1cO7LSrFFL/f86
         BVC3PV63E1l5FrIycRc7AEkwxYqop0U4fV+kmhrlEjmGODuqWlBIjHOADrMk0ICJMfBw
         m5MXalamrgXeQIWNmlSHtUU/p9XRBLYjfogEdYD7nuLgULb+0dOH5KhNvUmIqLE2TpBE
         Gcc+HUZTCNlxYPt0NT+dDgs9upYSb3QdOHNMxV7TV9Ozw3eY5agPKhLAg95+ZR3WuQaG
         tlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SFWwRMuo2akBIT2w5hY/P6zE3UrXZB1y7d2zJwvG/zM=;
        b=LqrKjssfhi8g1ymbkmsOn6UhxEX2Q8FcUsWXmRnVILNwA7oayADeikvwOWUWnItmqf
         6ae3UhGd5T8T2U/I0JgdePpk5Nn77HGmtABlsX1anmMx8LxgxZfM0d5+Zf0rKyRs321N
         wXGPqYFEJ00nX2elGc0+Mt2qg+wAxA8TMS3cKKHZ8LE+u/ZuavjEJ0yMzWaQtCUu3/nc
         H9HLO+zgo7pa3wbJwXlO2DYPFRkOnQ0uN4VujshriMraUmIi6rWxTJ1tgF31zDTbAwkG
         XgLw7GQqNwleHtxXq+y9Pb+4zNeO/6kB6VtWx0qtqs8Vuugy5vksl4iGvA+LI5HTq1w/
         +efw==
X-Gm-Message-State: AOAM531KLLHt4JMYqKeSxn47M7kr1iOL+UGQx7WqXEXxxqUWiGkcwicH
        UbSlYptQCUiSqJwRCirGy8hKlzER1Lo=
X-Google-Smtp-Source: ABdhPJz9XFsFCozAekEsVIhmO9vI3TWb6QloHbayv6BiCZ2AT1bsAexO2f2JdzprghAAx9MUZ4AJTA==
X-Received: by 2002:a17:903:228d:b029:e7:1f01:bab0 with SMTP id b13-20020a170903228db02900e71f01bab0mr32659243plh.80.1618337072711;
        Tue, 13 Apr 2021 11:04:32 -0700 (PDT)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:d830:a8b:3cf9:40aa:b8f8])
        by smtp.gmail.com with ESMTPSA id jx20sm2827842pjb.41.2021.04.13.11.04.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 11:04:32 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] monitor: Add iso packet count to analyze command
Date:   Tue, 13 Apr 2021 11:04:30 -0700
Message-Id: <20210413180430.356676-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210413180430.356676-1-hj.tedd.an@gmail.com>
References: <20210413180430.356676-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds iso tx/rx packet count to analyze command.
---
 monitor/analyze.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 022761c21..225a37ffa 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -34,6 +34,7 @@ struct hci_dev {
 	unsigned long num_evt;
 	unsigned long num_acl;
 	unsigned long num_sco;
+	unsigned long num_iso;
 	unsigned long vendor_diag;
 	unsigned long system_note;
 	unsigned long user_log;
@@ -77,6 +78,7 @@ static void dev_destroy(void *data)
 	printf("  %lu events\n", dev->num_evt);
 	printf("  %lu ACL packets\n", dev->num_acl);
 	printf("  %lu SCO packets\n", dev->num_sco);
+	printf("  %lu ISO packets\n", dev->num_iso);
 	printf("  %lu vendor diagnostics\n", dev->vendor_diag);
 	printf("  %lu system notes\n", dev->system_note);
 	printf("  %lu user logs\n", dev->user_log);
@@ -255,6 +257,22 @@ static void sco_pkt(struct timeval *tv, uint16_t index,
 	dev->num_sco++;
 }
 
+static void iso_pkt(struct timeval *tv, uint16_t index,
+					const void *data, uint16_t size)
+{
+	const struct bt_hci_iso_hdr *hdr = data;
+	struct hci_dev *dev;
+
+	data += sizeof(*hdr);
+	size -= sizeof(*hdr);
+
+	dev = dev_lookup(index);
+	if (!dev)
+		return;
+
+	dev->num_iso++;
+}
+
 static void info_index(struct timeval *tv, uint16_t index,
 					const void *data, uint16_t size)
 {
@@ -448,6 +466,10 @@ void analyze_trace(const char *path)
 		case BTSNOOP_OPCODE_CTRL_EVENT:
 			ctrl_evt(&tv, index, buf, pktlen);
 			break;
+		case BTSNOOP_OPCODE_ISO_TX_PKT:
+		case BTSNOOP_OPCODE_ISO_RX_PKT:
+			iso_pkt(&tv, index, buf, pktlen);
+			break;
 		default:
 			fprintf(stderr, "Unknown opcode %u\n", opcode);
 			unknown_opcode(&tv, index, buf, pktlen);
-- 
2.25.1

