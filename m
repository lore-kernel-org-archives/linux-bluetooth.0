Return-Path: <SRS0=3CUk=BL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA988C433E3
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Aug 2020 00:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C14DF20789
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Aug 2020 00:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgHAARH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Jul 2020 20:17:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:45614 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgHAARH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Jul 2020 20:17:07 -0400
Received: by mail-io1-f70.google.com with SMTP id p17so18962310iod.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2020 17:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=EeowjFs3ag00jmXysHEViINXb8Feznj0QWnCDc8JX9k=;
        b=GA18wfOqacdk5rVPKqZWcp2SfpRkSuhz/ueA0TZHxs8QL61EJIuScmqZjz8GwWNWAN
         26XDmlJqR+wJMsuBMiW5XiLAbV8JeiA2eOpkYAmqqtOUx1SdH4TojUAmQXjEC0/YCOVQ
         t0OeKt3+K4QHTpklg/V//5wERKS+iiItZGzFOZuJkzWIwpUrD5ZERGGQDm83J3MRD7zF
         d96FEvtn8vPx0yiqy/B507fkilpg8F5IkgjFlm72npi1Ap0Y7JFDlC1D3CwHngMdvVie
         aw55dacmG9AId1rk2DR6ruQFwXgkRzOoq08pDF7p7ki7bEdeW7ZtQzSVQ3W2oSfoWKxM
         yW8A==
X-Gm-Message-State: AOAM530XKrY+xrbQtKcmqhUW5YnGJBlMySKnRzLsZ400M//LoJ3Taddw
        4Asc4QG6sQZHyU58YUAs2XUxCx9qRncIJbqbIJkM6oGNy+Oy
X-Google-Smtp-Source: ABdhPJyUdXAO2hc9zkb+flLDdicREQ1MO5ek2xuunUaYgAh3EJco6GeHhbiRHe9n9Y2O1M10MBJzTxGwK5OnmfSGd22hGobEilwF
MIME-Version: 1.0
X-Received: by 2002:a5d:8a0c:: with SMTP id w12mr5949284iod.63.1596241026434;
 Fri, 31 Jul 2020 17:17:06 -0700 (PDT)
Date:   Fri, 31 Jul 2020 17:17:06 -0700
In-Reply-To: <000000000000f796a105abbfa33d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b507905abc5d32f@google.com>
Subject: Re: INFO: trying to register non-static key in skb_queue_purge
From:   syzbot <syzbot+99efc1c133eff186721a@syzkaller.appspotmail.com>
To:     andrew@lunn.ch, davem@davemloft.net, hkallweit1@gmail.com,
        jakub.kicinski@netronome.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit 65b27995a4ab8fc51b4adc6b4dcdca20f7a595bb
Author: Heiner Kallweit <hkallweit1@gmail.com>
Date:   Mon Aug 12 21:52:19 2019 +0000

    net: phy: let phy_speed_down/up support speeds >1Gbps

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1327ef50900000
start commit:   83bdc727 random32: remove net_rand_state from the latent e..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a7ef50900000
console output: https://syzkaller.appspot.com/x/log.txt?x=1727ef50900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e59ee776d5aa8d55
dashboard link: https://syzkaller.appspot.com/bug?extid=99efc1c133eff186721a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12429014900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12dbc404900000

Reported-by: syzbot+99efc1c133eff186721a@syzkaller.appspotmail.com
Fixes: 65b27995a4ab ("net: phy: let phy_speed_down/up support speeds >1Gbps")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
