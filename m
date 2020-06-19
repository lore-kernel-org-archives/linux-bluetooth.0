Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367C6C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 18:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1250521527
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 18:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq6G4WsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436682AbgFSSmG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732225AbgFSSmF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 14:42:05 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCD9C06174E
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 11:42:05 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id s13so8036121otd.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kV3/TnPlRElMR4EpGS3Wr6fOtcvyfVlWAo5KVqV268M=;
        b=Zq6G4WsF6kx8s1jgjdDacU5DSUJ7HVNKI9JBwWsWJ4eSKRXWp5E7IBA2UDPI8+eUho
         +Wiken+yHOM26E5jkAaZMq3R4Ge8Sy1OfEIwc/Ean9/+aK4IX+ixDCM0uoa3OasTD7yN
         8b4eqFnRfMWKMDTl7kPGXcay63z8sMJlgnU3OyYI0jdcUJTygxXyinw2cHoWCoOCIcv/
         qhOORxeRywrHMt4hNt9/Um3VLl9cMxymtCVorvQgtkxLXXSxsGQfPgz/aEFNY9XO28oK
         S3H2qdF+2E78fNw8jum4XtixmumvBLOa9ce/2r66zs8Vjdlfkll1jhsE+F6NlRXI2P5h
         zKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kV3/TnPlRElMR4EpGS3Wr6fOtcvyfVlWAo5KVqV268M=;
        b=sqvpExek8NwGRFHos5iPwEciZk6XoulyUqXQo9SmdQVxsvSI/3JleUmDEX6JbuTA/9
         olF6GrJgBUzsBVzQTmPLRMGnmC8KlvL58YE0zfQ1UhHziAWlOKR1rXr0E5exn/R2zgiC
         JsryPSIKVsSpVL/q+FFXijjBqpvejSveeS7vRAXvaG5cPj2cMRXxmI55iCUmAJ/lFdJw
         XDPbLru3ksytERl4+C2sieELOSPchmOysQ3+67mDaoo6LG1tC0oDIDouBqYGB/beIsJJ
         nXyorWTg6jd2biqRksuoUEPOc7qzybVKmdVGMx2gZ7YPbD0WerX3IJGq7YyyDWX+zvNn
         DMYg==
X-Gm-Message-State: AOAM532ThPUcgLMK92ACj27STcFHGKwCvZ+eppsAPXDTf/HvoBeYsiby
        S313pAfqBny3I/H0ubNv0SmZW8RqVICtZ553e9XmC2dD
X-Google-Smtp-Source: ABdhPJyZxO67azhJQipDme1wYecvf3GJ5HjN8tN2G+wWzcBxn1rnXigIe84hHBZShhjpCrQMUj+HOP9ckniY+eTjnIc=
X-Received: by 2002:a9d:4691:: with SMTP id z17mr4107616ote.88.1592592124884;
 Fri, 19 Jun 2020 11:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200618210659.142284-1-alainm@chromium.org> <C5D30F5E-B50F-4DE7-A909-F48F6C555661@holtmann.org>
 <CALWDO_XLRELJhe1n9AVq2w9fQYkgGLC+bdXQ-1-M4f-cUfEwGQ@mail.gmail.com>
In-Reply-To: <CALWDO_XLRELJhe1n9AVq2w9fQYkgGLC+bdXQ-1-M4f-cUfEwGQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 19 Jun 2020 11:41:53 -0700
Message-ID: <CABBYNZLEsUXFW_hrmcvSALRpeZwkmvk=c9SYPt+owO7tn+hMBw@mail.gmail.com>
Subject: Re: [PATCH v1] bluetooth: use configured params for ext adv
To:     Alain Michaud <alainmichaud@google.com>
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

Hi Alain, Marcel,

On Fri, Jun 19, 2020 at 6:54 AM Alain Michaud <alainmichaud@google.com> wro=
te:
>
> Hi Marcel,
>
> On Fri, Jun 19, 2020 at 3:46 AM Marcel Holtmann <marcel@holtmann.org> wro=
te:
> >
> > Hi Alain,
> >
> > please use =E2=80=9CBluetooth: =E2=80=9C prefix for the subject.
>
> ack.
> >
> >
> > > When the extended advertisement feature is enabled, a hardcoded min a=
nd
> > > max interval of 0x8000 is used.  This patches fixes this issue by usi=
ng
> > > the configured min/max value.
> > >
> > > This was validated by setting min/max in main.conf and making sure th=
e
> > > right setting is applied:
> > >
> > > < HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) p=
len
> > > 25                                          #93 [hci0] 10.953011
> > > =E2=80=A6
> > > Min advertising interval: 181.250 msec (0x0122)
> > > Max advertising interval: 181.250 msec (0x0122)
> > > =E2=80=A6
> > >
> > > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> > >
> > > Signed-off-by: Alain Michaud <alainm@chromium.org>
> >
> > The Reviewed-by lines go after your Signed-off-by.
>
> ack.
> >
> >
> > > ---
> > >
> > > net/bluetooth/hci_request.c | 10 ++++++----
> > > 1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.=
c
> > > index 29decd7e8051..08818b9bf89f 100644
> > > --- a/net/bluetooth/hci_request.c
> > > +++ b/net/bluetooth/hci_request.c
> > > @@ -1799,8 +1799,9 @@ int __hci_req_setup_ext_adv_instance(struct hci=
_request *req, u8 instance)
> > >       int err;
> > >       struct adv_info *adv_instance;
> > >       bool secondary_adv;
> > > -     /* In ext adv set param interval is 3 octets */
> > > -     const u8 adv_interval[3] =3D { 0x00, 0x08, 0x00 };
> > > +     /* In ext adv set param interval is 3 octets in le format */
> > > +     const __le32 min_adv_interval =3D cpu_to_le32(hdev->le_adv_min_=
interval);
> > > +     const __le32 max_adv_interval =3D cpu_to_le32(hdev->le_adv_max_=
interval);
> >
> > Scrap the const here.
>
> I'd like to understand why it isn't prefered to use const when you
> don't intend to modify it in the code.
> >
> >
> > And it is wrong since your hdev->le_adv_{min,max}_interval is actually =
__u16. So that first needs to be extended to a __u16 value.
>
> The macro actually leads to a function call that has a __u32 as a
> parameter so the __u16 gets upcasted to a __u32 already.
> >
> >
> > That said, if we have this in the Load Default System Configuration lis=
t, we should extended it to __le32 there as well.
>
> I agree, this means the range of default system configuration may not
> be sufficient to accept all possible values that the newer command
> supports, although I think this is a separate issue from what this
> patch is trying to solve.
> >
> >
> > >       if (instance > 0) {
> > >               adv_instance =3D hci_find_adv_instance(hdev, instance);
> > > @@ -1833,8 +1834,9 @@ int __hci_req_setup_ext_adv_instance(struct hci=
_request *req, u8 instance)
> > >
> > >       memset(&cp, 0, sizeof(cp));
> > >
> > > -     memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval));
> > > -     memcpy(cp.max_interval, adv_interval, sizeof(cp.max_interval));
> > > +     /* take least significant 3 bytes */
> > > +     memcpy(cp.min_interval, &min_adv_interval, sizeof(cp.min_interv=
al));
> > > +     memcpy(cp.max_interval, &max_adv_interval, sizeof(cp.max_interv=
al));
> >
> > This is dangerous and I think it actually break in case of unaligned ac=
cess platforms.
>
> Since it is in le format already and the 3 bytes from the cmd struct
> are raw, I'm not sure how this can be dangerous.  It effectively
> yields the exact same results as your suggestions below.

In zephyr we end up doing helper functions for 24 bits:

https://github.com/zephyrproject-rtos/zephyr/blob/master/include/sys/byteor=
der.h#L316

I guess that is safer in terms of alignment access and it would work
independent of the host order which apparently was not the case in the
code above since it doesn't do the conversion to le32 (or perhaps the
intervals are already in le32), anyway having something like that is
probably much simpler to maintain given that most intervals use for
things like ISO are also 24 bits long.

> >
> >
> > In this case I prefer to actually do this manually.
> >
> >                 /* In ext adv min interval is 3 octets */
> >                 cp.min_interval[0] =3D cp.min_interval & 0xff;
> >                 cp.min_interval[1] =3D (cp.min_interval & 0xff00) >> 8;
> >                 cp.min_interval[2] =3D (cp.min_interval & 0xff0000) >> =
12;
> >
> > Regards
> >
> > Marcel
> >



--=20
Luiz Augusto von Dentz
