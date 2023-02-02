Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C70C636D4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Feb 2023 09:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjBBJ0h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjBBJ0f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Feb 2023 04:26:35 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152D1474CC
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Feb 2023 01:26:34 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-501c3a414acso18301987b3.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Feb 2023 01:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yMJLDKfiAh5d4q1e+8BHnfDMo0mUiYMeMc9aD1SEa10=;
        b=fzeQZSHyw47SxC8Rtj+m5yBF+0xwnHJBbuQKxaz0Iac7/qtsy9fHhvgm89w6nwL6C2
         w/4hH5m23kzrn5ChiLw1DtIeK9vkEqavU9lWOIfZbVp5g7FegM2+H3wdLVbMp6aTqXc0
         WCILhVZe/eFsMU1Thw4veNWUgxMeVUW/ZIXLkHXiPBXsKPJkVsZqGLF0Ehlv3D022i++
         FxV+9bkXjvpHaRNUCAraNsXt9ZhJ0E+HN24IoruY5J7mFvyDF2lgreSyJtqD0BZg8X5C
         izALpjgrgmEu7FQsQ+w/LyRQ/Nsu6w/KxDM+YhzFB2MGOLHYm6ldNxd2kQ2k0Zb8Nf2U
         dZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMJLDKfiAh5d4q1e+8BHnfDMo0mUiYMeMc9aD1SEa10=;
        b=MYBnE6fcESMLYqBeCxmPugr7ah247MzG8rkyWySAyegQ1A53CwvSdISxXsu1RIr8kF
         Y8ea+ngHGZttGraI6ABpDxV7DUqGGaLGe0/U137aLyTx5UcqQdmMm3Awj9zbacRhr4ZJ
         FlR89UyGtS1O4VfR+hvs9aO/eY1ZkCgYl6G0Jy9hrkJNZQ3vJE1of4AoaLcH4yBp9g2Z
         HZvxnS022RosFAntZd78zUkHVdTkJyrIsio6WDwsia15+JRrp72vPP/OPWuulPbhZo+b
         aXBc4o2/UTKDQZlUaIYAtoEAH6lGBZ2qt4ODLhIVzkT7D8dlDFgFa0//JY6eYSF9zTRH
         Rd9w==
X-Gm-Message-State: AO0yUKV7hb8sYrKoriMGjdHRVjKkyMkhJlc4HH5Mo++cAP/uuTyMkAlY
        L/cCg/63CXDfTRUtirmqmxz5vUn6QG7BzrIHuZf3eA==
X-Google-Smtp-Source: AK7set8aXMGpKuLxzy9fQl+dGgdEeWWeapuh8k4nJ6zlAccjUYwWS0b7tuE6Jv3NgHgtrKXm51wDkn85QhM/rxFquZE=
X-Received: by 2002:a05:690c:b82:b0:500:ac2c:80fb with SMTP id
 ck2-20020a05690c0b8200b00500ac2c80fbmr617309ywb.90.1675329992984; Thu, 02 Feb
 2023 01:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20230123091708.4112735-1-git@sung-woo.kim> <20230202090509.2774062-1-iam@sung-woo.kim>
In-Reply-To: <20230202090509.2774062-1-iam@sung-woo.kim>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 2 Feb 2023 10:26:21 +0100
Message-ID: <CANn89i+hAht=g1F6kjPfq8eO4j6-2WEE+CNtRtq1S4UnwXEQaw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix use-after-free
To:     Sungwoo Kim <iam@sung-woo.kim>
Cc:     happiness.sung.woo@gmail.com, benquike@gmail.com,
        davem@davemloft.net, daveti@purdue.edu, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        wuruoyu@me.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Feb 2, 2023 at 10:07 AM Sungwoo Kim <iam@sung-woo.kim> wrote:
>
> Due to the race condition between l2cap_sock_cleanup_listen and
> l2cap_sock_close_cb, l2cap_sock_kill can receive already freed sk,
> resulting in use-after-free inside l2cap_sock_kill.
> This patch prevent this by adding a null check in l2cap_sock_kill.
>
> Context 1:
> l2cap_sock_cleanup_listen();
>   // context switched
>   l2cap_chan_lock(chan);
>   l2cap_sock_kill(sk); // <-- sk is already freed below

But sk is used in l2cap_sock_cleanup_listen()
and should not be NULL...

while ((sk = bt_accept_dequeue(parent, NULL))) {
  ...
  l2cap_sock_kill(sk);
  ..
}

It would help if you send us a stack trace ...

>
> Context 2:
> l2cap_chan_timeout();
>   l2cap_chan_lock(chan);
>   chan->ops->close(chan);
>     l2cap_sock_close_cb()
>     l2cap_sock_kill(sk); // <-- sk is freed here
>   l2cap_chan_unlock(chan);
>

Please add a Fixes: tag

> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
>  net/bluetooth/l2cap_sock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index ca8f07f35..657704059 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1245,7 +1245,7 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>   */
>  static void l2cap_sock_kill(struct sock *sk)
>  {
> -       if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
> +       if (!sk || !sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
>                 return;
>
>         BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
> --
> 2.25.1
>
