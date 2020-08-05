Return-Path: <SRS0=twEk=BP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E489FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 20:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08F822B42
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 20:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgHEUHX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:07:23 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51842 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgHEQdI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Aug 2020 12:33:08 -0400
Received: by mail-io1-f69.google.com with SMTP id l1so31948675ioh.18
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2020 09:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xdDF8KAwPeDbsdN5hACSBVSNt3eeL93Vn3ZE06PW0ws=;
        b=Q2H/pe1XDzyd1GLPT2YihSl7c5opc/ZSq6u3aoZgbu+xtM0tFVFi7Enp1+cbiWoD4m
         rCGxCfbuPtf3jqADhueqAfVPUEiJQwcHXki17uFy3iOGIk0TsYHcRpBSXzc7tjgZnJCo
         j94d4wJE9q9AjwUs+D7jjMjC+d2ZZtaZsoqStpzORvkrPqEljjeljNtzfaaa90sAN3lM
         wYG+Relh6soUkTEHkBEKF2in3JRsSRNaep37/wmudyA6ae0ZzMAgwG/rrrekZEdRRqQi
         NQp1aKK1HefGct7C+H2hvbRd9H3RoPbwTwta1ZgnCr1M37y8Q50CYcr9XxN44jzhMsbx
         5Dlw==
X-Gm-Message-State: AOAM530IYDEB6t0X2uTqs0D0szJV8pgveCW1ZeyPNKMoDjcn7Xy1D+yD
        CtHiyxK8DpP2Fuo+WUlYInB3XxtE6SuISJcgcrOmd0A3PRet
X-Google-Smtp-Source: ABdhPJx1bzir56joK2ABAxtH0sKqUYFQk87L5ebinbPqcd6dHIycZoH3GBn4mZAYZSuRbVEjVUHzKuZ7t4g9wSnDVEVr5CKihhk0
MIME-Version: 1.0
X-Received: by 2002:a6b:ba06:: with SMTP id k6mr4243404iof.101.1596645187111;
 Wed, 05 Aug 2020 09:33:07 -0700 (PDT)
Date:   Wed, 05 Aug 2020 09:33:07 -0700
In-Reply-To: <00000000000023efa305ac1b5309@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035d35105ac23ed6d@google.com>
Subject: Re: WARNING: refcount bug in l2cap_global_chan_by_psm
From:   syzbot <syzbot+39ad9f042519082fcec9@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, edubezval@gmail.com,
        johan.hedberg@gmail.com, kaber@trash.net, kadlec@blackhole.kfki.hu,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        marcel@holtmann.org, mchehab@kernel.org, mchehab@s-opensource.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit 3c1e300966d7edc380e405b3ab70b6e3c813a121
Author: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date:   Tue Oct 18 19:44:12 2016 +0000

    [media] si4713: don't break long lines

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108f4002900000
start commit:   c0842fbc random32: move the pseudo-random 32-bit definitio..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=128f4002900000
console output: https://syzkaller.appspot.com/x/log.txt?x=148f4002900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76cacb0fe58c4a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=39ad9f042519082fcec9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14491b04900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1188e392900000

Reported-by: syzbot+39ad9f042519082fcec9@syzkaller.appspotmail.com
Fixes: 3c1e300966d7 ("[media] si4713: don't break long lines")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
