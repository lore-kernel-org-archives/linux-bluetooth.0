Return-Path: <SRS0=SAxJ=4M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF11C11D2F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 17:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8169520836
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 17:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRqZ5HtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBXROA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:14:00 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:40495 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgBXROA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Feb 2020 12:14:00 -0500
Received: by mail-lj1-f180.google.com with SMTP id n18so10975328ljo.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 09:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aq4kJ/ZkHIbJkjTML+6K0wGl3MuZVZU0oKH1dY94hE0=;
        b=VRqZ5HtY6wovf96gUCwCw2saf/2HSnyerpcQGExIgSRrWC9HUQE5j9gc1pcEUKi4Ud
         myoWhANB9qniFHd6y4Piiy1VneutlAz8+E3FkedOI6NvGdHkiXYwm2SRr1H4iRQY75vf
         uFlpwTqIJFLxW/Z5faaIToM1CNfNekpnvLyVtGDvN3ndTRJLHnwE7iajF/KH/9MtXqZ/
         fVXw0WOQIL1mIOulImolYTESnvy3ClwQWdUmKmEzfxyaGMARqxKIcHpYmMlowIwWKxWf
         Mo4oRfgZQacrVc9tFZq/cml4wQtSU59Rs+WtIMNRtc9j+bdbJ4g6pSD5WtCM1abq+xCE
         /dDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aq4kJ/ZkHIbJkjTML+6K0wGl3MuZVZU0oKH1dY94hE0=;
        b=Oi0+wNcr4uOhzaGuITXe+rOe1YUvo+eb5hQetW0CiBr51rd12kNdrohCX37tRvXvLY
         fRgijBZgZlsxPBold+Zws34chQzfaZ+LakwZ0W1wYYZUcrxpCDK56zxjKTPrOJ9WBkx0
         Nr/HQk0OyLIuF4/RMDY/LByCAL4vyC8PsyNpMBScE+RnSF2qJH9qvibt2VX2azU2tpE6
         ICXZrLVS5kSqrIkm29GZODG1aUvheNOwlNkDcoM1JPaG2kTPKXja+ltBxwsZnC4BDsQr
         2LhKbWYeQuMYSqndVtB+qP3B8G8U/huAUOT5TMqyFFBa97h1iXxqviEF0U3iLfXYTVjp
         IVvQ==
X-Gm-Message-State: APjAAAVVTIkVWkQGAIFOU8M88+7NJZ0RKDKkvZQaXaau/xEEZT5cKZR8
        feskJcr4HFhUz/Q+IDk9DzbecxmixEx9OMZUW4vk7Zor7z9yDw==
X-Google-Smtp-Source: APXvYqxLVeOyZQK/gmpIc5Q7u7DDsfWhCCKFEfwzgU7kWajb7Xn0i3cn2KBaxCHEGPehcX0PLA1GYenEk5/LLcbuCCw=
X-Received: by 2002:a2e:574d:: with SMTP id r13mr30317521ljd.63.1582564436496;
 Mon, 24 Feb 2020 09:13:56 -0800 (PST)
MIME-Version: 1.0
References: <CAD3n0hm61cRPK3=Scf02y3Y3aMJ66eCC5nwFh40Y9kfLBWk-tw@mail.gmail.com>
 <CAAu3APZ4WqFd=61eUfbC8biTbygWW4k2Te3De38B2+maYoBePw@mail.gmail.com> <CAD3n0hnJkmXGjiei0-u=GBh0xoGb4N7tkuBh_uSvsuT7bAhXLA@mail.gmail.com>
In-Reply-To: <CAD3n0hnJkmXGjiei0-u=GBh0xoGb4N7tkuBh_uSvsuT7bAhXLA@mail.gmail.com>
From:   Barry Byford <31baz66@gmail.com>
Date:   Mon, 24 Feb 2020 17:13:44 +0000
Message-ID: <CAAu3APbWouHkguPG3_FQmxPY=6q6rzmr_CbOqY2_0a0RzC++XQ@mail.gmail.com>
Subject: Re: Bluez blotoothctl scan vs hcitool scan
To:     chris baker <chrisbkr2020@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If the DBus API is not cutting it for you then using the MGMT API
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt
is what has been recommended in the past:
https://www.spinics.net/lists/linux-bluetooth/msg68959.html

On Mon, 24 Feb 2020 at 16:37, chris baker <chrisbkr2020@gmail.com> wrote:
>
> On Mon, Feb 24, 2020 at 6:08 AM Barry Byford <31baz66@gmail.com> wrote:
> >
> > Hi Chris,
> >
> > On Mon, 24 Feb 2020 at 10:12, chris baker <chrisbkr2020@gmail.com> wrote:
> > >
> >
> > > So my question is, is there a way to get those missing advertisements
> > > through the dbus api, possibly some additional setting somewhere?
> >
> > Duplicates are disabled by default with the DBus API. This can be
> > controlled with the DuplicateData setting:
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n107
> >
> > Regards,
> > Barry
>
>
> My apologies, I guess I wasn't clear (long post) but, I turned
> duplicate data on when using the bluetoothctl command (via the "scan"
> submenu) and also used the flag, "hcitool lescan --duplicates", when
> running the hcitool command. So both scans should have included any
> duplicates (unless I've misunderstood something). Additionally, none
> of the missing packets were duplicates (again, unless I'm
> misunderstanding what "duplicates" means). each packet had a unique
> sequence numbers as well as the button data field toggling.
