Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C66EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Feb 2022 23:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347868AbiBCXES (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Feb 2022 18:04:18 -0500
Received: from relay08.th.seeweb.it ([5.144.164.169]:43593 "EHLO
        relay08.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiBCXER (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Feb 2022 18:04:17 -0500
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 915493F79B;
        Fri,  4 Feb 2022 00:04:15 +0100 (CET)
Date:   Fri, 4 Feb 2022 00:04:12 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Claudio Takahasi <claudio.takahasi@gmail.com>,
        igor.v.kovalenko@gmail.com
Subject: Re: [BlueZ] advertising: Fix reporting advertising properties
Message-ID: <20220203230412.dig2cu3vy2uzgsim@SoMainline.org>
References: <20211215180527.886481-1-claudio.takahasi@gmail.com>
 <61ba372b.1c69fb81.82f24.9d4f@mx.google.com>
 <CABBYNZKBPuR-W1iko=rF=jLJw1pq05SKUDWr2+7LAvR0BJpwQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZKBPuR-W1iko=rF=jLJw1pq05SKUDWr2+7LAvR0BJpwQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Claudio, Luiz,

On 2021-12-15 14:53:04, Luiz Augusto von Dentz wrote:
> Hi Claudio,
> 
> On Wed, Dec 15, 2021 at 12:50 PM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=596151
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    PASS      1.47 seconds
> > GitLint                       PASS      0.99 seconds
> > Prep - Setup ELL              PASS      49.04 seconds
> > Build - Prep                  PASS      0.61 seconds
> > Build - Configure             PASS      9.40 seconds
> > Build - Make                  PASS      209.53 seconds
> > Make Check                    PASS      9.37 seconds
> > Make Distcheck                PASS      248.72 seconds
> > Build w/ext ELL - Configure   PASS      9.46 seconds
> > Build w/ext ELL - Make        PASS      198.40 seconds
> > Incremental Build with patchesPASS      0.00 seconds
> >
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth
> 
> Applied, thanks.

This seems to at least partially back out of:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=d36c45c55

And as such, reintroduce the bug it fixed:

https://bugzilla.redhat.com/show_bug.cgi?id=1534857
https://bugs.archlinux.org/task/57464

Me and two others in the pulseaudio IRC channel see this connection
failure appear, and I've locally confirmed reverting this patch resolves
the issue yet again.

- Marijn
