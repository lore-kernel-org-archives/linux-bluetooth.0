Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9218C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Nov 2021 16:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhKZQwY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Nov 2021 11:52:24 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:39904 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbhKZQuW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Nov 2021 11:50:22 -0500
Received: by mail-io1-f71.google.com with SMTP id m6-20020a0566022e8600b005ec18906edaso12167758iow.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Nov 2021 08:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=E3SZU77OvG0V43pQYfeC1jMV8oQXDfgfTFhN98Th00Y=;
        b=PfahnVfLdYMS1l3B/SxnJ06CN/Dth6Jm0LpoiDiP8TZqdnTm7ZtdZw7pgvu/AxV5Q7
         5LjuEkpnG+rRyBgW2pYSXbG6zQ6ZQsEtEE+ak1+6tE4rcp68mTpef1/cr5SYMyQGGhzo
         ZFeYmO560PYEbogXQyNs7LWvyh/jB7rILkWcSf+8rWjL9yoVlC3Q0GZF2CZ4rp4T5f1x
         +sLVrpoaaKaSx4EjPuy+IQvOIgJ5t/VVAJZkDH/WfLnZ7o6GyrdGcRFPTZ/Ug6vd9XCO
         vy5fVLI3RiP/H05mZAR2bKmcES7IPNaRW0iRIWPGrhZgsFNCC65+WGQ00uczvuVoLZmd
         tbxQ==
X-Gm-Message-State: AOAM5311z5VBHw07VmRUTR5npRBEzGE16CknDSzlxKfSwLQlYm02CR1O
        slAR5yS5JcrRL9qMqxXoT6KaZ0wBDuTKkg+ew46XnF15uYun
X-Google-Smtp-Source: ABdhPJxa08KUq2MMDJ1aTzNQi/UsWNU0/4EepC/SG32d6AnThd3Chiw0oY+CcomOpKqgzD1VRBsYBUGPiOmiTWCB1LYJXM42xT0m
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2103:: with SMTP id n3mr43636451jaj.25.1637945229555;
 Fri, 26 Nov 2021 08:47:09 -0800 (PST)
Date:   Fri, 26 Nov 2021 08:47:09 -0800
In-Reply-To: <0000000000000a389a05ac5a9864@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091c45705d1b3d7ea@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Write in l2cap_chan_put
From:   syzbot <syzbot+452e9465a3b2817fa4c2@syzkaller.appspotmail.com>
To:     anant.thazhemadam@gmail.com, bobo.shaobowang@huawei.com,
        cobranza@ingcoecuador.com, davem@davemloft.net, ducheng2@gmail.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 1bff51ea59a9afb67d2dd78518ab0582a54a472c
Author: Wang ShaoBo <bobo.shaobowang@huawei.com>
Date:   Wed Sep 1 00:35:37 2021 +0000

    Bluetooth: fix use-after-free error in lock_sock_nested()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=141cfa45b00000
start commit:   c70672d8d316 Merge tag 's390-5.9-5' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd46548257448703
dashboard link: https://syzkaller.appspot.com/bug?extid=452e9465a3b2817fa4c2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152f31f9900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: fix use-after-free error in lock_sock_nested()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
