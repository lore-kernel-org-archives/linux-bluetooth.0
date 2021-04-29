Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61556C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Apr 2021 18:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF4761441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Apr 2021 18:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbhD2SQa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Apr 2021 14:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhD2SQ3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Apr 2021 14:16:29 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30B1C06138B
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Apr 2021 11:15:42 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id y10-20020a05622a004ab029019d4ad3437cso27792008qtw.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Apr 2021 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SmaZZ+RluG42rm6eYZfGzwjvRRBvOn7lkSLVYtAz0Tg=;
        b=bNb+bsxszXqPIvikn3kuDwPZdJbysghtcwlXsCCdstS0BrtswvXCz2QwX9LC9uRDTG
         wpm7FfAQN5akGj+T8cTJPtwZWF/tJ4cI1o7fMbh3mi0WYMcgzsJ7LD0haK4Jz1dtbVZC
         lFfImYyKCPs+jIOTBFrIJuVqD/Jj3gwR+daXOnEe2UipMA3GOIwN5bCzTp6JHBnOCBXX
         dD9gjXAO59lASS/jG6JR3AdXCiWeEYZ7IPVmLMMJFq5mi+4BkmDoHHw6QW3LBZCllz9P
         bjKzE5EtdWv8vSpG87mGrJCZZSxF+TDDnCM3nOd0fp7We9CK+dy6FAlYTwm5hoDtmTC6
         Uu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SmaZZ+RluG42rm6eYZfGzwjvRRBvOn7lkSLVYtAz0Tg=;
        b=ownV9AdhtK3NU5X2iE0zPJEXWDBH0ctNYLIgYhisbjqxJEuRimqX5wpDm02Vop4D9d
         GmLLvc1ncOb0T1Dq8QyxE8UBX6tVXIdrr4PgF01QvaJiIppve1oQQLDOMlahFcs2dL6x
         cJrsSbQZlJH2e5sjI9tWbYe+Nw3Roo1nT8Zk8BOAL7730FlMJbg0upeNaM5okLq8HVR1
         nhRqmSpHtCerc5e8gVLnXkwjRb+V5Z7l2oDxAmpsxk7g/VAT21jfDwML7utuSOYTLLkA
         2bnLG4GeUw1n8dmv5EeirTUl4WD/kSsx8wua0m7uyqJMqjzq1IUjB0SpRMoxKZ/C9im8
         wJlg==
X-Gm-Message-State: AOAM533taNVwYFcMHlCShj5NUKiohIc7JCdIUUv3/Gq61NSs/3x3nWsB
        uC7HwEWeeZ6DgJTQIm8ov9lUjF6ULUDKKZAI6gwgm3sfvduBD8gYmTiDc1hVZQnpHmP5uRklPjn
        QpGPy+LNTEORRXxGpUI/d1geZNCPJYn8FYAHoGBYKwo2gBEvQzl0kW6TXB3HxgRK7wwgH6igtVQ
        Ow
X-Google-Smtp-Source: ABdhPJyUom8ag+IRynYn4xDP2hCTobPglWE4lj1VkDmhUDAH0qkoYIghfHuwWHUBtVLuhyB/EUNfhhVtaLd8
X-Received: from yudiliu.mtv.corp.google.com ([2620:15c:202:201:b87a:317b:6a3:155c])
 (user=yudiliu job=sendgmr) by 2002:a0c:ef06:: with SMTP id
 t6mr813313qvr.17.1619720141994; Thu, 29 Apr 2021 11:15:41 -0700 (PDT)
Date:   Thu, 29 Apr 2021 11:15:38 -0700
Message-Id: <20210429111523.Bluez.v1.1.Ic00ed950add081b346d6c8ced590bb7b2eb6e9f7@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [Bluez PATCH v1] doc/mgmt-api - Add a new error code for HCI status 0x3e
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        chromeos-bluetooth-upstreaming@chromium.org
Cc:     Yu Liu <yudiliu@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We want to retry the pairing when HCI status 0x3e (Connection failed to
established/Synchronization timeout) is returned from the controller.
This is to add a new MGMT error code so that we can catch this 0x3e
failure and issue a retry in the user space.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v1:
- Initial change

 doc/mgmt-api.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 5355fedb0..f7cbf7ab2 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -200,6 +200,7 @@ and Command Complete events:
 0x12	RFKilled
 0x13	Already Paired
 0x14	Permission Denied
+0x15	Connection Not Established
 
 As a general rule all commands generate the events as specified below,
 however invalid lengths or unknown commands will always generate a
@@ -1112,6 +1113,7 @@ Pair Device Command
 				Not Powered
 				Invalid Index
 				Already Paired
+				Connection Not Established
 
 
 Cancel Pair Device Command
-- 
2.31.1.527.g47e6f16901-goog

