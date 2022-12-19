Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE25C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Dec 2022 22:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiLSWbp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Dec 2022 17:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLSWbo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Dec 2022 17:31:44 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2368DFB0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 14:31:43 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id x25-20020a056830115900b00670932eff32so6211134otq.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 14:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/oYWJr9SrqfmHplYs7/9CbKDoWpCwxaDwLbqkL/OaTg=;
        b=aW4qB0gs2Dv6j6dg4mbZILoe0fRk+ssBULETp5s50Re8uKexDypyRy4DHQIT/8rm7m
         1+AUWt+qMBtLg5Yy8zuB5EZoWEyWdo1WZ8TT2mqs36MGcLW/8TV0prTM+eNeOOT+Mc7z
         Jj/gHbDvxAKd+BK+lYp1yqCtl/Hs5oBhPJSyLtbfisNaaSidk4bgXbz34IoAn4H0Bi0I
         YtPKeZIKy0Jvu5hGKtEYhCEppweVu2MWNc47Kf6AYBvb5r6/gEe5ODjK0kGJLa0gf2D3
         Xo4ZBJUebyoelRVTekBG9cVay+Hb6fm0UXv3JjAJp0pbjM1pFw6dWRYMxjdGg74P4cnY
         TJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/oYWJr9SrqfmHplYs7/9CbKDoWpCwxaDwLbqkL/OaTg=;
        b=xq2kx2hrZIA9gnygRPSqGlxzQ5SqvmVcr9kZMEgYzt0t/o7p71AcomSxOi4FR01sPA
         3YUh7PLoyBky2iuElOYkMW7tAF6bUKXBUCtlgGtQEiXKowDBQcRqjo3kHE0y4xRd9zuA
         PQSkHr9owFg3f1f1xY8fMybn44A/AeDthicjG8qb+H4drpOrmuK1BljpCGirE8LVfHJQ
         1YIYJLxdCvNDNfbG3paF33iA4INdZ4t7txurxru1jwSHvVH85cV6NAjERP5Sj7Wno5Es
         +Vbb0f9RgVUiB9vLZx52DL/Q6WMPuiGoH33r350H4sRdt9lRTrR304eBVQC6rlWAcJQ7
         kEkw==
X-Gm-Message-State: ANoB5pl0rZmDFqavioYhffbp3Gp/Vz+qDOHvSfWqgolG9p82Zx6d7URr
        2PrgB8fTlG+iKOV/ByDtE4Eq2dZPQtzFTA==
X-Google-Smtp-Source: AA0mqf5EH1lGDh/H/4jnB4ACd6obh21+M+wOabIF2A6oPO/+lllc/1aUR5MVJQHUGtmW74sRa2kzWQ==
X-Received: by 2002:a9d:70ca:0:b0:670:804b:21f with SMTP id w10-20020a9d70ca000000b00670804b021fmr18378436otj.26.1671489102825;
        Mon, 19 Dec 2022 14:31:42 -0800 (PST)
Received: from [172.17.0.2] ([20.165.57.34])
        by smtp.gmail.com with ESMTPSA id 89-20020a9d0862000000b0066e820696edsm4913745oty.13.2022.12.19.14.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 14:31:42 -0800 (PST)
Message-ID: <63a0e64e.9d0a0220.ba65.1a56@mx.google.com>
Date:   Mon, 19 Dec 2022 14:31:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5378276736529828407=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RESEND,1/2] Bluetooth: MGMT: Fix Set PHY Configuration command
In-Reply-To: <20221219213702.3659417-1-luiz.dentz@gmail.com>
References: <20221219213702.3659417-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5378276736529828407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=705741

---Test result---

Test Summary:
CheckPatch                    PASS      1.88 seconds
GitLint                       PASS      0.59 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      32.55 seconds
CheckAllWarning               PASS      35.03 seconds
CheckSparse                   PASS      40.20 seconds
BuildKernel32                 PASS      30.04 seconds
TestRunnerSetup               PASS      444.98 seconds
TestRunner_l2cap-tester       PASS      16.75 seconds
TestRunner_iso-tester         PASS      17.06 seconds
TestRunner_bnep-tester        PASS      5.81 seconds
TestRunner_mgmt-tester        FAIL      114.16 seconds
TestRunner_rfcomm-tester      PASS      9.12 seconds
TestRunner_sco-tester         PASS      8.40 seconds
TestRunner_ioctl-tester       PASS      9.90 seconds
TestRunner_mesh-tester        PASS      7.18 seconds
TestRunner_smp-tester         PASS      8.36 seconds
TestRunner_userchan-tester    PASS      5.99 seconds
IncrementalBuild              PASS      56.30 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 491 (99.4%), Failed: 3, Not Run: 0

Failed Test Cases
Get PHY Success                                      Failed       0.134 seconds
Set PHY 1m 2m coded Succcess                         Timed out    2.777 seconds
Start Discovery LE - (Ext Scan Param)                Failed       0.141 seconds


---
Regards,
Linux Bluetooth


--===============5378276736529828407==--
