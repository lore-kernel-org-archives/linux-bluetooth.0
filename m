Return-Path: <SRS0=W52z=EO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDB7C5517A
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Nov 2020 22:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30A4206E3
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Nov 2020 22:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgKHWzG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Nov 2020 17:55:06 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:33722 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgKHWzG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Nov 2020 17:55:06 -0500
Received: by mail-io1-f70.google.com with SMTP id d202so4495336iof.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Nov 2020 14:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Mk8JTr7hVOq3EefkDcYJtK1cseL+MNVUi7YjoZxo834=;
        b=rA3Vu57JPJe1xcs0jHt3EiLk6xWWrUmRu7zYlfmQSKLwO/1UQRvmJeMjxifIhQHXTQ
         bC71a+oU9xZopoMdYLAbB4nCInQV8bcE+3dwfk1zjYjgcft+6nXZMOJtA/S7tDmYCeSD
         SWs8u165hdDyKwV2G4q/D+5CGRclddygBpJIHH1r7d72NtuqDQvKrIgv20eZ83ZMmTl5
         Kfj3YewsLafT5qQPDNknZ43oUp0DKOH6NmB1FCS7Ci0iECVeBDDp+gUMGOcQPCJ4JPA1
         vmup9iBc8+UJqIOgqU1sCtP4RRcXNRb/rbrejRoH56F/7Pm5paldtNzjWqQRwpRrCDOv
         874Q==
X-Gm-Message-State: AOAM533qKWRgl86a/QD5vYeLNDNYHo5yTOuvDPrDcAGf/3vzKEAwyTld
        8cRDbvYUvBIjlYo+evbMgU1VJyIdEaHdRFSbXxiiAn/vr/1O
X-Google-Smtp-Source: ABdhPJz46elvAlGQb+4iBu5GDJETkvSCwZYY3fQO4J1bsg3UipRMv59OOfwhgZstYtR/XAJyLUrU+ZktTcqi0Zw4wr4tBtTIjClC
MIME-Version: 1.0
X-Received: by 2002:a02:b1cb:: with SMTP id u11mr8883124jah.95.1604876105313;
 Sun, 08 Nov 2020 14:55:05 -0800 (PST)
Date:   Sun, 08 Nov 2020 14:55:05 -0800
In-Reply-To: <000000000000c57f2d05ac4c5b8e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a736805b3a05697@google.com>
Subject: Re: BUG: corrupted list in kobject_add_internal
From:   syzbot <syzbot+dd768a260f7358adbaf9@syzkaller.appspotmail.com>
To:     abhishekpandit@chromium.org, coiby.xu@gmail.com,
        davem@davemloft.net, dvyukov@google.com,
        gregkh@linuxfoundation.org, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        netdev@vger.kernel.org, rafael@kernel.org,
        sonnysasaka@chromium.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a46b7ed4d52d09bd6c7ab53b2217d04fc2f02c65
Author: Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri Aug 14 19:09:09 2020 +0000

    Bluetooth: Fix auto-creation of hci_conn at Conn Complete event

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d75792500000
start commit:   d6efb3ac Merge tag 'tty-5.9-rc1' of git://git.kernel.org/p..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff87594cecb7e666
dashboard link: https://syzkaller.appspot.com/bug?extid=dd768a260f7358adbaf9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105054aa900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ab6976900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Fix auto-creation of hci_conn at Conn Complete event

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
