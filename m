Return-Path: <SRS0=eST2=AT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEC3C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 04:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EFC02078A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 04:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YIYXBg1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgGHEa7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jul 2020 00:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgGHEa6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jul 2020 00:30:58 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EB9C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 21:30:58 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so1488698wmi.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 21:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZKamWyOk2LKr0w8kMEWnJTr+pCyij1spBpIwpyFRRm8=;
        b=YIYXBg1NoP8wmcNsD0Sf4ZqISekt1oF13AOJdsyxFYf8nBDU8Yj57Tc3HD/prjdXlP
         TrHYJjd97VIb2gnO0Ydbfv2wHVeRcvn/8Id392i3nbpDMKhzQm2wCcH23rl4q3VgrpOD
         gE8XnSt3Go7HqEkVJIuwKALtOZljq9scAKLYiGQ6RIFy1Rq4OWoSMaKITjUU/D7n/sJ1
         gcSDlt6BpNSnXnn1ZS8Kj643VJkUY6gmYfdnVV5f4q+lgWu+U871fLpg2HFPh9KeZEJw
         5Tens72l8M3bXXe3NKu4IIzqNsHLvhx5fttAo7cLSkECLJzCmCGDMWHPUFsKyxLgpMtJ
         CmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZKamWyOk2LKr0w8kMEWnJTr+pCyij1spBpIwpyFRRm8=;
        b=IRVWxMasyxlreOPv/saPt9HmpmlJ5tmjtngGgpKxjYYc+Gcz0IoQBDArELoa1t9wI2
         0rzvtf/gSDwdsy0pyrTt/ExFF+x7r6LFlbDbJmOwjFe/Fri9AfByrOP2kToBW3/LH6QL
         kKlZzn4CrDnwSXg9jrcZ7Hr+3hT4192zzCMtYU8Zu+NeW0HK+S0hDZvsK+V6jsgRWNbW
         gu+gnQmzmMQjVDjbQELMYkHlqsXqE0qSFe3Gpw3NtX+GGuy9w2hHq8LdVibaH6w8KEqP
         kOGNBYzhGFitaCxP5l0H9XrvPWrTDe2c0wQKG65h0tGt0NWdOrJ6ZEF7pwDTIIH0RxqI
         XrYg==
X-Gm-Message-State: AOAM532c4ZvdAEwhr9xuYtGMdexDBKsbBSzcbYNYPtismH8cpNbw5S7K
        74C8frf7dY0UIsSyNsPL7FI+jtyZvXu8ZNRWT16ozF6zqnQ=
X-Google-Smtp-Source: ABdhPJxFbBVjezHuFVJcepbKCoHMytsvAr4E0Rgswv1fMikjAKlRrVAFmagjIMc1h7jQD35dbDs+WUVZGuhZPv8ph5E=
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr7079420wma.18.1594182656690;
 Tue, 07 Jul 2020 21:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200627235318.Bluez.v2.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
 <CABBYNZ+8bZW7qjzVNsSv7Sc_3h-ZwbSa6Hnz=dAX+2AxmWV9Dw@mail.gmail.com>
In-Reply-To: <CABBYNZ+8bZW7qjzVNsSv7Sc_3h-ZwbSa6Hnz=dAX+2AxmWV9Dw@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Wed, 8 Jul 2020 12:30:45 +0800
Message-ID: <CAJQfnxHnLKoMQ+Z5bRhAQPWkoN5Lb5m-9o2pe4HTMP4Jy26qrQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 1/2] device: add device_remove_bonding function
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

As far as the spec is concerned, we can also remove the device by
calling device_remove. However, I suppose it would be confusing for
end users if they can no longer find their HID device on the device
list just because the device previously sent a virtual cable
disconnection.
The HID 1.0 spec part 6.4.2 also gives an example of a possible
scenario when a virtually cabled device is removed: "Unplugged devices
shall be marked as known and put into a =E2=80=9Cmost recently used list=E2=
=80=9D of
known devices to facilitate future re-connecting".

Thanks,
Archie


On Wed, 8 Jul 2020 at 02:03, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Sat, Jun 27, 2020 at 8:54 AM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > This patch splits the "bonding removal" function in device.c,
> > because we need to remove bonding information when receiving
> > "virtual cable unplug" in HID profile.
> >
> > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> > Changes in v2: None
> >
> >  src/device.c | 25 +++++++++++++++----------
> >  src/device.h |  1 +
> >  2 files changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/src/device.c b/src/device.c
> > index 7b0eb256e..9fb0e018c 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -4162,6 +4162,17 @@ static void delete_folder_tree(const char *dirna=
me)
> >         rmdir(dirname);
> >  }
> >
> > +void device_remove_bonding(struct btd_device *device, uint8_t bdaddr_t=
ype)
> > +{
> > +       if (bdaddr_type =3D=3D BDADDR_BREDR)
> > +               device->bredr_state.bonded =3D false;
> > +       else
> > +               device->le_state.bonded =3D false;
> > +
> > +       btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
> > +                                                       bdaddr_type);
> > +}
> > +
> >  static void device_remove_stored(struct btd_device *device)
> >  {
> >         char device_addr[18];
> > @@ -4170,17 +4181,11 @@ static void device_remove_stored(struct btd_dev=
ice *device)
> >         char *data;
> >         gsize length =3D 0;
> >
> > -       if (device->bredr_state.bonded) {
> > -               device->bredr_state.bonded =3D false;
> > -               btd_adapter_remove_bonding(device->adapter, &device->bd=
addr,
> > -                                                               BDADDR_=
BREDR);
> > -       }
> > +       if (device->bredr_state.bonded)
> > +               device_remove_bonding(device, BDADDR_BREDR);
> >
> > -       if (device->le_state.bonded) {
> > -               device->le_state.bonded =3D false;
> > -               btd_adapter_remove_bonding(device->adapter, &device->bd=
addr,
> > -                                                       device->bdaddr_=
type);
> > -       }
> > +       if (device->le_state.bonded)
> > +               device_remove_bonding(device, device->bdaddr_type);
> >
> >         device->bredr_state.paired =3D false;
> >         device->le_state.paired =3D false;
> > diff --git a/src/device.h b/src/device.h
> > index 06b100499..907c7c5c4 100644
> > --- a/src/device.h
> > +++ b/src/device.h
> > @@ -49,6 +49,7 @@ uint16_t btd_device_get_vendor(struct btd_device *dev=
ice);
> >  uint16_t btd_device_get_vendor_src(struct btd_device *device);
> >  uint16_t btd_device_get_product(struct btd_device *device);
> >  uint16_t btd_device_get_version(struct btd_device *device);
> > +void device_remove_bonding(struct btd_device *device, uint8_t bdaddr_t=
ype);
> >  void device_remove(struct btd_device *device, gboolean remove_stored);
>
> Is there any particular reason why device_remove is not enough here? I
> don't see any reason to leave the device object around after removing
> its bonding.
>
> >  int device_address_cmp(gconstpointer a, gconstpointer b);
> >  int device_bdaddr_cmp(gconstpointer a, gconstpointer b);
> > --
> > 2.27.0.212.ge8ba1cc988-goog
> >
>
>
> --
> Luiz Augusto von Dentz
