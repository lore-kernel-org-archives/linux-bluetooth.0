Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E3CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 09:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244958AbiEaJIF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 05:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241805AbiEaJID (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 05:08:03 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B407B55204
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 02:07:59 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r3-20020a9d5cc3000000b0060ae1789875so9148197oti.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 02:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWsthZPxNDA39U3KIC6LMsBvLuzLbrfSrlsINFHYDcI=;
        b=GIYO75yR6RxABAavORON5hxUzN4kdiuq7iHSEQU+CYmSKkkfZ8vjYY7xX1gDRJoG5K
         WA75V3DNHdz/zDQXyHEiAH5srFHNeIsH2HYfdJMpQ9w1XsbSWECD8ZOulAam5RJpg6fY
         NhnvWk26PwIEleos7OZzKK8rR2pvXqVteUll6hvklGGoXj/S6IspbIDwpd+Ift+Vybjb
         wEeXzYj5OjZ94nZYdMK7gyTFAIti2MtbG/oejv+cr+8XhQ/mazoM4Ro7zRM68pWVz+zM
         YKZuF6uX6UrEUrH0DkPcfa89zq0xmnpzrmr6a9G0wxvHQdCMY77aNgspIxpSuNWyDxRN
         sSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWsthZPxNDA39U3KIC6LMsBvLuzLbrfSrlsINFHYDcI=;
        b=bt2aB0W6Fdx9pyTL337AOGw5EaV/YkVqCWepGKYSL7icaHnC60Vf1F7QaxqkdTmHe0
         B3KcCwkOJEYtYJLAAfNGep6zbM8R0S2GSnl3midVj2mDcopjHkpo2w500ntP8EMn557k
         xYfPzxqH/LdUuXYLjaiOdjWEOKZcVfi+kz2f2hjLLJb7ytw67UKGpu8p506EOUcCHevl
         y6qS3X/W8lb2v/ouim4ljiTZVboDKs4QU+gWU3fbI+4GDeI/wWh+JCUh1M2rCRG/GcGR
         82qjUtVlSpEY0pTHGlRjfZdmEva5I6OLqKBcqf48TY+H4Gtn+izYWfL6YZb/fYMzGJQY
         Po6Q==
X-Gm-Message-State: AOAM5332PVgoYuGdrESYhoG31/EAYFYv+s1vB4Wj2XuORH8AX3vM/4gx
        L/WPpuojtE2+tM19VVJeeskTsXVy5xd/LQCsGj98Pg==
X-Google-Smtp-Source: ABdhPJxVvTrJGlPKkgE3ckW+2BAEYRKazdCH8wFipcEpTVtbBTK4iTzPHd32UxIZGi3IQCROhrDqUirCGPDwLhTbJs0=
X-Received: by 2002:a9d:6f1a:0:b0:60b:20fd:ca75 with SMTP id
 n26-20020a9d6f1a000000b0060b20fdca75mr13961134otq.126.1653988078875; Tue, 31
 May 2022 02:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220517094532.2729049-1-poprdi@google.com>
In-Reply-To: <20220517094532.2729049-1-poprdi@google.com>
From:   =?UTF-8?Q?Tam=C3=A1s_Koczka?= <poprdi@google.com>
Date:   Tue, 31 May 2022 11:07:47 +0200
Message-ID: <CAPUC6bKo6EdacUVAWaJp+_Z_sEztnv96Li6zLpm-UR=2rZth-w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Collect kcov coverage from hci_rx_work
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Andy Nguyen <theflow@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksandr Nogikh <nogikh@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Everyone,

Thank you for reviewing the patch - I hope everything is going well.

Please feel free to ask me if you need any more information regarding it!

Thank you,
Tamas

On Tue, May 17, 2022 at 11:45 AM Tamas Koczka <poprdi@google.com> wrote:
>
> Annotate hci_rx_work() with kcov_remote_start() and kcov_remote_stop()
> calls, so remote KCOV coverage is collected while processing the rx_q
> queue which is the main incoming Bluetooth packet queue.
>
> Coverage is associated with the thread which created the packet skb.
>
> Signed-off-by: Tamas Koczka <poprdi@google.com>
> ---
>  net/bluetooth/hci_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 45c2dd2e1590..703722031b8d 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -29,6 +29,7 @@
>  #include <linux/rfkill.h>
>  #include <linux/debugfs.h>
>  #include <linux/crypto.h>
> +#include <linux/kcov.h>
>  #include <linux/property.h>
>  #include <linux/suspend.h>
>  #include <linux/wait.h>
> @@ -3780,7 +3781,9 @@ static void hci_rx_work(struct work_struct *work)
>
>         BT_DBG("%s", hdev->name);
>
> -       while ((skb = skb_dequeue(&hdev->rx_q))) {
> +       for (; (skb = skb_dequeue(&hdev->rx_q)); kcov_remote_stop()) {
> +               kcov_remote_start_common(skb_get_kcov_handle(skb));
> +
>                 /* Send copy to monitor */
>                 hci_send_to_monitor(hdev, skb);
>
> --
> 2.36.0.550.gb090851708-goog
>
