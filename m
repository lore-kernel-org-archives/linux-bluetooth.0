Return-Path: <SRS0=CT7E=5E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8CFC4332E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Mar 2020 03:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F53A20732
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Mar 2020 03:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCSDsE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 23:48:04 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:39630 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCSDsE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 23:48:04 -0400
Received: by mail-io1-f72.google.com with SMTP id v1so693004ioh.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2020 20:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SpBeUK2orl3lUtegDDRgAX6bK+lg6ieBHaAyzRYeyGA=;
        b=nC82eJHpb3XnhH+66MmlM0khoolXjVyCFyzXUYIM5SX/2uNqxGrce+l/Xp04vUix8p
         5CE38iIlG/UcAXWxoGvOH0Zt+Hnb6JVzMP+zGKQFJfBGNeYWf6Q6lOAy2WRjbOClxbdX
         3/Ypl4oNcYT9XYM9yAwM1o2Lo2VXEV5NqAPvNW6C9LomG7SriB4RV3ivbCrx3iCf9zbe
         5h1lyX3KOScR/MjEW2mMolJw8OfNqpjZPPF7NbL+XwkuvuQn71plNKXk1zpW50mTUzRa
         aYsZJnZiAnSyCoSCTrrMOymsbqC9cPbaplOR7smIlvmQxHohebMaXkLLLVgOYK5Vy4bM
         S2qg==
X-Gm-Message-State: ANhLgQ0wfPb6zBN36MSaQPxNO7+gUUaD7ahckY1pTmUY7g8K5tA3b5k+
        XHtF5WHDE36xCDH30AYch0U5BPfknV8zTY1D6852lwHNH62G
X-Google-Smtp-Source: ADFU+vtAqpV2toYMJI1H1/XR+TOZKvYNkhMIxgEtDGnrlXdoP64XOFRaf7cN3dp14rKVDullA28btJ42rJrNIWtZ6zbZrqwkAWR6
MIME-Version: 1.0
X-Received: by 2002:a02:940d:: with SMTP id a13mr1290318jai.23.1584589683036;
 Wed, 18 Mar 2020 20:48:03 -0700 (PDT)
Date:   Wed, 18 Mar 2020 20:48:03 -0700
In-Reply-To: <000000000000da6059059fcfdcf9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c1d4405a12d0975@google.com>
Subject: Re: KASAN: use-after-free Read in skb_release_data (2)
From:   syzbot <syzbot+a66a7c2e996797bb4acb@syzkaller.appspotmail.com>
To:     davem@davemloft.net, grundler@chromium.org, hayeswang@realtek.com,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        pmalani@chromium.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this bug to:

commit 5f71c84038d39def573744a145c573758f52a949
Author: Prashant Malani <pmalani@chromium.org>
Date:   Tue Oct 1 08:35:57 2019 +0000

    r8152: Factor out OOB link list waits

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f5b973e00000
start commit:   63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17f5b973e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f5b973e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=a66a7c2e996797bb4acb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c25a81e00000

Reported-by: syzbot+a66a7c2e996797bb4acb@syzkaller.appspotmail.com
Fixes: 5f71c84038d3 ("r8152: Factor out OOB link list waits")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
