Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E22C47082
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 19:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE4E46024A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 19:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhFHT7b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 15:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbhFHT7b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 15:59:31 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C71C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jun 2021 12:57:22 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id q21so31910415ybg.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jun 2021 12:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNFhaATKL9cFgTS2eiccK4GiRji7Y9SK+W6sRYw5bJ0=;
        b=ooxf93GA4dcFUh31zlbCY3pHD3qk3Wkq8uKsFJzC5FIpi081RvIZvpmP3OicUM1VQx
         2WL/YzP9aucNtXmf2ViXrZocsP1qu6kWisp3zRK+Pq5LMWHvPbWdJqoai9AtDByRkn1z
         s4tNFvVUAeo2HwsScl8PG5dIFzxYS4HFNIl3Z7lvHfbXgwVRNcPb07qtGGfw3GPWbxBZ
         +Yfl3tCJozwVQ/bjgD6kWk4YDIU3o3yf4oTkLi7KbILbBPqWWuR7YFGXOK1q2dnbnCcH
         4ckOQIOog1gexSjWYZt3J6GaS5gSMHhqM3g6YFPB27EO/TtXd1L4jwPRTCNUPytfrfOf
         qLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNFhaATKL9cFgTS2eiccK4GiRji7Y9SK+W6sRYw5bJ0=;
        b=AGKJ1ZAJYfOgSynVKS916RZ5jjKMAr1JEpL+Ds90VfAjqrjYSMH2D2SgaTByBT/coi
         UmKb6by3y09Kn16fFSerikn/7bX+cn+MbNRAg56aAvk4bnQOx6qmOsDbSyActu+ZB/DI
         uczYr4gucRJWb3Xg0ZifGbEb1OnN86FkkESTcUkjF+x1HrcLCX0u4+hL5REBVYFJJpun
         KyhWj51TOeu6Crt238fa2yorqdxVryOTBHnGnfRFF8c54f1hv+ijrxpkf5Bb+le3Tlph
         +TcIHH9y+YPpFEch0++NZ064WMy0e9tiCmH5WkiJLOgfyxfT8+pjUvi4az3eyqxaYJ/J
         UKRA==
X-Gm-Message-State: AOAM532AjJj4l276/qbHbHgYpNmqn+O4cwg9AXpBQCbihBVneh+Dcmod
        4RgOuobzmgItrLA1GosMsM+DQ33uZoNMWjVGJqQqKm9O
X-Google-Smtp-Source: ABdhPJyVMYTFf9V5f2/kVWPnvS/L0ULCTswcDJYDHBoCu/lBP9IEF36tlj1epBpYSB45PVrq1Uu0ORG6Sp1Yb83eZJE=
X-Received: by 2002:a25:6612:: with SMTP id a18mr34125027ybc.347.1623182241106;
 Tue, 08 Jun 2021 12:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210608184457.3069064-1-luiz.dentz@gmail.com> <60bfc808.1c69fb81.1d1c6.838b@mx.google.com>
In-Reply-To: <60bfc808.1c69fb81.1d1c6.838b@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 8 Jun 2021 12:57:10 -0700
Message-ID: <CABBYNZ+yuNRGU4m68GRGd0exodb-0hwkLaYQ8gCE+NPi4bq0Fw@mail.gmail.com>
Subject: Re: Bluetooth: HCI: Fix Set Extended (Scan Response) Data
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     "An, Tedd" <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, Jun 8, 2021 at 12:42 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=496525
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.03 seconds
> GitLint                       PASS      0.10 seconds
> BuildKernel                   PASS      512.94 seconds
> TestRunner: Setup             PASS      336.29 seconds
> TestRunner: l2cap-tester      PASS      2.59 seconds
> TestRunner: bnep-tester       PASS      1.87 seconds
> TestRunner: mgmt-tester       FAIL      29.48 seconds
> TestRunner: rfcomm-tester     PASS      2.03 seconds
> TestRunner: sco-tester        PASS      1.99 seconds
> TestRunner: smp-tester        PASS      2.06 seconds
> TestRunner: userchan-tester   PASS      1.88 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS - 1.03 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
>
>
> ##############################
> Test: GitLint - PASS - 0.10 seconds
> Run gitlint with rule in .gitlint
>
>
> ##############################
> Test: BuildKernel - PASS - 512.94 seconds
> Build Kernel with minimal configuration supports Bluetooth
>
>
> ##############################
> Test: TestRunner: Setup - PASS - 336.29 seconds
> Setup environment for running Test Runner
>
>
> ##############################
> Test: TestRunner: l2cap-tester - PASS - 2.59 seconds
> Run test-runner with l2cap-tester
> Total: 40, Passed: 40 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: bnep-tester - PASS - 1.87 seconds
> Run test-runner with bnep-tester
> Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: mgmt-tester - FAIL - 29.48 seconds
> Run test-runner with mgmt-tester
> Total: 446, Passed: 415 (93.0%), Failed: 18, Not Run: 13
>
> Failed Test Cases
> Add Ext Advertising - Success 1 (Powered, Add Adv Inst) Failed       0.015 seconds
> Add Ext Advertising - Success 2 (!Powered, Add Adv Inst) Failed       0.021 seconds
> Add Ext Advertising - Success 5 (Set Adv off override) Failed       0.024 seconds
> Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok) Failed       0.019 seconds
> Add Ext Advertising - Success 7 (Scan Rsp Dta, Scan ok)  Failed       0.016 seconds
> Add Ext Advertising - Success 9 (General Discov Flag) Failed       0.020 seconds
> Add Ext Advertising - Success 10 (Limited Discov Flag) Failed       0.017 seconds
> Add Ext Advertising - Success 11 (Managed Flags)     Failed       0.023 seconds
> Add Ext Advertising - Success 12 (TX Power Flag)     Failed       0.017 seconds
> Add Ext Advertising - Success 20 (Add Adv override)  Failed       0.018 seconds
> Add Ext Advertising - Success (Name is null)         Failed       0.015 seconds
> Add Ext Advertising - Success (Complete name)        Failed       0.024 seconds
> Add Ext Advertising - Success (Shortened name)       Failed       0.024 seconds
> Add Ext Advertising - Success (Short name)           Failed       0.018 seconds
> Add Ext Advertising - Success (Name + data)          Failed       0.023 seconds
> Add Ext Advertising - Success (Name+data+appear)     Failed       0.025 seconds
> Ext Adv MGMT - AD Data (5.0) Success                 Failed       0.022 seconds
> Ext Adv MGMT - AD Scan Response (5.0) Success        Failed       0.020 seconds

We will probably need to fix these once the patch is merged, it looks
like they are always expecting 31 bytes of data but the extended
version this is variable size.

>
> ##############################
> Test: TestRunner: rfcomm-tester - PASS - 2.03 seconds
> Run test-runner with rfcomm-tester
> Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: sco-tester - PASS - 1.99 seconds
> Run test-runner with sco-tester
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: smp-tester - PASS - 2.06 seconds
> Run test-runner with smp-tester
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: userchan-tester - PASS - 1.88 seconds
> Run test-runner with userchan-tester
> Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


-- 
Luiz Augusto von Dentz
