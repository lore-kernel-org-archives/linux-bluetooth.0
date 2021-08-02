Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A1EC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 17:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B664960F9E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 17:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhHBRhP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhHBRhO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 13:37:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A9DC06175F
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Aug 2021 10:37:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p38so20171150lfa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Aug 2021 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eqj/jbZUe4stLkK8cTohIBe/BZXBIqwPs+QNhcq+Uec=;
        b=LENOxdMDGSQ8ezLeubiwsFnhp0UmAoj7lbtwnE324EOPT1HnvQsMT9HLyRWCvWlNTf
         7nXLNE01gbSGv0K8iX2MF5FHzlwx8GhQneKWfenVmtTRCuAdpgO7AELLBzksrRKNiOsX
         z0OWp7rbjQzQXKXEW9i8T2YOcWNsRUW9zP7VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eqj/jbZUe4stLkK8cTohIBe/BZXBIqwPs+QNhcq+Uec=;
        b=oJynQvJ9TajAAZeG9WJf+XTB0wfy5fHEqQdVjrlq/bFj1Qyo3jbXTNqxlkD15bPtw2
         4j1Mjy8RbtrFZlM1Pqxajm1ifz/gre4otpJAe2dZKaDdWUzaUT68zxEDW+/mEWJAmMIY
         aNqQ5qXRe8FX8zOiLxTo83V7YaAV/0hEsWvXc46MT2wxAU7WQY/K6YV7OZedBH7++wUV
         I5xnzscafKV9l+o6uO1Tyd0QLsfudLLhjz0y60P69qOVH2TnmfkHkuKQz+VumR9/Droe
         zspNHl0L50q2qRb2Wq0bMhVCyKi3qPcWJsyFCTNEVcXfBZDT76Ze1wuyHXTuCBYjJddk
         Z0XQ==
X-Gm-Message-State: AOAM531gk9vX5uy0O155noYWL5pZM/wFVHvuz/DbIPtbIAo+REVtneRF
        yrIXVCjJFOlKr0wJk62+1SyJIbWcfWeKjFd0
X-Google-Smtp-Source: ABdhPJzPHjf8CsdJWgKlwpT71GHFgP4eLuR29ppz1POHb2GWofMCgyz1zzlALCKnbBiswaNj0+Azbg==
X-Received: by 2002:a05:6512:3c9a:: with SMTP id h26mr13366210lfv.300.1627925822667;
        Mon, 02 Aug 2021 10:37:02 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id d4sm778370lfg.178.2021.08.02.10.37.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 10:37:01 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id m13so35070217lfg.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Aug 2021 10:37:01 -0700 (PDT)
X-Received: by 2002:ac2:569a:: with SMTP id 26mr9231678lfr.41.1627925821490;
 Mon, 02 Aug 2021 10:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <290fe7c7-c14f-8685-af09-419faa0e4d1f@i-love.sakura.ne.jp>
In-Reply-To: <290fe7c7-c14f-8685-af09-419faa0e4d1f@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Aug 2021 10:36:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRzabeP3CLZmFWO5EXrqWSvSL8uKwbSYRWw2xT9RVBrQ@mail.gmail.com>
Message-ID: <CAHk-=wgRzabeP3CLZmFWO5EXrqWSvSL8uKwbSYRWw2xT9RVBrQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: defer cleanup of resources in hci_unregister_dev()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LinMa <linma@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Aug 2, 2021 at 8:19 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> @@ -200,7 +211,7 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
>         sk_for_each(sk, &hci_sk_list.head) {
>                 struct sk_buff *nskb;
>
> -               if (sk->sk_state != BT_BOUND || hci_pi(sk)->hdev != hdev)
> +               if (sk->sk_state != BT_BOUND || hci_hdev_from_sock(sk) != hdev)
>                         continue;
>
>                 /* Don't send frame to the socket it came from */

I'm not convinced this is a good idea.

Here we use hci_hdev_from_sock() outside the socket lock, so now that
HCI_UNREGISTER test is not very logical.

And it's positively stupid to start with a hdev, then walk the socket
list to look up another hdev, and then check "was it the original
hdev, but not unregistered"?

In other words - if you care about HCI_UNREGISTER state, it should be
*above* the whole loop. Not inside of it.

So I think this test should remain just that

     hci_pi(sk)->hdev != hdev

and if HCI_UNREGISTER is relevant - and I don't think it is - it
should have been done earlier.

> @@ -536,8 +548,9 @@ static struct sk_buff *create_monitor_ctrl_open(struct sock *sk)
>
>         hdr = skb_push(skb, HCI_MON_HDR_SIZE);
>         hdr->opcode = cpu_to_le16(HCI_MON_CTRL_OPEN);
> -       if (hci_pi(sk)->hdev)
> -               hdr->index = cpu_to_le16(hci_pi(sk)->hdev->id);
> +       hdev = hci_hdev_from_sock(sk);
> +       if (!IS_ERR(hdev))
> +               hdr->index = cpu_to_le16(hdev->id);

Same deal. The 'id' is valid even if it's unregistered.

So either it should have generated an error earlier, or we just shouldn't care.

The fact that the old code used to do HCI_DEV_NONE seems to be more
about the fact that the ID no longer existed.  I think that if you
want to monitor a socket with a stale hdev, that's likely pointless
but valid.

So I think this should just keep using the hdev->id, even for a
HCI_UNREGISTER case.

That said, the *normal* case seems to be from the socket ioctl code,
so it's either explicitly not yet registered, or it just got
registered with a hdev, so I don't think it even matters. It looks
like the only case that HCI_UNREGISTER case would happen is likely the
magical replay case.

Which - again - I think would actually prefer the now still existing
hdev channel id.


> @@ -574,8 +588,9 @@ static struct sk_buff *create_monitor_ctrl_close(struct sock *sk)
>
>         hdr = skb_push(skb, HCI_MON_HDR_SIZE);
>         hdr->opcode = cpu_to_le16(HCI_MON_CTRL_CLOSE);
> -       if (hci_pi(sk)->hdev)
> -               hdr->index = cpu_to_le16(hci_pi(sk)->hdev->id);
> +       hdev = hci_hdev_from_sock(sk);
> +       if (!IS_ERR(hdev))
> +               hdr->index = cpu_to_le16(hdev->id);
>         else
>                 hdr->index = cpu_to_le16(HCI_DEV_NONE);
>         hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);

I think the monitor_ctrl close case is exactly the same case as the
open case above.

But the others look good to me.

So I *think* that the cases you actually want to catch are just the
ioctl/recvmsg/sendmsg ones. Not the special "monitor the hdev" ones.

That said, if you have some test-case that argues differently, then
hard data is obviously more valid than my blathering above.

                 Linus
