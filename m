Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA98DC43334
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jun 2022 20:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiFKU1U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Jun 2022 16:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiFKU1T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Jun 2022 16:27:19 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE4369734
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jun 2022 13:27:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y29so2440329ljd.7
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jun 2022 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNbFgUcUnaO2kGN77TjZj3rfpNNWIIveazG/oZ1/HFk=;
        b=jFB+cxyRAIkiGp8NFEjwgqhJLuZTqmGHIWOA7a4VH+WiEJhtAE3cc7DniNTEDL8/wk
         13X01qqD055tjfKo6PsjOI74oRw7zzgvUIWdN9XtxLRqOloCMkzefXqB0EAefyqIjsAA
         JZyHwBttdl3pBw7OcShs8NBH6iOG0jjxWAi1j+NbcQyqLWZP1bF4K1GIIN74Fgs6wGmb
         ZlS6wOR1rkbuwk0t574PY110f5qrCXB6Pwa9sseMdLzI2Q+Cc74BbyIXk9Oc8lmbPGS+
         2SJ0TTFTfR32NzCyTcQn1lpnlL0NvMN4SlEsxAtoBQtGSrADA++KyrXIXfeb0qNoSje5
         kB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNbFgUcUnaO2kGN77TjZj3rfpNNWIIveazG/oZ1/HFk=;
        b=KXvo0/0G/c8mXK/wMGl0Kuv8h/tvT0Na340UYnwCSEljwQOoWZhpfuljfWMWVVrWwM
         O2Kedk0xormhL0A35U9TlvIBqtDflgm44VMRAmN8uUdKECt29XzkLDAtT/yRRi7kMgLa
         pisbOI2xwSNyqicFAYZctIpTUPhz9+nSeDuSkRcFdlvUe9OZrErXgGQEvfJ93VuTIU1l
         NU6Jb9UkIVoiNwWtcUIoq12r4eD6I0yF2pqhb3qWIt7t3Bsj4xdnIZNMvDza/V4SVryA
         EjzIcsTkOYdcLSGZRroVysqufC2nuwR6FpqguA6VV9GTk+H2NJRRCKt9g/cW7yKhpaoL
         tVIg==
X-Gm-Message-State: AOAM5308B0omoEsER6itczzCAOWLjY0lUlpW+eLzZVJhxSvPFIEcqB8H
        qB3WHmAONHZl4v+uvPUHe3vNnvbsG/vXrlWasnNwqxQ8
X-Google-Smtp-Source: ABdhPJwF4b0WFz083yAflZKymp682OWPLoO2+1+ZjiBr6zo+N6jcpDQolz4g+pzK8YxXHrYD47aGjTYwW0+vvizYmP8=
X-Received: by 2002:a2e:b985:0:b0:255:9589:4746 with SMTP id
 p5-20020a2eb985000000b0025595894746mr17668793ljp.260.1654979236116; Sat, 11
 Jun 2022 13:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220610221124.18591-1-puffy.taco@gmail.com> <20220610221124.18591-2-puffy.taco@gmail.com>
In-Reply-To: <20220610221124.18591-2-puffy.taco@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 11 Jun 2022 13:27:08 -0700
Message-ID: <CABBYNZKZ6jHeQMO3r_NC1phA03Vg67o9dejKSGpJ1i9LCq_aOQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] eir: parse data types for LE OOB pairing
To:     Michael Brudevold <puffy.taco@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Michael Brudevold <michael.brudevold@veranexsolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Michael,

On Fri, Jun 10, 2022 at 3:49 PM Michael Brudevold <puffy.taco@gmail.com> wrote:
>
> From: Michael Brudevold <michael.brudevold@veranexsolutions.com>
>
> LE support added for P-256 and split out from existing BREDR support for
> P-192
>
> Also attempt to free any existing values before setting new values
> ---
>  plugins/neard.c |  8 ++++----
>  src/eir.c       | 41 +++++++++++++++++++++++++++++++++++------
>  src/eir.h       | 10 ++++++++--
>  3 files changed, 47 insertions(+), 12 deletions(-)
>
> diff --git a/plugins/neard.c b/plugins/neard.c
> index 99762482c..11d9e91c4 100644
> --- a/plugins/neard.c
> +++ b/plugins/neard.c
> @@ -352,11 +352,11 @@ static int process_eir(uint8_t *eir, size_t size, struct oob_params *remote)
>         remote->services = eir_data.services;
>         eir_data.services = NULL;
>
> -       remote->hash = eir_data.hash;
> -       eir_data.hash = NULL;
> +       remote->hash = eir_data.hash192;
> +       eir_data.hash192 = NULL;
>
> -       remote->randomizer = eir_data.randomizer;
> -       eir_data.randomizer = NULL;
> +       remote->randomizer = eir_data.randomizer192;
> +       eir_data.randomizer192 = NULL;
>
>         eir_data_free(&eir_data);
>
> diff --git a/src/eir.c b/src/eir.c
> index 2f9ee036f..79d423074 100644
> --- a/src/eir.c
> +++ b/src/eir.c
> @@ -53,10 +53,14 @@ void eir_data_free(struct eir_data *eir)
>         eir->services = NULL;
>         g_free(eir->name);
>         eir->name = NULL;
> -       free(eir->hash);
> -       eir->hash = NULL;
> -       free(eir->randomizer);
> -       eir->randomizer = NULL;
> +       free(eir->hash192);
> +       eir->hash192 = NULL;
> +       free(eir->randomizer192);
> +       eir->randomizer192 = NULL;
> +       free(eir->hash256);
> +       eir->hash256 = NULL;
> +       free(eir->randomizer256);
> +       eir->randomizer256 = NULL;
>         g_slist_free_full(eir->msd_list, g_free);
>         eir->msd_list = NULL;
>         g_slist_free_full(eir->sd_list, sd_free);
> @@ -323,13 +327,15 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
>                 case EIR_SSP_HASH:
>                         if (data_len < 16)
>                                 break;
> -                       eir->hash = util_memdup(data, 16);
> +                       free(eir->hash192);
> +                       eir->hash192 = util_memdup(data, 16);
>                         break;
>
>                 case EIR_SSP_RANDOMIZER:
>                         if (data_len < 16)
>                                 break;
> -                       eir->randomizer = util_memdup(data, 16);
> +                       free(eir->randomizer192);
> +                       eir->randomizer192 = util_memdup(data, 16);
>                         break;
>
>                 case EIR_DEVICE_ID:
> @@ -342,6 +348,15 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
>                         eir->did_version = data[6] | (data[7] << 8);
>                         break;
>
> +               case EIR_LE_DEVICE_ADDRESS:
> +                       if (data_len < sizeof(bdaddr_t) + 1)
> +                               break;
> +
> +                       memcpy(&eir->addr, data, sizeof(bdaddr_t));
> +                       eir->addr_type = data[sizeof(bdaddr_t)] & 0x1 ?
> +                                       BDADDR_LE_RANDOM : BDADDR_LE_PUBLIC;
> +                       break;
> +
>                 case EIR_SVC_DATA16:
>                         eir_parse_uuid16_data(eir, data, data_len);
>                         break;
> @@ -354,6 +369,20 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
>                         eir_parse_uuid128_data(eir, data, data_len);
>                         break;
>
> +               case EIR_LE_SC_CONF:
> +                       if (data_len < 16)
> +                               break;
> +                       free(eir->hash256);
> +                       eir->hash256 = util_memdup(data, 16);
> +                       break;
> +
> +               case EIR_LE_SC_RAND:
> +                       if (data_len < 16)
> +                               break;
> +                       free(eir->randomizer256);
> +                       eir->randomizer256 = util_memdup(data, 16);
> +                       break;
> +
>                 case EIR_MANUFACTURER_DATA:
>                         eir_parse_msd(eir, data, data_len);
>                         break;
> diff --git a/src/eir.h b/src/eir.h
> index 6154e23ec..b2cf00f37 100644
> --- a/src/eir.h
> +++ b/src/eir.h
> @@ -33,9 +33,12 @@
>  #define EIR_PUB_TRGT_ADDR           0x17  /* LE: Public Target Address */
>  #define EIR_RND_TRGT_ADDR           0x18  /* LE: Random Target Address */
>  #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
> +#define EIR_LE_DEVICE_ADDRESS       0x1B  /* LE: Bluetooth Device Address */
>  #define EIR_SOLICIT32               0x1F  /* LE: Solicit UUIDs, 32-bit */
>  #define EIR_SVC_DATA32              0x20  /* LE: Service data, 32-bit UUID */
>  #define EIR_SVC_DATA128             0x21  /* LE: Service data, 128-bit UUID */
> +#define EIR_LE_SC_CONF              0x22  /* LE: Secure Connections Confirmation Value */
> +#define EIR_LE_SC_RAND              0x23  /* LE: Secure Connections Random Value */
>  #define EIR_TRANSPORT_DISCOVERY     0x26  /* Transport Discovery Service */
>  #define EIR_MANUFACTURER_DATA       0xFF  /* Manufacturer Specific Data */
>
> @@ -77,9 +80,12 @@ struct eir_data {
>         uint16_t appearance;
>         bool name_complete;
>         int8_t tx_power;
> -       uint8_t *hash;
> -       uint8_t *randomizer;
> +       uint8_t *hash192;
> +       uint8_t *randomizer192;
> +       uint8_t *hash256;
> +       uint8_t *randomizer256;
>         bdaddr_t addr;
> +       uint8_t addr_type;
>         uint16_t did_vendor;
>         uint16_t did_product;
>         uint16_t did_version;
> --
> 2.25.1

It might be better to handle this via bt_ad instance instead of
eir_data, in fact the plan was always to switch to bt_ad but it seems
we forgot about it at some point.



-- 
Luiz Augusto von Dentz
