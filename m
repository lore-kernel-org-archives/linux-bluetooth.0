Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 09:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiBIJZc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:25:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiBIJZb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 04:25:31 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D118C094CAA
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 01:25:26 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d187so3191205pfa.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 01:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qW1SUmdDnvNIzHcgBGusXb1sIBN2gf/ZGCzEYdsEAfc=;
        b=MWmD2AfhTv3A9VTNplgDSqlug7tyqFypWaK7cntCV/fcPL2fxT8GTklLl6I64rgn/5
         hlzZPrj7u53g4PJAQ3QSMj5KASh5El1nam1uMlF9UkBjh/SAI4RZNTLRw1rp9I/I/cOY
         yZXZDR0Jyx+jHDkpKoRqWZDFy2jGbNpLimRqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qW1SUmdDnvNIzHcgBGusXb1sIBN2gf/ZGCzEYdsEAfc=;
        b=RnhGKxuMSaSyuVQeo0+UOo23wAoPUJX9DzxsY9xRtg8BHrkCQirRLhhDIIrH2HmC4M
         cX3gZLHwar50Y/Mofv0zl/4EH9kBdNB3xPU3tWqq8x/XWfwlGr8Yttu8mQXMhpkPSHhK
         3z0RYpoNi0sO8iRSTy5/hm0mhEIkwgp+Xqsh2/u0Sdc7iFO4U4uK9hRnJpjLycti3SAC
         ZhUmbiTeIgt6mDU7fOHRGQEQaoOMZLVfNvqzjDIpLBejFoxuW/4g4JS9vH5Sp6TbgGr3
         M/pLSVBFewpzyYLEcadbBIaRR2wgWUn4uEuOEzkouxwXeQkaJyo1xNKjl2HpVHKHD+vt
         7LBQ==
X-Gm-Message-State: AOAM5302ecPbs4FMgJKTpwf+Z7Y6epaxrFS/m+v3OogV9gpSf6T5uGMq
        PkfPPEk4z8D5kKv5ecKF0yA1zTYJynLgZg==
X-Google-Smtp-Source: ABdhPJwT03DkEFOouYisawmJK/39DlzXmBtZC2FM5AAol+wZFu9q2UAtx2jKuASZgBNppB2hg4gU0w==
X-Received: by 2002:a63:8ac2:: with SMTP id y185mr1181395pgd.608.1644398664316;
        Wed, 09 Feb 2022 01:24:24 -0800 (PST)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id 16sm5437731pje.34.2022.02.09.01.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 01:24:23 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v3 2/9] lib: Add structures and constants for quality report event
Date:   Wed,  9 Feb 2022 17:24:07 +0800
Message-Id: <20220209092414.751642-2-josephsih@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220209092414.751642-1-josephsih@chromium.org>
References: <20220209092414.751642-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the new struct and constants to lib/mgmt.h.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v3:
- Swap AOSP Bluetooth Quality Report Event and Intel Telemetry Event.

Changes in v2:
- This is a new patch for adding the new struct and constants.

 lib/mgmt.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 922a24367..db9a24cd6 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -1032,6 +1032,15 @@ struct mgmt_ev_adv_monitor_device_lost {
 	struct mgmt_addr_info addr;
 } __packed;
 
+#define MGMT_EV_QUALITY_REPORT			0x0031
+#define QUALITY_SPEC_AOSP_BQR			0x0
+#define QUALITY_SPEC_INTEL_TELEMETRY		0x1
+struct mgmt_ev_quality_report {
+	uint8_t quality_spec;
+	uint32_t data_len;
+	uint8_t data[];
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -1172,6 +1181,7 @@ static const char *mgmt_ev[] = {
 	"Controller Resume",
 	"Advertisement Monitor Device Found",		/* 0x002f */
 	"Advertisement Monitor Device Lost",
+	"Bluetooth Quality Report",			/* 0x0031 */
 };
 
 static const char *mgmt_status[] = {
-- 
2.35.0.263.gb82422642f-goog

