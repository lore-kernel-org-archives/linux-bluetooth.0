Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE0FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 21:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241350AbiESVHY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 17:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244979AbiESVHR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 17:07:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBA4EC330
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 14:07:16 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id a19so6091411pgw.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 14:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=70y+poCBFkASXvNkW46u1mn7duWk2uDvEibHGI2Ygug=;
        b=Sqk/3g5LcogcTzObv6kJaTIZbKv8/wuVbQ8fAMULPqsTLDMk13pQXpCNLLuHFpUzxR
         6aZmxCrzqKacsBvAZcfQQ0tEz+uCQgS8aBT8F7ep7dLZ/xx6I1DRXLMW2KepXLQtWvSj
         pWVnYAUMd97qGxDEMr9tolrdbh6uouIsZz/OlTDfHJyLz+UEwxz8okCqdDBPprQb608Y
         bcmUhh09xN1zhhWsnQEdH9nRNmXvdcHGuSFiZduzjgp6Lf3jg3aV99gNR69cczXZ6xhz
         4vfqn0Mx9LxKPYpg/7Nfjjt+vqx9lcfr1ZicllykICa5Lqg7VMaPM+b+yVpgjfdwvD/8
         kkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=70y+poCBFkASXvNkW46u1mn7duWk2uDvEibHGI2Ygug=;
        b=q4VyzmJF6RS9lwSde3CiEizKhr2SSalPHDYYo75g68AAaT5zou4mQjDDgs90UXpwSl
         w7KohnVZWjcW4WjaEe9ZcltY2WJ/hTMTQ5VKeDNSBpE/QU12A6tASVQrsSbYlPRELsu6
         JXmH7d5PPcXx0zkisfZAc+Phsuut+5wcYDQ537CjODPhspAEZlpcq0e3bEhXpFHuLY/5
         o51xjt79ksOp4EHLIoEM97RcPDj1tPuz025tsKT6X/+J2124hU/otqCthCOC5XVIE1eu
         Y4Rykq6bhQVwNoxKBVXmk4NcH8bKm2G1HY69h8uomRO2znnupKImCTDnJDF3P8Ef57KG
         Jh0w==
X-Gm-Message-State: AOAM530JxnX2NMclILQ/kX5x1/EgmsXTpKrM+2QTIMNl5M6KjQDCilC7
        Fs0hKM2scj+BWdZHaadiEc8zyqfg/us=
X-Google-Smtp-Source: ABdhPJw+K3FIbDQ+KajoprbMtrTh/k8isYLrecBid8V72hMgfxXHJDW/2w5GImbQMRBpKxFa0tKLxw==
X-Received: by 2002:a63:5523:0:b0:3f6:3789:cd7a with SMTP id j35-20020a635523000000b003f63789cd7amr4632640pgb.623.1652994435426;
        Thu, 19 May 2022 14:07:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.250.21])
        by smtp.gmail.com with ESMTPSA id b12-20020a170903228c00b0015e8d4eb29csm4212242plh.230.2022.05.19.14.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 14:07:15 -0700 (PDT)
Message-ID: <6286b183.1c69fb81.94d0c.a4f2@mx.google.com>
Date:   Thu, 19 May 2022 14:07:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4573825656665538004=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/3] Bluetooth: hci_conn: Fix hci_connect_le_sync
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220519202258.2459530-1-luiz.dentz@gmail.com>
References: <20220519202258.2459530-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4573825656665538004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=643316

---Test result---

Test Summary:
CheckPatch                    PASS      2.73 seconds
GitLint                       PASS      1.14 seconds
SubjectPrefix                 PASS      0.72 seconds
BuildKernel                   PASS      42.02 seconds
BuildKernel32                 PASS      37.35 seconds
Incremental Build with patchesPASS      91.80 seconds
TestRunner: Setup             PASS      624.66 seconds
TestRunner: l2cap-tester      PASS      20.89 seconds
TestRunner: bnep-tester       PASS      7.58 seconds
TestRunner: mgmt-tester       PASS      128.15 seconds
TestRunner: rfcomm-tester     PASS      11.71 seconds
TestRunner: sco-tester        PASS      11.35 seconds
TestRunner: smp-tester        PASS      11.41 seconds
TestRunner: userchan-tester   PASS      7.90 seconds



---
Regards,
Linux Bluetooth


--===============4573825656665538004==--
