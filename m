Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7904BC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 05:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E7461029
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 05:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbhHRFuX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 01:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbhHRFuX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 01:50:23 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71116C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 22:49:48 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id x19so498776uat.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 22:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Qn1im2C26/pdifvb/kuJTeT1Tc9CnfljE4DMquw0Sg=;
        b=cL2tUX2SM7uLX4/wkrottYL4tOg92dsJuReISIqOOnIakooWKALgbAeSwHhtGXRJXY
         h3eILoqofomXWlYqU5F68XMJmRZ2657i2DgY+sQTutFR6cTM2jq1SBn7gYzBs+Bp6Sfr
         wAoTsw254cYslLmqAkQH9nszkDJJyhQYSmocm7Tn963fpdXREdPd4lpTtmAC1VPXM+dr
         vMH3b8TRlwq/TI4F05/5OWaL7V6m8th2ehFFw/HTXjvx3KSYndzI7lo3hCi4u1Ldyf1E
         91XmJVq/p1zsFv6DyWsnFYd4qL0t0E6ohK+ehs4TF+mSPkDZqgfBlxB3gds1Qz9uOkV4
         63Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Qn1im2C26/pdifvb/kuJTeT1Tc9CnfljE4DMquw0Sg=;
        b=CN6QXyzj9d3xeE+UW7Dxvg606qwbYg2pIZ5Me7wAI/enc66h8IS8RJ4DHHo+CX2YIo
         TfI0tIu8JIKKQH8D60CAkDxu3TolSPvHGkI9ep3RyBKCvgQFuCgnnBcGdcWTnVee/Gwy
         /cs5JGr8wolgVqkWYeiyK8pdXyDqQa3g5l4RRX0RsM+OHmDVogkVf7nHdd6H2c4gBsyc
         jr5KNIdQOD+aVmI+hzr8CyiMD7vrVzmnnyhkEh2lGcgEwB20XRxPMoJhVVEqFtvfcwMz
         vkzjeZ1YFEJbcEnY/vTWwBNudelWdWGaClZTwdbTo95icmbeZU8ATRDD99F5/2tt8XhX
         8Tow==
X-Gm-Message-State: AOAM531SOB5M3l3H0JOGEZH6mfoXOnY+VoTzCt0ybHa8OSskw8RvRUFi
        nBB/iLXc+j4Lm++/170yTkyRtGH0QlLtz6MksY7YDg==
X-Google-Smtp-Source: ABdhPJy7PzEtrWvtAEdhTjIMCPggrm+dEWmHLrkSJ3p+yuppnayrPaO2IZbyAVGXT25c2vgOJ52QFeCVyfxEzUwbigs=
X-Received: by 2002:ab0:7014:: with SMTP id k20mr5435838ual.9.1629265787360;
 Tue, 17 Aug 2021 22:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210815201611.v9.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
 <61191554.1c69fb81.89ead.b7d9@mx.google.com> <CABBYNZLcEctR6=ovTK_CABqkKgU8UCKQQ30VsVsAJkdEA+xY0A@mail.gmail.com>
 <CAHFy418ZxGDjGvr9RBkKAk1FJa9Lq6jB1D1esnJmX99eKadJbw@mail.gmail.com>
In-Reply-To: <CAHFy418ZxGDjGvr9RBkKAk1FJa9Lq6jB1D1esnJmX99eKadJbw@mail.gmail.com>
From:   Joseph Hwang <josephsih@google.com>
Date:   Wed, 18 Aug 2021 13:49:36 +0800
Message-ID: <CAHFy418sMhHOc1SAZ01P0qOAcWVfUGo3=0TC_9KSqs-2xscNUw@mail.gmail.com>
Subject: Re: [v9,1/5] Bluetooth: btusb: disable Intel link statistics
 telemetry events
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz:

  I am wondering if it is possible to merge these kernel patches
before fixing the mgmt-tester?

  The mgmt-tester failed due to its checking against the fixed exp
feature count and the corresponding exp UUIDs and flags. A more
flexible tester may be required so that the tester would not be broken
whenever a new exp feature is added.

Thanks and regards,
Joseph

On Tue, Aug 17, 2021 at 5:54 PM Joseph Hwang <josephsih@google.com> wrote:
>
> (Resent this email to contain only plaintext.)
>
> Hi Luiz:
>
>   It seems that mgmt-tester currently uses a fixed feature count.
> Every time a new exp feature is added, the mgmt-tester would  be
> broken. By checking the kernel, it seems that there are currently 2 or
> 3 exp features, i.e., debug uuid, simultaneous central peripheral
> uuid, and LL privacy uuid. Note that the debug exp feature is guarded
> by CONFIG_BT_FEATURE_DEBUG. So I am not sure how the kernel is
> configured and made on your test setup.
>
>   If we fix the mgmt-tester in bluez to have 3 or 4 (which one?)
> features before merging the kernel changes here that adds a new
> quality exp feature, it would not match the existing kernel which has
> only 2 or 3 features.
>
>   Do you have any preference about how to fix the mgmt-tester?
>
>   My suggestion is to remove the checking of the feature count from
> the mgmt-tester. The feature count changes over time. It is possible
> to implement a customized exp_feat_check function which can be more
> flexible. If a uuid is found in the MGMT response, its associated
> flags are checked against.
>
>   The data currently used in the mgmt-tester:
>
> static const uint8_t read_exp_feat_param_success[] = {
> 0x02, 0x00, /* Feature Count */
> 0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, /* UUID - Simultaneous */
> 0x27, 0x92, 0x96, 0x46, 0xc0, 0x42, /* Central Peripheral */
> 0xb5, 0x10, 0x1b, 0x67,
> 0x00, 0x00, 0x00, 0x00, /* Flags */
> 0x04, 0x00, 0x13, 0xac, 0x42, 0x02, /* UUID - LL Privacy */
> 0xde, 0xb3, 0xea, 0x11, 0x73, 0xc2,
> 0x48, 0xa1, 0xc0, 0x15,
> 0x02, 0x00, 0x00, 0x00, /* Flags */
> };
>
>
>   Please let me know what you think.
>
> Thanks and regards,
> Joseph
>
>
> On Tue, Aug 17, 2021 at 1:49 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Joseph,
> >
> > On Sun, Aug 15, 2021 at 6:25 AM <bluez.test.bot@gmail.com> wrote:
> > >
> > > This is automated email and please do not reply to this email!
> > >
> > > Dear submitter,
> > >
> > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > This is a CI test results with your patch series:
> > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=531683
> > >
> > > ---Test result---
> > >
> > > Test Summary:
> > > CheckPatch                    PASS      2.92 seconds
> > > GitLint                       PASS      0.61 seconds
> > > BuildKernel                   PASS      598.41 seconds
> > > TestRunner: Setup             PASS      394.12 seconds
> > > TestRunner: l2cap-tester      PASS      2.89 seconds
> > > TestRunner: bnep-tester       PASS      2.07 seconds
> > > TestRunner: mgmt-tester       FAIL      30.94 seconds
> > > TestRunner: rfcomm-tester     PASS      2.31 seconds
> > > TestRunner: sco-tester        PASS      2.20 seconds
> > > TestRunner: smp-tester        FAIL      2.27 seconds
> > > TestRunner: userchan-tester   PASS      2.09 seconds
> > >
> > > Details
> > > ##############################
> > > Test: CheckPatch - PASS - 2.92 seconds
> > > Run checkpatch.pl script with rule in .checkpatch.conf
> > >
> > >
> > > ##############################
> > > Test: GitLint - PASS - 0.61 seconds
> > > Run gitlint with rule in .gitlint
> > >
> > >
> > > ##############################
> > > Test: BuildKernel - PASS - 598.41 seconds
> > > Build Kernel with minimal configuration supports Bluetooth
> > >
> > >
> > > ##############################
> > > Test: TestRunner: Setup - PASS - 394.12 seconds
> > > Setup environment for running Test Runner
> > >
> > >
> > > ##############################
> > > Test: TestRunner: l2cap-tester - PASS - 2.89 seconds
> > > Run test-runner with l2cap-tester
> > > Total: 40, Passed: 40 (100.0%), Failed: 0, Not Run: 0
> > >
> > > ##############################
> > > Test: TestRunner: bnep-tester - PASS - 2.07 seconds
> > > Run test-runner with bnep-tester
> > > Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
> > >
> > > ##############################
> > > Test: TestRunner: mgmt-tester - FAIL - 30.94 seconds
> > > Run test-runner with mgmt-tester
> > > Total: 448, Passed: 444 (99.1%), Failed: 1, Not Run: 3
> > >
> > > Failed Test Cases
> > > Read Exp Feature - Success                           Failed       0.012 seconds
> >
> > Looks like there is a regression on mgmt-tester:
> >
> > Read Exp Feature - Success - run
> >   Sending Read Experimental Features Information (0x0049)
> >   Test condition added, total 1
> >   Read Experimental Features Information (0x0049): Success (0x00)
> >   Invalid cmd response parameter size
> > Read Exp Feature - Success - test failed
> >
> > >
> > > ##############################
> > > Test: TestRunner: rfcomm-tester - PASS - 2.31 seconds
> > > Run test-runner with rfcomm-tester
> > > Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
> > >
> > > ##############################
> > > Test: TestRunner: sco-tester - PASS - 2.20 seconds
> > > Run test-runner with sco-tester
> > > Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
> > >
> > > ##############################
> > > Test: TestRunner: smp-tester - FAIL - 2.27 seconds
> > > Run test-runner with smp-tester
> > > Total: 8, Passed: 7 (87.5%), Failed: 1, Not Run: 0
> > >
> > > Failed Test Cases
> > > SMP Client - SC Request 2                            Failed       0.024 seconds
> > >
> > > ##############################
> > > Test: TestRunner: userchan-tester - PASS - 2.09 seconds
> > > Run test-runner with userchan-tester
> > > Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
> > >
> > >
> > >
> > > ---
> > > Regards,
> > > Linux Bluetooth
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
>
> Joseph Shyh-In Hwang
> Email: josephsih@google.com



-- 

Joseph Shyh-In Hwang
Email: josephsih@google.com
