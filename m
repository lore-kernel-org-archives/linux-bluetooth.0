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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABF7C4742C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D12D720838
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FgDriqeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgJ2VYG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgJ2VYF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 17:24:05 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B700C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:24:05 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a24so3140020pfh.20
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+EZS+0iqfqUdZXX+nBYUo2f3rJ8zcuppXhxUZFI276Q=;
        b=FgDriqeZ/rv0j7Tf3XHHXrFbkwwxZQyb9rNlR3l8KWBZ/fGw2aa0vDcvkxQ4GasDDh
         9WB/xlkRF7H/+z1SldUKp5wh/6TtgVHn0rJ6YamX2nG9JghTGbW/IhU0NQeYZKxfj6Z+
         jQ/42m9J5qAhvGPffl+HjRauVAydH592pqMmHIWd+h9WXnBwx2gRslyjY8R6tgBukE99
         ttDI7VYAbd37NmM3OwRP/+0GgrNHNk1k2YN1SirFZRAZpRkX31NwkzWrv7k1ITvoL9J8
         gxMO06HswbRTyVYa5k9WBQBWFK/w3Mjsw+9i7G51HhzPwxq2TUpfoYJHGMzADM9knJvG
         Jdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+EZS+0iqfqUdZXX+nBYUo2f3rJ8zcuppXhxUZFI276Q=;
        b=aEXKKAR1jLGKjxVcIG3+wpyv3ZxvgISvLVzvCmdf3VqV1CG4egCw+XznbQ1GMcwGBX
         k7zLA6ZjTzj9dHQBfJ5R31sVttY7DeGyUmA65H0/HMk8VwfqRKhsgybzqwIZjAffZ/ss
         O4K3Hrhapc9iZHqKVLrQAULSwnvM3W3Bhy19PFwlGW+5Ls9QuFZ7xL+6euMe0O/JJ8v6
         GuYpp5AKt7QKJJnJNPgd4MS7ZTuDwLulQHLC11zsmop4EJxrqcc2KBYDIb37+44syFuF
         esKZzWO5yo9Py+Hu7alnPGyPzqTL/sDA3C9echlhaNzTCI6/J+lg5OKMzN4G7eRUCRul
         lxgQ==
X-Gm-Message-State: AOAM530FBGJ/Ya5qcmTPOE9miPKS2XbsECtcjOTiXg8zDKsSQY5ynF/b
        o3X5VC7cmJc/DY+xmGVmzj+mIP/2wq8TlYStsWD3
X-Google-Smtp-Source: ABdhPJzvCHA1ZjK/3oWRSD6PXAn/6DCB5Iy7ob72rKI7wxPZw4nnZs8AMVYpthVIppQDIWHUiDPJiqLqrFH46Wl539wU
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a62:8cd2:0:b029:163:b01f:405d with
 SMTP id m201-20020a628cd20000b0290163b01f405dmr6393394pfd.48.1604006645097;
 Thu, 29 Oct 2020 14:24:05 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:23:35 -0700
In-Reply-To: <20201029212336.3283410-1-danielwinkler@google.com>
Message-Id: <20201029141832.Bluez.v5.10.I2884e6456c272dadb3d70a629674027f23b0393e@changeid>
Mime-Version: 1.0
References: <20201029212336.3283410-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v5 10/10] monitor: Add new MGMT adv commands and events
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

Changes in v5: None
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
2.29.1.341.ge80a0c044ae-goog

