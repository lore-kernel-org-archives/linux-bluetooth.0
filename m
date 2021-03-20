Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7573C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Mar 2021 11:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC827619B3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Mar 2021 11:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhCTLei (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Mar 2021 07:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhCTLec (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Mar 2021 07:34:32 -0400
Received: from mail-il1-x147.google.com (mail-il1-x147.google.com [IPv6:2607:f8b0:4864:20::147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1A5C0617AA
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Mar 2021 03:38:19 -0700 (PDT)
Received: by mail-il1-x147.google.com with SMTP id o7so36269121ilt.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Mar 2021 03:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TY6eWPej2xyMujUIiW14t6MNCP0JG96Bsng7hloAJn4=;
        b=RqAbTTbBiiAE+lbJxwM27+M0rVdbKzqQj1SBwRotVbBQHtuQ19rjbTVrsfop/s8QAR
         Vreo37J2gghorn0Zxg5fGTBSqA3iGsR1exhHEFn2OOeW6wcLwO3Fee1NRNoMYn+Yqtv2
         tOAsl7JdUFqvs4nIw/Ht8WRXr+0kG9r7btDEgCBZoQrOfoF9WOFrCvLV6h21ZmBNnH7Z
         10vGrsuC7PLPujLvTfWHErDLKRwGycezGGlqDgwjkwGibhXGA24qQdQppuIHFhhvPn68
         zlkU4vCTkxkN4yvGBkUrVylz4hHb9ddnqASSRFiz5AXkHzUU3X/ipeSSXXFHIWn6QzEC
         shrQ==
X-Gm-Message-State: AOAM531C8hnDHu8jGx/PEYQwlYu33UpuTDMMXfDEL0fxPuLnu/cIRIq6
        dCXR5tAaRtHVUCpwp1FFo867JDWdk/lPvvcyOR1GM20gG6hh
X-Google-Smtp-Source: ABdhPJzd4Hj0631V/HLa6Uj7/62+FcuBi7Qtrnplas/d5g38qhibrBz0f8jwbnFRIVPYlFVkOb2/5wjN/P0+HfQ/VrrH9dXKJCjr
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2184:: with SMTP id j4mr5426084ila.308.1616228824055;
 Sat, 20 Mar 2021 01:27:04 -0700 (PDT)
Date:   Sat, 20 Mar 2021 01:27:04 -0700
In-Reply-To: <00000000000076ecf305b9f8efb1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef073a05bdf398e0@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in add_adv_patterns_monitor
From:   syzbot <syzbot+3ed6361bf59830ca9138@syzkaller.appspotmail.com>
To:     apusaka@chromium.org, dan.carpenter@oracle.com,
        davem@davemloft.net, finanzas1@logisticaenlinea.net,
        hdanton@sina.com, howardchung@google.com, johan.hedberg@gmail.com,
        johan.hedberg@intel.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, mcchou@chromium.org,
        mmandlik@chromium.org, netdev@vger.kernel.org, sashal@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b4a221ea8a1f890b50838ef389d016c7ff280abc
Author: Archie Pusaka <apusaka@chromium.org>
Date:   Fri Jan 22 08:36:11 2021 +0000

    Bluetooth: advmon offload MSFT add rssi support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ef5ad6d00000
start commit:   b491e6a7 net: lapb: Add locking to the lapb module
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=be33d8015c9de024
dashboard link: https://syzkaller.appspot.com/bug?extid=3ed6361bf59830ca9138
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10628ae8d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12964b80d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: advmon offload MSFT add rssi support

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
