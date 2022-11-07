Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C49C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Nov 2022 21:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiKGVhz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiKGVhx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Nov 2022 16:37:53 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23775C21
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Nov 2022 13:37:53 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so14238557fac.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Nov 2022 13:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HejFlgHKmBGzk/mBIA87qRdy5PTiC31t5RYdgGHwS3o=;
        b=URdwkQQSLaYC2sgfRKTqDreHSK8nJLdGMGWE0eDM2e9LRCZqOQTSmI3XUalNFetIMN
         Blb67oK8zArpvcRPOgjEfbDXNdwWOsufnevc8c63x9kf8tKjYs9+IPL5/1s1sFlmKPLy
         l/kmuaT3yD3qmP2wNlYQaR5lEF3ATv1uPqC6deWIpSzyitSlp6d5ZtRl9FRWMghVBvLZ
         06rUqpoBTBbfu9fqypvJ/EEU2gbF9aV2IS0dHU1szUFmzcicldoCJB8vJst3pl1N+gyh
         tHTbanceg1gWZp6BJIiNqcQlehXm9/baD2yxqmeUcaCfFTTRWqq0ghHOkqC5xo7D2Tkl
         KJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HejFlgHKmBGzk/mBIA87qRdy5PTiC31t5RYdgGHwS3o=;
        b=5QXUyyHQV8BWDXttJ1E71AnHGfBHw4O5QjrA+XN6ifr8hJ5QBSOslN6H6CIuMgf5RU
         pS/6BtV3NfZxcs+O+6vGxS5ywVBg48nI1Fj1a5Havp3uQxCavx8s3LUP+Es9gx3TGoJD
         G1kPan2E/A0K8/McucH4NmcAAri7RV+jS8YRJUxzGyHx/oKTQ2ptIhjjFLMgathBr4og
         9oxEV3opW6zYuci+YSLJUk6UeutpV8Bce7Y65HKOs3wIcwZP54uO2VBZOiabX1pi5g+F
         tC9MPzYJ/bO0Efr+Aq2IUHh24qxEpdh1/bFjxkjvyQZfWRfquCk7zK311D3bQLrx9FRo
         Kh6Q==
X-Gm-Message-State: ACrzQf0wmSH1enDoMGXLlEqSn0cgfjA8B3pj9OhP2Oy0FkLg/dipuwHX
        cWRQ3BWK8DgoQfRzwt6S588LxvWAZR0Z/+TU5McUwg==
X-Google-Smtp-Source: AMsMyM48Ih0bnW2g8idkWTbJkUt3h7FZUwC1tdVNW6cLBRe9greBUQjyL5Oe+czHcLkK/F8jVcpFTbHM3Z/X62aTzgM=
X-Received: by 2002:a05:6870:b6a3:b0:13b:f4f1:7dec with SMTP id
 cy35-20020a056870b6a300b0013bf4f17decmr31266166oab.282.1667857072240; Mon, 07
 Nov 2022 13:37:52 -0800 (PST)
MIME-Version: 1.0
References: <0000000000000bab2c05e95a81a3@google.com> <000000000000946f3005eca8cafe@google.com>
 <CACT4Y+bX40TE_rx0SFnixoQVd_vHuGih9mtJA4TB7-dDOeguew@mail.gmail.com> <CABBYNZKyjFE_oVFDMj-U9uSax79bMimUCi1JyGBmyR_ufCNAUw@mail.gmail.com>
In-Reply-To: <CABBYNZKyjFE_oVFDMj-U9uSax79bMimUCi1JyGBmyR_ufCNAUw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Nov 2022 13:37:40 -0800
Message-ID: <CACT4Y+a0ma3NRFFLTEHMOH_6Y6DqNet5sz6m6HQwVe8sTv2EQA@mail.gmail.com>
Subject: Re: [syzbot] BUG: corrupted list in hci_conn_add_sysfs
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     syzbot <syzbot+b30ccad4684cce846cef@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com,
        gregkh@linuxfoundation.org, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com,
        yin31149@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, 6 Nov 2022 at 22:39, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Sun, Nov 6, 2022 at 3:25 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Fri, 4 Nov 2022 at 10:56, syzbot
> > <syzbot+b30ccad4684cce846cef@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot suspects this issue was fixed by commit:
> > >
> > > commit 448a496f760664d3e2e79466aa1787e6abc922b5
> > > Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > Date:   Mon Sep 19 17:56:59 2022 +0000
> > >
> > >     Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1052f8fe880000
> > > start commit:   dc164f4fb00a Merge tag 'for-linus-6.0-rc7' of git://git.ke..
> > > git tree:       upstream
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=b30ccad4684cce846cef
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1110db8c880000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e58aef080000
> > >
> > > If the result looks correct, please mark the issue as fixed by replying with:
> > >
> > > #syz fix: Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times
> > >
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >
> >
> > Looks reasonable based on subsystem and the patch:
> >
> > #syz fix: Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times
>
> Looks like I did add a different link when fixing it:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=448a496f760664d3e2e79466aa1787e6abc922b5
>
> Or perhaps they are duplicated?
>
> https://syzkaller.appspot.com/bug?id=da3246e2d33afdb92d66bc166a0934c5b146404a
> https://syzkaller.appspot.com/bug?extid=b30ccad4684cce846cef


Yes, most likely differently looking crashes, but the same root cause.
It happens.
