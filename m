Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0C2C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A361D206F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Azja3w5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgFJUYR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgFJUYQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 16:24:16 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2876C03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:24:15 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id u23so2773723otq.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKyljF/IDDTLMGi+kzzW0ginbngKZ7sZ5oDaU90ZxQg=;
        b=Azja3w5v3b74ZkqCCEcOyXAgC0cqBeP6hmkBClJar5YHo03gpHkRIxSkzIrN7TaUE2
         ou8QqhAVP7MiLavBRpD/lbApT59/53f9GW+FHpwbgYW+uj2DQ5Ip5Z9mcpIVLZSvW56s
         O8etAiwqweGsgc9FfzMuf8fmvSe0qyGnIG8tiFFX4CmiXe2gNfVCGE6S4GbAWUM83kG6
         A3qCbakzgIhNkFKUVMmm/CxH8Z/u/jPlf6rADsr9GbqHg1boM0V5VrngJSCBhSes4ufg
         yGkBskcXUQAB6Bmede7K5Ltvfl08Vt1T1s8AF07xtKYIX8FyzHmZ9e1eZKTloX3a14Vs
         87rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKyljF/IDDTLMGi+kzzW0ginbngKZ7sZ5oDaU90ZxQg=;
        b=OmQ3y8OX5QPx/ue8h8Iw1zPBzZIMYu9yj8V6sWwwUFEkkHREQkae0Nz1V7HaSdc96H
         FcH1VdglYpaP/DV15nkGBwyeNNcogBM8Bi0jVT1R3Df4FtcNkh2u1EdZlZQhFLEMhAkV
         /c1xfN+EmP+Sq7wF/pjK/U6KFzA9y3EETBOUm55CYRzksY8CWu+OzjizWTyQFAPp+/zX
         bLsUWUo4kl4dmGpOEjzLuZuOHCik736QOSA4o4c4U0OmQkuArPAtdOUNp0hk/vUvAmFJ
         9Zf7x4y/XloBpTSK1s9LmgwAFC6505aQpjVt9tEUyMlSSPFprhIxOCPJ2I119U15hmFG
         NGmA==
X-Gm-Message-State: AOAM533tz25pW9qYRx/w0H/KX68jI5jGbslPDD471D91HD5wL1EN5a3p
        CSNWkiEd3lvdLntVDU0FopaWYNn9EjoksJN7uCc=
X-Google-Smtp-Source: ABdhPJyAxOz/+Dj+AJN8Omr3xNVxWnvVJ0zloHW99WXXBwOP81kLtLa2HSavdJ1tub/UW39tDlG+S/CKmaeMP5w3wzs=
X-Received: by 2002:a05:6830:310c:: with SMTP id b12mr4190079ots.11.1591820655238;
 Wed, 10 Jun 2020 13:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200610230423.Bluez.v1.1.Id3fa4e63f104f100648140f38d0fc40919b24c69@changeid>
In-Reply-To: <20200610230423.Bluez.v1.1.Id3fa4e63f104f100648140f38d0fc40919b24c69@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 10 Jun 2020 13:24:02 -0700
Message-ID: <CABBYNZ+vT5931gr3bjcZLp+Ub2LJGy8mn1cbUrcazd5MyCKkxQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] input: Disconnect ctrl chan only if intr chan
 was disconnected by us
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Wed, Jun 10, 2020 at 8:04 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> If the intr channel was disconnected by the other party, then they
> are also responsible to close the ctrl channel. Such disconnection
> message would have the G_IO_ERR flag set, as opposed to it being
> unset if the disconnection is initiated by us.
>
> There doesn't seem to be an explicit rule in the specification
> about this behavior, but this is enforced in the PTS qualification
> tool.
> ---
>
>  profiles/input/device.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index d89da2d7c..a858bbb19 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -333,8 +333,10 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
>                 idev->intr_io = NULL;
>         }
>
> -       /* Close control channel */
> -       if (idev->ctrl_io && !(cond & G_IO_NVAL))
> +       /* Close control channel if the closing of interrupt channel is not
> +        * initiated by the other party
> +        */
> +       if (idev->ctrl_io && !(cond & (G_IO_NVAL | G_IO_ERR)))
>                 g_io_channel_shutdown(idev->ctrl_io, TRUE, NULL);
>
>         btd_service_disconnecting_complete(idev->service, 0);
> --
> 2.27.0.278.ge193c7cf3a9-goog
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
