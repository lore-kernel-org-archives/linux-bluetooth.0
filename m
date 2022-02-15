Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99746C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 14:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiBOOIm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 09:08:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiBOOIl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 09:08:41 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354532B183
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 06:08:28 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so2961545pjl.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 06:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=L869vQTyo5AF+O9zHcgMXtUoqGSe4fDvJZc58B3su4c=;
        b=oEQN+owkedu0qaezi7jR6XMZqY19n9vKzbV/qkKfnhd1IbNYn4lrTdYWZBb9qqmLXU
         YxY/behfezlBGS+s2JAkDh6l5sbFCQdEgPf/BabigmZUy0s5uRWuI6hf3TLE7bU8in/y
         evN4OKOusB2sXmDX0aVaASE6bCSut0M/1s2whYdbt2uYEQRkXoIiJ927jhXov91d0v2a
         uWeQtU6l2XO2BCVfAk2QwG81UD4ZZZH57IwlWwET9ACAhvxUGqy4BMoooIu0pnXh8ZXQ
         0ajr9DmYt37amWJlQzzVEpTP40ZjoOvfcciiGcLUg1OgACupCe3iqOd0ToY1SPCLe6AP
         R2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=L869vQTyo5AF+O9zHcgMXtUoqGSe4fDvJZc58B3su4c=;
        b=4BofxYg+9XpxAOaWcrzX6qMHKJiP1LSH0QqWjtzPr5NRaHKlJ8OTZ4vbuVyjohyLFf
         NtP8R/ycjf2Kr7NvHfNRaPkQn0/qj7oDNkOw5p6ScIus8MVOoAGqCaCeiHiPunVsI+XB
         xhvuZlqrJJsSSGK+Oba2Y2USGcGkWNduealqlelTMORV9QakFlhAikaSYXeInIs0w+3L
         zPrKhee7t04eeK2yHALc7HYI1rLlfGul88bBxi+WCx4PofdDUVUJ0QYCBOs0qF00uxrO
         uIlk7qa4bjHdBWJ2Wk8LzKtiFXGyg74knlqPLbQLGvJ01sRr80ki/zjvnbhPmN3uD+Yh
         yQ0w==
X-Gm-Message-State: AOAM531EhBltkIeQ1uLnD88NCxZz77F4KyajynEY7d572OWsa0xqSdLA
        CJ/2fg6TCWki7vMojejGSmwSeoK0CnQ=
X-Google-Smtp-Source: ABdhPJy2AxdfVOkQ8OTZIwfphmHJUzZjedoF1HOMCtEqZk5hrb47p042gouj/KsMBCpFzBceWD5BQA==
X-Received: by 2002:a17:902:eccc:: with SMTP id a12mr4321421plh.138.1644934107290;
        Tue, 15 Feb 2022 06:08:27 -0800 (PST)
Received: from [172.17.0.2] ([20.109.185.208])
        by smtp.gmail.com with ESMTPSA id on17sm14274865pjb.30.2022.02.15.06.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 06:08:26 -0800 (PST)
Message-ID: <620bb3da.1c69fb81.29bb2.1566@mx.google.com>
Date:   Tue, 15 Feb 2022 06:08:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5271267227565169374=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [v4,1/3] Bluetooth: aosp: surface AOSP quality report through mgmt
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220215213519.v4.1.I2015b42d2d0a502334c9c3a2983438b89716d4f0@changeid>
References: <20220215213519.v4.1.I2015b42d2d0a502334c9c3a2983438b89716d4f0@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5271267227565169374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614537

---Test result---

Test Summary:
CheckPatch                    PASS      4.35 seconds
GitLint                       PASS      1.15 seconds
SubjectPrefix                 PASS      0.69 seconds
BuildKernel                   PASS      35.09 seconds
BuildKernel32                 PASS      30.56 seconds
Incremental Build with patchesPASS      82.91 seconds
TestRunner: Setup             PASS      556.96 seconds
TestRunner: l2cap-tester      PASS      14.92 seconds
TestRunner: bnep-tester       PASS      6.70 seconds
TestRunner: mgmt-tester       PASS      119.24 seconds
TestRunner: rfcomm-tester     PASS      8.50 seconds
TestRunner: sco-tester        PASS      8.70 seconds
TestRunner: smp-tester        PASS      8.49 seconds
TestRunner: userchan-tester   PASS      7.03 seconds



---
Regards,
Linux Bluetooth


--===============5271267227565169374==--
