Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C27C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 03:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509BE60F14
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 03:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbhHQDDj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 23:03:39 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:39728 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbhHQDDi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 23:03:38 -0400
Received: by mail-io1-f71.google.com with SMTP id u22-20020a5d9f560000b02905058dc6c376so10391859iot.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 20:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=r36cl7Dm93TI6Hk3w1gK1TcRtwvGhgvxUmk3P8QzyoA=;
        b=C4q080bZt+hVzh2Rzuhy+dRj5B7++eLPs0SlqBIsVGK2KPOZA49fnlpZxA3oTuRoNE
         P8R+9XkpmLjoBaQhayaUo+jOkdExVp1RrPVlSnWsPgzJwoUSi06RSbqQXLK1kPs52Dbi
         BlvVrqSJ6S1RoP6gZ8R4V7n/Exkh1Jm48lQrQztaPdlKD56ZKwHLpl8X5YUnwO4QsNgZ
         TAC/1paS6oDSUV4AKvknCORcJbEKwRCusZwDwOulKO1nVpntPjt8+xD+gC2PJgm1RWjT
         YtTyDhFBQMNcn31PTkB3SX1OC3jzFLVJiWrPPusYYsByE8CASpfIerIfIE97Vbpc0V/b
         +EZg==
X-Gm-Message-State: AOAM532mVdUtLjbdo94xyiyjdUhD2YkCUkkEdtG7NJhUqUM02UrAnwDa
        Jx+XOBw+lLN0O37Un3wqLonRppA25KenRWvAjAWdIpmmVTqE
X-Google-Smtp-Source: ABdhPJzlctyr85a5kEj6HJpdeI+NV5Yxa//9wnjg7kk7US/j0HDD24qv9viEa0QuGVe26j6R8Cc5o192IS8pf+7WAvEoz9gD46GX
MIME-Version: 1.0
X-Received: by 2002:a6b:7106:: with SMTP id q6mr1173087iog.174.1629169385855;
 Mon, 16 Aug 2021 20:03:05 -0700 (PDT)
Date:   Mon, 16 Aug 2021 20:03:05 -0700
In-Reply-To: <04cbd217-21d2-c623-2d06-35d6040a3479@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085df3005c9b88ee0@google.com>
Subject: Re: [syzbot] INFO: task hung in hci_req_sync
From:   syzbot <syzbot+be2baed593ea56c6a84c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+be2baed593ea56c6a84c@syzkaller.appspotmail.com

Tested on:

commit:         794c7931 Merge branch 'linus' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=96f0602203250753
dashboard link: https://syzkaller.appspot.com/bug?extid=be2baed593ea56c6a84c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c85965300000

Note: testing is done by a robot and is best-effort only.
