Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C810EC00140
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 23:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiHEXBS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 19:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiHEXBQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 19:01:16 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCA733A15
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 16:01:15 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id s2so3081808qtx.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Aug 2022 16:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=bNMjzy6vwpaDyk5d9EbzDC7IYXuUJIAbfvtSg1JzDEw=;
        b=HgGr6oOOgSdsSLasBsH4A+62F81gDjVCOTXPgqp2zfdO9xJ8QeiDD7OrK6e5KMKsxt
         R6eGcAy53UlWBIed5/OivQSLuTDJeyG3CvjO9XJ3T4hQyhwz94mK2Fq+GFvv8yyPb7e4
         1Vxk4hn9PxiyhZCkp0nITeIZCbwmOKjwy5ecqZrZIMSALoSbtmfCKqFRxmkTViQiaIpK
         EMZtLrs9o8MYcyWaXaV+nK7eHIrzzYp3zkeiSvAZI+ZI2lkDDZNHbi+S7VkaFyqVOATp
         OKEIuzU0n+E5TDsnN+E0rMZwws/EppkhJGo5kxxNI/EJolWXi3R7+cCS69453S/QaUs4
         4TXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=bNMjzy6vwpaDyk5d9EbzDC7IYXuUJIAbfvtSg1JzDEw=;
        b=6QPZE5sZWryJ8WRx7RkOxlvSzkUDO/v63B9s6IWoJEPCVE3izGbwCNlVrTPAnek2hN
         c5DvEWNkXnX4pwNrbd8qCdmUf0Z9zMg2WW4aqoG+/WngwpRUcgSaceCEP5upVscIbGuE
         4YoLFNhpUbu6MpmUnizDBiMEOW2+rkVfP+KUm6JQz93dwtHfCa9Hpw6Rx0bDqH4jltRX
         Nat9wxbb6aL6tHbR+mTcHE+83nh4GNBXxhwv1kVHsYbi58IRMcLsuiAEtVgM4YW3v/R3
         tZt3hhvA/k8SS/AtlIXdZbfyw6cZWuXaY5c1U/YO5Uja7S+o7K/x8Av0XzNsA+g7IASQ
         0gDg==
X-Gm-Message-State: ACgBeo1PkPJiyrHbDBCG1nwsnFUzhgsSKe7UZMLD8fEGxPeaHddGftPf
        jRT0JcKJXQkMS0CKHDlVOYSpCojQmI4=
X-Google-Smtp-Source: AA6agR5SXwjXLDqmaNvNPyh3wqlpo5I4kD0in8SbovuAWW0y++7Fg/ce6J4kt7Qz7ch645ZFgxwu/g==
X-Received: by 2002:a05:622a:1356:b0:31e:d9b7:4cc with SMTP id w22-20020a05622a135600b0031ed9b704ccmr7628235qtk.51.1659740474335;
        Fri, 05 Aug 2022 16:01:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.22.230.74])
        by smtp.gmail.com with ESMTPSA id i25-20020ac84899000000b0033ff6387ab8sm3372450qtq.57.2022.08.05.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 16:01:14 -0700 (PDT)
Message-ID: <62eda13a.c80a0220.2ca18.b06e@mx.google.com>
Date:   Fri, 05 Aug 2022 16:01:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7214587840057197428=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: ISO: Fix not using the correct QoS
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220805215601.3958596-1-luiz.dentz@gmail.com>
References: <20220805215601.3958596-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7214587840057197428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=665768

---Test result---

Test Summary:
CheckPatch                    PASS      1.66 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.86 seconds
BuildKernel                   PASS      33.33 seconds
BuildKernel32                 PASS      28.61 seconds
Incremental Build with patchesPASS      41.02 seconds
TestRunner: Setup             PASS      478.76 seconds
TestRunner: l2cap-tester      PASS      16.98 seconds
TestRunner: bnep-tester       PASS      6.29 seconds
TestRunner: mgmt-tester       PASS      99.96 seconds
TestRunner: rfcomm-tester     PASS      9.65 seconds
TestRunner: sco-tester        PASS      9.32 seconds
TestRunner: smp-tester        PASS      9.42 seconds
TestRunner: userchan-tester   PASS      6.50 seconds



---
Regards,
Linux Bluetooth


--===============7214587840057197428==--
