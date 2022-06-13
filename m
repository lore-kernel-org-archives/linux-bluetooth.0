Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DB3C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 22:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiFMW2x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiFMW2w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 18:28:52 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C17AE43
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 15:28:51 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s10so7696851ljh.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 15:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0mRUAXK6ebsJ5++EX64A/OLMF5HZn19tvc9idLLSyZ8=;
        b=NE0UgYWJesclme8vHImffH8jiVix/YZA2uuIVHWM6GPRYjwzS2EnOdwISO08fTNrTR
         lx8dHn412eaheMGnhEuWP9SvpsBEha6p7VoUIj3k39L5F5IdFEkB8L/r7bnlGUyI6M0Q
         XcxBoyWtTEHk5otvhhIYPSoj06J0RqL+5rziXHpgeBoi5kR+i4Imzz7RCapL5qW3K6JW
         ya6qy9IvGTWKdnz6X2M/7SPB+ildDNWfCXIc25xcF/vQ7Lo5wn8LaoU+b0QnR3veBDbS
         F7PxHyHEScqt64Znw2qgpe5JiD3sGD2O5OZAG5fyvMvM+D/fCX9Is5LvGd4IzAoFhxJ3
         FAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0mRUAXK6ebsJ5++EX64A/OLMF5HZn19tvc9idLLSyZ8=;
        b=buTAUgNrOZiGJaB/Ex8hvS70yhPnKT5FzgP2nMWmIBmVC93T0Hgx11Z85SSvlaa9H6
         hacSvDBjevpCTYvDM8qKm4RBArfiyqSsiOKfnPlHazEvrPZnKDB2B8o//MmB6pzYxGRb
         BdMDSBDErxAtLwFOqFRXQeaX9McL6fZzjI2Jzx75hmdc2xwlk8JeAm7DZtw4PY7jSyyg
         Ovxilxm4k/7ItjOf1RULY8wKEtClqdJroSp1vypQobqMOL93u+nSMdZk3dsLfkqdM8pI
         KxkeGFjIb7CZxoPLk++oa/x6Xb6fPxfE3aP0JYt3ZMtodysITRojVTk1euUtqgTqCKqO
         UVgw==
X-Gm-Message-State: AJIora9dWSHzuK61PbrYxL0yJgbqjDMAUTHszHV52WzECZ1r3lwQmRmv
        XtnTW0URZnDtQQOb2E8Qejb3gvBYQrUp/pYDvx4=
X-Google-Smtp-Source: AGRyM1sljmonsUAuNlTfJ9gOUHiTdggc9GPsUTETuP29Mqd/79W9TJM/sGcxlxPXmGMobU26BBaRtzj1wU+xi/4g4rA=
X-Received: by 2002:a2e:a315:0:b0:259:e8b:5b23 with SMTP id
 l21-20020a2ea315000000b002590e8b5b23mr860176lje.115.1655159329638; Mon, 13
 Jun 2022 15:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220610221124.18591-1-puffy.taco@gmail.com> <20220610221124.18591-2-puffy.taco@gmail.com>
 <CABBYNZKZ6jHeQMO3r_NC1phA03Vg67o9dejKSGpJ1i9LCq_aOQ@mail.gmail.com>
 <CAB7rCTg4+gmzD3emRB6rxfo7RiaJsU+4oBWVQBEut3nr-WqqRA@mail.gmail.com> <CABBYNZJi+eQq=k_okUiPWr4vLr_Ehdrfq_RkSrkUqGKCeNPhng@mail.gmail.com>
In-Reply-To: <CABBYNZJi+eQq=k_okUiPWr4vLr_Ehdrfq_RkSrkUqGKCeNPhng@mail.gmail.com>
From:   Mike Brudevold <puffy.taco@gmail.com>
Date:   Mon, 13 Jun 2022 17:28:35 -0500
Message-ID: <CAB7rCThqud+vVcvsiDi+0f-7itVcc4Dn2Xx95Kzwb9FmM=1XDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] eir: parse data types for LE OOB pairing
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Michael Brudevold <michael.brudevold@veranexsolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Mon, Jun 13, 2022 at 4:55 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Mike,
>
> On Mon, Jun 13, 2022 at 2:42 PM Mike Brudevold <puffy.taco@gmail.com> wrote:
> >
> > Hi Luiz,
> >
> > > It might be better to handle this via bt_ad instance instead of
> > > eir_data, in fact the plan was always to switch to bt_ad but it seems
> > > we forgot about it at some point.
> >
> > Are you thinking something like below (doesn't fully compile,
> > name2utf8 is static in eir so I did nothing about that yet)?
> > Basically where the ad code parses the EIR data, but the neard plugin
> > still manages what to do with the data?  The alternative would be
> > where device.c became smarter to consume the ad struct itself and the
> > neard plugin becomes a simple conduit for the ad data.
>
> The later is probably better alternative, like I said I wrote bt_ad to
> replace eir handling completely so we could also write proper unit
> testing for it, Im fine if you want to take the time to change the
> daemon core itself but at least introduce support for the types you
> will be using in the plugin and then make use of them.
>
> > index 77a4630da..3d4064515 100644
> > --- a/plugins/neard.c
> > +++ b/plugins/neard.c
> > @@ -31,6 +31,7 @@
> >  #include "src/agent.h"
> >  #include "src/btd.h"
> >  #include "src/shared/util.h"
> > +#include "src/shared/ad.h"
> >
> >  #define NEARD_NAME "org.neard"
> >  #define NEARD_PATH "/org/neard"
> > @@ -336,6 +337,52 @@ static int check_device(struct btd_device *device)
> >         return 0;
> >  }
> >
> > +static void process_oob_adv(void *data, void *user_data)
> > +{
> > +       struct bt_ad_data *ad_data = data;
> > +       struct oob_params *remote = user_data;
> > +       uint8_t name_len;
> > +
> > +       switch (ad_data->type) {
> > +       case EIR_NAME_SHORT:
> > +       case EIR_NAME_COMPLETE:
> > +               name_len = ad_data->len;
> > +
> > +               /* Some vendors put a NUL byte terminator into
> > +                       * the name */
> > +               while (name_len > 0 && ad_data->data[name_len - 1] == '\0')
> > +                       name_len--;
> > +
> > +               g_free(remote->name);
> > +
> > +               remote->name = name2utf8(ad_data->data, name_len);
> > +               break;
> > +
> > +       case BT_AD_LE_DEVICE_ADDRESS:
> > +               if (ad_data->len < sizeof(bdaddr_t) + 1)
> > +                       break;
> > +
> > +               memcpy(&remote->address, ad_data->data, sizeof(bdaddr_t));
> > +               remote->address_type = ad_data->data[sizeof(bdaddr_t)] & 0x1 ?
> > +                               BDADDR_LE_RANDOM : BDADDR_LE_PUBLIC;
> > +               break;
> > +
> > +       case EIR_LE_SC_CONF:
> > +               if (ad_data->len < 16)
> > +                       break;
> > +               free(remote->hash256);
> > +               remote->hash256 = util_memdup(ad_data->data, 16);
> > +               break;
> > +
> > +       case EIR_LE_SC_RAND:
> > +               if (ad_data->len < 16)
> > +                       break;
> > +               free(remote->randomizer256);
> > +               remote->randomizer256 = util_memdup(ad_data->data, 16);
> > +               break;
> > +       }
> > +}
>
> Do we need to duplicate this information? I'd consider just using the
> bt_ad instance to parse and store them, well perhaps we want to
> introduce something like bt_ad_foreach_type so you can locate the data
> by type?

That's partly what I was checking on.  The ad code doesn't have much
functionality right now to be able to parse the meaning of the data,
beyond storing them in TLV format (bt_ad_data).  Which is the opposite
to how the data is given to ad if you're creating an advertisement
(e.g., service UUIDs are stored in bt_uuid_t format inside the service
queue when using bt_ad_add_service_uuid, not in the data queue).  This
means the ad code likely has to get smarter, but I wanted to make sure
I wasn't missing something that should have been obvious.  If the ad
code can present the data back in a usable format, then it wouldn't
really have to be duplicated.  Otherwise this code would have been an
easy way to not use the eir code while the ad code gets developed.
With some concern still that there's a type_reject_list related to the
data ad queue, but that can be completely bypassed when using
bt_ad_new_with_data - so this method is doing something that seems
unintended.

>
> >  static int process_eir(uint8_t *eir, size_t size, struct oob_params *remote)
> >  {
> >         struct eir_data eir_data;
> > @@ -370,32 +417,17 @@ static int process_eir(uint8_t *eir, size_t
> > size, struct oob_params *remote)
> >
> >  static void process_eir_le(uint8_t *eir, size_t size, struct
> > oob_params *remote)
> >  {
> > -       struct eir_data eir_data;
> > +       struct bt_ad *ad;
> >
> >         DBG("size %zu", size);
> >
> > -       memset(&eir_data, 0, sizeof(eir_data));
> > -
> > -       eir_parse(&eir_data, eir, size);
> > -
> > -       bacpy(&remote->address, &eir_data.addr);
> > -       remote->address_type = eir_data.addr_type;
> > -
> > -       remote->class = eir_data.class;
> > -
> > -       remote->name = eir_data.name;
> > -       eir_data.name = NULL;
> > -
> > -       remote->services = eir_data.services;
> > -       eir_data.services = NULL;
> > -
> > -       remote->hash256 = eir_data.hash256;
> > -       eir_data.hash256 = NULL;
> > +       ad = bt_ad_new_with_data(size, eir);
> >
> > -       remote->randomizer256 = eir_data.randomizer256;
> > -       eir_data.randomizer256 = NULL;
> > +       if (ad) {
> > +               bt_ad_foreach_data(ad, process_oob_adv, remote);
> >
> > -       eir_data_free(&eir_data);
> > +               bt_ad_unref(ad);
> > +       }
> >  }
>
>
>
> --
> Luiz Augusto von Dentz
