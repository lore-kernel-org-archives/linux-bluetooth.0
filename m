Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05405C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 21:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E839720659
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 21:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YOK9MJ+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgEMVlT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 May 2020 17:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729196AbgEMVlS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 May 2020 17:41:18 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80665C061A0C
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 14:41:18 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id i9so282805ool.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jUgqD/1mE0M/NdryDGvF9KXQVYSbR3hhJRpB8xR6LTs=;
        b=YOK9MJ+H0dndV1ZERYL9GGnqvRa6gSM4o0PrPHr2zRSGSbD1yFMOQmIJCEB9yX3a3K
         kIsBq38gPhAg1j/KJcw29e2IDwV5FAUmrI43pe9vNTUmG+RFzIf1u+hOvT5nrf3NoGOL
         HrsPWt1ekSVRFLU7GzpBr+hXsb4V1pu/c9I5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jUgqD/1mE0M/NdryDGvF9KXQVYSbR3hhJRpB8xR6LTs=;
        b=YOiI4+dwxZn7yjSVM6D4hKUQuW6MJEcvCwoKe7pZ3NkbKZg+2qKqe8d/er0pe3STzm
         1aGiucbfYRtpiHLn1gYLchXrbgOEzoCXkoIVNuO/6grNbX15IZTGB9HCwouojJ9bdzEW
         gLEtcXifyyCKgYOpNRL5+z+WuWelxnR22GAeHMRp9jQztsAsaNVD/j4z8MQ9esCGzaEn
         Wb3wfJC2je71OvAJkN++kHEsHrTwKl37nqGheoWTucLOQ1LcGeA4n4fMUsU+10cHx2fh
         vq+kRr2Ro95sgADKEgFiwv1GApoSEfKZ9XCaNDQh2U8We49N3rZhLVyQxVKcQEG0Rx8G
         9snA==
X-Gm-Message-State: AOAM530e60rUbnjvWeZAZ4va4BkKd0f8fbz+iAf/XszD09dcuVB1NPYx
        brbNM1yXHcBJCatsM9UbxIHtmMT/dHMfTMg/4mXnSiHL
X-Google-Smtp-Source: ABdhPJz5BntoK2GIWrvV4WY2HWqMVs02E9dyHTm5aJ6oOaIr2FZaudwGY6o0EBDtv2TGoK/0wqxay2DXWJFMirRA+Us=
X-Received: by 2002:a4a:2511:: with SMTP id g17mr1177931ooa.24.1589406077842;
 Wed, 13 May 2020 14:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005528.2897-1-sonnysasaka@chromium.org> <77B1AB20-C903-427C-A3BD-E10C79815EF9@holtmann.org>
In-Reply-To: <77B1AB20-C903-427C-A3BD-E10C79815EF9@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 13 May 2020 14:41:06 -0700
Message-ID: <CAOxioNkki7ZXHgz5VoTcfYzukiupHgs4Z1KktMFm4Cn8BX3+Hg@mail.gmail.com>
Subject: Re: [PATCH] build: Add an option to explicitly disable installing hid2hci
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for the suggestion, Marcel. I have sent the v2 patch, please
take another look. Thanks.

On Wed, May 13, 2020 at 1:02 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sonny,
>
> > ---
> > configure.ac | 5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/configure.ac b/configure.ac
> > index 1433ace4a..ba9937a16 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -218,8 +218,11 @@ if (test "${enable_udev}" != "no" && test -z "${path_udevdir}"); then
> > fi
> > AC_SUBST(UDEV_DIR, [${path_udevdir}])
> >
> > +AC_ARG_ENABLE(hid2hci, AC_HELP_STRING([--disable-hid2hci],
> > +             [disable hid2hci tool]), [enable_hid2hci=${enableval}])
> > AM_CONDITIONAL(HID2HCI, test "${enable_tools}" != "no" &&
> > -                                             test "${enable_udev}" != "no")
> > +                                     test "${enable_udev}" != "no" &&
> > +                                     test "${enable_hid2hci}" != "no")
>
> I looked at this again. Lets turn this around and make this an --enable-hid2hci similar to --enable-sixaxis.
>
> And you need to change the ${enable_tools} into ${enable_hid2hci} actually and not just add another dependency. Everything else seems to be already in the Makefile.tools for this.
>
> Regards
>
> Marcel
>
