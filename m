Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C64C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 04:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356896AbiFVEhL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 00:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356537AbiFVEhK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 00:37:10 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C16235842
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 21:37:09 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id w7-20020a056e021c8700b002d3bc8e95cbso10433600ill.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 21:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WGUUiAN9wgqgmgaLmxz5/QjWUxqb/iZbav0ddG9/qxM=;
        b=lHKEOwMqdwQ8GmwTZ/RShDSNd1TieERlchhG/TQnPUIMKpF96ww/qbCgKbrypE04Fv
         Bc1r1eVXyGbvsTi9uudw6cODB4gP5ErloXaj8HaGbCCWWpw1FnZhr0VQCBY/iS+sycIP
         J192jgKt8VvJINAt8WlR07RRv9sQe796MrCy2jwEp2cNH3AzfZR2jYFXIPytIJR15tC0
         dqbsfZ9yD+PvKrvcKEKjyuXYaEYjDubFrATg0V6udlx36NIpheXfO23Ul1REWXplODPW
         +gse6mAybocWLj+psPluRGwh+IzwxMGVGv+BzFWBp+SkoPWAniGjetsHS2KOn4qJl/f3
         9vjg==
X-Gm-Message-State: AJIora9X7qXgnK9Gc9EbgTpC+uXanCZWY9xRjxAhlwhkurh9aQ+pAnw6
        U1ykAlB1EhHrC39rT+WZTm3zBPexN7zQm3s8le/LvUQZXbSw
X-Google-Smtp-Source: AGRyM1vc7sXZh7aauZkM8JZvEZJZDVt5NW8TEBYvuQNC9WLxqRQPwVvkC8owL79Qzjil/e5YVyFYVXe55idtE2rXbP9w6urOkpEW
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3488:b0:332:2973:be80 with SMTP id
 t8-20020a056638348800b003322973be80mr1048880jal.6.1655872628113; Tue, 21 Jun
 2022 21:37:08 -0700 (PDT)
Date:   Tue, 21 Jun 2022 21:37:08 -0700
In-Reply-To: <000000000000cf2ece05def394c8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cacae905e201e3be@google.com>
Subject: Re: [syzbot] INFO: task hung in hci_dev_do_open (2)
From:   syzbot <syzbot+e68a3899a8927b14f863@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit d0b137062b2de75b264b84143d21c98abc5f5ad2
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Wed Oct 27 23:58:59 2021 +0000

    Bluetooth: hci_sync: Rework init stages

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1376c63ff00000
start commit:   38a288f5941e Add linux-next specific files for 20220506
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10f6c63ff00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1776c63ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f4fbf50aa82985b
dashboard link: https://syzkaller.appspot.com/bug?extid=e68a3899a8927b14f863
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111555fef00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1629b3eaf00000

Reported-by: syzbot+e68a3899a8927b14f863@syzkaller.appspotmail.com
Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
