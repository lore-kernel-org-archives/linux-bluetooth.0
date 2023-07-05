Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29B2EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 17:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjGERjR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjGERjQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 13:39:16 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240FC171A
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 10:39:12 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so1569481fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jul 2023 10:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688578750; x=1691170750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Weq9bZQxoIKIpV9bvKq/erXpr8iWhWkl79IG7bYwFpU=;
        b=LbvBmP78W0KdVhKDDz3h23KLTxREVkpgtNm1Nxz4J5ItjkFsBUW/L5eCvqXZKfPCQK
         kG5KQ8O3kutcv72BIJloMN38WFHmMvciPQwvEXhIcN56aREo6Gf2RkLLQ/j+yX1c+7E9
         UhE0DiRvNLKec1ZEty11shmK/ltprbVO2Ak5HbFqB80lDhf9bsDYzgPaW39RHaIdxMkn
         3BMUEno+GTePm+mqGh7YieQbGEVgSdqRxXcuCbYdETykFag7yLwRmH8RwAklY9bFifW3
         PbKCKBdrCH1gECX8r5baUy5EOwyqQiR9nbLUN+1MHv5uFgbctHbeGyeMHxPnzM1qoEeP
         4z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688578750; x=1691170750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Weq9bZQxoIKIpV9bvKq/erXpr8iWhWkl79IG7bYwFpU=;
        b=BjHUXsESKNez9hjLy3Sp1rBFML5Ed/D89A/+bAgYWxjYtm49cuGYjrT7PwI7znsfCj
         eZ/ctlCl7DZYnNOqW0QompKBJvyrf0pHUjfmuCnIoXdrM7J73U21/k2jjOVIXNuI5qls
         ejLzTc0lfIU/Pr8EfJNykvdoajChNSsvHjcjAF4aU7uEIHzko9v9laQM9/hDm+dF8qm2
         uuox2/dnsupeasNx1do0RyI0jTGdNPpKp6N+yZDxxQdi4JA7Nl+pV7tczKc2EbeDLhKq
         iJmnjCxOUzZIaSLmwsAqMrhyErGEI4tvzcEpSqJN9QcnTzgRDzEbUL0wd2fbv63UWO/N
         tYGg==
X-Gm-Message-State: ABy/qLbgj3XNeDaKsgMisP1Q8Iw7wiICt3kDRiP9lKzdEeqSJ2HJ8Xy7
        VD/8CVlLQG7JT+lDMAMDbWSojS6ff6V0fAw40mY=
X-Google-Smtp-Source: APBJJlEnH9JqtV2KbvWl2Q/2IDjSmHagJymDENfkKCTpJxlksWiwnJEdqCkrPWUjPOlzx725zi3KPR1vHgSHm0rIImI=
X-Received: by 2002:a05:651c:1055:b0:2b6:db9b:aadc with SMTP id
 x21-20020a05651c105500b002b6db9baadcmr10860912ljm.32.1688578749962; Wed, 05
 Jul 2023 10:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230705085131.6643-1-claudia.rosu@nxp.com> <20230705085131.6643-2-claudia.rosu@nxp.com>
In-Reply-To: <20230705085131.6643-2-claudia.rosu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 5 Jul 2023 10:38:57 -0700
Message-ID: <CABBYNZ+dh-E=zKARKcF9U6qbAAa-DkS=uOZHi_woicDX_Mu19g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/1] adapter: Allow broadcaster to be passed up
 to application
To:     Claudia Draghicescu <claudia.rosu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Claudia,

On Wed, Jul 5, 2023 at 2:02=E2=80=AFAM Claudia Draghicescu <claudia.rosu@nx=
p.com> wrote:
>
> Allow a broadcast advertiser to be passed up to application,
> if the scanner is an ISO Sync Receiver capable device.
> This allows for a broadcast sink to discover broadcast sources.
>
> ---
>  src/adapter.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 2679d4302..9c971d488 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -7031,6 +7031,16 @@ static bool is_filter_match(GSList *discovery_filt=
er, struct eir_data *eir_data,
>         return got_match;
>  }
>
> +static bool accept_bcast_adv(struct btd_adapter *adapter,
> +                               struct eir_data *eir_data)
> +{
> +       if ((btd_adapter_has_settings(adapter, MGMT_SETTING_ISO_SYNC_RECE=
IVER))
> +               && !(eir_data->flags & (EIR_LIM_DISC | EIR_GEN_DISC)))
> +               return true;
> +
> +       return false;
> +}
> +
>  static void filter_duplicate_data(void *data, void *user_data)
>  {
>         struct discovery_client *client =3D data;
> @@ -7154,12 +7164,18 @@ void btd_adapter_device_found(struct btd_adapter =
*adapter,
>                         return;
>                 }
>
> +               if (accept_bcast_adv(adapter, &eir_data))
> +                       monitoring =3D true;
> +
>                 if (!discoverable && !monitoring && !eir_data.rsi) {
>                         eir_data_free(&eir_data);
>                         return;
>                 }

Lets match by advertising UUID since it should contain a broadcast
audio announcement to be considered a broadcaster.

>                 dev =3D adapter_create_device(adapter, bdaddr, bdaddr_typ=
e);
> +
> +               if (accept_bcast_adv(adapter, &eir_data))
> +                       btd_device_set_temporary(dev, false);

I wouldn't persist broadcasters like that, at least not until we
synchronize with it, that said, if it is using a random address it
probably cannot be stored anyway.

>         }
>
>         if (!dev) {
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
