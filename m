Return-Path: <SRS0=7chU=YC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77562ECE58D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 14:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F32B218AC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 14:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAGGoaOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbfJIO7X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:59:23 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34158 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730546AbfJIO7W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Oct 2019 10:59:22 -0400
Received: by mail-oi1-f193.google.com with SMTP id 83so2026672oii.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Oct 2019 07:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xLqeYvJdzmh7KNV5+v6muB5CxR1PedcsevU05ZD3D2w=;
        b=JAGGoaOP9zVCCG5qhMattBbJKx8NfUvSJLMnWjA67f8SPFg+EhmWV2ZpAkaY8GvbKP
         124uenluPFZ5kaBR2bi1OQQWZBK9nENo7r1/h9Va1dB+LKu2novhg3R6UNkvH1AZdXy5
         WpEphiFjnnL203oBY4KDLM/B/guWi1CuW1Do3Hi7MvooI61A7nX9tlBIlo9azxQ/Twxh
         XU8IlehAcQ0XB0Dppii8sVQp6HSAz+cMr3rHxz4be2mjgpCEC3yuZhOeyju1A168Ci7o
         7zV/IRFssvu0tfnxfmhW3WKhWNU3FAMHh3BDUb+S3xG84v1tfsDnO9FDDsLMgSKv2xyY
         c9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xLqeYvJdzmh7KNV5+v6muB5CxR1PedcsevU05ZD3D2w=;
        b=pmzn6ifpH29B3uKwSCMZFWeyAzAZUq1tgg5NZVqUx0d3CcVBdz+OBtdBU01mZnpRuW
         8kck/TedWeJFVNxOb5D4LhkaJYJPTrQmPo6gHdkxeO87wo1tzBBuB0OiI1XhVgKuXY3x
         V2v2tpbQGNLS9myEnFuEuwallqa72cMEMHyPUPCzuKFW9gSnO+v1XpJuMBoWRA4FIhN8
         qY8U3SvvJH9p2vGUNTPqU3Fbn9hRWqEFVOckBHVECq81CQ9zHaq/Aw4r5C2yQqF+4PN8
         Rcr/4+mCWRkFhB0T8dL5jfoIf2Wn+UBYoPxiOI4i1iDIujyCudFArFpPzsyqkiO/WOGy
         sG1A==
X-Gm-Message-State: APjAAAUaunVJDY1bkSg8ImvHULb7DOy3qxc0E/ycFaPHV5cEeWIzzymw
        dpFIVCfMOZD0yKW5wJ1EauD8ffsEtD+CGa2cvpg=
X-Google-Smtp-Source: APXvYqxuT0/jV85rUcgf4mee++8CZraFSZUoZ5GtVsGXtKA6DX/YiTPjlv3jKJTUglpT+VbGdRsaxD3LDUHjWQ8ejpg=
X-Received: by 2002:aca:3c83:: with SMTP id j125mr2813984oia.108.1570633160090;
 Wed, 09 Oct 2019 07:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191003204405.27285-1-brian.gix@intel.com> <e9d186c8d89be278252ddfe3982602be984f3c14.camel@intel.com>
In-Reply-To: <e9d186c8d89be278252ddfe3982602be984f3c14.camel@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Oct 2019 17:59:08 +0300
Message-ID: <CABBYNZJ1L6ZaMe-Vf97jc=NxBEHwAs4gOGMQX_THJ-++w7Rnvg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] unit: Add Mesh Crypto tests from Mesh Profile Spec
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On Sat, Oct 5, 2019 at 7:17 PM Gix, Brian <brian.gix@intel.com> wrote:
>
> Applied
>
> On Thu, 2019-10-03 at 13:44 -0700, Brian Gix wrote:
> > This unit test will be grown over time to include tests formed from the
> > sample data in the Bluetooth Mesh Profile specification (Currently at
> > version v1.0.1).
> >
> > Currently it includes test cases for the following sets of sample data:
> > Sections 8.1.1-6
> > Sections 8.2.1-6
> > Sections 8.3.1-11
> > Section 8.4.3
> > Section 8.6.2
> > ---
> >  Makefile.am             |   10 +
> >  unit/test-mesh-crypto.c | 2000 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 2010 insertions(+)
> >  create mode 100644 unit/test-mesh-crypto.c
> >

make test is failing on this one:

==25559== 8 bytes in 1 blocks are definitely lost in loss record 1 of 4
==25559==    at 0x483880B: malloc (vg_replace_malloc.c:309)
==25559==    by 0x11FB25: l_malloc (util.c:62)
==25559==    by 0x120232: l_util_from_hexstring (util.c:427)
==25559==    by 0x118069: check_id_beacon (test-mesh-crypto.c:1709)
==25559==    by 0x118069: main (test-mesh-crypto.c:1997)

Btw usually the test are using the tester framework and it should be
possible to integrate with that but that probably need some work to
make you able to run with ell mainloop.




--
Luiz Augusto von Dentz
