Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BEAC2BB40
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 11:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 171C6238E3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 11:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgLQLIA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Dec 2020 06:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgLQLH7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Dec 2020 06:07:59 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C84C06138C
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 03:07:18 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id u21so19751971qtw.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 03:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WpyJG39zsZR3QTEsxdeIZ6It7enzbMRWstsw8rPRonw=;
        b=rFasmzLx8XfOzm6Y+FxLK6NecNAgN+nus0rsYJrLuW+hpzBD/G6Aut+1epJgd3Q9Y3
         rI4U+FdwwtB+ydXf1iKiX2YBDEoIPOXfOjoxwDsLlRC+VSAaSRks/dwUdbna9h704pS/
         d2A8hO4XsNEFJP5gOafW/aGB3cdf1Rucz2BtuT7meDa5VftF2vj6TKqvm/XuqnJdLo2v
         rJfj5QslNlV2FdjWijrHD1hpkaEMpURVzu25lOoF97RlseM6vDkoBhuHL0zQ2qg3FJ/4
         rLfN4/8uFirSkdP/MspVGyDZ3L7GXufno7ZA4RNMUzeNVlOatGeiFxvigK+pXnDBpG47
         sfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpyJG39zsZR3QTEsxdeIZ6It7enzbMRWstsw8rPRonw=;
        b=CGvbFNWOSHnqofLjAdTbpopGVviAour495Xs7rorsvm0fYQKQR1qbf5t1nK8Z834uA
         BJ9RS2iu828WsMLDXVmwCOExZ+kmg0OURGXJJCVWen5scF6AUWtriX7l+HUSAMcUjPQA
         Zoap0bfE2rfPFNAYKSxswj4DyumHyJDdSr9/1n4mNEb/q9hnTR+eftAZd3XysYuDgjtz
         sGqchlwAu9uFo9ZSIpldgcRTDFRR+RQUr3UdWbuM7zOkiU46VFll0kYiFiGAsD7Zh3+A
         f7Ef2H8Rv4yHpm6AlmLNuBz5I6XU9xYXCbAxCOv+DW/svac8JYL4UCmXfqUDCKyNc+xz
         bSdQ==
X-Gm-Message-State: AOAM533pBCPRVXHMbTA8t6dl3CV//jEnjGwylvev1HMEJTUYG+To2Evm
        3UWoYbIl4Gr/bT7gAPv3dQVjNcD/rJhX4uexCb8vGQ==
X-Google-Smtp-Source: ABdhPJwsy+Mk6kAd77qSP1iHQ1KvXJLnVTRVxCZaOziunZ7175tYz6+6XvAtQVR72glNqSkBWHZ8KadI0C3bjv0widA=
X-Received: by 2002:ac8:5ac3:: with SMTP id d3mr47345365qtd.66.1608203237853;
 Thu, 17 Dec 2020 03:07:17 -0800 (PST)
MIME-Version: 1.0
References: <000000000000ab11c505abeb19f5@google.com> <0000000000004ea4fe05b68fa299@google.com>
In-Reply-To: <0000000000004ea4fe05b68fa299@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 17 Dec 2020 12:07:06 +0100
Message-ID: <CACT4Y+ZyAD1aJtTt0q1E=AmsTwnapjitit82+o-Gn2NyxDZNgQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in __sco_sock_close
To:     syzbot <syzbot+077eca30d3cb7c02b273@syzkaller.appspotmail.com>
Cc:     anmol.karan123@gmail.com, coreteam@netfilter.org,
        David Miller <davem@davemloft.net>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Fox Chen <foxhlchen@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Patrick McHardy <kaber@trash.net>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        mchehab@s-opensource.com, netdev <netdev@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Dec 16, 2020 at 8:15 AM syzbot
<syzbot+077eca30d3cb7c02b273@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 6dfccd13db2ff2b709ef60a50163925d477549aa
> Author: Anmol Karn <anmol.karan123@gmail.com>
> Date:   Wed Sep 30 14:18:13 2020 +0000
>
>     Bluetooth: Fix null pointer dereference in hci_event_packet()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14cb845b500000
> start commit:   47ec5303 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c783f658542f35
> dashboard link: https://syzkaller.appspot.com/bug?extid=077eca30d3cb7c02b273
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165a89dc900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130a8c62900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: Bluetooth: Fix null pointer dereference in hci_event_packet()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: Bluetooth: Fix null pointer dereference in hci_event_packet()
