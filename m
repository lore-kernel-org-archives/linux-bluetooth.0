Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661D4C388F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 11:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EE72074B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 11:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJjO8cBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgKKLW5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 06:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgKKLWz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 06:22:55 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D1FC0613D6
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 03:22:55 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id i12so1017249qtj.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 03:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+0hvWNZjuGzR2yuBkOrthU1shgFfePvt4BkuauBxXY=;
        b=TJjO8cBzKT2rHIMjTFeHyNQ6EvDH4DKhPDmsFzKSLrGZ/Q8IyNQbicX1fyF54q4j8m
         IQBVC1sm2Vv12ZD75TApN/8T0uvgHnJS/JPsd6smNt/Mph5p4+mTpuPwf/i5tD5n9eKM
         C9rX+qkd4yZ3xpbh/oWM/cK4tEExKHE5llKm8dkD65h+a3Uogt6odU6p7ukYgKsVwJnG
         TuPt8CAxoENWh63Umn3BxEjUigoUPXYQFBzhCRkaFAt+nRmvVQMw4qjWGgjFLrZ+vTED
         kB80zM7rWDaSkzPTA0wDslSNY6/661lGnBOZnGNFkTVxZfDQqGzKX+F0HGUUvV0bmBmo
         +7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+0hvWNZjuGzR2yuBkOrthU1shgFfePvt4BkuauBxXY=;
        b=p2lUT1RHyRy/+9oZ/S0Qkm00UI6IyeCdxJLrfa9kpPjU6Ni1n8qNqV30TcLAGUsSX4
         KRyPsofAPl6BsFckS/vDuAMTMy2rvPeZgzAKx6IBY/gqCKPbO1LcfTdcTgfkxhzptxlw
         sibzsU1RWcZVTgR/qnYRJ86X4ITyHAusxX2t7/OKg2DMrs2+W5on4d89jJDqJNRQ5/Gr
         YK1CXbMgpSsOyBlfxKtmzUuW1VX3aQBYtcFkr5JvcVw6FanDowGGXEHwQBt0FrEPAgTT
         DN8uR9GUkgLYZXBakLxTQJIzrlOS117wXHp1At51HApWh5KBSzkhZMZOEK5n5SqpwDMI
         xk/A==
X-Gm-Message-State: AOAM530un1XmGFN7AKSVbO1bwkNh/y8F6c2MidhgyHzsCdMrNbZq8iHR
        iJhFlJZBMJ9QvG5xc50E9stxDM0xdywMff3ifGNMZQ==
X-Google-Smtp-Source: ABdhPJwLNYMg/E8M6NNNJsIV8jVxHNKK8b1huFHUn20uWGl5RATA0MNnH+Vn1aZZtb41l988fqwX7EwaS8SrxwXPrto=
X-Received: by 2002:ac8:37f2:: with SMTP id e47mr22634777qtc.290.1605093774733;
 Wed, 11 Nov 2020 03:22:54 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c57f2d05ac4c5b8e@google.com> <0000000000002a736805b3a05697@google.com>
In-Reply-To: <0000000000002a736805b3a05697@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 12:22:43 +0100
Message-ID: <CACT4Y+bTDLYNe2_5qbLNR7PaFmKR1Nz7mg+S95XwjUdp=zMc3Q@mail.gmail.com>
Subject: Re: BUG: corrupted list in kobject_add_internal
To:     syzbot <syzbot+dd768a260f7358adbaf9@syzkaller.appspotmail.com>
Cc:     abhishekpandit@chromium.org, Coiby Xu <coiby.xu@gmail.com>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        netdev <netdev@vger.kernel.org>,
        Rafael Wysocki <rafael@kernel.org>, sonnysasaka@chromium.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, Nov 8, 2020 at 11:55 PM syzbot
<syzbot+dd768a260f7358adbaf9@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a46b7ed4d52d09bd6c7ab53b2217d04fc2f02c65
> Author: Sonny Sasaka <sonnysasaka@chromium.org>
> Date:   Fri Aug 14 19:09:09 2020 +0000
>
>     Bluetooth: Fix auto-creation of hci_conn at Conn Complete event
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d75792500000
> start commit:   d6efb3ac Merge tag 'tty-5.9-rc1' of git://git.kernel.org/p..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff87594cecb7e666
> dashboard link: https://syzkaller.appspot.com/bug?extid=dd768a260f7358adbaf9
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105054aa900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ab6976900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: Bluetooth: Fix auto-creation of hci_conn at Conn Complete event
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: Bluetooth: Fix auto-creation of hci_conn at Conn Complete event
