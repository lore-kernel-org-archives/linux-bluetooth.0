Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF49EC00A5A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Jan 2023 04:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjASElT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Jan 2023 23:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjASEkf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Jan 2023 23:40:35 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9CD6C558
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jan 2023 20:38:53 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 66so1107137yba.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jan 2023 20:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gYdaFetUPf0E0ye7Z3ZJlSmRWJOtaHOZWbhbExkiyx8=;
        b=oD5uLA0y/00qtaZD98y+906UbmyKCQ91Umx0p1OmhRh1HjdSOThxXCzmSIAMlnkLsz
         QmK4AMU5cifY6S/eqpC3BrBqPm8ZjbimNTFWEFOTw1h4KrXN+yCwGIG7ptzsQ4qBWA07
         k44GyPHq9OxtUpubkZW3Pr+sVRph8cLT8kM+BybuBNZyINZ1qrnQHWW13+UflMUYSr0l
         iMPa7DklAsIJ0k/92neTiXESaKe2EBJcShKGhVvQVKWVR/Jjhh5FPH6HjQYGVlgtG4m+
         JQPMTAjNovYZQXsxSNppricUSA6IWDHK/5gTYgSqzOrlLUrGyn7EVPbPgR4jIlbj8GAP
         8KQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYdaFetUPf0E0ye7Z3ZJlSmRWJOtaHOZWbhbExkiyx8=;
        b=J1VE3cDcSQOhDzdDCaIRY5lwRJ+c3lLcjIRqDdFsLsdtX1aQ21KLS6pJW7jw75Ta++
         KpLc19/vmAMmcyq82lruppeKpkEcsIHzTLPb5+IfCR8BTMUxuwupQ+pbxmy5VBgl6W4E
         74q4sPnMalYY/sql5pA+M0D2WEMkmq5y4+udr65HbZEl68S0go9Zlyo1r01MRoAmalc2
         qAENW6uZaZ+gUy5MhReWe57f4xwgba7KxudfQUDBq2Chs6FibotKmeqHK16ZGaVjgQFO
         z4SMvEP9YSvJq0qlFn8UNgltX5EWMAv6i1nI8Ycai/Kg7Wgz0CkPhKfy+rdaWwZ1NtsJ
         wOOQ==
X-Gm-Message-State: AFqh2kp3AmF5a7oPy5PpwEsSzyuW/9f3OI1VZu4gIXlru2oJ1utrp6K7
        Q6k0prA9uJcdBbAGtxSbdWYtdFAoQE5DIyAI6SV7/pCILeiYjrCj
X-Google-Smtp-Source: AMrXdXvk62oDAXFWdiHI8MIYop20AX4xbZv0HPtfGaRjO2UGZYt6AErVloW1A0knHlP+SQOxc0zFNtzy8qq9s7CuD3A=
X-Received: by 2002:a81:351:0:b0:36c:aaa6:e571 with SMTP id
 78-20020a810351000000b0036caaa6e571mr859614ywd.467.1674101784903; Wed, 18 Jan
 2023 20:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20230119013405.3870506-1-iam@sung-woo.kim>
In-Reply-To: <20230119013405.3870506-1-iam@sung-woo.kim>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 19 Jan 2023 05:16:13 +0100
Message-ID: <CANn89iK6DZodENC8pR-toW_n5-VFyQR8X1XOuG9Lx1-kr1tmqQ@mail.gmail.com>
Subject: Re: [PATCH] L2CAP: Fix null-ptr-deref in l2cap_sock_set_shutdown_cb
To:     Sungwoo Kim <iam@sung-woo.kim>
Cc:     daveti@purdue.edu, wuruoyu@me.com, benquike@gmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Jan 19, 2023 at 2:35 AM Sungwoo Kim <iam@sung-woo.kim> wrote:
>
> The L2CAP socket shutdown invokes l2cap_sock_destruct without a lock
> on conn->chan_lock, assigning NULL to chan->data *just before*
> the l2cap_disconnect_req thread that accesses to chan->data.

This is racy then ?

> This patch prevent it by adding a null check for a workaround, instead
> of fixing a lock.

This would at least require some barriers I think.

What about other _cb helpers also reading/using chan->data ?

>
> This bug is found by FuzzBT, a modified Syzkaller by Sungwoo Kim(me).
> Ruoyu Wu(wuruoyu@me.com) and Hui Peng(benquike@gmail.com) has helped
> the FuzzBT project.
>
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>

I would also add

Fixes: 1bff51ea59a9 ("Bluetooth: fix use-after-free error in
lock_sock_nested()")

> ---
>  net/bluetooth/l2cap_sock.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index ca8f07f35..350c7afdf 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1681,9 +1681,11 @@ static void l2cap_sock_set_shutdown_cb(struct l2cap_chan *chan)
>  {
>         struct sock *sk = chan->data;
>

Other similar fixes simply do:

     if (!sk)
          return;

I would chose to use the same coding style in net/bluetooth/l2cap_sock.c

> -       lock_sock(sk);
> -       sk->sk_shutdown = SHUTDOWN_MASK;
> -       release_sock(sk);
> +       if (!sk) {
> +               lock_sock(sk);
> +               sk->sk_shutdown = SHUTDOWN_MASK;
> +               release_sock(sk);
> +       }
>  }
>
>  static long l2cap_sock_get_sndtimeo_cb(struct l2cap_chan *chan)
> --
> 2.25.1
>
