Return-Path: <SRS0=vyxk=RC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45781C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 11:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D8E20863
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 11:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kmad2RRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbfB0Lq3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:46:29 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44917 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbfB0Lq3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Feb 2019 06:46:29 -0500
Received: by mail-ed1-f68.google.com with SMTP id b20so13597489edw.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Feb 2019 03:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=/vYXZl0ZLKnCjOL2xQrfHoYyDzWXSjtMd7XrlySWbCE=;
        b=Kmad2RRdQAYyoOhnKP22cHaRILbePZvhNYQRWCXkr81429gyCngwIRjFQEkNQqT7G+
         TAoVAmTbY728p3mxaTkU2OQi+L50DG/uvH7GQ6QkGZUOoRGehJB5bgtSR4Fr/aedcZZQ
         T4GRNZggJvvvaHGjP9y0bfHJb7vlPVtT2Jy8D7UV56E1yW4+o2d+rzqe30ojDZyVGKsv
         sgtNC1vms3bLBRZyl2Rj99VzqoYV4iL2OHt2rmaX4Cxg7/Yutaryw96d3GFgHeaIIBaM
         naFabQqWfsLGfn7gtOHReZ/vvfBCRX8akkacaCX3+xsvvO4wrah3yUXlUHAK21HsUK0R
         XN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=/vYXZl0ZLKnCjOL2xQrfHoYyDzWXSjtMd7XrlySWbCE=;
        b=iDGIKC9tHQ+ig9YGK5E46xyPOz4BOBQ5MM0jXfqFjfijAQO+1vOkykAS0Ez7w8Hr4J
         83oouLjgs+QyqLtVexmNOiAQKGfR4rMfyLXmmlTAs5mL861gW0x2umVs+3PpYl9FK0JV
         o6JrXnyotkJ5+49LwzBIQJuEkNKsThiILRCpVOLxE/a53ex5wX1L/LHs64IWJEAJC6Be
         0jAi0P0sD6IBCo5lCLBZHtqHh5ReVg6c0/HWZthcF1bYljcCyLgqjO/lWcFcwWDvEDy+
         ZGnPbUuYRPHWCj0scYI3E54iXy9HXqt5i2WiNWYXWZ6dseyi3OzIL6HWYcZeHV4lW4M0
         sM1g==
X-Gm-Message-State: AHQUAuZfvjzdBNJvQ96BxEQcdNiKdokT0ZEmkuO8BlXtxmohBlzS85fA
        rnN0jrDDm2gjMrnK2VxACE0f5qS7UR8=
X-Google-Smtp-Source: AHgI3IY5f59mxLsB9Kwz1qCzINIphLhmVJSCC5npz2oKuHSjnoiYPp5TC2uSbUFJ0piiiKl5uP73tg==
X-Received: by 2002:a05:6402:124a:: with SMTP id l10mr2098775edw.62.1551267987202;
        Wed, 27 Feb 2019 03:46:27 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id l24sm2652333eja.57.2019.02.27.03.46.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 03:46:26 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] monitor: Add decoding support for LL_MIN_USED_CHANNELS
Date:   Wed, 27 Feb 2019 13:46:17 +0200
Message-Id: <20190227114620.21630-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190227114620.21630-1-luiz.dentz@gmail.com>
References: <20190227114620.21630-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints makes the fields to be printed instead of just decoding
the PDU name.
---
 monitor/bt.h |  6 ++++++
 monitor/ll.c | 17 ++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 46d9b287f..80f514f03 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -143,6 +143,12 @@ struct bt_ll_phy_update_ind {
 	uint16_t instant;
 } __attribute__ ((packed));
 
+#define BT_LL_MIN_USED_CHANNELS	0x19
+struct bt_ll_min_used_channels {
+	uint8_t  phys;
+	uint8_t  min_channels;
+} __attribute__ ((packed));
+
 #define LMP_ESC4(x) ((127 << 8) | (x))
 
 #define BT_LMP_NAME_REQ			1
diff --git a/monitor/ll.c b/monitor/ll.c
index 02ff1f628..ff757725b 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -535,6 +535,21 @@ static void phy_update_ind(const void *data, uint8_t size)
 	print_field("Instant: 0x%4.4x", pdu->instant);
 }
 
+static void min_used_channels(const void *data, uint8_t size)
+{
+	const struct bt_ll_min_used_channels *pdu = data;
+	uint8_t mask;
+
+	print_field("PHYS: 0x%2.2x", pdu->phys);
+
+	mask = print_bitfield(2, pdu->phys, le_phys);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+
+	print_field("MinUsedChannels: 0x%2.2x", pdu->min_channels);
+}
+
 struct llcp_data {
 	uint8_t opcode;
 	const char *str;
@@ -569,7 +584,7 @@ static const struct llcp_data llcp_table[] = {
 	{ 0x16, "LL_PHY_REQ",               phy_req_rsp,        2, true },
 	{ 0x17, "LL_PHY_RSP",               phy_req_rsp,        2, true },
 	{ 0x18, "LL_PHY_UPDATE_IND",        phy_update_ind,     4, true },
-	{ 0x19, "LL_MIN_USED_CHANNELS_IND", NULL,               2, true },
+	{ 0x19, "LL_MIN_USED_CHANNELS_IND", min_used_channels,  2, true },
 	{ }
 };
 
-- 
2.17.2

