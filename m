Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C61C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 13:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbiBONhJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 08:37:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiBONhI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 08:37:08 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EA06E8DE
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 05:36:59 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id qe15so17406887pjb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 05:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iah9qiR9JL2Z6N4lIow2hFh0pGExklk07rIIDc0sSuc=;
        b=dlatdPrwHL36yknZMfXwV1wj3YvmwXeGHNqE0vcpyTuvUCN5JLiUcoETKTpXjBYNKp
         hzpY3kz1nUEPYPpudL/yDke+wDRXX/tZxrRRkRbS0rQegh/fYooQ8KNWJh3b/cgt+/5w
         98kVIFpRg6YsfrFkSbrQkLpzLfqXMJ3jC1FVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iah9qiR9JL2Z6N4lIow2hFh0pGExklk07rIIDc0sSuc=;
        b=EToDxwOVOy1rHl8G3cqIrG86stBC3Og4uh9gAOv5DikIeywB6Bvdd0MAKJ50hjVoEd
         j/DKZE2qprUlluu31sWAcUYK4MBPktbdtVgfHDgxtDvehIXBQGg9vZUMAwTdZ0W6Vbtp
         xj8avredWY+6npwjwlOT0ZOdK5x7HAWF8iT9lzlwnJNhlb4lN7+Ua4R1KysgfUZxLXWh
         ro7N6doFRwO4jJOsLTigMiNRoX1//4s95eo14ttPdDMejCTs4u8r2VEzvXBg1l914obr
         /ZdRY9Hf7gw4/CruZuEaRPmk+kE3rlh8ve695mBOUcU+HFLHKBrgNtqpn+tNAXcOAxum
         P/Kg==
X-Gm-Message-State: AOAM530KVTcJ8GL18rspVurG3/7PKGW70n89deF13+LXwBN8NiUXDqbv
        xPiOz4BjwaldqTQcUZvJLZtOiXPVMuwWSA==
X-Google-Smtp-Source: ABdhPJz1h1v2551lpTsYkbP6IrLA0Ii+ml1a6kXUhIVRLGYoxSpZqBehWpinTD+h7gb+/ETijOOiaw==
X-Received: by 2002:a17:902:e888:: with SMTP id w8mr4353658plg.109.1644932218600;
        Tue, 15 Feb 2022 05:36:58 -0800 (PST)
Received: from localhost (208.158.221.35.bc.googleusercontent.com. [35.221.158.208])
        by smtp.gmail.com with UTF8SMTPSA id 84sm11267279pfx.181.2022.02.15.05.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 05:36:58 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v4 7/8] monitor: print quality report cmd
Date:   Tue, 15 Feb 2022 21:36:35 +0800
Message-Id: <20220215133636.2827039-5-josephsih@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220215133636.2827039-1-josephsih@chromium.org>
References: <20220215133636.2827039-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch prints the set quality command properly.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v4:
- Use get_u8() to replace *(uint8_t *).
- Use mgmt_new_settings_rsp as the rsp_func in mgmt_command_table
  for Set Quality Report.

Changes in v3:
- This is a new patch that prints the set quality command.

 monitor/packet.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index ec779a9d5..5f2085b4e 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12011,6 +12011,7 @@ static const struct bitfield_data mgmt_settings_table[] = {
 	{ 15, "Static Address"		},
 	{ 16, "PHY Configuration"	},
 	{ 17, "Wideband Speech"		},
+	{ 18, "Quality Report"		},
 	{ }
 };
 
@@ -13607,6 +13608,13 @@ static void mgmt_remove_adv_monitor_patterns_rsp(const void *data,
 	print_field("Handle: %d", handle);
 }
 
+static void mgmt_set_quality_report_cmd(const void *data, uint16_t size)
+{
+	uint8_t action = get_u8(data);
+
+	print_field("Set Quality Report %u", action);
+}
+
 struct mgmt_data {
 	uint16_t opcode;
 	const char *str;
@@ -13864,6 +13872,9 @@ static const struct mgmt_data mgmt_command_table[] = {
 				mgmt_add_adv_monitor_patterns_rssi_cmd, 8,
 									false,
 				mgmt_add_adv_monitor_patterns_rsp, 2, true},
+	{ 0x0057, "Set Quality Report",
+				mgmt_set_quality_report_cmd, 1, true,
+				mgmt_new_settings_rsp, 4, true },
 	{ }
 };
 
-- 
2.35.1.265.g69c8d7142f-goog

