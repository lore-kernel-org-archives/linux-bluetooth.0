Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7A9C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jan 2021 05:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F6D225AC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jan 2021 05:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbhAKFQr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jan 2021 00:16:47 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:36378 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbhAKFQr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jan 2021 00:16:47 -0500
Received: by mail-io1-f69.google.com with SMTP id y197so11748689iof.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Jan 2021 21:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TwLtYgNM/VxZnJX9RYzFOAmbDbu3TS829VUYdlrQ6tU=;
        b=dyAu3skCMnrRTGlVOYAorfn+I00DRMlAO1dsy5AqVEny1ei4G1HSbW5SpfN2U1b282
         6UTDeG3lv5EYgu/SsT2FJ2YHV+woMiZ1hL1G1xorgwmdaSCHUrJJssdRpCu5oGT4KvSs
         o2S++dGsotMQzPlh33EEEnZGo0jzVNN5FWFhp6RdTXf8Mwu7FccIo4emIZ4JV5J1+1ki
         /041gO3J2yRwgFaSSwpHmxRuRGUUTa5MofLd0OU3J8ifPAxHPojWgx+AjAjj4O492+GF
         SfCqvJiz/d632OK0mOPs9rC8/7CTz/o8RmQE7hSwA897txa+cFSnW5JkOILFwEnbRK1h
         UdpQ==
X-Gm-Message-State: AOAM532Nd0XcIwVy4rsbqBVLBjqXl5rgu6JjTNdmRQO2NmE5/FqO+Fmq
        y2U33Keb8D5v4+AHJ+CAne8aGGn8r0RXhy5624zfBFeyeDcc
X-Google-Smtp-Source: ABdhPJw34d6R73XmCxuksM9133DcvPyLfBOZgm6heuu0BEb6aKdNf+Jt1XOKWGljxWX0oVlLoshF5G4fzBYFc5U+6aYPAdyyumLW
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f86:: with SMTP id v6mr14014231ilo.56.1610342166413;
 Sun, 10 Jan 2021 21:16:06 -0800 (PST)
Date:   Sun, 10 Jan 2021 21:16:06 -0800
In-Reply-To: <000000000000f5964705b7d47d8c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbca0705b89900b3@google.com>
Subject: Re: INFO: trying to register non-static key in l2cap_sock_teardown_cb
From:   syzbot <syzbot+a41dfef1d2e04910eb2e@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, hdanton@sina.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org,
        mareklindner@neomailbox.ch, miklos@szeredi.hu, mszeredi@redhat.com,
        netdev@vger.kernel.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit 4680a7ee5db27772af40d83393fa0fb955b745b7
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Sat Oct 1 05:32:33 2016 +0000

    fuse: remove duplicate cs->offset assignment

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fc80e7500000
start commit:   73b7a604 net: dsa: bcm_sf2: support BCM4908's integrated s..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13fc80e7500000
console output: https://syzkaller.appspot.com/x/log.txt?x=15fc80e7500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ce34124da4c882b
dashboard link: https://syzkaller.appspot.com/bug?extid=a41dfef1d2e04910eb2e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166ee4cf500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1337172f500000

Reported-by: syzbot+a41dfef1d2e04910eb2e@syzkaller.appspotmail.com
Fixes: 4680a7ee5db2 ("fuse: remove duplicate cs->offset assignment")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
