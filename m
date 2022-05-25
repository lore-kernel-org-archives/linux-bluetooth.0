Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FC0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 May 2022 10:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiEYKuf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 May 2022 06:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiEYKue (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 May 2022 06:50:34 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F029588
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 03:50:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w3so11604366plp.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 03:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=onOqx5Fpa2xZe+G9sIa3BkOaz4cWIfCQZPOA6oQs8qQ=;
        b=IXjmgcxbc3bJEpVVSy61Wg++pKXd1UxYPK5nb3b32bZr0DdFpECl/JlkkUrXVaqphj
         bQgqIp5tJzyKepiEvh4Z46KDO50ksv0+6M7dtWO5dpMRQ9CGE+Ia4hhQ5TvTWlLRPUGA
         0PFAR/egqCHVisyZEmKiMEPfh9h/cGoPOST3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=onOqx5Fpa2xZe+G9sIa3BkOaz4cWIfCQZPOA6oQs8qQ=;
        b=RT43/dOhWoT8CW6D5YNmtYNOzSx8wECAvg0XzYATLN7lQAg1qI28c40vlWssqFLBZZ
         rRW8LdqUVEBjVamcJ0avWFcUOPTPO+6FG4tYlLe0VqUd6nhCYgvAceZOPa4Lo023muh+
         DMuRuxyxxkUAsAuW4v/Pktvq7GB24GrbyRzDUAjiy+E9Hc//UYa5wjZ3QfCtGMc+Ir+n
         yTmxdJctH4ofuLO6jf9mV7zO3Ds70e/eUaEmB6G3opjmuCZ5o+N2znSsPBIcvxickIl2
         8LEMrWCgmbMGMmL7h9JZdbqxLU5hnIPuN4yR+z8MN1JxTDkq54rQ+bfmC8XisYeAwNpj
         yLdg==
X-Gm-Message-State: AOAM530M28N2bJEu64HVoazd1fuCTQlIb36UVky/Xp2STPEpVAeH7f4m
        UFRz0JzX/Z5vn53a6koCbQXHu8g04HdJqQ==
X-Google-Smtp-Source: ABdhPJyIuPbuEoAuj7fuILItknDj/1+k5q1PUwS2a/lAfjI5EMPsIFo5iazQOcE2BizlKs3WfI8MLA==
X-Received: by 2002:a17:902:ec8a:b0:161:7ca5:eced with SMTP id x10-20020a170902ec8a00b001617ca5ecedmr32292930plg.17.1653475831440;
        Wed, 25 May 2022 03:50:31 -0700 (PDT)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id a13-20020a17090abe0d00b001cd4989feebsm1203709pjs.55.2022.05.25.03.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 03:50:31 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v5 2/8] lib: Add structures and constants for quality report command and event
Date:   Wed, 25 May 2022 18:50:09 +0800
Message-Id: <20220525105015.2315987-2-josephsih@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220525105015.2315987-1-josephsih@chromium.org>
References: <20220525105015.2315987-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the new MGMT struct and constants to lib/mgmt.h.

---

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

