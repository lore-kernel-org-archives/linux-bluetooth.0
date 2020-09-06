Return-Path: <SRS0=/VTe=CP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973B9C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Sep 2020 05:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3602075A
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Sep 2020 05:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgIFFbJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Sep 2020 01:31:09 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:44748 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgIFFbI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Sep 2020 01:31:08 -0400
Received: by mail-il1-f208.google.com with SMTP id j11so7837420ilr.11
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Sep 2020 22:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=AkAlyJgLNh08fM+adXYaVRQxqHnsf7ozrxDfshPlvlo=;
        b=jlzYQ/qt9MpyZR4TR6gMqqOHhYAdcVYF1po60zuYye/2hAp7iPlNR4jr1n5cXgJFIt
         QJU4M1qkyfHprYQVFp9+mwptNjDQiMs8GRuFUxWUEd7KnnoYfyK8GtcNDIUcaZ4nnZGc
         Bu4nSzy6dHdva80dnGtxr60/KExNzpR5oaZl1Feueh7hW1VCZZoBoOMKP0jPaSXqmnzz
         5J/QNkLf6J/p05FXUg0OBzft5R4N+qfehjbfqz7JJBKYodYOO9OX5H+c2vqMHt3wY0n6
         MGJji7+7IZiZ5J5qit2C+XjpBVZd4iiA10JzepTooCTMMQ/oAzSJKGb1dbFAZwfo927x
         hu2Q==
X-Gm-Message-State: AOAM532nfXPTEZ7uhuNHqe/4CFRDLfU7WosnQDMSbsXG+WKlgy6hbG4d
        yB+7Su6kgZ+JCwc71Gh/8W4tEZcDsBHaoPxI1KpFkIQolFiN
X-Google-Smtp-Source: ABdhPJwZOylw0u4Wo0Y6MQf20PT2tvuW4TXOi8u8DYia+/JL+8Tk/MjaNqQtmwfTZ13rTOIRf/mXOEYmGdgD6b9BLhL/1p4LDdw/
MIME-Version: 1.0
X-Received: by 2002:a92:99cb:: with SMTP id t72mr14005144ilk.172.1599370267186;
 Sat, 05 Sep 2020 22:31:07 -0700 (PDT)
Date:   Sat, 05 Sep 2020 22:31:07 -0700
In-Reply-To: <0000000000008b9e0705a38afe52@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3de6505ae9e6831@google.com>
Subject: Re: WARNING: refcount bug in do_enable_set
From:   syzbot <syzbot+2e9900a1e1b3c9c96a77@syzkaller.appspotmail.com>
To:     Markus.Elfring@web.de, abhishekpandit@chromium.org,
        alainm@chromium.org, davem@davemloft.net, hdanton@sina.com,
        johan.hedberg@gmail.com, koulihong@huawei.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, mcchou@chromium.org, netdev@vger.kernel.org,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115a4245900000
start commit:   fffe3ae0 Merge tag 'for-linus-hmm' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=226c7a97d80bec54
dashboard link: https://syzkaller.appspot.com/bug?extid=2e9900a1e1b3c9c96a77
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b3efea900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11131284900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Fix kernel oops triggered by hci_adv_monitors_clear()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
