Return-Path: <SRS0=vyxk=RC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ECBC4360F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 11:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A0C2147C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 11:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4q4xZdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfB0Lq1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:46:27 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46553 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbfB0Lq1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Feb 2019 06:46:27 -0500
Received: by mail-ed1-f65.google.com with SMTP id f2so13596237edy.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Feb 2019 03:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=1ZjeJbpIQNSdb2up8qN96jmggxa3eR7BGe+Qy6cUI4U=;
        b=A4q4xZdf5lrnh7UJxLmMidLOrn2SiPKYzDH85bq1rJhtWjXynZISwLO0UuXZPeIX3R
         Gn4+Zrgp/PcdFOADjSmC8GDaM4izwx6LW3ufjA+iOngqgMwwG1mgQvc3xTc9JU2/S8Dg
         0x1oD+b3GjVBxDnr5tWWssWjVrLM7OYqlALxseXsK+CL4zfZWXIq+vyHx77sLJDNTqC2
         MQGIA7JxbIudPDpifwLipINRfu3PTijzZsoqAQ9/ioUcxVxpj4lTWCDfjQpWQt8ALN61
         k0caHFxB5KvIYSAaOttsOauMZc2SPyEt7okPbSlBuy36RGQHDtWLdviptvVd8KJ914rC
         G7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=1ZjeJbpIQNSdb2up8qN96jmggxa3eR7BGe+Qy6cUI4U=;
        b=CP9plki2bVlwzUCXWAgftsq1T6Pux8giFtDx0Odorv2E14vE2Vtll0wzLqyMzjEobv
         cuZ2te7BOhuW6AHZs/Ob8S9TotEypueBl+BK+qq8WQmgcIMUU2pyGN4ulNm3jzla5H+f
         NCXhDLwT6lefWsl12VAWMp+L1mtMzgvkjv2+5b3eCf/YfmuFbqZLesjDxvn3FvV81ruW
         KJmpvYlGx1hARK9UNZe+zFgpYe/i/hauFqD36s29pndTJuO/txlBrJnsIdSCJ4m3oZ6l
         yWzzqHEup6xf/e5Wf8ZJB51mgFAhquaqNa0lTt6JOHTT8NKf2B8hwdjFwBeXuH7cs8hE
         W2eg==
X-Gm-Message-State: AHQUAuZqUyUH+3kPFU+KBIy+qNABImYFRaFtkEgnSeAI6HgF9gKmNaTG
        w9htpezmRmteBul1ATG2cXbMBU97L80=
X-Google-Smtp-Source: AHgI3IZkod6ajuV2jfS7FnVPx0DAtfU7w/IhummRSjR91U8Thh54xRJItP3oSjHTKdzS8Ah5goyFcw==
X-Received: by 2002:a05:6402:171a:: with SMTP id y26mr2067836edu.72.1551267984659;
        Wed, 27 Feb 2019 03:46:24 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id l24sm2652333eja.57.2019.02.27.03.46.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 03:46:23 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/7] monitor: Add decoding support for LL_PHY_*
Date:   Wed, 27 Feb 2019 13:46:15 +0200
Message-Id: <20190227114620.21630-2-luiz.dentz@gmail.com>
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
 monitor/bt.h |  8 ++++++++
 monitor/ll.c | 31 +++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 59d5c20af..aa4057a7b 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -128,6 +128,14 @@ struct bt_ll_length {
 
 #define BT_LL_LENGTH_RSP	0x15
 
+#define BT_LL_PHY_REQ		0x16
+struct bt_ll_phy {
+	uint8_t  tx_phys;
+	uint8_t  rx_phys;
+} __attribute__ ((packed));
+
+#define BT_LL_PHY_RSP		0x17
+
 #define LMP_ESC4(x) ((127 << 8) | (x))
 
 #define BT_LMP_NAME_REQ			1
diff --git a/monitor/ll.c b/monitor/ll.c
index c70c1166f..a65c93498 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -39,6 +39,7 @@
 
 #define COLOR_OPCODE		COLOR_MAGENTA
 #define COLOR_OPCODE_UNKNOWN	COLOR_WHITE_BG
+#define COLOR_UNKNOWN_OPTIONS_BIT COLOR_WHITE_BG
 
 #define MAX_CHANNEL 16
 
@@ -486,6 +487,32 @@ static void length_req_rsp(const void *data, uint8_t size)
 	print_field("MaxtxTime: %u", pdu->tx_time);
 }
 
+static const struct bitfield_data le_phys[] = {
+	{  0, "LE 1M"	},
+	{  1, "LE 2M"	},
+	{  2, "LE Coded"},
+	{ }
+};
+
+static void phy_req_rsp(const void *data, uint8_t size)
+{
+	const struct bt_ll_phy *pdu = data;
+	uint8_t mask;
+
+	print_field("RX PHYs: 0x%2.2x", pdu->rx_phys);
+
+	mask = print_bitfield(2, pdu->rx_phys, le_phys);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+	print_field("TX PHYs: 0x%2.2x", pdu->tx_phys);
+
+	mask = print_bitfield(2, pdu->tx_phys, le_phys);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+}
+
 struct llcp_data {
 	uint8_t opcode;
 	const char *str;
@@ -517,8 +544,8 @@ static const struct llcp_data llcp_table[] = {
 	{ 0x13, "LL_PING_RSP",              null_pdu,           0, true },
 	{ 0x14, "LL_LENGTH_REQ",            length_req_rsp,     8, true },
 	{ 0x15, "LL_LENGTH_RSP",            length_req_rsp,     8, true },
-	{ 0x16, "LL_PHY_REQ",               NULL,               2, true },
-	{ 0x17, "LL_PHY_RSP",               NULL,               2, true },
+	{ 0x16, "LL_PHY_REQ",               phy_req_rsp,        2, true },
+	{ 0x17, "LL_PHY_RSP",               phy_req_rsp,        2, true },
 	{ 0x18, "LL_PHY_UPDATE_IND",        NULL,               4, true },
 	{ 0x19, "LL_MIN_USED_CHANNELS_IND", NULL,               2, true },
 	{ }
-- 
2.17.2

