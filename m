Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7EAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Mar 2022 06:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiCZGdN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Mar 2022 02:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiCZGdL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Mar 2022 02:33:11 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E3627CFF
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 23:31:34 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t2so8236845qtw.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 23:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PTLKNJ1HHVa/CC/OMIeEXrqEsVbWaZOp7AFQBATXJDQ=;
        b=lUQtPiSM3Sqlxdd43fL+DfdNXAvAAY1bKNTHEfSflmKVRuwGdp6JHLhjUjDv6nQq+g
         0/+YIxlNQvlXokJXnrkraDIf4Q9elqAoG4z+oUBHynRN61oKnnJ3Z9oHJQKmMoCclCE3
         Jt9kSWDc+ZfmZRkWINyz0I50DPIYgmEScNspI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTLKNJ1HHVa/CC/OMIeEXrqEsVbWaZOp7AFQBATXJDQ=;
        b=0M+6vgNteFNOWki/Ub0grkPGraF0NLSos5cuWSslbM+P0L35VXN4BPuA/06jmPfx35
         yqCf4jPCOOfZ5ppjprF+e8IBN5iGvQuvLBew6Hh9/UXmZ1qV0Zu6SoSFNBdpOkgSTers
         3iu2xdaVhIJovl/+HdHdbwgdHsVjeHyJLczHycC/ak/zGIjtGURkiu611vvN7gVGwyJF
         yb7YUTXYiCk7EafMoro/Vw+QTPenKxKbEYeaZdHpwSbPz6DVxJkqncurlglTnj3cp5KW
         H06Y8nxMBU8YZUYFqRhyZns2v28CzBv7jAT38SgY00js+r4TJY74MYrCPjBfKbOQKGTt
         RGJA==
X-Gm-Message-State: AOAM531dGKs16veXe/JGOm5k3vrxfld2SDz512EU5fcNBpMs+0qTBrf/
        8w7XYGq4K5Q8QLu91+A3fEHr9ck84BMu+YUPblQAVw==
X-Google-Smtp-Source: ABdhPJyNXpv93V1BfrqoR6BPPZvt8TozB6bISb7ecXAcBKX5At5yoq8MUmWtanB+ci+O2oyb/CoairlaOa698avJc2c=
X-Received: by 2002:ac8:7ee3:0:b0:2e1:a508:c500 with SMTP id
 r3-20020ac87ee3000000b002e1a508c500mr12523470qtc.117.1648276293617; Fri, 25
 Mar 2022 23:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220325033028.1.I67f8ad854ac2f48701902bfb34d6e2070011b779@changeid>
 <CABBYNZKF1Ye6D130XgaFmqN6JAssf78-FaQh_AEkwigy8qaVjw@mail.gmail.com>
In-Reply-To: <CABBYNZKF1Ye6D130XgaFmqN6JAssf78-FaQh_AEkwigy8qaVjw@mail.gmail.com>
From:   Ying Hsu <yinghsu@chromium.org>
Date:   Sat, 26 Mar 2022 14:31:22 +0800
Message-ID: <CADwQ6b6cCrKGfS-zhh5KnSNdxm_n_krwpZ=s68WYdoJ-XCHH-Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix dangling sco_conn and use-after-free in sco_sock_timeout
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Joseph Hwang <josephsih@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I compiled and ran the c-reproducer:
https://syzkaller.appspot.com/x/repro.c?x=152b93e8700000
I will add relevant links in the commit message. Thanks for the reminder.

While fixing the use-after-free problem , I also found a possible
deadlock in sco_sock_connect() and sco_sock_getsockopt() :
sco_sock_connect() {
  hci_dev_lock(hdev);
  lock_sock(sk);
}

sco_sock_getsockopt() {
  lock_sock(sk);
  case BT_CODEC:
    hci_dev_lock(hdev);
}

So, adjusting the locking order in sco_sock_connect() can also avoid
the possible deadlock.

Ying

On Sat, Mar 26, 2022 at 2:50 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Ying,
>
> On Thu, Mar 24, 2022 at 8:31 PM Ying Hsu <yinghsu@chromium.org> wrote:
> >
> > Connecting the same socket twice consecutively in sco_sock_connect()
> > could lead to a race condition where two sco_conn objects are created
> > but only one is associated with the socket. If the socket is closed
> > before the SCO connection is established, the timer associated with the
> > dangling sco_conn object won't be canceled. As the sock object is being
> > freed, the use-after-free problem happens when the timer callback
> > function sco_sock_timeout() accesses the socket. Here's the call trace:
> >
> > dump_stack+0x107/0x163
> > ? refcount_inc+0x1c/
> > print_address_description.constprop.0+0x1c/0x47e
> > ? refcount_inc+0x1c/0x7b
> > kasan_report+0x13a/0x173
> > ? refcount_inc+0x1c/0x7b
> > check_memory_region+0x132/0x139
> > refcount_inc+0x1c/0x7b
> > sco_sock_timeout+0xb2/0x1ba
> > process_one_work+0x739/0xbd1
> > ? cancel_delayed_work+0x13f/0x13f
> > ? __raw_spin_lock_init+0xf0/0xf0
> > ? to_kthread+0x59/0x85
> > worker_thread+0x593/0x70e
> > kthread+0x346/0x35a
> > ? drain_workqueue+0x31a/0x31a
> > ? kthread_bind+0x4b/0x4b
> > ret_from_fork+0x1f/0x30
> >
> > Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> > Reviewed-by: Joseph Hwang <josephsih@chromium.org>
> > ---
> > Tested this commit using a C reproducer on qemu-x86_64 for 8 hours.
>
> We should probably add a link or something to the reproducer then, was
> it syzbot? It does have some instructions on how to link its issues.
>
> >  net/bluetooth/sco.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > index 8eabf41b2993..380c63194736 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -574,19 +574,24 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
> >             addr->sa_family != AF_BLUETOOTH)
> >                 return -EINVAL;
> >
> > -       if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
> > -               return -EBADFD;
> > +       lock_sock(sk);
> > +       if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
> > +               err = -EBADFD;
> > +               goto done;
> > +       }
> >
> > -       if (sk->sk_type != SOCK_SEQPACKET)
> > -               return -EINVAL;
> > +       if (sk->sk_type != SOCK_SEQPACKET) {
> > +               err = -EINVAL;
> > +               goto done;
> > +       }
> >
> >         hdev = hci_get_route(&sa->sco_bdaddr, &sco_pi(sk)->src, BDADDR_BREDR);
> > -       if (!hdev)
> > -               return -EHOSTUNREACH;
> > +       if (!hdev) {
> > +               err = -EHOSTUNREACH;
> > +               goto done;
> > +       }
> >         hci_dev_lock(hdev);
> >
> > -       lock_sock(sk);
> > -
>
> Also are we sure we are not introducing a locking hierarchy problem
> here? Previously we had hci_dev_lock then sock_lock now it is the
> opposite, or perhaps we never want to have them at the same time?
>
> >         /* Set destination address and psm */
> >         bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
> >
> > --
> > 2.35.1.1021.g381101b075-goog
> >
>
>
> --
> Luiz Augusto von Dentz
