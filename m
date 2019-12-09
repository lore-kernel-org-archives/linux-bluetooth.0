Return-Path: <SRS0=WaXy=Z7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CADC2BD09
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Dec 2019 06:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050302071E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Dec 2019 06:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLIGUC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:20:02 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:46620 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfLIGUC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Dec 2019 01:20:02 -0500
Received: by mail-io1-f69.google.com with SMTP id b186so10032291iof.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Dec 2019 22:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ib3fib3sKuBIkbtv5x2t+C/s5FzxvHK11gS8z3pdu9M=;
        b=Hx3wLD5AzTOdwGqGw6K1c5u2jIB2IatD1WsYQrJympANWQFdsOUtbybSHQPpSWrrfy
         tAAuqLqzUys4Dm2IACkCdoJZLH9xQ42OjvjFXqghWOREUonPo6ep+BJoQLNZnu0oIJpC
         5zQAJMh1VDV2czCtVC3HafvQ94qfm6OXOgcQG+pzGpDYji8lJdJaeESfB9WH/FUGU6l8
         IRGzqEHCIof5k8NentXXuvpfE0nBHPPkaviyC9Aqmrte+9EQ4xM9Moqx0CQLdQYxiPPp
         GEQQ8fwjzWC1PpCgjGjc4rNiThE69E1HGhmGlrZsKnvH0V/qVRyyxEraAGtioaHVCi3c
         0rZA==
X-Gm-Message-State: APjAAAVly67CpEFmz0/1Sp2/H0mXN1RAyOi+MuzVYVm+mi5f0hMER6Wq
        evFiXYYyBPdvDH2G2iSKrvKjVyFZvk5I9q2o6O/8UIqug0NY
X-Google-Smtp-Source: APXvYqxt5xSP7tbAVzuFhg+Ac4ya+TgZhTpk2Zr7W851b8K8a2VkPVv4m82Tfhoq72Q7Q0DHIeS8xNIuP9bQPMwA3Lj5vvagzqgz
MIME-Version: 1.0
X-Received: by 2002:a92:3984:: with SMTP id h4mr25241387ilf.36.1575872401339;
 Sun, 08 Dec 2019 22:20:01 -0800 (PST)
Date:   Sun, 08 Dec 2019 22:20:01 -0800
In-Reply-To: <000000000000bcd434057f4eb905@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b17fae05993f628b@google.com>
Subject: Re: WARNING in tty_set_termios
From:   syzbot <syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, gustavo@padovan.org,
        johan.hedberg@gmail.com, jslaby@suse.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@intel.com, marcel@holtmann.org, mhjungk@gmail.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        vdronov@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit b36a1552d7319bbfd5cf7f08726c23c5c66d4f73
Author: Vladis Dronov <vdronov@redhat.com>
Date:   Tue Jul 30 09:33:45 2019 +0000

     Bluetooth: hci_uart: check for missing tty operations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b20aeae00000
start commit:   66c56cfa Merge tag 'remove-dma_zalloc_coherent-5.0' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b05cfdb4ee8ab9b2
dashboard link: https://syzkaller.appspot.com/bug?extid=a950165cbb86bdd023a4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121cee07400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fdaed8c00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: Bluetooth: hci_uart: check for missing tty operations

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
