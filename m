Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74E6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 May 2022 14:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346549AbiEMOns (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 10:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382757AbiEMOnL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 10:43:11 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A0C1F8C5C
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 07:39:47 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c1so7154747qkf.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 07:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Ql2kFbFQYIgTMJYddn6MpxVM/SoDMktJ87BDG8Lt8ic=;
        b=ClT64VgGPoer+E+Ms7RxaS4Jy7lcLb4sgwVNL/F+QztJC/uJlQDtjU56ZkScozbRnn
         wUOnMmml0phlWA3Q5L1oB1O4tfcy6qAR+D1vZuaKtdQ+R2gK/b9K4FWg8xMSds5htYid
         d71DF+EEi9l8QbszK+6DE4sHZTBdY1qimeEoRxuByktEawPlJzfw3nm8iBP19t9FCRY2
         8KvpHvp2qWVnFrwLWDLxdf52ZHx6FKltKE/H9Hkt3cmklD+h8M1earjaBm9QX/+oflUT
         SpNmYFxH95fnb+Nf9eKB+SOxLMZu/JupnARCYObQQjRFaSnjRvoFudwA1i7itdHcU+IH
         s1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Ql2kFbFQYIgTMJYddn6MpxVM/SoDMktJ87BDG8Lt8ic=;
        b=EFSAnLDI/MDrx6pkOXB+D28k7GpRQR5Bn2wwVWTn8gj+E/hDTBSLeFKwjZalzxcLAM
         Ys6zxo+CvBmvN/zIwZR3VH57ZM8Mm6zXOb9YLsyyUUsQQzkiK5baca5IMBzI8VQa0Q67
         AInaRT+iZVUCMkZnDsknplP/svuMxqt55ZSgI3+dhV1tWn9TjVXbAs32zZOwoLAkIKpN
         1Ho+vTIBJXYPER8tz/aoUF4Gjf3ysaNsbM2wiZK/Ouz+iJOiSgbqKb0zjO/0IpH1D5Lz
         vZNYUQyDX5LcIJLT63u58foDJsA0MX/oMs8yqv6DElQcbHujfCMwZb6SyizV8F29Nf+R
         OVSA==
X-Gm-Message-State: AOAM530fovrfbSclNnmF33N8y1XBt86KRzp6OSKfbqgWue6SB8uv85SI
        jAA3tNZjU9F5WwTIg/JMdKBtHbLdP9QZ9g==
X-Google-Smtp-Source: ABdhPJz7KzrMeM0sK3uExxbLnUnxMruV6168Prw0t3IJdVbsJ1Ct1X5dc8g6OPnnDYrhoknFAIgtVw==
X-Received: by 2002:a05:620a:1182:b0:69f:fc99:490c with SMTP id b2-20020a05620a118200b0069ffc99490cmr4024071qkk.316.1652452786184;
        Fri, 13 May 2022 07:39:46 -0700 (PDT)
Received: from [172.17.0.2] ([52.188.205.149])
        by smtp.gmail.com with ESMTPSA id b17-20020a05620a04f100b0069fc13ce212sm1348964qkh.67.2022.05.13.07.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 07:39:45 -0700 (PDT)
Message-ID: <627e6db1.1c69fb81.5733c.77aa@mx.google.com>
Date:   Fri, 13 May 2022 07:39:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2686345786061373930=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, zheyuma97@gmail.com
Subject: RE: [v2] Bluetooth: bfusb: Check the endpoint type at probe
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220513140759.2196755-1-zheyuma97@gmail.com>
References: <20220513140759.2196755-1-zheyuma97@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2686345786061373930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=641424

---Test result---

Test Summary:
CheckPatch                    PASS      1.70 seconds
GitLint                       PASS      1.05 seconds
SubjectPrefix                 PASS      0.93 seconds
BuildKernel                   PASS      40.06 seconds
BuildKernel32                 PASS      35.18 seconds
Incremental Build with patchesPASS      47.73 seconds
TestRunner: Setup             PASS      588.75 seconds
TestRunner: l2cap-tester      PASS      19.89 seconds
TestRunner: bnep-tester       PASS      7.37 seconds
TestRunner: mgmt-tester       PASS      118.24 seconds
TestRunner: rfcomm-tester     PASS      11.25 seconds
TestRunner: sco-tester        PASS      10.99 seconds
TestRunner: smp-tester        PASS      11.14 seconds
TestRunner: userchan-tester   PASS      7.70 seconds



---
Regards,
Linux Bluetooth


--===============2686345786061373930==--
