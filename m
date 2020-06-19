Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E34C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 20:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13C420B80
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 20:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NaVeHMAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389872AbgFSU67 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392002AbgFSU6B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 16:58:01 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6E1C06174E
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 13:58:01 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i8so6336316lfo.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 13:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pi9mUfjZECkUpQIGYMQo/6NQ4L6ym2cDBq1A7qT/6+c=;
        b=NaVeHMAhn1KzZRQfD+wOu8UDQc2/X47vPbkvAkuoM9QmnXCM2STUL3kkpHYcBlSANj
         Va8BJRJqYIB5AwD6NUyGwEAGz69yx1wwRwdlt07r/17YRmZSGTZpbQByKs4ueh7Gn3oL
         yPanYqZIpO/bR8ELl7Y9vmcMru6ECFmmliPDudiaL4nki3jY5NDuCkfRWWDVZX6zD84k
         kIpVttarjUqKnh06uhVAyiclsIOT9FcNGaSxltUUJoXwvZwSLKNBfUOs6zRbtLtQow6s
         imD//ySH407H4QXsosemfugBvrTJsz2kTDw4VwL1Q873+Fr98PcjB6wCf+mdPYoMuMUZ
         NFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pi9mUfjZECkUpQIGYMQo/6NQ4L6ym2cDBq1A7qT/6+c=;
        b=XDB5WYwLPHpb2PQhL6QJaume4kInTR4W6LjOBcC+Q55WVHCLTbMy6rKnvnd9XO+/1r
         t2VAxI1tdaANVrDNHgWLekUtdqP14FaN39nZ9oKP8LOHXptsGNiya2Ryle3I22ya58Yg
         4ARq1igH1vXff4zBFL56Coe15MYXeTGJUBvVGhnw6HOLLI+pTBUMAby9HNz9QucQN0yt
         kl39VgIsySAPyGfl0USEBQ6n0dBD+hy0PER0D31PAsCeZugXCubSW3m2X4JZTvuK0vYo
         jjg6exdRkSqigmQfn1kDvoexvi8qXrrCuLzQrh2CCRpfUWQD2U9LChSEZNouTK3ECFz9
         gTrw==
X-Gm-Message-State: AOAM530WRGyRFbNaBBcNseZmCGdMWpMaQ6C5vPNlEmQ4SfMSi6a50F8x
        OTIoCCpqdw1wiMbCy7oVTuOQ0d/3CvhdoEpWE1fiaQ==
X-Google-Smtp-Source: ABdhPJzWRQb0DsakSDqowMcTjwuIImb5KfqC6r9nHtFbFUraZKrOL5bJiC/80XJraXTmc9DwlUHkAHPQQAjJdaLpaV4=
X-Received: by 2002:a19:701:: with SMTP id 1mr2890270lfh.138.1592600278354;
 Fri, 19 Jun 2020 13:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200618210659.142284-1-alainm@chromium.org> <C5D30F5E-B50F-4DE7-A909-F48F6C555661@holtmann.org>
 <CALWDO_XLRELJhe1n9AVq2w9fQYkgGLC+bdXQ-1-M4f-cUfEwGQ@mail.gmail.com> <CABBYNZLEsUXFW_hrmcvSALRpeZwkmvk=c9SYPt+owO7tn+hMBw@mail.gmail.com>
In-Reply-To: <CABBYNZLEsUXFW_hrmcvSALRpeZwkmvk=c9SYPt+owO7tn+hMBw@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 19 Jun 2020 16:57:47 -0400
Message-ID: <CALWDO_V2Hnc-HHYQQ5LfnW8a2FWzkTBOE1Cti0ZQzyw4CouAgw@mail.gmail.com>
Subject: Re: [PATCH v1] bluetooth: use configured params for ext adv
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Fri, Jun 19, 2020 at 2:42 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alain, Marcel,
>
> On Fri, Jun 19, 2020 at 6:54 AM Alain Michaud <alainmichaud@google.com> w=
rote:
> >
> > Hi Marcel,
> >
> > On Fri, Jun 19, 2020 at 3:46 AM Marcel Holtmann <marcel@holtmann.org> w=
rote:
> > >
> > > Hi Alain,
> > >
> > > please use =E2=80=9CBluetooth: =E2=80=9C prefix for the subject.
> >
> > ack.
> > >
> > >
> > > > When the extended advertisement feature is enabled, a hardcoded min=
 and
> > > > max interval of 0x8000 is used.  This patches fixes this issue by u=
sing
> > > > the configured min/max value.
> > > >
> > > > This was validated by setting min/max in main.conf and making sure =
the
> > > > right setting is applied:
> > > >
> > > > < HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036)=
 plen
> > > > 25                                          #93 [hci0] 10.953011
> > > > =E2=80=A6
> > > > Min advertising interval: 181.250 msec (0x0122)
> > > > Max advertising interval: 181.250 msec (0x0122)
> > > > =E2=80=A6
> > > >
> > > > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > > Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> > > >
> > > > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > >
> > > The Reviewed-by lines go after your Signed-off-by.
> >
> > ack.
> > >
> > >
> > > > ---
> > > >
> > > > net/bluetooth/hci_request.c | 10 ++++++----
> > > > 1 file changed, 6 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_reques=
t.c
> > > > index 29decd7e8051..08818b9bf89f 100644
> > > > --- a/net/bluetooth/hci_request.c
> > > > +++ b/net/bluetooth/hci_request.c
> > > > @@ -1799,8 +1799,9 @@ int __hci_req_setup_ext_adv_instance(struct h=
ci_request *req, u8 instance)
> > > >       int err;
> > > >       struct adv_info *adv_instance;
> > > >       bool secondary_adv;
> > > > -     /* In ext adv set param interval is 3 octets */
> > > > -     const u8 adv_interval[3] =3D { 0x00, 0x08, 0x00 };
> > > > +     /* In ext adv set param interval is 3 octets in le format */
> > > > +     const __le32 min_adv_interval =3D cpu_to_le32(hdev->le_adv_mi=
n_interval);
> > > > +     const __le32 max_adv_interval =3D cpu_to_le32(hdev->le_adv_ma=
x_interval);
> > >
> > > Scrap the const here.
> >
> > I'd like to understand why it isn't prefered to use const when you
> > don't intend to modify it in the code.
> > >
> > >
> > > And it is wrong since your hdev->le_adv_{min,max}_interval is actuall=
y __u16. So that first needs to be extended to a __u16 value.
> >
> > The macro actually leads to a function call that has a __u32 as a
> > parameter so the __u16 gets upcasted to a __u32 already.
> > >
> > >
> > > That said, if we have this in the Load Default System Configuration l=
ist, we should extended it to __le32 there as well.
> >
> > I agree, this means the range of default system configuration may not
> > be sufficient to accept all possible values that the newer command
> > supports, although I think this is a separate issue from what this
> > patch is trying to solve.
> > >
> > >
> > > >       if (instance > 0) {
> > > >               adv_instance =3D hci_find_adv_instance(hdev, instance=
);
> > > > @@ -1833,8 +1834,9 @@ int __hci_req_setup_ext_adv_instance(struct h=
ci_request *req, u8 instance)
> > > >
> > > >       memset(&cp, 0, sizeof(cp));
> > > >
> > > > -     memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval)=
);
> > > > -     memcpy(cp.max_interval, adv_interval, sizeof(cp.max_interval)=
);
> > > > +     /* take least significant 3 bytes */
> > > > +     memcpy(cp.min_interval, &min_adv_interval, sizeof(cp.min_inte=
rval));
> > > > +     memcpy(cp.max_interval, &max_adv_interval, sizeof(cp.max_inte=
rval));
> > >
> > > This is dangerous and I think it actually break in case of unaligned =
access platforms.
> >
> > Since it is in le format already and the 3 bytes from the cmd struct
> > are raw, I'm not sure how this can be dangerous.  It effectively
> > yields the exact same results as your suggestions below.
>
> In zephyr we end up doing helper functions for 24 bits:
>
> https://github.com/zephyrproject-rtos/zephyr/blob/master/include/sys/byte=
order.h#L316
>
> I guess that is safer in terms of alignment access and it would work
> independent of the host order which apparently was not the case in the
> code above since it doesn't do the conversion to le32 (or perhaps the
> intervals are already in le32), anyway having something like that is
> probably much simpler to maintain given that most intervals use for
> things like ISO are also 24 bits long.
I like this. Would you put this in hci.h or keep to a lower scope?

static inline void hci_cpu_to_le24(__u32 val, __u8 dst[3])
{
dst[0] =3D val & 0xff;
dst[1] =3D (val & 0xff00) >> 8;
dst[2] =3D (val & 0xff0000) >> 16;
}

> > >
> > >
> > > In this case I prefer to actually do this manually.
> > >
> > >                 /* In ext adv min interval is 3 octets */
> > >                 cp.min_interval[0] =3D cp.min_interval & 0xff;
> > >                 cp.min_interval[1] =3D (cp.min_interval & 0xff00) >> =
8;
> > >                 cp.min_interval[2] =3D (cp.min_interval & 0xff0000) >=
> 12;
> > >
> > > Regards
> > >
> > > Marcel
> > >
>
>
>
> --
> Luiz Augusto von Dentz
