Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC5FC433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 06:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33B2613DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 06:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhENGeR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 02:34:17 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:52913 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhENGeQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 02:34:16 -0400
Received: by mail-io1-f71.google.com with SMTP id o6-20020a05660213c6b0290438e33a3335so14120815iov.19
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 23:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Tfm3BDGQJB3swh4qZdQjbFt+R0jWQ2xc2bAdJPlLjMk=;
        b=QPht444Akcc/YmrP98gctdYw6Igm7fNBcXyc7N4OlX5JF42kGR4d9sbSePuYlIpuWA
         MxhFhqRs4XaJqUru+95sa0ZY73Mzlut91GS77p6vDwQApOO5AufBIKxgJFN2+H3nUOPG
         X0k6ROWyOp/yl7la8YpRcbWa+D2xh4I8Qx/thMVh8aSHgIn6Kvms+4O5IWe2fL2niD9j
         yXolXe0SQcrFwrTiI3EmmD2P4NIJujOP4ADXgJSuh2MWj0O9DYaNeo8JWdBrIjeqVfPj
         Y16NrqAJEnVDlSxc/pEHV0C3XsCbT3X8G7qZZGC+x7q07f5ZYwaPfbtJF4LWXlF5E9oH
         2juA==
X-Gm-Message-State: AOAM533KA/dU7QNimki/X2I585xhv1oL2b9hxs9ATFJE5LRR0PyqE83d
        wGcv5m9pplPptCbHJAhu8MYfaYfOnHjhrCoiPLX/o3P+hjWh
X-Google-Smtp-Source: ABdhPJwtXPYhtcMcSW3eVJps1uhikmfwJvy+InnSNpH3TKxsBRU8SeJ8XdCnVu/PmmWUKSvnqzaA1P4MeP/HtRV2Vie9XP3mEYHP
MIME-Version: 1.0
X-Received: by 2002:a05:6602:158a:: with SMTP id e10mr33338426iow.137.1620973985495;
 Thu, 13 May 2021 23:33:05 -0700 (PDT)
Date:   Thu, 13 May 2021 23:33:05 -0700
In-Reply-To: <0000000000001d48cd05abebd088@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000987c8205c2446ac9@google.com>
Subject: Re: [syzbot] WARNING: ODEBUG bug in bt_host_release
From:   syzbot <syzbot+0ce8a29c6c6469b16632@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org,
        johan.hedberg@gmail.com, kuba@kernel.org, linma@zju.edu.cn,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, syzscope@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit e2cb6b891ad2b8caa9131e3be70f45243df82a80
Author: Lin Ma <linma@zju.edu.cn>
Date:   Mon Apr 12 11:17:57 2021 +0000

    bluetooth: eliminate the potential race condition when removing the HCI controller

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15427145d00000
start commit:   f873db9a Merge tag 'io_uring-5.9-2020-08-21' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb68b9e8a8cc842f
dashboard link: https://syzkaller.appspot.com/bug?extid=0ce8a29c6c6469b16632
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10310972900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bluetooth: eliminate the potential race condition when removing the HCI controller

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
