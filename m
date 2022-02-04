Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909EDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Feb 2022 01:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbiBDBn3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Feb 2022 20:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbiBDBn2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Feb 2022 20:43:28 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3903CC061714
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Feb 2022 17:43:28 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id m6so14427495ybc.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Feb 2022 17:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wHjoU19Bkc+pq/8RVSL4Kew9DkhgPWWJZRpHWQr0nuU=;
        b=XCsoiSy4Eqh5sNjMgjL6DbIi+1Pjcco8ZGDtHUbZC/Ft6z4ntPscRpaVBq5hRA2Ous
         MSRHDBnM27uBIiom1p/mRG3s4sQRyKC5NG07hBbhdn6Mjgup2YnUDJdbkQi6dbqdKDaW
         h7KMg9jlip42QKDokZu0f1fmgdtVhHnlvNG32Cu9QJ8O9AlaDowZBngDyncPRpw48bUy
         HResQBzTeYY1IzbqLGCOc+8NayFOb3ZLcBzsCik6mOAjb2IxmWwE5UT5Jvuv6xVtISUq
         H6d1vo0hXCJ7ZfaXh/txO6wvoOCu58r/l68qACy6JeFtxDrJziOA9OCSKD72caWbxMOT
         aGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wHjoU19Bkc+pq/8RVSL4Kew9DkhgPWWJZRpHWQr0nuU=;
        b=rapkzlBabqaayUUqGuAFsEUDL0T/6RDtw7xn6Of77q12FWlSURln5kvH0X4HpqrVyI
         HiFx4ZeXL7WLuPGrafSq5Xsty4tD6xlNUo7sS1dADEkbjpmGLi72EcpLowLNw9hqpcgV
         8PrmHl78n+StFYEn/fvyTnuuOiSnGst8thmyzOhewsIrTD2wZJu2rGufI8A8fBvxDqMj
         T7zo4SbbBED2IoCKl/qIxglOMucpNkCiPXfnQneD/xgRcopqaXrEwqwsJoLBzIZmxHFj
         owRDZF23ibxtbscUHMzLXunKfjXab+uXgC3lBfYNKwuf1YHG6q5iUqUJtdeSNIAQ2hcG
         z16g==
X-Gm-Message-State: AOAM533oZX/oXCiAyiBmCXAsGk/Y09u5KCReWZUY8ydvpCbUcTsh2Zip
        9NypGVUnEBMApNClzRlPdAEW4Cx8rLenjnds/ZM=
X-Google-Smtp-Source: ABdhPJwopc6PmBxucr55Kb5cB50KOZC/lMiFiVaBn477v8RLhHsSGxRwpSYJyqjGfT0rvQp5q0kpQJcx97vR2dnenOM=
X-Received: by 2002:a81:dc0d:: with SMTP id h13mr565113ywj.8.1643939007247;
 Thu, 03 Feb 2022 17:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20211215180527.886481-1-claudio.takahasi@gmail.com>
 <61ba372b.1c69fb81.82f24.9d4f@mx.google.com> <CABBYNZKBPuR-W1iko=rF=jLJw1pq05SKUDWr2+7LAvR0BJpwQA@mail.gmail.com>
 <20220203230412.dig2cu3vy2uzgsim@SoMainline.org> <CABBYNZ+29R2=4orBVicSmCi8gcTQJOHuhJbLfm1ihobg9XRznA@mail.gmail.com>
In-Reply-To: <CABBYNZ+29R2=4orBVicSmCi8gcTQJOHuhJbLfm1ihobg9XRznA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 3 Feb 2022 17:43:16 -0800
Message-ID: <CABBYNZ+ae0+EYv=Am2xJp8_50g0TTW=bHYqFKpq1+Y=UtNYvqA@mail.gmail.com>
Subject: Re: [BlueZ] advertising: Fix reporting advertising properties
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Claudio Takahasi <claudio.takahasi@gmail.com>,
        igor.v.kovalenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Feb 3, 2022 at 5:06 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Marijn.
>
> On Thu, Feb 3, 2022 at 3:04 PM Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> >
> > Hi Claudio, Luiz,
> >
> > On 2021-12-15 14:53:04, Luiz Augusto von Dentz wrote:
> > > Hi Claudio,
> > >
> > > On Wed, Dec 15, 2021 at 12:50 PM <bluez.test.bot@gmail.com> wrote:
> > > >
> > > > This is automated email and please do not reply to this email!
> > > >
> > > > Dear submitter,
> > > >
> > > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > > This is a CI test results with your patch series:
> > > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=596151
> > > >
> > > > ---Test result---
> > > >
> > > > Test Summary:
> > > > CheckPatch                    PASS      1.47 seconds
> > > > GitLint                       PASS      0.99 seconds
> > > > Prep - Setup ELL              PASS      49.04 seconds
> > > > Build - Prep                  PASS      0.61 seconds
> > > > Build - Configure             PASS      9.40 seconds
> > > > Build - Make                  PASS      209.53 seconds
> > > > Make Check                    PASS      9.37 seconds
> > > > Make Distcheck                PASS      248.72 seconds
> > > > Build w/ext ELL - Configure   PASS      9.46 seconds
> > > > Build w/ext ELL - Make        PASS      198.40 seconds
> > > > Incremental Build with patchesPASS      0.00 seconds
> > > >
> > > >
> > > >
> > > > ---
> > > > Regards,
> > > > Linux Bluetooth
> > >
> > > Applied, thanks.
> >
> > This seems to at least partially back out of:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=d36c45c55
> >
> > And as such, reintroduce the bug it fixed:
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=1534857
> > https://bugs.archlinux.org/task/57464
> >
> > Me and two others in the pulseaudio IRC channel see this connection
> > failure appear, and I've locally confirmed reverting this patch resolves
> > the issue yet again.
>
> Hmm so that is the actual problem that PA can't find the adapter, this
> has been popping up quite a lot in our github issues, so I guess we
> will need to revert it and update the properties after reading the
> features, can either of you come with a patch for that?

I went ahead and send the following patch, hopefully we won't have to
worry about this sort of problem with that:

https://patchwork.kernel.org/project/bluetooth/patch/20220204013620.2465024-1-luiz.dentz@gmail.com/

-- 
Luiz Augusto von Dentz
