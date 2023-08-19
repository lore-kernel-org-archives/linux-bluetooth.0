Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D123AEE49AC
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Aug 2023 14:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjHSOEF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Aug 2023 10:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjHSOEF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Aug 2023 10:04:05 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5269D207E6
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Aug 2023 07:01:26 -0700 (PDT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-55bf2bf1cdeso2726657a12.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Aug 2023 07:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692453686; x=1693058486;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZsvY+dCPEmaCpPr1f7vZrfpTvA7QYOX8BM6J1APpHc=;
        b=l3uWpkqjZ8iLybUFjniPpTtW31XBVTf6WrnI+iLCC35gV18ckWayTRT8lKquOxaS1f
         7H/bQTJNRx3CeBmBRA5s7J3i1fBI4dTEcK7DutUvxHnAXQpQNrXXgAqz5SMIPNjXrSBp
         z/iWxRdvOo7D62YXqGF32TLjUjeg/Pt/10SlAhkjeFBcpuCA4tFat11Q8SrC1fvCJgph
         BPALyX1744/wWACjJDYjBnU0Q5VmmyZc+1SypYS00B7/VdB/z5xP409aDMwGQhq94RWL
         vTcWzHYJ8vR88RLCH+R5HTjzt3qIk4NocNerZtq+dZcjWsbrUPL4puLkbu4gHhHF3a+d
         AO2Q==
X-Gm-Message-State: AOJu0YyXZNxpQMmvo2GbThrSFrCVm2Q9Xm6cV+mHTb7PlU52Yb8BR4Iq
        /OHfYVJ72pYhERVIKLgZ5zN5alrR/GDoJ35hV4OnvCaTysL2SnI=
X-Google-Smtp-Source: AGHT+IHO7XVlwa1OHRuPE8VEfNmhFREgeGAD7J/9LoLC6pDnEJfUX9uRBf/r7/wO6zKrNT3CRfqAzLXOBvu9rLhabpgQUEFtovtn
MIME-Version: 1.0
X-Received: by 2002:a63:6d46:0:b0:565:dcd0:cf24 with SMTP id
 i67-20020a636d46000000b00565dcd0cf24mr287527pgc.3.1692453685529; Sat, 19 Aug
 2023 07:01:25 -0700 (PDT)
Date:   Sat, 19 Aug 2023 07:01:25 -0700
In-Reply-To: <d5aebbd4337291708c970380fa947a0fe1767cd5.1692451565.git.pav@iki.fi>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b998c106034714cb@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_chan_del
From:   syzbot <syzbot+cf54c1da6574b6c1b049@syzkaller.appspotmail.com>
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cf54c1da6574b6c1b049@syzkaller.appspotmail.com

Tested on:

commit:         f0835e74 Bluetooth: ISO: Use defer setup to separate P..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1479e265a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b3a4035b595be0
dashboard link: https://syzkaller.appspot.com/bug?extid=cf54c1da6574b6c1b049
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13b9e265a80000

Note: testing is done by a robot and is best-effort only.
