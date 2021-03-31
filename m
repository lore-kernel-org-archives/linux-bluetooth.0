Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF079C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Mar 2021 18:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF76C60FF3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Mar 2021 18:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhCaSdk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Mar 2021 14:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbhCaSdM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Mar 2021 14:33:12 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3A0C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 11:33:11 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso19867134otq.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 11:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJsGPCFWEfZKvi1DlmLG4hl8cElrFzWnfUlZZ9vfwAE=;
        b=r3n8qdXumaRpgrkIUQ3IEK3xPTkHX48eQwSomYZjhxBgPWXLnZ/v9W8CwYOnKllStG
         fdYrebxbdKBTEYx5JZxw9XFnr08/XzQWSpM++umwCOYqeB7ePPQpYiZfEYfYu+CNsfH1
         gqI2rFT5bQ6FydAbyH2dCplN0ZcGTwWDfvjhmtlMqSaVEiFI14xL7ojaSXbnmx7vEtnL
         DSB56/NY7fJUwL1WSklaShg7NvPyIva7I2iCSubjrOTLN/XaO2k323nRWshGQRl2aDIJ
         ofo/q87JdgU0MWwlVp2rZ2I4NQgDnVcpNBOto/o+YC2Z2GxPkhI36WtxD94M14gPm9cA
         VT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJsGPCFWEfZKvi1DlmLG4hl8cElrFzWnfUlZZ9vfwAE=;
        b=NexUFFYCBEmyBRgCPZTqexgchwPsZVZ7uJrySll16BRwFzTkOutFqAgG82vb9CmDfd
         CsnUUZB9ZaWc4vVYB2TEZu8jlXJ5QSNBynX7LwsiFKZcimadMOxUForX3PCMpIpoyEZc
         Vr0p9uGOg2jmFBIKochzfR6e/3Pqz/VezZtQJGV+4a9l5ePe66ga99VT9bxsAGstLRuz
         OkpF/I3hfFBBm690M33DiFoQf07LeQ+6adBFZZ9wj1d/o5i57/GnXp7ALWTpnNFN1JAl
         QbAHvW2ePdewNAnZelomjL5nRuJR26+mNJgq56soczQY/uKfJGwp1ykW1QsdpfUfOu3R
         49xQ==
X-Gm-Message-State: AOAM530ho3z8S0UhWVVCNDKaLwzc0gURzgTljHrubs8wmYh3ANL8EgxV
        7iwOycLY5sfsxvL/f4LeBV9QlglXagLMCO2A/lE=
X-Google-Smtp-Source: ABdhPJzYnrCQcR10oH+Tk6bvAKo9EpLpUXBJ2Dp+id0BHa98r1rbvURSQCSx4nGeXyKMqLjbwrzGmIhiDMVFswAJRgY=
X-Received: by 2002:a05:6830:619:: with SMTP id w25mr3669900oti.371.1617215591046;
 Wed, 31 Mar 2021 11:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <80f40fbd-c903-6f10-1d9f-e75f0f214db5@gmail.com>
In-Reply-To: <80f40fbd-c903-6f10-1d9f-e75f0f214db5@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 31 Mar 2021 11:33:00 -0700
Message-ID: <CABBYNZJ2Hw1+xSvhqwBQa90qkpcmYh+qO3U+Rs1JBaSOz+7AMA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/transport: Emit Volume changed if endpoint is source
To:     Feryllt Pryderi <feryllt@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Feryllt,

On Wed, Mar 31, 2021 at 4:40 AM Feryllt Pryderi <feryllt@gmail.com> wrote:
>
> Change set_volume to send a Volume PropertyChanged signal also if
> transport->sink_watch is set (and not only if source_watch is set).
>
> This fixes volume changes signals not being sent for devices like speakers and
> headphone adapters with volume control (like Bose Soundlink Revolve or Fiio BTR5).
> ---
>  profiles/audio/transport.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 8248014ae..26aa237a3 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -662,6 +662,7 @@ static void set_volume(const GDBusPropertyTable *property,
>      a2dp->volume = volume;
>
>      notify = transport->source_watch ? true : false;
> +    notify = notify || (transport->sink_watch ? true : false);

Id replace the following like with:

  if (transport->source_watch || transport->sink_watch)

>      if (notify)
>          g_dbus_emit_property_changed(btd_get_dbus_connection(),
>                          transport->path,
> --
> 2.31.0
>


-- 
Luiz Augusto von Dentz
