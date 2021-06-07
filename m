Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77198C47094
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 22:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF4C6121D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 22:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFGW1A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Jun 2021 18:27:00 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41607 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFGW07 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Jun 2021 18:26:59 -0400
Received: by mail-io1-f72.google.com with SMTP id y26-20020a6be51a0000b02904b200a26422so7712690ioc.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jun 2021 15:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=b6fHq6inNIhipW1ztkPlqvY4f9MP6CcM1fFIRec2g9Q=;
        b=PLDbmOpJ0/so6NVmQAU6L0Xzewv/dhI6BxJccbMirCGAserDVgdtei+ontSAO+Gkbt
         jFumfpArQazw1CD+5iUMyAUFUR5Hl+PKVU792HGSUI22xaGxkwIyCvsprgXWRSFvAfXM
         92oZAWxANdWf31pXbw0FuBgYeh4czEwyWHea12HLB1ffjigMwarkrHzEzNhXmB/C97fK
         yQo6R6rqg8n9Hm5Lo3SsGOnPldWR1EiFLE8MnoM+6BsprZCpgjnWw8GQS39tkPBS4mmE
         S9+iqBlUHkLibBdqRaKsL9gyysrSWSnuMuOw3StN2B7G5Q777Pk76HacFI7/jD6lnIZD
         tGnA==
X-Gm-Message-State: AOAM533fsytzGj9Zl+1+5MGtX3mGOCPWgMLiH/HFg1eZN+jmRC8ucywy
        nHtMSmFjRdOZW7dx6YyQJLkjpOQqCxjF2RvEr7eWcRxO7LIq
X-Google-Smtp-Source: ABdhPJwtAcTvPmWHX1yhNgZvplxVlg3Lq4Iy23LPMcdSinVbgK/jgNTPKiwR7uQG+A5JZN6RstwFjKbGZgb+FMJKPmXgZx7fH8dH
MIME-Version: 1.0
X-Received: by 2002:a92:c98b:: with SMTP id y11mr16544524iln.27.1623104707679;
 Mon, 07 Jun 2021 15:25:07 -0700 (PDT)
Date:   Mon, 07 Jun 2021 15:25:07 -0700
In-Reply-To: <000000000000adea7f05abeb19cf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088dbd105c4348388@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in hci_chan_del
From:   syzbot <syzbot+305a91e025a73e4fd6ce@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, anmol.karan123@gmail.com, coiby.xu@gmail.com,
        coreteam@netfilter.org, davem@davemloft.net,
        devel@driverdev.osuosl.org, dsahern@kernel.org, dvyukov@google.com,
        eric@anholt.net, fw@strlen.de, greg@kroah.com,
        gregkh@linuxfoundation.org, johan.hedberg@gmail.com,
        kaber@trash.net, kadlec@blackhole.kfki.hu, kadlec@netfilter.org,
        kernel-hardening@lists.openwall.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, phil@philpotter.co.uk,
        syzkaller-bugs@googlegroups.com, syzscope@gmail.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 43016d02cf6e46edfc4696452251d34bba0c0435
Author: Florian Westphal <fw@strlen.de>
Date:   Mon May 3 11:51:15 2021 +0000

    netfilter: arptables: use pernet ops struct during unregister

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1325d967d00000
start commit:   af5043c8 Merge tag 'acpi-5.10-rc4' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9aa2432c01bcb1f
dashboard link: https://syzkaller.appspot.com/bug?extid=305a91e025a73e4fd6ce
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130152a1500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102b1bba500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfilter: arptables: use pernet ops struct during unregister

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
