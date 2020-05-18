Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C8DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 21:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECAE22081A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 21:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3qnUtI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgERVbb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 17:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERVbb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 17:31:31 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE38C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 14:31:31 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id z6so2390400ooz.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1L30+ssZWk6kBDnGWOhdvCAkG1HH5xHLSQ9AVfCuBk=;
        b=d3qnUtI0ykhEbHbIPyaNhdm2JQXDiyQH8rY9jc92eew+9vkKu+ssG5meKecbtLlnr0
         IFU0ECOUFS8E04GNAcSz+sZz6dNDZ4fnJTETY1jGGgJ18ELirED1jm/r89HHxKZibx0J
         Sit/gQGQZorCuuk2gyYmBGwz1VoebzgWwiDzJJOaHfMLKlPQL+9xkq+aKSfHwV1IfUoc
         RUM7JRFNWCPsQkUDEW70y9t5ahIGwowYNFSAJkpk2QpiXx8u2CqWeb4jxgoaR9P9OKT9
         rLDN4ezGMtsb0TVdPxRAUleAIkcH1OH0Oz8ucB1VwD/2OAGK4goCkf75WaFtqF6qA5vr
         dkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1L30+ssZWk6kBDnGWOhdvCAkG1HH5xHLSQ9AVfCuBk=;
        b=H1bXzSIV1Irl+RQKT/BUvb/v0JD+0pP20GT9MrBFSAvTWVcIY6TsOPBM6WrDR68Sdk
         XIcuFH7cJsCSRBq17dtrogHfSxUOsHspaG48Sm0CkB1jaQ9bfh/6hMltjwXc/IJDMD4R
         j+DRLcC4E8PeN0Iejy2GNevGsoGeB8qPGd5JO7foLRFdXQElKRFSgjGH1XO5yCqUVns2
         8bHiDtyDLp8Nc3uzC2BbPc6gq6EcaQf6hOoDQyMuFhw/h7Wbg4tRhpUJ/DwzHcZsOdKT
         DQnGIF1AKU70F6eO1PRt8OyLMA4V80mXOBqu2dZgFdWIZle1Tetoj+8CxCKAiHzXMB6h
         hmUA==
X-Gm-Message-State: AOAM531DocRSZzjANoVsrCuI3fzjiDMNwt/qEPf4Y6EJOz93e/wZYrR5
        Dhyuhgb06dlZ1iDNLxaEKmBJ4L7lbfIA73wY81KO0w==
X-Google-Smtp-Source: ABdhPJzpaIVo5LLfknmytab7tcnyVsjgnokuUifiEdrVFPtUGEax321hzDLf9tCdXmwpAAvfuflf0tRru0tv5v4IDuk=
X-Received: by 2002:a4a:e795:: with SMTP id x21mr14142196oov.91.1589837490495;
 Mon, 18 May 2020 14:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200516210238.3184629-1-haadr@negentropy.io>
In-Reply-To: <20200516210238.3184629-1-haadr@negentropy.io>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 18 May 2020 14:31:18 -0700
Message-ID: <CABBYNZJj1PhYJ+fY7NcggY2aQS_Nt=6LXWnGopRAe+W9GRAUSw@mail.gmail.com>
Subject: Re: [PATCH] Set vendor, product and version for all HoG instances
To:     Haakon Drews <haadr@negentropy.io>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Haakon,

On Sat, May 16, 2020 at 2:15 PM Haakon Drews <haadr@negentropy.io> wrote:
>
> Set the the correct vendor and product ids for all UHID/HoG
> devices when they are unknown at HoG creation time.
>
> Before this change, when connecting a BT device with multiple HoG
> services for the first time, only the first HoG instance's vendor,
> product and version fields would be set by the DIS callback. This meant
> that all HoG instances except the first would be left with unset values
> and their UHID devices would then be created with '0000:0000' as their
> vendor:product ids.
>
> Signed-off-by: Haakon Drews <haadr@negentropy.io>

Ive dropped the line above, we don't use that on userspace.

> ---
>  profiles/input/hog-lib.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index 8fb0283ca..a544e062c 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -1387,10 +1387,19 @@ static void dis_notify(uint8_t source, uint16_t vendor, uint16_t product,
>                                         uint16_t version, void *user_data)
>  {
>         struct bt_hog *hog = user_data;
> +       GSList *l;
>
>         hog->vendor = vendor;
>         hog->product = product;
>         hog->version = version;
> +
> +       for (l = hog->instances; l; l = l->next) {
> +               struct bt_hog *instance = l->data;
> +
> +               instance->vendor = vendor;
> +               instance->product = product;
> +               instance->version = version;
> +       }
>  }
>
>  struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
> --
> 2.26.2

Applied, thanks.

-- 
Luiz Augusto von Dentz
