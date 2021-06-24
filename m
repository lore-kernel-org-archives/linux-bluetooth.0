Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EBAC49EA5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 20:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE3C613B3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 20:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhFXUPn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Jun 2021 16:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhFXUPm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Jun 2021 16:15:42 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE5FC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jun 2021 13:13:22 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id m9so1114878ybo.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jun 2021 13:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=JuKHP7exqg8ygKXZOxogK9y/AGv3FOAbnk8/3TJcnPY=;
        b=hCq3v8dAqttRkoHhca5fkoJB/+uuLvjc2Bd7uB8fH0/Q2ou/pdNbsPCin050oIgsxv
         uOxvzdMZMkCGJrNNkjP+B1jljSnVVn/mgB9lG0IQm5xSBr6xEu0Y6QHsRTi6ruNCuTdK
         jH+ZOyVX1DIeHLI+hpChve+hVg7cZ+XKwQfTWDe/51aLUeZVnGx1yzLmQZCyAkJ4OU1+
         SET1eM94bmc9qLHgF9t4rTfx7ZI+K3ZHjZb/nyukQZA7wPtrzfSRCYxnRxQxn94dAXh3
         g7i74+8EGzD65mbMEOPbTKUO0ABuQz8aZd67ZcGPZu48ijrtXqcmc/12kzifeKSVQQGD
         q9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=JuKHP7exqg8ygKXZOxogK9y/AGv3FOAbnk8/3TJcnPY=;
        b=sfeUdt7P7mwrH0aTz772vZ1XfgrbgRSNm47+YbTC8r3RhRLD8z05Xx5brKw7sek8hi
         2YJjbe17Lh12Tos42SWsryz1z8zR9usVbwiKaGm8DI96vrIVa3jzzyevb0MnV6CKCx4o
         lM471cOokVlB/85td5SdylW2QhP2+QCokQuIF7+oIQ8giY9hPhUAFUNrw4CNeB4QvruT
         mUhcWsy1DVQKvRjcOyRXbP6whTuQKDIDklLI8OIFnOtmLlGHjUzIaxkwcI4B+2wWn6iK
         AuxCAj74EEhQeH1+izQr2L8Rt+XO+SbqBgG4AI669cdmRzvHFqksNw3KN40zmvREuup1
         Z39g==
X-Gm-Message-State: AOAM533VEQJ/zWs6sB3EQZ0cwBBVcbVjvK8I5zM6Srp93j5T3KWz35Cm
        dKpgMmuhzoar5Pgr8XMMPApZLf6N9rWneP8b7BRifD4JVJA=
X-Google-Smtp-Source: ABdhPJy9j/CMNHL7ND/TMuxvKR7iEyr/3k88iAFhR4/Nu0504NiD5MGaok4sI4DzG6VfStLmd6sNissal3rpBscV2ps=
X-Received: by 2002:a25:acdf:: with SMTP id x31mr7740537ybd.222.1624565601664;
 Thu, 24 Jun 2021 13:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210623224539.3738085-1-luiz.dentz@gmail.com>
In-Reply-To: <20210623224539.3738085-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 24 Jun 2021 13:13:11 -0700
Message-ID: <CABBYNZLgv_Az7HrtqG+8Dwgk6jN9Mu5iBJ_44L1js_4gPN0wqQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] media: Fix UnregisterApplication
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jun 23, 2021 at 3:45 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> UnregisterApplication is not doing anything since the apps queue is
> never initialized which results in not finding any application when
> unregistering.
>
> Fixes: https://github.com/bluez/bluez/issues/126
> ---
>  profiles/audio/media.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index c84bbe22d..267722542 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -2384,6 +2384,8 @@ static void path_free(void *data)
>  {
>         struct media_adapter *adapter = data;
>
> +       queue_destroy(adapter->apps, app_free);
> +
>         while (adapter->endpoints)
>                 release_endpoint(adapter->endpoints->data);
>
> @@ -2402,6 +2404,7 @@ int media_register(struct btd_adapter *btd_adapter)
>
>         adapter = g_new0(struct media_adapter, 1);
>         adapter->btd_adapter = btd_adapter_ref(btd_adapter);
> +       adapter->apps = queue_new();
>
>         if (!g_dbus_register_interface(btd_get_dbus_connection(),
>                                         adapter_get_path(btd_adapter),
> --
> 2.31.1

Pushed.

-- 
Luiz Augusto von Dentz
