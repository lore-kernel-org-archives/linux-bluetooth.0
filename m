Return-Path: <SRS0=ax5w=RO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A9FC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 17:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1FE206BA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 17:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfCKRdB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:33:01 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:41146 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfCKRdB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Mar 2019 13:33:01 -0400
Received: by mail-io1-f69.google.com with SMTP id p17so4606344ios.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2019 10:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=isauicIveizh2Thnf2HeFHmP4eOsW9wt5monXQQBqYA=;
        b=VZDd9dgPjo0HI7i623vL8v2GWUQJUu8aK8kFh8YC3bT3ZvCqZbuXTZqmRAnFEv1sju
         ltQ0W24PBB4FLBKZMTFohjbdO6FAQfDYpZbu+/SR40eqYhgRVRhglkKAB+iiGTnpFBdJ
         9HOzoq8x9y4K/i6TfDbGe2palUB1YE+FKywzB3t1MhrW7GAbblXK78RvXG/lWMTsv1zN
         52ZrbhZd460/iG5GLSsZS0HGWslcUFiaBxMxfbfXOTQywYy0bns8hmvx814qpn4iIQvw
         bCaN5MlW6ipya8HDdo4lvCqiemh/fp6Pf8a/qP2isldWirM2UQpio8bX+4+1B5/w5i9I
         F9Tg==
X-Gm-Message-State: APjAAAUmTnGTrVVKBtb40pBe9z3WM8B+ruXfQQFYG5z0mP90k+X4WAse
        fSLDBLtGafOWefePsL9omsNPWpGODmU4j/eBcNEEN/AZUlDT
X-Google-Smtp-Source: APXvYqxNHGDwxMkhRMzYJUaaRw1NG+HTbRv8/Iwq88XM8tYlVM3Bik892jQNUzBmbT5xOMWwyVBKe39zxZmaWv4+1WHoIhakjx36
MIME-Version: 1.0
X-Received: by 2002:a24:6283:: with SMTP id d125mr128441itc.14.1552325580967;
 Mon, 11 Mar 2019 10:33:00 -0700 (PDT)
Date:   Mon, 11 Mar 2019 10:33:00 -0700
In-Reply-To: <0000000000004aed310583d22822@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d458540583d4f6ef@google.com>
Subject: Re: WARNING in lockdep_unregister_key
From:   syzbot <syzbot+be0c198232f86389c3dd@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de, bvanassche@acm.org,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        hmclauchlan@fb.com, hpa@zytor.com, joe@perches.com,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        marcel@holtmann.org, mhocko@suse.com, mingo@kernel.org,
        netdev@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, will.deacon@arm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this bug to:

commit 009bb421b6ceb7916ce627023d0eb7ced04c8910
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Sun Mar 3 22:00:46 2019 +0000

     workqueue, lockdep: Fix an alloc_workqueue() error path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1625a027200000
start commit:   009bb421 workqueue, lockdep: Fix an alloc_workqueue() erro..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1525a027200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1125a027200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9d91b7192a5e96e
dashboard link: https://syzkaller.appspot.com/bug?extid=be0c198232f86389c3dd
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1006dc83200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137d0027200000

Reported-by: syzbot+be0c198232f86389c3dd@syzkaller.appspotmail.com
Fixes: 009bb421 ("workqueue, lockdep: Fix an alloc_workqueue() error path")
