Return-Path: <SRS0=QJP1=RU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466B3C43381
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Mar 2019 16:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1537720896
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Mar 2019 16:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552840526;
	bh=hY0cRlqP6mrRAqGYm7UL1g03Ausu68ntfsBU8bXi3d8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ptuusCkNi6pxE9Qfi3OoXLyIXvc35h43uV9zDCnx02izTc3xqnkJIMybTcykFSnNe
	 mlgdm9m0ENumsZqEFkYOVtOihVRSn7u3sMVzAchOSd/K4DzEMtTH0P2LAlc7Qs2EJI
	 R2wj8QVnAZH/NttXFBL4V0tZ7e5TqTl7cG0punXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfCQQfY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Mar 2019 12:35:24 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:44781 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfCQQfY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Mar 2019 12:35:24 -0400
Received: by mail-lj1-f180.google.com with SMTP id n18so9948443ljg.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2019 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Lf3U1XdQWa3yMAD7V43VAz3JgxkZo6Z32jdZoT2Yig=;
        b=DfZ3BJd6LTAmwRVqj7BLIaxh7yuigvmKiH39h80K7yrdnXV+k7698Sa4ME3L0eCUxe
         Pg8+iSVEpoOfSqLsgGEuG3suCyJ9hsGxx5uCpfV7QE1rLBpCWr8uttHWyruLpM9FCG75
         yHdGHVkMcNmqxh9A3qh1vCMUKoOt5DefIkzTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Lf3U1XdQWa3yMAD7V43VAz3JgxkZo6Z32jdZoT2Yig=;
        b=B4+Z9zI2AyitkiC5MZzemBSAFfuXNPXJXE4sXRPRTMkuYfsJe1PzAqj0tI5m8i7ynR
         3G9Gg/zOK2Tvr7kAicoBOU7HmGVFR+ARglC9s01LEqqAdJUttMEpNmPxWXAXdDoPzcxK
         yFIo8MlyGP8WKzuDggbAXK51ZrjWI1dqwCoZBKQG//tEBYbU0D57CdojntCkPjV2IFUB
         wr2VQT6CU50PbzOx+xMSQTrZV0XWZ7d/1mHoFt+8hEp8CvzPDvN6J5t8R6xT24qQgZaG
         MnB1HGve2Z3mr3Ee4TiPAHNu7wgmZVr2WQBC6n3+RCaYdzt8qe2hM2CJt3CbeqZTDMvr
         3oYQ==
X-Gm-Message-State: APjAAAXgLfP2FK0a42GewCkwlUvBUJxoffL3vrQOqVJKq+U9rZLOpj3/
        RMpBQ2jvA/hWQMjrNo4Z1VKlzz6UK78=
X-Google-Smtp-Source: APXvYqx/OlJbzutk7fBMn4AFL7DxvjWxxJMvE+YPK5DnMwgMFqDqflPBS/aUxgzgsPofoPwSE8IhjA==
X-Received: by 2002:a2e:500d:: with SMTP id e13mr5054819ljb.169.1552840521759;
        Sun, 17 Mar 2019 09:35:21 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h23sm1749891ljk.36.2019.03.17.09.35.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 09:35:19 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id n18so9948388ljg.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2019 09:35:19 -0700 (PDT)
X-Received: by 2002:a2e:87cf:: with SMTP id v15mr8069744ljj.22.1552840518847;
 Sun, 17 Mar 2019 09:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008a1bce057ede3d13@google.com> <0000000000009950e1058447ef43@google.com>
In-Reply-To: <0000000000009950e1058447ef43@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Mar 2019 09:35:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUrznUSUKN1AXQA9kCStQ3MHFY95ZmeTZ5zYDcvMhBiQ@mail.gmail.com>
Message-ID: <CAHk-=wjUrznUSUKN1AXQA9kCStQ3MHFY95ZmeTZ5zYDcvMhBiQ@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bacpy
To:     syzbot <syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, mmarek@suse.com,
        Netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, Mar 17, 2019 at 3:43 AM syzbot
<syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit c470abd4fde40ea6a0846a2beab642a578c0b8cd
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Feb 19 22:34:00 2017 +0000

Heh. Yeah, I doubt it.

It would probably be good if syzbot did some confidence testing before
bisecting.

Don't get me wrong, "git bisect" is absolutely wonderful and has done
a ton to help us fix bugs, but bisection has one major downside: if
the bug you are bisecting isn't 100% repeatable, the bisection will go
off into the random weeds and give completely nonsensical results.
They won't even be *close*. What makes bisection so powerful is also
what makes it then completely random if there's even *one* mistaken
bisection point.

So it would probably be good to test each bisection point at least
twice, and if they don't agree, report it as being unbisectable rather
than give a random "this is what introduced the problem".

Hmm?

            Linus
