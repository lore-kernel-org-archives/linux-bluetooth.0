Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4FCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Mar 2022 23:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240816AbiCTXDy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Mar 2022 19:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiCTXDx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Mar 2022 19:03:53 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF228908A
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 16:02:30 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id q194so10622352qke.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 16:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=xfWqCMX6RgEYiRoZo1TngXcCnl+f/dbkH2/XK1OXkIU=;
        b=Hyy4Fo66f7TbnydndW74mLbh0cKK/HphRmsjIByhyC6UrA6JhnBGijwOICsJsWLbNV
         9eZJdxp97aRLbsis9STl3qvI5EQLN8dvGvRNxpen1eWBZjELll45qtqlw4loJpuLx8a9
         /jj7yzv+Mu9JC15WkYV9/3OUZMGHMD0ca2C6IkJYUQtd9jzBf6vhxWPUYRNImHL4vdDw
         5B1ctO3E9Uq/UZC8Qk53SUIAngNw9LTyQ6hH4dQiZfJK5S5gtMOL7cah4l+iX8+8LB49
         tY1n3cGws51oKIiM/UDqzCEvRKRRjwcy/7QTxCCMAJX5iuqreMu/fXklcV89KOMBYyJH
         miAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=xfWqCMX6RgEYiRoZo1TngXcCnl+f/dbkH2/XK1OXkIU=;
        b=QU9yDxyLJ+kzxAoCTZLTkkM3fL3YiROyj0b8Wh+A54oyqUqz4AkeSezb22jHdjick5
         tJ2/s3/AFM4YiYH0Ty+8r/rksFC04RNrDawP6Iczd7Mgij7pOkeJsdrb8bP3FRphuq1A
         5wjFxjt1aJ4MBAG9uDitL+5jlU2nzZKWukJEw1PutmmGluW3eZou5hEuAv5WTj1vEvpz
         MnkpE8EoLD8csZWI91Qvrs6P+NyM0pPaCZvF1bVcaZpCXc4TxFYfMKER1rP3RHMwcd46
         scMZEIHgbwce96SRVl3WUuru2Oemxh+osK2/sc5raHgHYPi5y7zMiUfQa7EAvYW+xgiA
         EL0g==
X-Gm-Message-State: AOAM530ooL5rublia2TTfxR1zJnaCEUPg5QVb+8E1xLxOAdeC/qOLd/U
        FyMjuastBqgrfGVv50IHbd4z3/92XPg=
X-Google-Smtp-Source: ABdhPJx6AFPS4EmgCDGlBLqL+SaT48ejHYMfj6c39WkoQQBWgzT4r2ZfXXbDe/ybl0CcxQJojCBM/A==
X-Received: by 2002:a05:620a:a81:b0:648:e30e:1c80 with SMTP id v1-20020a05620a0a8100b00648e30e1c80mr11507174qkg.385.1647817349123;
        Sun, 20 Mar 2022 16:02:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.155.236])
        by smtp.gmail.com with ESMTPSA id x20-20020ac85f14000000b002e1ee1c56c3sm9221293qta.76.2022.03.20.16.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 16:02:28 -0700 (PDT)
Message-ID: <6237b284.1c69fb81.8b510.08cd@mx.google.com>
Date:   Sun, 20 Mar 2022 16:02:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8567147674989414242=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, linus.walleij@linaro.org
Subject: RE: [v2] Bluetooth: btbcm: Support per-board firmware variants
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220320222749.1502856-1-linus.walleij@linaro.org>
References: <20220320222749.1502856-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8567147674989414242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=624982

---Test result---

Test Summary:
CheckPatch                    PASS      1.74 seconds
GitLint                       PASS      1.10 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      35.75 seconds
BuildKernel32                 PASS      31.91 seconds
Incremental Build with patchesPASS      43.15 seconds
TestRunner: Setup             PASS      551.44 seconds
TestRunner: l2cap-tester      PASS      17.37 seconds
TestRunner: bnep-tester       PASS      7.00 seconds
TestRunner: mgmt-tester       PASS      111.81 seconds
TestRunner: rfcomm-tester     PASS      8.89 seconds
TestRunner: sco-tester        PASS      8.77 seconds
TestRunner: smp-tester        PASS      8.64 seconds
TestRunner: userchan-tester   PASS      7.31 seconds



---
Regards,
Linux Bluetooth


--===============8567147674989414242==--
