Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33A8C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jun 2022 14:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiF0Olh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jun 2022 10:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiF0Olg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jun 2022 10:41:36 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6A3BE3F
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 07:41:35 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3178ea840easo87302887b3.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 07:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1hHJnJQFjFuIToWQDKaqG2N15/HHTzVxPaO06uGF804=;
        b=qTM2lIpYwNuYEZQHZ/Ga8EB8z8R7o9AlA+eFAqPxYsUT4s9V9gs4aimap7TPAFPAaA
         ELUH0DHsK9PT8ELf2dOUQ4WQNMbFH3LZpKgMsvmF3l8l+QU2g6NII4dNHODvqI+AP2Db
         E4bZLJ5qn6m5BvtP3b80w2chOfqLRLwTFHL5OgSvy1ylgaAqrQdZVeb8rfTXkGffV5qD
         0CR3PXBpHQfC3kB3Qw7CeYcUGVvSGHmsCuOnH3tXUnt4opHjvfidbEXTZvnww+jzze0N
         mY8whBGPhmS8XmcFL98LqcG4CuVlwXAdfqY3s6h5MpWMqN+EUi4/duM3XUjkfqNGpvGi
         DYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1hHJnJQFjFuIToWQDKaqG2N15/HHTzVxPaO06uGF804=;
        b=XfVG/+lretltcQpjjuefW94/hPAHcGXYdq9Q+865XXbsbtDaIs7+7+kTeYJ+bDv/oI
         CsmuQ7hph4K+rhpvk23LUJACR/mFGBMH/ukXqLixNfjPRZ0j46Iy+GRcjoPPs4uZYkbm
         PM/G6SDm8ckSxOr7+zTF2b3TSjeLuTMRwdQBF/M9mrVFhtGSVks2hrTtlXE3jzo25w9V
         MfIVFblOyQgqDP7AQtPkUnt3FSQ1Lb0royGVTE4ycZXrcleIe/hSbIa+REV4PihjeQDJ
         McMAey8k21ibwjD6QZa98Zi5izT3IDHtqSrKqDmeb4AGC6z9QwWOtmwDGD1/W0k+0Wsf
         bv3A==
X-Gm-Message-State: AJIora+CGxtzGu8swj02jjbQPDfngfSWUOH1LLXOPRSjnIb7/34CaVgW
        /g+a/jZo/qmy8ed0uSglqnDCLi4nTF4ZDQ1xkOIPaA==
X-Google-Smtp-Source: AGRyM1urGW/4H0GG94INFmrk81Rte5WO/5OidXSkbfUxWXyGmrcqN1x1WsStdWmSl8REBtZN+R+gCul7YvpVCEsrNVM=
X-Received: by 2002:a81:9b93:0:b0:317:8c9d:4c22 with SMTP id
 s141-20020a819b93000000b003178c9d4c22mr14864512ywg.278.1656340894677; Mon, 27
 Jun 2022 07:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220622082716.478486-1-lee.jones@linaro.org>
In-Reply-To: <20220622082716.478486-1-lee.jones@linaro.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 27 Jun 2022 16:41:23 +0200
Message-ID: <CANn89iK-uFP6Swgc0ZeEC38UsuywJ3wbybSNouH202Wa7X7Tzg@mail.gmail.com>
Subject: Re: [RESEND 1/1] Bluetooth: Use chan_list_lock to protect the whole
 put/destroy invokation
To:     Lee Jones <lee.jones@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Jun 22, 2022 at 10:27 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> This change prevents a use-after-free caused by one of the worker
> threads starting up (see below) *after* the final channel reference
> has been put() during sock_close() but *before* the references to the
> channel have been destroyed.
>
>   refcount_t: increment on 0; use-after-free.
>   BUG: KASAN: use-after-free in refcount_dec_and_test+0x20/0xd0
>   Read of size 4 at addr ffffffc114f5bf18 by task kworker/u17:14/705
>
>   CPU: 4 PID: 705 Comm: kworker/u17:14 Tainted: G S      W       4.14.234-00003-g1fb6d0bd49a4-dirty #28
>   Hardware name: Qualcomm Technologies, Inc. SM8150 V2 PM8150 Google Inc. MSM sm8150 Flame DVT (DT)
>   Workqueue: hci0 hci_rx_work
>   Call trace:
>    dump_backtrace+0x0/0x378
>    show_stack+0x20/0x2c
>    dump_stack+0x124/0x148
>    print_address_description+0x80/0x2e8
>    __kasan_report+0x168/0x188
>    kasan_report+0x10/0x18
>    __asan_load4+0x84/0x8c
>    refcount_dec_and_test+0x20/0xd0
>    l2cap_chan_put+0x48/0x12c
>    l2cap_recv_frame+0x4770/0x6550
>    l2cap_recv_acldata+0x44c/0x7a4
>    hci_acldata_packet+0x100/0x188
>    hci_rx_work+0x178/0x23c
>    process_one_work+0x35c/0x95c
>    worker_thread+0x4cc/0x960
>    kthread+0x1a8/0x1c4
>    ret_from_fork+0x10/0x18
>
> Cc: stable@kernel.org

When was the bug added ? (Fixes: tag please)

> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  net/bluetooth/l2cap_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ae78490ecd3d4..82279c5919fd8 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -483,9 +483,7 @@ static void l2cap_chan_destroy(struct kref *kref)
>
>         BT_DBG("chan %p", chan);
>
> -       write_lock(&chan_list_lock);
>         list_del(&chan->global_l);
> -       write_unlock(&chan_list_lock);
>
>         kfree(chan);
>  }
> @@ -501,7 +499,9 @@ void l2cap_chan_put(struct l2cap_chan *c)
>  {
>         BT_DBG("chan %p orig refcnt %u", c, kref_read(&c->kref));
>
> +       write_lock(&chan_list_lock);
>         kref_put(&c->kref, l2cap_chan_destroy);
> +       write_unlock(&chan_list_lock);
>  }
>  EXPORT_SYMBOL_GPL(l2cap_chan_put);
>
> --
> 2.36.1.255.ge46751e96f-goog
>

I do not think this patch is correct.

a kref does not need to be protected by a write lock.

This might shuffle things enough to work around a particular repro you have.

If the patch was correct why not protect kref_get() sides ?

Before the &hdev->rx_work is scheduled (queue_work(hdev->workqueue,
&hdev->rx_work),
a reference must be taken.

Then this reference must be released at the end of hci_rx_work() or
when hdev->workqueue
is canceled.

This refcount is not needed _if_ the workqueue is properly canceled at
device dismantle,
in a synchronous way.

I do not see this hdev->rx_work being canceled, maybe this is the real issue.

There is a call to drain_workqueue() but this is not enough I think,
because hci_recv_frame()
can re-arm
   queue_work(hdev->workqueue, &hdev->rx_work);
