Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35099C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D100610CF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbhHMMU6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbhHMMU5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:20:57 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C98C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:30 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mi10-20020a17090b4b4ab0290178b6d7574aso7587187pjb.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BvVBO9aCuApqAW803ra4S/QragqrXZCjWak6ZmBt8sE=;
        b=MJu7otQ+u4HfLussBhnpQOsFRGEGn9e4+UmaHcWHqavKWekMRxxXOM3LizFPoPofMj
         ZXiZd4n0fcV+kmDz9AfgGr0tbs/VxJ5OTAk3GSC3RNRKy9l5DlnjOKuu/SuhvI2tbSRh
         cvQ4iP6yEXzvXjmgjeG/53HaLGiWVQKRZkaMVhqWg8EDE1uc5GrMBDSO6qR01wiErMxp
         x3CMqJ2XydbrkqbbFDE5KTGUKk3S4NRmHda1FkSv3pyCOcwHdwYh2Pvja2RxSULfFo4B
         qQUDS6PpHYP3hr9x91Nf+q3NVy4xfQcohgV55So75sjU3JtmSpXWF6pXg8Iwfg/VSLVv
         MDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BvVBO9aCuApqAW803ra4S/QragqrXZCjWak6ZmBt8sE=;
        b=a7c0o+fByniJUQyUMTWuIwfdNFs37HxoJub2dk+NuYiU97Gu/YiJNQ71IWXaRUFzWA
         kQ3nJAQLNVwCnNIXunBRCJ55UWDvObh3fi8QSSomZi/5LGDJmp03zbDKtymVLY4p3gwt
         QrI2n8CjkzdpmmvW9pS23WLiEwDtpOqA2Nng421yilw6WfCI57K+Fxuf84qczTYS8jKf
         ep5EO/todxDjI0T0nbeRDDG37jIMvDzs+NmpA4XbXvmuAFNg2PpTW0bccFKQJPHiIx8M
         uZJ/zqfzq8jQUD8xS0v0b/3pFB0f3t2TXcGV1hjt9O+R6kippKC2BSyeePFnyRCNIoO5
         EVRg==
X-Gm-Message-State: AOAM533XlkaUL83N8fB0eMpGIs4ks4um7x0GtRx6hdd+cy6347D9nAkv
        XngAudCvcftMZXqUYs4W+mVMw+fQC26jP7Z9dCaXkzwrYqPu+FWvCFu/GMFy/m++y2FPo31k/9J
        0zZeFr6+J0RoC0neR1fsFInpji2CpuZoDRz2qq2mCDKVKApLFSmyERgr4a3YGlaCp12ig6iAbME
        jd
X-Google-Smtp-Source: ABdhPJy2jp/4q0pfOuB+EVRrcWn3KARk1iaBohLYZFMjA2gMpPnpRAi9iS70KoPtFHgGfdTbyWuvwA/glMg5
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a17:90b:396:: with SMTP id
 ga22mr205729pjb.0.1628857229999; Fri, 13 Aug 2021 05:20:29 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:00 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.15.I3a4295a824570e92a9274f94e8b59025c3fba576@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 15/62] monitor: Inclusive language in LL feature
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"peripheral" is preferred, as reflected in the BT core spec 5.3.
---

 monitor/bt.h | 4 ++--
 monitor/ll.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 3d3073e462..888dbe3d89 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -88,8 +88,8 @@ struct bt_ll_reject_ind {
 	uint8_t  error;
 } __attribute__ ((packed));
 
-#define BT_LL_SLAVE_FEATURE_REQ	0x0e
-struct bt_ll_slave_feature_req {
+#define BT_LL_PERIPHERAL_FEATURE_REQ	0x0e
+struct bt_ll_peripheral_feature_req {
 	uint8_t  features[8];
 } __attribute__ ((packed));
 
diff --git a/monitor/ll.c b/monitor/ll.c
index d1023c8a3e..d0db9194bd 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -449,9 +449,9 @@ static void reject_ind(const void *data, uint8_t size)
 	packet_print_error("Error code", pdu->error);
 }
 
-static void slave_feature_req(const void *data, uint8_t size)
+static void peripheral_feature_req(const void *data, uint8_t size)
 {
-	const struct bt_ll_slave_feature_req *pdu = data;
+	const struct bt_ll_peripheral_feature_req *pdu = data;
 
 	packet_print_features_ll(pdu->features);
 }
@@ -702,7 +702,7 @@ static const struct llcp_data llcp_table[] = {
 	{ 0x0b, "LL_PAUSE_ENC_RSP",         null_pdu,           0, true },
 	{ 0x0c, "LL_VERSION_IND",           version_ind,        5, true },
 	{ 0x0d, "LL_REJECT_IND",            reject_ind,         1, true },
-	{ 0x0e, "LL_SLAVE_FEATURE_REQ",     slave_feature_req,  8, true },
+	{ 0x0e, "LL_PERIPHERAL_FEATURE_REQ", peripheral_feature_req, 8, true },
 	{ 0x0f, "LL_CONNECTION_PARAM_REQ",  NULL,              23, true },
 	{ 0x10, "LL_CONNECTION_PARAM_RSP",  NULL,              23, true },
 	{ 0x11, "LL_REJECT_IND_EXT",        reject_ind_ext,     2, true },
-- 
2.33.0.rc1.237.g0d66db33f3-goog

