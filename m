Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D8EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Oct 2022 21:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiJJVNS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Oct 2022 17:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJJVNR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Oct 2022 17:13:17 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44B06DFBB
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 14:13:16 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id g13so6273810ile.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ubtpV2CoP0ltCPIrXpsz31+lei7JJ9Wj82r5uHIsyKE=;
        b=IPPt2siiJ9xVcmF3MQ0pobXAANJjPmhGTV9eT0Q7p2Osh84DphdsefNExYfZ2yYmmd
         BtiKWmEFJTD8MUKOJRR6E2VjKv0vgw5ffJF+cauIX6Bwi5Igb9BKRrY+hTRDY9Zn/zA5
         tkNZw2V+DbhhC1pl4P2S97hqsLmTwzz6Yw66H9ZhS4rCHIYx/5sIOT1t2CdSoTABCq8G
         9XQRoRuK+kP64oBIlSbW7tHBx3Qwf4PUzwW/SHVMnl/FZVJHawpmCOiTVmIfP7nXi56y
         22Ic2x7HA23tPK4ySuH7jo8hj6SRo93wfhB+oc26jwOVG/nTCeRTwtpIdeFHbhhVaPlT
         TsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubtpV2CoP0ltCPIrXpsz31+lei7JJ9Wj82r5uHIsyKE=;
        b=VsBxf26LesmpOxDpeME6RLKZhuz5jl0wJEunHfEZaNLfx5yk2Truxn1ZYl3hK4s9uk
         XB7V79uyeQI+E+s5jeqycz7CFWfTX7vt72HcOybISmSt6AEUezc5+Tm9n3YOmyIFsJWc
         roinBWWDxMv5PgvXhkT3bNgaYK1F41Is6sh2HFelkjo/6OXt5RyVQF8yg1xWLokGUoJO
         /GDRjBn5qMfZu25z9hIQoon9eiguAySjjFFkKaiz/Gqb68J+EM1nh2z60e5gW94wbKDC
         k6sIpeGkbD+6NhTBcSEUwKcKZTIH6S5BBU3N63Mqnmdljm4Cnkgw6Tq9LrvgFNbY9hH6
         IYFA==
X-Gm-Message-State: ACrzQf0n4q5EWb2W6+PJJo3BJw1DG5PNVD6we2HKY3NTRhmbN5fVggQY
        QXACLm+d0QWkULjeipq1o95x9xhI7Pc=
X-Google-Smtp-Source: AMsMyM7Z30ZKToMKx+W3Jp3N9U/iEjwIb9e1X1YU7xtrOdiSe5FSNqDBsfIkaM6KyrPpBSnoCT4UmA==
X-Received: by 2002:a05:6e02:1a2c:b0:2f2:3529:1a07 with SMTP id g12-20020a056e021a2c00b002f235291a07mr10245484ile.200.1665436395995;
        Mon, 10 Oct 2022 14:13:15 -0700 (PDT)
Received: from [172.17.0.2] ([40.69.172.65])
        by smtp.gmail.com with ESMTPSA id p14-20020a02b00e000000b003633eb91999sm4287427jah.155.2022.10.10.14.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 14:13:15 -0700 (PDT)
Message-ID: <63448aeb.020a0220.c3987.4386@mx.google.com>
Date:   Mon, 10 Oct 2022 14:13:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7224867214203715379=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [1/2] Bluetooth: hci_sync: Fix not setting static address
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221010203522.1251151-1-brian.gix@intel.com>
References: <20221010203522.1251151-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7224867214203715379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=684318

---Test result---

Test Summary:
CheckPatch                    PASS      2.59 seconds
GitLint                       PASS      1.52 seconds
SubjectPrefix                 PASS      1.31 seconds
BuildKernel                   PASS      34.07 seconds
BuildKernel32                 PASS      31.07 seconds
Incremental Build with patchesPASS      51.01 seconds
TestRunner: Setup             PASS      511.19 seconds
TestRunner: l2cap-tester      PASS      17.17 seconds
TestRunner: iso-tester        PASS      16.48 seconds
TestRunner: bnep-tester       PASS      6.24 seconds
TestRunner: mgmt-tester       FAIL      108.40 seconds
TestRunner: rfcomm-tester     PASS      10.01 seconds
TestRunner: sco-tester        PASS      9.54 seconds
TestRunner: ioctl-tester      PASS      10.59 seconds
TestRunner: mesh-tester       PASS      7.67 seconds
TestRunner: smp-tester        PASS      9.43 seconds
TestRunner: userchan-tester   PASS      6.46 seconds

Details
##############################
Test: TestRunner: mgmt-tester - FAIL - 108.40 seconds
Run test-runner with mgmt-tester
Total: 494, Passed: 492 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
Set Static Address - Success 1                       Timed out    2.669 seconds
Set Static Address - Success 2                       Timed out    2.002 seconds



---
Regards,
Linux Bluetooth


--===============7224867214203715379==--
