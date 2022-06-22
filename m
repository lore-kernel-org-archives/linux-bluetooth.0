Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF6AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 19:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376300AbiFVTnN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 15:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359347AbiFVTnL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 15:43:11 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8741013E27
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 12:43:09 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id b11-20020a92340b000000b002d3dbbc7b15so11656999ila.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 12:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4OG3JNBrKZLM5Nj65eYO+3GhL5W3BfIxkELhNmo04tU=;
        b=yR76Ve+2tcHeGF0dMqc2ONb7XLfZYUxK6iW9V7X06eFCfuXtAhi0o8VeCilJ91Y4sE
         uo5SkraoxP19EOAmO1pjCo6oryYrzO1T+vPzL9KmTse0d2g9hpsRpw/BHy1abxFOuuYl
         qJzG/gYNeOWEDMT7H3nVNzSbKawMqmp4vy1ltATVflS0kwqSJB7o1CZD983bd5RKZ2Dt
         tgeSi13qAxuc6pOvxfAYuNPIMkDJUk9S9kcPMbgwlBXBeHyy068WMEwUiyUDZUFGCUCC
         vvprmrTkaRwhfVAzCOa/dsWQ3tmd8VDDPBPVgw8SrQ+CBAkgpXvaJkKEE8c+G46pUIRl
         MTIQ==
X-Gm-Message-State: AJIora/7PGNttXp8RuLLgDgl/Oyt3dgARukDsT19qCHxs34V9QL1Ijvx
        0PqcxfifixSfpWLkEWS/rlJKJ7bo4me9bLWlqtaIgxNglP01
X-Google-Smtp-Source: AGRyM1tWX1L/At4A4DeZPe1TDB+uFjQewlzP9hHMsstdwwNphBkwnvetr+rGJG2CdxKpB9VzzNafv8p3hXEeIlPx0GLeSO17pEGo
MIME-Version: 1.0
X-Received: by 2002:a05:6638:5:b0:339:e628:b96c with SMTP id
 z5-20020a056638000500b00339e628b96cmr533882jao.203.1655926988375; Wed, 22 Jun
 2022 12:43:08 -0700 (PDT)
Date:   Wed, 22 Jun 2022 12:43:08 -0700
In-Reply-To: <000000000000113adf05e0704621@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea8d3305e20e8bfa@google.com>
Subject: Re: [syzbot] INFO: task hung in hci_power_on
From:   syzbot <syzbot+8d7b9ced2a99394b0a50@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1674ba1ff00000
start commit:   9d004b2f4fea Merge tag 'cxl-for-5.19' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1574ba1ff00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1174ba1ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c367f7c347f1679
dashboard link: https://syzkaller.appspot.com/bug?extid=8d7b9ced2a99394b0a50
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103f3755f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f4cf3df00000

Reported-by: syzbot+8d7b9ced2a99394b0a50@syzkaller.appspotmail.com
Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
