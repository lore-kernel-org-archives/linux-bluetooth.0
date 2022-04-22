Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F83C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Apr 2022 17:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiDVR0o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Apr 2022 13:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDVR0n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Apr 2022 13:26:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16A2CEE36
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 10:23:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q1so11084445plx.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=wb2QP3BO46rrJ9oZ0liecSIUWxQThgljBZkIb7Pq8+E=;
        b=bEFk8cSz1q45kTeyfVTByZJjq4ZgtMjgzWa77YMG6xMHdsv15tUQ+yChLtlzKO7shj
         INvAII3D464EwdBBMrfRjqjTeuohyb05REuCShNN3ud3nCjUUGwM4se0yoYz6AwUgi1Y
         Xjerh2aHfz4irDH7d/cLvxrb8H6U9/eaMn0N2nAUobCWty4R3yAWeeN1dd8l42CgY5/b
         Ck+mJ/9sw7Lod7tOZp/+yqr9LIgRLjsOdKBDustgt6ZHQwjA1AsUHYrhKgKobUnxPlHQ
         2WhaMuVf8E2PmY7z17BdS/KY6+AAe2yg9967QwvJIt+mR6Mw9rzKW+NlIw2Cfev2IEov
         ud2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=wb2QP3BO46rrJ9oZ0liecSIUWxQThgljBZkIb7Pq8+E=;
        b=kf5r5zEazDIkpa9ILVniQuGIWEA8yuCPraqtISZiIHJDXkD355xt3okvAn/frYBWub
         HNOKVJcfWjpBcTibQF0ZoQHYg1aRFmpDWeSPtdbemmnYVQSkrqajSR0zWa09Z5phHfq6
         gW/CWbJvItbeAzYGbb7tqEgUlOuhtL6saMLuAZGCGEkXsvPz19BC3F562LtqI3PsOHRP
         XAcrHeEwLOB6RqIzLrXuOuQMcoCclNAFk9P3Sj5adZ9adYoNhIOoxzSra1YP8SxHp0bl
         PhDuKP2plvxwawxgABEgVIOMQRk0DUhzyy12KuWX/eFlcTm51xBPd9pT3BBiePWsRhwJ
         8d6Q==
X-Gm-Message-State: AOAM531js1LH4Q9XzokdUUCX2BpiDZE12YHjp2ubRDoSalzBXqbRhM3Q
        6bhBE2CHo9xTQP4EP6mNQ1wvwMKvRNQ=
X-Google-Smtp-Source: ABdhPJz9dkwG8F9dBYnXqGFY2CNsqHfmgnsOhPdZLgBzfreoUU7Oj73hwzu1FX+Wt+tIccwg+IlPzw==
X-Received: by 2002:a17:903:2043:b0:15b:f6ff:79ed with SMTP id q3-20020a170903204300b0015bf6ff79edmr4237666pla.15.1650648135327;
        Fri, 22 Apr 2022 10:22:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.12.14])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090a2c4600b001cb78f1e301sm6933353pjm.1.2022.04.22.10.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:22:15 -0700 (PDT)
Message-ID: <6262e447.1c69fb81.e0d8e.199c@mx.google.com>
Date:   Fri, 22 Apr 2022 10:22:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2261596456140259502=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, icenowy@outlook.com
Subject: RE: btrtl: try to use OF machine compatible as config postfix
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <BYAPR20MB24723A54E913F0218DF87F83BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
References: <BYAPR20MB24723A54E913F0218DF87F83BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2261596456140259502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=634720

---Test result---

Test Summary:
CheckPatch                    PASS      2.36 seconds
GitLint                       PASS      1.29 seconds
SubjectPrefix                 PASS      0.93 seconds
BuildKernel                   PASS      31.82 seconds
BuildKernel32                 PASS      28.41 seconds
Incremental Build with patchesPASS      50.57 seconds
TestRunner: Setup             PASS      487.24 seconds
TestRunner: l2cap-tester      PASS      17.97 seconds
TestRunner: bnep-tester       PASS      6.12 seconds
TestRunner: mgmt-tester       PASS      106.62 seconds
TestRunner: rfcomm-tester     PASS      9.91 seconds
TestRunner: sco-tester        PASS      9.59 seconds
TestRunner: smp-tester        PASS      9.65 seconds
TestRunner: userchan-tester   PASS      6.46 seconds



---
Regards,
Linux Bluetooth


--===============2261596456140259502==--
