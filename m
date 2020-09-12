Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA260C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 12:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828772078B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 12:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgILM7O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 08:59:14 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:50927 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgILM7I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 08:59:08 -0400
Received: by mail-il1-f207.google.com with SMTP id u20so4149ilk.17
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2020 05:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WYtWFHRSU717tB4AOlbQFrWP5bISa+QXam+Bz0rRjMY=;
        b=aZH8/ab7fD3sJXV6ii1HCnGN1d3RUBPVLx/ezjHJMUr09RAZ6jkzIwAy0JFMLpXVL4
         Yu2lY/sCHQ5n7wlAzorEhaPT/qp715jRz8s2T1cg7wN3XMYrwZ2n/rZOqKOWvZc5t8K9
         GEqh26BaClwy+AjLZYoCdRUTEyKlyMKxRnVXNfsq1oLubBrJA4qNT/8JPPhlWsvWaqTX
         37O4wUTcXjS0zkxqx72LbmrVESUD8RFk1d7pA7nK0wjt6ylU6BHhjTrbyhg212ORrNQ+
         ae32zR3L5jUKcVleapHouSBHJlfGgYhcQf3jZ7Ao9TzqOT0DybrceNzC6yMoTyMpZAGs
         W0Sw==
X-Gm-Message-State: AOAM533IeCfYU3ZFnDw8Ep8CuQX3FjFfllThnfn6vV+1CYmnDB8aqBbr
        nEzMKL6W2XLaqB64OeW4VrNBIxeBI+JDemBG9f5ToHTRoX6/
X-Google-Smtp-Source: ABdhPJwLcoK9/BOVvUqW1qoKASa59qg2Z8rU3mVu/ovDZnFvptvji8E0w4KbtYZRK0MK1BCQIgrBtsl0DqKZRNCFZ2x3MA/XMcfx
MIME-Version: 1.0
X-Received: by 2002:a5d:995a:: with SMTP id v26mr5175295ios.176.1599915547769;
 Sat, 12 Sep 2020 05:59:07 -0700 (PDT)
Date:   Sat, 12 Sep 2020 05:59:07 -0700
In-Reply-To: <0000000000004991e705ac9d1a83@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5419905af1d5d2b@google.com>
Subject: Re: inconsistent lock state in sco_conn_del
From:   syzbot <syzbot+65684128cd7c35bc66a1@syzkaller.appspotmail.com>
To:     cgroups@vger.kernel.org, davem@davemloft.net, hannes@cmpxchg.org,
        johan.hedberg@gmail.com, keescook@chromium.org, kennyyu@fb.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        luto@amacapital.net, marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org, wad@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit 135b8b37bd91cc82f83e98fca109b80375f5317e
Author: Kenny Yu <kennyyu@fb.com>
Date:   Tue Jun 21 18:04:36 2016 +0000

    cgroup: Add pids controller event when fork fails because of pid limit

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f6d80d900000
start commit:   e8878ab8 Merge tag 'spi-fix-v5.9-rc4' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11f6d80d900000
console output: https://syzkaller.appspot.com/x/log.txt?x=16f6d80d900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c61610091f4ca8c4
dashboard link: https://syzkaller.appspot.com/bug?extid=65684128cd7c35bc66a1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121ef0fd900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c3a853900000

Reported-by: syzbot+65684128cd7c35bc66a1@syzkaller.appspotmail.com
Fixes: 135b8b37bd91 ("cgroup: Add pids controller event when fork fails because of pid limit")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
