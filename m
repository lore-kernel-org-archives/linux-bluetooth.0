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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5681CC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 07:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 211DB239E7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 07:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbhANHpw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jan 2021 02:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbhANHpv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jan 2021 02:45:51 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18579C061794
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 23:45:11 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id 189so3857892qko.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 23:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OLI6r859/uK7KgczXsbP9/aCx0v/ssHbjmUiDlbtpVc=;
        b=wTuvAmhSNGlk4RJn5aegVdKCSUC6Xojl3z/CmCyKMAe1xFYkuS8/fdTcI2OIKBM/OI
         /payObBI7c8wMfrCvkLCNk14W1W9yur4AhtLamc6q3Odc6ppCuFdrqYjnHz+RspXVW3y
         lve+4BId58OlK843qKvMhVnzWh4JIWTmW958CBysSxrpk4fBa/DpZrL+k/InqMhRK+uA
         QO5nAviaugwWRd2i7hOO8kuER+OSAGq01O1Uq/JaviLcRI5dkAjjZ/l9Dy+9xXcyQ/Zw
         39dNhAmUyQN18ZrUoTRhkYLZeFybS/8OVYk4bVS7I3eAUZ8Vwe4l4hEoWsOSdY/eZo6a
         TEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OLI6r859/uK7KgczXsbP9/aCx0v/ssHbjmUiDlbtpVc=;
        b=N4EKW/+pjrMdEIs5yFqpCduOmEEo9Z6POEWsKKwnZ9Ejs/wFHF3izWWckDdzHJnWYR
         /d5lR5wuaexn38mMTHKPA3frVO6zVgzSvBde01uraW36/mDRQyd6PJo2lxfBzyywjpes
         rvxcAyax63Pihv7fFQbGX22EySqhfvZHIvzWzCRhfBqdKS97oobaGzFgxgKp0Jxt1Dpc
         T7nGrBZLFKk6jHZhs5sAufHWfNYWUpYp2afrZnrZxx1JG4ym7Ko4LVh6JH4N/8qS1jya
         rpydVLMbPrv41Hj6ekZoFi4w9MO1NEtjipLL4GmrC9AbcV9CSQ4AdjNoE6kCrb99eY/N
         +3ow==
X-Gm-Message-State: AOAM531HqWP//9bLBqCaesx6w48SBDxCFH0NdUUStIhfyPZGGFHrydlo
        Cb92i8++fTU8wPB/LZWn55lmtBDj76WEaR3sPR8s0KTLDxmc8lwNf5CR9zRXuk/BqZ1RIWTZUXh
        KbjEAazwK+SOrv2k8zB4Epz2YenyAnyR+EXlI0RHqDP9+g15jtiWD2rYt17y9oHd88fw9ag2V2J
        tU
X-Google-Smtp-Source: ABdhPJy0gHbYnyr7nTZ2A4W7jCmyT51tChlRDA8SYP5ZAZ0cCnglP3wFKUppkc9XDfewSDqzkTNlun5G590j
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:81c7:: with SMTP id
 n7mr6826096ybm.290.1610610310167; Wed, 13 Jan 2021 23:45:10 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:44:54 +0800
In-Reply-To: <20210114074458.3399055-1-apusaka@google.com>
Message-Id: <20210114154405.Bluez.v3.1.I90bb4b25451e7f726fc2c8771cfe642b16312ce3@changeid>
Mime-Version: 1.0
References: <20210114074458.3399055-1-apusaka@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [Bluez PATCH v3 1/5] lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode
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

(no changes since v2)

Changes in v2:
* Remove trailing period and fix order of mgmt parameter

 lib/mgmt.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index f37f7e6540..76a03c9c24 100644
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
+	struct mgmt_adv_rssi_thresholds rssi;
+	uint8_t pattern_count;
+	struct mgmt_adv_pattern patterns[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

