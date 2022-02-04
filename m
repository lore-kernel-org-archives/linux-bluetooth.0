Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3442EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Feb 2022 15:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359803AbiBDPl5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Feb 2022 10:41:57 -0500
Received: from relay05.th.seeweb.it ([5.144.164.166]:51577 "EHLO
        relay05.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359802AbiBDPl5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Feb 2022 10:41:57 -0500
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 345383F370;
        Fri,  4 Feb 2022 16:41:55 +0100 (CET)
Date:   Fri, 4 Feb 2022 16:41:53 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Claudio Takahasi <claudio.takahasi@gmail.com>,
        igor.v.kovalenko@gmail.com
Subject: Re: [BlueZ] advertising: Fix reporting advertising properties
Message-ID: <20220204154153.e6bmbmhj5qsi53hr@SoMainline.org>
References: <20211215180527.886481-1-claudio.takahasi@gmail.com>
 <61ba372b.1c69fb81.82f24.9d4f@mx.google.com>
 <CABBYNZKBPuR-W1iko=rF=jLJw1pq05SKUDWr2+7LAvR0BJpwQA@mail.gmail.com>
 <20220203230412.dig2cu3vy2uzgsim@SoMainline.org>
 <CABBYNZ+29R2=4orBVicSmCi8gcTQJOHuhJbLfm1ihobg9XRznA@mail.gmail.com>
 <CABBYNZ+ae0+EYv=Am2xJp8_50g0TTW=bHYqFKpq1+Y=UtNYvqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZ+ae0+EYv=Am2xJp8_50g0TTW=bHYqFKpq1+Y=UtNYvqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2022-02-03 17:43:16, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Thu, Feb 3, 2022 at 5:06 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Marijn.
> >
> > On Thu, Feb 3, 2022 at 3:04 PM Marijn Suijten
> > <marijn.suijten@somainline.org> wrote:
> > >
> > > Hi Claudio, Luiz,
> > >
> > > On 2021-12-15 14:53:04, Luiz Augusto von Dentz wrote:
> > > > Hi Claudio,
> > > >
> > > > On Wed, Dec 15, 2021 at 12:50 PM <bluez.test.bot@gmail.com> wrote:
> > > > >
> > > > > This is automated email and please do not reply to this email!
> > > > >
> > > > > Dear submitter,
> > > > >
> > > > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > > > This is a CI test results with your patch series:
> > > > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=596151
> > > > >
> > > > > ---Test result---
> > > > >
> > > > > Test Summary:
> > > > > CheckPatch                    PASS      1.47 seconds
> > > > > GitLint                       PASS      0.99 seconds
> > > > > Prep - Setup ELL              PASS      49.04 seconds
> > > > > Build - Prep                  PASS      0.61 seconds
> > > > > Build - Configure             PASS      9.40 seconds
> > > > > Build - Make                  PASS      209.53 seconds
> > > > > Make Check                    PASS      9.37 seconds
> > > > > Make Distcheck                PASS      248.72 seconds
> > > > > Build w/ext ELL - Configure   PASS      9.46 seconds
> > > > > Build w/ext ELL - Make        PASS      198.40 seconds
> > > > > Incremental Build with patchesPASS      0.00 seconds
> > > > >
> > > > >
> > > > >
> > > > > ---
> > > > > Regards,
> > > > > Linux Bluetooth
> > > >
> > > > Applied, thanks.
> > >
> > > This seems to at least partially back out of:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=d36c45c55
> > >
> > > And as such, reintroduce the bug it fixed:
> > >
> > > https://bugzilla.redhat.com/show_bug.cgi?id=1534857
> > > https://bugs.archlinux.org/task/57464
> > >
> > > Me and two others in the pulseaudio IRC channel see this connection
> > > failure appear, and I've locally confirmed reverting this patch resolves
> > > the issue yet again.
> >
> > Hmm so that is the actual problem that PA can't find the adapter, this
> > has been popping up quite a lot in our github issues, so I guess we
> > will need to revert it and update the properties after reading the
> > features, can either of you come with a patch for that?

Perhaps yes, I haven't had more time to look into this than seeing the
original patch and spotting this patch to "advertising" recently while
bisecting 5.62 and 5.63.  Looks like you came up with a neat solution,
would have taken me some time to get accustomed to this bit of BlueZ :)

> 
> I went ahead and send the following patch, hopefully we won't have to
> worry about this sort of problem with that:
> 
> https://patchwork.kernel.org/project/bluetooth/patch/20220204013620.2465024-1-luiz.dentz@gmail.com/

Many thanks, that addresses the issue once again!

- Marijn

> -- 
> Luiz Augusto von Dentz
