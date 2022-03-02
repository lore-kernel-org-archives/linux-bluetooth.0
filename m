Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275A4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 19:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244940AbiCBTOU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 14:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243540AbiCBTOT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 14:14:19 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38834BFF7
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 11:13:35 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2db569555d6so29669467b3.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 11:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQWXV4m/8famC0uLEfP2KGVjMso9vfOGNdAhvkCZsbY=;
        b=ZPvj+dbyI+JzuRDvYnIB6ngZu41hxeY0P5UVazMS5WSWgxhOJHuG1XIFEnDE8bEVC+
         gZpnZ11h7kQipls4508qF6j5U7pBj2EjPhznTM8p/P+SPSO1h4azRehrH16xZeUXHFd0
         h9NyU8BRaOGYQwQmzGUvTC/N7WJETa1C3sLdjjmVeieEK/xGonhJFQMHRGHtn8QXrc9u
         EjMrT4hjDOHZ0UXxoYF+8byNQmwdsxpIBvCPqaNPjWlnjpUhIkC3RcA/GepW6qFNQhD6
         /ShsB17JyHUdoyu6Z6PfdJHavZMBgVPlwZdfZh9heda2AI6AIlBtwweIbIAPDMxoopZq
         J3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQWXV4m/8famC0uLEfP2KGVjMso9vfOGNdAhvkCZsbY=;
        b=7IbOd0Miz1hS0aSxQX2W9oaqRYCMX8tO+Kigx3+oIsm9Oq5zt2RoDL6uZKed88hAwl
         ANLdn/7fQVmLchJjmZHXEB2Hkz3guUnXhJGOCA0pfOxt7LmJ8Jo2Nkg6oXYAs85URWfA
         5hZyjI9MCB/TiPxRklHMeOOFq6v/r+z8u7+661AiD6vindmzdeleWtYwPYTrLdSvYUfB
         bMnfPo0+MPDQjd1d4FUVTKASvqU+Ui72jMR6q6mj+phYcTyWfOHUlur7LgZ7354kbD1n
         UYzsxZ5+XyXZpM5eLVxCwXrQsB1Hl0MIZ/1aSGv4dpunJeCPGKMBud9wUDiCtGRjckkE
         4Uww==
X-Gm-Message-State: AOAM532UHSeu+BWsXnQpt8q8hgzObsavRcCosdTg+YKcjoGqNmDa1eVV
        bCRMdlat3c5LZYioD7wGfaAxZFMrXQ4OGwOg4XK/9qxm
X-Google-Smtp-Source: ABdhPJxLRhjIp56W+A/CyCiMIFvvsJQ3SIwNZzR8IL8zK1vIE7mrETmxJKzuHuio+3MMOSBkapkqDHTt3+8xeiV5ge8=
X-Received: by 2002:a81:638b:0:b0:2d6:ac65:962 with SMTP id
 x133-20020a81638b000000b002d6ac650962mr31574784ywb.37.1646248414789; Wed, 02
 Mar 2022 11:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20220302134439.515377-1-hdegoede@redhat.com> <621f7aae.1c69fb81.1e0a4.91fc@mx.google.com>
 <fe9f0d40-bfda-3048-273a-bce2b0cbfa3a@redhat.com>
In-Reply-To: <fe9f0d40-bfda-3048-273a-bce2b0cbfa3a@redhat.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 2 Mar 2022 11:13:23 -0800
Message-ID: <CABBYNZJ+7=Bp_mmG=QNOwSoPEBi-30_6_+Df24oye4gSVtUOww@mail.gmail.com>
Subject: Re: Bluetooth: hci_core: Fix unbalanced unlock in set_device_flags()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

On Wed, Mar 2, 2022 at 8:52 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 3/2/22 15:09, bluez.test.bot@gmail.com wrote:
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619579
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    PASS      1.68 seconds
> > GitLint                       PASS      0.97 seconds
> > SubjectPrefix                 PASS      0.85 seconds
> > BuildKernel                   PASS      36.20 seconds
> > BuildKernel32                 PASS      31.72 seconds
> > Incremental Build with patchesPASS      43.70 seconds
> > TestRunner: Setup             PASS      564.00 seconds
> > TestRunner: l2cap-tester      PASS      15.37 seconds
> > TestRunner: bnep-tester       PASS      7.22 seconds
> > TestRunner: mgmt-tester       PASS      117.53 seconds
> > TestRunner: rfcomm-tester     FAIL      9.09 seconds
> > TestRunner: sco-tester        PASS      8.99 seconds
> > TestRunner: smp-tester        PASS      8.92 seconds
> > TestRunner: userchan-tester   PASS      7.47 seconds
> >
> > Details
> > ##############################
> > Test: TestRunner: rfcomm-tester - FAIL - 9.09 seconds
> > Run test-runner with rfcomm-tester
> > Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0
> >
> > Failed Test Cases
> > Basic RFCOMM Socket Client - Write 32k Success       Failed       0.188 seconds
>
> This seems like a false-positive failure, since I don't
> see anyway how this patch can cause this issue.

Its a known problem, CI is running against bluetooth-next.git while
the fix for this is on our stable bluetooth.git, once
bluetooth-next.git gets rebased this should go away.

-- 
Luiz Augusto von Dentz
