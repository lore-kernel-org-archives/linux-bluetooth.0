Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86835C38142
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Jan 2023 23:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjAaX4y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Jan 2023 18:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjAaX4x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Jan 2023 18:56:53 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A10319684
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 15:56:52 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id u12so16234577lfq.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 15:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pXuNtBF2yoeuzZ/TDiZButCnUew9Y8SGLIehMt1n9j8=;
        b=TT/OiW4Xi0CaIrq9zlraK864mBnNsSLL+qiIEvKMQ+Fk06Vi5bgzdkklF0Bl2ymtVT
         HcgKec6Ah5ixOyy10c5gEkDZIRpLspJyjSs2GBcJGBOcyxd2BNvUEOIpkrSZ6oj2pxwS
         poo+3H+aZQdzk75zv8BoKNeTYtHCQs3eCZfOX3rXkkYZlTTnJEblJN+3fQfiaBD5ZSup
         gxn/wL1GOBf/PNlrUtil0nJ002C8uxARTjkWp7+CRJdLYKBR06h8GrPKdfIB83FL+K57
         nGuVeARcuQ0sMTiSByO/H31LkeZzGnksy5BXfI2SJ/mveRNxSWAa6Mdw3P/WvtWqZtsT
         seRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXuNtBF2yoeuzZ/TDiZButCnUew9Y8SGLIehMt1n9j8=;
        b=eh0EsKOFq4m5FED0tEVT5i79+VvSnAYJ5tUKloZ8jYGveziBBKawaewwPLIi8zna/5
         kK4s2NybbX+ahtR9M2ugfxFKstxGFdcFR/aLADCchNRr9+Va8O/+idbk167uBFlUVkUH
         tImUQjuLZtA0ldu4Q/IY5YnlqtgopCxQs4j7v5FHuxcdWVwwhLxV+Z51GYMtU95KSdEx
         w0G/MJ8WYkNa0yXySEvRxC+XzW3xhiQ0l++hQ9heDuRKn5qlVTYlnoZ8cpSKEYUZU60e
         yq+3YzHa+sixUo5gleIK9dkKwgdFD/2vcheI24JhDQJPW5QtJTf23Wshc5qjgcwUcJdZ
         IJyw==
X-Gm-Message-State: AO0yUKWk/hy70SrfELvai8yOBUAG5veOTVI/Jv+26Qs3KpOckC51LD5q
        9iRQKV3QaaEVpbg48Sl7bP+1FTpQf2UxTz6N4quUQWiBua8=
X-Google-Smtp-Source: AK7set9fP6nDJ1TQPIhVzmi6u4rK3qbKgWeaQ4zbpRwK4CTOF0pPACFHw3A1w97EFeFSTmi2x4a5nJFQTZ5I1om2oH0=
X-Received: by 2002:a05:6512:21c:b0:4b5:7d38:a636 with SMTP id
 a28-20020a056512021c00b004b57d38a636mr12219lfo.109.1675209410551; Tue, 31 Jan
 2023 15:56:50 -0800 (PST)
MIME-Version: 1.0
References: <20230131230105.139035-1-alex.coffin@matician.com>
In-Reply-To: <20230131230105.139035-1-alex.coffin@matician.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 31 Jan 2023 15:56:39 -0800
Message-ID: <CABBYNZ+wXYH8vag6Xk2X7U7U096_YENasq1cPCEo-0SD5ut_wA@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: fix use-after-delete
To:     Alexander Coffin <alex.coffin@matician.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alexander,

On Tue, Jan 31, 2023 at 3:02 PM Alexander Coffin
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

How about if we do it at l2cap_sock_alloc_skb_cb:

https://gist.github.com/Vudentz/3a1d8c4c3a80e9490ff98118fb135656

Since that is where we do the unlock to allocate the skb and then lock again.


-- 
Luiz Augusto von Dentz
