Return-Path: <SRS0=twEk=BP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C761C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 07:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438622073E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 07:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgHEHbN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:31:13 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:52119 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHEHbJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Aug 2020 03:31:09 -0400
Received: by mail-il1-f197.google.com with SMTP id c84so8703023ila.18
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2020 00:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UAjlV35CqUYg8Wq8iE9joWFodTfiF9zQm++Jk44fcSY=;
        b=fFSA0ku2bKmCryeIoxfWNuwgwxe1fZqpkCiGLEEQDJKqOxqFlLAW8K3/8C7wQKmYPk
         GUzusERy5DWzHIXLsjeJ2of5CekZz4wxu5qHaCjU6arlE9sZpTuMwyUitGLu8bKBd5OI
         1sNp+/AubC/AOGlBGSBs8XWV55ZD3r4SLQAPbc6nOmpHQulJRQ3gNcHyER+d4bpDETWp
         29rr5mewOizjIxpe44sfK6dxy+4lfboJymlPx+Cq/5tpstW9H51NW7b3iLjBhBB8IePe
         foc/cSO9T8Vuqx0KOjH79CLXvPoSeIcMDqCOqe2xStNGkg+XmVabZz7I5/mp5jpAefGf
         olhQ==
X-Gm-Message-State: AOAM533E85xxJnWDDnRMDkEMWpaHMOW3PyoO1UwHhDEuc5ydoLiIREUB
        sbT+Q9KOJdo5R2g9Rm3kXImnc0ffPDh43lArjLoEqUr1OA5W
X-Google-Smtp-Source: ABdhPJydINKXG6kk6Rt5Q7YptVJc6WU2HIGHbqBbyEup0nCj4eB/muV9ogT+bIQJk1+5SdRMqrFrePgB51/EIuvRRPKG7IPv2d9A
MIME-Version: 1.0
X-Received: by 2002:a92:1b5b:: with SMTP id b88mr2679375ilb.104.1596612668103;
 Wed, 05 Aug 2020 00:31:08 -0700 (PDT)
Date:   Wed, 05 Aug 2020 00:31:08 -0700
In-Reply-To: <000000000000a39e4905abeb193f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed214e05ac1c5ae8@google.com>
Subject: Re: general protection fault in hci_phy_link_complete_evt
From:   syzbot <syzbot+18e38290a2a263b31aa0@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, johan.hedberg@gmail.com,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        kuba@kernel.org, kvalo@codeaurora.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux@armlinux.org.uk,
        marcel@holtmann.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit b59abfbed638037f3b51eeb73266892cd2df177f
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Thu Sep 15 13:30:03 2016 +0000

    mac80211_hwsim: statically initialize hwsim_radios list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15dd5f98900000
start commit:   c0842fbc random32: move the pseudo-random 32-bit definitio..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17dd5f98900000
console output: https://syzkaller.appspot.com/x/log.txt?x=13dd5f98900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf567e8c7428377e
dashboard link: https://syzkaller.appspot.com/bug?extid=18e38290a2a263b31aa0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e4e094900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1143e7ca900000

Reported-by: syzbot+18e38290a2a263b31aa0@syzkaller.appspotmail.com
Fixes: b59abfbed638 ("mac80211_hwsim: statically initialize hwsim_radios list")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
