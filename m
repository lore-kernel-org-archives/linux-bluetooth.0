Return-Path: <SRS0=vyxk=RC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC055C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 11:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7C320863
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 11:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZmxk4Ud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfB0Lqb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:46:31 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35144 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbfB0Lqa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Feb 2019 06:46:30 -0500
Received: by mail-ed1-f65.google.com with SMTP id g19so13646488edp.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Feb 2019 03:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=t5xx2RA17FmVgEmNk1uDto7iHYGHTN/qXdyb3XbhxkY=;
        b=UZmxk4UdUI5PTytkzY6LK+ZyYxuaJR/ap/IQ8goJdxygYMHR95Qu/GvMK52g9In9Zk
         bFF+90dNeCN+XLxUTyo060yxsGQdkLoTDvDTjl4JNCaPit7L2pXhcmOKze2VBAT4yGAc
         7Mj4jWcvmB3IKusvjYO8BMtOelygcj2J9jKhDxuAthaQJ+CP1FY2+aMy9ZlKJhYr0+qJ
         y+Z7rWF82gwjrIhynYpo4RuGK0S69cEn4pu//u5dBtKfNRMmHCJR7ZwN7LfoFFt+GaAb
         edDpuQmUFE+aD7reTk3iaNC7WNk8OPc+VBh+MO4Dkge9/Uz74wNKV6kSKqaN8p/c4gdq
         pAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t5xx2RA17FmVgEmNk1uDto7iHYGHTN/qXdyb3XbhxkY=;
        b=M5mpMufuQuvoDU8hL9Z2TKYTw/aOgUUTBlDdnG8Hd5nHHmzmobAry8K/21/bA+IAjE
         cTQBe64yIk7JWSlvRZ/kAVW2f7RcXgYgzgwNdGPYkourtCCOvhxXB89X8He8ol/Pm/+v
         xeYNFotORCCAEMUkHhZAxnTa4gMiDK/sJ1PUXxBUuWq/odm/7fYteo1m9RZJfWCMWOYk
         UukmgFrS3gJYVja1DtGr3b/o3TMF96yVZQovssh9Aze621aLOXelQ6WcjnEcNTGdbKyr
         Xhb7S1RcTXIpglbkzmVWSMq1qMtGIbczwVL1Cat41d36aEsoJlQRUrfcuii562r/Pxka
         291Q==
X-Gm-Message-State: AHQUAubGL/nLP7wMacZ2sPb2EEFYrJQahLzoVpis0ut7HR3GO8LF2pGB
        hred0rTLbHvQV7fpcQ5fqAQjna59gKk=
X-Google-Smtp-Source: AHgI3IYdu2/xdppBZeuCewTle+NUbwQu3WqWkdq02MVbJw9P/IUOTRttse9+3b/kGmSkmNs9mTjcIQ==
X-Received: by 2002:a50:e703:: with SMTP id a3mr1955326edn.205.1551267988617;
        Wed, 27 Feb 2019 03:46:28 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id l24sm2652333eja.57.2019.02.27.03.46.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 03:46:27 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/7] monitor: Decode LL_CTE_*
Date:   Wed, 27 Feb 2019 13:46:18 +0200
Message-Id: <20190227114620.21630-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190227114620.21630-1-luiz.dentz@gmail.com>
References: <20190227114620.21630-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces the command passing for LL_CTE_* PDUs added in 5.1.
---
 monitor/bt.h |  7 +++++++
 monitor/ll.c | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index 80f514f03..f3995b4ea 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -149,6 +149,13 @@ struct bt_ll_min_used_channels {
 	uint8_t  min_channels;
 } __attribute__ ((packed));
 
+#define BT_LL_CTE_REQ		0x1a
+struct bt_ll_cte_req {
+	uint8_t  cte;
+} __attribute__ ((packed));
+
+#define BT_LL_CTE_RSP		0x1b
+
 #define LMP_ESC4(x) ((127 << 8) | (x))
 
 #define BT_LMP_NAME_REQ			1
diff --git a/monitor/ll.c b/monitor/ll.c
index ff757725b..34f3e2cfc 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -550,6 +550,26 @@ static void min_used_channels(const void *data, uint8_t size)
 	print_field("MinUsedChannels: 0x%2.2x", pdu->min_channels);
 }
 
+static void cte_req(const void *data, uint8_t size)
+{
+	const struct bt_ll_cte_req *pdu = data;
+
+	print_field("MinCTELenReq: 0x%2.2x", pdu->cte & 0xf8);
+	print_field("CTETypeReq: 0x%2.2x", pdu->cte & 0x03);
+
+	switch (pdu->cte & 0x03) {
+	case 0x00:
+		print_field("  AoA Constant Tone Extension");
+		break;
+	case 0x01:
+		print_field("  AoD Constant Tone Extension with 1 μs slots");
+		break;
+	case 0x02:
+		print_field("  AoD Constant Tone Extension with 2 μs slots");
+		break;
+	}
+}
+
 struct llcp_data {
 	uint8_t opcode;
 	const char *str;
@@ -585,6 +605,8 @@ static const struct llcp_data llcp_table[] = {
 	{ 0x17, "LL_PHY_RSP",               phy_req_rsp,        2, true },
 	{ 0x18, "LL_PHY_UPDATE_IND",        phy_update_ind,     4, true },
 	{ 0x19, "LL_MIN_USED_CHANNELS_IND", min_used_channels,  2, true },
+	{ 0x1a, "LL_CTE_REQ",               cte_req,            1, true },
+	{ 0x1b, "LL_CTE_RSP",               null_pdu,           0, true },
 	{ }
 };
 
-- 
2.17.2

