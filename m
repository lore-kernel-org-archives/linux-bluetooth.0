Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7655BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 18:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A57610A2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 18:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346776AbhIBSOK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 14:14:10 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52823 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346886AbhIBSOG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 14:14:06 -0400
Received: by mail-io1-f72.google.com with SMTP id e18-20020a6b7312000000b005be766a70dbso1966402ioh.19
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Sep 2021 11:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SKqbmxS+RsaX2s2wlkIqfPl2jpAwEZUOKc/WPcjCCI4=;
        b=gfRc4HZ949nQRhcdpxv2j5coyhZt3aYwoMBIRCxwhnVNMBOynth5hjtD1rz0CyN64u
         XhZE8+t80KqvdWxm2upzc7LPWvbe434tnb1oSRsR5RmkK/FVjHIN4mtVO3GN67C+Cpux
         SdyVQi19HZcqKyU/aad6nYFp5oV1nzf0xBG5FIZ95GD27kKL1/3wllG4zhkt4yT7jiW0
         GUpJbVrTOoa4fxSBbJDGzQT+Uuw5J9LkadWkL6bxXQ/LxmUUXjHnMcZH24kyl7C8aJ9r
         BMLlnXUc/w+bebMtYqBWsQHTJtgEKhESUJdC/O9p8PKO1zsEhA4tA+FP/UPXDrHpLWW9
         KVhw==
X-Gm-Message-State: AOAM532ez0qWxWv4dCZu4ReycDGel0HLDIETRy53rzmYTw0bfwDkXSdK
        ees3gnL5GEQsg+LsRti4onw2awnrfuM5ouNiU55dHIEFD+s2
X-Google-Smtp-Source: ABdhPJwD0D7+AptQ8EA9ckgdTuikiRxn9vuAi6y42y6HBFgaRe792GZ/6WBHMCptEET95qkqIwwzNODir9aTMaslfmsTvAlBugdE
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:: with SMTP id h28mr3424101ila.266.1630606387606;
 Thu, 02 Sep 2021 11:13:07 -0700 (PDT)
Date:   Thu, 02 Sep 2021 11:13:07 -0700
In-Reply-To: <00000000000034712e05ca9741e8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080826005cb07223c@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Write in __pm_runtime_resume
From:   syzbot <syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com>
To:     abhishekpandit@chromium.org, apusaka@chromium.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        hildawu@realtek.com, johan.hedberg@gmail.com, kuba@kernel.org,
        len.brown@intel.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        pavel@ucw.cz, rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit 66f077dde74943e9dd84a9205b4951b19556c9ea
Author: Archie Pusaka <apusaka@chromium.org>
Date:   Fri Jul 23 11:31:55 2021 +0000

    Bluetooth: hci_h5: add WAKEUP_DISABLE flag

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17258e45300000
start commit:   835d31d319d9 Merge tag 'media/v5.15-1' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14a58e45300000
console output: https://syzkaller.appspot.com/x/log.txt?x=10a58e45300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d793523866f2daea
dashboard link: https://syzkaller.appspot.com/bug?extid=7d41312fe3f123a6f605
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17608125300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17465ffe300000

Reported-by: syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com
Fixes: 66f077dde749 ("Bluetooth: hci_h5: add WAKEUP_DISABLE flag")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
