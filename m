Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EC3C3DA66
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Aug 2023 19:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjHYTey (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Aug 2023 15:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjHYTeb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Aug 2023 15:34:31 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB302684
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Aug 2023 12:34:29 -0700 (PDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-53ff4f39c0fso1049177a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Aug 2023 12:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692992068; x=1693596868;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QfsEebV8zTG2r+IEVFBCogKrr4ns055y+jw1URP6XFw=;
        b=IElw4eWWYaofx5esKom3wlPEyhm1h9JluzqUzTPSuLQyd3bghCKzeiEuYFJp3KvvRs
         9JCNgH7zEkGIN6nJQK1jXvJBb7ZMQGveYqgyFwG3s/zzMOnmU/mg8pDGDD0bLJgklpMZ
         LhZZ7e9LL+SryCRUeN5yQ/kCsUWhXxpwNTI7a5C97/91Y3PAZY3SoMsZ7PZmai+1QswC
         3vTyLjg/wLMNvlqd7dHDXa4turuEj7LBm0vU1UXBM3TN19nm5qy4Xbg1rSQz9xxTXh6B
         ZraCtgcALElK+I60Qpb/XvKkZ74mNYGnSPdd0e2TDgAf8wQiK3nZ2vALZrLfp5RJhZYr
         wsig==
X-Gm-Message-State: AOJu0YyYP3K02FDjlUsAxvIXnQd/9ivy38frBHjf6a8G0Iwa5ZXDb9lV
        rYrX08VCzadj/F2rfvh6fN9oAuNaRHoVO+zzhLygqANzsDxy5pY=
X-Google-Smtp-Source: AGHT+IHuXfNyZ0x8VNX75RLh16LBKIWUrtngyu3lh3b4ao9ELzyIIoFlZFxol6e4DapEFAu3Q3K7uTRghXfEsLrbulExnlZnPv9t
MIME-Version: 1.0
X-Received: by 2002:a63:3582:0:b0:56a:c549:abb3 with SMTP id
 c124-20020a633582000000b0056ac549abb3mr3097168pga.10.1692992068626; Fri, 25
 Aug 2023 12:34:28 -0700 (PDT)
Date:   Fri, 25 Aug 2023 12:34:28 -0700
In-Reply-To: <8d413750f5749773c033245a593394933b77372e.1692986355.git.pav@iki.fi>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbbcda0603c46ea1@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_send_acl
From:   syzbot <syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com>
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com

Tested on:

commit:         2a05334d Bluetooth: btusb: Do not call kfree_skb() und..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1521e55ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e532e371ba4b65ca
dashboard link: https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11eaff5ba80000

Note: testing is done by a robot and is best-effort only.
