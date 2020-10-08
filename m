Return-Path: <SRS0=KpSE=DP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99728C433E7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Oct 2020 00:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABDB20872
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Oct 2020 00:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bup7u3uu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgJHABs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Oct 2020 20:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJHABs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Oct 2020 20:01:48 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68423C061755
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2020 17:01:48 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id g8so1083207oov.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2020 17:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGcWFkCUmg/0lwHuogLJE3j+LrS/+7N9rRIGqAGZGAo=;
        b=bup7u3uuchqul1wuv6gKFN5NSSx/dH0PMAqblaEQzYK18Y4iGreRmtGT97+Cks6A2y
         Ltz0g+ei+nwP2YXt0ptDLPAO7khRvUqLmQOLKaGIVIGzndrKdU/CWl5qOQL0nK/szm3d
         X3S+gVstE2657Qa06la6KC2AzER5kfU9OG+/mDi4VBRlRMwiX0P5xvQePZ0/7Z7N2hYM
         vA9Qoxe8FR3m/2JP7KVU3WlORKxSF3HX/uiI8o5TPGM8CYDk9vfu9tZGnRXr5Hd82nvX
         0wSKxzCJmIXuGMqQU/t3A8koqD0kDa/x2GV0qqjeuIfET1FvNDJ49FwA1AnfOlLorePD
         Lj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGcWFkCUmg/0lwHuogLJE3j+LrS/+7N9rRIGqAGZGAo=;
        b=frZO3IQFiNMeg8UqXYWjmLBGCAX92ORP6ebfoWBQACz+ycfT6vvfFxLxLetqFa6trK
         nveApxg2/8VZfpRtJEhyU45G9itKBxVvYVFEDIuWLOiEQiRUWTWYGPa8N4KCtI9eCE1q
         Yk2b3P/39otdwqC7Ae0oSEcdjNtbJsCZTcjTnzBjvggV2e4NuSukrJFsoFJrlP4juhK2
         4Sz2hRovQDQxtauyqY8kKldyMmzdyNR/giDbV7JqjhuOahzUkph/rKAIdMP11+UbmhGY
         mTh1IVbiGvcL7Aa3URQ86nDy533ndedKF9ixT2y2ciizi0B4nTisgEJdCq4dGF3ncOr0
         /s+g==
X-Gm-Message-State: AOAM530jQS7rWoLGroSZEr0kmyLZsDWCl19se2AET6VbpLEHGtf/FE/8
        1fm/gDUWvKwMP53OhkUFrpu8/u8PsFLCCpF7IOmQaJPQ
X-Google-Smtp-Source: ABdhPJxFNxx06+pN91K7yt9ouMB50ur4urolICaXRiE4lNZcP8TqejO+GCwtM+LYXKj1hIEh6kMMJLOUVEkWHXjWJUg=
X-Received: by 2002:a4a:a787:: with SMTP id l7mr3627244oom.63.1602115307766;
 Wed, 07 Oct 2020 17:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200928192002.22733-1-machiry@cs.ucsb.edu> <5f7239e2.1c69fb81.dfa65.87a7@mx.google.com>
 <CANozA0hYY6M_We73Zummfodk_g1HhWsyHiLP8Gw17rR+X89dpQ@mail.gmail.com>
 <CABBYNZJzbn2p7BNrcUOmSWKPhKcpDUcH_kL6oWLuE7H8gjy0RA@mail.gmail.com> <CANozA0jn0jM99A=gUCnC0Zys2_FYCacFfkAvQn1axDTS=U2UZA@mail.gmail.com>
In-Reply-To: <CANozA0jn0jM99A=gUCnC0Zys2_FYCacFfkAvQn1axDTS=U2UZA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 7 Oct 2020 17:01:33 -0700
Message-ID: <CABBYNZJ1++jjS_Kqo+U_DS_xYS1OhTupjEjQ0HQF+rzR_5eqAQ@mail.gmail.com>
Subject: Re: [BlueZ] lib: Replace malloc/memset(..0..) with malloc0
To:     Aravind Machiry <machiry@cs.ucsb.edu>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Aravind,

On Sat, Oct 3, 2020 at 5:36 PM Aravind Machiry <machiry@cs.ucsb.edu> wrote:
>
> Hi Luiz,
>
> Yes. Although bt_malloc internally uses malloc, there are a couple of
> places where bt_malloc is used instead of malloc.
>
> I was sticking to the convention of replacing malloc with malloc0 and
> bt_malloc with btmalloc0. I am not sure about any underlying reason
> for using malloc vs bt_malloc.
>
> If you think that bt_malloc/bt_malloc0 is the right way to go? I can
> go ahead and replace all occurrences of malloc/malloc0 with
> bt_malloc/bt_malloc0 respectively.
>
> Please do let me know.
>
> Btw, all the tests seem to pass when I did the replacement.

Applied, thanks, note that I did replace the instances of malloc0 with
bt_malloc0.

> -Best,
> Aravind
>
>
>
>
> On Sat, Oct 3, 2020 at 2:49 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Aravind,
> >
> > On Sat, Oct 3, 2020 at 11:14 AM Aravind Machiry <machiry@cs.ucsb.edu> wrote:
> > >
> > > Gentle reminder!
> > >
> > > On Mon, Sep 28, 2020 at 12:30 PM <bluez.test.bot@gmail.com> wrote:
> > > >
> > > > This is automated email and please do not reply to this email!
> > > >
> > > > Dear submitter,
> > > >
> > > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > > This is a CI test results with your patch series:
> > > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=356715
> > > >
> > > > ---Test result---
> > > >
> > > > ##############################
> > > > Test: CheckPatch - PASS
> > > >
> > > > ##############################
> > > > Test: CheckGitLint - PASS
> > > >
> > > > ##############################
> > > > Test: CheckBuild - PASS
> > > >
> > > > ##############################
> > > > Test: MakeCheck - PASS
> > > >
> > > >
> > > >
> > > > ---
> > > > Regards,
> > > > Linux Bluetooth
> >
> > There seems to be a mixture of malloc0 or bt_malloc0 when I guess the
> > later should be preferred.
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
