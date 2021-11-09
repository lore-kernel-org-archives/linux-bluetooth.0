Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6246C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 23:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF2D610F8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 23:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbhKIXQL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbhKIXQK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 18:16:10 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C959C061766
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 15:13:24 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id b3so1023509uam.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Nov 2021 15:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNBlkyCfDq9pVW5kW5Bl/ZDUnuVfkvlAxyA5xr2Xf1Q=;
        b=Fpx8m9oKe3uyyaRAY/ExGIjwkpUJwAtPb6DqhS5w07r7u9oHE8/5bdRiwlhX86Wx1Z
         sKIaXYteg29YI+AZc/XOFuDBFKccRRnKiuOaK4Q7g5ZwhK0o88c3+O6HV6GDaejx0Dj4
         bbnE5YWY+dBwa6red1int5Powh/eNN3ieq3NY52bVysB4T8rG9vMmCoMAfluW+sAtlly
         rE51StE7GZr5XTgr27OOJ2zxzWsHR0/4MpVva/uLhFU/BABz8uCL8D93a2BYT9KpV0Im
         +0FMKRTmbmgN75dp1a4EN9Ha1OEpgk+FIvGWaJ5VunM9+Vz6pnBepsuod4K+9GJHxgFX
         nYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNBlkyCfDq9pVW5kW5Bl/ZDUnuVfkvlAxyA5xr2Xf1Q=;
        b=DE00jeNlo92HJZANm7Cx5Qz3FPsuZ/eINqt6mK5LKrAn1tbLrnSNgUNqKoKafcamGj
         9+3w6EQcP85Je8SC8H54atOt7qjQf+tbHUVMmih3LJts/4aZTJKWQEhJ1Z5kMipidxN4
         5mjkRmZnjxPICnHBAXrS6tuEODhi848WL6vDqJsA60dQY/3qcf220OacK02EYUM7wVKT
         is71gvo9B8+GEoO57pNkHLDFRyY3rAHNxuQFF91sNoylsz6XDBi2fJAIxrsZIFQy3cuK
         tyP2nkWfUMeGtRkYx2M2lsHmWRv6kTpJ2Yme0Vqroho1KNIlzvtPNJOf1c6K7QVNUm0c
         /uvg==
X-Gm-Message-State: AOAM532MZ0ljpEMgEAgwWGK8GF562aPukE24ikAXV+KcNZCKuRAySCaJ
        Y9mxGzPrU/cY2bC8YTjN02pCSZusrP1jYYbqS5Y=
X-Google-Smtp-Source: ABdhPJxCWH3qPklEpmEahw81EONlBgbT6DN/DnqW9FNKPis7Bl57xAPWAJmyyekehGPfDEH4K9/mO3B/b1C7wFyqvrY=
X-Received: by 2002:a67:b844:: with SMTP id o4mr125542735vsh.61.1636499603057;
 Tue, 09 Nov 2021 15:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20211109164113.65981-1-benjamin@sipsolutions.net> <20211109164113.65981-4-benjamin@sipsolutions.net>
In-Reply-To: <20211109164113.65981-4-benjamin@sipsolutions.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 9 Nov 2021 15:13:12 -0800
Message-ID: <CABBYNZJ2mXOTQygWWgHMN+pkqYoY_cudqrbW6aOHozo7soUZhA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Bluetooth: hci_core: Signal TX failure if sending a
 frame failed
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Benjamin Berg <bberg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Benjamin,

On Tue, Nov 9, 2021 at 2:35 PM Benjamin Berg <benjamin@sipsolutions.net> wrote:
>
> From: Benjamin Berg <bberg@redhat.com>
>
> Call the hci_tx_error handler in case a frame cannot be send.
>
> Signed-off-by: Benjamin Berg <bberg@redhat.com>
> ---
>  net/bluetooth/hci_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index bbb35188e41f..8664c2fbacdb 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -4200,6 +4200,8 @@ static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
>         if (err < 0) {
>                 bt_dev_err(hdev, "sending frame failed (%d)", err);
>                 kfree_skb(skb);
> +
> +               hci_tx_error(hdev, -err);

Either we do this here by calling directly hci_cmd_sync_cancel like I
suggested previously or perhaps we should have the error returned by
hci_send_frame otherwise the current thread still has to wait to get
the error from req_result which perhaps is not necessary if we already
got a proper error here just return it so the thread doesn't even need
to sleep.

>         }
>  }
>
> --
> 2.31.1
>


-- 
Luiz Augusto von Dentz
