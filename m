Return-Path: <SRS0=Zhcm=6P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF6BC35280
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 20:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39CFB208DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 20:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYFitxW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgEAUpG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 May 2020 16:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgEAUpG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 May 2020 16:45:06 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5BFC061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2020 13:45:05 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 72so3596063otu.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 May 2020 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=erD0up87+FBeaMo9KZ4PIvRgnrOnxw2GKMhrJG2SvFo=;
        b=lYFitxW8cg6tg01gdXXk3Ry8gfEYNzjJlzUZ79noJ69m53ElN7F0UtxlTKDL+eINyn
         tVOKNFDaBv6GHxHHxzH8uMEv3dFC6e/GBc/wM3jNi4lS4H4eUEkw8rAgp6dDZV1R3Dzp
         3ZB0vy4aFO8Ur1U8EQjqhymotdyrvDKDdiYtQcwqJM9+4eITt0CZyPkMj6/qwT8juYbn
         8SxC8lS/lXJD5zNMX6R/ZuJqGB1jco11iGYrMJc0X57K8lySARuLu/5O0HeUyAACMsTY
         R7viGab89VyhPmfsDgxeTjVAAezQ/fgU+UTTih78xwyVTgs+3uTPyBF/8VzHycOXqNjC
         Y7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erD0up87+FBeaMo9KZ4PIvRgnrOnxw2GKMhrJG2SvFo=;
        b=cIAluKMU12yW84ao8j89G9u8W4mXpcJy1x52FjwovrPiB5UJsfPjsrNO7TfposY8Dh
         EV2txTGJijM2Ke6PZUytsLI6gS8wS24PxFSOFx41gjdFayQwOm1CbStzZ+fGS0uvTn5h
         DXGSQ3rJFrVEKxCqisS1J2aVZ1Akl6siDxncKwwLORDdOjHIc3nYXFkAmZJYUwVb1DTZ
         m1SfEmtBy1qwuTk2MY01GmXx/+IBjxz6nf+lOW6zs79mFN6azmVHZ4z8FtEvskJG+Zek
         g2P3iMCx/fxqY6dgleNlg9uKctzKBw6rSfKMHLRNN2VU6QR8pFsr9/7hTp5vKPhT9GjY
         mXPg==
X-Gm-Message-State: AGi0PuamoGX6JrI9I1SetgMK+7fgRFmTtjSS6j9yb6uRbaz+bPTVE4xV
        lP/TBmbs2KnzWpbQlNDtnYd/jC47iubarPa6nNbFKNR2
X-Google-Smtp-Source: APiQypIwxCLppkekVWBeBa/bWioEBTRCeF2C/YD7jTEt2S0vr3ar4KGK3SuoX7DhrEyKZQ4cWoN7kzBD9Zfc5hg2j8I=
X-Received: by 2002:a9d:57cb:: with SMTP id q11mr5085146oti.11.1588365905207;
 Fri, 01 May 2020 13:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200501192447.78757-1-alainm@chromium.org>
In-Reply-To: <20200501192447.78757-1-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 1 May 2020 13:44:53 -0700
Message-ID: <CABBYNZLd-JoEwaLwbXAuiV0tm2BV5-tof3QbbH82wbZyMEUUiA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] shared/gatt-client:Fixing a few comment typos
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Fri, May 1, 2020 at 12:27 PM Alain Michaud <alainm@chromium.org> wrote:
>
> This change simply fixes a few comment typos.
>
> ---
>
>  src/shared/gatt-client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 963ad619f..c4a79eac9 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -642,7 +642,7 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
>                 gatt_db_attribute_get_service_handles(svc, &start, &end);
>
>                 /*
> -                * Ajust end_handle in case the next chrc is not within the
> +                * Adjust end_handle in case the next chrc is not within the
>                  * same service.
>                  */
>                 if (chrc_data->end_handle > end)
> @@ -651,7 +651,7 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
>                 /*
>                  * check for descriptors presence, before initializing the
>                  * desc_handle and avoid integer overflow during desc_handle
> -                * intialization.
> +                * initialization.
>                  */
>                 if (chrc_data->value_handle >= chrc_data->end_handle) {
>                         free(chrc_data);
> --
> 2.26.2.526.g744177e7f7-goog
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
