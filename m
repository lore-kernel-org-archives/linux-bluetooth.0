Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C04C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Apr 2022 11:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiD1LfW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Apr 2022 07:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244994AbiD1LfW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Apr 2022 07:35:22 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B961FCFE
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Apr 2022 04:32:07 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id d19-20020a0566022d5300b0065499cd4a73so4252518iow.14
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Apr 2022 04:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OLJAFGzDsMJJ4vQznge540lOuDzmbTYygXPQSl9cRbQ=;
        b=o/anArnv79XOhpwiC4Ljt7jMa4VAfxaNZDGAr/KW44xtWrCHKlDp1F9RrgH2so9+9W
         ODlSn7W9GzDwpUZjkx9k4rLzf7lL9lYyvqEo83hsQxcyKewIIdok/VerrHxEnZN29/0r
         ad2tWA3SVAQP0RsTu49Ja0Fz1uvQnIPUx1Tb0+7mQdaMsb+SEJ1k8gftQ3qf4ra/YX9g
         Goco0pdCmulsyMqjUaY/b6sVcY3pZLxCRLwyyiJBIWm1MAa/NRYxXbKvT6512Ty9sEQw
         DOz7GKPvT6zFnc/xicI+eWs59TRTGe2Y1hKJIUq3V3EsbLidQxEOg12qCAD7xfJ2xD1H
         UCoQ==
X-Gm-Message-State: AOAM531CvcIkaXDJmLr2JS8jeLsBo4uh4PfgK5F3ipLAhMnyP//cGXCd
        FOM9T4lH9BkytMlTOFA7ZZr2n+DOrl6sTsGjHro1xK9ghTRQ
X-Google-Smtp-Source: ABdhPJxAB0syNAAGUZ1g96hnh6vV4104IOqaj5OdTdHHn6UlNjjQtYhmf+CWQ5O28oTueITCCnG3U8t1lGf+LO7u83qZ5Ixvnhkl
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20eb:b0:2cd:83e9:b910 with SMTP id
 q11-20020a056e0220eb00b002cd83e9b910mr10188255ilv.185.1651145526916; Thu, 28
 Apr 2022 04:32:06 -0700 (PDT)
Date:   Thu, 28 Apr 2022 04:32:06 -0700
In-Reply-To: <000000000000af7f9905da904400@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009abe0e05ddb546f6@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in dst_destroy
From:   syzbot <syzbot+736f4a4f98b21dba48f0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, weiwan@google.com,
        yajun.deng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit d16e6d19ccc6d3aa6b96d6a8fdb9e04fb9dffdbd
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Wed Oct 6 01:09:33 2021 +0000

    Bluetooth: hci_vhci: Fix calling hci_{suspend,resume}_dev

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14d40c1f700000
start commit:   03fa8fc93e44 Merge branch 'remove-virt_to_bus-drivers'
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16d40c1f700000
console output: https://syzkaller.appspot.com/x/log.txt?x=12d40c1f700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e95eee1a1aa4fb4
dashboard link: https://syzkaller.appspot.com/bug?extid=736f4a4f98b21dba48f0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1239a4e4f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a4b3b8f00000

Reported-by: syzbot+736f4a4f98b21dba48f0@syzkaller.appspotmail.com
Fixes: d16e6d19ccc6 ("Bluetooth: hci_vhci: Fix calling hci_{suspend,resume}_dev")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
