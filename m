Return-Path: <SRS0=4il6=YE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9F2C47404
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 13:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F158A2089F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 13:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABThd2M9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfJKNHf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:07:35 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32790 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfJKNHc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Oct 2019 09:07:32 -0400
Received: by mail-oi1-f196.google.com with SMTP id a15so7946120oic.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2019 06:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfCJU2Y7boHnbsfL4/kbl3IEV5kiFdSVuWR7/jhRHUA=;
        b=ABThd2M9lXeRQwWhhuRRnQHFWzGtQcmsoWZBU00bB4ePiPjPdKjz5gPZBYhxipkidG
         tKTAMZg27Sfk3fUmPqMbbvFMazLuzfqZLqBfkPf3j31Tkk2UPiCrljX1cBlVc72lPqvm
         FN0/XMzks2qfHM55Ezw+mJ7ET+EiAW8S3KYg3bRK4iukhqlv5A59JaAn9x0SkSlUE2KI
         cSic9hvHV2mfQF3oMT/hu19jXKlGX2dpWA2+XXMCXmEoymGMH1s2ADpb8czOg1rW50Dw
         LuON57E1BqVhpzIsUFYJqgyEs5by+OQSPGPl5cSJXOP5JRMbtzZMUNpGuNaEoiOEI4hm
         QAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfCJU2Y7boHnbsfL4/kbl3IEV5kiFdSVuWR7/jhRHUA=;
        b=LUWh/PNwFcgof1OPno9yVtc9Y58Iz2bJ1R407HKlg9mxnlaqC6rm+oR7SymCcr2eVc
         iSIeacotLhWXtTDHJy/4bA4JZlDyImo4d4mnOMjshp0LLe48T8TMcyHfChkUpEUfKp6I
         2URQ4Z63VYDmXlb6xNt6x46Rdkt1W1/cOdvqb04durhXRruJinjYFwB+nsNpW8dmtOqA
         oXBR0Hiy04DZ+RZfE1aHu/oPHRgXboOHesVPadQFZsHSPwqR+TP2kfgEQElms7YTayoW
         kmVidksRHJLuaZkYDhOPvLmLxouo+NllUZiJRkHLRgPRw7MEa4nhQoSegaexiQ3Fu0Ma
         bY4A==
X-Gm-Message-State: APjAAAVBJCa4AptfTPzfNsJNwYfhljLbISXYpj2Yf7dm5PFfP9XVNc5z
        ses4e+BycIjZmlbIMBOY4wiXhK/zNNjE4GeErkpNq4GNtTMh3Q==
X-Google-Smtp-Source: APXvYqzpANpw6UP49Y+D1n0ZH0u+WyjCPVDTgBRXwMDsfPYWuHVSqTwLGYguT1cV/w/enR7L7rb6H2Be4fMljUCiMlo=
X-Received: by 2002:aca:3c83:: with SMTP id j125mr12242991oia.108.1570799251763;
 Fri, 11 Oct 2019 06:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191003204405.27285-1-brian.gix@intel.com> <e9d186c8d89be278252ddfe3982602be984f3c14.camel@intel.com>
 <CABBYNZJ1L6ZaMe-Vf97jc=NxBEHwAs4gOGMQX_THJ-++w7Rnvg@mail.gmail.com> <eccd2dff7fa5e04605a3b0302315060f99c80e53.camel@intel.com>
In-Reply-To: <eccd2dff7fa5e04605a3b0302315060f99c80e53.camel@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 11 Oct 2019 16:07:18 +0300
Message-ID: <CABBYNZJXWe12oFUB+AXkDELFSDSLq9Dof1TJ-RYqjzEw3mVKzQ@mail.gmail.com>
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

On Wed, Oct 9, 2019 at 7:01 PM Gix, Brian <brian.gix@intel.com> wrote:
>
> Hi Luiz,
>
> On Wed, 2019-10-09 at 17:59 +0300, Luiz Augusto von Dentz wrote:
> > On Thu, 2019-10-03 at 13:44 -0700, Brian Gix wrote:
> > > > This unit test will be grown over time to include tests formed from the
> > > > sample data in the Bluetooth Mesh Profile specification (Currently at
> > > > version v1.0.1).
> > > >
> > > > Currently it includes test cases for the following sets of sample data:
> > > > Sections 8.1.1-6
> > > > Sections 8.2.1-6
> > > > Sections 8.3.1-11
> > > > Section 8.4.3
> > > > Section 8.6.2
> > > > ---
> > > >  Makefile.am             |   10 +
> > > >  unit/test-mesh-crypto.c | 2000 +++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 2010 insertions(+)
> > > >  create mode 100644 unit/test-mesh-crypto.c
> > > >
> >
> > make test is failing on this one:
>
> What platform/command line are you getting to see this?  or are you running it under a static analysis tool of
> some sort?
>
> I am getting no errors on F30, bith 32 and 64 bit...
>
> But I will check out the check_id_beacon() function...

I think you might not have valgrind installed or the build is not able
to detect, anyway you can run the test manually like this:

valgrind --trace-children=yes --leak-check=full --show-reachable=no
unit/test-mesh-crypto

> >
> > ==25559== 8 bytes in 1 blocks are definitely lost in loss record 1 of 4
> > ==25559==    at 0x483880B: malloc (vg_replace_malloc.c:309)
> > ==25559==    by 0x11FB25: l_malloc (util.c:62)
> > ==25559==    by 0x120232: l_util_from_hexstring (util.c:427)
> > ==25559==    by 0x118069: check_id_beacon (test-mesh-crypto.c:1709)
> > ==25559==    by 0x118069: main (test-mesh-crypto.c:1997)
> >
> > Btw usually the test are using the tester framework and it should be
> > possible to integrate with that but that probably need some work to
> > make you able to run with ell mainloop.
> >
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
