Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A57EC8758
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 19:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbjIGTlm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 15:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbjIGTlm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 15:41:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648B1E47
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 12:41:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c337aeefbdso12274895ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Sep 2023 12:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694115697; x=1694720497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2V5tbTARhzljZ7otOZhQKOmHANjSYplm5Jntmibgezo=;
        b=dzByjGdLT3tMeA1urhJd2LpZ0x61hGq1eQZNJ91PcXrBCjASveMOSDkxyqRuDNKzqL
         oejMVb2e7D+AQMBJIecEcr/tyy8QrBox79SU6nB3nmcv9bLpZ+owZAT9wv73VNhI/DDd
         +NoFjXeRB2t9Tfat3TIXiDygDBxjBSCjPXg2l/M1fh9yBTPuIcvxBSQqiDOGEjJuaAs+
         eDvDzQazimAD0qoumtfEpptCyyDZL4LFAg46LLNQhmsfm8ElzZONfEanvzoBBJ5GM5kd
         WfZPXsrEnIbh48Tn1pRzglvIeyY6QbEHVqZx0jZaIDx7ZLlbzZn2kZijo7+3LGUGW/Wb
         dTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694115697; x=1694720497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2V5tbTARhzljZ7otOZhQKOmHANjSYplm5Jntmibgezo=;
        b=kLSu4FSH5y9uBSxuSOYxB3Lgr5aZTUWodbZrn3TFYJKgUL1uw5QuvyvYAw16Cwzbg8
         HdfsqB46f6OiMAyAA6ymrwAGIa5Vh5zA3IKOjG1vg5QJ56BnKZqTVGrOUFtXggucDSev
         VyXjK2KnEwug5+Sbp8NAbDnmrgkb6xV4QXHLjBvMtqKgWBekGvO7GBno8Owfl/yGJyx9
         Rs33zSyvHGws8rIipotoSJcnIbBEoTAdF9u/CUgicDRV4RrnVqwjxQD6rXk/8/hmpxdq
         w0ca9CfWXfVFxIWX4i6JqhZnwulNC1GoBW9gSeKYzOCrRyYeSHj7OTMMJqMXz3B/V8Xa
         VxBw==
X-Gm-Message-State: AOJu0YwH4iIEy+K8dL4ATfCs/+q6/8/1WeJ86KJigiDkCwl7LhLPWIk0
        VQanoI2XoCU6FGdBz0ykXpOG8KsOtYM=
X-Google-Smtp-Source: AGHT+IECYtxBF9UCA+yhTTCaNxG3jVqoTYGibbrDhmvu2y1YNiiuniPPQsMbBCplPskuQa4xV2TThg==
X-Received: by 2002:a17:902:c412:b0:1c3:394a:8660 with SMTP id k18-20020a170902c41200b001c3394a8660mr668417plk.62.1694115696957;
        Thu, 07 Sep 2023 12:41:36 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c20b00b001bbfa86ca3bsm129352pll.78.2023.09.07.12.41.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 12:41:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] main.conf: Fix printing errors for valid options
Date:   Thu,  7 Sep 2023 12:41:33 -0700
Message-ID: <20230907194134.2242634-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following errors:

Unknown key RefreshDiscovery for group General
Unknown key Encryption for group CSIS

Fixes: https://github.com/bluez/bluez/issues/583
---
 src/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/main.c b/src/main.c
index 2134fcf752cf..b5a6f8e5562f 100644
--- a/src/main.c
+++ b/src/main.c
@@ -85,6 +85,7 @@ static const char *supported_options[] = {
 	"Privacy",
 	"JustWorksRepairing",
 	"TemporaryTimeout",
+	"RefreshDiscovery",
 	"Experimental",
 	"KernelExperimental",
 	"RemoteNameRequestRetryDelay",
@@ -149,6 +150,7 @@ static const char *gatt_options[] = {
 
 static const char *csip_options[] = {
 	"SIRK",
+	"Encryption",
 	"Size",
 	"Rank",
 	NULL
-- 
2.41.0

