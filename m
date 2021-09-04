Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997B5C43217
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Sep 2021 02:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA4261057
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Sep 2021 02:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbhIDCHN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 22:07:13 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:38882 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbhIDCHM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 22:07:12 -0400
Received: by mail-io1-f71.google.com with SMTP id n8-20020a6b7708000000b005bd491bdb6aso650339iom.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Sep 2021 19:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zRIZHEuwoWOZaFEYOhQYWbRsZA/HnSh/xL4xkgPXzcc=;
        b=e4dV+yadDanRlcX9BA3ymgzbZHB/bdCy61kHadYIlpiLpnZvLhpzGu3mKGug7eNQhl
         BjfDm4F+yed6BvPDF6pRq8/KT6n7c3QtoYTuJO3cpkF3FdtQ0PSTguByTijcyXoT0uE/
         Vq81IgqXyARPQhWXLFCysw/uXZSJQa5Wre96ydBYMg4uWikbZE3OFnnTJBFeXeIfmyNm
         6nYy5eYgMTfTIEGYITQ4xcPBpP9RNL5389JCfd9bHkLD37Pfl8taLTHqnV16hZV9wSqN
         LAAYs7wCqTTgO6hqv7+5xIkR0m5tqsmTUj8VXoehP0+OfikWxn8EUmb6OrDuAj5gsj3j
         xSXg==
X-Gm-Message-State: AOAM533wdk8NIb4lJY9Yrs3lxOx0M+xu4m9od10DoS7WAIq8d82+Xj6M
        wcPD7oE7aJnnvs4bKGSte7D10pj7H2s3FjZC9OPGSqhMOCbO
X-Google-Smtp-Source: ABdhPJw9Np9RoKEz/LYgjUEKyZW1euqFQbMviBTa0A8MNSn66Y8d6bK+OvzYK041vGvMfoC0VmTIIndIbGS42wYFBjUHFOu/w5Dq
MIME-Version: 1.0
X-Received: by 2002:a92:cda4:: with SMTP id g4mr1287797ild.236.1630721171596;
 Fri, 03 Sep 2021 19:06:11 -0700 (PDT)
Date:   Fri, 03 Sep 2021 19:06:11 -0700
In-Reply-To: <000000000000f0cdb005cb1ff6ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000292cce05cb21dcd8@google.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in hash_net_create
From:   syzbot <syzbot+2b8443c35458a617c904@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d7ad33300000
start commit:   a9c9a6f741cd Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11d7ad33300000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d7ad33300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ac29107aeb2a552
dashboard link: https://syzkaller.appspot.com/bug?extid=2b8443c35458a617c904
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fba55d300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bd2f49300000

Reported-by: syzbot+2b8443c35458a617c904@syzkaller.appspotmail.com
Fixes: e6e7471706dc ("bvec: add a bvec_kmap_local helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
