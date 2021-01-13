Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D55EC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14623233E2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbhAMJuj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbhAMJui (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jan 2021 04:50:38 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3844EC0617A2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 01:49:51 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id u17so858845qku.17
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 01:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=69dxCVVjaN2iiNcGWmlNnDuTGnT+BWOF10dDA+3unhM=;
        b=ed//6u0+lrTsOPQA7ZBkbadBC+wTQSoQkUWXLOGngXMD4Z/KkFIqnxx+Y0LysKVGA8
         Y1H4igBdxAW/kg6GFzq1nn71j6kXoIhPUjoHpOB5xUI7UOU7yni4Mp/mIsWVPUgtM1S0
         AJfQqNJes8pECpOvHfNwPmQ0anSzE+fgmg0KNbUFBlQBdMaA3jxNYVvhyDXojNv3hkzj
         zzOcKznyLHoY58X/tr0XW4f0sy11frqQC7FEX6Umdltw+NdfadHqYmaUWJYBq4eydpoQ
         u/Tpg0uRIDN+qsnNreCmCjo7szlKi4Db67/sCR49jwgQpzesS++DHp20XMidTt4Rzm/1
         DW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=69dxCVVjaN2iiNcGWmlNnDuTGnT+BWOF10dDA+3unhM=;
        b=kKZnmfdNCR/xP3dgdAum2tBas7JcwvauMiXHn3t5P9H+++3tmust060H1FIGn3rGg0
         D9W0mufMEDerA6Em/zYAZTOD5NgEkg7Wq4C9fuRIIybYhPIu1PbF0sr8qcx4x/fcH7Ng
         8/ZYnXOT2xtE9JQYgJaVRHGwwJUNXYEJXRuiwzf5MZhCVIF3sZMykVNTsRrfhd2OZouc
         LjBnjvzOnqqjcEWNJ5hWskdbp+fRo+uniFKDX8mSGo0bAwXhRvDVaGZF33nypx5KJoca
         lWVs9ZOJzWreNbsMvWw0tIR3r0XxQjan3L46vv8L9ePjdiyaI8+6+nlS575DXdQQ+tXu
         WWQg==
X-Gm-Message-State: AOAM533+d6zNvRHvszp0Mu3EbumQAC4dm8KBUTZzJKg/4e+L2tS92SZZ
        oGRWVpAxN74Ws1qMfugYly7QazlC4qI+Y4QWrnyLyA7Nx2yIrDyFidEYCDUuujuLlpYR3lKSvnx
        TGb4KgfxZRY6DQF5aJ1BHhkCvRLmSIjIopXP2oMeXg56AFq3x7MNJV9WgVtFtJUFGh7odGodML9
        Sq
X-Google-Smtp-Source: ABdhPJyvlxzXyyRf7C4W8Fp6BFIl2Qp2VsZ8Q8/ugpbH6nMI3LmhjbwNn1KiizqJEsOfPCPA6d85q+nZOcGc
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a0c:ea34:: with SMTP id
 t20mr1387149qvp.5.1610531390331; Wed, 13 Jan 2021 01:49:50 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:49:05 +0800
In-Reply-To: <20210113094905.2787919-1-apusaka@google.com>
Message-Id: <20210113174829.Bluez.v2.5.I0777ec8d6a8874f4d0308d1568aac8c33b04803c@changeid>
Mime-Version: 1.0
References: <20210113094905.2787919-1-apusaka@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [Bluez PATCH v2 5/5] monitor: Decode add advmon with RSSI parameter
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Add support for MGMT command of add advertisement monitor with RSSI
parameter (0x0056).

@ MGMT Command: Add Advertisement.. (0x0056) plen 76  {0x0003}
        RSSI data:
          high threshold: 1 dBm
          high timeout: 0 seconds
          low threshold: -2 dBm
          low timeout: 3 seconds
          sampling: just once (0xFF)
        Number of patterns: 2
          Pattern 1:
            AD type: 0
            Offset: 1
            Length: 2
            Value : c504
          Pattern 2:
            AD type: 255
            Offset: 10
            Length: 4
            Value : 9a55beef

Reviewed-by: Yun-Hao Chung <howardchung@google.com>
---

(no changes since v1)

 monitor/packet.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index c91b91e2b2..fcd698d92a 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13261,18 +13261,22 @@ static void mgmt_print_adv_monitor_patterns(const void *data, uint8_t len)
 
 	/* Reference: struct mgmt_adv_pattern in lib/mgmt.h. */
 	while (data_idx + 34 <= len) {
-		uint8_t ad_type = get_u8(data + data_idx);
-		uint8_t offset = get_u8(data + data_idx + 1);
-		uint8_t length = get_u8(data + data_idx + 2);
+		uint8_t ad_type = get_u8(data);
+		uint8_t offset = get_u8(data + 1);
+		uint8_t length = get_u8(data + 2);
 
 		print_field("  Pattern %d:", pattern_idx);
 		print_field("    AD type: %d", ad_type);
 		print_field("    Offset: %d", offset);
 		print_field("    Length: %d", length);
-		print_hex_field("    Value ", data + data_idx + 3, 31);
+		if (length <= 31)
+			print_hex_field("    Value ", data + 3, length);
+		else
+			print_text(COLOR_ERROR, "    invalid length");
 
 		pattern_idx += 1;
 		data_idx += 34;
+		data += 34;
 	}
 }
 
@@ -13284,6 +13288,33 @@ static void mgmt_add_adv_monitor_patterns_cmd(const void *data, uint16_t size)
 	mgmt_print_adv_monitor_patterns(data + 1, size - 1);
 }
 
+static void mgmt_add_adv_monitor_patterns_rssi_cmd(const void *data,
+								uint16_t size)
+{
+	int8_t high_rssi = get_s8(data);
+	uint16_t high_rssi_timeout = get_le16(data + 1);
+	int8_t low_rssi = get_s8(data + 3);
+	uint16_t low_rssi_timeout = get_le16(data + 4);
+	uint8_t sampling_period = get_u8(data + 6);
+	uint8_t pattern_count = get_u8(data + 7);
+
+	print_field("RSSI data:");
+	print_field("  high threshold: %d dBm", high_rssi);
+	print_field("  high timeout: %d seconds", high_rssi_timeout);
+	print_field("  low threshold: %d dBm", low_rssi);
+	print_field("  low timeout: %d seconds", low_rssi_timeout);
+
+	if (sampling_period == 0)
+		print_field("  sampling: propagate all (0x00)");
+	else if (sampling_period == 0xff)
+		print_field("  sampling: just once (0xFF)");
+	else
+		print_field("  sampling: every %d ms", 100 * sampling_period);
+
+	print_field("Number of patterns: %d", pattern_count);
+	mgmt_print_adv_monitor_patterns(data + 8, size - 8);
+}
+
 static void mgmt_add_adv_monitor_patterns_rsp(const void *data, uint16_t size)
 {
 	uint16_t handle = get_le16(data);
@@ -13553,6 +13584,10 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x0055, "Add Ext Adv Data",
 				mgmt_add_ext_adv_data_cmd, 3, false,
 				mgmt_add_ext_adv_data_rsp, 1, true },
+	{ 0x0056, "Add Advertisement Monitor With RSSI",
+				mgmt_add_adv_monitor_patterns_rssi_cmd, 8,
+									false,
+				mgmt_add_adv_monitor_patterns_rsp, 2, true},
 	{ }
 };
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

