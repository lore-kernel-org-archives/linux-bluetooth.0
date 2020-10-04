Return-Path: <SRS0=39yq=DL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A03BC41604
	for <linux-bluetooth@archiver.kernel.org>; Sun,  4 Oct 2020 00:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD2F206B5
	for <linux-bluetooth@archiver.kernel.org>; Sun,  4 Oct 2020 00:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucsb.edu header.i=@cs.ucsb.edu header.b="Wzx9oDKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgJDAgy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Oct 2020 20:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgJDAgw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Oct 2020 20:36:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1872C0613D0
        for <linux-bluetooth@vger.kernel.org>; Sat,  3 Oct 2020 17:36:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a17so2676175pju.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Oct 2020 17:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.ucsb.edu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFDdMEP2hLIXjPRfRXB9hkWTOVm+momB2vAsTN25Y2Y=;
        b=Wzx9oDKH4drei+W6NRd6bmgc1vb8tnDzrkDSmboasQl62mlQwoyfQ06TmPC09hsQB1
         fPNmS870Fz+hSpMfinXVNAoydNpniJ4BUHX1q+cYxBQKaE5o84wd7VZNQvEAcak6HQZo
         0xMYj1poERFDfI6HxgF0/iOTZYViksqFL5uvbWaMf6yUPix+OI8XiQALXfn93NQi3Jx9
         Lk/4w6pOamNmCybuff5Qqc7BHiA48GwQGKXxuazjwtUi+OhOOkrHMsnj9czDV7UlMcvN
         KagskKPNr7Rd2G8ZFyjMdTkl/D9nSBlWwax8oB2XBi8hDlPP7SU9p8etaqTJenK7+I9J
         ghzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFDdMEP2hLIXjPRfRXB9hkWTOVm+momB2vAsTN25Y2Y=;
        b=Y/mOeV0Ex1ArP1Dqyx71KIjV4d3I7lEsPhI/YjNf06Yh+i1pkAosyBUkXs8mKCvstV
         9EPahhyOqf8yC0n+npECWbF3OU5bOtP8IFz4SODyJDHuHSSh1bJOlxpZlHIC1kFas1HH
         b/ltRdxO5bQLZy/UGNr6VTPlBIVIX1sgoIvhPyYwkKrPVaIvqNV1ZLRJ6cw6t1HNCOq1
         I2UIc0fVmfbziMuPCrlLlhAP/O6QebEbo0YLL5WZvGbxyEf1e+s4fu+ig/v9RnfEY8uK
         hqxbe+CHDneRflpigd0ZwAZciTmurcVKfxNNnSoQsVR32G3gIkP0TjQCVq68UFvyeU/R
         NxwQ==
X-Gm-Message-State: AOAM5330hQe+ByMqWqEx1xbh5JGAp+SBtSITqLpyfw4c+OiG71KHIXbK
        PRAW1ejrKp0rYR4vDl73icD030THBr2n5KvEnV1YLA==
X-Google-Smtp-Source: ABdhPJyGAE2xfLnqfjhaKXZSyI+u8Ab9s/LnVMapWv0BR9wvBqPRb/20FrfXMEU9ehxewXHbpfTRxxvtLeb1D94yB3s=
X-Received: by 2002:a17:90b:797:: with SMTP id l23mr9521038pjz.176.1601771810388;
 Sat, 03 Oct 2020 17:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200928192002.22733-1-machiry@cs.ucsb.edu> <5f7239e2.1c69fb81.dfa65.87a7@mx.google.com>
 <CANozA0hYY6M_We73Zummfodk_g1HhWsyHiLP8Gw17rR+X89dpQ@mail.gmail.com> <CABBYNZJzbn2p7BNrcUOmSWKPhKcpDUcH_kL6oWLuE7H8gjy0RA@mail.gmail.com>
In-Reply-To: <CABBYNZJzbn2p7BNrcUOmSWKPhKcpDUcH_kL6oWLuE7H8gjy0RA@mail.gmail.com>
From:   Aravind Machiry <machiry@cs.ucsb.edu>
Date:   Sat, 3 Oct 2020 17:36:39 -0700
Message-ID: <CANozA0jn0jM99A=gUCnC0Zys2_FYCacFfkAvQn1axDTS=U2UZA@mail.gmail.com>
Subject: Re: [BlueZ] lib: Replace malloc/memset(..0..) with malloc0
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Yes. Although bt_malloc internally uses malloc, there are a couple of
places where bt_malloc is used instead of malloc.

I was sticking to the convention of replacing malloc with malloc0 and
bt_malloc with btmalloc0. I am not sure about any underlying reason
for using malloc vs bt_malloc.

If you think that bt_malloc/bt_malloc0 is the right way to go? I can
go ahead and replace all occurrences of malloc/malloc0 with
bt_malloc/bt_malloc0 respectively.

Please do let me know.

Btw, all the tests seem to pass when I did the replacement.

-Best,
Aravind




On Sat, Oct 3, 2020 at 2:49 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Aravind,
>
> On Sat, Oct 3, 2020 at 11:14 AM Aravind Machiry <machiry@cs.ucsb.edu> wrote:
> >
> > Gentle reminder!
> >
> > On Mon, Sep 28, 2020 at 12:30 PM <bluez.test.bot@gmail.com> wrote:
> > >
> > > This is automated email and please do not reply to this email!
> > >
> > > Dear submitter,
> > >
> > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > This is a CI test results with your patch series:
> > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=356715
> > >
> > > ---Test result---
> > >
> > > ##############################
> > > Test: CheckPatch - PASS
> > >
> > > ##############################
> > > Test: CheckGitLint - PASS
> > >
> > > ##############################
> > > Test: CheckBuild - PASS
> > >
> > > ##############################
> > > Test: MakeCheck - PASS
> > >
> > >
> > >
> > > ---
> > > Regards,
> > > Linux Bluetooth
>
> There seems to be a mixture of malloc0 or bt_malloc0 when I guess the
> later should be preferred.
>
>
>
> --
> Luiz Augusto von Dentz
