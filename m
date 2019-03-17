Return-Path: <SRS0=QJP1=RU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD32C43381
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Mar 2019 10:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499A42085A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Mar 2019 10:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfCQKnC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:43:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44186 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfCQKnB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Mar 2019 06:43:01 -0400
Received: by mail-io1-f72.google.com with SMTP id c2so10994392ioh.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2019 03:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=43y/7IsqIHUUKBmqY48xyQhoryEkkW6z3Qinap7q7uU=;
        b=rboOpEGf9kAGUYpp0Wo+J5kAot5PfXm/YuHJz0PKdtKE0/UuMfF2U6GkhAJuwudwja
         KsOsO9bWHDwdPnKHM9Froer+NXPXZduRDG7B2o/les5I+H+EDG2Yf1NeuZkob9wd9maC
         CJYoF6IwIOeJhc8U0qBzXfX5W9BmilIIanRj7lMEJX5mOurE4mcpKwC0OF0AaT/7H1Z5
         iTVawsDCjFJcEKC1Gwp/xpc+7Ff/6aY89aEtFgEqjJzGjStOPzX4R2Om2sGDUTnsKmxC
         p+N+62zy6bO+RJX/oDRxOvdHpjgp4hk5xt5vTs/nqKMrPc+eqlYlhwWO1qLqyPG3R4nc
         x4Gw==
X-Gm-Message-State: APjAAAUrM4ZV5E6rjh5yftP8MqwRMoF5yhvi6ZnFvoCDizotjThQfSk6
        j51Bh3rtZbPIIwU+vxMyorY66+ABq/A3tEdAV56A64vFGhDA
X-Google-Smtp-Source: APXvYqxJ2GNURNaAGoL+uUmqBW47D3Z8/BvMbO8S3QyBU8ijogfA0uxoM32zji8RMgXjM6hIqBbFb3mwo+2/GjRjl6JguzI80hTv
MIME-Version: 1.0
X-Received: by 2002:a5d:8b47:: with SMTP id c7mr8134643iot.21.1552819380898;
 Sun, 17 Mar 2019 03:43:00 -0700 (PDT)
Date:   Sun, 17 Mar 2019 03:43:00 -0700
In-Reply-To: <0000000000008a1bce057ede3d13@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009950e1058447ef43@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bacpy
From:   syzbot <syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org, mmarek@suse.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this bug to:

commit c470abd4fde40ea6a0846a2beab642a578c0b8cd
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Feb 19 22:34:00 2017 +0000

     Linux 4.10

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13dbe2cf200000
start commit:   c470abd4 Linux 4.10
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d55557b516c45456
dashboard link: https://syzkaller.appspot.com/bug?extid=660883c56e2fa65d4497
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1756666f400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1397354b400000

Reported-by: syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com
Fixes: c470abd4 ("Linux 4.10")
