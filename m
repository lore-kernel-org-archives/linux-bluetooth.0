Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E278DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C251F20738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BC9XyHOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbgFVXlK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730736AbgFVXlI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 19:41:08 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C7EC061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:41:06 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u8so639986pje.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mnI2T0XAuyMCxizpaBmW1IsSXotQkg/aoyLe10cJIoU=;
        b=BC9XyHOdSbhDCQ9+FqEIr10E7ZgJGlaecn6TShzLSBM1eGijWOQ+AJUZTclWxguCTN
         sA3R6l1fOpjuP1XuxZyAR1WmuUsAgYj1GBDvfW4GrfB3l3J2AFXV+DidlCRRU9pClz0K
         DOusv6QGew4ezG9Q4Ia69jQtkuuQNxBI9pfJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mnI2T0XAuyMCxizpaBmW1IsSXotQkg/aoyLe10cJIoU=;
        b=S2/TKfYYedIr49znO4oxQOOX7rsHJuKcAOVNns0cWaPtYPPZupfh0+UTEii3dHbaqi
         7DE0eM0kW6UuDgjqfyc0yGElHvwRT1ddMQZxvudpsQSbHg3s886cVQ/XLUvIfJsrBgeP
         m8T38yNbHhol4U3N4RkQK/KmdAvdvRYnwKfM+4dmus6ecQYH+6OyvZHVeLknWndybuWc
         WqKQsq15kos5KelR9o1o7qlBHQ3YHr0aTvGcb4JgPZ4fwLlQ5ONlR1wClz9u2nhZhvJi
         PH1HfB9Hw1pFzi7wHuEQINIlCieZLc8Z04RUXD7FhvLJD7KoHn4YKqzKBGMvbsZKqPDD
         y/+Q==
X-Gm-Message-State: AOAM533h/E+3Odvfgt1TjIbI5Os5nBLvQJI7AcDpBChGmVZRmeTi7j6Z
        0hUmNgmEWJ31TyW3IHHZqrK0Pw==
X-Google-Smtp-Source: ABdhPJzi0TSOKOrrbTLL/wm6JPG9JCdybTZz+amfcdcULsioYDjooYia/B3vyimpZoGD9Cr82iABpw==
X-Received: by 2002:a17:90b:3690:: with SMTP id mj16mr20755286pjb.104.1592869266366;
        Mon, 22 Jun 2020 16:41:06 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w22sm15049500pfq.193.2020.06.22.16.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 16:41:05 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v5 1/6] mgmt: Add mgmt op and events for device flags
Date:   Mon, 22 Jun 2020 16:40:46 -0700
Message-Id: <20200622164003.BlueZ.v5.1.I3a6c238b09e1a0fad69e69cc2e6f4063af989b37@changeid>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200622234051.206800-1-abhishekpandit@chromium.org>
References: <20200622234051.206800-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add Get Device Flags, Set Device Flags and Device Flags Changed.

---

Changes in v5:
- Use device_flags mgmt op

Changes in v4: None
Changes in v3: None
Changes in v2: None

 lib/mgmt.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index fad1f3dfe..525c4dd62 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -654,6 +654,27 @@ struct mgmt_cp_set_default_runtime_config {
 	uint8_t parameters[0]; /* mgmt_tlv */
 } __packed;
 
+#define MGMT_OP_GET_DEVICE_FLAGS	0x004F
+#define MGMT_GET_DEVICE_FLAGS_SIZE	7
+struct mgmt_cp_get_device_flags {
+	struct mgmt_addr_info addr;
+} __packed;
+struct mgmt_rp_get_device_flags {
+	struct mgmt_addr_info addr;
+	uint32_t supported_flags;
+	uint32_t current_flags;
+} __packed;
+
+#define MGMT_OP_SET_DEVICE_FLAGS	0x0050
+#define MGMT_SET_DEVICE_FLAGS_SIZE	11
+struct mgmt_cp_set_device_flags {
+	struct mgmt_addr_info addr;
+	uint32_t current_flags;
+} __packed;
+struct mgmt_rp_set_device_flags {
+	struct mgmt_addr_info addr;
+} __packed;
+
 #define MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS	(1 << 0)
 
 #define MGMT_OP_READ_ADV_MONITOR_FEATURES	0x0051
@@ -919,6 +940,13 @@ struct mgmt_ev_exp_feature_changed {
 	uint32_t flags;
 } __packed;
 
+#define MGMT_EV_DEVICE_FLAGS_CHANGED		0x002a
+struct mgmt_ev_device_flags_changed {
+	struct mgmt_addr_info addr;
+	uint32_t supported_flags;
+	uint32_t current_flags;
+} __packed;
+
 #define MGMT_EV_ADV_MONITOR_ADDED	0x002b
 struct mgmt_ev_adv_monitor_added {
 	uint16_t monitor_handle;
@@ -1007,6 +1035,8 @@ static const char *mgmt_op[] = {
 	"Set Experimental Feature",
 	"Read Default System Configuration",
 	"Set Default System Configuration",
+	"Get Device Flags",
+	"Set Device Flags",				/* 0x0050 */
 	"Read Advertisement Monitor Features",
 	"Add Advertisement Patterns Monitor",
 	"Remove Advertisement Monitor",
@@ -1053,6 +1083,7 @@ static const char *mgmt_ev[] = {
 	"Extended Controller Information Changed",
 	"PHY Configuration Changed",
 	"Experimental Feature Changed",
+	"Device Flags Changed",
 	"Advertisement Monitor Added",			/* 0x002b */
 	"Advertisement Monitor Removed",
 };
-- 
2.27.0.111.gc72c7da667-goog

