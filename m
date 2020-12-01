Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EFEC64E7A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 23:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D92F221E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 23:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgLAXEJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 18:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgLAXEJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 18:04:09 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A06C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Dec 2020 15:03:29 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u19so8128911lfr.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Dec 2020 15:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=swagCWTEugzOrNMoP0Q8yf0CpGk5roRj7rznuoN/djc=;
        b=rsIYjqQM6ktDgp3BaM5WoFzBCz04Mw4spmxwUAAJI2B/5n0COzw2Tyul5CqcZ7jm+z
         pI0QLkEep3q2gWfV7NtEUk0xa1bWqI7EVaDsMXFAxps1IMblr039KXoDZk1DycbdX7Dh
         g1RKV3noED4AIKkXzTLwPyWkAN4sw+oFGS7RVgfjKcUuMQv0a7zBc47qGI1PGNGQWDwi
         OW9ruB5fRa44DrCh/cMuEUQk2kz6SmjqfSVNGecEvvA3gLSoLXien+uiBPqn8bd+WfJj
         79KeWEGZSlMGn/vDSQvRK6inwt7aONoFo+D/Luont/0jAaIR9X77EuD/5GaI0jFUbfGO
         IZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swagCWTEugzOrNMoP0Q8yf0CpGk5roRj7rznuoN/djc=;
        b=WDb+cm3t8QXGmPhoA2XNYJJGjn2baqwGaCwcS02vz+kE37ONXj4HAPRl+1rjHw7mzf
         Bt/MIPEPdK2pyun/YuxLbs47NA50yrvCSeNLv/HcIKwFqZA4wFQJs/xwX+/nxz43n6dv
         Hzvdgn9V+kf6pmM536qZQb9exqCcMR4gAmHtw6+3XhhD6TEOSvMBs7F0lekgxNDpTn1U
         flG8xnOV5Xjvem5mumhxoqEIg0dBQ4QOV9vsQxie/XRDw0XZfipHM2GDgC0uCl3vDGUm
         vwYqDBO8JE1ip1uJ89GimBMI7EGLQlfYfDfqvYVz2ALx+jwweCwqrZq3EraNmHtubZ8V
         9XiA==
X-Gm-Message-State: AOAM531ughrXm5JCq3CrJBPyHnWDu2lxSVy3oHhAqSNguY5lHV6nmpKW
        lcXWL5aOYZokeZOgoMYjtOsId7IFBb1Y9Ste8XsJ/uMBQ1kcqLMq
X-Google-Smtp-Source: ABdhPJyVPGdBPLi/E2hdVbPZJ6NALTZTb9knGtEVlyMoQfQXI3gPm1bsRpd8+U2I7tM8A0A247bNQ1iioZasjZz+xXI=
X-Received: by 2002:a19:8883:: with SMTP id k125mr2171139lfd.10.1606863806536;
 Tue, 01 Dec 2020 15:03:26 -0800 (PST)
MIME-Version: 1.0
References: <CALWDO_Ug-VzXmrTOUmMKgQSqqVx-b_L5rekwnv53d4ynjzyfYg@mail.gmail.com>
 <C7HTF3EX487A.12XRHXZKFSF76@rxps>
In-Reply-To: <C7HTF3EX487A.12XRHXZKFSF76@rxps>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 1 Dec 2020 18:03:18 -0500
Message-ID: <CALWDO_XbKaLVsfTmkOU56-xtad7RAFAVnGRux_Ls40qDzF-yFg@mail.gmail.com>
Subject: Re: [BlueZ] main.conf: use correct key for BREDR configuration
To:     Ronan Pigott <rpigott314@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I likely won't get to it for a little while, but if someone will be
fixing this, we also noticed this issue while reviewing the related
patch:

{ "PageTimeout",
&btd_opts.defaults.br.page_timeout,
sizeof(btd_opts.defaults.br.page_scan_win), //<-- this should also be
page_timeout rather than page_scan_win
0x0001,
0xFFFF},

Thanks!
Alain

On Tue, Dec 1, 2020 at 5:53 PM Ronan Pigott <rpigott314@gmail.com> wrote:
>
> On Tue Dec 1, 2020 at 8:33 AM MST, Alain Michaud wrote:
> > Hi Luiz/Ronan,
> >
> > This appears to have been an incorrect fix since
> > parse_mode_config(config, "BREDR", params, ARRAY_SIZE(params)); will
> > attempt to read from the BREDR section. My suggestion would be to
> > update the group table entry instead:
>
> Oh, that's right. Whoops.
>
> Updating the group table sounds good to me.
