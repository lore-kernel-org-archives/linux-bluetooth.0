Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AFAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 10:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348744AbiBKKCY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Feb 2022 05:02:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348731AbiBKKCX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Feb 2022 05:02:23 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1E6E9C
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 02:02:22 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id m25so7856070qka.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 02:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Yrmy/MI76Vfq8d2KNWB85GP7hiV9xgz7C7cCUBNgNkw=;
        b=ldaiH8J1Gkfr0LtiClBdYrLeV6nx8fdI3VhmLpELzdzhyTp1plHWh4NsEuU10U/h8t
         rIfkBhceGymHSOLvgXb7hDzADVAgVSSM3h1B3nsnGQ1z1qIqmoxGD9SqKpuyxMtLI1nf
         VwoFkFc4JRiRwylzCfV6erp6VDyS4qoZmu37GDJp1ps20F7NCw+86l/bQjblTCj+1ttW
         PQYGLQfoIKEkOmYYcB09CGU88gGkmO/qenn6yMtdlTd9Z6und1jg6jLyxEj3MC2pF3pc
         bMPl+P/X1gD0Y0BDfh4zjPpcm4/gNSJMXi3JqZT1gdff5q/s+1vdHf6G46Cx3EYYB3zX
         yJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Yrmy/MI76Vfq8d2KNWB85GP7hiV9xgz7C7cCUBNgNkw=;
        b=o7XZRa98rnzWAJFeX2BCzs47dcbCWUKOH7Q5Nk5l8pMOR+5RPVSqKMG8UHw+wLaJXn
         wA8CsQI/kdFkbYlEH2Zl2flZFWDCiloDnJMEOPh5wItzczFUpgJEgokvnp2YLoEAyBKC
         LDBGZwmjzBsPYnOKpcDGezElcppkg3bWspYkHAz2xS8rFm3rBkPl/75df2MkZUIJ5Qp+
         eBE8qucuu5sryRLS9/QUaN91t8A4ePAmmantgcBV3B6daDt1jtjgTf6icpuN8BlIuCUp
         4A3Fl0mpopSfDXfkdM4KbbzzpjSoeAYAoxhga45rBNLzGeLwQNzv3HJE+PKZaX1Y0efC
         ZSKw==
X-Gm-Message-State: AOAM531AqXTaaRUi5YEXl2qv6Lt8WtQ97yTldYZ8SNHagHIrxYfL5j+a
        nrwLOnCNR5HMmxr2V5eE4BQVBMeiTLQgWA==
X-Google-Smtp-Source: ABdhPJySJRQUanGSS68fvy/sYy31tOUZ1SLGso3MaaMUFb8dig/nAri8W1Y6vxoGQxSw9aoRGVcWjg==
X-Received: by 2002:a05:620a:40cc:: with SMTP id g12mr311460qko.308.1644573741647;
        Fri, 11 Feb 2022 02:02:21 -0800 (PST)
Received: from [172.17.0.2] ([52.251.121.46])
        by smtp.gmail.com with ESMTPSA id f22sm12840313qtb.1.2022.02.11.02.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 02:02:21 -0800 (PST)
Message-ID: <6206342d.1c69fb81.ff867.73e7@mx.google.com>
Date:   Fri, 11 Feb 2022 02:02:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3742043561408239344=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pepe2k@gmail.com
Subject: RE: Bluetooth: btusb: add support for LG LGSBWAC02 (MT7663BUN)
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220211093103.18124-1-pepe2k@gmail.com>
References: <20220211093103.18124-1-pepe2k@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3742043561408239344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=613415

---Test result---

Test Summary:
CheckPatch                    PASS      1.73 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.90 seconds
BuildKernel                   PASS      37.50 seconds
BuildKernel32                 PASS      32.75 seconds
Incremental Build with patchesPASS      44.43 seconds
TestRunner: Setup             PASS      573.51 seconds
TestRunner: l2cap-tester      PASS      15.69 seconds
TestRunner: bnep-tester       PASS      7.19 seconds
TestRunner: mgmt-tester       PASS      120.64 seconds
TestRunner: rfcomm-tester     PASS      9.15 seconds
TestRunner: sco-tester        PASS      9.19 seconds
TestRunner: smp-tester        PASS      9.07 seconds
TestRunner: userchan-tester   PASS      7.64 seconds



---
Regards,
Linux Bluetooth


--===============3742043561408239344==--
