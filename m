Return-Path: <SRS0=jDol=DK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0B7C41604
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 21:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3828D206C3
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 21:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbAY80EO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgJCVtz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Oct 2020 17:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgJCVtz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Oct 2020 17:49:55 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DD6C0613D0
        for <linux-bluetooth@vger.kernel.org>; Sat,  3 Oct 2020 14:49:55 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id f37so1471930otf.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Oct 2020 14:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYLYHF6dY7sciTVyTyrJHcKkLPtvkPtKW2qf40Wm4+M=;
        b=NbAY80EOTpQf/wrdO6alXZL/9hDVSYTrlvewnjKijTWvYrM4d8vobBQrvTEW+xDj/3
         IDxAY0TqBi6+fnQTvHuxKiPl7XQ8enypzT6gO8pZsrWI8Gv60DSGE7qpQnkNvDZoMuwP
         hUE3QZUTg46kt2Mi+KYtC+ZFsugCgzF7SYzcH3oHZVfYpxtQDTd98ghHiDKvHrVQXzkE
         h6YbKKugsnlIZIACmYGMGWyzKsQYyPvlRe0EnhM2+wkY43zJQKt4bPhq3d4Ngcwc+VGH
         fBPf2XklQVeWlZ3OaYxibdXC/7kaTGz4Z/1gXfXB2/n5gcEFHik9LzSF6ew31gDI6ibX
         NMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYLYHF6dY7sciTVyTyrJHcKkLPtvkPtKW2qf40Wm4+M=;
        b=BiZteEKPZGwoM1fRSX99waXrzlSHMTbkvG0yUAymMpj+6WgITVTdhOUUrQeqxYyT+G
         6fx9ANhCiydqv2eek9so3Dx3ajhMFZ3Nqzz8g3c/LwP8kJ5JP90Tfm2VbfB3IFBOBjag
         U0fEx6X+8xEBtnqubZkYqQVvgi/4YOQvi5a/rMRmO5LEPjgCTQg8GLbWHPIJ36YOX4uB
         4j9exSArbkkDzC8lhVqgvDQ107ZAnNmcSHR9sSqjCOmjvSMaWTZo3vvvhyl+1BTpdgzM
         3eVcTO63lwJ7Zl0KQWJK8LnzA3m2ED8SJAs/vboMraux+Dq4C7541tMQ+PkzvQVwKzrn
         tfDA==
X-Gm-Message-State: AOAM530Kc4pV/LTOBb3LOOryEyJg1vG8PKxhfxKQQchHSEuh6Ebi7Znp
        oHuDG34Ko2qUnVANG655kI5B9OuJvZh1oM7uQTi13+pB
X-Google-Smtp-Source: ABdhPJyy7c5Ld2tCOBwbHqlGOg90YzoPQ/SaXsMp1pyQ46CxuuDgaYxQ3bHeyr7pBbaiMepD3aZMPIuQPOIE/ngvlf4=
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr6083344otd.362.1601761794586;
 Sat, 03 Oct 2020 14:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200928192002.22733-1-machiry@cs.ucsb.edu> <5f7239e2.1c69fb81.dfa65.87a7@mx.google.com>
 <CANozA0hYY6M_We73Zummfodk_g1HhWsyHiLP8Gw17rR+X89dpQ@mail.gmail.com>
In-Reply-To: <CANozA0hYY6M_We73Zummfodk_g1HhWsyHiLP8Gw17rR+X89dpQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 3 Oct 2020 14:49:42 -0700
Message-ID: <CABBYNZJzbn2p7BNrcUOmSWKPhKcpDUcH_kL6oWLuE7H8gjy0RA@mail.gmail.com>
Subject: Re: [BlueZ] lib: Replace malloc/memset(..0..) with malloc0
To:     Aravind Machiry <machiry@cs.ucsb.edu>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Aravind,

On Sat, Oct 3, 2020 at 11:14 AM Aravind Machiry <machiry@cs.ucsb.edu> wrote:
>
> Gentle reminder!
>
> On Mon, Sep 28, 2020 at 12:30 PM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=356715
> >
> > ---Test result---
> >
> > ##############################
> > Test: CheckPatch - PASS
> >
> > ##############################
> > Test: CheckGitLint - PASS
> >
> > ##############################
> > Test: CheckBuild - PASS
> >
> > ##############################
> > Test: MakeCheck - PASS
> >
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth

There seems to be a mixture of malloc0 or bt_malloc0 when I guess the
later should be preferred.



-- 
Luiz Augusto von Dentz
