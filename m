Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D3EC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 01:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7387610CB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 01:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhIBBfK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Sep 2021 21:35:10 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:56866 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhIBBfJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Sep 2021 21:35:09 -0400
Received: by mail-il1-f197.google.com with SMTP id v9-20020a92c6c9000000b00226d10082a6so96942ilm.23
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Sep 2021 18:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eCBaAjhiQ9w8mLGGTf4y2S5ooafVmimcQTh9DS+sy1I=;
        b=D8zGeURs9HABFZhBnvZoO08pDg2SUgSI+BEbyBRW/2/78pnnuTCOjVY0pUVI+FPbFS
         +pjJuUOl7U3t4kZ6xJbJm9qTiRsOGQ4k5oAtk+96qqWrKnzKcJmkE9vZNdHmzLEzRFt6
         sDPXM9M5Wv59jxPBkaQIAR8jm6X5fGnTaQ/OUbW+c/M1OiPhsc/QBE+y+VHtvIw02JaQ
         V0sbnsKfCRZO3Eg5gdc2XDWXx3UpKlFN+lIJqSihocNntOWziEOs4aH0bt/EL8lC4wCG
         /YaTYGcsfXzgVIkVEi5kHcheQbSwjfGj1QgtgpIHWeps4Ms71dVer1GGLkrt9fgimlsU
         S8xQ==
X-Gm-Message-State: AOAM5321TCkUKGg9OALvCtdJ/1TapbnLbaXCUeB0RsQD+BCtt+GTtNZc
        iXMQn2+y0Hn0RQkxfquck1WMQeubYK5A1na43U6z1Hz0sFd+
X-Google-Smtp-Source: ABdhPJy7YbQOhifggTgvwQ1ZQFRbtvh13nQVZvAK1NEPE5pzyvQ0i+/WLbSyJhTpVilAxNa9Vy7XmtqTqrokDGUVsBCjNxA6Uq17
MIME-Version: 1.0
X-Received: by 2002:a5e:d60e:: with SMTP id w14mr638638iom.135.1630546451511;
 Wed, 01 Sep 2021 18:34:11 -0700 (PDT)
Date:   Wed, 01 Sep 2021 18:34:11 -0700
In-Reply-To: <000000000000b1c39505c99bd67c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000840d605caf92e8e@google.com>
Subject: Re: [syzbot] INFO: task can't die in __lock_sock
From:   syzbot <syzbot+7d51f807c81b190a127d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, desmondcheongzx@gmail.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit b7ce436a5d798bc59e71797952566608a4b4626b
Author: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Date:   Tue Aug 10 04:14:09 2021 +0000

    Bluetooth: switch to lock_sock in RFCOMM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f90ffe300000
start commit:   29ce8f970107 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15f90ffe300000
console output: https://syzkaller.appspot.com/x/log.txt?x=11f90ffe300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f9d4c9ff8c5ae7
dashboard link: https://syzkaller.appspot.com/bug?extid=7d51f807c81b190a127d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1630a66d300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d07c6d300000

Reported-by: syzbot+7d51f807c81b190a127d@syzkaller.appspotmail.com
Fixes: b7ce436a5d79 ("Bluetooth: switch to lock_sock in RFCOMM")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
