Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC73DC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 May 2023 15:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjETP5A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 May 2023 11:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjETP47 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 May 2023 11:56:59 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6781A95
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 May 2023 08:56:58 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-62385de2d40so9418096d6.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 May 2023 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684598217; x=1687190217;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qMH0nr4XVtZMQVJLc9zV0M1MrBtoWpErO85hiGJz3Ss=;
        b=M81ac6MdFmjVstDwzL1SrDPmhKosKbMU+hiJsYYzvcrDCLAilutNn/Dk/yptKQrNB8
         /BVrmWhhtu178pUxauSj6OYowCgMWNbF2jyygiS5y42hUN+BloMbvhiU0XVpOnYZ+/bA
         /ZZgehh593nhAGvmF9I6nh7Hut26G/fvE1I7v05jcaaqa+dO0VCnZi1ERu6ap6M67O/9
         NPBrbWKcaD1/iErWduesup50yKPCL1xgDaxFsX4xUyuQtr/pLxOgUM3kCii5ere/UE8x
         Q40w93dG26Mfe7cfI7qO9kc77Snn2CHET/IauZWR9REVvQ0he/Hz6852vG2B/dQYTvpR
         LKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684598217; x=1687190217;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMH0nr4XVtZMQVJLc9zV0M1MrBtoWpErO85hiGJz3Ss=;
        b=jKStgGkIzDvWST3R9dbswSRA0PmOfb9mNo2X9OMYbGXbau5DH3WmMkMVw9svH3tokg
         oB5js64kjs9lWfyXweeSfrA6SnFLP4NbAAVJSlWRoC7ygupkwmcLv8gMA0gjV2Y/7gDn
         QiR/fiMexA42hdhMoPPPXlFGKcpHgQYHUwT0Vej16m6Zqjk//YkNaZ1GKy5cTZo30IEZ
         SpevxyCTunMHiKE9+aKG9/iuoupbV7NR4QEJlg33vsFLASaW/OnE0lD905fK+SKigWWG
         L8WHkx6bs2HiGkHfZJWw6I3sIRllf8uFD/0hIUctsjKaAt0AFv7/2rOv6WVp+6djfWk5
         Zj/w==
X-Gm-Message-State: AC+VfDzWkq9aNDmIlbhp8afhIAk8PeCXl0VTL+wfF7OXeF3XdUnNSC3p
        riiq83Wsc8l2jAS9LJ0hecuIoL6GJZrJmQ==
X-Google-Smtp-Source: ACHHUZ4H/9U6lGFeFkBc7+z2mEe9gEUoZEd37SptRweQwQaNbNCndeM8xKvZcltw0wCQET9jBKbDtA==
X-Received: by 2002:a05:6214:27e6:b0:5d8:eac2:3b54 with SMTP id jt6-20020a05621427e600b005d8eac23b54mr13066238qvb.16.1684598217398;
        Sat, 20 May 2023 08:56:57 -0700 (PDT)
Received: from [172.17.0.2] ([52.191.76.16])
        by smtp.gmail.com with ESMTPSA id ml22-20020a056214585600b0061b73e331b2sm643220qvb.30.2023.05.20.08.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 08:56:57 -0700 (PDT)
Message-ID: <6468edc9.050a0220.30bd7.2b5f@mx.google.com>
Date:   Sat, 20 May 2023 08:56:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4724642998100799612=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: RE: Bluetooth: hci_ll: Use the devm_clk_get_optional() helper
In-Reply-To: <2035c65977818626011f512d17cd018b6d877925.1684595848.git.christophe.jaillet@wanadoo.fr>
References: <2035c65977818626011f512d17cd018b6d877925.1684595848.git.christophe.jaillet@wanadoo.fr>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4724642998100799612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=749494

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      32.27 seconds
CheckAllWarning               PASS      35.06 seconds
CheckSparse                   PASS      39.96 seconds
CheckSmatch                   PASS      108.89 seconds
BuildKernel32                 PASS      31.10 seconds
TestRunnerSetup               PASS      446.95 seconds
TestRunner_l2cap-tester       PASS      17.26 seconds
TestRunner_iso-tester         PASS      21.31 seconds
TestRunner_bnep-tester        PASS      5.71 seconds
TestRunner_mgmt-tester        PASS      116.57 seconds
TestRunner_rfcomm-tester      PASS      9.09 seconds
TestRunner_sco-tester         PASS      8.35 seconds
TestRunner_ioctl-tester       PASS      9.72 seconds
TestRunner_mesh-tester        PASS      7.16 seconds
TestRunner_smp-tester         PASS      8.31 seconds
TestRunner_userchan-tester    PASS      5.99 seconds
IncrementalBuild              PASS      29.29 seconds



---
Regards,
Linux Bluetooth


--===============4724642998100799612==--
