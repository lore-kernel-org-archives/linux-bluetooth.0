Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686B5C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Nov 2022 05:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKEF1U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Nov 2022 01:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKEF1T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Nov 2022 01:27:19 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E942E69E
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Nov 2022 22:27:18 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id l4-20020a056e021aa400b00300ad9535c8so5171101ilv.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Nov 2022 22:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ASnNDxhoqSLaBjncwLtyuIp6tFD08p3uNjxVPZiJKI=;
        b=m+ZN/3EVF89OTlJOGwGnYGXHVhwEM6ke8TSrjFNQL+HmcApHvU/0E1xsmN7b0Eh6YJ
         XLXyucpP+mBBGW1lYtmKpaPYm6wis7Vc3A5Q9z/xU0BzFc+coqS/chfOxuH85dI5efl5
         xPd0yew3bq9tJ92Oi59fYb9/OPa4nXGmBhYiAQnW8ELbyElQGpq7EkoW/ra0tmRWA4Ll
         MQW0GovmIJpcDeKHZjzrfG0mUrr/w8IOk3ojrhAO7BVjHIEY23RTm/J0lP/UZrvyXlkY
         Kpc8EmP/XBNCNNWST6/QWZf/otQC6z+S92wO7yPHeTLQ57SIiaKr66Wg9EU7+4I4F2EB
         heXA==
X-Gm-Message-State: ACrzQf0Z4/vbT4TQ73cANhNIxgjnCYg70N0fZLaoABuoHD0s8df42r04
        CEdTkNqgFv89flKm0i7v2a9rHZVJGUPO82prmeWZxZ+0jr6l
X-Google-Smtp-Source: AMsMyM6VWI4Vk3WRzJfNJhb6um+SW7Ecd5WwtI1YxMBLKoya+XpAkwf4Adj2jolavy1c/SExku6Efe+lBuQpH9G+Y3dNw75iPtHB
MIME-Version: 1.0
X-Received: by 2002:a02:a00f:0:b0:375:7166:2dac with SMTP id
 a15-20020a02a00f000000b0037571662dacmr14017102jah.49.1667626037516; Fri, 04
 Nov 2022 22:27:17 -0700 (PDT)
Date:   Fri, 04 Nov 2022 22:27:17 -0700
In-Reply-To: <00000000000041f5bc05e678fa9f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000959e6405ecb271a3@google.com>
Subject: Re: [syzbot] WARNING in __cancel_work
From:   syzbot <syzbot+10e37d0d88cbc2ea19e4@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 2d2cb3066f2c90cd8ca540b36ba7a55e7f2406e0
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Sat Sep 3 15:32:56 2022 +0000

    Bluetooth: L2CAP: initialize delayed works at l2cap_chan_create()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1469d541880000
start commit:   7ebfc85e2cd7 Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=20bc0b329895d963
dashboard link: https://syzkaller.appspot.com/bug?extid=10e37d0d88cbc2ea19e4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13537803080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e68315080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: L2CAP: initialize delayed works at l2cap_chan_create()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
