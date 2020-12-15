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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5689C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 08:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E103222B3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 08:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgLOIfG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 03:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgLOIey (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 03:34:54 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40557C06179C
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 00:34:14 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x21so9861827pff.14
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 00:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nbQS3g+yAVoRtuBXHwiD9CuWwggjm9hbbAVoCzZw1hI=;
        b=cXKPE7KR/Ti+N7+hkYYXoS5uAL3/v2Iv4Wa6XJvDbN2QAFb/2X7/vLRKHgkcJYys41
         ueGIAZmkooht+vsFI+LeizS/59YSie16RfGA/1BtDoJ1OiAVyXIKiobopytBLrSedHAK
         ShaDQ88jAnJEk0bmLJMDqeCD7oaRk0v6IQ/ykds6el878RioabFEcOXxgLEYh+L/lbRz
         ohHDXzrDRbz4AOZ3AqOGHSIVFHLWCvj0nhtwakmiG2odAKUjYu4jMy1ZXXujX315tlpf
         IxnEO8XW7/k2j0Slo8jts38m55pIB1SIMUezHHMi4cmUefwRzGW6znZlw1m3pxmYrvYp
         jJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nbQS3g+yAVoRtuBXHwiD9CuWwggjm9hbbAVoCzZw1hI=;
        b=ndrlGXlTd/TRjB4SbbsKcqMHRdzPJxt1eFsChoYCwAY9xrdW4HDWptgImqEBxfw0vf
         83SX+rqqaZz78F0fwDpH5kFK0ALbcfLkdy9kDt5Nw1xZb1KVSQ9tMl84GkfImxV4My2j
         AbsEGfHajrKm8SqjQ+InLazHqhCzWjfcGtPLSobtq3kKxf4b5HVNbSTKuXsuamLN8DtB
         Z/N/J4LYzbWWuKiiM4N9if9QBXJuhX2vnW/in066ZjB7W76Ff0HgqAkf9Qccak2RiSPl
         Sybr5pRZhB6pTt9ceBW290eFLrw2w+Yt8QUJ9wWLgn2+MdbJKgv0HCeD4Qep5yuxaeBS
         QbTA==
X-Gm-Message-State: AOAM532WU9IJUama2qAw4KWTZTUh2NY1V8GkKkyXgK5YwU9aJfjsAlqy
        kqV5tCsQ2xaJOMgRv1ggpmJutui/3TKveogMrPXzYzMrVAAby7ZTN9LjiWD8+mpvmSW38+sJoGR
        +qyltKeU9ezwmXqOT8cSQWgcL69p0hMRCcfeoFOVG3uyWYe3/V7fpRvJPIbNZLWxoiIHryRZQEd
        CX
X-Google-Smtp-Source: ABdhPJwkUScw6ZgD2p9PP4iHPqqVVl+uL8kg9mweA+BeMvb2ZvgFTyu3mpaUMukEuoGF2ptNW40kMr7NLFVG
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:90a:8b94:: with SMTP id
 z20mr1462987pjn.1.1608021253112; Tue, 15 Dec 2020 00:34:13 -0800 (PST)
Date:   Tue, 15 Dec 2020 16:33:47 +0800
In-Reply-To: <20201215163328.Bluez.v1.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
Message-Id: <20201215163328.Bluez.v1.2.I90bb4b25451e7f726fc2c8771cfe642b16312ce3@changeid>
Mime-Version: 1.0
References: <20201215163328.Bluez.v1.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [Bluez PATCH v1 2/2] lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode.
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

The new op is to utilize RSSI in advertisement monitor

Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@google.com>
---

 lib/mgmt.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index f37f7e6540..1b8fcc0e10 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -738,6 +738,21 @@ struct mgmt_rp_add_ext_adv_data {
 	uint8_t	instance;
 } __packed;
 
+struct mgmt_adv_rssi_thresholds {
+	int8_t   high_threshold;
+	uint16_t high_threshold_timeout;
+	int8_t   low_threshold;
+	uint16_t low_threshold_timeout;
+	uint8_t  sampling_period;
+} __packed;
+
+#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI	0x0056
+struct mgmt_cp_add_adv_patterns_monitor_rssi {
+	uint8_t pattern_count;
+	struct mgmt_adv_rssi_thresholds rssi;
+	struct mgmt_adv_pattern patterns[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
-- 
2.29.2.684.gfbc64c5ab5-goog

