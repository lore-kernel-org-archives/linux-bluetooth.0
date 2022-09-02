Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC45EC6FA87
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Sep 2022 12:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbiIBMj7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Sep 2022 08:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbiIBMiv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Sep 2022 08:38:51 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AB547BB7
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 05:30:22 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id i67so907287vkb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Sep 2022 05:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8QYVw6ZRx2XqpXiZbdSWT7c8/Gv25mz1kltqA5+azyA=;
        b=HV5Guf1s6EkgsUxrfe4xOmpNl8sPaSPX10qCIGLduT/63enMCemJgjn4lACDQzSk3l
         /k3tzGAu+pnTYiCwGDrHVpidFPf0qBNy60W8gitgRsIGcc00pbCxf7BCU9rIji31hTpb
         MLJupNae0gdjKvM5SuPMH6uQYxClpzLXUJ4FyoAJfAhVD4pdmgfnzmfT6nmabFaoNRKj
         7MIV0WX8HDECemuO8WdQMPHzF+CWLo1gf8W18qm9XzciJMRk9dElAl3TDNasi+XKoa88
         GnViMrOQ6Dyn0o8KiE0CoyaVFN4Wsja6FVmCaeJx5dXj9H5YNxyRmTDvaQc5WH22wbvD
         DS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8QYVw6ZRx2XqpXiZbdSWT7c8/Gv25mz1kltqA5+azyA=;
        b=tCXxJ8IJUCD1mIIaPLHYCCsLRmW2aK5iWG4pies/fZ9WbTy5Nu3Kg8R7iIlbCBl7+z
         UCLa5ikdHOCMElJQGccSW1xpfQ2Z1a/DCrXRpG3JlvIqwWpsKvI3F7rhPVoVReHLJm+N
         r5qHPDPc8mdcioTS+/sSBcOM4Gy5yOush7aU5h6qQ++5x6gSFOyvU1dGUqcCxfMknJe8
         zJYT3+LOJP08SFkcbcsxrefiaLzhLj/5yymKEoa803iQzcmShnwJJdIKAyoTOOju0nqP
         CkQBZ6RWf5/3RSLKPlcNMCaFghV15JQGjbq5+n4lQaiJXWuaQhMiZnZSgZu0QDuu6cmc
         YPRg==
X-Gm-Message-State: ACgBeo2mJqb06HsaO9Fy7XJ/7KOYaf7ZB4bU/xxqljhR7Li1B8IrksXQ
        NsBhKz8V1lyIWVB7ohdWw+OCcBvKzHw/UGScAVYshQ==
X-Google-Smtp-Source: AA6agR5NbWo1XpT7tNGxl8i/9NnU+Dg7ODCO9CpR0LUqxBiFGc/ih9I+exJB5Xs7fmz3ly9GdfKg6mHMocUIrKD3YWU=
X-Received: by 2002:a1f:a0c6:0:b0:381:373d:c61d with SMTP id
 j189-20020a1fa0c6000000b00381373dc61dmr9922814vke.1.1662121743406; Fri, 02
 Sep 2022 05:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000016512d05e76bd837@google.com> <CAJhGHyDPN0CWZD8PxFHoB66f6QBNFGx8Lwz9EG-kSB8Q2yriQw@mail.gmail.com>
 <CABBYNZKNHnrgHfu8JN-kw5UqfEGUVWGyOwK_fLqHP5w8kPc2KA@mail.gmail.com>
In-Reply-To: <CABBYNZKNHnrgHfu8JN-kw5UqfEGUVWGyOwK_fLqHP5w8kPc2KA@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 2 Sep 2022 14:28:52 +0200
Message-ID: <CANp29Y6gP7Q8F0BbjG6FPcsp9kd5OAtk0J4qybnfGuV=g20_uw@mail.gmail.com>
Subject: Re: [syzbot] upstream test error: WARNING in __queue_work
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        syzbot <syzbot+243b7d89777f90f7613b@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "'Aleksandr Nogikh' via syzkaller-bugs" 
        <syzkaller-bugs@googlegroups.com>, Tejun Heo <tj@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

This one has so far happened only once on syzbot, probably it's either
an extremely rare issue or was already solved.

On Tue, Aug 30, 2022 at 7:37 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Lai,
>
> On Tue, Aug 30, 2022 at 7:08 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> >
> > CC: BLUETOOTH SUBSYSTEM
> >
> > It seems that hci_cmd_timeout() queues a work to a destroyed workqueue.
>
> Are there any traces or a way to reproduce the problem?

You can take a look at the console log provided in the original bug report:

console output: https://syzkaller.appspot.com/x/log.txt?x=120ebce7080000

Re. reproduction -- syzbot records a test error when it failed to do
the following sequence of steps:
1) Boot a VM and establish an SSH connection to it
2) Upload fuzzer binaries
3) Start fuzzer binaries; these binaries will set up the fuzzing
environment (networking devices, etc)
4) Execute a simple mmap program to check if coverage collection works fine

mmap(0x1ffff000, 0x1000, 0x0, 0x32, 0xffffffffffffffff, 0x0)
mmap(0x20000000, 0x1000000, 0x7, 0x32, 0xffffffffffffffff, 0x0)
map(0x21000000, 0x1000, 0x0, 0x32, 0xffffffffffffffff, 0x0)

It's probably easiest to start syzkaller locally on this exact kernel
revision and see if the fuzzing is able to start. It will perform the
same steps and report an error, if the issue persists.
I've just tried to reproduce this particular bug myself on
4c612826bec1 and everything booted absolutely fine. So probably it was
just a flake.

FWIW syzbot can also perform patch testing for the reported bugs and
output console logs, so it should also simplify the debugging of such
bugs. More details are here:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches

Patch testing can be done if there's a repro, I've just sent a PR
(https://github.com/google/syzkaller/pull/3355) to add testing to the
exception list -- we can retest that without a repro.

Best Regards,
Aleksandr
>
> --
> Luiz Augusto von Dentz
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CABBYNZKNHnrgHfu8JN-kw5UqfEGUVWGyOwK_fLqHP5w8kPc2KA%40mail.gmail.com.
