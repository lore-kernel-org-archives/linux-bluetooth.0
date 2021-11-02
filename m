Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B1DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 06:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946E660EB9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 06:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhKBGQM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 02:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhKBGQK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 02:16:10 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAE2C061714
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 23:13:36 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id v20so35968272uaj.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Nov 2021 23:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G6Yad7puWQwWtkvh/WEGeT+Dug1fEBf8eSfMTl14pcc=;
        b=dwqFaBbqAjHfflqB16RlY3Rz3Sa0zHjh2SrLXP4C4tF98GTEx25ylTkFECQBL8yVAs
         AflvymD81VBlJueSsJCrNu69+QSIGryFPC045gKNiN/+TdCNtmIrQi1YMpmHM6gI7YHk
         zaQleSezaOUnIaEig6aIQ68rRGShB4wg1nhiPFASsPVRLqZ85BY/mpvETtFxBWd3irzF
         2aHA7lj6SSR6FQVFWSH6PBTAg/mRhAnNbb1uXV43yTzRCO22QR7u0Ry/zKJ8h1cDsZkT
         txIHRbLNYXDt4T1ddD4aUe2gUuChByfAvUR4ge3JJ5d0xli1XWxllTmEAzWK2N8suZzW
         tdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6Yad7puWQwWtkvh/WEGeT+Dug1fEBf8eSfMTl14pcc=;
        b=ZiOSa+xolNCQtGBwH2i0FBYhXApeGy3/AOEPjBQPAH4UgnAZw1OQo1ZU/rfqtJOzoJ
         Wae2SA3N3Krd58+72/ZX13XR+5JbJHaz3ZBvAPSbWjFxD6QXO8L33UjbCaf0G/gHl6xN
         c41IvhN7z7ncAQA56EpjoOfpH4bFbo3ERrPMm3p/Q2KPYsEcueBzRsH0M2ou0vEz1BjF
         QbT73/6ZWqvh9lMUcxT+UO0VXxv27uRLlPjBxRgZKHwjge191AKOJ8RkeZZh9TqzxwaP
         E0cmy4al3QFtKJkfsV1SlCzD/Tr1MTwVG4Mc1L/FpMw7FTiejoTLnwk++NqvhLlp1QxX
         qq2Q==
X-Gm-Message-State: AOAM533HCDLNb7jGJ3E2ybzuJeoQ8JZra0VQ4T3d4tPqeONol/RC5rDk
        4czxTkh8gjzTqDcDFXVuyliPOKMoIUYcyjy8CjQ=
X-Google-Smtp-Source: ABdhPJz1YN/jkbcEjM+hEYMM5EVSkxILoQR11LWrHAospYrFeZfzruA0shN6fgdkE52Fm28zwc05AQkCtKAEwQ1h/Sg=
X-Received: by 2002:a67:b844:: with SMTP id o4mr37322213vsh.61.1635833615279;
 Mon, 01 Nov 2021 23:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211101140544.Bluez.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
 <20211101140544.Bluez.3.Idb95ae18113225915b97a4f06983e1e41a7f7a2e@changeid>
In-Reply-To: <20211101140544.Bluez.3.Idb95ae18113225915b97a4f06983e1e41a7f7a2e@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 1 Nov 2021 23:13:24 -0700
Message-ID: <CABBYNZJqFBgAvQY5hD6LbouiEiFA0DqYaU_50z5PEGHHxctQug@mail.gmail.com>
Subject: Re: [Bluez PATCH 3/3] adapter: Remove "Master" entry from LTK storage
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Sun, Oct 31, 2021 at 11:06 PM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> The entry has been deprecated since 2014 and it's time to remove them
> altogether.
> ---
> Hi maintainers,
> While cleaning this entry, I found that this entry is involved in some
> kind of storage file conversion, probably when upgrading BlueZ 4 to 5.
> Should we also remove the file conversion too, since it's dated to
> 2014 as well?

Perhaps we can but I'd had such cleanup as a separate patch then.

>
>  src/adapter.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 6b12c9e793..3a3c957a6c 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3779,8 +3779,6 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
>                                         uint8_t peer_type, const char *group)
>  {
>         struct smp_ltk_info *ltk = NULL;
> -       GError *gerr = NULL;
> -       bool central;
>         char *key;
>         char *rand = NULL;
>
> @@ -3836,12 +3834,6 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
>                                                                         NULL);
>         ltk->ediv = g_key_file_get_integer(key_file, group, "EDiv", NULL);
>
> -       central = g_key_file_get_boolean(key_file, group, "Master", &gerr);
> -       if (gerr)
> -               g_error_free(gerr);
> -       else
> -               ltk->central = central;
> -
>         ltk->is_blocked = is_blocked_key(HCI_BLOCKED_KEY_TYPE_LTK,
>                                                                 ltk->val);
>
> @@ -5904,7 +5896,6 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
>         g_free(str);
>
>         g_key_file_set_integer(key_file, "LongTermKey", "Authenticated", auth);
> -       g_key_file_set_integer(key_file, "LongTermKey", "Master", central);

Weird that it still was setting the "Master" even though this is meant
to convert the old format into the new one.

>         g_key_file_set_integer(key_file, "LongTermKey", "EncSize", enc_size);
>         g_key_file_set_integer(key_file, "LongTermKey", "EDiv", ediv);
>
> @@ -8445,9 +8436,6 @@ static void store_ltk_group(struct btd_adapter *adapter, const bdaddr_t *peer,
>                 g_error_free(gerr);
>         }
>
> -       /* Old files may contain this so remove it in case it exists */
> -       g_key_file_remove_key(key_file, "LongTermKey", "Master", NULL);
> -
>         for (i = 0; i < 16; i++)
>                 sprintf(key_str + (i * 2), "%2.2X", key[i]);
>
> --
> 2.33.1.1089.g2158813163f-goog
>


-- 
Luiz Augusto von Dentz
