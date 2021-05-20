Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DE6C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 05:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8A2610A2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 05:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhETFqY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 May 2021 01:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETFqX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 May 2021 01:46:23 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B2C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 22:45:01 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id b13so19810204ybk.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 22:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9eX6MRfmU7YZT4/lh7sEk8uNFshLDy/EqdNsiCD78nA=;
        b=JbPswZWwfkMCGuDoW9NZknaa9GW6dSebdDp3ZwtCk/ac4XCA9H1kJ0iBLYPQbq1IHR
         W7igFmr6crO73RKjv3A4BsCbT41ryzuUG2fIeYKF9giJWYOi6wazgqNJdNRAFJu6Hdil
         +8TA5oOMfEvAd66fzUtjghnrpxhD5YJypMDMvc+tzj16+he6FbZXe6bjruN/M5twosB+
         3FTWoCgcLRBUXUvG7JjT1+tiHhQq7y6jdwNZiOvPjadOahT57TyutAjhJSR8cGa4/fSf
         4p1pkQ1rMa+V9nfH/tqTr4fpwwjKklwkbYl7wy3j36wYhhgsCxvmsYACMG5s2QU+9kYm
         0Mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eX6MRfmU7YZT4/lh7sEk8uNFshLDy/EqdNsiCD78nA=;
        b=rD0qNnSOZ3l4hSvU9p100SwEbUP9Y+E0n8Ms2ZQk7t306+552WEDfLp/zEFrQGorIK
         Ak/n3GxLfyXyaJvUfqAVAts5ZcfBURY3FKWL8ivdxQaSqqp5kV870tVPaf4z7r0XSAzZ
         yNtcZtoqek44MrAsZPKFO8s3qIR/MscOLAImnPCF/k95BNbK02lnIJibh07mOmLe+FpK
         6NEyBwfZqEkoJNsGmbaYkCNy+d+fIJzg9Mv2KkvuQ5bJiDurrkpCiccu5rKJclm74bGx
         Wh4inQPHScLn+t2vAD2kuXqnTTMh0VUk6EAI6rS7QNYB3JG8jIJjujzCr4yj1hPfNJWx
         8btg==
X-Gm-Message-State: AOAM531taJnyDJDUnFV0mW16wNgkFYWo8UxD2R32EkuXRxUvRfrPP6l7
        fFIDDgi5kx6loTov9eNe6N5OlX0OJzPFHA97PWHmSTY/
X-Google-Smtp-Source: ABdhPJz93zxYqkBRBNN0yLehDkLUGgxH1Xk4KYUqlpNTlkAfFXkjhXUH5D7EulnKo3hFmSUUoCGFb5XR37xFWFRR6QY=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr5034338ybu.282.1621489500989;
 Wed, 19 May 2021 22:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210520041142.332534-1-eh5@sokka.cn>
In-Reply-To: <20210520041142.332534-1-eh5@sokka.cn>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 May 2021 22:44:50 -0700
Message-ID: <CABBYNZK_Wtc5VfQqojkpb7SzD9ueO8h_k8y7WxvFp=y7poNn_Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] avrcp: Fix unregister AVRCP player
To:     Huang-Huang Bao <eh5@sokka.cn>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Huang-Huang,

On Wed, May 19, 2021 at 9:14 PM Huang-Huang Bao <eh5@sokka.cn> wrote:
>
> v2: fix commit message & code styles
>
> 'notify_addressed_player_changed()' expected to be called with
> 'player->changed_id' set to what 'g_idle_add()' returns.
>
>     player->changed_id = g_idle_add(notify_addressed_player_changed,
>                                     player);
>
> And 'avrcp_player_event()' relies on 'player->changed_id' to perform
> Addressed Player Changed notification. However,
> 'avrcp_unregister_player()' calls 'notify_addressed_player_changed()'
> without adding it to the main loop and set 'player->changed_id'. To
> make 'notify_addressed_player_changed()' can be called without set
> 'player->changed_id' flag. We add antoher flag
> 'player->addressed_changing' to indicate addressed player changing.
>
> Fixes https://github.com/bluez/bluez/issues/142
> ---
>  profiles/audio/avrcp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 58d30b24d..5058a6848 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -239,6 +239,7 @@ struct avrcp_player {
>         uint8_t *features;
>         char *path;
>         guint changed_id;
> +       bool addressed_changing;
>
>         struct pending_list_items *p;
>         char *change_path;
> @@ -792,7 +793,8 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
>
>         DBG("id=%u", id);
>
> -       if (id != AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED && player->changed_id) {
> +       if (id != AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED &&
> +                       player->addressed_changing) {
>                 code = AVC_CTYPE_REJECTED;
>                 size = 1;
>                 pdu->params[0] = AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED;
> @@ -1794,6 +1796,8 @@ static gboolean notify_addressed_player_changed(gpointer user_data)
>                                 };
>         uint8_t i;
>
> +       player->addressed_changing = true;

Well we could just set the change_id manually instead since it is
anyway set to 0 in the code below which is equivalent to what you are
doing here.

> +
>         avrcp_player_event(player, AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED, NULL);
>
>         /*
> @@ -1804,6 +1808,7 @@ static gboolean notify_addressed_player_changed(gpointer user_data)
>         for (i = 0; i < sizeof(events); i++)
>                 avrcp_player_event(player, events[i], NULL);
>
> +       player->addressed_changing = false;
>         player->changed_id = 0;
>
>         return FALSE;
> --
> 2.31.1



-- 
Luiz Augusto von Dentz
