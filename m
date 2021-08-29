Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF92C4320A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 08:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5399D60462
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 08:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbhH2IwG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Aug 2021 04:52:06 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:55232 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbhH2IwG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Aug 2021 04:52:06 -0400
Received: by mail-il1-f200.google.com with SMTP id r6-20020a92c506000000b002246015b2a4so6890794ilg.21
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Aug 2021 01:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VRjZ55btMfZrqeGahP9upV/+bb8bMaX/8gs+6OMv40U=;
        b=hBfc3Af3w55m5HRS1PJU2R48Yrzt/rsNuaw8Mlrm8/1rldp63JTrQYJAW7/jewrtHi
         vA3gTqx3pj7B9LffUmU9o5x32RmYW9fxIi2ShKRXAvh9ztJUo5OdXSb4ZG8szDeb3IkT
         hCi/2+hz3Rue4B5hn6L2deuM3FhneLh8OyqRXI4dT2rCwwLshQ/ARcnEMuzrgxI1pmlq
         0C6iCJR2WK9IOkqux4pNwOIy3XjnUyvAIm79fxzZjCsgRSeRHNb/bSRpz0+koAv/zGj3
         rHGpaaBDnx+Ro0GsGqcom3FUfuInbOUQo5r4GQ6e2dSHpDwqU3OWlSkzd8eqsbWAQtd5
         x0AQ==
X-Gm-Message-State: AOAM531aOzAt2vS6Nu7SuL8xzlYgLPzDtwA6976AoCSUmRDUTpi5YJBh
        c0JgkYddsACWmaLXND8DisgO2jlLHYectAmBiXV1xr+Dpm7F
X-Google-Smtp-Source: ABdhPJyVvN8oXQt2MGRND3Pgy/bPaDyFUxLOI1Jcv0MmI3Hmw64p195vbuwVSUMPjj0r0mqcTW/w/loewrn56mynJQND8yznsIDX
MIME-Version: 1.0
X-Received: by 2002:a05:6602:340a:: with SMTP id n10mr12067086ioz.188.1630227074389;
 Sun, 29 Aug 2021 01:51:14 -0700 (PDT)
Date:   Sun, 29 Aug 2021 01:51:14 -0700
In-Reply-To: <20210829082929.2897-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac212205caaed18a@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in sco_sock_timeout
From:   syzbot <syzbot+2bef95d3ab4daa10155b@syzkaller.appspotmail.com>
To:     desmondcheongzx@gmail.com, hdanton@sina.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.von.dentz@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2bef95d3ab4daa10155b@syzkaller.appspotmail.com

Tested on:

commit:         e3f30ab2 Merge branch 'pktgen-samples-next'
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef482942966bf763
dashboard link: https://syzkaller.appspot.com/bug?extid=2bef95d3ab4daa10155b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=108523fe300000

Note: testing is done by a robot and is best-effort only.
