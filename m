Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6765FC433E9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 03:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2876822B2D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 03:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgLVD1i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Dec 2020 22:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLVD1h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Dec 2020 22:27:37 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1ABC0613D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 19:26:56 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m25so28584559lfc.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 19:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DuYh69TS1gggLotCn6ERQcD55cxnc82V29wS9VHcJs=;
        b=WdJDWBFZxJ1uV3TfY51XO/idtHjYEIQPxRxDXv6oiW9yM6d7H70ZTkUAINBtJEzQHa
         vJS8JXiyFU76yxGYTeo8/QLRtGgsyUzN5GQzt5Lbe6xnNEQ/POe9PIjNdi2qqsjzyxJp
         YragRbGE+erGUY/5wZsROIPbKDen6IicXMsxDkCD0q4jx2fuJSuQNqJ7Co3ZTAg4P6lC
         DU/t21uYsSJXoKdqxbf0r2x/2enmPhpop4f+5Q2rDUx+E96cspGugwxSjmvuA9RsLPM4
         l1E4GrOj7hrOFWKM2OU5O/97vCKDQg4M7Cch3HQ9jlaDypfKHokibzBoeIv7Gukxs5/Z
         OY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DuYh69TS1gggLotCn6ERQcD55cxnc82V29wS9VHcJs=;
        b=X1s7lxmdbKQIO77lv3BBbqHzKKNm1Eo+IO9EzHqJaLyzlEEMKRs2TuFjYa5aykBwpD
         hZKKc10FUmerCZ/ZJ2grei95F/HqYnBzgP+/gMAejMw2nAOjkDvpKgMya9s+juw2MrDj
         LytDbpMIXGDaPquEzyHfOBqoUmHPZ8HVmUEAUkdFgiK8zdoeP0ymIdVrJJR12yFLSoy5
         g5Oumgjg0RxMfhC2ayNnNYuCCovxUNaFq8ZFxyNxkj2cJf5IYJcA02bwGl6IvZ3uWXfE
         GPl2e6BYpqwuF6vYvaZHUKLDoD1mBt9/ac3y0/Dt7i3dd9noIN3WPt1OukqwB8gm3DsH
         BUqA==
X-Gm-Message-State: AOAM532qMBgYW1gn5Pj+EfZ42pABLN6wUrZ4/5ALuyap1Z1RVKIp7SJF
        /cdhFR0Z0vcngx6WtnGSljyV63ApOeXxtlSyvnin6g==
X-Google-Smtp-Source: ABdhPJyydnV50sAF97g4pkHQR5JB1TgCTbhsPNMp+KFO7FBqrNHPukIGxBtqgi+y+1PLSGMSyPHdJvYMBUw1iSbyhzs=
X-Received: by 2002:a2e:9053:: with SMTP id n19mr5967972ljg.283.1608607615185;
 Mon, 21 Dec 2020 19:26:55 -0800 (PST)
MIME-Version: 1.0
References: <20201216043335.2185278-1-apusaka@google.com> <20201216123317.v3.4.I215b0904cb68d68ac780a0c75c06f7d12e6147b7@changeid>
 <73E2D097-F8D4-4BFA-8EC1-C04B079F1BFC@holtmann.org>
In-Reply-To: <73E2D097-F8D4-4BFA-8EC1-C04B079F1BFC@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 22 Dec 2020 11:26:44 +0800
Message-ID: <CAJQfnxHrvnsLRDHNFWAN9uPJmWiTpE6x4YAmgs77KO6QQBFW7w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] Bluetooth: advmon offload MSFT handle controller reset
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, 21 Dec 2020 at 17:12, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> > When the controller is powered off, the registered advertising monitor
> > is removed from the controller. This patch handles the re-registration
> > of those monitors when the power is on.
> >
> > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> >
> > ---
> >
> > (no changes since v1)
> >
> > net/bluetooth/msft.c | 79 +++++++++++++++++++++++++++++++++++++++++---
> > 1 file changed, 74 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
> > index f5aa0e3b1b9b..7e33a85c3f1c 100644
> > --- a/net/bluetooth/msft.c
> > +++ b/net/bluetooth/msft.c
> > @@ -82,8 +82,15 @@ struct msft_data {
> >       struct list_head handle_map;
> >       __u16 pending_add_handle;
> >       __u16 pending_remove_handle;
> > +
> > +     struct {
> > +             u8 reregistering:1;
> > +     } flags;
> > };
>
> hmmm. Do you have bigger plans with this struct? I would just skip it.
>
This struct is also used in patch 5/5 to store the "enabled" status of
the filter.
Suspend/resume would need to enable/disable the filter, but it is not
yet implemented in this patch series.

Thanks,
Archie
