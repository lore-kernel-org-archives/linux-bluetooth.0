Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2B4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 31 Oct 2021 18:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A3660F4F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 31 Oct 2021 18:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhJaSvp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 31 Oct 2021 14:51:45 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:45813 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhJaSvo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 31 Oct 2021 14:51:44 -0400
Received: by mail-il1-f197.google.com with SMTP id q14-20020a92750e000000b002589d954013so8709790ilc.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Oct 2021 11:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=EDfj5ne47rqVe1CydX+aYgYdcHr5k4W7I1Ib2hSVKPQ=;
        b=NVBEDz6KWQ044FMkO9qn4ON2JkCPqxo0AmV4joi1ii+Pw6JCbLHWTxK8yDstblAuD5
         PTvqazU0Y1bdE5CtO1yKrqnomSjbOeeuG/kaZbMCKwjQxE0inVbx+OveSh+Djj1Q56b0
         xiXlj8TVRdDA4lzbxVMncrKlcP9IJQ87/6+ElJ9J+8akWW5IYudQjlTvSLhs+WrtwxXN
         nuVYw9EcJJJxEBWXadpQ/+V2K90sszQ+/WVipWUKma20tMSe/zdfNgO7aGTmUvvTSdVg
         v26+2HIMh22Lbg57mBYjmOO6nIosE6WsWPNeLUKObZPJfOvd319/Vxbwld4Q6SeBUH9S
         DjjQ==
X-Gm-Message-State: AOAM533fQvyCpUIBbnBCNbb4tuWGOeKre/6zny7Qe2UJQ0ecenaMG7w6
        Hww3DYwa7Rp2O9QQz6v5rkSakCaaGFjslxkq0MTDZY3wO8kx
X-Google-Smtp-Source: ABdhPJyOG+lTecw5XF3nfkAPSpnl6M8hQQ/dDGVasqzB2YT8aLiWoViqcJHVGaVKr5kPojVr1ebi8CChphSOdx01Y5mQi4o/Pg9s
MIME-Version: 1.0
X-Received: by 2002:a6b:650f:: with SMTP id z15mr11810710iob.27.1635706152392;
 Sun, 31 Oct 2021 11:49:12 -0700 (PDT)
Date:   Sun, 31 Oct 2021 11:49:12 -0700
In-Reply-To: <dd579644-7ef9-f005-0275-b7384ca731a5@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ba17d05cfaa8446@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in hci_le_meta_evt (2)
From:   syzbot <syzbot+e3fcb9c4f3c2a931dc40@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+e3fcb9c4f3c2a931dc40@syzkaller.appspotmail.com

Tested on:

commit:         180eca54 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6362530af157355b
dashboard link: https://syzkaller.appspot.com/bug?extid=e3fcb9c4f3c2a931dc40
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1295a186b00000

Note: testing is done by a robot and is best-effort only.
