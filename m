Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A859C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 22:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2032660EFF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 22:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhHQWVn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:21:43 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:37714 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbhHQWVn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 18:21:43 -0400
Received: by mail-il1-f197.google.com with SMTP id a2-20020a9266020000b0290222005f354cso69822ilc.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 15:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=umDmu+4hB/JDNHdbTJk5sLucv5/bOLVHY7bndijJFTA=;
        b=UxLBJ9tpLey7Y4NupMOut79vKmQ6xoka+jSBZCgpacxdvhlaDGiq+ucgvC/mKFR5dm
         /iU/V007KNYAchkBqUezGPkzCyB/25kvHPnFHgZ/L85A/DHSKwCGcBTfKsmjYnSHmaSp
         5M0LbI58yEaMFyfHFyjJ2759jxGovtH38796zcLd9tbx233nLUvxLjP0Z4qeSOaWbHR4
         3WJmmkJIVEFFlLeG0UWloKDzJsOXS+5mpZQmihtz1fgPuHBtIqKgYRefAOOxF++0h3Ms
         MjQWm4+em9JUMTD1TcTytHtKs1KDV4HpPCf7wL2EuPgZVJu00jMvgZziu9BDgv4EhNjD
         c0ag==
X-Gm-Message-State: AOAM531KSVtcp/S1rDVnyKsWqXCx0Uua0O6cK4ySYnrsxGFeBCHdM+7D
        rQ8dcwzPWfHnahsBjnvqZo+sjV7RQmDPvBfVUB/POYfSZ0SR
X-Google-Smtp-Source: ABdhPJzaDcwt4eaiB4ndqrwZbsMFOJdKO3Yu0KMKfK1Kr5midZbCbjKzgjJY5yO6zqRjKZKrk/3nxoTRvoMMG4XwWaB7JHSI/tXL
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:547:: with SMTP id i7mr3835170ils.102.1629238869490;
 Tue, 17 Aug 2021 15:21:09 -0700 (PDT)
Date:   Tue, 17 Aug 2021 15:21:09 -0700
In-Reply-To: <00000000000080486305c9a8f818@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012030e05c9c8bc85@google.com>
Subject: Re: [syzbot] KFENCE: use-after-free in kvm_fastop_exception
From:   syzbot <syzbot+7b938780d5deeaaf938f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, mathew.j.martineau@linux.intel.com,
        matthieu.baerts@tessares.net, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit c4512c63b1193c73b3f09c598a6d0a7f88da1dd8
Author: Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri Jun 25 21:25:22 2021 +0000

    mptcp: fix 'masking a bool' warning

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122b0655300000
start commit:   b9011c7e671d Add linux-next specific files for 20210816
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=112b0655300000
console output: https://syzkaller.appspot.com/x/log.txt?x=162b0655300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a245d1aa4f055cc1
dashboard link: https://syzkaller.appspot.com/bug?extid=7b938780d5deeaaf938f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157a41ee300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f78ff9300000

Reported-by: syzbot+7b938780d5deeaaf938f@syzkaller.appspotmail.com
Fixes: c4512c63b119 ("mptcp: fix 'masking a bool' warning")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
