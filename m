Return-Path: <SRS0=QJP1=RU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A02BC43381
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Mar 2019 20:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658CD217F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Mar 2019 20:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552855282;
	bh=64YO2k1ILxmBV1ysSiRPzA847cIs5p+6I7oU1yJDEyA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LstTcppYl9n1SZRrwLW6NC/6Uph/6ulCZb97A8RueC4EjMkeJ+4/uf54gHRKI/i10
	 ppehrao43EOp5dwF8vimqUNc2j/GayfVWO6yRHsDimWnL3hAhkAi80Bj/IRWL01KRZ
	 UDyspyfNSZ2YqVvA+E5nQrrAPkIzWUOB4DcuK1eI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfCQUlV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:41:21 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:34964 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQUlV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Mar 2019 16:41:21 -0400
Received: by mail-lf1-f53.google.com with SMTP id u21so267469lfu.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2019 13:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PO3jNqZCfjilE8Yx097aTy6Y8RYNf8t+1W3KEZZVyYE=;
        b=e7zUY0UpSQxwGKLa4sa5QMjSPAD3/r1emUajPMXKEKjI4NMMqd7Zc08L/0bifzLXn+
         EnZssEos21WcIgfluUwJWlaUn6gtjqT2/QWcqQnSLm5V679pP9MyaAWylI2ImDot0enm
         hSCmICIbaPLnKz8+Qz5gLWzTviTJXqlqd/Das=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PO3jNqZCfjilE8Yx097aTy6Y8RYNf8t+1W3KEZZVyYE=;
        b=ixZiaA8e/8Dho//sbWXy9lT4BBjfY+zhHI51/rRf4hVOs/FGgreIwjhycPPmA1aE1p
         ldBDDjCQ5+tsrRzq3yXuOvTtHaWpZPI3bneDi319lnGBYvwt0KiXSVne1dwRS4uG0KXn
         7Gmw7Idq3b3XK4Hx4ncYctzmdzbfyIC1qkJ0sclagU+nguRoR9P28dHMbU42oobFRTUO
         rOmWYER+oPZjMiCigyABuvuss77zCQHAp/Vo2I+9I/gLkGE7krB8tz15INbZwDRUG/Ba
         WKESaa48PU9mkKpk3eu6U+BnOYO3hYXcKzUxYK4rvVaZONt39u7RfAc6e2ay01krRfUw
         awSA==
X-Gm-Message-State: APjAAAXdxwQ75QZ4s9L/TNdKV1w3xgAGQgydeYOrRpN0nMp9fKsT0+iR
        ui8Y8swIC68ty0/+4Iq8B4c8cX8IjVc=
X-Google-Smtp-Source: APXvYqxCUe4D3ST13rPxrZAEoCSEkSZ0S0ASofM9+J5QNr2oCbj8XYRWl5BZfWq5frmZgo8k0fTTqg==
X-Received: by 2002:a19:40cc:: with SMTP id n195mr8207735lfa.150.1552855278747;
        Sun, 17 Mar 2019 13:41:18 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id q2sm929105lfj.58.2019.03.17.13.41.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 13:41:17 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id u21so267436lfu.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2019 13:41:17 -0700 (PDT)
X-Received: by 2002:ac2:4203:: with SMTP id y3mr7709582lfh.11.1552855277033;
 Sun, 17 Mar 2019 13:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008a1bce057ede3d13@google.com> <0000000000009950e1058447ef43@google.com>
 <CAHk-=wjUrznUSUKN1AXQA9kCStQ3MHFY95ZmeTZ5zYDcvMhBiQ@mail.gmail.com> <CACT4Y+YOWaU8s90joeGB4G1oc-GxrQSDnjpuFOuE4eJd5FHK3g@mail.gmail.com>
In-Reply-To: <CACT4Y+YOWaU8s90joeGB4G1oc-GxrQSDnjpuFOuE4eJd5FHK3g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Mar 2019 13:41:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_+ObTogs75N++EigJ5RPpu8GL2ma0jasgJxG+t3oPPQ@mail.gmail.com>
Message-ID: <CAHk-=wj_+ObTogs75N++EigJ5RPpu8GL2ma0jasgJxG+t3oPPQ@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bacpy
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Michal Marek <mmarek@suse.com>,
        Netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, Mar 17, 2019 at 10:12 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Please see https://github.com/google/syzkaller/blob/master/docs/syzbot.md#bisection
> it should answer all of your questions. It does 2 and more.
> And in this case it seems to be working as intended bisecting it to a
> release tag.

No, it's definitely not working as intended.

You can see it in the bisect log - you don't actually have a single
"git bisect bad" outside of the initial one that you start bisecting
with. That's a pretty good sign of bisection being completely broken.
Yes, it can happen in theory, but in general with a good bisection,
you should see about as many "good" results as "bad".

I bet that what's going on is that your initial "let's test every
release" uses a _different_ process than the actual bisection itself
does.

So if I were you, I'd look at what syzbot does differently during
bisection vs what it does for that initial "test each release". For
example, does it do "make clean" in between each build in one case,
but not the other? Does it do "make oldconfig" vs a fixed config
generated from scratch every time? Because the fact that you first
tested 4.10 bad using the "test each release", and then when you do
bisection, the very commit *before* 4.10 is good (the only difference
being the EXTRAVERSION and the tag) shows that something went wrong.

                      Linus
