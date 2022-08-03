Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1244C19F2B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Aug 2022 23:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiHCXFC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 19:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiHCXFB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 19:05:01 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10234D818
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 16:04:59 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id l18so10617754qvt.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Aug 2022 16:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=XRuzGsN1D3UXMpGNkQlR2NJM8xE6M08/GTqchLWd43s=;
        b=DEVC8iWxPOKxbkJ4CWGzZp/UQywexxyN4pJKhuDFHsqiP5gZIsQ+mc9JSarZ9T1MAH
         8ubk2Icf8USIMupmpqUSOP+6WgE6nB471ZJ/qIn+PNsvrl349SwS3ac32UV8/pZVfcwY
         Reiy6Ixc+MHj5ez7tiOgcEoO+KF3VahuUxcatrGyEebEvkM/XXvmMfkGxAFG9ZaO0QZO
         1MyufjZUp216PcIeuSgLQ0wFc5SV9KM5HCkNFZrm5B12WNh2wYskmB5PjMF4mjLMtmDU
         NlMdujzImW5+rFQu5N8zKBNjB9qJ2xnhofrlIiyR4P4INGN0UnmZH3xEobVmEHwhTm3/
         PhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=XRuzGsN1D3UXMpGNkQlR2NJM8xE6M08/GTqchLWd43s=;
        b=ZAT0kgSjsV6MGzq1ZxKFKcLKq3irTvTDGieO436kcgPqlGl3ZoYJHM3luiXmhw4V3N
         /2XKsocVglx1yZOogmIRSuFmba0WNcRSGve3NrmLbPv+S+3Vej9bjQkyhq55UE6g/WCo
         w9/jbO6vcNbOqObHTbW7XmDIIg+3RrrSnxsIo408A/PlX+PaovosvN3SJAGpmBQQLsEV
         zZ36RKdFigEa0CiawavpbCh8YuiQf/UqsOdmTuHBgjfliAiYAPvKcoMPWxXBcUKlTxmG
         b/WXBbvY4xKlSHdLxIVk/calvtFn/sSgAdHQRwF1/dw2GgPZazFnCY5WEZ4uBNdbAocq
         4wUQ==
X-Gm-Message-State: ACgBeo2MciKsxRNE7OcA8ecs3RPP3OzXPZ00deelewG/i6LCa0X1D3ke
        oiuQ0SwlzUJOtU9jMOgJVT/Ea+8AbEs=
X-Google-Smtp-Source: AA6agR5Q8r4bg3IKDYGkT4+ZII8jEL67+Rnp3HYQj0nZee2qfdiG9KEXrsa/aEslwWaeLQOTFYrSAw==
X-Received: by 2002:a05:6214:21ad:b0:477:47ad:c2b6 with SMTP id t13-20020a05621421ad00b0047747adc2b6mr723163qvc.120.1659567898655;
        Wed, 03 Aug 2022 16:04:58 -0700 (PDT)
Received: from [172.17.0.2] ([40.117.44.100])
        by smtp.gmail.com with ESMTPSA id fv18-20020a05622a4a1200b0031ecb90454fsm12033302qtb.70.2022.08.03.16.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 16:04:58 -0700 (PDT)
Message-ID: <62eaff1a.050a0220.e5fb1.2b81@mx.google.com>
Date:   Wed, 03 Aug 2022 16:04:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8825112580555287449=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/2] Bluetooth: hci_event: Fix build warning with C=1
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220803215527.3070932-1-luiz.dentz@gmail.com>
References: <20220803215527.3070932-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8825112580555287449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=665193

---Test result---

Test Summary:
CheckPatch                    PASS      3.50 seconds
GitLint                       PASS      2.08 seconds
SubjectPrefix                 PASS      1.75 seconds
BuildKernel                   PASS      33.59 seconds
BuildKernel32                 PASS      29.33 seconds
Incremental Build with patchesPASS      48.03 seconds
TestRunner: Setup             PASS      476.72 seconds
TestRunner: l2cap-tester      PASS      16.95 seconds
TestRunner: bnep-tester       PASS      6.26 seconds
TestRunner: mgmt-tester       PASS      98.97 seconds
TestRunner: rfcomm-tester     PASS      9.69 seconds
TestRunner: sco-tester        PASS      9.33 seconds
TestRunner: smp-tester        PASS      9.41 seconds
TestRunner: userchan-tester   PASS      6.45 seconds



---
Regards,
Linux Bluetooth


--===============8825112580555287449==--
