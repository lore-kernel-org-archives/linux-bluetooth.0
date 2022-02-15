Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F09C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 13:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbiBONgy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 08:36:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiBONgy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 08:36:54 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E91A65179
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 05:36:44 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z16so13022678pfh.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 05:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b+/YuDBUcvSQNoEcHVaCYlQpUanQiQyBVuqYOJZ6w10=;
        b=NwNJ9xMM9ITUiux8d2if4on42CmEBLcX7oqL7YfHU3q52YQx8m0xR1ef2V1FfZLO3S
         TzG+bXXiqEE+xjilFbzf9qeFwZ4M9XvecMax8cxlDU+W8BQ2Mft+oTGteyiqrY1jZJhC
         R5YQzirdXg6M1rOMFiCrTS8WfEqNxR65oiOS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b+/YuDBUcvSQNoEcHVaCYlQpUanQiQyBVuqYOJZ6w10=;
        b=hxUysbzVFgMdBtZ/MhsvBz0PW6BEwyPa8E8Oqh4KmJf0VmYFvkJfhNHtFVW5mo5GZ8
         pghS7sYE49fqTP6U3rY73QuLQBAVagU2lXJAw/Ch4LxDjuAqV7QbIyYiu/FpkkptJSxK
         T9PfM87EsF/Al6YepYz9DQ/z/QblM9/+VzBzfXOKmJjFbLfDbGUhj7bJhrJrnPGQH42C
         Y0mqvPAyVuPTWk5tlIHhk7o9hWxDN6zV9OBxsvasIbyLVob3nxZR/NRVHK2wZdCm9YZZ
         LfWfd8EUVSrfHp5qsDA59louDablQCl7SiYITg4LlBY3EsoFctcBnD5V3sGaFGNfnlgj
         s7xA==
X-Gm-Message-State: AOAM5312gh79KEcvdjutLIFpQLYuPGSwafHOKVv521ydfnEjDZEXzUYx
        pt/nBXkbjxMrzKM3QJqeclpvm6vIkbwO1g==
X-Google-Smtp-Source: ABdhPJyRnAZ3LaTpo76pqRHugCJmvk0OyYhq3l5e1ACrx0zgmpP99Xt7zY94rc5a9EaySPwu0WfgAg==
X-Received: by 2002:a05:6a00:228e:: with SMTP id f14mr4476374pfe.33.1644932203660;
        Tue, 15 Feb 2022 05:36:43 -0800 (PST)
Received: from localhost (208.158.221.35.bc.googleusercontent.com. [35.221.158.208])
        by smtp.gmail.com with UTF8SMTPSA id bg9sm5932351pjb.46.2022.02.15.05.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 05:36:43 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v4 2/8] lib: Add structures and constants for quality report command and event
Date:   Tue, 15 Feb 2022 21:36:30 +0800
Message-Id: <20220215133636.2827039-2-josephsih@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220215133636.2827039-1-josephsih@chromium.org>
References: <20220215133636.2827039-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the new MGMT struct and constants to lib/mgmt.h.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

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
index 922a24367..c7a2a7868 100644
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
+	uint8_t action;
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
+	uint8_t data[];
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
2.35.1.265.g69c8d7142f-goog

