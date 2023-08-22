Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45C1EE49AB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 20:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjHVUUs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 16:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjHVUUr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 16:20:47 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB2FE50
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 13:20:42 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso48247321fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692735640; x=1693340440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYfZaUOwtSsAoUEBezhshDuxpM4zSXIOgmLhfiwYVLM=;
        b=eP16VOFUkYAwOhf0mUv4xY4ywQDQzASHmngSO+BVsFj7kBTUiqVQv2bk7jS7CVPrSU
         WjizMSiD7CG2Kru6kQYSAHRKE63JCfBM4FiqQ1lG+fPnogZBVDnncyl4O+w0uDQBlu8A
         mGgPSfN29wqctJRaAIavB3UthUIJ1UsdOGkLz0IyNBSFHa7f4wScoa1MtHZTYkQDN+9F
         B5zETQq0Uqn7IP17yGhE9PwgvywSIr6TZZjSA+s1/OT0WUOo4WhEK4ZznW8NYhtNKCeX
         K8qZUzzHRe5n1j/CglnUbavOOYLKajp722SNS50UkClaQS8u5s/XiIwx4nxCkEnwnTGu
         bK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692735640; x=1693340440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYfZaUOwtSsAoUEBezhshDuxpM4zSXIOgmLhfiwYVLM=;
        b=hmXabzp61p1W5Kln/slLpI63/019PiNYv7aI0RRNnaA6vP+iUm7g9+sa+86EjsULG0
         q7yJ1liWyqNYDm81HPanGAEYbVmK6ZB1EN8JLre7bHdDU3sv8ifd8v6jU/4M84Q/hUDS
         4HrHOPjIvD/3kV9HriUMKgJhKTiXdmqA2JI+7fXGTxszn9snPfjdceCPUCMw9LvzyhH1
         oxaNXyKtPfqcvPrFv5S4VaGJbZP7EWwTaraCHnSKaK97/+eOR7CoVDBIPld3MA82t+7M
         TCzhVPlFM97xwTOt96CLnSWUm8baqBEpuV3KPEAY9vXuiVqKJdd9IROfjl0cBnDHXo0Z
         4kPg==
X-Gm-Message-State: AOJu0YyIXf2V7uRi0vmCpUfUJTrvpMp/ZdnmEokbOIptFj66TOfmDsqr
        5HWXbP8595LFE9jdLPzu01VcRMUxW2QPrDwLwGM=
X-Google-Smtp-Source: AGHT+IFtHitMWavhDaA+0N/J6QfBkANwzabbflosrqRaJvYrKAUHd/kTsW76vWz49EHKMB/3XXLLZyk8T4sUUJlE03k=
X-Received: by 2002:a05:651c:224:b0:2bc:d7d6:258f with SMTP id
 z4-20020a05651c022400b002bcd7d6258fmr948754ljn.35.1692735640245; Tue, 22 Aug
 2023 13:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230822191444.3741307-1-luiz.dentz@gmail.com> <fe9b42b3-6a9d-41dc-9532-5f7358c422ed@molgen.mpg.de>
In-Reply-To: <fe9b42b3-6a9d-41dc-9532-5f7358c422ed@molgen.mpg.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 22 Aug 2023 13:20:28 -0700
Message-ID: <CABBYNZ+2yrD3R+x2GeCdG+J25KkWoQX_FJuPNLMm9Fr7Tvab1A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Bruno Pitrus <brunopitrus@hotmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Paul,

On Tue, Aug 22, 2023 at 1:01=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> [CC: +Bruno]
>
> Dear Luiz,
>
>
> Thank you for the patch.
>
> Am 22.08.23 um 21:14 schrieb Luiz Augusto von Dentz:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This introduces HCI_QUIRK_BROKEN_LE_CODED is is used to indicate that
>
> =E2=80=A6. It is used =E2=80=A6
>
> > LE Coded PHY shall not be used, it is then set for some Intel models
> > that claims to support it but when used causes many problems.
>
> that claim to =E2=80=A6
>
> > Link: https://github.com/bluez/bluez/issues/577
> > Link: https://github.com/bluez/bluez/issues/582
> > Link: https://lore.kernel.org/linux-bluetooth/CABBYNZKco-v7wkjHHexxQbgw=
wSz-S=3DGZ=3DdZKbRE1qxT1h4fFbQ@mail.gmail.com/T/#
> > Fixes: 288c90224eec ("Bluetooth: Enable all supported LE PHY by default=
")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >   drivers/bluetooth/btintel.c      |  2 ++
> >   include/net/bluetooth/hci.h      | 10 ++++++++++
> >   include/net/bluetooth/hci_core.h |  4 +++-
> >   3 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index 9b239ce96fa4..3ed60b2b0340 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -2776,6 +2776,8 @@ static int btintel_setup_combined(struct hci_dev =
*hdev)
> >               case 0x11:      /* JfP */
> >               case 0x12:      /* ThP */
> >               case 0x13:      /* HrP */
> > +                     set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks)=
;
> > +                     fallthrough;
> >               case 0x14:      /* CcP */
> >                       set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks)=
;
> >                       fallthrough;
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index c58425d4c592..767921d7f5c1 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -319,6 +319,16 @@ enum {
> >        * This quirk must be set before hci_register_dev is called.
> >        */
> >       HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER,
> > +
> > +     /*
> > +      * When this quirk is set, LE Coded PHY is shall not be used. Thi=
s is
>
> s/is shall/shall/
>
> > +      * required for some Intel controllers which erroneously claim to
> > +      * support it but it causes problems with extended scanning.
> > +      *
> > +      * This quirk can be set before hci_register_dev is called or
> > +      * during the hdev->setup vendor callback.
> > +      */
> > +     HCI_QUIRK_BROKEN_LE_CODED,
> >   };
> >
> >   /* HCI device flags */
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 6e2988b11f99..e6359f7346f1 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1817,7 +1817,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
> >   #define scan_2m(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_2M) || =
\
> >                     ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_2M))
> >
> > -#define le_coded_capable(dev) (((dev)->le_features[1] & HCI_LE_PHY_COD=
ED))
> > +#define le_coded_capable(dev) (((dev)->le_features[1] & HCI_LE_PHY_COD=
ED) && \
> > +                            !test_bit(HCI_QUIRK_BROKEN_LE_CODED, \
> > +                                      &(dev)->quirks))
> >
> >   #define scan_coded(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_CODE=
D) || \
> >                        ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))
>
> Will this be future proof, once firmware for the broken controllers are
> fixed?

Yes, it won't cause any regressions if the firmware is fixed in the
future, but LE coded PHY will need to be re-enabled by removing the
quirks, this is why we say it is broken but we can't depend on runtime
detection and should probably print a warning until we have a proper
fix for it lands at the firmware side. We could in theory set
HCI_QUIRK_BROKEN_LE_CODED based on the firmware version but firmware
versioning schemes tend to change so I'm afraid that could also cause
regression like this in the future.

>
> Kind regards,
>
> Paul



--=20
Luiz Augusto von Dentz
