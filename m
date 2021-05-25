Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7525EC2B9F8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 18:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C18561404
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 18:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhEYSR7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 14:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhEYSR6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 14:17:58 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D414C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 11:16:27 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id l16so11472875ybf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 11:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N1kImjzBtE/vrxCeMuJJmgJRCgDagWv9xJeZyytAHSs=;
        b=Gop9KhHhWYy35AmtRjKjzkpo/Ix4O8jMHBeiNmsCMvt84BLF5aak0g1Xu3L3FRafal
         qMxD7JXl71tfGUg/VSIu9xca4UeTrgJPuWzS7bNeh9QM/iEHcJMWv5baizqW9zB2ZEYe
         iCr07K6QKQHbFm1KjgYYSF+h1bvtF94rblVLPBW2uoa0BUVNv6/O1RgUcH/DINmcfU1d
         MQm4SXiOqg8OHm+Lxfg55SBdWBzEHFLAdzgIJpiRSfLsWhLlVpAwurFwWw9nc4OH+XAB
         +cBx3//kCGwQNFC5E6i7VAKx4OnFsip7H8ICPPgrXtE7lSnxoHKm0g6JX/Y/0iiejnxa
         4hUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1kImjzBtE/vrxCeMuJJmgJRCgDagWv9xJeZyytAHSs=;
        b=Q8Yux4GIutIRVYJwBb4dA3rI0SOzkDt9WnfiiwdvIb0+S39etqLWYsDm/bOCYyGpsZ
         JxxojZIBVmyIumlxHc1L0/7Zl4W2ee4TMnbweBRuQbjwlJ7gmgREmTlnQ3fy+d9nppa6
         a/bj+YRILThY9lEVKmLtzKbk4wI9RxYjwQtWzBU4LoEp8n4X5r7Cow/TLeXUrxrAKPAT
         5D/SCgM/o4W/UN5tTSt1FTggajcDEVsyswWXwVmufiSPHXX3eXtKNTwR4ExTXlfNlYZN
         62Xw8R2YAZvE+9O+ILjlaEqNp20OXX5Wxbgj1CHzkbAYBWpPkvF3+nvCGic+ETK9C/Vu
         HXdg==
X-Gm-Message-State: AOAM5316KSTgTXtbypNhyRV+s08WL5hnlFS4cbwivj8kcQCJnMVReRnc
        YrGe2WbQ00sI3QVFrIm9nCRla6vjQAVlw3UypS2s9DqD
X-Google-Smtp-Source: ABdhPJyhpbuE8lp9TE2HwOaT2/yaDmYBdVuXyq87gfOdQF1Dkv6JtvRd4Lose0g/TOpGmK4glt3Cc50FRNdd3kDZk5M=
X-Received: by 2002:a25:ca08:: with SMTP id a8mr11033501ybg.222.1621966586699;
 Tue, 25 May 2021 11:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210525123902.189012-1-gregkh@linuxfoundation.org>
 <60acfd67.1c69fb81.ff72c.cc6c@mx.google.com> <YK0H/AyoPWZwNZbu@kroah.com>
In-Reply-To: <YK0H/AyoPWZwNZbu@kroah.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 25 May 2021 11:16:15 -0700
Message-ID: <CABBYNZKrp6S7kCy-qJfF7qZF6-Xy_QSjmTVWQpp4OmtEVOXJBw@mail.gmail.com>
Subject: Re: [v2] Bluetooth: fix the erroneous flush_work() order
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Greg,

On Tue, May 25, 2021 at 10:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 25, 2021 at 06:36:39AM -0700, bluez.test.bot@gmail.com wrote:
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=488173
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    FAIL      0.77 seconds
> > GitLint                       PASS      0.12 seconds
> > BuildKernel                   PASS      529.82 seconds
> > TestRunner: Setup             PASS      311.54 seconds
> > TestRunner: l2cap-tester      PASS      2.46 seconds
> > TestRunner: bnep-tester       PASS      1.76 seconds
> > TestRunner: mgmt-tester       PASS      26.34 seconds
> > TestRunner: rfcomm-tester     PASS      1.97 seconds
> > TestRunner: sco-tester        PASS      1.94 seconds
> > TestRunner: smp-tester        PASS      2.03 seconds
> > TestRunner: userchan-tester   PASS      1.92 seconds
> >
> > Details
> > ##############################
> > Test: CheckPatch - FAIL - 0.77 seconds
> > Run checkpatch.pl script with rule in .checkpatch.conf
> > Bluetooth: fix the erroneous flush_work() order
> > WARNING: Invalid email format for stable: 'stable <stable@vger.kernel.org>', prefer 'stable@vger.kernel.org'
> > #26:
> > Cc: stable <stable@vger.kernel.org>
> >
> > WARNING: From:/Signed-off-by: email name mismatch: 'From: linma <linma@zju.edu.cn>' != 'Signed-off-by: Lin Ma <linma@zju.edu.cn>'
> >
> > total: 0 errors, 2 warnings, 0 checks, 14 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> >
> > "[PATCH] Bluetooth: fix the erroneous flush_work() order" has style problems, please review.
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> >
>
> Do these matter enough for me to do a v3?

Nah, we treat checkpatch as just informational I didn't know it
actually checked the git patch description.

> The first one is crazy, the second one, well, I can understand...

I wonder why checkpatch is even doing something like that, anyway I
believe the CI just runs checkpatch from mainline.

>
> thanks,
>
> greg k-h



-- 
Luiz Augusto von Dentz
