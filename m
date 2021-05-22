Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD47DC04FF3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 May 2021 00:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A682061152
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 May 2021 00:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhEVA1L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 May 2021 20:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhEVA1K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 May 2021 20:27:10 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86251C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 May 2021 17:25:45 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id y36so13165575ybi.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 May 2021 17:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=575ZUJRb23YVtgDvrzJO6zc3GCFkfvva9/KckiR8Rog=;
        b=FflsKT9lCPimXb0Ke0DgXOC7XT0hBFrzr16zosJJT1NSU7UuRsH5qml3aoX+sg09rZ
         QM7X9dtqn5Sr6BzzK3tfR90yZNSW86zeWPfxv0iMJxeENxCdp6/ZHnBOCEX99ENHPmr3
         ToyM4vKr+UNY6tCK3Q0UDg4Q/TkBbAbVe1vYNwWWcmSvQhvYLQNfS0WZuM0GzqfYy/Y/
         2oJFyrmQK2F5BPoTuinr5iTuGNhx5fbSSMUIddkuEVu1LZw95pDrjnB9bDU4NBmi90KT
         lBxXucC0m3PTivxI6USKzPNEEeb+NeUDYk59zFUj3ynBoHsGJ+sotA8JSEkTh3MMP7qr
         BYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=575ZUJRb23YVtgDvrzJO6zc3GCFkfvva9/KckiR8Rog=;
        b=BW0GjWSpppUYM+H5GuzGlFvqBqe/GHseUa0tZXiZhzwDQecY7covHOSPo+EbFWaBvg
         pbhZt3kD/9KwMy+7mO0MgnXiIjSuqJCn9uD/N29gIpTyctnLfaALEKVjLrDeFky3PIfx
         uvBTO+KPd/zQygA18Q4hT98RfMXzsULYHWSCUFW8MKMPVQcuN7DLW5sl7OGowAPLvFaU
         bsA11Ljz74/9dcy8d0V6eZkv1F2sCgsxU0u5ckwIwPTQRiQcCivYqKuWttKTvszYXsPZ
         7c+UV93/E+xSjjurAgP5CBjyhaP5GLRuuz4cYpgtMplSmXqL0tqkVxPO5FKx6EzNdLtY
         Sizw==
X-Gm-Message-State: AOAM531pAkI2+2gKnpDiGBFWBLOJTZ6czekqZzqUjhyCmQIk2vF/Hhbn
        7OG/gvzI/saK4bt2+xfNnI29b1ozPz2Ne/ipiK8YnWLl
X-Google-Smtp-Source: ABdhPJyau7sHejmC9NqsJtMcsitLGQS+u8Sy5HykohRqy2kPnkHZSbjx9G+ZGio++v1Bfk41jAERQMJDgyVYYr+eCJo=
X-Received: by 2002:a25:9a04:: with SMTP id x4mr19029036ybn.440.1621643144829;
 Fri, 21 May 2021 17:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210520092200.14937-1-eh5@sokka.cn>
In-Reply-To: <20210520092200.14937-1-eh5@sokka.cn>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 May 2021 17:25:33 -0700
Message-ID: <CABBYNZK0tmCaAKjLS3s-yndRnmsQsaurOnx7-ffa_QyQ_7BgYQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3] avrcp: Fix unregister AVRCP player
To:     Huang-Huang Bao <eh5@sokka.cn>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Huang-Huang,

On Thu, May 20, 2021 at 7:44 AM Huang-Huang Bao <eh5@sokka.cn> wrote:
>
> 'notify_addressed_player_changed()' expected to be called with
> 'player->changed_id' set to a non-zero value.
>
>     player->changed_id = g_idle_add(notify_addressed_player_changed,
>                                     player);
>
> And 'avrcp_player_event()' relies on 'player->changed_id' to perform
> Addressed Player Changed notification. However,
> 'avrcp_unregister_player()' calls 'notify_addressed_player_changed()'
> without adding it to the main loop and set 'player->changed_id'. To
> indicate addreddsed player changed for both scenarios, we set
> 'player->changed_id' to 1 at the head of
> 'notify_addressed_player_changed()'.
>
> Fixes https://github.com/bluez/bluez/issues/142
> ---
>  profiles/audio/avrcp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 58d30b24d..ef721e17b 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1794,6 +1794,12 @@ static gboolean notify_addressed_player_changed(gpointer user_data)
>                                 };
>         uint8_t i;
>
> +       /*
> +        * Set changed_id to an non-zero value to indicate addreddsed player
> +        * changed.
> +        */
> +       player->changed_id = 1;
> +
>         avrcp_player_event(player, AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED, NULL);
>
>         /*
> --
> 2.31.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
