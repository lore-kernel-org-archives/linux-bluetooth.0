Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCD8C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 21:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA3360EB5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 21:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhGWUrl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhGWUrk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 16:47:40 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8278C061575
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 14:28:12 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id l145so4375249ybf.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 14:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6r/PHGYRNP2mxnIgqTH0kSr0nPAoZpxcd2UrQwVikBA=;
        b=kyk1G0qASouU7iwkvdWROfbLddyhibLxS2wJzEJ9wpMGBl0tmNzxzwzA7m63Gi8fEN
         aIOqn08pCW2S/bI5nphKOzHltWLKQ5gpOOLSNeRJstngAC2bgkcmZb7Z6NVlYNOSb+Ao
         O0HJ0DuW8H1NhF6QDAe21xJZqOPhjLcufInUoU0EI/b2IlDCMTKi+zE9gTB4ci8hP3xz
         nQMKGIC6cCdb14/wCEpk56r+fXbG1qRn8VCEyHz6+cGLeecCM12M/T2oEO+13pj302yA
         LJmjr6eA1iSZpLUi9C5DTWVzdwsY665iGC+OuGn9YmILH4oAoKSnzStGbVr1ZWtNEk+R
         dZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6r/PHGYRNP2mxnIgqTH0kSr0nPAoZpxcd2UrQwVikBA=;
        b=SKwkjxWqiE25me4dgUOLX3eOBDEZSPYr23A9His316Jz5X+rrwVUCgoKwAHRtHyEsA
         nbmN4tB6gWlvaq2XJF8cvVg9FKnFQt6uyIaxjw2sb7j3GMIzgieflKuv4joFOukK9mRA
         lYJkgGvZ8yKr5G/40QOYVsqAR3KeX8UARhYDbUgIkhJ745VsgP79f/N8eJLzuyw0SvFn
         yUaECH7Or9RUbW4ck5UADmAWumzE223ZCaUBPCSw/2Qq8g4B9kCX48CAJLLVe2eAUo+q
         WusPWxkRoUEzF/edOH20CSi1UelIPitnQcITPkXpjUjDdxgH1NAxD8YO/QBxRlHMZ3uJ
         togQ==
X-Gm-Message-State: AOAM5303A+rvpwwJxmveL+yIm4oCihHS6lYXpAnaUzrc5IUfhZKrrrkV
        GINFvLHXoV4VLd/F/tGQQUJC9QcG+pwVJKr0ZmQ=
X-Google-Smtp-Source: ABdhPJw/M4uiYGFGHhlugdhOU1CGKdivssEah+utJuWEPFHTA5j3QhApDLGEOkOUKojYhU4KzScmljzuYUHDe5QzpZI=
X-Received: by 2002:a25:7e86:: with SMTP id z128mr8992443ybc.222.1627075692045;
 Fri, 23 Jul 2021 14:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210720104905.6870-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <CABBYNZLt=fJTtdj9qvC22GkF_uYFe59D2bS3u61K14=Gq43Qbw@mail.gmail.com> <bb9ceb4d-9e5c-1487-233b-426bc58e9a91@i-love.sakura.ne.jp>
In-Reply-To: <bb9ceb4d-9e5c-1487-233b-426bc58e9a91@i-love.sakura.ne.jp>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 23 Jul 2021 14:28:01 -0700
Message-ID: <CABBYNZJnC-b0s5LW=zTLh4_bV44Uv2-6LXXy+vRAgQmxk=defg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: reorganize ioctls from hci_sock_bound_ioctl()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        LinMa <linma@zju.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tetsuo,

On Wed, Jul 21, 2021 at 4:42 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2021/07/22 3:17, Luiz Augusto von Dentz wrote:
> > I think it would have been cleaner if we have dedicated functions for
> > each command like I did in my patch:
> >
> > https://patchwork.kernel.org/project/bluetooth/patch/20210717000731.3836303-1-luiz.dentz@gmail.com/
>
> But your patch was proven to be unsafe. There is a use-after-unregister
> race window which would require at least 1000 lines of modification and
> a lot of careful review if we try to manage without my patch.
> Such all-in-one-step change is too much for "sleep in atomic context"
> regression fix which is preventing syzbot from testing Bluetooth module
> and is preventing Linux distributors from fixing CVE-2021-3573.

Im not saying you should adopt my solution, the locking etc stay the
same as in this set but each command should have a helper function to
make it clearer that way we don't have to re-evaluate the command over
and over.

> As far as I can see, it is lock_sock() (not bh_lock_sock_nested() in your
> patch) that is needed for protecting
>
>         sk->sk_err = EPIPE;
>         sk->sk_state = BT_OPEN;
>         sk->sk_state_change(sk);
>
> in hci_sock_dev_event(HCI_DEV_UNREG) from concurrent modification
>
>         lock_sock(sk);
>
>         if (sk->sk_state == BT_BOUND) {
>                 err = -EALREADY;
>                 goto done;
>         }
>
>         (...snipped...)
>
> -               hci_pi(sk)->hdev = hdev;
> +               if (hdev) {
> +                       hci_pi(sk)->dev = hdev->id;
> +                       hci_dev_put(hdev);
> +               }
>
>         (...snipped...)
>         /* Race window is here. */
>         (...snipped...)
>
>         sk->sk_state = BT_BOUND;
> done:
>         release_sock(sk);
>
> in hci_sock_bind().
>
> >
> > That way it is simpler to protect the likes of
> > copy_from_user/copy_to_user, etc, even if we have to some checks
> > duplicated on each function we can have a helper function to checks
> > the flags, etc.
>
> My patch calls copy_from_user()/copy_to_user() without lock_sock()
> which works nicely with "[PATCH v3] Bluetooth: call lock_sock() outside
> of spinlock section". I'd like to backport "[PATCH v2] Bluetooth:
> reorganize ioctls from hci_sock_bound_ioctl()" together.

Yep, Im not asking you to change any of that.


-- 
Luiz Augusto von Dentz
