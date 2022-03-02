Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F780C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 21:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245300AbiCBVOp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 16:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245356AbiCBVNV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 16:13:21 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830C9DD94B
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 13:11:51 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id s11so2968634pfu.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 13:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=50Nephl6fy1USBwU2EAcPAe5o7oNF9XmCVhDKcdgHU0=;
        b=k/Qt51uzJu4Gip8Ko+DPexOfWfq5bXJRzTWN60gXZW5CIgFMjzCBAs0vSLrk7hs1EO
         fvE4gRVm7ercvQLg0wxaeEtyZwXN8eoOiq950lJvJmMZ0VD8+zshBgd6n7zuO5+VHff0
         sGmHrrqI3SqXovpOfwO3whrfC72gWFen8+s39eESdI5ajg3r4K8H1UDJS0UPlVZrN57W
         tTtjjVUWbw9TDrNDqWm9kTO1vh4atkRhOgQu4QfIzd04EQt6YDHjTrZ5iWit6zkKQAkj
         yPuXfaAjLVwZf+i7vpBvqObpfluls+h/1dmiWzPu0uMTJTLvDASILntTZ6qDAoJcrKHX
         81xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=50Nephl6fy1USBwU2EAcPAe5o7oNF9XmCVhDKcdgHU0=;
        b=Cr+RWrCYZmi5gfB2L6c8aFUJn/v4ppDVWbJirkctjLpXLGmCGclAAfbTHZObVVOZEc
         WhHz5jih2pJ2VrBOR8/De70rce4tfeIgBYedO3XbtaRQmqMB6U09VPLS3MzzSollJPgB
         vW1ZdQkstZ3qpyjqIWv2HQP3klk1khbh5dtCOQcZhDJ2LoZczyoasqUswu5OJlHgGF2F
         8rhqzH1Sx96/NukWsU4Wv02b3CuYfxRfiKdUMTlgs9iLA4zUr9Pfe8ux3t701yywuBRV
         Boa0EzCC+zzefepRIeyX2rXmZSnlYcArbtIPQsGVgwhBvYWXilfbCmh6s5mzF9hNnGpu
         /YRA==
X-Gm-Message-State: AOAM5325/aXasMaaElekN6ml5vudvG6C42FNadRUOp6MGlpnUNSmsBKs
        KBCfGrMnAps6uaywf/sMLpHvpMkzlB4=
X-Google-Smtp-Source: ABdhPJxltXAtmGBNVNhtXf4IFftegx4umlqaRI/PMwunk9xIp2LQQ/EJb3iGb20JJzOl0hBf+W1q1A==
X-Received: by 2002:a65:5842:0:b0:374:58b8:2563 with SMTP id s2-20020a655842000000b0037458b82563mr27523461pgr.52.1646255510709;
        Wed, 02 Mar 2022 13:11:50 -0800 (PST)
Received: from [172.17.0.2] ([20.112.13.67])
        by smtp.gmail.com with ESMTPSA id q92-20020a17090a1b6500b001bc169e26aasm5375532pjq.2.2022.03.02.13.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:11:50 -0800 (PST)
Message-ID: <621fdd96.1c69fb81.7b41f.fa6a@mx.google.com>
Date:   Wed, 02 Mar 2022 13:11:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3659729772137072795=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: RE: Bluetooth: Don't assign twice the same value
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <e2c2fe36c226529c99595370003d3cb1b7133c47.1646252285.git.christophe.jaillet@wanadoo.fr>
References: <e2c2fe36c226529c99595370003d3cb1b7133c47.1646252285.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3659729772137072795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619692

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.42 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      38.87 seconds
BuildKernel32                 PASS      34.65 seconds
Incremental Build with patchesPASS      47.41 seconds
TestRunner: Setup             PASS      618.78 seconds
TestRunner: l2cap-tester      PASS      16.73 seconds
TestRunner: bnep-tester       PASS      7.50 seconds
TestRunner: mgmt-tester       PASS      128.99 seconds
TestRunner: rfcomm-tester     FAIL      9.62 seconds
TestRunner: sco-tester        PASS      9.64 seconds
TestRunner: smp-tester        PASS      9.54 seconds
TestRunner: userchan-tester   PASS      7.80 seconds

Details
##############################
Test: TestRunner: rfcomm-tester - FAIL - 9.62 seconds
Run test-runner with rfcomm-tester
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Basic RFCOMM Socket Client - Write 32k Success       Failed       0.224 seconds



---
Regards,
Linux Bluetooth


--===============3659729772137072795==--
