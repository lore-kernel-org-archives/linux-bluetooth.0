Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56F0C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 21:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C450520724
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 21:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD9mTfPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgDWVzG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgDWVzF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 17:55:05 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55B4C09B042
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 14:55:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x15so3690594pfa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 14:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yAXh3xoOECbXXgj+ID5ZQOMf1h0nrGV0PRZjaNZf1ig=;
        b=aD9mTfPJEfI7b3hR0Qk0J4wy4BUcp2u0l8ViaQd8tDewR21RD3+tNZAtIL7a13NG6g
         RyRJ9tFGBlekLBQCadnsDF5/mfBbnAY/jYe4a2KuVPwgsy8aIjia1yu5CvYUag4Vozq6
         LFEbbgREGvK6ECqvOgf8b5aIXdpq2t/6Zdp92farCTL15Hqx2X+zl/M9WNksvS4oH9Yo
         OhfSt0enFOg+cK+T/8wbyUhd16ZvlJXc6AEeFLff0gtDxCfVQZE9TG+ICTx8Var0gXdp
         9qQgNUzlZ6pt0cn+RgX8YgtP3aiA61rdwhPC4JDdpV46+gktDajiPGsJkxYQjFz1QNQn
         N4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yAXh3xoOECbXXgj+ID5ZQOMf1h0nrGV0PRZjaNZf1ig=;
        b=IKOU8WDRlHfxBI9JeEMsRkd2ilOup8AQpEZSCvHNwhTmFDP2YvVy/dH7vTvxOgKeZJ
         GXLTZbumWfkX14vyyTUt4KgkWHbGWVOccHwy53zEM2Lharczto+Ewc9K0LLgjjpr+kZe
         LUohDhSY4Odj9BsVOl3pR4Mi2mYAXm9qy7kAR1EExWWFGQf1T08RIpv6/TRlrvZpECCj
         xJfdHYyO02O+GKOzWV1WoRwEH1Yu8Wzsit5Kml1QzJd5E3mwJiS0nZ8M4MSd1yDMWccY
         hjiizWd5TimvY6V/s54ZXeap9bjaxgGtvaRQ3FbpdFf22gQFWvbTtWPh3zZj+Nl8s1nU
         z1UQ==
X-Gm-Message-State: AGi0PuYiPm9UG20yiYQZtfyaTJSRbBDnfgXp0K9N5OxosLWKRywh2h48
        jY9UNO4Gf0JkAWf11Zy2xZadem+s93A=
X-Google-Smtp-Source: APiQypKvsJpyqdmgWt3JGf1kX+9GEUvGMohIbNMV+dKeTzIOWB4A8pVHEVWsOgos4+uPuNh5pAKNEQ==
X-Received: by 2002:a62:e211:: with SMTP id a17mr5398151pfi.250.1587678904758;
        Thu, 23 Apr 2020 14:55:04 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k12sm2972294pgj.33.2020.04.23.14.55.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:55:04 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/6] monitor: Add decoding support for HCI LE Set Host Feature
Date:   Thu, 23 Apr 2020 14:54:57 -0700
Message-Id: <20200423215501.427266-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200423215501.427266-1-luiz.dentz@gmail.com>
References: <20200423215501.427266-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds decoding support for LE Set Host Feature.
---
 monitor/packet.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 038dd6d17..777a52205 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8128,6 +8128,21 @@ static void le_req_peer_sca_cmd(const void *data, uint8_t size)
 	print_field("Connection Handle: %d", le16_to_cpu(cmd->handle));
 }
 
+static void le_set_host_feature_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_host_feature *cmd = data;
+	uint64_t mask;
+
+	print_field("Bit Number:");
+
+	mask = print_bitfield(2, cmd->bit_number, features_le);
+	if (mask)
+		print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown features "
+						"(0x%16.16" PRIx64 ")", mask);
+
+	print_field("Bit Value: %u", cmd->bit_value);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -9041,6 +9056,10 @@ static const struct opcode_data opcode_table[] = {
 	{ BT_HCI_CMD_LE_ISO_TEST_END, BT_HCI_BIT_LE_ISO_TEST_END,
 				"LE Isochronous Read Test Counters", NULL, 0,
 				false },
+	{ BT_HCI_CMD_LE_SET_HOST_FEATURE, BT_HCI_BIT_LE_SET_HOST_FEATURE,
+				"LE Set Host Feature", le_set_host_feature_cmd,
+				sizeof(struct bt_hci_cmd_le_set_host_feature),
+				true, status_rsp, 1, true },
 	{ }
 };
 
-- 
2.25.3

