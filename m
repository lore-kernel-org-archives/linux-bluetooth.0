Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48846C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 23:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B1720791
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 23:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2L+wmsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgJ2XGw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 19:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgJ2XGw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 19:06:52 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD9EC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 16:06:50 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id z125so3308760pfc.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 16:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=kA9w/wVpwLgl3jMtZangANRk6/ntU2HgtobEbdswOj4=;
        b=K2L+wmsg8UyE4YFV8W07qtDxGXvJqx208dcCXtFeeDdgoEvfxLNAotp8R3ju5sTh4w
         W5Uh+jqCkd/KOaHo3b4xroUvSmcb0tldNXlmi+u57XPR/KFjV6FmNMdRyh3chbcrQ8Rk
         MD4ejWNEl0vgDrcRYcnxcgD9z09EhasaO+HY/k69o7cI1Y3yyc4Q4rA70igszQ1X4oP9
         WbD2wW04HYDVFRaE/qQ7V+D+cH4as8l0O/YZupUI7liGs6sd7D69AaGAzaRzwHZuVwir
         1QTIim1L2wPcrS0VwaFEI1SQPtax2kb7V2c70CzMTHntjrM5/YON8Q7/nnKEoDuqeOG+
         2jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kA9w/wVpwLgl3jMtZangANRk6/ntU2HgtobEbdswOj4=;
        b=pTKEKcU+yqhvL5454X5PogJRQeQbmLYfVqFTBKwbPgvwgnHFTNzzhTZpNpMyVecO/i
         0ocX429F75IpPbTUHCIm/abxfo106OPmTk1N2eYeduuO0nKqLkW1nvaahW5hcWQUe0nN
         BEN37JlirYyPOGTNhMroPf5U3nXyo7+9MR1jzAgHbQM6QTp7jcjb4drWO3YbT085eQCX
         QVdtNqkVeW1PXuv63FbB7fXcnF4rA57SncP04IMDUCtylEGoWCbv9pTSo+J3lkrRWVqE
         RpKPTvdDFs+D5RYieitew8UB+jPwQJKbddGtHi9A/CwqjwKQrDJUN9oVLf4LDCdiDZFl
         Qqyw==
X-Gm-Message-State: AOAM533sKq5P6A1tIRlpluhoDAVHIkGHGLoM393Nwf0YBI4Gb9RiSSlL
        4iiFQjlwaGmpYs9X81LK03gT9H5zZpmwvmuNSm95
X-Google-Smtp-Source: ABdhPJx7N1qh0KVSsuTtTWg4WekpJ5CgoUsb1C2R+BY1X7clt+DsMRE3MYU5u8JNy1i/7KlQuhJs4Kz4MzV+ifj7kD6j
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a17:90a:d303:: with SMTP id
 p3mr1461029pju.93.1604012810251; Thu, 29 Oct 2020 16:06:50 -0700 (PDT)
Date:   Thu, 29 Oct 2020 16:06:22 -0700
In-Reply-To: <20201029230623.3630069-1-danielwinkler@google.com>
Message-Id: <20201029160317.Bluez.v6.10.I2884e6456c272dadb3d70a629674027f23b0393e@changeid>
Mime-Version: 1.0
References: <20201029230623.3630069-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v6 10/10] monitor: Add new MGMT adv commands and events
 to monitor
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

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3:
- Removed Tx Power Selected MGMT event from monitor

Changes in v2: None

 monitor/packet.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index a97f2af52..c8c835d53 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11845,8 +11845,16 @@ static const struct bitfield_data mgmt_adv_flags_table[] = {
 	{  7, "Advertise in 1M on Secondary channel"	},
 	{  8, "Advertise in 2M on Secondary channel"	},
 	{  9, "Advertise in CODED on Secondary channel"	},
+	{  12, "Use provided duration parameter"	},
+	{  13, "Use provided timeout parameter"		},
+	{  14, "Use provided interval parameters"	},
+	{  15, "Use provided tx power parameter"	},
 	{ }
 };
+#define MGMT_ADV_PARAM_DURATION		(1 << 12)
+#define MGMT_ADV_PARAM_TIMEOUT		(1 << 13)
+#define MGMT_ADV_PARAM_INTERVALS	(1 << 14)
+#define MGMT_ADV_PARAM_TX_POWER		(1 << 15)
 
 static void mgmt_print_adv_flags(uint32_t flags)
 {
@@ -13151,6 +13159,57 @@ static void mgmt_set_device_flags_rsp(const void *data, uint16_t size)
 
 	mgmt_print_address(data, type);
 }
+static void mgmt_add_ext_adv_params_cmd(const void *data, uint16_t size)
+{
+	uint8_t instance = get_u8(data);
+	uint32_t flags = get_le32(data + 1);
+	uint16_t duration = get_le16(data + 5);
+	uint16_t timeout = get_le16(data + 7);
+	uint8_t *min_interval = (uint8_t *)(data + 9);
+	uint8_t *max_interval = (uint8_t *)(data + 13);
+	int8_t tx_power = get_s8(data + 17);
+
+	print_field("Instance: %u", instance);
+	mgmt_print_adv_flags(flags);
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
+	uint8_t max_adv_data_len = get_u8(data+2);
+	uint8_t max_scan_rsp_len = get_u8(data+3);
+
+	print_field("Instance: %u", instance);
+	print_power_level(tx_power, NULL);
+	print_field("Available adv data len: %u", max_adv_data_len);
+	print_field("Available scan rsp data len: %u", max_scan_rsp_len);
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
 
 static const struct bitfield_data mgmt_adv_monitor_features_table[] = {
 	{ 1, "OR Patterns"	},
@@ -13488,6 +13547,12 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x0053, "Remove Advertisement Monitor",
 				mgmt_remove_adv_monitor_patterns_cmd, 2, true,
 				mgmt_remove_adv_monitor_patterns_rsp, 2, true},
+	{ 0x0054, "Add Ext Adv Params",
+				mgmt_add_ext_adv_params_cmd, 18, false,
+				mgmt_add_ext_adv_params_rsp, 4, true },
+	{ 0x0055, "Add Ext Adv Data",
+				mgmt_add_ext_adv_data_cmd, 3, false,
+				mgmt_add_ext_adv_data_rsp, 1, true },
 	{ }
 };
 
-- 
2.29.1.341.ge80a0c044ae-goog

