Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BDAC0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 17:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjG1RVi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 13:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjG1RVh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 13:21:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A6E188
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 10:21:35 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fcd615d7d6so3978772e87.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 10:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690564894; x=1691169694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2aSZfEbYtbSGJQH9qK4kw4x0HrKxSdAHUORKzF1l3U=;
        b=AOHv+ffzU5aLSEqGAfLV7ejA1vtWDJfHl57TNBgGkTdX6hd0yJFQ1baCrspHHclbU4
         yRqK6b4tloKGSHAaEOEPRkfgx/eBBoBaAZ1s9Eki2cMDZb82YoZAOqVYycnIK2J7Wqyj
         eOwl222pBSgrCGgrHdKhnXHNmMS3SY6sWutJX2sYaJF8alw64C/f+XILVstrMoTNsywu
         wy8exow09uUZoCIO7yBzjr4V4Rzu4/HKzJ5avA0dfLhh0XIff6ZIBEWO6yRBJmLBhJCX
         vMrPELkskBp48i1V4hMxtuP8qFUlJrODNMcLRRTWuhmEjRTpwSngRJK2lBGNlDRQ6dHz
         gLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690564894; x=1691169694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2aSZfEbYtbSGJQH9qK4kw4x0HrKxSdAHUORKzF1l3U=;
        b=Zgt6GGC9OPQfUqueDT4h1sIZf4oAg8kZpENpQmTntFWmxy5cqxMfnHMY7422Z5QfXh
         FeaFNYLL044ZTObst347vPkePY6Bid45QgYhKcAHKDeG6gysRWM4HqZZ5MX262gb0P1J
         vivaDNaZg+NmPcEAg5Qrv0VxPJ0NuNTSwq5LQkkeutc18GqHKF39v60iewduQui1z9At
         T0qu4fROB2Pc86MDwHKj3PJVyRI7gUUR6uicJxfXw0mPwIbPznSKh4lKxeXTCBGFkU+V
         +PPgNav5+7YTgkxKjN3a2JGUvDyNoWqtuebu5lnXF2wnz4BuYwWLyXCs1HQv81Za4i0N
         d4VA==
X-Gm-Message-State: ABy/qLZa3pNmy8WPcJAcotoBs2XSvHxMMnShhp7dsumfeZxz24itu7uA
        jIQypZennBCum6wfrs4hyR4oAOMlqpR28IHGmLI9fuae
X-Google-Smtp-Source: APBJJlF9a9gebn8Q5IlJ5GaLBqHektBm//YSKxss5SJ5LAEbzyM8Ih0NfH76oXduK1qJKhlVj+FFLsg/ubF/v1Hd39k=
X-Received: by 2002:a2e:81cc:0:b0:2b9:afd1:b77a with SMTP id
 s12-20020a2e81cc000000b002b9afd1b77amr2166702ljg.0.1690564893843; Fri, 28 Jul
 2023 10:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230728044923.576144-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20230728044923.576144-1-simon.mikuda@streamunlimited.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 28 Jul 2023 10:21:21 -0700
Message-ID: <CABBYNZ+OkscU57380dpe6QkJJhbv2QLRq1xXdvHuw-W5JBanOg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] advertising: Fix setting "BR/EDR not supported" flag
To:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Simon,

On Thu, Jul 27, 2023 at 10:21=E2=80=AFPM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> We need to check if adapter is connectable since remote device can connec=
t
> to our device even when we are not discoverable according to advertised
> MAC address.

This is actually intentional, we don't want to 'leak' bearer
information if we are not discoverable over BR/EDR since when we are
just connectable we don't respond to inquiries then we shouldn't
advertise it either.

If the use case you want to support is to use an advertisement to
indicate to the remote end to connect over BR/EDR then it is probably
a better idea to make it discoverable on both bearers, then that flag
wont get set.

> ---
>  src/advertising.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index d959bf38f..b50900029 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -95,6 +95,8 @@ struct dbus_obj_match {
>         const char *path;
>  };
>
> +static int get_adv_flags(struct btd_adv_client *client);
> +
>  static bool match_client(const void *a, const void *b)
>  {
>         const struct btd_adv_client *client =3D a;
> @@ -736,11 +738,11 @@ static bool set_flags(struct btd_adv_client *client=
, uint8_t flags)
>         if (!btd_adapter_get_bredr(client->manager->adapter))
>                 flags |=3D BT_AD_FLAG_NO_BREDR;
>
> -       /* Set BR/EDR Not Supported if adapter is not discoverable but th=
e
> +       /* Set BR/EDR Not Supported if adapter is not connectable but the
>          * instance is.
>          */
> -       if ((flags & (BT_AD_FLAG_GENERAL | BT_AD_FLAG_LIMITED)) &&
> -                       !btd_adapter_get_discoverable(client->manager->ad=
apter))
> +       if ((get_adv_flags(client) & MGMT_ADV_FLAG_CONNECTABLE) &&
> +                       !btd_adapter_get_connectable(client->manager->ada=
pter))
>                 flags |=3D BT_AD_FLAG_NO_BREDR;
>
>         if (!bt_ad_add_flags(client->data, &flags, 1))
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
