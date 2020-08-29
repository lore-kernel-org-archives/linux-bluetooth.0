Return-Path: <SRS0=jcZI=CH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245A9C433E6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Aug 2020 01:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A16207BB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Aug 2020 01:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h8nYGDaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgH2BCa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Aug 2020 21:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgH2BCW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Aug 2020 21:02:22 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EE0C061232
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2020 18:02:21 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p15so431301pli.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2020 18:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCwx0WjM+Tg/OUIJ0l+mpEQceJ2qn7yAxNpmvP8bdS0=;
        b=h8nYGDaFfEGx5g99mTM6U/CtMtRrpaRC0JKHy1KTPJ5AZCnQcb9uvAB8aIHfyWbbLX
         ws2b/ATWLNCPLq9/6zQaZHCBlBNI0Y+v1QlPI/ZtZPMFEqBrh5aFCPpRt8s7LCrvI9QH
         PCX0Gp2Ycg6FRjliqdKkBYAA5rlL3t4ZwLDXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCwx0WjM+Tg/OUIJ0l+mpEQceJ2qn7yAxNpmvP8bdS0=;
        b=rMSYsEZjCwHzXMDJBZ+oFQzOyER6zd8bsxJZttrMI3HAYYvWerdGnoPmjanCEj9XQy
         5VfC0fagHxmcQtlazRunR4DmEaoiUFPTAHPuwuH/LVi4YhVph8No/lCJiiOcPqtCmyis
         Pg1TJnLtBl8nLZjy+A6dv9qDKfjU4RKt5FZp2yTSD7GORG21PVhGWlsAsscPITdfzmLQ
         8ZIqKZ6wcTIVhf7fW1CROk7/zUeyZ7lCjEnseGEJL3KpVAI7xjFmpnPx4+K1Z2f3DZBn
         TfBsi5epihpbU9ri4QvjEBVMyVW0MJrerom8AZkiyhW/S+y8DTe9OjL9la3BUaEAtxpd
         pV6A==
X-Gm-Message-State: AOAM530AlD+ijEE1QiPxXTMJTskMlw2gENF9KaivPriu31d/T9Ux9iVG
        XBTTlVmRE8LAnSMkbIaL4Sx0GQ==
X-Google-Smtp-Source: ABdhPJxp31rxPdZ7f51B3qg3IoieSzyWo5PQRAG9BHSnCS2oHPHFS3gKXjcsP7gro8npPLhJoyHvvg==
X-Received: by 2002:a17:90a:b00e:: with SMTP id x14mr1232309pjq.203.1598662939741;
        Fri, 28 Aug 2020 18:02:19 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id 78sm630360pfv.200.2020.08.28.18.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 18:02:19 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [Bluez PATCH v3 2/3] monitor: Add btmon support for Suspend and Resume events
Date:   Fri, 28 Aug 2020 18:02:09 -0700
Message-Id: <20200828180157.Bluez.v3.2.Id78b98210807c1326ee2c187af73a325fc97f1e1@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200829010210.871471-1-abhishekpandit@chromium.org>
References: <20200829010210.871471-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support to pretty print Suspend and Resume mgmt events in btmon.

Example:

@ MGMT Event: Controller Suspended (0x002d) plen 1
        Suspend state: Page scanning and/or passive scanning (2)

@ MGMT Event: Controller Resumed (0x002e) plen 8
        Wake reason: Remote wake due to peer device connection (2)
        LE Address: CD:F3:CD:13:C5:9A (OUI CD-F3-CD)

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v3: None
Changes in v2: None

 monitor/packet.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 431a39b66..451630e04 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13555,6 +13555,9 @@ static void mgmt_device_disconnected_evt(const void *data, uint16_t size)
 	case 0x04:
 		str = "Connection terminated due to authentication failure";
 		break;
+	case 0x05:
+		str = "Connection terminated by local host for suspend";
+		break;
 	default:
 		str = "Reserved";
 		break;
@@ -13782,6 +13785,54 @@ static void mgmt_device_flags_changed_evt(const void *data, uint16_t size)
 	mgmt_print_added_device_flags("Current Flags", current_flags);
 }
 
+static void mgmt_controller_suspend_evt(const void *data, uint16_t size)
+{
+	uint8_t state = get_u8(data);
+	char *str;
+
+	switch (state) {
+	case 0x0:
+		str = "Controller running (failed to suspend)";
+		break;
+	case 0x1:
+		str = "Disconnected and not scanning";
+		break;
+	case 0x2:
+		str = "Page scanning and/or passive scanning";
+		break;
+	default:
+		str = "Unknown suspend state";
+		break;
+	}
+
+	print_field("Suspend state: %s (%d)", str, state);
+}
+
+static void mgmt_controller_resume_evt(const void *data, uint16_t size)
+{
+	uint8_t addr_type = get_u8(data + 6);
+	uint8_t wake_reason = get_u8(data + 7);
+	char *str;
+
+	switch (wake_reason) {
+	case 0x0:
+		str = "Resume from non-Bluetooth wake source";
+		break;
+	case 0x1:
+		str = "Wake due to unexpected event";
+		break;
+	case 0x2:
+		str = "Remote wake due to peer device connection";
+		break;
+	default:
+		str = "Unknown wake reason";
+		break;
+	}
+
+	print_field("Wake reason: %s (%d)", str, wake_reason);
+	mgmt_print_address(data, addr_type);
+}
+
 static const struct mgmt_data mgmt_event_table[] = {
 	{ 0x0001, "Command Complete",
 			mgmt_command_complete_evt, 3, false },
@@ -13863,6 +13914,10 @@ static const struct mgmt_data mgmt_event_table[] = {
 			mgmt_exp_feature_changed_evt, 20, true },
 	{ 0x002a, "Device Flags Changed",
 			mgmt_device_flags_changed_evt, 15, true },
+	{ 0x002d, "Controller Suspended",
+			mgmt_controller_suspend_evt, 1, true },
+	{ 0x002e, "Controller Resumed",
+			mgmt_controller_resume_evt, 8, true },
 	{ }
 };
 
-- 
2.28.0.402.g5ffc5be6b7-goog

