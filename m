Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECA0C433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 22:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E32207D3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 22:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="WWlbmm+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgIAWAu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbgIAWAt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 18:00:49 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BBCC061244
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2020 15:00:48 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id l1so2039675qvr.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2020 15:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CcdNWU+86e5xTiOf7ah/MgfDcwkOxV/DvzlKs8nXLOM=;
        b=WWlbmm+hACMBMvxtgXeSsmeHJwZDYmBCs29VdHN+qjg60j+XqPybqlx6kj70U0k1Xl
         LgBfgCqJMrFtcJEkYtXSpGPt9aEC4HYt3lGj3qmTI1ORSs3/TXAOCqp0qROKh97nILE4
         J72uySrAIj3aQQxF2GqX9s0oF02RxG7Cn9VLPDC9kvbSACFJc/QPNJiWcnHo4CplQ+ss
         Ut8Gvu7oC09CAQuNb7C2S/hmEolbeCPMtMT5DmkqhrESEWH+DPBTfY3no8Y18WoCpkEL
         NuN4RtyrEiUIdpgXAiSeok3Eb2t+GNaLtznwWo5KNwbNhAGpbTs5OgCvZbd5WsthE+Rd
         0H4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CcdNWU+86e5xTiOf7ah/MgfDcwkOxV/DvzlKs8nXLOM=;
        b=rGIF20GH/Ecwm5q5zKnrl/2fNDjEmn2wf4bEwpf9UPyMcdLwRcvrqAoN8/KwGGsH+T
         LLgELlwm0by0L3y63oiVNAlpVJREcFn8BlBx1od3zkSTj5CGtrFDZjjU8/WyI16zCbc5
         E/ZlNHrCy7iYUGoP7Vv6/OVW1NxeS0zRAcl/wommHmDT/SxVm/yp2MTHqZjFTVg09ogt
         9E3OdTM/NTuUjy7QwP6w84VPEsd0usNUBnPPOXfjctPqMico8q6oc+4l2iT+EfQWTKDt
         K0vUZfRong5VvIqt5si4zCoY4LyDW1chCm2Aqs5c4mdLFQtgjQsHVEzmct24vmNlHAX0
         NH6A==
X-Gm-Message-State: AOAM533HzuQI/WWiL2ChRqFR5xq0V94DYQQwy9mA37UvhtZys0cMCcvP
        SW1siH5jq413/YD5b9AjozwcUQA9q44tYf8qJY5J2axkiB3UbzJ2zlHzkpTpCxYVNDUpa1x6ez+
        04Dxl0nj6Iy8MqDM0QplA9Am17Zq/w5Hocf9AumBjsAHO3+4bJOfU6/SvLl7Afe1bgRm+Yx5R0b
        ypC1u7DjLDvy2xuXdm
X-Google-Smtp-Source: ABdhPJyJIYbHREBmZyiDaangNcbGagLACibNHazu9a2hX9ZSdgcqqdmUj4XCHPOxI3b/EPaX0f3a8UY+7HCGpSp7gFqb
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a0c:a342:: with SMTP id
 u60mr4111883qvu.2.1598997648082; Tue, 01 Sep 2020 15:00:48 -0700 (PDT)
Date:   Tue,  1 Sep 2020 15:00:24 -0700
In-Reply-To: <20200901220024.662941-1-danielwinkler@google.com>
Message-Id: <20200901145820.Bluez.v2.3.Ieb6522963e3f54b0d63dd88ed3ce24a8942ed73e@changeid>
Mime-Version: 1.0
References: <20200901220024.662941-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [Bluez PATCH v2 3/3] advertising: Add adv SupportedFeatures to doc
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v2:
- Doc: Expect empty SupportedFeatures if no support available

 doc/advertising-api.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index b0565eab2..90a8a47f6 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -209,3 +209,21 @@ Properties	byte ActiveInstances
 			Possible values: "1M"
 					 "2M"
 					 "Coded"
+
+		array{string} SupportedFeatures [readonly, optional]
+
+			List of supported platform features. If no features
+			are available on the platform, the SupportedFeatures
+			array will be empty.
+
+			Possible values: "CanSetTxPower"
+
+						Indicates whether platform can
+						specify tx power on each
+						advertising instance.
+
+					 "HardwareOffload"
+
+						Indicates whether multiple
+						advertising will be offloaded
+						to the controller.
-- 
2.28.0.402.g5ffc5be6b7-goog

