Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5670CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 22:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 324396108B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 22:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhJUW6M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhJUW6M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 18:58:12 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3A3C061764
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 15:55:55 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id j12so3039093qkk.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 15:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=MWsl2yPql7yRYVA+UM6OjCkdFtxeQHrnvMesSgXgSeg=;
        b=Sby33bPcmS82v6GbTQ38XBHpoeHUtM/b4bK5vobz6SKqxuYZA8IatRKfZyk8WCw7Ot
         K5mcHgfVuGZl2iEsfpZmzSMXPG7VGq5M+8NWlVd27mb7Qu2U/zJD3+U7hvBV5zFQeti4
         WfHudKmEbYIVecCMGmkVKPF+1jAPGHdRp4na+3qzu0o3ZVoh5+FaNxEShaoj5afpiQNO
         BxOTOZBtGzyUrB6TxyZG9F2dNZTo44/oo/Nr3XETrhQpuCMrWVdrZqqIIu2zUGzzXXdz
         BJFA1Awthy5EQwifOQ7B3UlGxTnJf6Sep9EGKSy+Rgbi3Q6bc9Kp9pWNrjXlAefzTQtD
         UjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=MWsl2yPql7yRYVA+UM6OjCkdFtxeQHrnvMesSgXgSeg=;
        b=dC/0zHU+DShnZJCn8iggMVSalQI7fkDBzrIQf7dyrl68IAFVnY0R+HM3ue2/5MTCYG
         e/P/PdWUi7FzyOCeDoleawpshuWwbDZvQBRvkLMKNpTrt3pu8btqx1P9wzZRiiIrmivo
         YJZbekEcl6mjMleUGvBDJZ0xZ8ofKRn570yx+kkzxvKjYJUaIbG1u7DL/4nFXUeeiWHo
         dXzwA/FODzjVU8qHP6cNCG0eHzsOFXUqv5SL9GpA10v83qsYHx728VqhTaMt2eYe/xPA
         AUuMXMYc1Q/AtHzEQUPruP7cSHKFjU/AD877S5DNCN6gRAsrcbN0WOH/5hfI8wvaBv89
         qinw==
X-Gm-Message-State: AOAM530Y9Nuisyns1BdQsaXEDdC3JDJGdmyGhbPNdOH5kS+YeKggw/DB
        XqiUsxn7YW8jpcEq4EuD6CwiLcU1pFMM+g==
X-Google-Smtp-Source: ABdhPJx5iWImS3CfRAyHtk7HhXHIQGSbBp0LJXRg1HlxQa0LnPq+Q1mWl+FhDnE9fywfJl+t/mNKTQ==
X-Received: by 2002:ae9:ed86:: with SMTP id c128mr6885149qkg.7.1634856954625;
        Thu, 21 Oct 2021 15:55:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.3.197])
        by smtp.gmail.com with ESMTPSA id l27sm3169301qki.98.2021.10.21.15.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 15:55:54 -0700 (PDT)
Message-ID: <6171effa.1c69fb81.a65b3.5230@mx.google.com>
Date:   Thu, 21 Oct 2021 15:55:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3579711401391992493=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] mgmt-tester: Fix expected manufacturer
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211021223659.654744-1-luiz.dentz@gmail.com>
References: <20211021223659.654744-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3579711401391992493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=568217

---Test result---

Test Summary:
CheckPatch                    PASS      2.85 seconds
GitLint                       PASS      1.90 seconds
Prep - Setup ELL              PASS      45.27 seconds
Build - Prep                  PASS      0.50 seconds
Build - Configure             PASS      8.27 seconds
Build - Make                  PASS      195.24 seconds
Make Check                    PASS      9.74 seconds
Make Distcheck                PASS      231.28 seconds
Build w/ext ELL - Configure   PASS      8.36 seconds
Build w/ext ELL - Make        PASS      185.36 seconds



---
Regards,
Linux Bluetooth


--===============3579711401391992493==--
