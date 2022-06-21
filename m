Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7E4C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 19:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353085AbiFUTuy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 15:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiFUTuw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 15:50:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F079222B2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:50:50 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a2so24131839lfg.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WU3y1B0RmPPfJIlasNzHEh7Zf6yfnOBcCr1A2164i9w=;
        b=HUic6AwPo37gJNaCyK2kaGk/qc4XnqiNp6TjoeMKxtlmCA/CiOsteKYq828wmTqkmy
         hj/ve/4X+wucogHjCOhugY4sIdIYDy1/49Fr8nLh3GqhTd7HXmB5g5AUf+N8cbAfJ7FE
         UQfGaEitGzBV0Dfyz7ZkvK9mSO4d/wakyNVAXNzQ3TXhJsx3Lci8cCIq97UhhGvQKyXg
         NAyjCS5frxHB/7lwIMVFXddFZMqf6G+TLNlQzBeuGas/0+7ZB+kdNXc49SKh5q2iBwiV
         XpxnF2KHGdsHVUD00NiMYR163Jot5NE6E7b9CPcnU0n5BPAdDlNo3WFvT+BY6jKYVD5F
         1scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WU3y1B0RmPPfJIlasNzHEh7Zf6yfnOBcCr1A2164i9w=;
        b=TWl1hg5Pjs+UMVedAKVhoegChAkPdSMHWQIVymmiTfTqi2U2qcDLMxlGiQcrNzgxPi
         xmwJuvGdTVIS6tdAHwO/ZdSnAKP/p6yv88rqnOYOTPOu+UbxXnRk1j/ZDgYt1brWNWC0
         GudSJTSqk6O9GLifv4/PYYMwqtpJlTqLmU6CToz2pfZDjYGfxW7GjuWjpKJPSB1A5ql2
         a/YNGJMDA1mJjn+v/AEF6YSSF4Vls5ZczMBNFRBSIp7X0cBMFTSBqLfoJKO5SxDnHi4J
         f6Z1/aGmPRZ9sAOFloTUQPe/gk15fy3ST6ykO/wI6GNpPVrJoSC1VdOOddx9qgaoascI
         T8FA==
X-Gm-Message-State: AJIora9vOC5tbxYoJ0HGrHoL96PrNeoiToxwK6SfzU5FKwqG5asb2EeG
        QOtMpdD/w50Jz0EhMa8hXyMTZIYo4KrLwY1pMB/+Jc7LZkQ=
X-Google-Smtp-Source: AGRyM1vqxRqcvV5DfbeFqOAXQUqJxIzTtwfWDZi2UW0OV+Kpu75MgjBiITPMWZ9D6nK7jk+nG2F1E1YVI9zieKG5cL4=
X-Received: by 2002:a05:6512:ba6:b0:47f:8c91:b33d with SMTP id
 b38-20020a0565120ba600b0047f8c91b33dmr1982409lfv.104.1655841048196; Tue, 21
 Jun 2022 12:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220610221124.18591-1-puffy.taco@gmail.com> <20220610221124.18591-2-puffy.taco@gmail.com>
 <CABBYNZKZ6jHeQMO3r_NC1phA03Vg67o9dejKSGpJ1i9LCq_aOQ@mail.gmail.com>
 <CAB7rCTg4+gmzD3emRB6rxfo7RiaJsU+4oBWVQBEut3nr-WqqRA@mail.gmail.com>
 <CABBYNZJi+eQq=k_okUiPWr4vLr_Ehdrfq_RkSrkUqGKCeNPhng@mail.gmail.com>
 <CAB7rCThqud+vVcvsiDi+0f-7itVcc4Dn2Xx95Kzwb9FmM=1XDg@mail.gmail.com> <CABBYNZLYVYFS1Q_Cksyzy5shWOs8y78v6sehneO2F2cD6C628A@mail.gmail.com>
In-Reply-To: <CABBYNZLYVYFS1Q_Cksyzy5shWOs8y78v6sehneO2F2cD6C628A@mail.gmail.com>
From:   Mike Brudevold <puffy.taco@gmail.com>
Date:   Tue, 21 Jun 2022 14:50:36 -0500
Message-ID: <CAB7rCTh1COpsYMtCJMHn-MecqM5Z4wLgs76eePE+oUkSrWG_hg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] eir: parse data types for LE OOB pairing
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Michael Brudevold <michael.brudevold@veranexsolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, Jun 21, 2022 at 1:57 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Mike,
>
> On Mon, Jun 13, 2022 at 3:28 PM Mike Brudevold <puffy.taco@gmail.com> wrote:
> >
> > Hi Luiz,
> >
> > On Mon, Jun 13, 2022 at 4:55 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Mike,
> > >
> > > On Mon, Jun 13, 2022 at 2:42 PM Mike Brudevold <puffy.taco@gmail.com> wrote:
> > > >
> > > > Hi Luiz,
> > > >
> > > > > It might be better to handle this via bt_ad instance instead of
> > > > > eir_data, in fact the plan was always to switch to bt_ad but it seems
> > > > > we forgot about it at some point.
> > > >
> > > > Are you thinking something like below (doesn't fully compile,
> > > > name2utf8 is static in eir so I did nothing about that yet)?
> > > > Basically where the ad code parses the EIR data, but the neard plugin
> > > > still manages what to do with the data?  The alternative would be
> > > > where device.c became smarter to consume the ad struct itself and the
> > > > neard plugin becomes a simple conduit for the ad data.
> > >
> > > The later is probably better alternative, like I said I wrote bt_ad to
> > > replace eir handling completely so we could also write proper unit
> > > testing for it, Im fine if you want to take the time to change the
> > > daemon core itself but at least introduce support for the types you
> > > will be using in the plugin and then make use of them.
> > >
> > > > index 77a4630da..3d4064515 100644
> > > > --- a/plugins/neard.c
> > > > +++ b/plugins/neard.c
> > > > @@ -31,6 +31,7 @@
> > > >  #include "src/agent.h"
> > > >  #include "src/btd.h"
> > > >  #include "src/shared/util.h"
> > > > +#include "src/shared/ad.h"
> > > >
> > > >  #define NEARD_NAME "org.neard"
> > > >  #define NEARD_PATH "/org/neard"
> > > > @@ -336,6 +337,52 @@ static int check_device(struct btd_device *device)
> > > >         return 0;
> > > >  }
> > > >
> > > > +static void process_oob_adv(void *data, void *user_data)
> > > > +{
> > > > +       struct bt_ad_data *ad_data = data;
> > > > +       struct oob_params *remote = user_data;
> > > > +       uint8_t name_len;
> > > > +
> > > > +       switch (ad_data->type) {
> > > > +       case EIR_NAME_SHORT:
> > > > +       case EIR_NAME_COMPLETE:
> > > > +               name_len = ad_data->len;
> > > > +
> > > > +               /* Some vendors put a NUL byte terminator into
> > > > +                       * the name */
> > > > +               while (name_len > 0 && ad_data->data[name_len - 1] == '\0')
> > > > +                       name_len--;
> > > > +
> > > > +               g_free(remote->name);
> > > > +
> > > > +               remote->name = name2utf8(ad_data->data, name_len);
> > > > +               break;
> > > > +
> > > > +       case BT_AD_LE_DEVICE_ADDRESS:
> > > > +               if (ad_data->len < sizeof(bdaddr_t) + 1)
> > > > +                       break;
> > > > +
> > > > +               memcpy(&remote->address, ad_data->data, sizeof(bdaddr_t));
> > > > +               remote->address_type = ad_data->data[sizeof(bdaddr_t)] & 0x1 ?
> > > > +                               BDADDR_LE_RANDOM : BDADDR_LE_PUBLIC;
> > > > +               break;
> > > > +
> > > > +       case EIR_LE_SC_CONF:
> > > > +               if (ad_data->len < 16)
> > > > +                       break;
> > > > +               free(remote->hash256);
> > > > +               remote->hash256 = util_memdup(ad_data->data, 16);
> > > > +               break;
> > > > +
> > > > +       case EIR_LE_SC_RAND:
> > > > +               if (ad_data->len < 16)
> > > > +                       break;
> > > > +               free(remote->randomizer256);
> > > > +               remote->randomizer256 = util_memdup(ad_data->data, 16);
> > > > +               break;
> > > > +       }
> > > > +}
> > >
> > > Do we need to duplicate this information? I'd consider just using the
> > > bt_ad instance to parse and store them, well perhaps we want to
> > > introduce something like bt_ad_foreach_type so you can locate the data
> > > by type?
> >
> > That's partly what I was checking on.  The ad code doesn't have much
> > functionality right now to be able to parse the meaning of the data,
> > beyond storing them in TLV format (bt_ad_data).  Which is the opposite
> > to how the data is given to ad if you're creating an advertisement
> > (e.g., service UUIDs are stored in bt_uuid_t format inside the service
> > queue when using bt_ad_add_service_uuid, not in the data queue).  This
> > means the ad code likely has to get smarter, but I wanted to make sure
> > I wasn't missing something that should have been obvious.  If the ad
> > code can present the data back in a usable format, then it wouldn't
> > really have to be duplicated.  Otherwise this code would have been an
> > easy way to not use the eir code while the ad code gets developed.
> > With some concern still that there's a type_reject_list related to the
> > data ad queue, but that can be completely bypassed when using
> > bt_ad_new_with_data - so this method is doing something that seems
> > unintended.
>
> Are you missing some feedback on these changes?

If you have any, I welcome them.  I have an idea of what I would do to
augment struct bt_ad by making bt_ad_new_with_data smarter to parse
out to other queues/data values, but it hasn't been the highest
priority so I haven't put any time into it.

>
> > >
> > > >  static int process_eir(uint8_t *eir, size_t size, struct oob_params *remote)
> > > >  {
> > > >         struct eir_data eir_data;
> > > > @@ -370,32 +417,17 @@ static int process_eir(uint8_t *eir, size_t
> > > > size, struct oob_params *remote)
> > > >
> > > >  static void process_eir_le(uint8_t *eir, size_t size, struct
> > > > oob_params *remote)
> > > >  {
> > > > -       struct eir_data eir_data;
> > > > +       struct bt_ad *ad;
> > > >
> > > >         DBG("size %zu", size);
> > > >
> > > > -       memset(&eir_data, 0, sizeof(eir_data));
> > > > -
> > > > -       eir_parse(&eir_data, eir, size);
> > > > -
> > > > -       bacpy(&remote->address, &eir_data.addr);
> > > > -       remote->address_type = eir_data.addr_type;
> > > > -
> > > > -       remote->class = eir_data.class;
> > > > -
> > > > -       remote->name = eir_data.name;
> > > > -       eir_data.name = NULL;
> > > > -
> > > > -       remote->services = eir_data.services;
> > > > -       eir_data.services = NULL;
> > > > -
> > > > -       remote->hash256 = eir_data.hash256;
> > > > -       eir_data.hash256 = NULL;
> > > > +       ad = bt_ad_new_with_data(size, eir);
> > > >
> > > > -       remote->randomizer256 = eir_data.randomizer256;
> > > > -       eir_data.randomizer256 = NULL;
> > > > +       if (ad) {
> > > > +               bt_ad_foreach_data(ad, process_oob_adv, remote);
> > > >
> > > > -       eir_data_free(&eir_data);
> > > > +               bt_ad_unref(ad);
> > > > +       }
> > > >  }
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
