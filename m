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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6640C4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 03:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A6523333
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 03:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgLPDoL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 22:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPDoJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 22:44:09 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8F7C061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 19:43:29 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id y10so11694123pll.20
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 19:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=kgGzWy8Mj+jhbJDtLnvvOkcAqITIq+BFXW/rwl32T9I=;
        b=C5+k1dE8/IZKxMmyHjm9gJdux0EtJ8NO7ttIvfblkEtct/9ZVgqaRr2Bq7dorJOnU8
         DdGmTBN5n0fzbqbPRc0aDxfioted+GN8tem39FqZkybiYC5wYnDmDIH7bLymkkarcoPC
         kKGN0Uz0Y/gvMwena47WxU23aLRUDn8k0zH4o7vutCswTQdrXEsAcJlCfKNm8idW6BEk
         uP48OiHppr7dR0c74EC+x4vF3e2umrojRkuzl/o+kRLXnmHzRTbt8LYw7cwGH9ja1hLw
         dg4JZJuVAZwp+NnA3rwTrgkLbNgODcDyBGei/Xy+52bfAxAFblSl3HwU8LL7J+sdZNnV
         R+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kgGzWy8Mj+jhbJDtLnvvOkcAqITIq+BFXW/rwl32T9I=;
        b=szVkID3vyZAjjv8lnJ81vwdz2PXn6GA3ExgBiUuHnfegqPvqTnfBZlkEnX8HSSRPqg
         H3c6lLyaWfH00XpQmFDJcI8CHPfjTDzVYGY1D6/PU87xQ8Tr2GMCKf4Tcsp9C8TdiWbs
         agukO447lgcVrLC3xi31ZGaMSA2+Fza3FwItaBg9VJ1gBQLYsWKp51U2VvF9VWFQxdCI
         AMX1vmtX8dTOtnT4hdiWw+jazboAdXfU5UmLWgrfoJZTkG8oTEsEZI+u8WiIAOFDmzxz
         by/gkkjSvgaYOojhzMddYc/jm9yZflVHQ67RQtgvWb6ErwRuIg6gqShkqna6Lmrcl0LE
         ppZA==
X-Gm-Message-State: AOAM533o0bnPvpsqj4VsND0RBudbNLFWwJ4LXuyohRmiMl0ROeJZbQKv
        436lPTRA2aaA5HAgISZz8hJMFod3QNFkWyfH3sQCkU4YkfHqmYQ2xZC2Rn1v6Vs/XeEQf+mElqE
        OG+f9ElQ84fzd0raiMgS8OmlQ+kIvV2zh3c85BVqhTVEt/kVOV96AlOtr/4MNHe2EfPUDlK52rW
        Ec
X-Google-Smtp-Source: ABdhPJw76y1iECCBe+kbxb2Bn/k6WqLQIT+C7NMwAqsjg+sly7sWSlJlXYL+byR2NivH8R2S3TsrTov8Gbei
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:90a:1706:: with SMTP id
 z6mr227143pjd.0.1608090208674; Tue, 15 Dec 2020 19:43:28 -0800 (PST)
Date:   Wed, 16 Dec 2020 11:42:58 +0800
In-Reply-To: <20201216114231.Bluez.v3.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
Message-Id: <20201216114231.Bluez.v3.2.I90bb4b25451e7f726fc2c8771cfe642b16312ce3@changeid>
Mime-Version: 1.0
References: <20201216114231.Bluez.v3.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [Bluez PATCH v3 2/2] lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode
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

Changes in v3:
* Flip the order of rssi data and pattern count

Changes in v2:
* Remove the trailing period on the commit title

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
2.29.2.684.gfbc64c5ab5-goog

