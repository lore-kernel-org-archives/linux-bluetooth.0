Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C27AC00140
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 08:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240393AbiHEICO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 04:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiHEICN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 04:02:13 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5029995B9
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 01:02:12 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c24so1349411qkm.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Aug 2022 01:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=lnHzQJcOG5YiYTFwGgLRv8qijHfPDSrvpfKR1N0FqZY=;
        b=Ru/O8UiTsbLUgJ2+O0+VhE42+RixBMkTeaMG568KyJ8o0Z+LhGsheoaquO1kmexB+e
         ymG8B/dMWaPpfy/kctmSo8BjxOHYVY3vCxXzSNCoawO01FjVbABPZLfH7jTROYAwg3EW
         FI45F5ND6RhEZJOz2/7nkCmIMltqXAe1XkL6OHJyt8KQjpyN3hN4gqzy9i7WFtAOT4rO
         UK5aZYOwxa8X/YF85Ac+c58P3ReUuf8/llRQNXYqq9RGipon0mCOERQGbKuQCDTfYT3o
         XXW3DtsL5CwSWmztUIr4zA9nsOSPt9Yu3HSFyI1EsHX2Gso7hoI2SM1wtMKTgK9IeWk2
         TIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=lnHzQJcOG5YiYTFwGgLRv8qijHfPDSrvpfKR1N0FqZY=;
        b=64i0yKnowYqVKyI1Xpvpm/8u0zDaggTEaF/YHI1pnIXyzpRfxOryiTROiYIlM2wxpb
         TKJLtkKxAAHKMBP6d4GFrPFxmFWa/zWmoj5aSHq2UcQLSbEHnCT7HvHxELvhwL/p8VyP
         U6i8S20M1wc4FUrdk3ghHGy0B82yxhSXr3qgFp1YOgwVPbf9hlkCTzyZPQh0noU4DW9q
         cv+y0mvwgN+5ATQE86/pObZRqOkA7bhgiYAeuA0vrbYJhPfF7nJ010cBPpNoRB47KWof
         GXFcJj1Rr9LZr1eR7dcCZRXmH605RnXwths7W4pxU2ti2LnjcutJVZ/vhItIEWSnca/y
         S0ew==
X-Gm-Message-State: ACgBeo2HyEjnIhPzF/Uv8mMIzsFm3AKAq5U1tfAqtwHURpS/T9Dt8ISp
        fb/LqpI8Ny66dKHiUeivCC7TgWl4YXY=
X-Google-Smtp-Source: AA6agR7FYtpDO8oUebNQed3ORrwynTsZAGHA1B5wZXaM0HPYFCqIe/qwFRkdqKaddrpK1BXMoQM5eg==
X-Received: by 2002:a05:620a:1a81:b0:6b6:4ae:5917 with SMTP id bl1-20020a05620a1a8100b006b604ae5917mr4089687qkb.349.1659686531160;
        Fri, 05 Aug 2022 01:02:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.11.181])
        by smtp.gmail.com with ESMTPSA id bq23-20020a05622a1c1700b0031eebfcb369sm2086268qtb.97.2022.08.05.01.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 01:02:10 -0700 (PDT)
Message-ID: <62ecce82.050a0220.aacb.575c@mx.google.com>
Date:   Fri, 05 Aug 2022 01:02:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0255131554880753915=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
Subject: RE: [(urgent)] Bluetooth: don't try to cancel uninitialized works at mgmt_index_removed()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <244af2fe-5340-9e63-a354-d5ab7d155dc4@I-love.SAKURA.ne.jp>
References: <244af2fe-5340-9e63-a354-d5ab7d155dc4@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0255131554880753915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=665551

---Test result---

Test Summary:
CheckPatch                    PASS      1.63 seconds
GitLint                       FAIL      1.01 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      34.88 seconds
BuildKernel32                 PASS      30.75 seconds
Incremental Build with patchesPASS      41.93 seconds
TestRunner: Setup             PASS      502.14 seconds
TestRunner: l2cap-tester      PASS      17.94 seconds
TestRunner: bnep-tester       PASS      6.99 seconds
TestRunner: mgmt-tester       PASS      105.50 seconds
TestRunner: rfcomm-tester     PASS      10.44 seconds
TestRunner: sco-tester        PASS      10.18 seconds
TestRunner: smp-tester        PASS      10.16 seconds
TestRunner: userchan-tester   PASS      7.21 seconds

Details
##############################
Test: GitLint - FAIL - 1.01 seconds
Run gitlint with rule in .gitlint
[(urgent)] Bluetooth: don't try to cancel uninitialized works at mgmt_index_removed()
1: T1 Title exceeds max length (85>80): "[(urgent)] Bluetooth: don't try to cancel uninitialized works at mgmt_index_removed()"




---
Regards,
Linux Bluetooth


--===============0255131554880753915==--
