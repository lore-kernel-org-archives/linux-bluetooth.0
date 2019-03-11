Return-Path: <SRS0=ax5w=RO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4BDC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 13:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A194D20657
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 13:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCKNVE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:21:04 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:54131 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbfCKNUB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Mar 2019 09:20:01 -0400
Received: by mail-io1-f71.google.com with SMTP id w11so2932614iom.20
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2019 06:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=XWXyMv0OkppzDtuTxi6zaQw/Ven1ks4fo6kqpXPB2G0=;
        b=qecMYZO44yTzRfmlUAgkTB4dKuUpFu7zx9N/O8Ht1L2ECgQGiFjL64nVXlXsqeOP+1
         nqSst9anB0A4sYOTLphsPIrqVyEofCNN6CqdyGUo3PeGazH3KpaOLQjnpRN5v0GDe+0v
         niNIaHnWxl/NvlJO9Ty9kVrjlkzf3vYX2k5ar3Xz9/3HaODLQ6HLCm684+AXyFuoxKfK
         xqgDgOivqVrSlrSKXdfPQ6nauGoJyCZ5AJ48EN0gskStGyiPna8743cwxyhMAdaRgtL2
         RHmTtg8VtqqV16batBDeB4vXfsSISpAvHk/3esGz5f4WZqldaQDdxq9LcmwdoXB+djKh
         LVDg==
X-Gm-Message-State: APjAAAXns0u1wfa0rcATkc0Qbmy7L3XHOLZSosW2oneL3SPUtRAxqZ2G
        Ur1yBJIeTy4GsCSjBbX7HzJDFmkY4vWyAbZ5Inv5G8y3ZeWW
X-Google-Smtp-Source: APXvYqzvhKDQZnwTiSr0Wufsyf3Ob+nH38/hpmwq2nR4LtR1G5at6dSDOmYgtarPwhl2UFaxehHX7w7oRrW7gRkUD1UggK1/+QLP
MIME-Version: 1.0
X-Received: by 2002:a24:334a:: with SMTP id k71mr20549923itk.14.1552310400655;
 Mon, 11 Mar 2019 06:20:00 -0700 (PDT)
Date:   Mon, 11 Mar 2019 06:20:00 -0700
In-Reply-To: <000000000000b9e68e0581142f19@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000032b7f0583d16e0e@google.com>
Subject: Re: general protection fault in skb_put
From:   syzbot <syzbot+65788f9af9d54844389e@syzkaller.appspotmail.com>
To:     axboe@fb.com, hch@lst.de, james.smart@broadcom.com,
        johan.hedberg@gmail.com, jsmart2021@gmail.com,
        keith.busch@intel.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        marcel@holtmann.org, sagi@grimberg.me,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this bug to:

commit 97faec531460c949d7120672b8c77e2f41f8d6d7
Author: James Smart <jsmart2021@gmail.com>
Date:   Thu Sep 13 23:17:38 2018 +0000

     nvme_fc: add 'nvme_discovery' sysfs attribute to fc transport device

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=121f55db200000
start commit:   97faec53 nvme_fc: add 'nvme_discovery' sysfs attribute to ..
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=111f55db200000
console output: https://syzkaller.appspot.com/x/log.txt?x=161f55db200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59aefae07c771af6
dashboard link: https://syzkaller.appspot.com/bug?extid=65788f9af9d54844389e
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178e0798c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b4f0b0c00000

Reported-by: syzbot+65788f9af9d54844389e@syzkaller.appspotmail.com
Fixes: 97faec53 ("nvme_fc: add 'nvme_discovery' sysfs attribute to fc  
transport device")
