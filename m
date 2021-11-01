Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F412C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 00:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16CE61051
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 00:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhKAAMl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 31 Oct 2021 20:12:41 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:42747 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhKAAMk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 31 Oct 2021 20:12:40 -0400
Received: by mail-il1-f198.google.com with SMTP id w1-20020a056e021c8100b00266694bb43cso1733264ill.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Oct 2021 17:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Afp5EW5NkKvo/CTFXhPj0ythG6Ja27sM8OR5KgU1Xu8=;
        b=z6uY78Wa9Ek0UDCda5XHmWyhBwVIbd5HBwKkuJqksnoiLQtTReSfikOIdBK0m0I2O8
         fa0q/SWQ4Y36VeMF5Z76KeH9fc5dxw8w1Wv0xYzNxp1VG3HCExKcUv4CHMaQ01KBJTCu
         fDPvOjcaHIXopWNzUEnhY8/v6RIzRf4SUixpDih4dZl1bhX4WhANeZN0sd4MrSwH8pyb
         FVj2nCqOV9i7GUylTl+H65+HKbCWJv3pflPsq8wnCXe7WgsLiSeGctA/KMxmoAc2SVcm
         53o/LwUlWsCx3ltrdzHPbFkrAwk01gLkzjB7+/QJGWUBycRJDq4W6MWc7H0xkddu0xsB
         Ttrg==
X-Gm-Message-State: AOAM533BWyseClf++K3Fcg2+a0ZyKXusp35voJHdexEyaMTLAIHUU1Wo
        1MUcZXevETNCoOkm86NwfC8364/3cj5oMndvWmL5Y5SwmU5R
X-Google-Smtp-Source: ABdhPJzvDiSWpENrfpgFn60q4qjm7mMvncZKK3Plr617y0m1LtDCp5/53EwucWc1koNxoVvq4ESrYzdTCQ+mYziVq0qcr6T4SxXP
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3488:: with SMTP id t8mr4452286jal.139.1635725408206;
 Sun, 31 Oct 2021 17:10:08 -0700 (PDT)
Date:   Sun, 31 Oct 2021 17:10:08 -0700
In-Reply-To: <4b2b9c55-e2e0-a149-7dfe-ca36244d2245@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e805e605cfaefff1@google.com>
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

commit:         8bb7eca9 Linux 5.15
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=afe4479d781b5f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=e3fcb9c4f3c2a931dc40
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15bd0e6ab00000

Note: testing is done by a robot and is best-effort only.
