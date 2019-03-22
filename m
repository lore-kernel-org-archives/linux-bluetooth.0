Return-Path: <SRS0=CqyX=RZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF3DC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 12:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10099218B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 12:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDKi5kGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390300AbfCVMQ6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:16:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35144 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390292AbfCVMQ5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Mar 2019 08:16:57 -0400
Received: by mail-it1-f194.google.com with SMTP id w15so2938534itc.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2019 05:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YW0V78Vu4h5rSxMfAZ1y6bOUKJxVXX904UGaBFUKQa8=;
        b=WDKi5kGgQoYwzYVeTQGYAfCluHUyqqkQr4L8XoBUwwRZ3Rg+07S302dhmtQ+U8cm7l
         T64sdCX78UXmCrajT2z1ppLdxsApxO4uxZBxOFTnwyWEw+tnwsKrJ2UhxFyXM4G+wPUw
         0UrCAaHqC/wLO1N8dvoxsuLcjUV3ClatF+q/UQGQFpLxhoSF1y3CPuartj6QbQ3yVGio
         eOFkathweuzmY2hzgwHobGIs1BFTiTcZaiHbO1J2wSsRaKjB5L6MwxiZ4lzY+sz/3MPW
         uwHa3CUIpQ4FmfXzen4U2NLHa/AcRR562jzCzurIy7A+KTL6C7w7HryfziZNyiMUPr5M
         mcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YW0V78Vu4h5rSxMfAZ1y6bOUKJxVXX904UGaBFUKQa8=;
        b=Z5nOKwlmQs7T/fqqIlWuxQ93IAzj93w/4g75LiUtA3knWCWewdelEItMnbvu3UleWG
         0tQpTK9YvhGPSUihgteQdCcJKuH+ovtXpwcFciF8QqzaGayQzq5sqlgW3EY8yDrwQTKo
         FLnY8KgOFDBRb2FlMUmsbMN5F4LUDsioYR8ztNVps/RqlM3a/6UZgUGJyYPxYfjpUrq/
         4W/ubZ/t1XN/hHpGiZUOk5z1KXHYDTpiCDiJamtaB26nJmBRAWCgKdh8+AUCAwutNDrY
         ULiIdtXzIyNcPiQCqLYhpGH7PWtIW3CB3lDi1fUwBd7fRM60CSJy4/IhDQpeZpvOaOB0
         Gsug==
X-Gm-Message-State: APjAAAWOaYNT3lox59sPGS4r74AV2FTMe0OGnN0I/mA5iP/D4qXhNcnX
        HVJQNpW3tQg55lJJNy/65WL0SLE8GnJjksI+4xtMrw==
X-Google-Smtp-Source: APXvYqxW+fbLoSgmqWDCRVDgW60p0UzonxKZfDmM1G9AzaUHotxUW5g5bfKL4XCdaufNXQCj6gvKPUNBytz7C3jvfbM=
X-Received: by 2002:a02:84ab:: with SMTP id f40mr6306106jai.72.1553257015828;
 Fri, 22 Mar 2019 05:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003692760578e651dd@google.com> <0000000000007917ff0584ada6e7@google.com>
In-Reply-To: <0000000000007917ff0584ada6e7@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 22 Mar 2019 13:16:44 +0100
Message-ID: <CACT4Y+b0Onk4AB0hkvhXgZPdk+rERFsYAQra681o6QLDH_Ct-g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in hci_sock_release
To:     syzbot <syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "open list:KERNEL BUILD + fi..." <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Michal Marek <mmarek@suse.com>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Mar 22, 2019 at 1:04 PM syzbot
<syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit c470abd4fde40ea6a0846a2beab642a578c0b8cd
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Feb 19 22:34:00 2017 +0000
>
>      Linux 4.10
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1664c6df200000
> start commit:   c470abd4 Linux 4.10
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7308e68273924137
> dashboard link: https://syzkaller.appspot.com/bug?extid=b364ed862aa07c74bc62
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152532bb400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f73320c00000
>
> Reported-by: syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com
> Fixes: c470abd4fde4 ("Linux 4.10")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

The same story of HCI being broken before v4.10, so this is bisected
to the release.
