Return-Path: <SRS0=CqyX=RZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8649CC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 12:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EF32070D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 12:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388140AbfCVMEB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:04:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:47792 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388594AbfCVMEB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Mar 2019 08:04:01 -0400
Received: by mail-io1-f71.google.com with SMTP id b199so1519028iof.14
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2019 05:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HhIwQpOIDaInjq9W5iO17MElgr9ywvkfiRcKDy0TYVI=;
        b=Zs1GXpJZUFN2D+3HvYJlxN9Oeiflo5iDM9yHyEL47V6P5YpuPqnNKs41rq0X+6Bvyq
         EwhRlwF3Wh2LhJU3ItvziPprluIx1BvOHjp2aX3bxUrMCgND3+JM1nQ+/aDnnIpPCj2j
         w4SxZL/XsikGeUW9GGoN02qkpuwDwyTCq5icDHBTebVhgG5jVU3STiwTTpvDZQqbVEym
         jKzfZXXG04XmPMBjJYCCDw5mZdlVht/o8hIL11QD6Mxo0BOMLnlQv4cX+I2UpJk3X858
         LSPwa8R5HCnEqRAIaE5ArOSdyJ5eM5p6vXxLfWCnUyDOxDvlZB1B1wLLW1OmvDrnrK4p
         aRcA==
X-Gm-Message-State: APjAAAXk4nIP3Rzwc5IpRUZ1TAK2GjEQMKEDA3VElUXmN5yUEdCnQUvz
        rvp2NDMSxwDcEtdvQ3o59glX/vrYcF1ZcbQq5Xs9mj1jSavG
X-Google-Smtp-Source: APXvYqxewmxUvJeJivsYNJAYw4A+YPrEl2q2KRPzLI60pjm8+ODiNw4nJOk2T7nrekpcEU7Qv9+AjT+/tYP3d76JWNrQF2zGwv08
MIME-Version: 1.0
X-Received: by 2002:a02:9f08:: with SMTP id z8mr7082292jal.6.1553256240713;
 Fri, 22 Mar 2019 05:04:00 -0700 (PDT)
Date:   Fri, 22 Mar 2019 05:04:00 -0700
In-Reply-To: <0000000000003692760578e651dd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007917ff0584ada6e7@google.com>
Subject: Re: KASAN: use-after-free Write in hci_sock_release
From:   syzbot <syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1664c6df200000
start commit:   c470abd4 Linux 4.10
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7308e68273924137
dashboard link: https://syzkaller.appspot.com/bug?extid=b364ed862aa07c74bc62
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152532bb400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f73320c00000

Reported-by: syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com
Fixes: c470abd4fde4 ("Linux 4.10")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
