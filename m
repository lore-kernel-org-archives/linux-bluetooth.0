Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6481C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 14:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344318AbiFJOBY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 10:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349147AbiFJN7q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 09:59:46 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9AF25FC6F
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 06:59:42 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3137eb64b67so71620537b3.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 06:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OWEPC7SAufrCkjFU0SfT1ySX9jvLl/PM1GkMbPRUTlE=;
        b=EVitkBKz9HTETcRAjD4jGW+cco0VlHX2iLKnRGHPQGm6CKoryiObuhFKTAHjd+LGLi
         6zYOTYLEbsUluzdHJgAz9ZvvMk29rs749HjMBKdzGaPX9cgem3LHcsh2HMGSdaxXyRJn
         5YuSeynELes+xuZW7GEs4pT8lndKHz81Wjepfu6WP0UvgZm89gNVRHe/9+00BCNqtxJy
         ETi3leVwScGZNzvk/MJrdTAKM9ui19dbzxWDfS2KaWRhNOArXj3sqyJMln0aBNlmxCwH
         iQBVpK3e0RfcWIOTE3ebm+YXYmyEWbN0WcotgIMyCtpJbrsoD5JWvelbGJQWnS6mCwe5
         EGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OWEPC7SAufrCkjFU0SfT1ySX9jvLl/PM1GkMbPRUTlE=;
        b=Co1mpLjz1E1MgqB8Qa/9K00BDUyGlRqiywSyCuZSCswlEzy/xb8t1g5EPZZPdlnx4c
         oOqBqMSncliWcHAhwjcP9fS7BGNY/zbxNmyaF2fd8e+ZJt0SLu6IVXQRkMB10xkR+uWT
         ZutmR7SqLHlSSTSBwwh5NkAJ9w9qchwj8MB5LjbC/obun0L58YgIN5JBqZXbHsN8Q6AK
         8/pPmc9DxXKjaFcYhic4fpyIisN/jKPDNR6rrOme2zKDDlwohxeNOigcZGEpWmsmNNHE
         NVfpMg+uBCmud6+aKMmojz4+xMyvZ42bSrf0lObqEZey05mgdgxBwByWhWcwF83cdLdk
         Bd+g==
X-Gm-Message-State: AOAM5317rl5oNBjQTe8A7kxuWaclMEsq+Nk6nbThzUKBgB6ek4iF7Iav
        333tiiBG+UliEO3uciwHdcBnndq4CiuGo9fSzvm6Xw==
X-Google-Smtp-Source: ABdhPJzpokt62wF8w51PGFxOhJ4bvWwLARVlE5z03nqvvSEUQRP60Ws5kIgElWNEyhTSKx+UNMTvrNFzYJ1PAxe6uqw=
X-Received: by 2002:a81:7b86:0:b0:310:e75:3abb with SMTP id
 w128-20020a817b86000000b003100e753abbmr42924798ywc.332.1654869581103; Fri, 10
 Jun 2022 06:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220610110749.110881-1-soenke.huster@eknoes.de>
In-Reply-To: <20220610110749.110881-1-soenke.huster@eknoes.de>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 10 Jun 2022 06:59:29 -0700
Message-ID: <CANn89i+YHqMddY68Qk1rZexqhYYX9gah-==WGttFbp4urLS7Qg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: RFCOMM: Use skb_trim to trim checksum
To:     Soenke Huster <soenke.huster@eknoes.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jun 10, 2022 at 4:08 AM Soenke Huster <soenke.huster@eknoes.de> wrote:
>
> As skb->tail might be zero, it can underflow. This leads to a page
> fault: skb_tail_pointer simply adds skb->tail (which is now MAX_UINT)
> to skb->head.
>
>     BUG: unable to handle page fault for address: ffffed1021de29ff
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     RIP: 0010:rfcomm_run+0x831/0x4040 (net/bluetooth/rfcomm/core.c:1751)
>
> By using skb_trim instead of the direct manipulation, skb->tail
> is reset. Thus, the correct pointer to the checksum is used.
>
> Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
> ---
> v2: Clarified how the bug triggers, minimize code change
>
>  net/bluetooth/rfcomm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 7324764384b6..443b55edb3ab 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1747,7 +1747,7 @@ static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
>         type = __get_type(hdr->ctrl);
>
>         /* Trim FCS */
> -       skb->len--; skb->tail--;
> +       skb_trim(skb, skb->len - 1);
>         fcs = *(u8 *)skb_tail_pointer(skb);
>
>         if (__check_fcs(skb->data, type, fcs)) {
> --
> 2.36.1
>

Again, I do not see how skb->tail could possibly zero at this point.

If it was, skb with illegal layout has been queued in the first place,
we need to fix the producer, not the consumer.

A driver missed an skb_put() perhaps.

Can you please dump the skb here  ?

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 7324764384b6773074032ad671777bf86bd3360e..358ccb4fe7214aea0bb4084188c7658316fe0ff7
100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1746,6 +1746,11 @@ static struct rfcomm_session
*rfcomm_recv_frame(struct rfcomm_session *s,
        dlci = __get_dlci(hdr->addr);
        type = __get_type(hdr->ctrl);

+       if (!skb->tail) {
+               DO_ONCE_LITE(skb_dump(KERN_ERR, skb, false));
+               kfree_skb(skb);
+               return s;
+       }
        /* Trim FCS */
        skb->len--; skb->tail--;
        fcs = *(u8 *)skb_tail_pointer(skb);
