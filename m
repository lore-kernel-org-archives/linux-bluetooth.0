Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E47C05027
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Feb 2023 01:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjBGBP4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Feb 2023 20:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjBGBP4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Feb 2023 20:15:56 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E873D9752
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Feb 2023 17:15:54 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id z6so4301110qvp.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Feb 2023 17:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oj35lx1M9RxRHoqfIQNZncHXjB683F8IGdiNs+Cc9j4=;
        b=N1VClMQUbV+V5FhXOoQyFjA0Xaau1E3ZZUDJoUnEsrpEWUHWAUcOjgeNO1aXZQiYfQ
         pwJr5aY+aONZDqeXi0WXJMy00aUoSK7fCC/2GBzpMP8AU8xBA5Ao6j2RM4tvxjug4dwE
         CQzolR9phlihV/cmw1sZRP1Dz71lrPmvTJOZBDWMzZm8+sDfHXeXeFz9yIdcMSRGLvKn
         YN0ABgm2KpyRlD0ON9YnC2sxWcRpHyynQVeYSyUyrVz/deSCcBee+PWkuLFS/0IJbHo3
         zTVlFO1A5SN+TIboEw7aHPsG9xz7v3BR673s975zZ0MH63AFnxBiAOpdhrM3uL4H1LsI
         It7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oj35lx1M9RxRHoqfIQNZncHXjB683F8IGdiNs+Cc9j4=;
        b=4wrG53EHaAQXrLkG9ZuPVW0noBw2Gnqf/cmJpWjAF6QS2XgjD8+LW4ylPrVxhojuPT
         DltV2eV3b7+YyoYC/ogFNt+VvZbPs60NBNplc1uqFZPpdJOhN5kTt1ipQX3MSLHTLePo
         WwafssZBTHurtgiu4XVmFw6T9SNws4CSLuODk1O+9xjtlRpxDVBPTeMy9Huj+ssxLQv0
         OWTFEzytkkXl/6rMAtsD+sBupYRvfZ2lcXYnjwtXoTJBMG1P0QI1dgYPbT5I2rtYFkSm
         xXTt3fXOrJkBocvovVnnU29hwqaMtqIMqHL8QzTGbRYz19LwwfTuRrev/qFOnV5tQuiX
         7urw==
X-Gm-Message-State: AO0yUKVnhMscjYOzWIAfyI0ZqAyTevwW1WWsnivnh130VZtUMDopcwoV
        RerHVtdL/sS0c94KJWFfWY19ezjnKAU=
X-Google-Smtp-Source: AK7set/GQQfQ1N6dH1aUpKxAtWrDU7A1ufsYTzjDeeXeupXg/VuSP9yf7SYKcYig888oryF7z7M+4Q==
X-Received: by 2002:a05:6214:d43:b0:56b:f097:a34b with SMTP id 3-20020a0562140d4300b0056bf097a34bmr2021955qvr.3.1675732553927;
        Mon, 06 Feb 2023 17:15:53 -0800 (PST)
Received: from [172.17.0.2] ([104.45.204.224])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a410600b0070383f1b6f1sm8319679qko.31.2023.02.06.17.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 17:15:53 -0800 (PST)
Message-ID: <63e1a649.050a0220.1a683.8d32@mx.google.com>
Date:   Mon, 06 Feb 2023 17:15:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3522974288386159238=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bage@debian.org
Subject: RE: Bluetooth: btrtl: add support for the RTL8723CS
In-Reply-To: <20230206233912.9410-2-bage@debian.org>
References: <20230206233912.9410-2-bage@debian.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3522974288386159238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=719291

---Test result---

Test Summary:
CheckPatch                    PASS      2.18 seconds
GitLint                       PASS      0.73 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      31.21 seconds
CheckAllWarning               PASS      34.24 seconds
CheckSparse                   WARNING   38.42 seconds
CheckSmatch                   WARNING   107.48 seconds
BuildKernel32                 PASS      29.86 seconds
TestRunnerSetup               PASS      430.17 seconds
TestRunner_l2cap-tester       PASS      16.19 seconds
TestRunner_iso-tester         PASS      16.39 seconds
TestRunner_bnep-tester        PASS      5.42 seconds
TestRunner_mgmt-tester        PASS      108.87 seconds
TestRunner_rfcomm-tester      PASS      8.57 seconds
TestRunner_sco-tester         PASS      7.96 seconds
TestRunner_ioctl-tester       PASS      9.31 seconds
TestRunner_mesh-tester        PASS      6.93 seconds
TestRunner_smp-tester         PASS      7.82 seconds
TestRunner_userchan-tester    PASS      5.75 seconds
IncrementalBuild              PASS      33.40 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:52:45: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:52:45: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============3522974288386159238==--
