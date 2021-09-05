Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F25C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Sep 2021 23:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FAE60F92
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Sep 2021 23:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhIEXWO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Sep 2021 19:22:14 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:34474 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhIEXWN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Sep 2021 19:22:13 -0400
Received: by mail-il1-f198.google.com with SMTP id d17-20020a9287510000b0290223c9088c96so3015819ilm.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Sep 2021 16:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=t6KGl5qGZOKwjA8wYNjhxOdRHpEUEUmyOHtgq+CbC7c=;
        b=FMzFe+uyJ54pOtExJNwe+KC6ySPIVWHWTG5ymBOGHpgDJHem2HXxbtZh24VWw6QHQl
         eKRjAx7ouCei7bC9qlhN0SaiI+4h7hA9tvuHwCZD7U/sLvKIUkrGwtRy58rWeJELYs0a
         oLhvqq84NKSNG6i/rvRhEfnGHsWJoXQALY6xrqe8wnvjCUAish6U8s/mgaG924skLkfr
         srJ4lJDAkFfrI1y/nLm64hriduco8YDuJ0BTFNNl5r0Lmjedbj2QIDM+rI53ufDoVfGV
         OYHfP986ppu2Z7KQCTbHQM0iJNRncEAenSqvLi7v2gD4mlq0iY12hLbOKOWSdsV2yB0+
         i+rA==
X-Gm-Message-State: AOAM530zVbRvm2zhV9ucR3eCzwC1fsnaIqM0MinwHAdG9g7ZFZpllx6H
        clzXT6OmceevVNRDk9VdwORa/ZlGJcYSd2kILR+gIxoQ+VAJ
X-Google-Smtp-Source: ABdhPJwd3TYEWNuMTgpkZAvirmsn+/SrAn8Wwh9OqmKijRfViKorf/rzRe7Kmqs3U6G0U4D5VgDmmChYa9ZQ83uEoiOkJtAR2DKB
MIME-Version: 1.0
X-Received: by 2002:a05:6602:38e:: with SMTP id f14mr7782287iov.62.1630884069876;
 Sun, 05 Sep 2021 16:21:09 -0700 (PDT)
Date:   Sun, 05 Sep 2021 16:21:09 -0700
In-Reply-To: <000000000000ea2f2605cb1ff6f6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7a8de05cb47c9b2@google.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in hash_ip_create
From:   syzbot <syzbot+3493b1873fb3ea827986@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, chaitanya.kulkarni@wdc.com,
        coreteam@netfilter.org, davem@davemloft.net,
        eric.dumazet@gmail.com, fw@strlen.de, hch@lst.de,
        ira.weiny@intel.com, johan.hedberg@gmail.com, kadlec@netfilter.org,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, martin.petersen@oracle.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit e6e7471706dc42cbe0e01278540c0730138d43e5
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Jul 27 05:56:34 2021 +0000

    bvec: add a bvec_kmap_local helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17468471300000
start commit:   a9c9a6f741cd Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14c68471300000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c68471300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7860a0536ececf0c
dashboard link: https://syzkaller.appspot.com/bug?extid=3493b1873fb3ea827986
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11602f35300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e8fbf5300000

Reported-by: syzbot+3493b1873fb3ea827986@syzkaller.appspotmail.com
Fixes: e6e7471706dc ("bvec: add a bvec_kmap_local helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
