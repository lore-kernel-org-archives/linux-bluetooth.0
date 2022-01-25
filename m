Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85042C4321E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 02:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354495AbiAYCeE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jan 2022 21:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415977AbiAYBxj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jan 2022 20:53:39 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D55C028BEF
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 17:13:58 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id m6so56920611ybc.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 17:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nB16MGqkZS72AZ0ACsRFubInnC+/wBnIiO3MbQ6anp0=;
        b=NmBGAogjGVkA3ptx+hRqm6GSVRrIYnS6Cr7HueFCJVvQARI/ctzyX+9aXngCQnqQyD
         n0SqaqGpJ1pqzNuw9H49imX9SthVXg6u+gp8RkrqNhcP0olZLesFrUAkm5bKmtMIvy39
         QEbydLkV65Sjns0MoTvIY3R6MF5UC/JU7spYWLDUyOFMll8duI4T8U+7cz0WWcgJMjZR
         OLI+eEhjrE1BM7z7VY5caACPEs4XhVLBVUGhmO3I2USyHGiElIEjDC6nPBf/vhUX4kmj
         0l/8aqqbLpcZKEKez985TyBA+uel+XFrqj4uPPgmDQdemXN/DbEefA1BYjYkftjUJp5F
         FpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nB16MGqkZS72AZ0ACsRFubInnC+/wBnIiO3MbQ6anp0=;
        b=RZOXMx/L2fZNbEv8K5xrzK/QEKItuUig6C9BU0uROa0ax6JY01nBVJSFQ/qvXn+n8m
         V8AdBAEkeoNcNytmtbNiB9JwFE5utIYBmi7gXK+kaO40GWQsy79fUVoab4HHsCoNk/9c
         bM4a1nSK3bbAnhxHqBhzjOLxny0s2638aSrCL6MqJlYeJNFI6wrPwcMs+R7kLD49t5+o
         rGz4g8ShEYyUzbbZyP7uK7ocG30QUYTN0ueNt+mHP3YJsTAywTlpV97YNH21QfnPmMPh
         O5O8Q8wmBchhh0B7WTRpS/X6UVWohKe7ytujpsS2jMlvILab7Gac9/FOo8Fynuz4dA0w
         gk1w==
X-Gm-Message-State: AOAM532ifEr8TLhtX4K57uHN1CTQUHeYX1yarySQ5uIZb6AFRAHPH64D
        FTaQQiADOD5KwCBiz+YIiuJYGZF654l0V/l2M34=
X-Google-Smtp-Source: ABdhPJyRsnGICnaSqTzT/j9E5K7A4JKGiKQ0JG6Vm1eWlkr21cySGwVbMULKLENXQrRIF4IkFCZ7OKyqr91Bth1dk9w=
X-Received: by 2002:a25:c41:: with SMTP id 62mr26480923ybm.284.1643073237906;
 Mon, 24 Jan 2022 17:13:57 -0800 (PST)
MIME-Version: 1.0
References: <4124ccb8-11f-21e9-982e-7fb07f23225@panix.com> <CABBYNZLt3GmBTmAADa+FF2bdEfzMg_9Horxk2pT85BC+LFgrMQ@mail.gmail.com>
 <91c1e9ef-4786-b9f5-8bb8-b93c84c0874b@panix.com>
In-Reply-To: <91c1e9ef-4786-b9f5-8bb8-b93c84c0874b@panix.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 24 Jan 2022 17:13:47 -0800
Message-ID: <CABBYNZ+t+L=G-X0qt=Cnn7vUpLu2s1=purmAESnCaRvK7XtmdQ@mail.gmail.com>
Subject: Re: Commit ad383c2c6 ("Bluetooth: hci_sync: Enable advertising when
 LL privacy is enabled") breaks my MS ArcTouch mouse
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kenneth,

On Mon, Jan 24, 2022 at 11:59 AM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> On Mon, 24 Jan 2022, Luiz Augusto von Dentz wrote:
>
> > > I'm running Linus' master (as of today, 1c52283265a462a100). With this commit in
> > > place I get no bluetooth ("hcitool dev" shows no adapters) and/or I can't see my
> > > MS ArcTouch mouse.
>
> > It would be great to have some logs, btmon, dmesg, etc.
>
> That's just it- nothing shows up in any log/dmesg; unlike when a non-MS mouse is
> detected and I get the notification from the HID layer.
>
> I even did an s/{bt}_debug/{bt}_info/g over all the files in the commit, and when
> that mouse is power-cycled it doesn't even make a peep in the logs- it's like it's
> not even being seen (vs. several lines when I use my ordinary mouse).
>
> What params should I use for "btmon" so I can send you the output?

Try something like:

sudo btmon -t

Also restart the daemon just in case and then do:

bluetoothctl> power on

> > If the adapter doesn't work this might be related to firmware loading
>
> Turns out this was a red herring; I always have the adapter.
>
> > anymore the LL privacy feature is not
> > enabled by default so I wonder if you had it enabled in userspace?
>
> Where would I go to check that?

It is enabled via main.conf, if you have not modified that shouldn't be enabled.

>         -Kenny
>
> --
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA



-- 
Luiz Augusto von Dentz
