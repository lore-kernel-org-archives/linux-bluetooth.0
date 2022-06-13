Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B2FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 21:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiFMVzR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiFMVzR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 17:55:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A8C205EE
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 14:55:15 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l18so7619319lje.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 14:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bg59/+c/99J6whLduDvmaQTmtMcdqeOdyp0SOzHl9VM=;
        b=fSGFm46bCyhuVZX4FkZf+gYGn5nBWhO0p52UmQWD0MLL3+tuFXdHAtT983nj9zLPDY
         g6xX2gx9aL4mU8TeqNK+a90FGbbvnprrLVD9+t0gDSCzPKwsyYHUmYPao7KN1GURgDXP
         cnTG7vmhwC7kmHzxJeIbjVPzqm6MDfLzYzOUEAiU2QO+8sQPx6rkqVk18Zyq+cnGvS9+
         qIj/eKuln0E21AG5qyyfAVtzguFtTWA5mSLolg2QCie92XcY1cs0AbgnOzylEUSc6i77
         cQDXKjRdts8okvabe9clUxjvxrtUQt9M+AuZpGrWRVEpscdiXLGjvxIw38PriXw3uRnx
         BIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bg59/+c/99J6whLduDvmaQTmtMcdqeOdyp0SOzHl9VM=;
        b=WbMgbXi2vKyIUn/08H5hwtvYmf4CATrskGWpfihp3UEcvREt1kFxZVGbB6+X5zqn5/
         I1s5+5F6/C4Vsm6KjcPaOFhCA4BTpvWAvNLfg9keBlmh9mvPxMlhNJRIBqgGG93ap9hc
         7FzhRBifNVv+jFzEDiX0zWBXtM+lgyE0eTv0AAGWSHy3eIvlH1s4y5acz9dZJo/O30g1
         x+oqIRSujxaidUf2/x+Az9fDzQiAXgC4y4ON1PZ3J4ujzlL61dnyw9f6eh41I9m9DO2t
         Zzn9T0yuZc2kAc2Sd9rpX+bDv0NbXaeREBSRCVa1t0Ggp2I+QILzvxRnbkGR5x9a1nzX
         eAGw==
X-Gm-Message-State: AJIora85uBfyvUPO7I/j8T0B+jM/iodAV0G1qi0Xa3co164XYlyzBOHd
        mhLe+wK1HK5DCNLZBxLUUPCX8ka3oCr+UBTvANY=
X-Google-Smtp-Source: AGRyM1u2nF82bA4tO3Wh/ouyn4RiN/Bn/PfCfTm/uYUzgmiMYTKs33QY+643tgTHGN5Q9Tx7V653nvECo+eOiU3qnQA=
X-Received: by 2002:a2e:b53a:0:b0:255:7788:5790 with SMTP id
 z26-20020a2eb53a000000b0025577885790mr844281ljm.161.1655157313879; Mon, 13
 Jun 2022 14:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220610221124.18591-1-puffy.taco@gmail.com> <20220610221124.18591-2-puffy.taco@gmail.com>
 <CABBYNZKZ6jHeQMO3r_NC1phA03Vg67o9dejKSGpJ1i9LCq_aOQ@mail.gmail.com> <CAB7rCTg4+gmzD3emRB6rxfo7RiaJsU+4oBWVQBEut3nr-WqqRA@mail.gmail.com>
In-Reply-To: <CAB7rCTg4+gmzD3emRB6rxfo7RiaJsU+4oBWVQBEut3nr-WqqRA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Jun 2022 14:55:02 -0700
Message-ID: <CABBYNZJi+eQq=k_okUiPWr4vLr_Ehdrfq_RkSrkUqGKCeNPhng@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] eir: parse data types for LE OOB pairing
To:     Mike Brudevold <puffy.taco@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Michael Brudevold <michael.brudevold@veranexsolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mike,

On Mon, Jun 13, 2022 at 2:42 PM Mike Brudevold <puffy.taco@gmail.com> wrote:
>
> Hi Luiz,
>
> > It might be better to handle this via bt_ad instance instead of
> > eir_data, in fact the plan was always to switch to bt_ad but it seems
> > we forgot about it at some point.
>
> Are you thinking something like below (doesn't fully compile,
> name2utf8 is static in eir so I did nothing about that yet)?
> Basically where the ad code parses the EIR data, but the neard plugin
> still manages what to do with the data?  The alternative would be
> where device.c became smarter to consume the ad struct itself and the
> neard plugin becomes a simple conduit for the ad data.

The later is probably better alternative, like I said I wrote bt_ad to
replace eir handling completely so we could also write proper unit
testing for it, Im fine if you want to take the time to change the
daemon core itself but at least introduce support for the types you
will be using in the plugin and then make use of them.

> index 77a4630da..3d4064515 100644
> --- a/plugins/neard.c
> +++ b/plugins/neard.c
> @@ -31,6 +31,7 @@
>  #include "src/agent.h"
>  #include "src/btd.h"
>  #include "src/shared/util.h"
> +#include "src/shared/ad.h"
>
>  #define NEARD_NAME "org.neard"
>  #define NEARD_PATH "/org/neard"
> @@ -336,6 +337,52 @@ static int check_device(struct btd_device *device)
>         return 0;
>  }
>
> +static void process_oob_adv(void *data, void *user_data)
> +{
> +       struct bt_ad_data *ad_data = data;
> +       struct oob_params *remote = user_data;
> +       uint8_t name_len;
> +
> +       switch (ad_data->type) {
> +       case EIR_NAME_SHORT:
> +       case EIR_NAME_COMPLETE:
> +               name_len = ad_data->len;
> +
> +               /* Some vendors put a NUL byte terminator into
> +                       * the name */
> +               while (name_len > 0 && ad_data->data[name_len - 1] == '\0')
> +                       name_len--;
> +
> +               g_free(remote->name);
> +
> +               remote->name = name2utf8(ad_data->data, name_len);
> +               break;
> +
> +       case BT_AD_LE_DEVICE_ADDRESS:
> +               if (ad_data->len < sizeof(bdaddr_t) + 1)
> +                       break;
> +
> +               memcpy(&remote->address, ad_data->data, sizeof(bdaddr_t));
> +               remote->address_type = ad_data->data[sizeof(bdaddr_t)] & 0x1 ?
> +                               BDADDR_LE_RANDOM : BDADDR_LE_PUBLIC;
> +               break;
> +
> +       case EIR_LE_SC_CONF:
> +               if (ad_data->len < 16)
> +                       break;
> +               free(remote->hash256);
> +               remote->hash256 = util_memdup(ad_data->data, 16);
> +               break;
> +
> +       case EIR_LE_SC_RAND:
> +               if (ad_data->len < 16)
> +                       break;
> +               free(remote->randomizer256);
> +               remote->randomizer256 = util_memdup(ad_data->data, 16);
> +               break;
> +       }
> +}

Do we need to duplicate this information? I'd consider just using the
bt_ad instance to parse and store them, well perhaps we want to
introduce something like bt_ad_foreach_type so you can locate the data
by type?

>  static int process_eir(uint8_t *eir, size_t size, struct oob_params *remote)
>  {
>         struct eir_data eir_data;
> @@ -370,32 +417,17 @@ static int process_eir(uint8_t *eir, size_t
> size, struct oob_params *remote)
>
>  static void process_eir_le(uint8_t *eir, size_t size, struct
> oob_params *remote)
>  {
> -       struct eir_data eir_data;
> +       struct bt_ad *ad;
>
>         DBG("size %zu", size);
>
> -       memset(&eir_data, 0, sizeof(eir_data));
> -
> -       eir_parse(&eir_data, eir, size);
> -
> -       bacpy(&remote->address, &eir_data.addr);
> -       remote->address_type = eir_data.addr_type;
> -
> -       remote->class = eir_data.class;
> -
> -       remote->name = eir_data.name;
> -       eir_data.name = NULL;
> -
> -       remote->services = eir_data.services;
> -       eir_data.services = NULL;
> -
> -       remote->hash256 = eir_data.hash256;
> -       eir_data.hash256 = NULL;
> +       ad = bt_ad_new_with_data(size, eir);
>
> -       remote->randomizer256 = eir_data.randomizer256;
> -       eir_data.randomizer256 = NULL;
> +       if (ad) {
> +               bt_ad_foreach_data(ad, process_oob_adv, remote);
>
> -       eir_data_free(&eir_data);
> +               bt_ad_unref(ad);
> +       }
>  }



-- 
Luiz Augusto von Dentz
