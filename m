Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B0CC4727F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D90B720796
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D43UkDGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbgJAXCT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 19:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733085AbgJAXCT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 19:02:19 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FACBC0613D0
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2020 16:02:19 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id de12so224840qvb.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2020 16:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gJBrriPpYfqgEnTAXFMs90hjHaltSYXEQB9GSfjDt/c=;
        b=D43UkDGpicZJtqhR7V37Fv5gxISSa35iXU3LLN6PkCrhFo4N03hOSwfGFb1zlO0eSr
         wlm3eGl49S2G2SnKc3/kdIvtHW6N8FtFBE/6YBgpb19kmQQrXv5w24aI0VgJFlYjNiKy
         vQrhA4+AWOCRlqwLFY7iSo3jMPIUZaR3gP/kZW41syqNF1qw2fjFAPHzGTdjXVHIx+FG
         Z0hV67YcwKP7FAjw3R02p+mWYbfsLo9tzWclXGh4cURe5K7ozO3XeIIFYa9ep6nHPH34
         p4StB+/NeFpgQJ2Ej624mmLFEXLH1hGOg+rXFATWY0VgIdSBRaukzRgyKMtsw3zD66yy
         Ej+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gJBrriPpYfqgEnTAXFMs90hjHaltSYXEQB9GSfjDt/c=;
        b=f50yCplskjHItv2aGgueqpUa7OdkEX1d8n+0wzREaHdonoqzqq6R6LgsasNJ2qnl9a
         wu4PgUWj39XD5FoY/AqAhM/T/KcEsRJ1TvFBxhm1XonAlIZA83f+Fg7frGJqYmCObNuI
         2T67xMC+7dXHxsZULDTS94mGVlZwbSfKXucv57lVVbkZ6u0D73ACFUCHjWf8uOMSahYp
         vm4UOgLFTU6n+OyyiHSdu8l549TQGTjoJnGkGEaxADcfwyXO7M1rKAfo0HXQv++0r8Qm
         iabr7YGa/BJdkc+w0GAxtsw+qiKFdoVjnUXjkrRuzN21mwrHfuPtOaYvqbNmJA1WrSE0
         mmRQ==
X-Gm-Message-State: AOAM533g/Fv44PGB5QK+F730YPtSwKP/ZmYu27lEe6QJ7S9V+ZCgctiy
        2Uma8eAdRiEflqkC4k7QASKy8HRnYybT/PkHHq20
X-Google-Smtp-Source: ABdhPJxwTBUXDvF15XgYIppO4xRNTwsyr5imIoCt4oMeZLAJcFMHFdPRlIkmWUHraEIIqDdm2ffinqO5WX+0T4OONq+w
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:ad4:458f:: with SMTP id
 x15mr10344427qvu.33.1601593337999; Thu, 01 Oct 2020 16:02:17 -0700 (PDT)
Date:   Thu,  1 Oct 2020 16:01:52 -0700
In-Reply-To: <20201001230152.2422908-1-danielwinkler@google.com>
Message-Id: <20201001155738.Bluez.v4.10.I2884e6456c272dadb3d70a629674027f23b0393e@changeid>
Mime-Version: 1.0
References: <20201001230152.2422908-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v4 10/10] monitor: Add new MGMT adv commands and events
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

Changes in v4: None
Changes in v3:
- Removed Tx Power Selected MGMT event from monitor

Changes in v2: None

 monitor/packet.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 615c180f8..b67510f6d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11844,8 +11844,16 @@ static const struct bitfield_data mgmt_adv_flags_table[] = {
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
@@ -13150,6 +13158,57 @@ static void mgmt_set_device_flags_rsp(const void *data, uint16_t size)
 
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
 
 struct mgmt_data {
 	uint16_t opcode;
@@ -13382,6 +13441,12 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x0050, "Set Device Flags",
 				mgmt_set_device_flags_cmd, 11, true,
 				mgmt_set_device_flags_rsp, 7, true},
+	{ 0x0054, "Add Ext Adv Params",
+				mgmt_add_ext_adv_params_cmd, 18, false,
+				mgmt_add_ext_adv_params_rsp, 4, true },
+	{ 0x0055, "Add Ext Adv Data",
+				mgmt_add_ext_adv_data_cmd, 3, false,
+				mgmt_add_ext_adv_data_rsp, 1, true },
 	{ }
 };
 
-- 
2.28.0.709.gb0816b6eb0-goog

