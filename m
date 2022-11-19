Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796C0C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 05:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiKSFCL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 00:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKSFCK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 00:02:10 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B5FBB9D7
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:02:09 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id h2so2793068ile.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6upuZTEjRvTA2I62ya44i7Qq0RkdMqXPGG8SHgF2oJU=;
        b=Ie5XVuaJXqKQjTYiTk2Dr5CQxlirTRUt+qxfDsPeJWyWHXdVrOu63kLud5Kry1lt5D
         nDgyt8huAIyDDitvrq5Ti+6zk5A/TVLYe1N9kKnN9QueJF5yexO1zAWSsS7Z1wcxMh3h
         bQx5bJ4ExmzOUo+wjYfmK9B6m06u3JpH3pWXpuBY6klibfyY/kIgHnMDf9zFwAqCFWUr
         8pe2l7CxnAzQKIVE31CZRhudhqAwpVWneg2CuMrj+Mx5NTDU06XgVbtV1Vn5gsUKjcKO
         8lJt3aQSHjHO9ZnuPvtmfpE4LEHAkgZsQRhXj8KwzEiX1+bqbYZVNhUM8Sjn0Zj+A1I4
         kg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6upuZTEjRvTA2I62ya44i7Qq0RkdMqXPGG8SHgF2oJU=;
        b=2Ri72wdkabq9dvLBT+rrG2Fvc9x4Xqa8aCNxNqusT3tza4mwAU4kU663jDqjbMZjL5
         oKkn5u9umF0XQ1Og9Y8NNgPswKF0Y+HuZbQWmiT+RgC8/AQI1t1E/IXXyaq2i8PijoUR
         9LuX41jihWF6XCkjWiA+w16XqRZTvosVCJbBUoHf5gU55bfYAOt6uqfdky5lH3QNGmqj
         /9TosATc++EhZpMmsBB6x4czLkntg9x/CCG3PRfw9lO2y6A5wmSlgZf38dGtg+zsRkzm
         uZ2KOvF4J0dkPIxuGYYqwjvrGHkxGYBalNwjDqH3jF+eds+DO13jBcOgaFbUyzaXMIhb
         PIWw==
X-Gm-Message-State: ANoB5pl1ki+LydYHw6o0NkrtPQ0sQNeiZ6xm7w5csy/J7nsV3BiwlCZb
        q9Sra+uK14Hm25bzmmGTmNUh0rEPYb5ftg==
X-Google-Smtp-Source: AA0mqf78ITadXHtvmIUbgNSvO1ymrqEFtr2/1SRU1QeUAn7QIZLtAc3gdhj8/PPPgexYp0zEuQcuhw==
X-Received: by 2002:a05:6e02:88e:b0:2ff:c490:cf9a with SMTP id z14-20020a056e02088e00b002ffc490cf9amr4478733ils.169.1668834128806;
        Fri, 18 Nov 2022 21:02:08 -0800 (PST)
Received: from [172.17.0.2] ([20.29.123.45])
        by smtp.gmail.com with ESMTPSA id r28-20020a02b11c000000b003753a8178ccsm1881741jah.160.2022.11.18.21.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 21:02:08 -0800 (PST)
Message-ID: <63786350.020a0220.625b7.4cd8@mx.google.com>
Date:   Fri, 18 Nov 2022 21:02:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5661296018375282846=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [RFC] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
In-Reply-To: <20221031220205.91975-1-brian.gix@intel.com>
References: <20221031220205.91975-1-brian.gix@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5661296018375282846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690652

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      33.72 seconds
BuildKernel32                 PASS      30.16 seconds
TestRunnerSetup               PASS      420.94 seconds
TestRunner_l2cap-tester       PASS      15.68 seconds
TestRunner_iso-tester         PASS      15.07 seconds
TestRunner_bnep-tester        PASS      5.26 seconds
TestRunner_mgmt-tester        PASS      103.94 seconds
TestRunner_rfcomm-tester      PASS      9.08 seconds
TestRunner_sco-tester         PASS      8.59 seconds
TestRunner_ioctl-tester       PASS      9.86 seconds
TestRunner_mesh-tester        PASS      6.69 seconds
TestRunner_smp-tester         PASS      8.41 seconds
TestRunner_userchan-tester    PASS      5.52 seconds
IncrementalBuild              PASS      31.24 seconds



---
Regards,
Linux Bluetooth


--===============5661296018375282846==--
