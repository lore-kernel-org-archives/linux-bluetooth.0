Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CE3C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 23:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3100E2075E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 23:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GIu9x6bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHRX2e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgHRX2b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 19:28:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63012C061389
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 16:28:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mt12so242136pjb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 16:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7X+uls88rccAT4N2V4ZR70a3gZiJwbItKIK4d+bIKUQ=;
        b=GIu9x6bcnut8SKqOskUyIQwIVz1Evdzq/+W0XlMxz8JDgRyipB2SlhZrb0pn7xDfMw
         kv11IAwUSEl875nIPXhxIUOBp4ghjxJNPWgeLTDdBp8v3T96Y8w7Xw3i4J13E2m7+tbz
         onGEoAuxQOr/ltOlG/5BfqcoX+F3feNEoH4wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7X+uls88rccAT4N2V4ZR70a3gZiJwbItKIK4d+bIKUQ=;
        b=TJIsbAlhPF/8dp+rN1RCSRlrQh13lKIfqYyvY0oGLRqz7YIAvMW/N40O4CMBBUKAIZ
         1OlT1pbSosTQhUm6ulAxP4HJ+XmY47KRSKP8Q2dIb3joeNanKr+h6lC6kbZJa6S2If9w
         eo05waRfNWUe/D9QzEdngdb8vTUOwKr/rHUUoy26PyCDc2QKOkxtBRT7nj09EHL24P+9
         N5KDMMDcrLy0KpB3IItaOwt1TPzLb7d+fJJl0OtF20/Ujw/6eAYlXW3p8CzfYlU8LX/4
         WOrbXDtzj1GmncEQS77UeQo7xcV2OzsoCeFrOUs35/WfqOfCSJisrEWcGXGBIeTYSAen
         PfNw==
X-Gm-Message-State: AOAM532jQ6kBGzMlTVDMVTsJIO6PrQADiMlqnr3aHhDDimrCzMCd6yLA
        sYj5iBXqi5Vg+O7E9E0hw0ZgFw==
X-Google-Smtp-Source: ABdhPJyiVHMyc5dM1ZclPxVPfbZpltYkdPGrXlxCnwiAMJ5blhdMzN+e6FBXQTNc/RfrgCzYrnQ9BA==
X-Received: by 2002:a17:90a:154e:: with SMTP id y14mr1863601pja.178.1597793310761;
        Tue, 18 Aug 2020 16:28:30 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id 30sm904747pjz.24.2020.08.18.16.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 16:28:30 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [Bluez PATCH v2 2/3] monitor: Add btmon support for Suspend and Resume events
Date:   Tue, 18 Aug 2020 16:28:21 -0700
Message-Id: <20200818162807.Bluez.v2.2.Id78b98210807c1326ee2c187af73a325fc97f1e1@changeid>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200818232822.1645054-1-abhishekpandit@chromium.org>
References: <20200818232822.1645054-1-abhishekpandit@chromium.org>
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
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

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
2.28.0.297.g1956fa8f8d-goog

