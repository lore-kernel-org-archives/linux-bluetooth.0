Return-Path: <SRS0=ZUSg=BO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DD6C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 13:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D593208A9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 13:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgHDNBa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:01:30 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:43631 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgHDNBH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Aug 2020 09:01:07 -0400
Received: by mail-il1-f200.google.com with SMTP id f131so9178393ilh.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2020 06:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=06+82rKMp3PGXLDD6Ap7gC365MaLMsLGY5Rl6STa3zE=;
        b=KGCXRJ6z2NnWqsTugSoBZEddg3by2lWWN+Kz5wRJbnRRo8mmGjU2jK5jplndO2Vh9W
         BlyyOdkby3QpZqdaczb5f3pfHNh5SOOcBD1uZRRyskqJmkf1O1b3RGOvojrzRcUSASND
         rpRJRIHe/6Ai6QSPX/nKjGSBVMy9HePVb+Geh3sQaTFCU3R8fBqTQ5c45dHPBvnBSyx2
         sMEq6e/E2BoMX7bqOlPfkk3RL59K2F/zGBO41uRITcZ99FEB2Y89UMXlMmv2Xo4iXDQb
         ynFwW+53fjNGiAkQNEPRljb4XIIXep5nDZNadR7ktWGFOnnF0wXyi8pXSNKTc2Scpj/F
         cZOQ==
X-Gm-Message-State: AOAM531w39pO3Y6IOapS07GTBZUDzhssAXhsVQNdvk2nnnOlr98hSq74
        0zzzpnZ0HwRb655VM6wchh4CMhr81EUNEBa7BB0osIRq0vt2
X-Google-Smtp-Source: ABdhPJysIn/3rq8mJzFBZcPdgkiq5Vci73yhB6VXvAfDq6syCOUZWs4ErkDjGmgAWbCV304S/arGJe8W97c4vCtTU2PHRCJr/z6K
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d51:: with SMTP id h17mr4320234ilj.155.1596546066783;
 Tue, 04 Aug 2020 06:01:06 -0700 (PDT)
Date:   Tue, 04 Aug 2020 06:01:06 -0700
In-Reply-To: <000000000000a7eb5e05abeb197d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002da68705ac0cd9ab@google.com>
Subject: Re: general protection fault in hci_event_packet
From:   syzbot <syzbot+0bef568258653cff272f@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, geert@linux-m68k.org, javier@osg.samsung.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, marcel@holtmann.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit 941992d2944789641470626e9336d663236b1d28
Author: Javier Martinez Canillas <javier@osg.samsung.com>
Date:   Mon Sep 12 14:03:34 2016 +0000

    ethernet: amd: use IS_ENABLED() instead of checking for built-in or module

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155180c2900000
start commit:   bcf87687 Linux 5.8
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=175180c2900000
console output: https://syzkaller.appspot.com/x/log.txt?x=135180c2900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b489d75d0c8859d
dashboard link: https://syzkaller.appspot.com/bug?extid=0bef568258653cff272f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1043af04900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ca1dea900000

Reported-by: syzbot+0bef568258653cff272f@syzkaller.appspotmail.com
Fixes: 941992d29447 ("ethernet: amd: use IS_ENABLED() instead of checking for built-in or module")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
