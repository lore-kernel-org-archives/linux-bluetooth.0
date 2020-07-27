Return-Path: <SRS0=Hv/D=BG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3913DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jul 2020 23:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FF120729
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jul 2020 23:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDuyQSMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgG0XP5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgG0XP5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jul 2020 19:15:57 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29531C061794
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2020 16:15:57 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id w17so13599763otl.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2020 16:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECEwATKpjiwoPaJQLx1KlRnXodk6DB4h6BgLx+5ivDk=;
        b=FDuyQSMKy83wjoyim0KV9XMuuPl+hg/lut29FbVqXzwcxXB83DfzCIkwHlgt+DoYag
         rNx/10nYH6RXmWhMQUz/IKqGJ/ezqKUsPaHAa0lXG+7xyQ8VZp+n+xZ9h2L7hj7XVe2c
         rH9sToVNXip0xOu0JNmgd2wS96ZyqCkoMVrgl8mLOeCzITHq4szxFJXPP8jnGp7GrQlT
         wIDG53xsfxqZytIZjvtTnwcMUE0AFCGV7PmS4nPa4vuVDncEO6FJtHxKqb2oTEAotQ9N
         HAdBBWQ7YggXqkkPzuGur99oLuwzBJDswwUak8h2Gz4W86H5UyWFDbGzyWLzN2ZtTlAr
         MnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECEwATKpjiwoPaJQLx1KlRnXodk6DB4h6BgLx+5ivDk=;
        b=YyvRQeZTCQGlPtOaLQeV+kjyq7cYL111i1D3GmFSXlK0mljsl9YysPVMoVLeLOz3Ff
         j38WrDwRoX2wSjfKXhpeJIfIiyJHkZhM0Pyjgug2awhBKn9vnYyK7Xl16ZDGYITaKIBN
         xkvRTxXLXt/oWHoUhTRTDoaSfQ98oCzHqo7uKbiJ/EihFWuN/jc96wwkecFXhjNNkuEl
         M5mBuwcqkrFwbKriw3fs9O0cyqYnVUkQWz4r/RL4LEavstWCqHJ7uChA1nD/7GFpPGoH
         LXYhGGqzahEinzsVF+4E7FSeH+5xzyJ42nb1VJZaoyxnEgU1WOdy57fe4GSFB+51gU42
         TO8w==
X-Gm-Message-State: AOAM5307ZdxGeM8uBn6xiQaVFYSwtHhgKo33K1JSWt5AExj90xakaGFe
        syJ8vUNlY9WbxJ9PZzL/YSJpaswgnYpW9dVm1qHfSqfE
X-Google-Smtp-Source: ABdhPJxK8zKSnlollauZNCo6kafSUoY2Gh2k/1G0iO1oNMJ/ytYznEdKCcDGX9cQPK2ULOI2iXwmhjcCTENc3m8WeaI=
X-Received: by 2002:a9d:5e18:: with SMTP id d24mr21585329oti.88.1595891756491;
 Mon, 27 Jul 2020 16:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200724140305.111507-1-committed@heine.so>
In-Reply-To: <20200724140305.111507-1-committed@heine.so>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 27 Jul 2020 16:15:46 -0700
Message-ID: <CABBYNZL-gxf1TJr4Ckt9Zot4v5ZfKHXUS_tWEwndB==AUB24_A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] main: add missing comma after AlwaysPairable
To:     committed@heine.so
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jul 24, 2020 at 7:08 AM Michael Nosthoff <committed@heine.so> wrote:
>
> Commit 1880b2990866 ("core: Add AlwaysPairable to main.conf") added a new
> key to supported_options but didn't add a comma. This leads to the
> following error message on startup if the key 'PairableTimeout' is pesent:
>
> Unknown key PairableTimeout for group General in /etc/bluetooth/main.conf
>
> This probably also leads to ignoring the setting.
>
> Fixes: 1880b2990866 ("core: Add AlwaysPairable to main.conf")
> ---
>  src/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/main.c b/src/main.c
> index ec7a9fbd7..2c083de67 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -79,7 +79,7 @@ static const char *supported_options[] = {
>         "Name",
>         "Class",
>         "DiscoverableTimeout",
> -       "AlwaysPairable"
> +       "AlwaysPairable",
>         "PairableTimeout",
>         "DeviceID",
>         "ReverseServiceDiscovery",
> --
> 2.25.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
