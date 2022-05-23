Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8347C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 May 2022 03:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354985AbiEWD4m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 May 2022 23:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiEWD4k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 May 2022 23:56:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2582B7
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 May 2022 20:56:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id m20so26014476ejj.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 May 2022 20:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKAJkiWmW+IPGP1bXDKaiFUYpV46xzegx9oR3356eFs=;
        b=gVnl8EntcpMgwE29/c+bjMIurGfrhaKvHuVgNwokXlHj8f0HpRtVO2iTuf2t84JtcC
         4T8IWNKbLcn4nS8C8o54KCWd2cK+9MGM+jMuIbj4JCyR7HUtw+Hfe5LSZl4Mo/IfVzMY
         D4Ai8Dmf6YrLPSwpNE0xjpX1Lrp517SuOajXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKAJkiWmW+IPGP1bXDKaiFUYpV46xzegx9oR3356eFs=;
        b=LzPndYjwDT+9Zr8266mYKqKSAi/3H4pg4zLISGuePxbncKGlqFZNYReXNhKxXlckWu
         UROwLYvEqBpTUvxqAD/Cs6LTJ24OcD5lZ+AHirWWZ5SkUOVkDjMTXDLKVPGnN+OzlS+c
         D8t+BtaQPfO7BSFk0BPeoaeAY1AqWuOkVPUwtgneSF2ivtxt0Q+Nrun7Vzn48plNZ01x
         hw9uKT0HsAMH2DfLMEMjwD2PNEWDg56pCM9eYED86dMd3wOeDNcPLbYnhmrYSyNTGSm2
         JN/UnBQj6b3tDT1kvIG6ZTezKtUkYWW09fWAgSfyASkrGK4DN9saDTeJlvBY7pzUNAPC
         iq1Q==
X-Gm-Message-State: AOAM5313RfAxmrSHRQXQcGlcZew+b1Q1FOqYUSSHXfff4ajtJnPu0z6K
        PCv8y6vU+q+MfsZBJK9uE5t98o/pOq5H559B
X-Google-Smtp-Source: ABdhPJzHkjDfebGhwhicZmxaFcluC5BkpqrmQzdSWQ5rL5p7kayGfKz3R34MPZ0bl8iKman0jZZ8qQ==
X-Received: by 2002:a17:907:971e:b0:6fe:b652:7d51 with SMTP id jg30-20020a170907971e00b006feb6527d51mr10582101ejc.356.1653278196611;
        Sun, 22 May 2022 20:56:36 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id z7-20020a05640235c700b0042b0fcfe966sm4916637edc.37.2022.05.22.20.56.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 20:56:35 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id p10so827712wrg.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 May 2022 20:56:35 -0700 (PDT)
X-Received: by 2002:a5d:5484:0:b0:20f:bf64:cae1 with SMTP id
 h4-20020a5d5484000000b0020fbf64cae1mr10390593wrv.281.1653278194596; Sun, 22
 May 2022 20:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c1925305ac997812@google.com> <000000000000b6b4eb05dfa1b325@google.com>
In-Reply-To: <000000000000b6b4eb05dfa1b325@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 May 2022 20:56:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whH5pmgyzE6+6C==p2VQFUgGiPhSwX=R2zKs+iHZuX7_A@mail.gmail.com>
Message-ID: <CAHk-=whH5pmgyzE6+6C==p2VQFUgGiPhSwX=R2zKs+iHZuX7_A@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in corrupted (4)
To:     syzbot <syzbot+48135e34de22e3a82c99@syzkaller.appspotmail.com>
Cc:     applications@thinkbigglobal.in, David Miller <davem@davemloft.net>,
        gustavo@padovan.org, Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Marek <mmarek@suse.com>,
        Netdev <netdev@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, May 22, 2022 at 4:01 PM syzbot
<syzbot+48135e34de22e3a82c99@syzkaller.appspotmail.com> wrote:
>
> The issue was bisected to:
>
> commit c470abd4fde40ea6a0846a2beab642a578c0b8cd
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Feb 19 22:34:00 2017 +0000
>
>     Linux 4.10

Heh. That looks very unlikely, so the bisection seems to sadly have
failed at some point.

At least one of the KASAN reports (that "final oops") does look very
much like the bug fixed by commit 1bff51ea59a9 ("Bluetooth: fix
use-after-free error in lock_sock_nested()"), so this may already be
fixed, but who knows...

But that "update Makefile to 4.10" is not the cause...

               Linus
