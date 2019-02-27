Return-Path: <SRS0=vyxk=RC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6509C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 11:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39A520863
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 11:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOXZrxlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfB0Lqc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:46:32 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:45357 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfB0Lqc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Feb 2019 06:46:32 -0500
Received: by mail-ed1-f45.google.com with SMTP id f19so4230122eds.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Feb 2019 03:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=KrrEww7Q1fCqoQfRvRTWyaP6DzeHVg+uuyZojbGIZ9I=;
        b=tOXZrxlFeRRBV3LamV9a8BQYDMavz0ulGr0xQ5ZLOq5+WpSj/wGQQafAaZ2qLuNkVI
         dItVeFMqiOZAS7HxsmytM/J1lNyFcXtUS7qPUgUOBGQlatEMkvVw2YEy8FJWnNPNvyCI
         T8v7r7aKj8WtVu2SIQW+oKkPmJA2vo0scY9C4woKY0thp0g2gvOCAmGE+uG4JWukbLGN
         JALlA5LAz1FHSGFO2QjzpXzFJTm6/tWST1PK/gKWu5FcVMhGuH6ACVNUhpyD2KUrEq4H
         Ez9fId+10LXQCCFcW5BCeahzInx9Q3xZxED6LPjLPDyDCCFPNLnR0c7YLGb0ShfzuWB3
         2JRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=KrrEww7Q1fCqoQfRvRTWyaP6DzeHVg+uuyZojbGIZ9I=;
        b=dqYNRqnxTtwGX76a7ZA0nkTsujyzu/rCTluIpVfajHk0e5Q5vSRixQ9lKlt0rZdZL3
         yKNXLyrwwP1M16uSxALPqCRLHZbXTwfDIiJZJG6u76y4cEzya5s1zgj06ghhIMxSlbiE
         TfVixqMGmqIRVb+uRjkQrtyx23Wm3LXZP23D/bsd1yoRU7vgFJcwyJlLH7viYyoJTfnP
         q0+jVpmwo7xu69sHDj90Thm9T5n6GjDg1lU0ZPOrbPEPuzWcyuYwmsGc8aSX+zN1kbIV
         cAdUnDFp21u7p6u8bUbhuW0YGMNp5X5Rqh8398wjaeKd8WctRFv7KYcjtF2hk+MZEUV6
         N3qw==
X-Gm-Message-State: AHQUAuZ+NCXiOEubCVTyH3uomX2ILStldyqzzde5XW8fDGl9ZNZL/NIP
        3uQ9TvCCb1PxDdRgBv7amxIExZIzBKc=
X-Google-Smtp-Source: AHgI3IY2DccHiS65dGmDsUVlQ+htatCfabNSy1hPlMwOqxxAS0Gf7ll34+vTdptqyvYOExV6YRVJgQ==
X-Received: by 2002:a17:906:4ccc:: with SMTP id q12mr1247467ejt.201.1551267989873;
        Wed, 27 Feb 2019 03:46:29 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id l24sm2652333eja.57.2019.02.27.03.46.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 03:46:29 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/7] monitor: Decode LL_PERIODIC_SYNC_IND
Date:   Wed, 27 Feb 2019 13:46:19 +0200
Message-Id: <20190227114620.21630-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190227114620.21630-1-luiz.dentz@gmail.com>
References: <20190227114620.21630-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces the command passing for LL_PERIODIC_SYNC_IND PDU added
in 5.1.
---
 monitor/bt.h | 12 ++++++++++++
 monitor/ll.c | 25 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index f3995b4ea..3b2af7439 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -156,6 +156,18 @@ struct bt_ll_cte_req {
 
 #define BT_LL_CTE_RSP		0x1b
 
+#define BT_LL_PERIODIC_SYNC_IND	0x1c
+struct bt_ll_periodic_sync_ind {
+	uint16_t id;
+	uint8_t  info[18];
+	uint16_t event_count;
+	uint16_t last_counter;
+	uint8_t  adv_info;
+	uint8_t  phy;
+	uint8_t  adv_addr[6];
+	uint16_t sync_counter;
+} __attribute__ ((packed));
+
 #define LMP_ESC4(x) ((127 << 8) | (x))
 
 #define BT_LMP_NAME_REQ			1
diff --git a/monitor/ll.c b/monitor/ll.c
index 34f3e2cfc..712c383a6 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -570,6 +570,30 @@ static void cte_req(const void *data, uint8_t size)
 	}
 }
 
+static void periodic_sync_ind(const void *data, uint8_t size)
+{
+	const struct bt_ll_periodic_sync_ind *pdu = data;
+	uint8_t mask;
+
+	print_field("ID: 0x%4.4x", pdu->id);
+	print_field("SyncInfo:");
+	packet_hexdump(pdu->info, sizeof(pdu->info));
+	print_field("connEventCount: 0x%4.4x", pdu->event_count);
+	print_field("lastPaEventCounter: 0x%4.4x", pdu->last_counter);
+	print_field("SID: 0x%2.2x", pdu->adv_info & 0xf0);
+	print_field("AType: %s", pdu->adv_info & 0x08 ? "random" : "public");
+	print_field("SCA: 0x%2.2x", pdu->adv_info & 0x07);
+	print_field("PHY: 0x%2.2x", pdu->phy);
+
+	mask = print_bitfield(2, pdu->phy, le_phys);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+
+	packet_print_addr("AdvA", pdu->adv_addr, pdu->adv_info & 0x08);
+	print_field("syncConnEventCount: 0x%4.4x", pdu->sync_counter);
+}
+
 struct llcp_data {
 	uint8_t opcode;
 	const char *str;
@@ -607,6 +631,7 @@ static const struct llcp_data llcp_table[] = {
 	{ 0x19, "LL_MIN_USED_CHANNELS_IND", min_used_channels,  2, true },
 	{ 0x1a, "LL_CTE_REQ",               cte_req,            1, true },
 	{ 0x1b, "LL_CTE_RSP",               null_pdu,           0, true },
+	{ 0x1c, "LL_PERIODIC_SYNC_IND",     periodic_sync_ind, 34, true },
 	{ }
 };
 
-- 
2.17.2

