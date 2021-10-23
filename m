Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7502C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Oct 2021 13:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D734603E8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Oct 2021 13:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhJWNtc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 23 Oct 2021 09:49:32 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:36541 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhJWNtb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 23 Oct 2021 09:49:31 -0400
Received: by mail-io1-f72.google.com with SMTP id x21-20020a0566022c5500b005ddd625f399so5355441iov.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 23 Oct 2021 06:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=6th7FRqhRNbP1CsZO8PDsX9c9NXk641vpSEu8kddIEc=;
        b=WEy2oQCAOcwpXxqZm/Y6syBxdJYBM6bsMqUuCFiIqXuma1ICoePDx19ZLY0neBCIeI
         /JBO2OcRESkC1r/QAYGv7gLbq8BRuD4UFZiau+RwMEiK4l3AaLbkXyFeGofKVdCvmThR
         4e5IMQwKG6Z8lGVAsJ049U7bkACRG7ke2qMIi1SllF9mutbAqS33S9iZp8MCq/O2WNS2
         eF7cMzl6yTiT8ARSdQUVUvmo4X+UZ8j/Ul6eVKmon+hcp//iWJe5iLrNyGkkVZoZOzKk
         aYABzCV+DuQO+TsKXwRmz1RMuTD3pbnAUmfULH1tmbMFFMspxE+uFMKeEVmIu6+9OEBz
         gopg==
X-Gm-Message-State: AOAM530owmoIXn57nkY1m+AW8GXru5l8s5IQZz4IzW6xi9vnPjMJcsjP
        zW4Za2YWXD7lugTd4+HGA8RU8vf2UL+6BmMl/DbMkOV80GD4
X-Google-Smtp-Source: ABdhPJwAolsosnFjYFye6ykTTlSg+G8dCRpSMML37WZ0RiyiCqDL7LK8qN5nC7KJw8ivcRihrhIAZ3bdcRjrkSsGiMhMDK+WW64x
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:de2:: with SMTP id m2mr3623066ilj.134.1634996832673;
 Sat, 23 Oct 2021 06:47:12 -0700 (PDT)
Date:   Sat, 23 Oct 2021 06:47:12 -0700
In-Reply-To: <4202176.J8ZBFPDcmx@localhost.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006baa3205cf055dd1@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in
 hci_uart_tty_receive (3)
From:   syzbot <syzbot+f2725165900304ec97b6@syzkaller.appspotmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     fmdefrancesco@gmail.com, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> On Saturday, October 23, 2021 1:54:24 AM CEST syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    519d81956ee2 Linux 5.15-rc6
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=16787178b00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=1f7f46d98a0da80e
>> dashboard link: https://syzkaller.appspot.com/bug?
> extid=f2725165900304ec97b6
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils 
> for Debian) 2.35.2
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the 
> commit:
>> Reported-by: syzbot+f2725165900304ec97b6@syzkaller.appspotmail.com
>> 
>> INFO: trying to register non-static key.
>> The code is fine but needs lockdep annotation, or maybe
>> you didn't initialize this object before use?
>> turning off the locking correctness validator.
>
> Let's try the solution attached.
>
> Fabio
>
> #syz test

This crash does not have a reproducer. I cannot test it.

> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
