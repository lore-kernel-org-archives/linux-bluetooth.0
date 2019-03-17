Return-Path: <SRS0=QJP1=RU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B96C43381
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Mar 2019 10:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED9F2184C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Mar 2019 10:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCQKnC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:43:02 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:39661 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfCQKnB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Mar 2019 06:43:01 -0400
Received: by mail-it1-f199.google.com with SMTP id h3so12188860itb.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2019 03:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oi5XUX9Bfm0EZAFt9uWawkoY614hl8Ao0SeR1n2snTQ=;
        b=kg1IeX43ZdDPyH0in87uAC8jQ4B7X1vnhiRYSu2UFhFbIlwmWUSARml9V4tYhHNNSZ
         rTVLs6CfqZiPoHCUcJxwy79TnFtLSYfxZqhNM7XxNxYbveiw51qNDYBCbje17eZS5mbj
         ZQibccF7OrkwL7bgEjXA1ghswO24nVkUROmqeQl1FH/GrDBe+WXQd7/iNQ5P44wq1aOm
         g+Zqz/KwJePonwK7jHqshXaRhXYzKLXjpL8jgz+dAbww42rdVPtKFsoO85S4SaIfwRu5
         yxzXEe7pdqL0i0ex6Ta6Z1bm3H1TlcTI6i7tvO0OMnaggiRJHMRZn2djtC1TTuCCBm5Q
         0Jzg==
X-Gm-Message-State: APjAAAWZEom/+ozRQbpjiSGnQ9Lm1hGCKV+ocFqgckCDg47yOJ1TnFpD
        WHdeeIMA3God8SpI9nE+/db1hl9sW7quoIwqJ+Fc/eVx0NLS
X-Google-Smtp-Source: APXvYqylmbuGqfpklPa2WOK8fFaqmVHKcWlSaxz9jYcRgqrwSr1LD/ArXA8K6Cj5utQWqTSsOvlydZZB1OqrCHhJnLpJ6+hKJ/9B
MIME-Version: 1.0
X-Received: by 2002:a24:b007:: with SMTP id d7mr7096608itf.8.1552819380766;
 Sun, 17 Mar 2019 03:43:00 -0700 (PDT)
Date:   Sun, 17 Mar 2019 03:43:00 -0700
In-Reply-To: <000000000000696949057ee26e44@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000974cbc058447ef88@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hci_event_packet
From:   syzbot <syzbot+cec7a50c412a2c03f8f5@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127bd0f7200000
start commit:   c470abd4 Linux 4.10
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d55557b516c45456
dashboard link: https://syzkaller.appspot.com/bug?extid=cec7a50c412a2c03f8f5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1643bfbf400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d6c8f7400000

Reported-by: syzbot+cec7a50c412a2c03f8f5@syzkaller.appspotmail.com
Fixes: c470abd4 ("Linux 4.10")
