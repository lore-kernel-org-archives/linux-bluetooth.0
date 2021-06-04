Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18597C4743E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 21:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0EE6121D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 21:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFDVlH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Jun 2021 17:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhFDVlG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Jun 2021 17:41:06 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27D4C061766
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jun 2021 14:39:19 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id i6so1002223ybm.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jun 2021 14:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PeKeB3TvL1tWV4Q5VttMOtqa8ltLzI98QJmLmRexFto=;
        b=tc3jtofa1MFWrBhQPW0iEp8+eQpG8SUV/4MPWwuQGDVhqshLEshOzbwUG74c6irKBH
         ISIgXJx6YjoXK3Ee2TnoCFpFjqziHmdiwHsHsxfDH6e09NHNnMbE0rrFPgu7d0ooor/6
         21SAB+ceVVkGx7PtIQtG17p3XgIpQxWgvdlCN2Nh6Z4FL13dsT6OyWSp7fwymzM/vmIt
         69cfTpDb5Rc1M1SO3AePwlsthxsu4yoEpDYlps6vvofix8uVLx+F2DP0WKtGPwoqHOXg
         OsYiZOhe0Ldxl4HaWxof882yLN1fW/SNukl9SddpxVpzftv8C47THB5yVv4YuwkYRYWu
         X+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PeKeB3TvL1tWV4Q5VttMOtqa8ltLzI98QJmLmRexFto=;
        b=eDEfqfIGylc5Sj+Y/yVC3CGB+I1j9aIUD0T10kQJJem6nw2Q5dDb33M0gf1leilFaL
         FZ+fse9uw/Toe+505oXXn6ZbC9IEW9djzwGGtCxORxoVg9RLf4DuL/buxIW/rkKC4y8R
         HUiotK3FhHOLQm8nsgAkNOFXuRkiNiMyo+og6aFqYfmTkH3yc4Cp6DsZWNPdd9vR9Vwe
         u0/HY3G/agyDdOdgWMZAU3vHWxyaj+prQVcZYB8F0cUUh9iLegmmeNYjf26KIVx6lofg
         ulNXAb/eYV1nS2gKoELWnv7/ttjNbjRjTwlnXpOba+QdNpE8oNA3HROvSPPReabwGALI
         KfsA==
X-Gm-Message-State: AOAM531dEb0Qb51x2TGDW6/dEObGIQsUVM7V5CBMG9anx++ySQ8ZbxoQ
        uIblidz5qzTmM6FBgGN8bxRI7nBmi/T3/wbmNlZcwl6kLiE=
X-Google-Smtp-Source: ABdhPJyfqvX/ri6FRpOHP8jEWj6XY+WUi256utgnsZ0D81MyC6YqJue8w0MWHefPxgsDWaDYh4x+J7+xs7LRHyNSZt4=
X-Received: by 2002:a25:4048:: with SMTP id n69mr8269929yba.91.1622842758213;
 Fri, 04 Jun 2021 14:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <749228e2-4d49-83ef-06f0-2db0532beb93@systech.com>
In-Reply-To: <749228e2-4d49-83ef-06f0-2db0532beb93@systech.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 4 Jun 2021 14:39:07 -0700
Message-ID: <CABBYNZJeEV-4-fhGAwzqu0e+J3DN9Bm8pDk1s29myUdRF29jUQ@mail.gmail.com>
Subject: Re: Bluez Socket File Descriptor Leak
To:     jay@systech.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jay,

On Fri, Jun 4, 2021 at 12:14 PM Jay Foster <jay@systech.com> wrote:
>
> I am experiencing an odd problem with PAN networking.  I have PAN
> networking setup in NAP role.  Another machine makes a BNEP connection
> and performs network activity, then disconnects the BNEP connection.
> This repeats periodically.  This works just fine, except after a while,
> the BNEP connection fails with the following in the log.
>
> May  4 13:08:02 (none) daemon.debug bluetoothd[1373]:
> profiles/network/server.c:confirm_event() BNEP: incoming connect from
> B8:27:EB:E5:35:9B
> May  4 13:08:03 (none) daemon.err bluetoothd[1373]: Can't add bnep0 to
> the bridge br1: Too many open files(24)
>
> ls /proc/`pidof bluetoothd`/fd shows about 1000 open file descriptors
> (sockets mostly).  This looks like some kind of resource (file
> descriptor) leak.
>
> Has anyone experienced this before?  I don't know if it is in the
> bluetoothd application or one if the libraries (glib2, dbus) it links
> with.  Happens with bluez 5.19 and 5.52.

That looks like the fd are not released (via close) after they are
attached to the bridge, you could in theory increase the number of fd
a process can have in the meantime but we will need to fix this
problem at some point so please have a issue created in github:

https://github.com/bluez/bluez/

-- 
Luiz Augusto von Dentz
