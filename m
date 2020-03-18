Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8BFC5ACD6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 10:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE81E20768
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 10:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku5hptqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCRKra (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:47:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35984 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRKra (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 06:47:30 -0400
Received: by mail-io1-f67.google.com with SMTP id d15so24406507iog.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2020 03:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bXQ7MMTikT+H0Zq0NN2bwxYO/PrjoWtdk12rOmFio34=;
        b=Ku5hptqpUlnJ/6IDhwO6bHI/iZeL2Kg2e+DNG2M3Smzf5yLC5MChYKqCVaBXXFJ26F
         dzQ45iwQBp7Bq16vUW0iyuXzH+4vlA9PEth3mkziCoZhW13xJVXyI9dxNJ9ZW54ZBIBb
         jMYjMbMJoinEdU/awkdsn9PpGbDlsPDSk5kwiBprbi+569rjVPMcOnwE7cxdENwCEuI6
         AefqLH50DEjU0/fzO98BuHF6/hoZJ9TytHejvUCxtgeE3lSN2ime2jl0zwJZ8/rTHfa9
         0T562uZo4JUvNoWoe/bnjkGOCqGRQF/CMjKnFKjI5obdNYOG+569mIKOMqfwHbu7zOnX
         9D7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bXQ7MMTikT+H0Zq0NN2bwxYO/PrjoWtdk12rOmFio34=;
        b=b24ZHaAdxeBX/yICMfp6zc36voHKNUwX2ArCgnOTIvBvwnXtxV4Pu3rVSUPARQyBuB
         LsqEMBnzkPil9Y+KCCrV8yRfyesPjp/1qS/tuPMYDWdBbd8EZ4gy3JQp9FWLpFaf7G//
         NzefeV9PQmqoWuyTcSh7pF8zZk98eHJwtVgJA2ZhlZwLfYxkF1tVlSzcAqA/A5HvMBLU
         mp0EQNAl7vDhKPH5hcP+P8Bs80z+cm0LcF84THr3f7mzt8Hc4SLXk5Eb3w7mKjX+ye+U
         RL1QolOb4ZRcvq7aGl+DILXDs/Ffmr1SdUkplbWkR/7WUfwpogfcPZaVKLlrDUk03Irl
         Shdw==
X-Gm-Message-State: ANhLgQ2nF3dwawib/tEx/hGnWrmmTHNk42BBtcQLILN9vx1L9CE0+ycK
        QnTpviPJem1Ajisx88Nph1lzFBLbhLYHSPesUbo=
X-Google-Smtp-Source: ADFU+vuUHF4RaF3qDM4v8kOqqgd2a+x6F5ILGqyIx/7oYqVcm0lElsK/KT137oFMhvzQNBt+0XK9HOgAaaFju5fydzM=
X-Received: by 2002:a05:6638:3dd:: with SMTP id r29mr3585840jaq.94.1584528449212;
 Wed, 18 Mar 2020 03:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200312100754.3445-1-sathish.narasimman@intel.com>
 <20200312100754.3445-2-sathish.narasimman@intel.com> <AD87C0E6-8A18-4016-9A4C-CE2934B6F862@holtmann.org>
In-Reply-To: <AD87C0E6-8A18-4016-9A4C-CE2934B6F862@holtmann.org>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Wed, 18 Mar 2020 16:17:17 +0530
Message-ID: <CAOVXEJL7wqq4CBszn697sD1_fi7Em7QANGHkxa1QE5ZE2S4cnQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] Bluetooth: LL Privacy Delete Store Resolving list
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

On Wed, Mar 18, 2020 at 4:12 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Sathish,
>
> > This patch help to delte the resolving list stored in the BT
> > Controller w.r.t BD_ADDR.
> >
> > Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
> > ---
> > include/net/bluetooth/hci.h      |  1 +
> > include/net/bluetooth/hci_core.h |  2 ++
> > net/bluetooth/hci_request.c      | 33 ++++++++++++++++++++++++++++++++
> > 3 files changed, 36 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 5f60e135aeb6..352bc43940ff 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -457,6 +457,7 @@ enum {
> > #define HCI_LE_DATA_LEN_EXT           0x20
> > #define HCI_LE_PHY_2M                 0x01
> > #define HCI_LE_PHY_CODED              0x08
> > +#define HCI_LE_LL_PRIVACY            0x40
> > #define HCI_LE_EXT_ADV                        0x10
> > #define HCI_LE_EXT_SCAN_POLICY                0x80
> > #define HCI_LE_PHY_2M                 0x01
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index d4e28773d378..5f04ef88da35 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1657,6 +1657,8 @@ void hci_le_start_enc(struct hci_conn *conn, __le=
16 ediv, __le64 rand,
> >
> > void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
> >                              u8 *bdaddr_type);
> > +void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_typ=
e,
> > +                                  bdaddr_t *bdaddr);
> >
> > #define SCO_AIRMODE_MASK       0x0003
> > #define SCO_AIRMODE_CVSD       0x0000
> > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> > index bf83179ab9d1..f4bbd3b79210 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -885,6 +885,39 @@ static void hci_req_start_scan(struct hci_request =
*req, u8 type, u16 interval,
> >       }
> > }
> >
> > +void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_typ=
e, bdaddr_t *bdaddr)
> > +{
> > +     struct hci_cp_le_del_from_resolv_list cp;
> > +     struct hci_request req;
> > +     struct bdaddr_list_with_irk *irk;
> > +
> > +     BT_DBG("");
> > +
> > +     /* Nothing to be done if LL privacy is not supported */
> > +     if ( !(hdev->le_features[0] & HCI_LE_LL_PRIVACY) )
> > +             return;
> > +
> > +     if ( !hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) &&
> > +         ( hci_dev_test_flag(hdev, HCI_LE_ADV) ||
> > +           hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
> > +           hci_lookup_le_connect(hdev) ) )
> > +             return;
>
> please don=E2=80=99t invent your own coding style. Follow the netdev conv=
ention.

Sure will correct the coding style in next version of the patch
>
> Regards
>
> Marcel
>
