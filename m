Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734E8C001E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 23:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjHHXVP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 19:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjHHXVO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 19:21:14 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8344F1BE1
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 16:21:12 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso95506491fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Aug 2023 16:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691536871; x=1692141671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IjCgF6bbim8x60egR3BL5qa6jVn/etl5Sq0m7ZXh2c=;
        b=SUU+/9ObwfR9LQa/neotxTj0o9P5AVcWtJ6Z3XgaxKTTIf7RK99r9zn3u1BzmKa+Of
         1KaskXjfRLzGiI0/ounGs+9BLdbDUj3h6JuehluK5PcrqT/4OsXQXNdVjPunPg/xvSNq
         xBGa+1Rb+PjHG86DunBVbjU9jWNarse53KdDON0UCJGFUm/BvHPGQ2ncCO0fUFWWc3U2
         kegomZLsFhKWD/XBW9CpEvWKQvu0nhpLXUppCqqZNvzzU7GqPms+OLmFoid5OIcfy7yF
         SbzDR8GA9TqBjQelIwLLlMQoLCzYsnfu5yCYFmZVmnuWPcd/rZmwnwksg94IAvF0kTbz
         +DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691536871; x=1692141671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IjCgF6bbim8x60egR3BL5qa6jVn/etl5Sq0m7ZXh2c=;
        b=NhoKRSCPOCIV2YsuFNAHnHICjXxvMD1n9U8s0ZuvyR0Ao2lYglbXqRl2qxxxyrRYIz
         Q1A7j3JvU80FbQLe64Dgb1y4/SN4p4870P8P6ed2SKx9352IkT63AOH/KHt8WIulnF+Y
         vJFaxLYlgXeCkbcO5tFmmpyou11Tjm3MwzvXmwHCDLjHfehLErTA7Jh8PBLs62KaWBK9
         gPbsEGbWo37bLGwIFMt/dIbiEq7s4Di7M0B9hZ4WXKkPxGLqmjYpabrSamH+lsARJAqq
         4qMNNkixVzu3cSZRvVuFHnpKW66SzU8l2NgepnVsN+u6FRDJI/KUdOTjgT6ww3AAnwpE
         21Pw==
X-Gm-Message-State: AOJu0YwmyB3VrxlHBkI0OY/zWSDxXbeyj3tE/exBFG/c4+d9Wtjgz3HH
        z765pQ81By9aGvKeBOtsHpYuHP3ieo5t8YSv65huxEd+
X-Google-Smtp-Source: AGHT+IFb2dDrlqk0MUSQ+TMjRCkPVvhPxEF/pSVjaXV7MYewd2mMMEdB+E9ovxrtBZzRQkIc2q/0mWVqM85IXvrk204=
X-Received: by 2002:a2e:7a0f:0:b0:2b6:dc55:c3c7 with SMTP id
 v15-20020a2e7a0f000000b002b6dc55c3c7mr643174ljc.20.1691536870452; Tue, 08 Aug
 2023 16:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230808115040.4403-1-claudia.rosu@nxp.com> <20230808115040.4403-4-claudia.rosu@nxp.com>
In-Reply-To: <20230808115040.4403-4-claudia.rosu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 8 Aug 2023 16:20:58 -0700
Message-ID: <CABBYNZJEhRvT8w9C-JBcr2pjNdStN3KkYO2zyuLb+2=5NWPhZw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 3/7] adapter: Do not filter out broadcast advertiser
To:     Claudia Draghicescu <claudia.rosu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Claudia,

On Tue, Aug 8, 2023 at 9:45=E2=80=AFAM Claudia Draghicescu <claudia.rosu@nx=
p.com> wrote:
>
> This allows a broadcast advertiser to be passed up to application,
> if the adapter has the capability of being a Synchronized Receiver.

We probably need a proper method to check if there is any profile with
probe_on_discover that matches the advertising before we allow every
broadcaster to be added as a new device.

> ---
>  src/adapter.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 491bd7031..fa15030e0 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -7029,6 +7029,13 @@ static bool is_filter_match(GSList *discovery_filt=
er, struct eir_data *eir_data,
>         return got_match;
>  }
>
> +static bool accept_bcast_adv(struct btd_adapter *adapter)
> +{
> +       if ((btd_adapter_has_settings(adapter, MGMT_SETTING_ISO_SYNC_RECE=
IVER)))
> +               return true;
> +
> +       return false;
> +}
>  static void filter_duplicate_data(void *data, void *user_data)
>  {
>         struct discovery_client *client =3D data;
> @@ -7152,6 +7159,9 @@ void btd_adapter_device_found(struct btd_adapter *a=
dapter,
>                         return;
>                 }
>
> +               if (accept_bcast_adv(adapter))
> +                       monitoring =3D true;
> +
>                 if (!discoverable && !monitoring && !eir_data.rsi) {
>                         eir_data_free(&eir_data);
>                         return;
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
