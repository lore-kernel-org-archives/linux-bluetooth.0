Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CC4C05027
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 19:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjBATKb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Feb 2023 14:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjBATK1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Feb 2023 14:10:27 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643B87D9A5
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 11:10:26 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u27so13866409ljo.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Feb 2023 11:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RvDQ7jr6dJVJMgML4GZIsPeERmGp31G+SoskmGCaImQ=;
        b=Ucqf6JTzy/1efj1G0lUF8tHlZtOA5MGpXtm6v17byf4JKPQbgJjX5CeOxFYt6QumK/
         Iv626M5LlRGezUqYfXsYz60kEuSYrWQbzuhd/b/8lTHj0CH3zRYxxTmF3QCND6BJJDjs
         p62OQa+QNGt6GBXmmoHFozJGaMsC7pdbDM6xdHWZ04dbJ1YbsJNMyUeBxP1XKJJLM9bh
         hWPgghQtaTdLFIko0sDneiQKYp74lJwTSIM0btTrk4VemaZ3ttXXmDxEmpkiy+aPwU9h
         nBH8CuEIXKCT6j6gEx2e2SZjJxtbJVWxIdDKAd6a0BJa10FroEyBlNytuTfT0Bu+W90o
         IorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvDQ7jr6dJVJMgML4GZIsPeERmGp31G+SoskmGCaImQ=;
        b=c2utmJzYZuSv1Dncejvgoefb3OKmoY7F06YuAXtz9+IclGMR70yvyynhr6Gi41EG30
         0NaPxgEJQu3rJXxBqiUfasZV/xToojT2E23SkiLlN/wEE5ER3i1cTANPUrBnZEhChpga
         vMQ/kBwKE197jnwE9QII0vi4liFORt/iV9XJP6RG+nQEpqmz3xZ/coNaLEp8IS9zJM03
         QxXtMX6hcS6AQQsTbuzYWYajmdfjnl/nbFTSMtKxGoZO3b1p/kpcx3v4l2L+/dkdc+1P
         v+R+3QPUgupM8kqOCjRDV2ROjE5h3HGQF4Ozqu8SlujMq4Z68hh1C9sR1KmlttONSyd6
         GOvQ==
X-Gm-Message-State: AO0yUKX/D78FhAsj0ejx/rls1sU13AvFx7D0e3+Tgl3m8YbsDZHzOqe2
        iMUE3/4g4yaR11vN2S2FKIty+FFvYpN5R6J+weQ=
X-Google-Smtp-Source: AK7set8LmzeX3W8x2ftgG9rd1NgPZ4sEJqHLMpz5Hb97Xb8OYEmnLz2rU9LgxKv4u/kjZ0WmOeaXkZO3TP+211SMEOg=
X-Received: by 2002:a2e:a4c3:0:b0:28e:92b2:a04a with SMTP id
 p3-20020a2ea4c3000000b0028e92b2a04amr545243ljm.34.1675278624229; Wed, 01 Feb
 2023 11:10:24 -0800 (PST)
MIME-Version: 1.0
References: <d23190507e9c7131481648848d0afd62448226d3.1675276185.git.pav@iki.fi>
In-Reply-To: <d23190507e9c7131481648848d0afd62448226d3.1675276185.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 1 Feb 2023 11:10:12 -0800
Message-ID: <CABBYNZK145J6kOOhDCF1=tA13B3ta57dHPfuWBKXaC6pWzQTAQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] media: set default value for BAP endpoint Vendor field
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, Feb 1, 2023 at 10:57 AM Pauli Virtanen <pav@iki.fi> wrote:
>
> The "Vendor" field is optional, and should have an initialized valid
> default value.

It is probably a good idea to include logs where the problem is detected.

> ---
>  profiles/audio/media.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index d96367454..a62755f69 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -2551,7 +2551,7 @@ static void app_register_endpoint(void *data, void *user_data)
>         const char *uuid;
>         gboolean delay_reporting = FALSE;
>         uint8_t codec;
> -       struct vendor vendor;
> +       struct vendor vendor = { 0 };

I guess {}; or { 0,0 }; are clearer here since there are 2 fields in
the struct, although it is probably safer to go with memset(&vendor,
0, sizeof(vendor)).

>         struct bt_bap_pac_qos qos;
>         uint8_t *capabilities = NULL;
>         int size = 0;
> --
> 2.39.1
>


-- 
Luiz Augusto von Dentz
