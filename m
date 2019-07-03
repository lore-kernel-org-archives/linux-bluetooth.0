Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5AAC06511
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 18:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4AD21881
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 18:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfGCS0B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:26:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:49867 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfGCS0B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 14:26:01 -0400
Received: by mail-io1-f72.google.com with SMTP id x24so3505920ioh.16
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 11:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ol2oTL6I09LrbBugODTrPEcLgmAtDlXO+xFKA9FYWzI=;
        b=TtIJFqLaAO8IuPoD5fRAH2UclwVXons5bUbVweuqnFGwLM4/mohXZB/YBJQumrFpYs
         lP0+kXdv+Izmt65d3BfpADeLnRm2+oF7HCNq8pMZeXoOJ0vw4fotMLLCpTKgFzjZZgw+
         Mea/DUvbdBa2aWGI5T+eD3KEr6tLfrHgxvBpFtQf5gsd+9MQ6t5QimbwqMdjlJY5u74x
         giCJEc+eScjsonoEDDxG6SkbwC6FiQSWRYD9QbjjW9NjRB2SY5fQWMr1l82IYpkzBuZo
         6PenSW0fToGjR8FG8dUEawthZDa1Q97XIm/6mZk0P6Th2tXN5lvDP3TokXjb2UKMFRpZ
         VJDA==
X-Gm-Message-State: APjAAAVXprJg2b9vPX2ZsPmop+Fhllz9xVMceRDLocZ9GNfsrNUyaQNP
        uBUKM1L+iGl1S6fFvQFkRFVL0/fAscnhBxMIzpYiFvD7r+EJ
X-Google-Smtp-Source: APXvYqwnKz9Y5ErGzM/oENrZog1dO7eB2V3AocjmtCzYXUDUaLNQ1kAbKUGqE/0CNl8wQiJx3GqOLtHaUDhnnEPnEz2HNfDxKgvN
MIME-Version: 1.0
X-Received: by 2002:a02:c50a:: with SMTP id s10mr45090759jam.106.1562178360550;
 Wed, 03 Jul 2019 11:26:00 -0700 (PDT)
Date:   Wed, 03 Jul 2019 11:26:00 -0700
In-Reply-To: <00000000000035c756058848954a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041ac74058ccafe0d@google.com>
Subject: Re: KASAN: use-after-free Read in hci_cmd_timeout
From:   syzbot <syzbot+19a9f729f05272857487@syzkaller.appspotmail.com>
To:     chaitra.basappa@broadcom.com, davem@davemloft.net,
        jejb@linux.vnet.ibm.com, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, marcel@holtmann.org,
        martin.petersen@oracle.com, mpt-fusionlinux.pdl@broadcom.com,
        netdev@vger.kernel.org, sathya.prakash@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this bug to:

commit ff92b9dd9268507e23fc10cc4341626cef50367c
Author: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Date:   Thu Oct 25 14:03:40 2018 +0000

     scsi: mpt3sas: Update MPI headers to support Aero controllers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130ac8dda00000
start commit:   eca94432 Bluetooth: Fix faulty expression for minimum encr..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=108ac8dda00000
console output: https://syzkaller.appspot.com/x/log.txt?x=170ac8dda00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6451f0da3d42d53
dashboard link: https://syzkaller.appspot.com/bug?extid=19a9f729f05272857487
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125b7999a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176deefba00000

Reported-by: syzbot+19a9f729f05272857487@syzkaller.appspotmail.com
Fixes: ff92b9dd9268 ("scsi: mpt3sas: Update MPI headers to support Aero  
controllers")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
