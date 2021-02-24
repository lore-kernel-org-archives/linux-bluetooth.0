Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12410C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Feb 2021 19:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B02B464F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Feb 2021 19:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbhBXTAU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbhBXS6e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Feb 2021 13:58:34 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FEFC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Feb 2021 10:57:52 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id p21so4620292lfu.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Feb 2021 10:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GX33ld/zCPziFqqadOxurpTzLAR15WqFyHWvUgoEXw=;
        b=jxLvtYwg8xZZYAZ+eMjULhv9aL3kXiKxWkTvHgJ/K1zy3YEYJZqsQqJlarZtnAkWkb
         PdVXMn+k62lttvfL2ncmj23wmUrGO22mJCDVaxM3Dmc5vzlJQ+R6HST7+apLTkWlnAEZ
         JP7/iDpsvBMaqFNqn1A3uHgIzNN1g28wd6DXNPb32Cd5hPur2unk96pOI7OHWIL/GiB2
         u2+wd+CZc98hbat16b7lVvBmB1C+NQEoaiJjevtFcwXootcPUNTtWqexI2pWh38+Z8K0
         3C19cKAumxpSelpaGZHOTc4J7Lt0GK8sHxBg7DZHw3W2W8C6J32ANmOul4zbgELyHR5j
         7V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GX33ld/zCPziFqqadOxurpTzLAR15WqFyHWvUgoEXw=;
        b=bj1r01jkYJusL8CryOHj0BRWZMKSNGWOkd++MXUPwtw7bwGp79vy8fxD+C8svIHB9T
         kAfHOvCuklcKm2IJhqA9chz6jZ4jdSo6JZNUyDVjooneYOxgCeFVn2qe4oWlu6siwjLo
         FpZvcfcxN8qsndmUNqnadvUDGl7MIYOgkeHdDKenjQBGhu4nhS2mUQNd2Q+PXKhJvcfJ
         73OIt5N9xywlnnsmlIv86NTOFZJ6DqxDxk87tAzmmtODsHbcxR6vhyhgMUrDOoCCYBNg
         jkA71z5l681G0v2dsYO10aj6dJ7F5tr+qnav9VJ2awf+aOJuX7GUwLzcotVJze3/CxLh
         jGUQ==
X-Gm-Message-State: AOAM5332wRRPCSnic5TM6xDdLYYBxrXTfb/+/JeUv/I0XcjEIIUMNKe/
        tg8lEwJy5yC3SI/Gifm69JPaKUItgj8R/3iBrNxTb7MHvfM=
X-Google-Smtp-Source: ABdhPJyeQxjHomLwKulgmX4i7t4Jz74OSijDWC8y0LAcowKq1LWXPiMbmucF9TKsEv/K9ta9xq1uDp/bAehAAN9qgzo=
X-Received: by 2002:ac2:5603:: with SMTP id v3mr4652637lfd.67.1614193070107;
 Wed, 24 Feb 2021 10:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20210217142511.3221605-1-alainm@chromium.org> <602d321b.1c69fb81.3fe48.4e13@mx.google.com>
 <CALWDO_XuBfnvY4jSbCFVmec63S3-V_iW3nG+TkcDKtU-t=h5rA@mail.gmail.com>
In-Reply-To: <CALWDO_XuBfnvY4jSbCFVmec63S3-V_iW3nG+TkcDKtU-t=h5rA@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 24 Feb 2021 13:57:33 -0500
Message-ID: <CALWDO_UNbWSchjYanspW5Abgh8f+yJNDyBBVDGr71oUppU_ozw@mail.gmail.com>
Subject: Re: [v1] Bluetooth: Tolerate valid pre 4.2 conn params
To:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Friendly ping.


On Thu, Feb 18, 2021 at 3:06 PM Alain Michaud <alainmichaud@google.com> wrote:
>
> +Marcel for viz
>
>
> On Wed, Feb 17, 2021 at 10:11 AM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=434523
> >
> > ---Test result---
> >
> > ##############################
> >     Test: CheckPatch - PASS
> >
> >
> >     ##############################
> >     Test: CheckGitLint - PASS
> >
> >
> >     ##############################
> >     Test: CheckBuildK - PASS
> >
> >
> >     ##############################
> >     Test: CheckTestRunner: Setup - PASS
> >
> >
> >     ##############################
> >     Test: CheckTestRunner: l2cap-tester - PASS
> >     Total: 40, Passed: 34 (85.0%), Failed: 0, Not Run: 6
> >
> >     ##############################
> >     Test: CheckTestRunner: bnep-tester - PASS
> >     Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
> >
> >     ##############################
> >     Test: CheckTestRunner: mgmt-tester - PASS
> >     Total: 416, Passed: 402 (96.6%), Failed: 0, Not Run: 14
> >
> >     ##############################
> >     Test: CheckTestRunner: rfcomm-tester - PASS
> >     Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
> >
> >     ##############################
> >     Test: CheckTestRunner: sco-tester - PASS
> >     Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
> >
> >     ##############################
> >     Test: CheckTestRunner: smp-tester - PASS
> >     Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
> >
> >     ##############################
> >     Test: CheckTestRunner: userchan-tester - PASS
> >     Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
> >
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth
> >
