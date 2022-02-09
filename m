Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340F4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 09:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbiBIJ0P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:26:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiBIJ0M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 04:26:12 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA85E058269
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 01:26:07 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id a39so2386592pfx.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 01:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fQtjyJhWV3SBhpr27SqHKqSu/xFu20sVB+tlUFLL+GM=;
        b=QQJnt/oQEwVXWXGZVVaW52Jcnnd9OyAPxC5eO7uP/BpcyNNxjZtzWE0ZNOCFkQ5zgy
         P5RwDdQ54U/maO3VMmT+DTYD03jIaMFvOlObjYmdxNprWVgn5YTFTJZA4B51W0p7yhTN
         HTYO4ibA+7q/FIR7DbxFfKWdUoq/VDTLR7plE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQtjyJhWV3SBhpr27SqHKqSu/xFu20sVB+tlUFLL+GM=;
        b=RcUu/ueXDkXoET1o3GGi820CiTFEoWNoBDIv6x15nHkYWColIfpB2FFH49AhtWLun+
         hRrjTCfgqYJWyGtLRucxe3BkR+CQb1yWItwxQMXEq9xcr2u5SbUNGcxhSFgGpGgv9Rwv
         SJMPp5kRBT58QBFHTXXe50XR10rYCGEvwbGXg+CJsRaS7u6oO8WJA+szIGHa5jZMAEeC
         VcPw3zoHduTlrItQ7ovPtKkLM8pqn7U6WC4Prsc449JIvxlFQTL4p7qbGWkbdQ6FXlkT
         mGCsC6OHwa/wCv8m67nr5hkBX3qD/PDnnCrPAXQSMWWAHBqO6jP+dnub7PND0NmI9PEa
         70qg==
X-Gm-Message-State: AOAM530jHvwY6avSbn1FCwKVCSgHBbRT/NeQYtIeRojvV8MXc9IB12l7
        KUCB2GNI7+ReYuADsc8p7UlcxAw4ahmR3g==
X-Google-Smtp-Source: ABdhPJw63VL5m7wpsMo2kepLc0deDKTlIXCjWnExhON66s2pDXwnDtdldz63QRuyiNdNtz10ppHZzw==
X-Received: by 2002:a63:6a87:: with SMTP id f129mr1210501pgc.0.1644398683645;
        Wed, 09 Feb 2022 01:24:43 -0800 (PST)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id j14sm19611086pfj.218.2022.02.09.01.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 01:24:43 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v3 9/9] monitor: print quality report cmd
Date:   Wed,  9 Feb 2022 17:24:14 +0800
Message-Id: <20220209092414.751642-7-josephsih@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220209092414.751642-1-josephsih@chromium.org>
References: <20220209092414.751642-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch prints the set quality command properly.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v3:
- This is a new patch that prints the set quality command.

 monitor/packet.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 397000644..4dce2f681 100644
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
+	uint8_t action = *(uint8_t *)data;
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
+				mgmt_null_rsp, 0, true },
 	{ }
 };
 
-- 
2.35.0.263.gb82422642f-goog

