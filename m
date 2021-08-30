Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E425BC4320E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 03:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD1F60C3F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 03:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhH3DvI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Aug 2021 23:51:08 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:40703 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhH3DvE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Aug 2021 23:51:04 -0400
Received: by mail-il1-f198.google.com with SMTP id f13-20020a056e02168d00b002244a6aa233so8236657ila.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Aug 2021 20:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aPj2TWnuDlBBweogJjWY/JGFaEJrBHfPmSKpxgNvZiU=;
        b=PhQBTBtD84Oxgs8VrBy/smmvYiyfKGsuyxQ9q9IaHOkn1oOY04YhigzoBuBZA4IE4f
         mqn3d59CKA8jAZ7Uyp8jBvwE9j0SUs3gmw02vWZhymWZZB7Uo+6OcrvJuKwBArm7QQqo
         GA59vAE+e7XBKr+RlN5HANFKcitd/gtBE0ACaQd6Vlt5dM6BjwuWQdqhmqVU5w4is5wh
         wKBFwaxUBGHgk4rKdDDmUN8kcHi46vqveYTZgjikFJ8j+n70hCIFaDySCM2kls5dfxmf
         +1JaMNtCUvv5IcREACn0qBwBLLIkatciZApKLLqeaH7cDiwKFxG3oGCYMxOSnKkk6Tym
         jutw==
X-Gm-Message-State: AOAM531uiz9sqboUAKX7wAU88DhlVOZkyz1/E9Plbj18l7K4ccEi/3j3
        uP40z7j4JDbtC09ySTdlPWcx4uj9Ru/f6mLxPQOwGaW2wGym
X-Google-Smtp-Source: ABdhPJy+Gj4J94WdetktCJfOEdZLLQt7q/2b2MyG4vRH7zjuGJWFiubLKIITRmf5mdwjudyvT2VLSHlhjDXPPZ6V+hAs6E7qGM0+
MIME-Version: 1.0
X-Received: by 2002:a6b:5c0c:: with SMTP id z12mr10646897ioh.171.1630295411206;
 Sun, 29 Aug 2021 20:50:11 -0700 (PDT)
Date:   Sun, 29 Aug 2021 20:50:11 -0700
In-Reply-To: <9b1afb1f-45d5-8664-eeb6-e8373d95cad3@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd337505cabebaab@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in sco_sock_timeout
From:   syzbot <syzbot+2bef95d3ab4daa10155b@syzkaller.appspotmail.com>
To:     desmondcheongzx@gmail.com, hdanton@sina.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.von.dentz@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2bef95d3ab4daa10155b@syzkaller.appspotmail.com

Tested on:

commit:         e3f30ab2 Merge branch 'pktgen-samples-next'
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef482942966bf763
dashboard link: https://syzkaller.appspot.com/bug?extid=2bef95d3ab4daa10155b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12580a25300000

Note: testing is done by a robot and is best-effort only.
