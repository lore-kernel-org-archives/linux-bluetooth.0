Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE98EE4993
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 16:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbjHWQfp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 12:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjHWQfo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 12:35:44 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCAC11F
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 09:35:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-500760b296aso34026e87.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 09:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692808540; x=1693413340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcOGsSFzwOexHGZXlu9fcu+jFAU5soP6hYoX4xjCi8g=;
        b=mPimZSy82wJDoDDEsyGNyO3Q7sCW9OlCiWg+zUY+62C4K1SmnrVS5lqTziF1mfU1S0
         u4FzGPqGqT98CYLasp8KcLsTNqMSdoJT92mpc81TXsVltqJu+rKkr1vGZKCU45WftvyF
         jmRMb9eawlVQp2gjThjrQE9lXE7eY/t/P6TJcPP7Pkqt/h3s3J/kpc19/e2+jy8sy4zN
         3u7kf6NSGjGojcURUtkQkMw+pbgS/g6t4yi+XC13IQZMOyxezsiuOQCUlLju0v6h/WgH
         1TAOXl7W6KW9J45yXQs98+zUq2ofk5oldZxcaKZJx610I0MH6eO21AHm3aJo61mnysZo
         lQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692808540; x=1693413340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcOGsSFzwOexHGZXlu9fcu+jFAU5soP6hYoX4xjCi8g=;
        b=TdEZynfO+gYbVqznJMNnxU6VSDl/G32cLicN+vHb5N4+9zr+kvc8eBQl5d9A0Un1ZY
         cVb+Ab1eOlFs3TItjZtPDa8l5lwjfEO9EmtsiRnCxwiGIcEqAuSrmjFEnOxmsn/+v2eA
         x7I2pGOkMayYgMeFu2mZejPKESP7K8FqQcoNdissn+N1yF1EZfp8Br/lGhtvOadxQudZ
         tKwJjp7KXvLp1ef0F71P+x6Ur6KjsGcKsVzFp704NVdiySv0deva/luOz80+oLwFKPPb
         GSSKZQGI5sDa7M9aZ7FDK4iJriwze3kMRmzadusyKbRMGA0D2e342MvTfblmb7IVSxby
         7gvQ==
X-Gm-Message-State: AOJu0YwHw4Kx47dhCTJuVmxRC7lEBOJNe/n/6QwnGiOcDCHFyWABGakJ
        J/2Y/Odj6Zke/iTrpIUXR5/NQ1SkaoR5in13knk=
X-Google-Smtp-Source: AGHT+IGHkFF6qeNS25UVkQfsz0VlNEj++XGUb+tYE2tHcQ4YPMyTj4+bCvcQ6+hy49VFK8ZuM65nvDFL44Mw0J97VhY=
X-Received: by 2002:a05:6512:ba7:b0:500:8676:aa7f with SMTP id
 b39-20020a0565120ba700b005008676aa7fmr3071698lfv.23.1692808539677; Wed, 23
 Aug 2023 09:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230822191444.3741307-1-luiz.dentz@gmail.com>
 <CABBYNZ+2yrD3R+x2GeCdG+J25KkWoQX_FJuPNLMm9Fr7Tvab1A@mail.gmail.com>
 <8c395313-5e2d-4c27-969c-019eabacd6cf@molgen.mpg.de> <5704690.DvuYhMxLoT@bruno-beit>
In-Reply-To: <5704690.DvuYhMxLoT@bruno-beit>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 23 Aug 2023 09:35:27 -0700
Message-ID: <CABBYNZ+6pRytUHfi68h4Q=A9urNR=JtuJ0mzG+615q0Lyyeg+w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
To:     Bruno Pitrus <brunopitrus@hotmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bruno,

On Wed, Aug 23, 2023 at 2:21=E2=80=AFAM Bruno Pitrus <brunopitrus@hotmail.c=
om> wrote:
>
> Dnia =C5=9Broda, 23 sierpnia 2023 10:26:31 CEST Paul Menzel pisze:
> > Dear Luiz,
> >
> >
> > Thank you for your answer.
> >
> > Am 22.08.23 um 22:20 schrieb Luiz Augusto von Dentz:
> > > Hi Paul,
> > >
> > > On Tue, Aug 22, 2023 at 1:01=E2=80=AFPM Paul Menzel <pmenzel@molgen.m=
pg.de> wrote:
> > >>
> > >> [CC: +Bruno]
> > >>
> > >> Dear Luiz,
> > >>
> > >>
> > >> Thank you for the patch.
> > >>
> > >> Am 22.08.23 um 21:14 schrieb Luiz Augusto von Dentz:
> > >>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >>>
> > >>> This introduces HCI_QUIRK_BROKEN_LE_CODED is is used to indicate th=
at
> > >>
> > >> =E2=80=A6. It is used =E2=80=A6
> > >>
> > >>> LE Coded PHY shall not be used, it is then set for some Intel model=
s
> > >>> that claims to support it but when used causes many problems.
> > >>
> > >> that claim to =E2=80=A6
> > >>
> > >>> Link: https://github.com/bluez/bluez/issues/577
> > >>> Link: https://github.com/bluez/bluez/issues/582
> > >>> Link: https://lore.kernel.org/linux-bluetooth/CABBYNZKco-v7wkjHHexx=
QbgwwSz-S=3DGZ=3DdZKbRE1qxT1h4fFbQ@mail.gmail.com/T/#
> > >>> Fixes: 288c90224eec ("Bluetooth: Enable all supported LE PHY by def=
ault")
> > >>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >>> ---
> > >>>    drivers/bluetooth/btintel.c      |  2 ++
> > >>>    include/net/bluetooth/hci.h      | 10 ++++++++++
> > >>>    include/net/bluetooth/hci_core.h |  4 +++-
> > >>>    3 files changed, 15 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btinte=
l.c
> > >>> index 9b239ce96fa4..3ed60b2b0340 100644
> > >>> --- a/drivers/bluetooth/btintel.c
> > >>> +++ b/drivers/bluetooth/btintel.c
> > >>> @@ -2776,6 +2776,8 @@ static int btintel_setup_combined(struct hci_=
dev *hdev)
> > >>>                case 0x11:      /* JfP */
> > >>>                case 0x12:      /* ThP */
> > >>>                case 0x13:      /* HrP */
> > >>> +                     set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->qui=
rks);
> > >>> +                     fallthrough;
> > >>>                case 0x14:      /* CcP */
> > >>>                        set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->qu=
irks);
> > >>>                        fallthrough;
> > >>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hc=
i.h
> > >>> index c58425d4c592..767921d7f5c1 100644
> > >>> --- a/include/net/bluetooth/hci.h
> > >>> +++ b/include/net/bluetooth/hci.h
> > >>> @@ -319,6 +319,16 @@ enum {
> > >>>         * This quirk must be set before hci_register_dev is called.
> > >>>         */
> > >>>        HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER,
> > >>> +
> > >>> +     /*
> > >>> +      * When this quirk is set, LE Coded PHY is shall not be used.=
 This is
> > >>
> > >> s/is shall/shall/
> > >>
> > >>> +      * required for some Intel controllers which erroneously clai=
m to
> > >>> +      * support it but it causes problems with extended scanning.
> > >>> +      *
> > >>> +      * This quirk can be set before hci_register_dev is called or
> > >>> +      * during the hdev->setup vendor callback.
> > >>> +      */
> > >>> +     HCI_QUIRK_BROKEN_LE_CODED,
> > >>>    };
> > >>>
> > >>>    /* HCI device flags */
> > >>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetoo=
th/hci_core.h
> > >>> index 6e2988b11f99..e6359f7346f1 100644
> > >>> --- a/include/net/bluetooth/hci_core.h
> > >>> +++ b/include/net/bluetooth/hci_core.h
> > >>> @@ -1817,7 +1817,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn=
);
> > >>>    #define scan_2m(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_2M=
) || \
> > >>>                      ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_2M))
> > >>>
> > >>> -#define le_coded_capable(dev) (((dev)->le_features[1] & HCI_LE_PHY=
_CODED))
> > >>> +#define le_coded_capable(dev) (((dev)->le_features[1] & HCI_LE_PHY=
_CODED) && \
> > >>> +                            !test_bit(HCI_QUIRK_BROKEN_LE_CODED, \
> > >>> +                                      &(dev)->quirks))
> > >>>
> > >>>    #define scan_coded(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY=
_CODED) || \
> > >>>                         ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_COD=
ED))
> > >>
> > >> Will this be future proof, once firmware for the broken controllers =
are
> > >> fixed?
> > >
> > > Yes, it won't cause any regressions if the firmware is fixed in the
> > > future, but LE coded PHY will need to be re-enabled by removing the
> > > quirks, this is why we say it is broken but we can't depend on runtim=
e
> > > detection and should probably print a warning until we have a proper
> > > fix for it lands at the firmware side. We could in theory set
> > > HCI_QUIRK_BROKEN_LE_CODED based on the firmware version but firmware
> > > versioning schemes tend to change so I'm afraid that could also cause
> > > regression like this in the future.
> >
> > Understood. Maybe you could add the known broken firmware versions to
> > the commit message for posterity though.
> >
> >
> > Kind regards,
> >
> > Paul
> >
> Thanks,
> This patch partly works for me. The mouse now takes several dozen seconds=
 to detect where the computer did not find it at all before.
> But note that in kernel 6.3.x it was always detected immediately.

What version did you try, v2 didn't have any effect for me, only v3
worked which had the same behavior of AX210 so it discovered it quite
quickly.

--=20
Luiz Augusto von Dentz
