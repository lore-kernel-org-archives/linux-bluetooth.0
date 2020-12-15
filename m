Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56164C2BB9A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 22:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F4A22CB9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 22:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgLOWG7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 17:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbgLOWGu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 17:06:50 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D6FC0617A7
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 14:06:05 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id j20so16486960otq.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 14:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vpE/U6W6Ov9WDAaDCr6xUzDdZ5ooNc15QQU94LXJL1Y=;
        b=aBzHddLiFo4UezpF71hgxxw6DGpmO+dk/4xT7qy0SpMLxM0tFFV5ZbeZHq43LGhyrN
         yoW2Ko+kD+EO6aZKGRhPEk2Ds+do/mRIxuC+jgOj2nvUAyIWs/Qyd3N7J4q7bRAa9dyv
         wHJhpH9hg/TukaFyeA9XUqGjQ6cZIqPM5V+xZuSrYIu67YEpRwnAAiZzhYSgLgbz6225
         g6f//WWvQzV+M1+Sh1gdugt27/UJMBUyz9w4F6bzmLQPnXW8agX36F9dIloiUD7svd6v
         1qM/ErvCTFZwzctMbwFDjgr+vOZ1nhcdPbfxXVBbN0inYgXtzlgyxYGBNHFMmgKnzzIr
         uW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpE/U6W6Ov9WDAaDCr6xUzDdZ5ooNc15QQU94LXJL1Y=;
        b=rNW6peNGENBkGrK7UVtyPa3nTc6VD4ldW5ehLj++R2gRPlBGNwBQB1OZ50YxCWnJzZ
         d/SqDYqiS6SE3Juj/OQ4/j+QLOCNwEb1XUxGGyyJfYNRQqExGwfQhocEeSbZHQKqQ7ww
         wcIs5ZbCA5M1XVhrCghHoFVpMhco961kK2J1I9yQyAiqhfeCskptYRDFc1wQB31KwmHi
         g4kCgg/Z2PJL/3j4360qoQ0+aKx/FQ5H2H15bjgMC/L5zsKQVq49/5VYlbgnPxYmSvfK
         w2/0kW1EYDX3t06laNBimh09FeAaoMoILrxbxTRPfeLWQrOFcZylXum6HNUN0CjsPF5H
         AlEQ==
X-Gm-Message-State: AOAM532Nk8S9T5dGFDFUkgDyaWfcnB2LkvZnkvfHsK80wbfoWOUTZM8X
        9aPJvGTU9chMoAHP5gaDZJ8Dc9a20Y4mQo8WLeE=
X-Google-Smtp-Source: ABdhPJwhqmr/zykVj06nYyd+AiqYHZPamOh1pBeoO64QKAvBXgJNF46ZMabXaLVqbrSv7CUV1w3ZRT3oqMlli0uw9Yo=
X-Received: by 2002:a05:6830:1319:: with SMTP id p25mr25170223otq.240.1608069965119;
 Tue, 15 Dec 2020 14:06:05 -0800 (PST)
MIME-Version: 1.0
References: <22bd6446-d293-c5d7-14b7-9db9fa0727f6@gmail.com>
 <CABBYNZ+yi2kX0P8c8u4ZpZNcuy=vRMHqEfsirPd-+EVdbqxnuw@mail.gmail.com> <ea82ca14-2738-cf9d-070a-7934be6fc1ab@gmail.com>
In-Reply-To: <ea82ca14-2738-cf9d-070a-7934be6fc1ab@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Dec 2020 14:05:54 -0800
Message-ID: <CABBYNZLqODeZNxBAsNMC9dbwAxok00-Y7LeXMpzDF1B1S57kxg@mail.gmail.com>
Subject: Re: BLE Midi problem with mixed 16/128Bit UUIDs in characteristics
To:     Johannes Deisenhofer <jo.deisenhofer@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johannes,

On Tue, Dec 15, 2020 at 11:58 AM Johannes Deisenhofer
<jo.deisenhofer@gmail.com> wrote:
>
> On 12/15/20 6:51 PM, Luiz Augusto von Dentz wrote:
> > Hi Johannes,
> >
>
> Hi,
>
> >
> > The spec doesn't allow mixing values of different sizes, or does it
> > first return the 16 bits one and then later 3 are return in a
> > different response?
> >
>
> No, all in one response (which is re-assembled from two HCI packets).
>
> My working device (DIY, arduino, but probably based on nordic semi code)
> does the right thing:
> It returns all handles with 16 bit, the client requests a continuation,
> which results in the MIDI I/O characteristic, 128Bit, in another response.
>
> [ cut ]
>
> >
> > Well if the device is returning mixed UUID sizes then there is nothing
> > we can do to figure out since as you said there is only one len so all
> > elements should be of the same length, perhaps Android doesn't use
> > Read By Type procedure and discover them, anyway it is perhaps worth
> > notifying them about this problem given that it doesn't seem to
> > conform to the spec.
> >
>
> Thanks for clarifying. So quite obvious a bug in their (Roland's)
> implementation. I hope they care enough.
> I contacted them through their customer support forum, but I don't have
> much hope getting by the first-level support there.
> If anybody has a better contact...
>
> In this case, it would help to fetch the characteristics service by
> service instead of all in one. All characteristic UUIDs for the MIDI
> service are 128bit, the rest is all 16 bit. Could be the reason it works
> with Windows, Android, OSX, and whatever else they test with.

Yep, it is quite possible others OSes don't take advantage of big
UUIDs like we do since we can discover more than one service at time
that speeds up the discovery procedure quite a lot depending on MTU
size.

>  From my limited understandig, that could probably be changed, but needs
> to be done in the general code, slowing everybodys pairing time down. A
> non-starter, I guess, for a single buggy device.
>
> So I'll keep a fork with my super-ugly workaround and hope for roland.
> I have to rebuild bluez anyway because my distro does not use
> --enable-midi.

We should at least attempt to validate the response since it appears
we don't detect there is more data than expected but if the total
length is actually a multiple of the elements len it would still
create invalid attributes in the database. Anyway I would reach to the
manufacturer since they are clearly not following the Bluetooth Core
spec to the letter here.

> Thanks!
> Jo
> --
> Johannes Deisenhofer



-- 
Luiz Augusto von Dentz
