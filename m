Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1879FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Oct 2022 03:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiJQD6U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Oct 2022 23:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiJQD6S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Oct 2022 23:58:18 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A3D52DFC
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Oct 2022 20:58:18 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id bb5so7017326qtb.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Oct 2022 20:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FYw9+F22EqzHZcBjzFGF3c6Z35iv7zrvMLY6i/gQPqM=;
        b=fXgnaR664JPmwAhawKPuNIgUdaTS58sDkFNUG9HgYlcailA4owr98JOIEGfzAPxrrK
         LSTZnADYSKGXoZMzTX19p8/w+m+QBT0JrDOpLBllsulBQvxemxQlIGcvnbhA8d2fzZpJ
         U9cA1Wgssj9UbvecmOXuetypi4y841viBrYsx0O2Vu9uj0GECKkQKPqmwwaBxG6iWJlL
         z+1FR4x2g4pupOzGaLDoPW4f4Jr53wULgMSt5F5kRZ4VQVvqGKwWb5/b3hHt09dUlu0S
         LgYeNwR8iGdw1nJV6otM7ZbAcnSEXbZ00xaoOl4xUm69PAHXjOyuOgzv5pTV2uDrF+3Q
         0wOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYw9+F22EqzHZcBjzFGF3c6Z35iv7zrvMLY6i/gQPqM=;
        b=bM3VSMesDr6AbS1O9JGAWxfpDs08007dulYoMEcr8r2WUq8V2SGHSd4xKhMdWJD0nT
         tgszmsUAPhgHCcacrNuc0j7IzbYpOl5xdEr3NdFSWMpVTqempcqE95cHrc42OCQhKf3W
         gqCmoUjW2KVZKtHiDbaaEZf64lJTyFxuVZNEus4XHvR9Q6hyrgsyD8R6q+ZSJH9518C+
         70VnJqQ1jajzhRG+Nth3/h5ZDANukpCeMN5O4M9/WAV+1pDxUoRkK50GV120H3ivSipa
         Nznwj3ClqOdJl7oWpVRacgByPlJSXc60/KWv9r36GaynhueDGQym4PyU3t/+UcV9RabU
         jqSA==
X-Gm-Message-State: ACrzQf1bFufETa0vb1ltaEcghWXNKx+5K8nEsSYc2LcWiu+Ysvk64hzu
        CW+Oqo8p2WrR9CmNx/gqo4quVdocgy9Xvw==
X-Google-Smtp-Source: AMsMyM6thlZMgYmTZ/1eam2aNnvNmL/Cw04biCe5J9AdTYAS0VAMnaK2PB8RSmcLbE7AnjzgCKv+gA==
X-Received: by 2002:a05:622a:156:b0:39c:8dc:d543 with SMTP id v22-20020a05622a015600b0039c08dcd543mr7119364qtw.458.1665979096834;
        Sun, 16 Oct 2022 20:58:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.30.20])
        by smtp.gmail.com with ESMTPSA id d14-20020a05620a166e00b006be8713f742sm8429139qko.38.2022.10.16.20.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 20:58:16 -0700 (PDT)
Message-ID: <634cd2d8.050a0220.3674e.2dc7@mx.google.com>
Date:   Sun, 16 Oct 2022 20:58:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5756186868751074022=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiapeng.chong@linux.alibaba.com
Subject: RE: net: bluetooth: Use kzalloc instead of kmalloc/memset
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221017030421.69108-1-jiapeng.chong@linux.alibaba.com>
References: <20221017030421.69108-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5756186868751074022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=685678

---Test result---

Test Summary:
CheckPatch                    PASS      1.85 seconds
GitLint                       FAIL      1.00 seconds
SubjectPrefix                 FAIL      0.89 seconds
BuildKernel                   PASS      34.47 seconds
BuildKernel32                 PASS      30.51 seconds
Incremental Build with patchesPASS      44.59 seconds
TestRunner: Setup             PASS      507.42 seconds
TestRunner: l2cap-tester      PASS      17.03 seconds
TestRunner: iso-tester        PASS      15.91 seconds
TestRunner: bnep-tester       PASS      6.36 seconds
TestRunner: mgmt-tester       PASS      102.95 seconds
TestRunner: rfcomm-tester     PASS      10.09 seconds
TestRunner: sco-tester        PASS      9.50 seconds
TestRunner: ioctl-tester      PASS      10.62 seconds
TestRunner: mesh-tester       PASS      7.68 seconds
TestRunner: smp-tester        PASS      9.46 seconds
TestRunner: userchan-tester   PASS      6.53 seconds

Details
##############################
Test: GitLint - FAIL - 1.00 seconds
Run gitlint with rule in .gitlint
net: bluetooth: Use kzalloc instead of kmalloc/memset
6: B1 Line exceeds max length (104>80): "./net/bluetooth/hci_conn.c:2038:6-13: WARNING: kzalloc should be used for cp, instead of kmalloc/memset."


##############################
Test: SubjectPrefix - FAIL - 0.89 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============5756186868751074022==--
