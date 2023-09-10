Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C68EE49A4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Sep 2023 22:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjIJWnp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 Sep 2023 18:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIJWno (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 Sep 2023 18:43:44 -0400
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7E5184
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Sep 2023 15:43:39 -0700 (PDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-26f3bf964feso4598610a91.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Sep 2023 15:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694385819; x=1694990619;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLIZAbSCvNytHhevI9ZG78CMGs02CUAu94VDRUFUCTg=;
        b=M7H6mKvN9GTE+wn9/GbIO0UWnItloWMfD/2r8NpJjDKewMhqucw4jaLPLe+h+CayMz
         V31lIVxTVNgid0jK2ubNWIzsO/kuG/my3/JplTDSEHhUfxXEKbByzqGjLO9AuwLnU1wV
         FrU+0BSi6cbQli+WG9NYOoWYpR9uPD9QNMGEyljk0L9Hd7bKrHl1YyNy31DncwiKw6vi
         0NdqfSxUNzQNOFlHyi3VO87DimVpHlDZR62RBtXsVID7N2nPL+698EWHvgJW+0mlCUxn
         f9ryCkQLIFWn5PjcKEmufplO56Zn+BQ1bKUbOUxFHoZIToS1+xMTiSXFR08dIA2N7It8
         yPrw==
X-Gm-Message-State: AOJu0YyUwkdRbp8GGgMOum9B8mchpCF924HsNSsdRZVrr3IYFmXYhlBo
        8PA6C75/2fGD3CgK6E+xqsHVouLsoPc5u7GQ72Phi9zR7aWH
X-Google-Smtp-Source: AGHT+IHjJSd9mSFaTvjCMHXTpXZtE1Fh0uCicpy5IzNHyNzZiWSElSHzGQX36i2ikxjDzfXOuEKtESL43gSz23rexVlYXvxVz3kR
MIME-Version: 1.0
X-Received: by 2002:a17:90a:c28f:b0:262:de4e:3967 with SMTP id
 f15-20020a17090ac28f00b00262de4e3967mr2253607pjt.0.1694385819076; Sun, 10 Sep
 2023 15:43:39 -0700 (PDT)
Date:   Sun, 10 Sep 2023 15:43:38 -0700
In-Reply-To: <0000000000007f826b06044878ed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbd624060508f001@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __sco_sock_close
From:   syzbot <syzbot+dec4d528fb7a7c5d8ce3@syzkaller.appspotmail.com>
To:     eadavis@sina.com, hdanton@sina.com, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, pav@iki.fi, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit 94d9ba9f9888b748d4abd2aa1547af56ae85f772
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Wed Aug 9 23:49:33 2023 +0000

    Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124d6578680000
start commit:   99d99825fc07 Merge tag 'nfs-for-6.6-1' of git://git.linux-..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=114d6578680000
console output: https://syzkaller.appspot.com/x/log.txt?x=164d6578680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=988789167afa40d5
dashboard link: https://syzkaller.appspot.com/bug?extid=dec4d528fb7a7c5d8ce3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e9ba2fa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111affcba80000

Reported-by: syzbot+dec4d528fb7a7c5d8ce3@syzkaller.appspotmail.com
Fixes: 94d9ba9f9888 ("Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
