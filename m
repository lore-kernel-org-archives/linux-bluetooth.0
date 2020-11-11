Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9749C5517A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 13:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595A520829
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 13:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQH4xLgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgKKNZl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgKKNZe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 08:25:34 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A61C0613D4
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 05:25:33 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id 13so841539qvr.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 05:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FKEbwQJZmRNwkVX9YGHSP4rPuoQ5U5pdFiZu5vgyAhY=;
        b=CQH4xLgZGd0Q7mJrHl0G80Gmrc9hbeqgs3ko6+jmS+J9PoGhQQI8GhDWCxAgSyGA/w
         SGWlIIMm36QTsXHAogUG1dLNFo2XRPM+rWQwRNftYrkKBv5+FkXNohlKKGMlsMiAW0nS
         +s4/I7wDAmRoNcjPoSJNcDISgIFWk2BWcuybL/3ZqkZqXkU7OMFLx4NFsI/S+yT7M8zD
         wd5uYdcnf5LYP+YJuSGy/W9Kzh15MOLBlx0pIl6SK9vII39hN/0UbWodXs7WHHm8KAnu
         Q3aLfidvktdVKOorTYCsHG2Cc/JmqEejmjK8/NNJNSklpgQIx06FZNJSZRmeoOyk4o3+
         F2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FKEbwQJZmRNwkVX9YGHSP4rPuoQ5U5pdFiZu5vgyAhY=;
        b=YNaXvBhEFDRVuQM3embhCSvfYzBu8EYe4FU/5Ol3nxkIgZmUcquKkTZAsSPYizn5BW
         xunBCEWTar+s5XUD8u23uEBfILN/Eb2IwAfzSuc1avhMqpO0tKKEITlUi+MXtM8X84ef
         FXPhZLNi79K6nKB8r9xdnY4FpBqJmtgRLw5nwLoDFo0kVY4vR4aOKVB28E+J9XrGGVyh
         mzJmvEXRHgOvMNlRYzCqL0SSciOdphKdTla4me0G14vE7YhvNVz6F/xD9NjeUJvF5suE
         1bbJidxgF9rrCT4Yb3ozk9HBSQ0WL0jx26Cr6I6nD9mpjzmR56QXZ6WK2Vhi/aYd/HHb
         LRVA==
X-Gm-Message-State: AOAM532mSaDEsC5ZNy4561pz+wM4eUkqPlt9J3I8/pJw6RHI9JM6awEy
        Mvwr0OCth9NNX5oQ9qWBD0hETkyPJ9d5IT28hRmeo8XVX7rTXEVk
X-Google-Smtp-Source: ABdhPJw+zL/j1fjqkk71AlpEkNH7Cl9BQVxUcYF2rFrvs/jsNTblKTZCB1e79W5MS3x3QzUVy27ok1kNJU6caWzrry4=
X-Received: by 2002:ad4:46cb:: with SMTP id g11mr24903255qvw.37.1605101132594;
 Wed, 11 Nov 2020 05:25:32 -0800 (PST)
MIME-Version: 1.0
References: <00000000000055e1a9059f9e169f@google.com> <000000000000c8101605ae7de686@google.com>
In-Reply-To: <000000000000c8101605ae7de686@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 14:25:21 +0100
Message-ID: <CACT4Y+ak0Enm0CZ5rmUwyWRDkityJx9yzp1yyVDx2shpC5tL_A@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in refcount_warn_saturate
To:     syzbot <syzbot+7dd7f2f77a7a01d1dc14@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Sep 4, 2020 at 4:44 PM syzbot
<syzbot+7dd7f2f77a7a01d1dc14@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit b83764f9220a4a14525657466f299850bbc98de9
> Author: Miao-chen Chou <mcchou@chromium.org>
> Date:   Tue Jun 30 03:15:00 2020 +0000
>
>     Bluetooth: Fix kernel oops triggered by hci_adv_monitors_clear()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f92e3e900000
> start commit:   c0842fbc random32: move the pseudo-random 32-bit definitio..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cf567e8c7428377e
> dashboard link: https://syzkaller.appspot.com/bug?extid=7dd7f2f77a7a01d1dc14
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b606dc900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123e87cc900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: Bluetooth: Fix kernel oops triggered by hci_adv_monitors_clear()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: Bluetooth: Fix kernel oops triggered by hci_adv_monitors_clear()
