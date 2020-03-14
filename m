Return-Path: <SRS0=4xDg=5A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BC7C1975A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Mar 2020 01:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7992071B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Mar 2020 01:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgCOByv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:54:51 -0400
Received: from mail-qt1-f198.google.com ([209.85.160.198]:41949 "EHLO
        mail-qt1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbgCOByn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Mar 2020 21:54:43 -0400
Received: by mail-qt1-f198.google.com with SMTP id w3so12800804qtc.8
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Mar 2020 18:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lcIB99Oc70nccWilUatyGo7bA1aJbKIH0bAnGGmG+HI=;
        b=uWeXQtb17+a1UtBJWORtFby7mlJu1hC5V6NIsMF7sK1trHaIsS3nVUtLkwVf+3Qykw
         iUEcQH22uPoHtADzC+RkZrcaO1Nrbe9NwP1kSLNZIDj1YxH91HPQy85spjIE2qMBWBXv
         l4xemHLeSQprs1PAlWxFKLYWwwWSvRn9xoxec8lorStg/PqdMmHQ1ZZGQJD4XmyM/dId
         xz87lo3jcmoS7tRHV9ZigxmxoWZCrqqNgXfb+J2oGjWv3GKm1nQbHPYDWqQn2FsHwv0r
         jLFSRGL0iN6tTp0YP13FosqzCGXUYVW8wESK2Ge8qhfp1yNg/lGPfPho52xMc5cGJvVz
         C4iA==
X-Gm-Message-State: ANhLgQ2MgU2+N2gOfBaQODgr+9neOQQZ2YH9E7gZE1359J1LAOypr1h+
        OEaqQF40x2B0nbyjfUlX3LXEbBfZvxbjXmYho8EjQ8z2YGsX
X-Google-Smtp-Source: ADFU+vtPYT6ImrSmn+n/oX5k44+StXAe5BTdqdlYQ14Q6+IFjM7O2EKZuGalsm3dcqRYn0+Y71MHqpN4yJlLeeGrUHswwpKYHgR0
MIME-Version: 1.0
X-Received: by 2002:a02:cacc:: with SMTP id f12mr13752376jap.99.1584228542130;
 Sat, 14 Mar 2020 16:29:02 -0700 (PDT)
Date:   Sat, 14 Mar 2020 16:29:02 -0700
In-Reply-To: <0000000000001ba488059c65d352@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f2c5b05a0d8f312@google.com>
Subject: Re: BUG: corrupted list in __nf_tables_abort
From:   syzbot <syzbot+437bf61d165c87bd40fb@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        johan.hedberg@gmail.com, kadlec@netfilter.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, max.chou@realtek.com, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 34682110abc50ffea7e002b0c2fd7ea9e0000ccc
Author: Max Chou <max.chou@realtek.com>
Date:   Wed Nov 27 03:01:07 2019 +0000

    Bluetooth: btusb: Edit the logical value for Realtek Bluetooth reset

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113e9919e00000
start commit:   d5d359b0 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=83c00afca9cf5153
dashboard link: https://syzkaller.appspot.com/bug?extid=437bf61d165c87bd40fb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168a1611e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162f0376e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: Bluetooth: btusb: Edit the logical value for Realtek Bluetooth reset

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
