Return-Path: <SRS0=p+wm=66=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2553BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 May 2020 21:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD1D207BB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 May 2020 21:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgEPV1G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 16 May 2020 17:27:06 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:49781 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgEPV1F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 16 May 2020 17:27:05 -0400
Received: by mail-il1-f198.google.com with SMTP id y12so2466948ilg.16
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2020 14:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=f3hko+0TXM3ZTxTzVXQjaXqhvt2WnzZbWWNxH4vk64g=;
        b=DX4iwyqn6/Pkw53ova5zK81V6gq9WEP+rMNWduYa75mkV9Si0F+qyYyHjQFKdJtUsR
         5BXfn4gFOqkYY7Zw/V4waDoNIsehEPZI0sEXUrgDkZ3aHp0tH5g+w5vDsjhJ0+5/BFTb
         XyNLOWWHSL2FGDGfxogBL0S2KpzoZaVzszBzHeWqtfJwCH7vT453FlN6r+wdwaNoZ++2
         6usvbWBs5Wwu3DfXQ4Rie7/Ra+SivEzdmHBl6vWtftGTQ3CQRAcQYkkBiBYShqDV4QIl
         B8920s46zyBF7TT7IKjzcnSnwQ7JHPZs5bC4Rl89H+n411dM3Qj+O6zRbc6rA3lkOESy
         JAqw==
X-Gm-Message-State: AOAM530divQ048YCaaRkjSkNxlLVHzCx5LSUd/PNeT3pGSqXozXL9jp8
        wI+gAhyUXFJK/C2CgArx5sjyv1QA/WqfLtFgRHZ/+xb7RSUw
X-Google-Smtp-Source: ABdhPJz0cH5oPpV8Crm3N4eRME8yr4YUcg2zWCEKfV1oaXJx6vivQpTeE+zffP6GmIpSFnRS9D7COeZSShOVJTZOtPesbiPzsDog
MIME-Version: 1.0
X-Received: by 2002:a02:860e:: with SMTP id e14mr1019310jai.109.1589664423356;
 Sat, 16 May 2020 14:27:03 -0700 (PDT)
Date:   Sat, 16 May 2020 14:27:03 -0700
In-Reply-To: <0000000000003692760578e651dd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044329005a5ca97eb@google.com>
Subject: Re: KASAN: use-after-free Write in hci_sock_release
From:   syzbot <syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, davem@davemloft.net, dvyukov@google.com,
        jack@suse.cz, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org, mmarek@suse.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit f1e67e355c2aafeddf1eac31335709236996d2fe
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Mon Nov 18 13:28:24 2019 +0000

    fs/buffer: Make BH_Uptodate_Lock bit_spin_lock a regular spinlock_t

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1761ce06100000
start commit:   645ff1e8 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7308e68273924137
dashboard link: https://syzkaller.appspot.com/bug?extid=b364ed862aa07c74bc62
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152532bb400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f73320c00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: fs/buffer: Make BH_Uptodate_Lock bit_spin_lock a regular spinlock_t

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
