Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E15C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jan 2022 10:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbiA0KQ3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jan 2022 05:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238944AbiA0KQ2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jan 2022 05:16:28 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A97C061714
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 02:16:28 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d18so2093643plg.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 02:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQfqUCe52Kc/dWWcenFdwSJogZh4zY4n1Nupyj466uE=;
        b=h2xlW6kSG0RJn9cqixXAmX93/B3ebK15KcU1NzbdvLlETBKdRDtXNDU/dq5rI5K3/u
         FB1TrsiYB9d8LxiEIrg70yMOl0Lsdlq/P9LnmWC83T/gvDd90Cff3F1nTJJim9nBNw4f
         ItPpFubkY4EwQfNqx3Gh/Q+i3j5ELddHhT1js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQfqUCe52Kc/dWWcenFdwSJogZh4zY4n1Nupyj466uE=;
        b=LhAp6wjBMGWgXyET3VPO7wPqdudxiD+xe6T9GKkZWkpHhfoIRlXfmI2jqFBOVMIpej
         FKC7or/tOUcXhirNJYXe2zn53RiNgfjJK9vcEJwJrM852LwFYZuETIlGXoztG7bODYec
         9NiomxK8QB9AWqqZgJZH7NHs0fd0aAKBzKtWKvhFszTRsEilHvWLjfV1pLshc2ns6Myz
         dktWLFPKc9lLqHK+jbhFjJLpS7YfeFN8F3cHal/Df450x1SsSoMJlH3A4ew0CadnHenx
         M2kYgZfhVP375vpQy0tYWe393gifyKCQYgTO8ie1hmRG9eNkoJI3ZGpK3EY8rwbzq4ZE
         iiWw==
X-Gm-Message-State: AOAM530Zv8So7UZ9/hwGIzmWODjFPSKiUAQF6OfNZGpte3FkcjT+YfeB
        WcxTnAdOw7MRkgJv01+OJngWuR/hvkIOzQ==
X-Google-Smtp-Source: ABdhPJz72nTFqUqH8wm4dO+kcEaNuDghqjMgq+sJQ75wKB70jNGlN1Dy0aYS15brzwB9aguPaPQqXQ==
X-Received: by 2002:a17:903:2352:: with SMTP id c18mr3199673plh.104.1643278587720;
        Thu, 27 Jan 2022 02:16:27 -0800 (PST)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id s42sm5475105pfg.146.2022.01.27.02.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 02:16:27 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v2 2/4] lib: Add structures and constants for quality report
Date:   Thu, 27 Jan 2022 18:16:07 +0800
Message-Id: <20220127101609.3646316-2-josephsih@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127101609.3646316-1-josephsih@chromium.org>
References: <20220127101609.3646316-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the new struct and constants to lib/mgmt.h.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v2:
- This is a new patch for adding the new struct and constants.

 lib/mgmt.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 922a24367..92c682a8c 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -1032,6 +1032,16 @@ struct mgmt_ev_adv_monitor_device_lost {
 	struct mgmt_addr_info addr;
 } __packed;
 
+#define MGMT_EV_QUALITY_REPORT			0x0031
+#define QUALITY_SPEC_NA				0x0
+#define QUALITY_SPEC_INTEL_TELEMETRY		0x1
+#define QUALITY_SPEC_AOSP_BQR			0x2
+struct mgmt_ev_quality_report {
+	uint8_t quality_spec;
+	uint32_t report_len;
+	uint8_t report[];
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -1172,6 +1182,7 @@ static const char *mgmt_ev[] = {
 	"Controller Resume",
 	"Advertisement Monitor Device Found",		/* 0x002f */
 	"Advertisement Monitor Device Lost",
+	"Bluetooth Quality Report",			/* 0x0031 */
 };
 
 static const char *mgmt_status[] = {
-- 
2.35.0.rc0.227.g00780c9af4-goog

