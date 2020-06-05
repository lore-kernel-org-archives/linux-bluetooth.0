Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C16DC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 23:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 281892064C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 23:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omkqu+Dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgFEX0y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 19:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgFEX0y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 19:26:54 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71785C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 16:26:54 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j189so9636225oih.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 16:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NOTIMDgCZacyI5aIkjRVuzbN82H5cC5RCcdJEgSquLE=;
        b=omkqu+DtVOIsD+jH3a86bNkx08JYcCgc7PvNMn9swdmo03UZRV1OY6c3bg9EsFCQ8v
         0aA5qgnqmBDt3+kPj3AQETXhd1ej0+UoFdblc2IzIDOB+0vuJixQg8TQuk9vgQRfLzGD
         b+H1C5xOMwwfWJntyJSm76ww+tO54f+8ggSMujEg+dw5Qyx9KZrg6aYO4uTvUJ0mCG9h
         sbqYFbQQo4xlYHFLS9z+Opo42vCquhAF4NAHr7Tl8lGMjfJ4jY3YDoHfXnuqO/HjhAqC
         pPodWIpayzreWWb8tE2PMVo5oXy95b2wRIwyq4/1EJQvjl1xZrEfl7Cxl+VHrVueSvGX
         rQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NOTIMDgCZacyI5aIkjRVuzbN82H5cC5RCcdJEgSquLE=;
        b=QkNOWa74Ig5s8QdKnkQYWWrabIauss5rSwsXjvlCPVwizSPZdQppfwjKX9vstJCpf1
         nyhGgBwFPVLrExKOk/gWE0UctXSjIll4oOR2jSS/3OJNb2OC89BBWa4a12zq9UBSDYzl
         1/lX5wcaHHdB/dBhIF+CgFNoJ3OVxOWNnbYaF88cTJDzedSKkxeCdHFREurNMLaqyHPj
         N3e0bnWZWuWyLyPpzt1NRbcysLLWi/+zWV9kjkXWJCuUgQYM5Y38SvwoEItp5HHhrSBw
         3DRBD68k3bi5K75f9vfM6l1He7Q+ovSwqEnGEIbuUEtExmABVttURsZFv/PhqRL2INc9
         k4Fg==
X-Gm-Message-State: AOAM532Uxqs1Ig626rurUXIF+LIuM+7q5qO034Y9KlyvSSxROZpC6/IY
        p933G/bHgf1/yDvr2LFegP1Wkf3dDxuj59CRlDxyig==
X-Google-Smtp-Source: ABdhPJzYuqYCYkS904GjAp38pS+XdAt+rlsREMTO+lVcB7H8nDA4P8kBFdVe5ZCjsuuOSsZ5k75g647wXRfwdDW/DxE=
X-Received: by 2002:a05:6808:b32:: with SMTP id t18mr3303323oij.82.1591399612752;
 Fri, 05 Jun 2020 16:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200605175942.719436-1-luiz.dentz@gmail.com>
In-Reply-To: <20200605175942.719436-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 5 Jun 2020 16:26:40 -0700
Message-ID: <CABBYNZJ=RirU3of1pCUjgBwKTP0Rmv5g0uGP-CKJnYLvdDUwOQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] btio: Fix not translation mode to L2CAP mode
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jun 5, 2020 at 10:59 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> When using L2CAP_OPTIONS legacy modes need to be used since they are
> not compatible with BT_MODE.
> ---
>  btio/btio.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/btio/btio.c b/btio/btio.c
> index 13c731062..844d6007f 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -597,6 +597,20 @@ static gboolean get_key_size(int sock, int *size, GError **err)
>         return FALSE;
>  }
>
> +static uint8_t mode_l2mode(uint8_t mode)
> +{
> +       switch (mode) {
> +       case BT_IO_MODE_BASIC:
> +               return L2CAP_MODE_BASIC;
> +       case BT_IO_MODE_ERTM:
> +               return L2CAP_MODE_ERTM;
> +       case BT_IO_MODE_STREAMING:
> +               return L2CAP_MODE_STREAMING;
> +       default:
> +               return UINT8_MAX;
> +       }
> +}
> +
>  static gboolean set_l2opts(int sock, uint16_t imtu, uint16_t omtu,
>                                                 uint8_t mode, GError **err)
>  {
> @@ -614,8 +628,14 @@ static gboolean set_l2opts(int sock, uint16_t imtu, uint16_t omtu,
>                 l2o.imtu = imtu;
>         if (omtu)
>                 l2o.omtu = omtu;
> -       if (mode)
> -               l2o.mode = mode;
> +
> +       if (mode) {
> +               l2o.mode = mode_l2mode(mode);
> +               if (l2o.mode == UINT8_MAX) {
> +                       ERROR_FAILED(err, "Unsupported mode", errno);
> +                       return FALSE;
> +               }
> +       }
>
>         if (setsockopt(sock, SOL_L2CAP, L2CAP_OPTIONS, &l2o, sizeof(l2o)) < 0) {
>                 ERROR_FAILED(err, "setsockopt(L2CAP_OPTIONS)", errno);
> --
> 2.25.3

Pushed.

-- 
Luiz Augusto von Dentz
