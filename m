Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1068EC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 May 2022 10:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiEYKut (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 May 2022 06:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiEYKur (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 May 2022 06:50:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CE4D1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 03:50:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gz24so1387524pjb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 03:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=miJIvESjAK0ZOteRzXcxVnOWKJVfLsHBHQwdmkHOyoo=;
        b=dFfY/OPLLBmvoTIVkxDFhvi00dkeD3fl2Wrwhys9icoCeeNiyqMHZIlg0wVjGuxkJY
         9ATJX62gR9snV/hs4T3QIDfucXKnYv4csP8JSTIbOmcYhSjrtHeI6BvgIresxjFPDheq
         qcRINzWJCRvVvYLPpz/3nORvItsuC0v3QQwRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=miJIvESjAK0ZOteRzXcxVnOWKJVfLsHBHQwdmkHOyoo=;
        b=kJ6MG6CqhFGRaZFiW5ife96M7w9iFFXX40j7viLNHThT/nAzwgb9T0aesQD083K/d0
         z5umODSnjtYjhza+OjH4TW5U2N+ZjpMaRrimnXO/OkIU4JM8uMZQS9zeWEOtcJChCTFk
         sDkKruSWEM5wCBFrBjwf6dDjkUYb71IG9gg3EgGK6gg8dk9r6frbCC+TXYUTBL4nBp7G
         dBIIyljtv1s0R1Cnpd3m3O3WBTnDy4CgAv2OET1MbHqbw5VSCaQmh5nh2yxoJXvo1SOW
         ZoVNqrkaizrHHYVDSRsBpR5Uz4X/+fNk3qjyR0mweqvhtga43Pb5E3LNAeKOOLOhNLPv
         nXYw==
X-Gm-Message-State: AOAM533iS+XUvlkfhYy53Jx/KppRs8ogz/9ZxbLHvCIL+veVpeCGvduK
        4WhUA99mdyS7Ou4jbxjQes1D08av3jBC4A==
X-Google-Smtp-Source: ABdhPJz8pBiIBYx216PLdTiyBKrnqh4fz+PF8sP6eJOqHEXHVylbfCT5/PuzB80MiLHP8lZPInot9w==
X-Received: by 2002:a17:903:181:b0:161:d2d2:751d with SMTP id z1-20020a170903018100b00161d2d2751dmr31954920plg.91.1653475845921;
        Wed, 25 May 2022 03:50:45 -0700 (PDT)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id k2-20020a170902c40200b0016240bbe893sm3600857plk.302.2022.05.25.03.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 03:50:45 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v5 7/8] monitor: print quality report cmd
Date:   Wed, 25 May 2022 18:50:14 +0800
Message-Id: <20220525105015.2315987-5-josephsih@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220525105015.2315987-1-josephsih@chromium.org>
References: <20220525105015.2315987-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch prints the set quality command properly.

---

(no changes since v4)

Changes in v4:
- Use get_u8() to replace *(uint8_t *).
- Use mgmt_new_settings_rsp as the rsp_func in mgmt_command_table
  for Set Quality Report.

Changes in v3:
- This is a new patch that prints the set quality command.

 monitor/packet.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index d80735a06..33b1f2fea 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12216,6 +12216,7 @@ static const struct bitfield_data mgmt_settings_table[] = {
 	{ 15, "Static Address"		},
 	{ 16, "PHY Configuration"	},
 	{ 17, "Wideband Speech"		},
+	{ 18, "Quality Report"		},
 	{ }
 };
 
@@ -13812,6 +13813,13 @@ static void mgmt_remove_adv_monitor_patterns_rsp(const void *data,
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
@@ -14069,6 +14077,9 @@ static const struct mgmt_data mgmt_command_table[] = {
 				mgmt_add_adv_monitor_patterns_rssi_cmd, 8,
 									false,
 				mgmt_add_adv_monitor_patterns_rsp, 2, true},
+	{ 0x0057, "Set Quality Report",
+				mgmt_set_quality_report_cmd, 1, true,
+				mgmt_new_settings_rsp, 4, true },
 	{ }
 };
 
-- 
2.36.1.124.g0e6072fb45-goog

