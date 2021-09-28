Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA744C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 23:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BFF61357
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 23:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243347AbhI1Xil (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243304AbhI1Xil (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 19:38:41 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C944C06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 16:37:01 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id a13so608134qtw.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 16:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3CR638onWGmhbgBl70qCj/wxS8wxDrGZ/Ly6GTbZlLM=;
        b=IjWBEKmCxz9efE8VbRX+gJRDN5jUKGxyr7y6FC56c1Pag6m7WxeyTveKZWZSsTxm2E
         P0AHHiyR4PV0B3+s+oAr59vPnHK1EM2oRZS31AheDWb0jxH9Ll+Uq9RVVjdY5YEXlry4
         ebQ0+pFLbqwsTl3SAg8x1RMsx502klPL9aQUayjZ715qTZqavKyyJ5UJs8JKdtiU9m6A
         TbFoRZwuakwOpkOJZFd+8TpO0sfersMXh2c39Zd6accu1jAvkKjEn2urzhsXN/xrc5e/
         mVMWdV7GhAUQAyIgfqn8Z+QN87OdT5nYkdi3Jjc9BuveiuS8J28bVIRNYRFgHhrySL4Q
         UB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3CR638onWGmhbgBl70qCj/wxS8wxDrGZ/Ly6GTbZlLM=;
        b=vYuNlCWiJgq6Htk2s+W+UU02AiH9W/iam9g+q+5C85oeRo3qFphj3ZmmESE91tmh2L
         O8Dk47upU7ON88aNKjGC5RcrL4dusMewaHg5AiDfm0SA6EGT4GGcYwlzMa1rSdkWJrxI
         WfNtLk4e6djXaOITmuFS+YtvyW0YjtTIQ1wpenYB7N4vgeT7st0uwOeBXDyURcOtzRET
         IfbQnc2W4WNJEOLLdRHQGibIOjX5/U147XCoj2x81mqBd3ZvUAO5uH4TU5/Gr7gDrOQy
         9X6VX5STGGQ6vmv7X58AOsci7VSv5uXej3oML4mMld+6jbOWBxEgOzAC5xgI2G0IkOLn
         FHfg==
X-Gm-Message-State: AOAM530QdL4UMGeXygJrwEXOSmWgn0/pyCh+fywpFXdfx3L7f/ae1BC3
        CqW4tpHnbpz932kdB2qmYR64OzHLEPDK9g==
X-Google-Smtp-Source: ABdhPJyDjhRh4B04iFEnE7wVkygdHS1SWyg2/6CdmW2qogJmSyjtXAzsN7yja6C8qdzDymSndn7Vmw==
X-Received: by 2002:ac8:1404:: with SMTP id k4mr8636875qtj.278.1632872220253;
        Tue, 28 Sep 2021 16:37:00 -0700 (PDT)
Received: from [172.17.0.2] ([52.186.65.10])
        by smtp.gmail.com with ESMTPSA id e22sm446149qtm.10.2021.09.28.16.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:36:59 -0700 (PDT)
Message-ID: <6153a71b.1c69fb81.63a50.3404@mx.google.com>
Date:   Tue, 28 Sep 2021 16:36:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5877000104441476023=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bernie@allthenticate.net
Subject: RE: [RFC,BlueZ,v2] Cleaning up gatt operations on a disconnect to fix possible use after free
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210928230015.26295-1-bernie@allthenticate.net>
References: <20210928230015.26295-1-bernie@allthenticate.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5877000104441476023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=554607

---Test result---

Test Summary:
CheckPatch                    PASS      1.56 seconds
GitLint                       FAIL      1.05 seconds
Prep - Setup ELL              PASS      48.61 seconds
Build - Prep                  PASS      0.51 seconds
Build - Configure             PASS      8.91 seconds
Build - Make                  PASS      207.06 seconds
Make Check                    PASS      9.64 seconds
Make Distcheck                PASS      246.35 seconds
Build w/ext ELL - Configure   PASS      9.02 seconds
Build w/ext ELL - Make        PASS      195.19 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[RFC,BlueZ,v2] Cleaning up gatt operations on a disconnect to fix possible use after free
1: T1 Title exceeds max length (89>80): "[RFC,BlueZ,v2] Cleaning up gatt operations on a disconnect to fix possible use after free"




---
Regards,
Linux Bluetooth


--===============5877000104441476023==--
