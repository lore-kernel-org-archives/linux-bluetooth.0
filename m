Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BE2C4727E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2470207C4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdzpCNVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgIYBOQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 21:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgIYBOQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 21:14:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F53C0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 18:14:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e2so1112262ybc.17
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 18:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=u7upB3YHtuG3XeKfD7rbED1WqQ/vtOSp37smZR5GKso=;
        b=WdzpCNVPvG77wfjbMXgVvIYvlolb6Ci2jHZuHKRofKlaQGHwYHVSi1Rc0/2W0pa9iJ
         UgoPAEJilMvR1pMBiJ7+nKkjd+SQLRucJekpuWGHyekep9UdWiwZjgpcXJPZW4mdr49a
         eRhh1KtlxcrXLXu9sKpv4I57JHcQzMqvgAAENN5HzqVAJfiIx41dt1KX629ZGIzDlqUV
         iFpfeI3fWsduAE4bTpFaymkajx3ZJPXnG6yYe+QAo8oE5T21RiIvE1ACZICi0U4tgwwT
         yy+IxPzJX1/wFleJvLGK/Gmpu7X55yLHiTu+V75OB8guOK3z4qi/bChTOc7RrZUZIbZY
         LvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u7upB3YHtuG3XeKfD7rbED1WqQ/vtOSp37smZR5GKso=;
        b=Ut1cW9VJNs+WMa4hKgILESWy11iBoEYegVbQJ2JxvTIJ/IyqCSSR3LBhccEVi60xSV
         2rD2xcFGsW4OZsYXex+JAc7E6Oz8wYWVE2W6+aB2hXBJMYSQ4JEgaMxvw0/xzI52jB/C
         /GnQ02YjvM3C+SLxSaPZPGqOlSBat7o5bhMrQ63+bGMav99OdTnPSAIVGhJRO8FzewyY
         D/4z6qTzyWHUkbDH5eOCDokHCCfjUR86oO6DEqFe4IEsUglf1yD7cumBMC7kCtHWv2yy
         +eMhYf3/Jxdq8chNUSe/HO3zSr9nB0dV/xodJEYnKiXtso0ymuRcja9kHG5VYkUWZ/o3
         fNpA==
X-Gm-Message-State: AOAM533/YJ0zSmqMHg/Y8WE8RbGCesXZ+esD1Ge3KK/+MaiO5Js9o3k3
        60rVatojAhG2VMMOdaw6AsnRZnYCVMDw2uMP7HNs
X-Google-Smtp-Source: ABdhPJwKMM/VhWOJWPWskOoZFxMMCJqbAM1TCp/z1Il5Zv6zE05QLbzZ+stUOoq+8vKN4zHvdbzaETgQRMcBIh5hdNeT
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:e80d:: with SMTP id
 k13mr1968674ybd.179.1600996455256; Thu, 24 Sep 2020 18:14:15 -0700 (PDT)
Date:   Thu, 24 Sep 2020 18:13:47 -0700
In-Reply-To: <20200925011347.2478464-1-danielwinkler@google.com>
Message-Id: <20200924180838.Bluez.v3.9.I2884e6456c272dadb3d70a629674027f23b0393e@changeid>
Mime-Version: 1.0
References: <20200925011347.2478464-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v3 9/9] monitor: Add new MGMT adv commands and events to monitor
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds the following to packet monitor:
-Add Ext Adv Params command and response
-Add Ext Adv Data command and response

This patch was manually tested by registering advertisements with
various features and verifying in btmon log.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v3:
- Removed Tx Power Selected MGMT event from monitor

Changes in v2: None

 monitor/packet.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 9350a6682..00bc165cc 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11872,6 +11872,26 @@ static void mgmt_print_adv_flags(uint32_t flags)
 							" (0x%8.8x)", mask);
 }
 
+static const struct bitfield_data mgmt_adv_params_table[] = {
+	{  0, "Use Duration parameter"	},
+	{  1, "Use Timeout parameter"	},
+	{  2, "Use Interval parameters"	},
+	{  3, "Use TX Power parameter"	},
+	{ }
+};
+
+static void mgmt_print_adv_params(uint16_t flags)
+{
+	uint32_t mask;
+
+	print_field("Enabled parameters: 0x%4.4x", flags);
+
+	mask = print_bitfield(2, flags, mgmt_adv_params_table);
+	if (mask)
+		print_text(COLOR_UNKNOWN_ADV_FLAG, "  Unknown advertising param"
+							" (0x%8.8x)", mask);
+}
+
 static void mgmt_print_store_hint(uint8_t hint)
 {
 	const char *str;
@@ -13163,6 +13183,55 @@ static void mgmt_set_device_flags_rsp(const void *data, uint16_t size)
 
 	mgmt_print_address(data, type);
 }
+static void mgmt_add_ext_adv_params_cmd(const void *data, uint16_t size)
+{
+	uint8_t instance = get_u8(data);
+	uint32_t flags = get_le32(data + 1);
+	uint16_t params = get_le16(data + 5);
+	uint16_t duration = get_le16(data + 7);
+	uint16_t timeout = get_le16(data + 9);
+	uint8_t *min_interval = (uint8_t *)(data + 11);
+	uint8_t *max_interval = (uint8_t *)(data + 15);
+	int8_t tx_power = get_s8(data + 19);
+
+	print_field("Instance: %u", instance);
+	mgmt_print_adv_flags(flags);
+	mgmt_print_adv_params(params);
+	print_field("Duration: %u", duration);
+	print_field("Timeout: %u", timeout);
+	print_ext_slot_625("Min advertising interval", min_interval);
+	print_ext_slot_625("Max advertising interval", max_interval);
+	print_power_level(tx_power, NULL);
+}
+
+static void mgmt_add_ext_adv_params_rsp(const void *data, uint16_t size)
+{
+	uint8_t instance = get_u8(data);
+	int8_t tx_power = get_s8(data + 1);
+
+	print_field("Instance: %u", instance);
+	print_power_level(tx_power, NULL);
+}
+
+static void mgmt_add_ext_adv_data_cmd(const void *data, uint16_t size)
+{
+	uint8_t instance = get_u8(data);
+	uint8_t adv_data_len = get_u8(data + 1);
+	uint8_t scan_rsp_len = get_u8(data + 2);
+
+	print_field("Instance: %u", instance);
+	print_field("Advertising data length: %u", adv_data_len);
+	print_eir(data + 3, adv_data_len, false);
+	print_field("Scan response length: %u", scan_rsp_len);
+	print_eir(data + 3 + adv_data_len, scan_rsp_len, false);
+}
+
+static void mgmt_add_ext_adv_data_rsp(const void *data, uint16_t size)
+{
+	uint8_t instance = get_u8(data);
+
+	print_field("Instance: %u", instance);
+}
 
 struct mgmt_data {
 	uint16_t opcode;
@@ -13395,6 +13464,12 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x0050, "Set Device Flags",
 				mgmt_set_device_flags_cmd, 11, true,
 				mgmt_set_device_flags_rsp, 7, true},
+	{ 0x0054, "Add Ext Adv Params",
+				mgmt_add_ext_adv_params_cmd, 20, false,
+				mgmt_add_ext_adv_params_rsp, 2, true },
+	{ 0x0055, "Add Ext Adv Data",
+				mgmt_add_ext_adv_data_cmd, 3, false,
+				mgmt_add_ext_adv_data_rsp, 1, true },
 	{ }
 };
 
-- 
2.28.0.709.gb0816b6eb0-goog

