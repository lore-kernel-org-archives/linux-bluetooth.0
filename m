Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FEFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Feb 2022 01:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353229AbiBDBGa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Feb 2022 20:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353233AbiBDBG3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Feb 2022 20:06:29 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E9DC06173D
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Feb 2022 17:06:29 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id k31so14322669ybj.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Feb 2022 17:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QfS6fZL6AKOoxKHGub/zeRKVwSbuNEL1wM1bB7LEUY=;
        b=G4C0MEO7jmxzAryO3Y7ZfGaeIvIxmSdiDnTVEPOFIU1dcSLZRQ6yi6J+Py1LVgi2qW
         c02q54duxaDd5HvAWaplO6RH0973/+Lgdn8s1OKUZp5RTcNGFCaUC5XMJhGZ9gnvyhG6
         2Ek6gcWnKJjhQtHobBRVA4geV+X7pSFJSCowJMfTGHMIoZ1rmXj3ZQaazww6mSBfTYzB
         JZNmmrmlrorYdBfs0USeYQRe6LuZxuQ75Xgb7eS0nbOn20i83LzcjAUvqIQkz2npfXhE
         TPkhFmxpclZkbtfuSY0gJxVLpKsxBsvx1iFx9dpU/IXuh1SftukMbkX9zbhYt+44DM85
         eEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QfS6fZL6AKOoxKHGub/zeRKVwSbuNEL1wM1bB7LEUY=;
        b=Qau5es4829jYpnfmBf+6vNYcgkUU2D0mBv+jODWPEM9acY7RKyA10IlIwe+gOXaoVZ
         U4YeOCSCscLPowpbARZbz8gnRLFk+Um5P0qwmBDW8dlojaDJMfwNiBL+r+09RXLhPSP4
         qzJzSTbFEr7EKkEG3vaokCi+AaMgYe1IHw4xSDgxwD554QIu5GvnONp9qJlvyjfmsJle
         iGe8h1fhLGsjjd4s7nV5+2rxbXlOwqmyjgQgM8Ed4AfQ3fZRjWWkloRkclAJu1NwUati
         FWaw8Ib2liZaYG/s3C9Bzn3GJ32AhhZx9/C8edCWsN+mMll6JAf9BCXqjTai8jmt9huN
         zakQ==
X-Gm-Message-State: AOAM530xZ8uehsegZ+O14u6wgEvlMYqYI7bFT+D/WdvEJjJfVH6jB2KQ
        R9+j9a3wBCSpDAbqNQJHIH2kPd353hWhwnvS9dXtoewVzNI=
X-Google-Smtp-Source: ABdhPJyaJRzk+QDDWEEKrrr+aj1qbNg3c0+sDQd2gmBOTjd1zUubiG1dzoXkHjS61mXKi84qMW7QI6bR1RheqedQM6k=
X-Received: by 2002:a25:3f87:: with SMTP id m129mr788811yba.188.1643936788454;
 Thu, 03 Feb 2022 17:06:28 -0800 (PST)
MIME-Version: 1.0
References: <20211215180527.886481-1-claudio.takahasi@gmail.com>
 <61ba372b.1c69fb81.82f24.9d4f@mx.google.com> <CABBYNZKBPuR-W1iko=rF=jLJw1pq05SKUDWr2+7LAvR0BJpwQA@mail.gmail.com>
 <20220203230412.dig2cu3vy2uzgsim@SoMainline.org>
In-Reply-To: <20220203230412.dig2cu3vy2uzgsim@SoMainline.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 3 Feb 2022 17:06:17 -0800
Message-ID: <CABBYNZ+29R2=4orBVicSmCi8gcTQJOHuhJbLfm1ihobg9XRznA@mail.gmail.com>
Subject: Re: [BlueZ] advertising: Fix reporting advertising properties
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Claudio Takahasi <claudio.takahasi@gmail.com>,
        igor.v.kovalenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn.

On Thu, Feb 3, 2022 at 3:04 PM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Hi Claudio, Luiz,
>
> On 2021-12-15 14:53:04, Luiz Augusto von Dentz wrote:
> > Hi Claudio,
> >
> > On Wed, Dec 15, 2021 at 12:50 PM <bluez.test.bot@gmail.com> wrote:
> > >
> > > This is automated email and please do not reply to this email!
> > >
> > > Dear submitter,
> > >
> > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > This is a CI test results with your patch series:
> > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=596151
> > >
> > > ---Test result---
> > >
> > > Test Summary:
> > > CheckPatch                    PASS      1.47 seconds
> > > GitLint                       PASS      0.99 seconds
> > > Prep - Setup ELL              PASS      49.04 seconds
> > > Build - Prep                  PASS      0.61 seconds
> > > Build - Configure             PASS      9.40 seconds
> > > Build - Make                  PASS      209.53 seconds
> > > Make Check                    PASS      9.37 seconds
> > > Make Distcheck                PASS      248.72 seconds
> > > Build w/ext ELL - Configure   PASS      9.46 seconds
> > > Build w/ext ELL - Make        PASS      198.40 seconds
> > > Incremental Build with patchesPASS      0.00 seconds
> > >
> > >
> > >
> > > ---
> > > Regards,
> > > Linux Bluetooth
> >
> > Applied, thanks.
>
> This seems to at least partially back out of:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=d36c45c55
>
> And as such, reintroduce the bug it fixed:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1534857
> https://bugs.archlinux.org/task/57464
>
> Me and two others in the pulseaudio IRC channel see this connection
> failure appear, and I've locally confirmed reverting this patch resolves
> the issue yet again.

Hmm so that is the actual problem that PA can't find the adapter, this
has been popping up quite a lot in our github issues, so I guess we
will need to revert it and update the properties after reading the
features, can either of you come with a patch for that?

-- 
Luiz Augusto von Dentz
