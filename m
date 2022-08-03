Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33B0C19F2B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Aug 2022 21:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiHCVI3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 17:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbiHCVI3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 17:08:29 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C3F4D16A
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 14:08:28 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bf13so16178465pgb.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Aug 2022 14:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=w67mP7Vl++aHT16k4c+DWpSnSJb3wyV1vjlr3V9902A=;
        b=MncgqV+1ZMHHDwkjxt8ptrBuz3YgSPA8712/OlpP1NGh8hT6ft/QoNAaS/NtS4FHoA
         3aI6mI5vQZM00mVXS5qPwYhfULcs9iM9jBufOXSpZEpFvdR4hmd2QXrCM6JGfP7O08xo
         4zTZwf5IMXBq2RMcBcIqEON1zJhs2xxW3sxCDjE+VZy0uZHt65kB1IZ0fYU6oasbIFVH
         cvjkZdG/gDLvZTDMQlq+GneWVzfn3VBrD3/ygbh7htJMOavPWLhT3Qhcwdoh5AnTUZcI
         LlDoO0eXnPhPso5Cx5r5y2+nS9n/ZEbnqLoQBay3SAotvZYYnqcciDDBxReY5P1TC/e5
         LCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=w67mP7Vl++aHT16k4c+DWpSnSJb3wyV1vjlr3V9902A=;
        b=tED2sNf6Lkor0MlSw6gMsBUhj5n/o5OOB1R+P6pCumamz99HFd8iGUar0nmfvKng46
         0+qHZ2XRyWhFqZsXLYx6mPDMR/P1funs9nR2cBNFUB+vJvy5tsOLBqxpUu5koRDVuK0v
         xFuZTaWroegTs03xToNYS0LU/ZdZWAEm+6ggFgvW7CmXenpYKgnyvCREFVjsCDaVWB7R
         t9XiInKtnj7XkrsQQcI1K/9YxpFAa5q4sGHm/XFVMxnhJq3joxTdT+aE20bC0FLIrGX3
         qn2OA1U1E4mqfpQW4D6avvnkDlwrtHAm+2zoTJ3Hoyl4t9H6hLJxuu/Y90Oj7Dz0FCxo
         xCVQ==
X-Gm-Message-State: AJIora8uiaeGyqx0wcd5DRSYcFfBGb3ET0sbPsVmsPG1jGG0OyY3td/r
        ZVduziXV97I34wHaARUP5cmTuzqVVpo=
X-Google-Smtp-Source: AGRyM1s+Y8cXAFzE3mHSbBbFRpfQNfEYtFn9ue8m/mytct8BrcMpBRgZOGu+uvvBLHTVluCQWCcbCA==
X-Received: by 2002:a63:2b84:0:b0:412:5277:99dc with SMTP id r126-20020a632b84000000b00412527799dcmr21983527pgr.208.1659560907701;
        Wed, 03 Aug 2022 14:08:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.149.145])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902714500b0016ed715d244sm2421925plm.300.2022.08.03.14.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:08:27 -0700 (PDT)
Message-ID: <62eae3cb.170a0220.a0e9b.434e@mx.google.com>
Date:   Wed, 03 Aug 2022 14:08:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9054454712753948574=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [1/2] Bluetooth: Disable AdvMonitor SamplingPeriod while active scan
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220803132319.1.I5acde3b5af78dbd2ea078d5eb4158d23b496ac87@changeid>
References: <20220803132319.1.I5acde3b5af78dbd2ea078d5eb4158d23b496ac87@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9054454712753948574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=665174

---Test result---

Test Summary:
CheckPatch                    PASS      2.05 seconds
GitLint                       PASS      0.86 seconds
SubjectPrefix                 PASS      0.57 seconds
BuildKernel                   PASS      42.46 seconds
BuildKernel32                 PASS      37.16 seconds
Incremental Build with patchesPASS      59.22 seconds
TestRunner: Setup             PASS      622.69 seconds
TestRunner: l2cap-tester      PASS      20.79 seconds
TestRunner: bnep-tester       PASS      8.24 seconds
TestRunner: mgmt-tester       PASS      127.00 seconds
TestRunner: rfcomm-tester     PASS      11.95 seconds
TestRunner: sco-tester        PASS      11.45 seconds
TestRunner: smp-tester        PASS      11.58 seconds
TestRunner: userchan-tester   PASS      7.87 seconds



---
Regards,
Linux Bluetooth


--===============9054454712753948574==--
