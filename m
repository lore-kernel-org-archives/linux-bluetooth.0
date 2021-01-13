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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDF8C433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B66F2339F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbhAMJ0s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbhAMJ0s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jan 2021 04:26:48 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273A4C061786
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 01:26:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v187so249949ybv.21
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 01:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SRa8dd5e37oxGYqqIqTF7B45ms6xLoBbhxXPvy7fdvc=;
        b=pURfbiieIZRKg81fdGT9egNRU/h09Itwt/ALFhqTaKXUNcq4Z7fKWJkVSzSRR+OBLw
         1UL3q0XoYysaei7/UEi7/zS8uqG5/94FEpteMDthOiSrJSJoo6WnPTS9R1AgWlwr6ekl
         IUncysHR6HaTY3flf9si/1uXNtPpMilk+k/hrjor3VQhQ0M639zJS/RvkGiwEuxrMCnh
         9buqD/Q6oEifDs7OQKs1UXweXdIiCz6k7KOql9BbPIgMlkoWnF1gEpCJwjVciTLs+iCR
         DXXUhdXWfK96ADBQXJEjYZG8dQsyOQJDgAQ9J0iHQZsI0wjCK4CFaATg0UcUchFupmvT
         uEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SRa8dd5e37oxGYqqIqTF7B45ms6xLoBbhxXPvy7fdvc=;
        b=ebxINhLi/ppzJ2nYmmkXlEGO1mmOilYBtSW13gvff75DUG6JIki4Jdl5dnmJR4rh7b
         kmYa+1Pxa9qAppjaodrb1su4Ihq+p2R+nGNNFve136ImbmWszp4WPRBJvjGKYUvnFER4
         W2RFxJwp+tF9WzlZCsoka8XmONlWyursTGoW+SGgIt2bIm5AjO/gpt1MZ4uVT7NNvGrV
         KfG09bj57Bci7sRhexSuNg9o+p9OtY3LYLaRQmkh85XMVHSjo3law88sVZZ4Uf3+JX/G
         cS9AbUv8FPzoM+q0NDoRRW37LAH9I1zyxvTzkJcZBBjc8VoyoQ8ShncUAFmix+Nhehhb
         oE5w==
X-Gm-Message-State: AOAM531qra956ZhMr8F6+fGPLGkTGr3OY0x9bvKAefci6Hx4ErKhJCt1
        D8vFdkKDk+DoYRLH1gbbKjbIv4YnFRDz9JFUvXBLYEjYoq4i8rHb/E+JAQV1N4CQ5oBYek0Y4iZ
        FB0TytbqgjI2qSJAQ1XcwfdTauC7Pb65EtL6VCJJ2AY50ullUMDb0DRscBJOtNy0fsbYE6B+u/a
        DX
X-Google-Smtp-Source: ABdhPJwFKCzl58cnZ3Os/Ykp+/lEEiGxTg+k46rnAG0j5joVJQfHgFnPqVKoHoop3gS2Mpfdw+vZo2DiE88z
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:5a04:: with SMTP id
 o4mr1499479ybb.269.1610529967306; Wed, 13 Jan 2021 01:26:07 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:25:32 +0800
In-Reply-To: <20210113092534.2771034-1-apusaka@google.com>
Message-Id: <20210113172337.Bluez.v1.1.I90bb4b25451e7f726fc2c8771cfe642b16312ce3@changeid>
Mime-Version: 1.0
References: <20210113092534.2771034-1-apusaka@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [Bluez PATCH v1 1/5] lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode.
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>,
        Manish Mandlik <mmandlik@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

The new op is to utilize RSSI in advertisement monitor

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@google.com>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
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
2.30.0.284.gd98b1dd5eaa7-goog

