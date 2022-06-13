Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902C7C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 21:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiFMVml (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiFMVmj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 17:42:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871B02AD4
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 14:42:38 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a15so10906015lfb.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 14:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1eejamA9keoec6s/80lqMX8m6igLyc/WBKCrHFnJdxo=;
        b=ZwMGGDx5sbxUgKNl67duU43XP/iw0QUTLRUS8wJtIf5uRZ7mDclozwObeGBb9pmRK9
         Dy3wI+2rcacZgPXbtbCAg4sINrtcV3WAY8doRzpkKRzGiP6ad0iXII9UByScDy1+CWyd
         pKh3sgLyzehl0ixpA0g3F6gai87g4X1vekmpy1j1Ae1w4MTfw5RC/WdF+zFY0Xd65Qkw
         XKm0k77SZTrcoxx0zHPQPlNVgXjpt9WBQeXhBqu6DiuyqGwZqO5uk9UzWySCC/QhvX6v
         +HlbdhLjLGkba7qpJoNaTBjRj+SJTuPshzl8+CQS9e6Php61qfjig/zpntDMdeiDDS1q
         2nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1eejamA9keoec6s/80lqMX8m6igLyc/WBKCrHFnJdxo=;
        b=ZlMIP1HbzAD6taqBtpfi2/MqteV7XUIFeJRxZ7HIS+WCsqsGVyAh86IWxdiuUVIhuK
         Zf56mGlH+EPp8sWbV+DVPmfTb5T44EUhzW+6dyuJ2y6gNMMK8rIWZCenJjgohOhZ/os9
         dKBTljdCqnpOiC9OoSF65cH54BdJvrrs5qdwPcJ2riiYMsmWZvgA0n7Z8k3QjyGrxDjA
         EY9xlnRHSsyBGTq0xMivBRl1K67ZvTpfJ/FhOPMAqREsRchjc0K34Fb+GXPeJUeZfC4a
         42ABDedB2AULJuSi3/zVymFXtAKv1VcSardZVSaNGHtuGjiJC8miKtwHJ0VO92AHMP9m
         VzZA==
X-Gm-Message-State: AJIora9xujRSqHNO4hu1xXd7BI7ew9ZcHPvsGS6c2vKvpTuylzaDnlVS
        mXxQ4kTLFbt1m3haScYGuALUOWM/INOW4GtZTqE6eudm2CE=
X-Google-Smtp-Source: AGRyM1t3UypRRK91MLRLZP9UNk4hJyYwlEUNbMMN2wrz7owxejGx8WIiUGzcJZoV7xagbEjk3x55MyIYb4COEymud+M=
X-Received: by 2002:a05:6512:1155:b0:479:2b1d:5d17 with SMTP id
 m21-20020a056512115500b004792b1d5d17mr1096659lfg.23.1655156556730; Mon, 13
 Jun 2022 14:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220610221124.18591-1-puffy.taco@gmail.com> <20220610221124.18591-2-puffy.taco@gmail.com>
 <CABBYNZKZ6jHeQMO3r_NC1phA03Vg67o9dejKSGpJ1i9LCq_aOQ@mail.gmail.com>
In-Reply-To: <CABBYNZKZ6jHeQMO3r_NC1phA03Vg67o9dejKSGpJ1i9LCq_aOQ@mail.gmail.com>
From:   Mike Brudevold <puffy.taco@gmail.com>
Date:   Mon, 13 Jun 2022 16:42:22 -0500
Message-ID: <CAB7rCTg4+gmzD3emRB6rxfo7RiaJsU+4oBWVQBEut3nr-WqqRA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] eir: parse data types for LE OOB pairing
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Michael Brudevold <michael.brudevold@veranexsolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Sat, Jun 11, 2022 at 3:27 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Michael,
>
> On Fri, Jun 10, 2022 at 3:49 PM Michael Brudevold <puffy.taco@gmail.com> wrote:
> >
> > From: Michael Brudevold <michael.brudevold@veranexsolutions.com>
> >
> > LE support added for P-256 and split out from existing BREDR support for
> > P-192
> >
> > Also attempt to free any existing values before setting new values
> > ---
> >  plugins/neard.c |  8 ++++----
> >  src/eir.c       | 41 +++++++++++++++++++++++++++++++++++------
> >  src/eir.h       | 10 ++++++++--
> >  3 files changed, 47 insertions(+), 12 deletions(-)
> >
> > diff --git a/plugins/neard.c b/plugins/neard.c
> > index 99762482c..11d9e91c4 100644
> > --- a/plugins/neard.c
> > +++ b/plugins/neard.c
> > @@ -352,11 +352,11 @@ static int process_eir(uint8_t *eir, size_t size, struct oob_params *remote)
> >         remote->services = eir_data.services;
> >         eir_data.services = NULL;
> >
> > -       remote->hash = eir_data.hash;
> > -       eir_data.hash = NULL;
> > +       remote->hash = eir_data.hash192;
> > +       eir_data.hash192 = NULL;
> >
> > -       remote->randomizer = eir_data.randomizer;
> > -       eir_data.randomizer = NULL;
> > +       remote->randomizer = eir_data.randomizer192;
> > +       eir_data.randomizer192 = NULL;
> >
> >         eir_data_free(&eir_data);
> >
> > diff --git a/src/eir.c b/src/eir.c
> > index 2f9ee036f..79d423074 100644
> > --- a/src/eir.c
> > +++ b/src/eir.c
> > @@ -53,10 +53,14 @@ void eir_data_free(struct eir_data *eir)
> >         eir->services = NULL;
> >         g_free(eir->name);
> >         eir->name = NULL;
> > -       free(eir->hash);
> > -       eir->hash = NULL;
> > -       free(eir->randomizer);
> > -       eir->randomizer = NULL;
> > +       free(eir->hash192);
> > +       eir->hash192 = NULL;
> > +       free(eir->randomizer192);
> > +       eir->randomizer192 = NULL;
> > +       free(eir->hash256);
> > +       eir->hash256 = NULL;
> > +       free(eir->randomizer256);
> > +       eir->randomizer256 = NULL;
> >         g_slist_free_full(eir->msd_list, g_free);
> >         eir->msd_list = NULL;
> >         g_slist_free_full(eir->sd_list, sd_free);
> > @@ -323,13 +327,15 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
> >                 case EIR_SSP_HASH:
> >                         if (data_len < 16)
> >                                 break;
> > -                       eir->hash = util_memdup(data, 16);
> > +                       free(eir->hash192);
> > +                       eir->hash192 = util_memdup(data, 16);
> >                         break;
> >
> >                 case EIR_SSP_RANDOMIZER:
> >                         if (data_len < 16)
> >                                 break;
> > -                       eir->randomizer = util_memdup(data, 16);
> > +                       free(eir->randomizer192);
> > +                       eir->randomizer192 = util_memdup(data, 16);
> >                         break;
> >
> >                 case EIR_DEVICE_ID:
> > @@ -342,6 +348,15 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
> >                         eir->did_version = data[6] | (data[7] << 8);
> >                         break;
> >
> > +               case EIR_LE_DEVICE_ADDRESS:
> > +                       if (data_len < sizeof(bdaddr_t) + 1)
> > +                               break;
> > +
> > +                       memcpy(&eir->addr, data, sizeof(bdaddr_t));
> > +                       eir->addr_type = data[sizeof(bdaddr_t)] & 0x1 ?
> > +                                       BDADDR_LE_RANDOM : BDADDR_LE_PUBLIC;
> > +                       break;
> > +
> >                 case EIR_SVC_DATA16:
> >                         eir_parse_uuid16_data(eir, data, data_len);
> >                         break;
> > @@ -354,6 +369,20 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
> >                         eir_parse_uuid128_data(eir, data, data_len);
> >                         break;
> >
> > +               case EIR_LE_SC_CONF:
> > +                       if (data_len < 16)
> > +                               break;
> > +                       free(eir->hash256);
> > +                       eir->hash256 = util_memdup(data, 16);
> > +                       break;
> > +
> > +               case EIR_LE_SC_RAND:
> > +                       if (data_len < 16)
> > +                               break;
> > +                       free(eir->randomizer256);
> > +                       eir->randomizer256 = util_memdup(data, 16);
> > +                       break;
> > +
> >                 case EIR_MANUFACTURER_DATA:
> >                         eir_parse_msd(eir, data, data_len);
> >                         break;
> > diff --git a/src/eir.h b/src/eir.h
> > index 6154e23ec..b2cf00f37 100644
> > --- a/src/eir.h
> > +++ b/src/eir.h
> > @@ -33,9 +33,12 @@
> >  #define EIR_PUB_TRGT_ADDR           0x17  /* LE: Public Target Address */
> >  #define EIR_RND_TRGT_ADDR           0x18  /* LE: Random Target Address */
> >  #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
> > +#define EIR_LE_DEVICE_ADDRESS       0x1B  /* LE: Bluetooth Device Address */
> >  #define EIR_SOLICIT32               0x1F  /* LE: Solicit UUIDs, 32-bit */
> >  #define EIR_SVC_DATA32              0x20  /* LE: Service data, 32-bit UUID */
> >  #define EIR_SVC_DATA128             0x21  /* LE: Service data, 128-bit UUID */
> > +#define EIR_LE_SC_CONF              0x22  /* LE: Secure Connections Confirmation Value */
> > +#define EIR_LE_SC_RAND              0x23  /* LE: Secure Connections Random Value */
> >  #define EIR_TRANSPORT_DISCOVERY     0x26  /* Transport Discovery Service */
> >  #define EIR_MANUFACTURER_DATA       0xFF  /* Manufacturer Specific Data */
> >
> > @@ -77,9 +80,12 @@ struct eir_data {
> >         uint16_t appearance;
> >         bool name_complete;
> >         int8_t tx_power;
> > -       uint8_t *hash;
> > -       uint8_t *randomizer;
> > +       uint8_t *hash192;
> > +       uint8_t *randomizer192;
> > +       uint8_t *hash256;
> > +       uint8_t *randomizer256;
> >         bdaddr_t addr;
> > +       uint8_t addr_type;
> >         uint16_t did_vendor;
> >         uint16_t did_product;
> >         uint16_t did_version;
> > --
> > 2.25.1
>
> It might be better to handle this via bt_ad instance instead of
> eir_data, in fact the plan was always to switch to bt_ad but it seems
> we forgot about it at some point.

Are you thinking something like below (doesn't fully compile,
name2utf8 is static in eir so I did nothing about that yet)?
Basically where the ad code parses the EIR data, but the neard plugin
still manages what to do with the data?  The alternative would be
where device.c became smarter to consume the ad struct itself and the
neard plugin becomes a simple conduit for the ad data.

index 77a4630da..3d4064515 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -31,6 +31,7 @@
 #include "src/agent.h"
 #include "src/btd.h"
 #include "src/shared/util.h"
+#include "src/shared/ad.h"

 #define NEARD_NAME "org.neard"
 #define NEARD_PATH "/org/neard"
@@ -336,6 +337,52 @@ static int check_device(struct btd_device *device)
        return 0;
 }

+static void process_oob_adv(void *data, void *user_data)
+{
+       struct bt_ad_data *ad_data = data;
+       struct oob_params *remote = user_data;
+       uint8_t name_len;
+
+       switch (ad_data->type) {
+       case EIR_NAME_SHORT:
+       case EIR_NAME_COMPLETE:
+               name_len = ad_data->len;
+
+               /* Some vendors put a NUL byte terminator into
+                       * the name */
+               while (name_len > 0 && ad_data->data[name_len - 1] == '\0')
+                       name_len--;
+
+               g_free(remote->name);
+
+               remote->name = name2utf8(ad_data->data, name_len);
+               break;
+
+       case BT_AD_LE_DEVICE_ADDRESS:
+               if (ad_data->len < sizeof(bdaddr_t) + 1)
+                       break;
+
+               memcpy(&remote->address, ad_data->data, sizeof(bdaddr_t));
+               remote->address_type = ad_data->data[sizeof(bdaddr_t)] & 0x1 ?
+                               BDADDR_LE_RANDOM : BDADDR_LE_PUBLIC;
+               break;
+
+       case EIR_LE_SC_CONF:
+               if (ad_data->len < 16)
+                       break;
+               free(remote->hash256);
+               remote->hash256 = util_memdup(ad_data->data, 16);
+               break;
+
+       case EIR_LE_SC_RAND:
+               if (ad_data->len < 16)
+                       break;
+               free(remote->randomizer256);
+               remote->randomizer256 = util_memdup(ad_data->data, 16);
+               break;
+       }
+}
+
 static int process_eir(uint8_t *eir, size_t size, struct oob_params *remote)
 {
        struct eir_data eir_data;
@@ -370,32 +417,17 @@ static int process_eir(uint8_t *eir, size_t
size, struct oob_params *remote)

 static void process_eir_le(uint8_t *eir, size_t size, struct
oob_params *remote)
 {
-       struct eir_data eir_data;
+       struct bt_ad *ad;

        DBG("size %zu", size);

-       memset(&eir_data, 0, sizeof(eir_data));
-
-       eir_parse(&eir_data, eir, size);
-
-       bacpy(&remote->address, &eir_data.addr);
-       remote->address_type = eir_data.addr_type;
-
-       remote->class = eir_data.class;
-
-       remote->name = eir_data.name;
-       eir_data.name = NULL;
-
-       remote->services = eir_data.services;
-       eir_data.services = NULL;
-
-       remote->hash256 = eir_data.hash256;
-       eir_data.hash256 = NULL;
+       ad = bt_ad_new_with_data(size, eir);

-       remote->randomizer256 = eir_data.randomizer256;
-       eir_data.randomizer256 = NULL;
+       if (ad) {
+               bt_ad_foreach_data(ad, process_oob_adv, remote);

-       eir_data_free(&eir_data);
+               bt_ad_unref(ad);
+       }
 }
