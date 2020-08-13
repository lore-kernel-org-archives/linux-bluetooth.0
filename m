Return-Path: <SRS0=cSIk=BX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DADC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Aug 2020 00:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B66D2087C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Aug 2020 00:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QZCYdxvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHMA2d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Aug 2020 20:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHMA2d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Aug 2020 20:28:33 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9C8C061383
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2020 17:28:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x25so1908509pff.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2020 17:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t2jktOp3oLFCxWLPdRedZQlig2hKxvQwaPspKdm/eDI=;
        b=QZCYdxvWssD+hStyvbPSHpls7j9anvadJrrp94CoajB6/De6t8zv5/n2iSfqbId1lG
         Kd2qLuUFuYFQgPOxkVdQqH0nCcnrqiuO1XAhYw3VGCqICMKA6Id0wO4iLkmVJNXLNBEd
         uh5CFAjalU37XFpaDjC2V6m8go5+BgPap/Vq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t2jktOp3oLFCxWLPdRedZQlig2hKxvQwaPspKdm/eDI=;
        b=OSfMCcUsD7DoRC0TH5H98oLvhTG2qb7FWumjKCnPU3Pa3omcDulQbpasJ3+81OAaL0
         rZgCcsEkuSMxtQFT8Zz3S9uRXvlfq3Mnf8EY+woXryDC6wfZQjKvAPHBteZmEyopmxV0
         LScCj+3sTNeufJs9AOc62kQTTR56tRAreCkNtdzpjRwOu7puPPDsLt/70Q3OCgrG1OxF
         No+q6Yzy9Gx8JMnD6nsHHAMJ/Sk1rB8bLByOkmhsu/ljHCpYKRMQF1JN95kmAwdNoFN6
         albjjNCE+fckm32D/m5Ki0yw+lShmm5QHImYLmU/EmzIPOBErjps3wi7pvPhlYO4Of+K
         VJ/w==
X-Gm-Message-State: AOAM530yyhB9K2wp1/JbfleG4lDL6Rz26WTqRlgmqQadL5SxZ6CS1keY
        dnBYf2i6SSA4F+b2Ho29Jeg4BdAHzkQ=
X-Google-Smtp-Source: ABdhPJwMevQWaXfbcSLDsUqIf/TKNnhc2aV13KJyh/H4+c213T2lKCGb/Xn2EABJMb2/f1je61znmg==
X-Received: by 2002:a63:af01:: with SMTP id w1mr1546730pge.23.1597278511728;
        Wed, 12 Aug 2020 17:28:31 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id 2sm3945626pfv.27.2020.08.12.17.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 17:28:30 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ] checkpatch: Ignore SPDX license tag
Date:   Wed, 12 Aug 2020 17:28:19 -0700
Message-Id: <20200813002819.359374-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

BlueZ does not use SPDX license tag on file headers.

---
 .checkpatch.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.checkpatch.conf b/.checkpatch.conf
index 419733832..72c3529c3 100644
--- a/.checkpatch.conf
+++ b/.checkpatch.conf
@@ -12,3 +12,4 @@
 --ignore PREFER_PACKED
 --ignore COMMIT_MESSAGE
 --ignore SSCANF_TO_KSTRTO
+--ignore SPDX_LICENSE_TAG
-- 
2.26.2

