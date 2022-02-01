Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F39C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Feb 2022 18:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbiBAShB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Feb 2022 13:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241919AbiBAShA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Feb 2022 13:37:00 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2765DC06173B
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Feb 2022 10:37:00 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l25so33649790wrb.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Feb 2022 10:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DI1x5+Wihj4SQ70P5LSVw+8H1DmmobNWAEhS7drOCTA=;
        b=FODfQEB3+VrZ5tKcYc+CWcrD2hHYrFmADtl0dJMx5xXMl9RKo6eBF3lT/Sow792Z+Q
         f8ZlSAACHtERHUoXHY1d2ecJjnB8wS/Q87qex3WylrZWuf1L4j5yHLHcNxaZVAyB4VVm
         P6FiTB21uMDQPGS7O92SNJ6SXBTeFUVskTYpP0zcPV0blQxwnVptj7/dNOH+EaoFnNyr
         79N8tEK+nSLcBIrjROxswMd5MknwJm5re8cehiZwo0Cio2Ty4Q3RhaQEMfGuLH5IXJQ/
         riAlhibal7ZCvPd9Yc+vYrN969ElkfpTQPUZNpDBsSUk+pVx4QIFxvJsMjxH9C2pVKn5
         FY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DI1x5+Wihj4SQ70P5LSVw+8H1DmmobNWAEhS7drOCTA=;
        b=EQFsnrVfs6a+t7ODUseBav5qFchNkdE3S61951C2dYaD6bSBGGRXDkhXqmX3Ib4Hb2
         Ldjl2h83jKUsBItQF1Noen/PJRb9NhH1yeShNWJRcmM+f/ONPZ9m0KtQPgL4p7XsRgKN
         10MyGQKERLA/mUICxbEdTF46pgAeXlIMfp3R29JRQMTgoKNWyHtBFXQKZrmKyIdb5UcW
         EUDJoYFxZVo0L4JEOuRlLR/en2c837d1wLb/uErHCNYPCgJXtFRj44GY1s6+cUzlsFIr
         rWKbqkfIVd5H2Wxs3q8zZf7TfWNQk5XQez4vRqKz9OpoQZ1AwdH+NlgY/Lek9yvBefHL
         pA/A==
X-Gm-Message-State: AOAM530XXF5onASNLK2N9+LPEkBD6HrZIgey12ZZZ8gJJqnzX4fgvybR
        8S081MavO4Od60YeiHavODZMd2Lj62cSjMj2XyJgZA==
X-Google-Smtp-Source: ABdhPJykR69e7xynNf/2GwFt8xXKISZXw11Lu8sKsZOzgS4SZNut8V2WY0EwKSIQS5tWWaFjpg+UUAKzXkbQfOnBvCs=
X-Received: by 2002:adf:f1c7:: with SMTP id z7mr13384515wro.198.1643740618703;
 Tue, 01 Feb 2022 10:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20220113150846.1570738-1-rad@semihalf.ocm> <CABBYNZJn1ej18ERtgnF_wvbvBEm0N=cBRHHtr8bu+nfAotjg2Q@mail.gmail.com>
 <CAOs-w0+W_BHTdZkOnu-EPme2dpoO_6bQi_2LRH7Xw0Ge=i9TOA@mail.gmail.com>
 <CABBYNZLinzOxJWgHwVbeEWe2zkz_y4BrXVYX4e0op580YO1OeA@mail.gmail.com> <CABBYNZL3ozczAK2mWXVd+x2NtZhaAbfnUFoA3ot1AQLNHSeL5w@mail.gmail.com>
In-Reply-To: <CABBYNZL3ozczAK2mWXVd+x2NtZhaAbfnUFoA3ot1AQLNHSeL5w@mail.gmail.com>
From:   =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>
Date:   Tue, 1 Feb 2022 19:36:50 +0100
Message-ID: <CAOs-w0+T1Dcwsx-dy28v_6RxyQZidFoxOBts4++j8h5N5sY6mA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix skb allocation in mgmt_remote_name()
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        upstream@semihalf.com, Angela Czubak <acz@semihalf.com>,
        Marek Maslanka <mm@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hey Luiz.
Sorry for keeping you waiting. I will send it today.

pon., 31 sty 2022 o 19:47 Luiz Augusto von Dentz
<luiz.dentz@gmail.com> napisa=C5=82(a):
>
> Hi Rados=C5=82aw,
>
> On Thu, Jan 13, 2022 at 2:23 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Rados=C5=82aw,
> >
> > On Thu, Jan 13, 2022 at 2:07 PM Rados=C5=82aw Biernacki <rad@semihalf.c=
om> wrote:
> > >
> > > Hi Luiz,
> > >
> > > czw., 13 sty 2022 o 17:17 Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> napisa=C5=82(a):
> > > >
> > > > Hi Radoslaw,
> > > >
> > > > On Thu, Jan 13, 2022 at 7:09 AM Radoslaw Biernacki <rad@semihalf.co=
m> wrote:
> > > > >
> > > > > From: Radoslaw Biernacki <rad@semihalf.com>
> > > > >
> > > > > This patch fixes skb allocation, as lack of space for ev might pu=
sh skb
> > > > > tail beyond its end.
> > > > > Also introduce eir_precalc_len() that can be used instead of magi=
c
> > > > > numbers for similar eir operations on skb.
> > > > >
> > > > > Fixes: cf1bce1de7eeb ("Bluetooth: mgmt: Make use of mgmt_send_eve=
nt_skb in MGMT_EV_DEVICE_FOUND")
> > > > > Signed-off-by: Angela Czubak <acz@semihalf.com>
> > > > > Signed-off-by: Marek Maslanka <mm@semihalf.com>
> > > > > Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
> > > > > ---
> > > > >  net/bluetooth/eir.h  |  5 +++++
> > > > >  net/bluetooth/mgmt.c | 12 ++++--------
> > > > >  2 files changed, 9 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/net/bluetooth/eir.h b/net/bluetooth/eir.h
> > > > > index 05e2e917fc25..e5876751f07e 100644
> > > > > --- a/net/bluetooth/eir.h
> > > > > +++ b/net/bluetooth/eir.h
> > > > > @@ -15,6 +15,11 @@ u8 eir_create_scan_rsp(struct hci_dev *hdev, u=
8 instance, u8 *ptr);
> > > > >  u8 eir_append_local_name(struct hci_dev *hdev, u8 *eir, u8 ad_le=
n);
> > > > >  u8 eir_append_appearance(struct hci_dev *hdev, u8 *ptr, u8 ad_le=
n);
> > > > >
> > > > > +static inline u16 eir_precalc_len(u8 data_len)
> > > > > +{
> > > > > +       return sizeof(u8) * 2 + data_len;
> > > > > +}
> > > > > +
> > > > >  static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type,
> > > > >                                   u8 *data, u8 data_len)
> > > > >  {
> > > > > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > > > > index 37087cf7dc5a..d517fd847730 100644
> > > > > --- a/net/bluetooth/mgmt.c
> > > > > +++ b/net/bluetooth/mgmt.c
> > > > > @@ -9680,13 +9680,11 @@ void mgmt_remote_name(struct hci_dev *hde=
v, bdaddr_t *bdaddr, u8 link_type,
> > > > >  {
> > > > >         struct sk_buff *skb;
> > > > >         struct mgmt_ev_device_found *ev;
> > > > > -       u16 eir_len;
> > > > > -       u32 flags;
> > > > > +       u16 eir_len =3D 0;
> > > > > +       u32 flags =3D 0;
> > > > >
> > > > > -       if (name_len)
> > > > > -               skb =3D mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_FOUND=
, 2 + name_len);
> > > > > -       else
> > > > > -               skb =3D mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_FOUND=
, 0);
> > > > > +       skb =3D mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_FOUND,
> > > > > +                            sizeof(*ev) + (name ? eir_precalc_le=
n(name_len) : 0));
> > > >
> > > > Looks like mgmt_device_connected also has a similar problem.
> > >
> > > Yes, I was planning to send a patch to this one though it will not be=
 as slick.
> > > It would be nice to have a helper which will call skb_put() and add
> > > eir data at once.
> > > Basically skb operation in pair to, what eir_append_data() does with
> > > help of eir_len but without awkwardness when passing return value to
> > > skb_put() (as it returns offset not size).
> >
> > Hmm, that might be a good idea indeed something like eir_append_skb,
> > if only we could grow the skb with skb_put directly that would
> > eliminate the problem with having to reserve enough space for the
> > worse case.
> >
> > > I will send V2 with two patches. I hope they will align with your
> > > original goal of eliminating the necessity of intermediary buffers at
> > > some point in future.
>
> Are you still planning to send the v2?
>
> > > >
> > > > >         ev =3D skb_put(skb, sizeof(*ev));
> > > > >         bacpy(&ev->addr.bdaddr, bdaddr);
> > > > > @@ -9696,10 +9694,8 @@ void mgmt_remote_name(struct hci_dev *hdev=
, bdaddr_t *bdaddr, u8 link_type,
> > > > >         if (name) {
> > > > >                 eir_len =3D eir_append_data(ev->eir, 0, EIR_NAME_=
COMPLETE, name,
> > > > >                                           name_len);
> > > > > -               flags =3D 0;
> > > > >                 skb_put(skb, eir_len);
> > > > >         } else {
> > > > > -               eir_len =3D 0;
> > > > >                 flags =3D MGMT_DEV_FOUND_NAME_REQUEST_FAILED;
> > > > >         }
> > > >
> > > > These changes would leave flags and eir_len uninitialized.
> > >
> > > Both are initialized to 0 by this patch.
> >
> > Sorry, I must be blind that I didn't see you had changed that to be
> > initialized in their declaration.
> >
> > > >
> > > > > --
> > > > > 2.34.1.703.g22d0c6ccf7-goog
> > > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
