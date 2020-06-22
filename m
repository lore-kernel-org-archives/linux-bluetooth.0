Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30713C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1200120738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PpKcz1x8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgFVXlK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbgFVXlI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 19:41:08 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AFCC061795
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:41:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h22so695842pjf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPhbF6HE3nQ5MGpsYDhrbUUMEcb/RIPepByvehJkX9I=;
        b=PpKcz1x8l/+Y3YI6LC5VdIzAB2zSaFHY8g2Q6NWHaf5BVRuCUkgboOxw2eh9aEh2d3
         oacmSOjejUejxhm9hWenB5lV4+NHZz2m+gTe26M6r/T9ZDipxwclNNcrwExrpab7tXqI
         /NnDHymfBHPsankHvyS55Qu2E1CDw11t6WajA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPhbF6HE3nQ5MGpsYDhrbUUMEcb/RIPepByvehJkX9I=;
        b=L8yoJcuj/R5n0lhGk7YfvhRWUI0sIUWtzIv2gsp0eQZWsY9Ws9Q9lxIVDUUmO71Ktu
         lk0YgbJkIlYPm2IDT9A+ROn7PQgXR+TiwAJYQP2METdBIOtzK+QiPNC1yLs/QFxqvuH2
         LBVzaRIIJ9eMCe+eiqqF43N69rS7oXixG6DtTVkgkI4exB9vtDAdhYj+fa5Fkv1nYW1q
         vLB3xBnl4RQF933Q0PKv0ippgadR+pZW4JZsmWrrnMfntZZQ5gqc14tmb7XokMYzvXPi
         AYG57SaviUTCxy8PCsYcoYVAnOii4px/bnzmdpyL3y7z5tTVpcd0vufegRuNs3YaYKlY
         71Gg==
X-Gm-Message-State: AOAM531HJBFfyc2j4Dxg1A8Yjma40yS4aW26rMUg5pLKYgOY8RkF8E6G
        dY3MFOw4KPD5nhgYZ8N2jVNC0g==
X-Google-Smtp-Source: ABdhPJy0mqtJJEBz8APB2cixJA8Z360H6EOeOWX0w5LIczVaCnKFweL5e3vnIY0B1ZAi9icxg8cM9w==
X-Received: by 2002:a17:902:8694:: with SMTP id g20mr21650335plo.332.1592869267483;
        Mon, 22 Jun 2020 16:41:07 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w22sm15049500pfq.193.2020.06.22.16.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 16:41:06 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v5 2/6] monitor: Decode device flags mgmt ops and event
Date:   Mon, 22 Jun 2020 16:40:47 -0700
Message-Id: <20200622164003.BlueZ.v5.2.Ieac700ddea68a19e8c3dc53528f686482076a77a@changeid>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200622234051.206800-1-abhishekpandit@chromium.org>
References: <20200622234051.206800-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for Get Device Flags and Set Device Flags mgmt operations
and Device Flags Changed mgmt event.

Sample trace:
@ MGMT Command: Set Device Flags (0x0050) plen 11     {0x0002} [hci0]
        LE Address: CD:F3:CD:13:C5:91 (Static)
        Current Flags: 0x00000000
@ MGMT Event: Device Flags Changed (0x002a) plen 15   {0x0001} [hci0]
        LE Address: CD:F3:CD:13:C5:91 (Static)
        Supported Flags: 0x00000001
          Remote Wakeup
        Current Flags: 0x00000000
@ MGMT Event: Device Flags Changed (0x002a) plen 15   {0x0004} [hci0]
        LE Address: CD:F3:CD:13:C5:91 (Static)
        Supported Flags: 0x00000001
          Remote Wakeup
        Current Flags: 0x00000000
@ MGMT Event: Device Flags Changed (0x002a) plen 15   {0x0003} [hci0]
        LE Address: CD:F3:CD:13:C5:91 (Static)
        Supported Flags: 0x00000001
          Remote Wakeup
        Current Flags: 0x00000000
@ MGMT Event: Command Complete (0x0001) plen 10       {0x0002} [hci0]
      Set Device Flags (0x0050) plen 7
        Status: Success (0x00)
        LE Address: CD:F3:CD:13:C5:91 (Static)

---

Changes in v5:
* Decode device flags

Changes in v4: None
Changes in v3: None
Changes in v2: None

 monitor/packet.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 3b9c06512..6280dfff0 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -100,6 +100,7 @@
 #define COLOR_UNKNOWN_EXP_FEATURE_FLAG	COLOR_WHITE_BG
 #define COLOR_UNKNOWN_ADV_FLAG		COLOR_WHITE_BG
 #define COLOR_UNKNOWN_PHY		COLOR_WHITE_BG
+#define COLOR_UNKNOWN_ADDED_DEVICE_FLAG	COLOR_WHITE_BG
 
 #define COLOR_PHY_PACKET		COLOR_BLUE
 
@@ -13099,6 +13100,54 @@ static void mgmt_set_exp_feature_rsp(const void *data, uint16_t size)
 	mgmt_print_exp_feature(data);
 }
 
+static const struct bitfield_data mgmt_added_device_flags_table[] = {
+	{ 0, "Remote Wakeup"	},
+	{ }
+};
+
+static void mgmt_print_added_device_flags(char *label, uint32_t flags)
+{
+	uint32_t mask;
+
+	print_field("%s: 0x%8.8x", label, flags);
+	mask = print_bitfield(2, flags, mgmt_added_device_flags_table);
+	if (mask)
+		print_text(COLOR_UNKNOWN_ADDED_DEVICE_FLAG,
+			   "  Unknown Flags (0x%8.8x)", mask);
+}
+
+static void mgmt_get_device_flags_cmd(const void *data, uint16_t size)
+{
+	uint8_t type = get_u8(data + 6);
+	mgmt_print_address(data, type);
+}
+
+static void mgmt_get_device_flags_rsp(const void *data, uint16_t size)
+{
+	uint8_t type = get_u8(data + 6);
+	uint32_t supported_flags = get_le32(data + 7);
+	uint32_t current_flags = get_le32(data + 11);
+
+	mgmt_print_address(data, type);
+	mgmt_print_added_device_flags("Supported Flags", supported_flags);
+	mgmt_print_added_device_flags("Current Flags", current_flags);
+}
+
+static void mgmt_set_device_flags_cmd(const void *data, uint16_t size)
+{
+	uint8_t type = get_u8(data + 6);
+	uint32_t current_flags = get_le32(data + 7);
+
+	mgmt_print_address(data, type);
+	mgmt_print_added_device_flags("Current Flags", current_flags);
+}
+
+static void mgmt_set_device_flags_rsp(const void *data, uint16_t size)
+{
+	uint8_t type = get_u8(data + 6);
+	mgmt_print_address(data, type);
+}
+
 struct mgmt_data {
 	uint16_t opcode;
 	const char *str;
@@ -13324,6 +13373,12 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x004a, "Set Experimental Feature",
 				mgmt_set_exp_feature_cmd, 17, true,
 				mgmt_set_exp_feature_rsp, 20, true },
+	{ 0x004f, "Get Device Flags",
+				mgmt_get_device_flags_cmd, 7, true,
+				mgmt_get_device_flags_rsp, 15, true},
+	{ 0x0050, "Set Device Flags",
+				mgmt_set_device_flags_cmd, 11, true,
+				mgmt_set_device_flags_rsp, 7, true},
 	{ }
 };
 
@@ -13714,6 +13769,17 @@ static void mgmt_exp_feature_changed_evt(const void *data, uint16_t size)
 	mgmt_print_exp_feature(data);
 }
 
+static void mgmt_device_flags_changed_evt(const void *data, uint16_t size)
+{
+	uint8_t type = get_u8(data + 6);
+	uint32_t supported_flags = get_le32(data + 7);
+	uint32_t current_flags = get_le32(data + 11);
+
+	mgmt_print_address(data, type);
+	mgmt_print_added_device_flags("Supported Flags", supported_flags);
+	mgmt_print_added_device_flags("Current Flags", current_flags);
+}
+
 static const struct mgmt_data mgmt_event_table[] = {
 	{ 0x0001, "Command Complete",
 			mgmt_command_complete_evt, 3, false },
@@ -13793,6 +13859,8 @@ static const struct mgmt_data mgmt_event_table[] = {
 			mgmt_phy_changed_evt, 4, true },
 	{ 0x0027, "Experimental Feature Changed",
 			mgmt_exp_feature_changed_evt, 20, true },
+	{ 0x002a, "Device Flags Changed",
+			mgmt_device_flags_changed_evt, 15, true },
 	{ }
 };
 
-- 
2.27.0.111.gc72c7da667-goog

