Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2ABC636D3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 22:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBAWgO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Feb 2023 17:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAWgN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Feb 2023 17:36:13 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC80D4C16
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 14:36:11 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id k2so14129996qvd.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Feb 2023 14:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gpSE1DRl/wpZGBRMztQ7wiQS6Qyt1jxmeRuy5z8QaVg=;
        b=UmcZWqZAqKu/Ex6U8TaJvlzFGrfQmKY9XyzJfmVTF74TJE51RuI6FDJiS1LGIqkC8j
         TF6PiIjdIwuIyMADm3Gb+Qm4UTR7LSQ1+Pycx2M1RQjXCtZCxhfDbED+b9M6fySpNAiP
         rDogiiA4jxS4Lja7yBfu9xeu/tmqSGVbQr54gS25jdlnDDkMTnUsKSjPN6jfumpjsxSd
         tlcd4rcLnlK0cmInOZwEzUZOG3or3f9804mXfgeTPdPkwTfn7VU/tblfSNYubLJCPnC0
         7zlXm+fTQr8VnG2vqiQFKgU3imFXptAyx6CugKKFA9Q+DFOGSBmEw4y1tWdBJKYbNXsB
         ioOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpSE1DRl/wpZGBRMztQ7wiQS6Qyt1jxmeRuy5z8QaVg=;
        b=v7JqWmGymzpdsac5ZM7huShVoS2UY9dctZQ8r/BbHsnR3/vKaoxnJiclnI2Q94eo7F
         sjVZdB7whkzL4/uK8UN9x2U24d4sraA16bF88iqHJz1aCjGQuS0jRc/jAumlVmoenIz+
         w32OnU1p8FSAle1LYYBP+ACyLfuM4NcXdVZY/Di/I4q2ccpm7XE4ghnKH7oTiwpwYICp
         KrW57taIExi2lYId6hUdbSpMPoSMccMG3dn8WcJISYj1wASbA621WAh/KUGE3F3fOOOF
         abpi2NH3GunNFM8oE0rJj3ZSKdf+DWjlAo0hqcEDq9LkT7wZsiMcLD8ZM9ybZfMd1YlP
         /nbw==
X-Gm-Message-State: AO0yUKUB0E19esELqP1s+sAnpht0ynhnNQN709zvK1Zg3imPZVqw54Rs
        B+WUChbrXu0xbtLwVY8Nth9u1CrsDm4=
X-Google-Smtp-Source: AK7set+gvYhJckW1Xu14ij0TRRofI38NatOMb/hn/JbKePNk4HCoXJAj6U39sZX3l64CDg+sXZwx4w==
X-Received: by 2002:ad4:580c:0:b0:53b:5054:9e18 with SMTP id dd12-20020ad4580c000000b0053b50549e18mr6087203qvb.36.1675290970887;
        Wed, 01 Feb 2023 14:36:10 -0800 (PST)
Received: from [172.17.0.2] ([20.185.156.81])
        by smtp.gmail.com with ESMTPSA id x124-20020a379582000000b006cbc00db595sm13045863qkd.23.2023.02.01.14.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 14:36:10 -0800 (PST)
Message-ID: <63dae95a.370a0220.25d9.c141@mx.google.com>
Date:   Wed, 01 Feb 2023 14:36:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1071602910878397112=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: L2CAP: Fix potential user-after-free
In-Reply-To: <20230201220704.1543663-1-luiz.dentz@gmail.com>
References: <20230201220704.1543663-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1071602910878397112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=717902

---Test result---

Test Summary:
CheckPatch                    PASS      1.17 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      37.93 seconds
CheckAllWarning               PASS      41.71 seconds
CheckSparse                   PASS      46.75 seconds
CheckSmatch                   PASS      126.54 seconds
BuildKernel32                 PASS      36.61 seconds
TestRunnerSetup               PASS      525.34 seconds
TestRunner_l2cap-tester       PASS      18.69 seconds
TestRunner_iso-tester         PASS      20.41 seconds
TestRunner_bnep-tester        PASS      6.76 seconds
TestRunner_mgmt-tester        PASS      129.22 seconds
TestRunner_rfcomm-tester      PASS      10.65 seconds
TestRunner_sco-tester         PASS      9.84 seconds
TestRunner_ioctl-tester       PASS      11.64 seconds
TestRunner_mesh-tester        PASS      8.60 seconds
TestRunner_smp-tester         PASS      9.80 seconds
TestRunner_userchan-tester    PASS      7.09 seconds
IncrementalBuild              PASS      34.40 seconds



---
Regards,
Linux Bluetooth


--===============1071602910878397112==--
