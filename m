Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960AFC352A1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Dec 2022 17:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbiLFRP3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Dec 2022 12:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbiLFRPR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Dec 2022 12:15:17 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117D6391D9
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 09:15:15 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bp15so24678726lfb.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Dec 2022 09:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dbJeToAlH8JV+iVCT9FP8KbfJIfYeM3PERi1ojwPcf0=;
        b=Q721oaCZT5wK3enV129a0hu68G/RR1GihckEAH6AYl19v0YWMWF/lk+ItqepQExFpO
         EiimaAoyYQt7yRaofJUg2ovvM3G2WGCSTniR938tTgtCJvdliSvcVrB0b7GeC4n6O24h
         eKcYexbHzI6f0A7soWgMhP4w1MSg+qG0m6TZBKnr2zBY7oiQhRXE2wKLusnFAyftejTy
         tSWg2o0TrI+K/nTBJes/rtS3DB2ojkqaKBjoqgx5e9hkcX9LaFGnUy4ppfO/agXb0HdK
         c4ydeiQeEqHxmKIb4d1kJyGUuaYQEI4+ChlNFa7A0xbHUzlwtE9Jm3w449TInDhZ56Ri
         WVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbJeToAlH8JV+iVCT9FP8KbfJIfYeM3PERi1ojwPcf0=;
        b=sj4APOxrIJNyvm9nYhzaUfa55qzd9nP7MD5xPwZWD7fDmr2OqcRFe/NVc/+cHCUox5
         vynJoTulZ7lVRVSGP5eIIpI5gkJyLm59h9Q0wl3SZAfoZhRaWQzC9h1/EKxAdIf4/CNo
         2xMtla6esMxge+d/s3tENXQVKqOBpEai5ZcF5Rj6HgtsNkM/552gdROKQK1VfrJINc/4
         rZxWoADN/nOt3CiqZTQfh3RAisfScPNks/sUZTNl5Yir/XKN10ivDigawfaT1uaihHeC
         rd3VvwEBk5etbSJDGuIixc4GA0w1BQF0LwE7DVXrxFxfSnA9G7drsw4hxh1sslhxDh0N
         7qjA==
X-Gm-Message-State: ANoB5pl6asGO+mLGQ8lnpylT4wYLZCqZv98354GVxa/p1CSrpCMvzB21
        vyADDDrVqKsk1uu2OSgJNojrhWNoThq11FTzeno=
X-Google-Smtp-Source: AA0mqf52L/A5TbvxAWZi2CNSvAF7hs3tZ0gSdb7ju/xemEBEfKRB23ocnWDf0nPqA1QQnJq9Xb2EtdszNaOC63gDCl4=
X-Received: by 2002:ac2:4e07:0:b0:4a2:2a60:ecf5 with SMTP id
 e7-20020ac24e07000000b004a22a60ecf5mr30924845lfr.57.1670346913190; Tue, 06
 Dec 2022 09:15:13 -0800 (PST)
MIME-Version: 1.0
References: <20221206125910.2170554-1-yangyingliang@huawei.com>
In-Reply-To: <20221206125910.2170554-1-yangyingliang@huawei.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 6 Dec 2022 09:15:01 -0800
Message-ID: <CABBYNZKwVkaJ_N=r+wKv-H1P65ty-+nu+nBgcjOv09f=-Q1nmg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: don't call kfree_skb() under spin_lock_irqsave()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yang,

On Tue, Dec 6, 2022 at 5:01 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> It is not allowed to call kfree_skb() from hardware interrupt
> context or with interrupts being disabled. So replace kfree_skb()
> with dev_kfree_skb_irq() under spin_lock_irqsave().
>
> Fixes: 803b58367ffb ("Bluetooth: btusb: Implement driver internal packet reassembly")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/bluetooth/btusb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 271963805a38..772f2b0cb10d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -802,13 +802,13 @@ static inline void btusb_free_frags(struct btusb_data *data)
>
>         spin_lock_irqsave(&data->rxlock, flags);
>
> -       kfree_skb(data->evt_skb);
> +       dev_kfree_skb_irq(data->evt_skb);
>         data->evt_skb = NULL;
>
> -       kfree_skb(data->acl_skb);
> +       dev_kfree_skb_irq(data->acl_skb);
>         data->acl_skb = NULL;
>
> -       kfree_skb(data->sco_skb);
> +       dev_kfree_skb_irq(data->sco_skb);
>         data->sco_skb = NULL;
>
>         spin_unlock_irqrestore(&data->rxlock, flags);
> --
> 2.25.1

This sounds like a better way to handle in the following set as well:

https://patchwork.kernel.org/project/bluetooth/list/?series=701842

Could you please rework the entire set to use dev_kfree_skb_irq?

-- 
Luiz Augusto von Dentz
