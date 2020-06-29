Return-Path: <SRS0=UgXA=AK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46A1C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 23:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C310A206C3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 23:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OdlZXXlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgF2XCc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbgF2XCc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jun 2020 19:02:32 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF205C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 16:02:30 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f2so7676191plr.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 16:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hVvbR6QNmm9waRXWyOSgJ2bOxzhCSL1WQfugry/sT1M=;
        b=OdlZXXlpH60q8YZ2HvMJwooRdB3Ii0i6U6vjOq80mwOHGVPscEInyvFXIAwxvSVw+u
         SfhlJvyRcvTtqm+qeiXfL3yN9Q1NMOk5mOtMbf+v9clB9rYTWj2F5lGksSFWK//S8B7G
         kALSku8/1iJ+6sRKujEzG0tGBUhkCt2XUtup8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hVvbR6QNmm9waRXWyOSgJ2bOxzhCSL1WQfugry/sT1M=;
        b=Cb1hEmDaljgdSr/kcjpJc/Gp1GFVreLOf2ikvtM7QfjvLL/SGMrDrsRwj8IAle1zzX
         u2pH1n19lg64a4XJlSSn2/gsB1NSJmsU4kSCLeYIHRATdzH/UK6KqAZQz/6doVuzmlKg
         H93dfBd6hpFtzXKW8/Wtx/eCUdBttJyWFaq1Iy3X/rf4Bymz+GtYpGqgPMWix1NjIglu
         GGyecVaamKVgPndrhFO8NV9x3/QRlzaO1/qc0feinp3O8H0ZsF7PkEbb3fVHWE2veRLW
         FLMmpZwd73QZeWZvVLF70W9LDAmfm53kNTp6pk4gu7ey4aOFv7meM8zXqkFCoVmr6cQi
         JOGg==
X-Gm-Message-State: AOAM530r67vGXxyP0+oE+9fTZni7CZqvmBBuaVQ6vUp7W4wKu9Xbh+pB
        vtdnU3zts6Hdi5mmDm6cc1BLwKWAV/w=
X-Google-Smtp-Source: ABdhPJyRoW8sPk9O/xRH4Y40JiGN7Ikj5uigiYJrumoQ7bj0zHIjnMorSNXXi4FpS0EXN/XaFaViqw==
X-Received: by 2002:a17:902:ff0c:: with SMTP id f12mr15513333plj.254.1593471750394;
        Mon, 29 Jun 2020 16:02:30 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id i13sm467275pjd.33.2020.06.29.16.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 16:02:29 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v6 1/6] mgmt: Add mgmt op and events for device flags
Date:   Mon, 29 Jun 2020 16:02:18 -0700
Message-Id: <20200629160206.BlueZ.v6.1.I3a6c238b09e1a0fad69e69cc2e6f4063af989b37@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200629230223.3538949-1-abhishekpandit@chromium.org>
References: <20200629230223.3538949-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add Get Device Flags, Set Device Flags and Device Flags Changed.

---

Changes in v6: None
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
2.27.0.212.ge8ba1cc988-goog

