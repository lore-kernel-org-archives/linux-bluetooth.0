Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BF3C636CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Jan 2023 23:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjAaXMT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Jan 2023 18:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjAaXMQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Jan 2023 18:12:16 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E359773
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 15:12:15 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id w11so26590436lfu.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 15:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=matician-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aqBqqbvxJPuTyQ5sPNc4pavJQZ6KwwBHRPw70Ob4Www=;
        b=AQU47IQTtWdF/VlN0ReneYyV1BYcau1CjVJyEjCo/+MZV/F3TWeW4wBOieceX9AtcV
         TiGFV9kvsgRYaG+8XPhH79IuRi/HHZMrQqyG4AbhxXxIXxpfPqduTWu0MbbzvkEYZvLS
         KG96PsnKVHK0y5jjwUz9bfdBsLNRE66yLI9XENlqRdZJ5ev6jBzcisnQkO7/eqC4Hxo7
         eU7WHkIS032+i3DJbipY7SPHgkIfcUFZMT3erXqv7+glJMc5g7OLs8hJ90Ezv1nB1Ty3
         tae0RTSGjIF2vvnTw8Pf9wbcBSyK6A8xRKAOJXcU32kyoLHd/knslcvYlI0RWVKCxDNp
         SEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqBqqbvxJPuTyQ5sPNc4pavJQZ6KwwBHRPw70Ob4Www=;
        b=hZNWmQnQbPH+c+mVo9STIZq826iLEtUgG9VAhF6CsbpdjLlfWLpXQG/XOP+HzuBN8F
         /vdkt3VGpDL41WRjI6R66dKGZEnw0ZpuDNq2CcQnKOj/Z+DCVN91RwE1a23ysXkTO0on
         L3qIUwV7OcE+7Qa7XiKNYTAsZaExhG+5J1W6uzch977leLm8Zv8lIBV5i7tbZkqB+aRe
         ZWHhdEsvIse3Okvr2KWQhikdObu2oMR8s4YPYd82Yr/KCjxBjo6Pc26NYTHkFUqj1v4k
         Xm2vT1zN7oXoxDyEaXvasMRmG5yt3lCasLswOD0p8bGj+gj+YsV0bbtd7Y8tTFGBuQyV
         so4Q==
X-Gm-Message-State: AFqh2krV+DnwaFMZzlUXFl9jravCFyayrg+LXdA7gvXVAgU9IRcf/r/t
        G4yuvX6vNdfQx2g01qNoIggFkDTOPahTXRb31LFCbg==
X-Google-Smtp-Source: AMrXdXt+rKuWEGOgkQyGnw3pfuDV8IWww8RZ7mgJDdYi+urcx9AbI+bv6fZI0ozSPry9q/6fy8z+0Kq8cGCpHGNPEkY=
X-Received: by 2002:a05:6512:3b95:b0:4cb:34b5:3196 with SMTP id
 g21-20020a0565123b9500b004cb34b53196mr5651668lfv.240.1675206733264; Tue, 31
 Jan 2023 15:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20230131230105.139035-1-alex.coffin@matician.com>
In-Reply-To: <20230131230105.139035-1-alex.coffin@matician.com>
From:   Alexander Coffin <alex.coffin@matician.com>
Date:   Tue, 31 Jan 2023 15:11:57 -0800
Message-ID: <CA+hUFcu44ONAhJQAdW9w5WRGM5sJcww9oxoRRYdtnY=k1O67Gg@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: fix use-after-delete
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

The above patch addresses a bluetooth crash/issue that we have
observed on our robots. We have tested it for a few weeks, and have
not seen the issue after we applied this patch so not only should this
patch theoretically fix the issue, but it seems to work practically
work for us too. I have pasted the crash below snippet below

Jan 07 15:54:53 robot kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000000000000010
Jan 07 15:54:53 robot kernel: Mem abort info:
Jan 07 15:54:53 robot kernel:   ESR = 0x96000005
Jan 07 15:54:53 robot kernel:   EC = 0x25: DABT (current EL), IL = 32 bits
Jan 07 15:54:53 robot kernel:   SET = 0, FnV = 0
Jan 07 15:54:53 robot kernel:   EA = 0, S1PTW = 0
Jan 07 15:54:53 robot kernel: Data abort info:
Jan 07 15:54:53 robot kernel:   ISV = 0, ISS = 0x00000005
Jan 07 15:54:54 robot kernel:   CM = 0, WnR = 0
Jan 07 15:54:54 robot kernel: user pgtable: 4k pages, 39-bit VAs,
pgdp=0000000060557000
Jan 07 15:54:54 robot kernel: [0000000000000010] pgd=0000000000000000,
pud=0000000000000000
Jan 07 15:54:54 robot kernel: Internal error: Oops: 96000005 [#1] PREEMPT SMP
Jan 07 15:54:54 robot kernel: Modules linked in: bnep hci_uart
usb_f_ncm u_ether usb_f_acm u_serial REDACTED st7701s(O) cdc_acm
rtc_bucha(O) libcomposite btsdio bluetooth ecdh_generic ecc brcmfmac
cfg80211 REDACTED
Jan 07 15:54:54 robot kernel: CPU: 0 PID: 446 Comm: agent-rt Tainted:
P           O      5.4.215-yocto-standard-cv2 #1
Jan 07 15:54:54 robot kernel: Hardware name: REDACTED
Jan 07 15:54:54 robot kernel: pstate: 20000005 (nzCv daif -PAN -UAO)
Jan 07 15:54:54 robot kernel: pc : l2cap_chan_send+0x34c/0xf50 [bluetooth]
Jan 07 15:54:54 robot kernel: lr : l2cap_chan_send+0x314/0xf50 [bluetooth]
Jan 07 15:54:54 robot kernel: sp : ffffffc07ab8baa0
Jan 07 15:54:54 robot kernel: x29: ffffffc07ab8baa0 x28: ffffff806758d500
Jan 07 15:54:54 robot kernel: x27: 00000000000005da x26: ffffffc07ab8bb50
Jan 07 15:54:54 robot kernel: x25: ffffff805368d2c8 x24: 00000000000000f5
Jan 07 15:54:54 robot kernel: x23: ffffffc07ab8bbe0 x22: 00000000000005d8
Jan 07 15:54:54 robot kernel: x21: 00000000000005da x20: 00000000000000f5
Jan 07 15:54:54 robot kernel: x19: ffffff80605e6c00 x18: 0000000000000000
Jan 07 15:54:54 robot kernel: x17: 0000000000000000 x16: 0000000000000000
Jan 07 15:54:54 robot kernel: x15: 0000000000000000 x14: 733276632b373432
Jan 07 15:54:54 robot kernel: x13: 343166322d623730 x12: 3130333230322d65
Jan 07 15:54:54 robot kernel: x11: 7361656c65722722 x10: 3731652d61706f63
Jan 07 15:54:54 robot kernel: x9 : 081a01d101ca6705 x8 : ebde183f0196d44d
Jan 07 15:54:54 robot kernel: x7 : 0140013802304553 x6 : ffffff805368d103
Jan 07 15:54:54 robot kernel: x5 : ffffff805368d2c0 x4 : 00000000000005da
Jan 07 15:54:54 robot kernel: x3 : 000000007fffffff x2 : ffffffc008c88380
Jan 07 15:54:54 robot kernel: x1 : 0000000000000000 x0 : 0000000000000000
Jan 07 15:54:54 robot kernel: Call trace:
Jan 07 15:54:54 robot kernel:  l2cap_chan_send+0x34c/0xf50 [bluetooth]
Jan 07 15:54:54 robot kernel:  l2cap_sock_sendmsg+0x100/0x138 [bluetooth]
Jan 07 15:54:54 robot kernel:  sock_write_iter+0xa0/0x108
Jan 07 15:54:54 robot kernel:  do_iter_readv_writev+0x144/0x1c8
Jan 07 15:54:54 robot kernel:  do_iter_write+0x98/0x1a0
Jan 07 15:54:54 robot kernel:  vfs_writev+0xc0/0x110
Jan 07 15:54:54 robot kernel:  do_writev+0x80/0x108
Jan 07 15:54:54 robot kernel:  __arm64_sys_writev+0x28/0x38
Jan 07 15:54:54 robot kernel:  el0_svc_common.constprop.0+0x78/0x1a0
Jan 07 15:54:54 robot kernel:  el0_svc_handler+0x34/0xa0
Jan 07 15:54:54 robot kernel:  el0_svc+0x8/0x600
Jan 07 15:54:54 robot kernel: Code: f9004fe3 f94047e0 d2800001
f9417a62 (b9401018)
Jan 07 15:54:54 robot kernel: ---[ end trace 35098a74adb57ee8 ]---

Regards,
Alexander Coffin

On Tue, Jan 31, 2023 at 3:01 PM Alexander Coffin
<alex.coffin@matician.com> wrote:
>
> the use-after-delete occurs when the bluetooth connection closes while
> messages are still being sent.
>
> Signed-off-by: Alexander Coffin <alex.coffin@matician.com>
> ---
>  net/bluetooth/l2cap_core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index a3e0dc6a6e73..6cf5ed9a1a7b 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2350,6 +2350,10 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
>                                          struct msghdr *msg, int len,
>                                          int count, struct sk_buff *skb)
>  {
> +       /* `conn` may be NULL, or dangling as this is called from some contexts
> +        * where `chan->ops->alloc_skb` was just called, and the connection
> +        * status was not checked afterward.
> +        */
>         struct l2cap_conn *conn = chan->conn;
>         struct sk_buff **frag;
>         int sent = 0;
> @@ -2365,6 +2369,13 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
>         while (len) {
>                 struct sk_buff *tmp;
>
> +               /* Channel lock is released before requesting new skb and then
> +                * reacquired thus we need to recheck channel state.
> +                * chan->state == BT_CONNECTED implies that conn is still valid.
> +                */
> +               if (chan->state != BT_CONNECTED)
> +                       return -ENOTCONN;
> +
>                 count = min_t(unsigned int, conn->mtu, len);
>
>                 tmp = chan->ops->alloc_skb(chan, 0, count,
> --
> 2.30.2
>
