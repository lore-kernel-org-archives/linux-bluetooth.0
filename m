Return-Path: <SRS0=KpSE=DP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3780DC43467
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Oct 2020 00:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A726E207EA
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Oct 2020 00:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwmxMOE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgJHAAO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Oct 2020 20:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgJHAAO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Oct 2020 20:00:14 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EA6C061755
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2020 17:00:12 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id d28so3994172ote.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2020 17:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/OvJkLNgLY51M/T+bgW7dh/6HmgEGhI1x6njqYG4UnE=;
        b=bwmxMOE6p15n74y6G2XfOlrs/WsUYgK+qBKMy4aKgSPUZWCQEowl8EbhPMngTLxWZ+
         PYvfKUF44Lf63g2NpPXA8rzo5sfPi+CjWd8x+b/J4P7v/PA0DFevOJ0IJGvdMYVxgmiP
         wXCTwvh2pbC9Ft1HsXaWKKGzzUGVajNMe2UrIb5OJuLypKWXVVaJi+SQlBNBQSxD0kNN
         wVR4Id8b9DtpsggO6WCBUGJdh/aitnkh4gHAhzoIii6d5zS7Oiu7fbvDbpJpdjNeTFWa
         jtYasAxBM4qFN2hymp4OoQTLcRG9WKMPSDiqZfttW4cgRTOx/lr659TLOL0PiQDVp6Gx
         HF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OvJkLNgLY51M/T+bgW7dh/6HmgEGhI1x6njqYG4UnE=;
        b=U90tzZXJNnqEAEnnQsQdmneBptv8wY30lJT8qmQS8gcIlO+KVyJi6RskpRhC1YOzH0
         EeX66rA8OTrbhgGvKPWVmaW9z2XYIfc+gUR4KfOIAt2+v0pPwp0m0eZtgHTkY+XTwWs5
         mFS6IEBv3jASkMzqWGnUkjC1jQx2bUhtmiw3pHnXYu9xlvK5PcCjrVvuUhWkFNMz+Ra2
         vpqPvj3r4hkYIor1wiJAncOXqiNfkPouMA/5xVXW3hIuVGvWftZRsmc58CV6FM7hgZeg
         It1L0/TDZu5MhTUb0LwOz0TC8/YBc1JlxNRwcuPcA/Ljv9Rf25Wy2E5IyMXVP4Lidgzn
         jZtw==
X-Gm-Message-State: AOAM530QizvrjaSnD96WV8NY7cZE3Naiz4deLKzzKFKektn0pBIuG2NJ
        wD7WmCUOCnoAlB/q5Hs0UD/FM3MvdIN7Cg5uMuAqpdHV
X-Google-Smtp-Source: ABdhPJywSTAFLjy7um6MnFm/U569nrz0EfNTIugiLt9WiltEKoSdQSOwfFIZI6ntT4FnsZmIWuZaTPO9J8lT7bX5X/k=
X-Received: by 2002:a05:6830:400d:: with SMTP id h13mr3477186ots.371.1602115211701;
 Wed, 07 Oct 2020 17:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200928064446.17803-1-machiry@cs.ucsb.edu> <5f719177.1c69fb81.4e1d.07c5@mx.google.com>
 <CANozA0imy3i=ohQLLAA0ou32qBAEfAk0QGrXzMWBTqueO-8wfg@mail.gmail.com>
In-Reply-To: <CANozA0imy3i=ohQLLAA0ou32qBAEfAk0QGrXzMWBTqueO-8wfg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 7 Oct 2020 16:59:58 -0700
Message-ID: <CABBYNZKzOJ0Nmzvobe1EV_mB7ceNq6P-kObPJnp8dJL1p2LvPQ@mail.gmail.com>
Subject: Re: [BlueZ] lib/sdp.c: Validate attribute search return value
To:     Aravind Machiry <machiry@cs.ucsb.edu>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sat, Oct 3, 2020 at 11:14 AM Aravind Machiry <machiry@cs.ucsb.edu> wrote:
>
> Gentle reminder!
>
> On Mon, Sep 28, 2020 at 12:32 AM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=356319
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
> >

Applied, thanks.

-- 
Luiz Augusto von Dentz
