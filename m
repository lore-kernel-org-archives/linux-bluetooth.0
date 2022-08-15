Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC48C00140
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Aug 2022 17:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiHORsz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Aug 2022 13:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHORsz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Aug 2022 13:48:55 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0271C286DA
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 10:48:54 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x19so11580142lfq.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 10:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gF0u4R/H78VEsnpCrdxAEFIwdpMB5aB135pUWQHymsk=;
        b=UDFQ038Tq47b+cyfFo2Gp1U+cQzZMGi1LQRfBg2+dl7H3JAHHGL5Vbz10Q9QwZkpqG
         2ZPJ0GHvuhIKWA/2L6/xwSn4t1tXQnsNvAXwKf6Uobv82ozdf4FZYkCRpKJI7JYLCxRK
         6lCzsjUAHxNiyIAD0HvLuwgFiijTeR7X6od6w1EANLmJ9LK/7Iw5moiXA2n7NNcOntMB
         llpoUB7Ao8hHB4XyI4XtRiwHfWpT9xTjZhfs8L1NyXt8JOtcjWbyHWU0oFA5l+uaxbhi
         /yDT8qHxNnDmI4Oeajenk1cydu7rDmizb+FAzwvwLpUEVzpiD41O0Zsr0K/fTDW63OEg
         tuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gF0u4R/H78VEsnpCrdxAEFIwdpMB5aB135pUWQHymsk=;
        b=AjOlcMpnfCHwQe6KispzOzOLnup0SbDY5ca5gfpwIRpy3w1uLdPFUfZvZekTBS8J/Z
         5uDhD7/FYmo6wsm/2nfpgQpqjZUn1wsDOb7kAF/zhjRPiQGdPVQ8479rH5LSxvVy2pfG
         2sV2iHpdgMRUlEe4PPqkBrDBLYWJy1xIT2FrEOzNAr9RStEF6BXzuT8MkxsMihPTd1dq
         n29wd2ONuvQa3cF27YHfwQGbQrX8aNOGnfd/vN7GwDeLcs/3U4JXREhhlV1qE7pZDsV5
         BIV0rpPH1c9wcWBQhQ9mCkUelLkQ0JJgW+64Z7oLYy0N55fA3yDW3FuRL6209UgK0ria
         YLNA==
X-Gm-Message-State: ACgBeo1nNx1N14ds3Vg/xdfJf12Zwf+IgPB/ejB2G/8j5veehjOKeFej
        +tkselWK4WOz/l7sUOq5CSu3KViSKbID1sEgZBbGwLj9dts=
X-Google-Smtp-Source: AA6agR56H1I0ewddsPXE643mxqCClBHAZ3dOfMIoh7NEBSY4XhxMH8s4btwwsGnWKXSGsjzJ1XblZylypAgjDdKTy3A=
X-Received: by 2002:a05:6512:22ce:b0:48c:190f:5c37 with SMTP id
 g14-20020a05651222ce00b0048c190f5c37mr5604668lfu.564.1660585732126; Mon, 15
 Aug 2022 10:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220815031332.64190-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220815031332.64190-1-ye.xingchen@zte.com.cn>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 Aug 2022 10:48:40 -0700
Message-ID: <CABBYNZJnd4+ZPD+17=9-fzLbnNhGZzStDfdcxptJR35SGGdb7A@mail.gmail.com>
Subject: Re: [PATCH linux-next] Bluetooth: hci_conn:Use kzalloc instead of kmalloc/memset
To:     cgel.zte@gmail.com
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sun, Aug 14, 2022 at 8:13 PM <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> From the coccinelle check:
>
> ./net/bluetooth/hci_conn.c
> WARNING  kzalloc should be used for d, instead of kmalloc/memset
>
> Use kzalloc rather than duplicating its implementation, which
> makes code simple and easy to understand.

Would you please add Fixes tag since we probably want to apply to rc series.


> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  net/bluetooth/hci_conn.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 337e74d0f8b1..184c790af045 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -824,11 +824,10 @@ static int hci_le_terminate_big(struct hci_dev *hdev, u8 big, u8 bis)
>
>         bt_dev_dbg(hdev, "big 0x%2.2x bis 0x%2.2x", big, bis);
>
> -       d = kmalloc(sizeof(*d), GFP_KERNEL);
> +       d = kzalloc(sizeof(*d), GFP_KERNEL);
>         if (!d)
>                 return -ENOMEM;
>
> -       memset(d, 0, sizeof(*d));
>         d->big = big;
>         d->bis = bis;
>
> @@ -861,11 +860,10 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, u16 sync_handle)
>
>         bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big, sync_handle);
>
> -       d = kmalloc(sizeof(*d), GFP_KERNEL);
> +       d = kzalloc(sizeof(*d), GFP_KERNEL);
>         if (!d)
>                 return -ENOMEM;
>
> -       memset(d, 0, sizeof(*d));
>         d->big = big;
>         d->sync_handle = sync_handle;
>
> @@ -2034,7 +2032,7 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
>         if (hci_dev_test_and_set_flag(hdev, HCI_PA_SYNC))
>                 return -EBUSY;
>
> -       cp = kmalloc(sizeof(*cp), GFP_KERNEL);
> +       cp = kzalloc(sizeof(*cp), GFP_KERNEL);
>         if (!cp) {
>                 hci_dev_clear_flag(hdev, HCI_PA_SYNC);
>                 return -ENOMEM;
> @@ -2046,7 +2044,6 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
>         else
>                 dst_type = ADDR_LE_DEV_RANDOM;
>
> -       memset(cp, 0, sizeof(*cp));
>         cp->sid = sid;
>         cp->addr_type = dst_type;
>         bacpy(&cp->addr, dst);
> --
> 2.25.1



--
Luiz Augusto von Dentz
