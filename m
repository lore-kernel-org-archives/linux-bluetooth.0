Return-Path: <SRS0=2wua=CN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C927BC43461
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Sep 2020 14:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91954206F2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Sep 2020 14:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbgIDOoO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:44:14 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:52007 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbgIDOoK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Sep 2020 10:44:10 -0400
Received: by mail-io1-f77.google.com with SMTP id q12so4421532iob.18
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2020 07:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GE20mkCJFx34V9csXbBi5MpSPEm23j5O5gEKMXhuGs4=;
        b=jTxTV3FSjJPPYofjYJrVk43LQrfKGwPrA+Vjot0+fx7Ymm/iWFUX+y6/+g34qRkKyu
         LLpDMOof1FDUbqCdPmc0FjCJ5XKSO3JWnN/4a3wpjWdVrKx9gUeqUhnQ44fbwDltAeSy
         1rGGsomwpIVe4CI4n0Gcp36l3b48ZILA1Wd4soJTGDlan0FzRm7Km62ArxE2fo5QgDmG
         ofhSWce7UU20kRRTsRqO28QVulJnM0k5vQvWD8fEKA1ykEgt26FJMBWIXPbYbWh3kvKI
         9/S7p91UnnR4Jh+XdVlvFJJNY6IGO7W6Wi6iH0kDcsAg8wjvD6to9ufJqTroc59pLCkB
         u3tQ==
X-Gm-Message-State: AOAM533cd3V59D88TLcfGPJ/YyyZByLYFo+buWgkxwt1WwzF1L6F3ebN
        SLeWfpB4cB3LVjHgnqijffHtKpSfXQc/F1kHM1kZTEj+fEEn
X-Google-Smtp-Source: ABdhPJxZCmzJJSBtD6oipaJudDBJ1GQFFB0c3Y+RmR7v/iFXEsAA2X6Ph+jfCB/546LXa6E6JWGbeRIObehShZ2GPeZnQjV295Tv
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1303:: with SMTP id g3mr4832562ilr.218.1599230649567;
 Fri, 04 Sep 2020 07:44:09 -0700 (PDT)
Date:   Fri, 04 Sep 2020 07:44:09 -0700
In-Reply-To: <00000000000055e1a9059f9e169f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8101605ae7de686@google.com>
Subject: Re: KASAN: use-after-free Write in refcount_warn_saturate
From:   syzbot <syzbot+7dd7f2f77a7a01d1dc14@syzkaller.appspotmail.com>
To:     abhishekpandit@chromium.org, alainm@chromium.org,
        davem@davemloft.net, johan.hedberg@gmail.com,
        johan.hedberg@intel.com, josua.mayer@jm0.eu,
        jukka.rissanen@linux.intel.com, keescook@chromium.org,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        mcchou@chromium.org, mike@foundries.io, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b83764f9220a4a14525657466f299850bbc98de9
Author: Miao-chen Chou <mcchou@chromium.org>
Date:   Tue Jun 30 03:15:00 2020 +0000

    Bluetooth: Fix kernel oops triggered by hci_adv_monitors_clear()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f92e3e900000
start commit:   c0842fbc random32: move the pseudo-random 32-bit definitio..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf567e8c7428377e
dashboard link: https://syzkaller.appspot.com/bug?extid=7dd7f2f77a7a01d1dc14
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b606dc900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123e87cc900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Fix kernel oops triggered by hci_adv_monitors_clear()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
