Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2738DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 11:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347092AbiEZLZG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 07:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345927AbiEZLZE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 07:25:04 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7E7CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 04:25:04 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c22so1141715pgu.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 04:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3TriAZF2PfVsPnINlTHwFuM9S9AZnTdcYqC1UFJFAXc=;
        b=M89WWL7b2E3m6buRd6RewTNCGrmubDSCSMDtW9heca052jN09flKiSuxdwMKUHxoHO
         X2xMTnkfHQCW6KHYxVof8JUtP1XGhHG+E9bFhQ+VRL6NfaK3HEqO7Dxqff3/6rnFQaVP
         TqXi9LiPIiDLbzg35+/pUjdr2UwuCaKrgUErw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3TriAZF2PfVsPnINlTHwFuM9S9AZnTdcYqC1UFJFAXc=;
        b=N0PgznUuHUb9eeCX6hbphNc3QkTlzpvMgIEikdXKcD45MpGdk0nErahO6mZJb7Ndn8
         amBOG3fZ8irOCKaKxf8gmWByJXy8R5ZnfFsPYbU9G9D6rUkE0xxOOgKqnPK7SshEARr1
         W+vp2dZ8ippm7YAxXr2WAy3OZaD+J9UiznSKCztPJrQQ6MPkVIjERP3zAXYcHRmgMQDw
         Gz6f8eHOFarmst/g1m/ABrR5XnpBgisn64/d+NlVhS1Ny0GF360ShtYI0onq5QQEgg38
         WLYkAHJjcDMUNmNP5938A6yXg+Cam4gp7Ckk5Uo14RQh3leUxNnDObOBijc6ag4F5hk2
         NOmg==
X-Gm-Message-State: AOAM530I8BrDInk6+0j57jkHY/qfY+rAPgwfElSLJR+FXisTUhL5IJO5
        D7ztWJFByS4GUfVQY7ruNwBQpDRbalWS1w==
X-Google-Smtp-Source: ABdhPJxuweiqjemal3OlYRToT5wkfaHHdHfCsrwZJSg7DS57KuG0Jxk8ywvOeUFPtCmelHJw8q421w==
X-Received: by 2002:a63:716:0:b0:3fa:1604:c9ab with SMTP id 22-20020a630716000000b003fa1604c9abmr20722914pgh.518.1653564303438;
        Thu, 26 May 2022 04:25:03 -0700 (PDT)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id d20-20020a056a00199400b0051829b1595dsm1353114pfl.130.2022.05.26.04.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 04:25:03 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v6 2/8] lib: Add structures and constants for quality report command and event
Date:   Thu, 26 May 2022 19:24:50 +0800
Message-Id: <20220526112456.2488536-2-josephsih@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220526112456.2488536-1-josephsih@chromium.org>
References: <20220526112456.2488536-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the new MGMT struct and constants to lib/mgmt.h.

---

(no changes since v5)

Changes in v5:
- Use quality_report instead of action in struct
  mgmt_cp_set_quality_report.
- Declare "const uint8_t data[];"

Changes in v4:
- Combine both MGMT command and event changes in a single patch.
- Fix namings of QUALITY_SPEC_AOSP and QUALITY_SPEC_INTEL.
- Use "Quality Report" without the prefix "Bluetooth".

Changes in v3:
- Swap AOSP Bluetooth Quality Report Event and Intel Telemetry Event.

Changes in v2:
- This is a new patch for adding the new struct and constants.

 lib/mgmt.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 922a24367..fd59ef6fa 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -96,6 +96,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
 #define MGMT_SETTING_PHY_CONFIGURATION	0x00010000
 #define MGMT_SETTING_WIDEBAND_SPEECH	0x00020000
+#define MGMT_SETTING_QUALITY_REPORT	0x00040000
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
@@ -757,6 +758,14 @@ struct mgmt_cp_add_adv_patterns_monitor_rssi {
 	struct mgmt_adv_pattern patterns[0];
 } __packed;
 
+#define MGMT_OP_SET_QUALITY_REPORT		0x0057
+struct mgmt_cp_set_quality_report {
+	uint8_t quality_report;
+} __packed;
+struct mgmt_rp_set_quality_report {
+	uint32_t current_settings;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -1032,6 +1041,15 @@ struct mgmt_ev_adv_monitor_device_lost {
 	struct mgmt_addr_info addr;
 } __packed;
 
+#define MGMT_EV_QUALITY_REPORT			0x0031
+#define QUALITY_SPEC_AOSP			0x0
+#define QUALITY_SPEC_INTEL			0x1
+struct mgmt_ev_quality_report {
+	uint8_t quality_spec;
+	uint32_t data_len;
+	const uint8_t data[];
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -1172,6 +1190,7 @@ static const char *mgmt_ev[] = {
 	"Controller Resume",
 	"Advertisement Monitor Device Found",		/* 0x002f */
 	"Advertisement Monitor Device Lost",
+	"Quality Report",				/* 0x0031 */
 };
 
 static const char *mgmt_status[] = {
-- 
2.36.1.124.g0e6072fb45-goog

