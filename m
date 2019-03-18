Return-Path: <SRS0=9Smc=RV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764DBC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 13:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C8020857
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 13:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IeRG7LKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfCRNAS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:00:18 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:52652 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfCRNAS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Mar 2019 09:00:18 -0400
Received: by mail-it1-f170.google.com with SMTP id g17so20266468ita.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2019 06:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGal6BMDhsfhhnQaWXeRS4L+kMnG5Bgz71EQFAkSJ1c=;
        b=IeRG7LKvaXmv5CzFJeioj8e/xUTrWyO7jUSqENyjbKkE80TQS/u2FUPutUJEq85hpW
         CHtaBu7AOKCjjEelOMlGlWV/CgP2aHLKX1yBx1BzNlk3IqoS7Iw9ylZoSedyZdGzi/22
         r8uIk7XXM+EtNvZx37KoFGvIORqIfeCss6MJhGo7TAWW5SQYn3GsP1knrM5vCkLHGZ/m
         TqS1YyZvJNgFq6bGQqTNzsWaoqi/aF/UTO1w5eunLh0+ylYI9JHAdik0rMAnWeGYK7Z5
         NgAvn9YVws2Irqfwa2UQ45wYrQSD7ObP5PnBujeMEikIIswGcpCNYRxLUD37w+Ngqgi4
         a3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGal6BMDhsfhhnQaWXeRS4L+kMnG5Bgz71EQFAkSJ1c=;
        b=p1UiyKnwSbLTgBdRo34sfSVPgwW4iBEARx/0XXkcO1EzibqTFgh9b1t7WihKG8d2xe
         BCBBanEnopwGJ7nqka9sSifwS14bvkDr+sPpnm4kHhXaHDRartpxi2nNOphIIsnfaaFH
         XHokweJgrpxb6jjd4aTcyLcojv9GcDPTMd7YNvcaDc4h6B/IgHopSBXh73gk+zwEJlum
         Y1RLSrdzplgLfzIVJTet82mHnydG24cqCJ7F2k4Pxe/BTdY8L1NwOq0aUe7fmWiBtSZV
         4zXOuF7/EXKsphBt0ZZiDf2DbwHWHqL6qkKgm7eL6UPWSX9HMaH4/jq0b+euYGzLNX6/
         f5mQ==
X-Gm-Message-State: APjAAAVfFZaH1sMWJVBsYUL87ZmL6/8RcuaONQ97CLpN5bwSIefSoWsH
        yBZAMiACbHamfdje1Nmw56PDRcRFwKmwKlosZf/GEw==
X-Google-Smtp-Source: APXvYqxT5QPwgfOjTJ4X2MNyOlwfNsDcQm2CQn9+2C+ZR2AqU7YakUAGH7dsbyK3doxjx9+mKJQt9d5KQExi3+0BSw8=
X-Received: by 2002:a24:3b01:: with SMTP id c1mr9323944ita.144.1552914016414;
 Mon, 18 Mar 2019 06:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008a1bce057ede3d13@google.com> <0000000000009950e1058447ef43@google.com>
 <CAHk-=wjUrznUSUKN1AXQA9kCStQ3MHFY95ZmeTZ5zYDcvMhBiQ@mail.gmail.com>
 <CACT4Y+YOWaU8s90joeGB4G1oc-GxrQSDnjpuFOuE4eJd5FHK3g@mail.gmail.com> <20190317202455.32a334d1@elisabeth>
In-Reply-To: <20190317202455.32a334d1@elisabeth>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 18 Mar 2019 14:00:05 +0100
Message-ID: <CACT4Y+bo1PC_fBHy1wtkfhtaY1Au9CwLtQphbsHDA24Xx7o+-g@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bacpy
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Michal Marek <mmarek@suse.com>,
        Netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, Mar 17, 2019 at 8:25 PM Stefano Brivio <sbrivio@redhat.com> wrote:
>
> On Sun, 17 Mar 2019 18:11:49 +0100
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > And in this case it seems to be working as intended bisecting it to a
> > release tag.
>
> I guess what went wrong here is that it had to skip quite a few
> commits, and the result isn't relevant anymore. Maybe you could improve
> this by handling a:
>
>         all runs: boot failed: can't ssh into the instance
>
> case as bad revision? And, also, if scp times out (as it did on
> 912964eacb11), keep retrying instead of marking the revision as good?

Skipping revisions does not make the result wrong. In the worst case
git bisect will point to a range of commits.
But marking non-building/booting revisions as bad can actually diverge
bisection in the wrong direction and will result in pointing to
completely irrelevant commits. git skip is meant exactly for such
cases.
And in this case, skipping did not affect the process, it just needed
to do few more additional steps.
