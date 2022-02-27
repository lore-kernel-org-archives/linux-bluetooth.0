Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1765BC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Feb 2022 07:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiB0Hxv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Feb 2022 02:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiB0Hxt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Feb 2022 02:53:49 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586D0632C
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 23:53:13 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id m3-20020a056e02158300b002b6e3d1f97cso6676859ilu.19
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 23:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8x4prQR53xKdTVGUoxh3U1NM4w8xxnpghylkDWISnKI=;
        b=Ojj3qC4EVorLsNx2qPnSFg9g5EwTCtr5Roysx5zPBoud0F1R6aAVuOjXqscXwUqrrH
         oJ75mGYkTYnMwVZews2A6wDBe/xtHTiLEFET+hkrRNse7EU1kaL4zdMwn8p1AqYjiSm4
         RSIYMTWGqNl1GruGKb0lfJpJzpFZA7jWSK1jnAPPorapTDz8Kk0fh8kE2e7/CcLWo++6
         WfHETPMys0Crbz81VaWjcAn/PQvo2rOUl6zB4n4V8YmnW0nEsmWSx+NmHgwjvCY/f1/W
         h9nIqXeMhAWkb/qBJK8FvUskSQGl3yXRYGFvKHHf56YQnMcnKghaA+E7hyKFwVFZUPWQ
         J9BA==
X-Gm-Message-State: AOAM532lscA/H0V7yPAtna+HBH4enTd23ENd2JejOXGnq+SAJjdKdIN5
        /BsAtR/7vtINAX4j4OAh+/DXEL5Bp1P4sywwma/ZoUh5R91m
X-Google-Smtp-Source: ABdhPJwnM//x289HcGWdyw6/MGcyPjreaVsnsQEtDClJ29ZCA4H62iYtHU111CI/dde+EtOVB0pSCgrO2DM1+90IGs0rgaCC8QmS
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3409:b0:641:a051:df23 with SMTP id
 n9-20020a056602340900b00641a051df23mr11607999ioz.98.1645948392694; Sat, 26
 Feb 2022 23:53:12 -0800 (PST)
Date:   Sat, 26 Feb 2022 23:53:12 -0800
In-Reply-To: <20220227074046.2963-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043e8b805d8fb398c@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in sco_sock_timeout
From:   syzbot <syzbot+2bef95d3ab4daa10155b@syzkaller.appspotmail.com>
To:     desmondcheongzx@gmail.com, hdanton@sina.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2bef95d3ab4daa10155b@syzkaller.appspotmail.com

Tested on:

commit:         922ea87f ionic: use vmalloc include
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f802340579dda19
dashboard link: https://syzkaller.appspot.com/bug?extid=2bef95d3ab4daa10155b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134f85da700000

Note: testing is done by a robot and is best-effort only.
