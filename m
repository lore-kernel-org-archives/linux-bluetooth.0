Return-Path: <SRS0=PvgB=3K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDB6C2D0CE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 22:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA92A24655
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 22:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F71lfE9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgAUWXw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:23:52 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38746 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgAUWXw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 17:23:52 -0500
Received: by mail-vs1-f67.google.com with SMTP id v12so2977211vsv.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2020 14:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iD6ZGhDQZrOHRv/A01FwXuPAY9l9Xe49LbJoITnwCmM=;
        b=F71lfE9hbq8RxLcp0uDCRXCiTJpoXNF4XotknaJAmZSTIihIu22T2MA9GBRM0OH/be
         rvSzPVmvRdjl78yonzxCqdGyR+udgzZzhflh0LHdKmSR65W0Z1Y31cjZUyoI8WJsJqVA
         YOAdiKGb0ogy7cT6v6BH6jmWeyk3vvfxGyD8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iD6ZGhDQZrOHRv/A01FwXuPAY9l9Xe49LbJoITnwCmM=;
        b=VU2RCoFZ2VKymqEZu9sIUgAfdeXRkwDjCd6zpkfhw/YLcW0rjXEz+o4OykxL4mCv5L
         0/UhPChsfgm3juV5ifz0n7aBg70nDiw6C0L2GaNWYkHxsEFEXQ5aBq+Kk2Nmd+pyINkz
         jASgS75nzfoo1V3FgxIJTkD8SExx2UURMDCEarKKTtSh9XupR1ylCH4Hwwb38vMwgaiL
         K1WZNoOTWV/PdQUCn4nM/s+/xoCjTey9fdbu6ldfQn+CxR6jarCB+BhnaOONaQMg2PfW
         3wu/QDrdAj+xsng2H6R541bstXT3MdDVJnf3QVvaIwlOsZtSn2WYezluCypQ5IjUm1GQ
         eoww==
X-Gm-Message-State: APjAAAWvck1lY2BeYvZ2ZSOFUw+4l8wE3UQ8OCqnuxs9KtTh4n/HG0B3
        oMvYmbKwM/GPoo+CcMWcPJtGL1p/0aksbQQ6Hfvspg==
X-Google-Smtp-Source: APXvYqwdKtZ2i29raYCeIhkNaU3cOuv+s7RjXUfIkZxIFTgKX4HoyyJ3p4sB00HsLIntdVkU83W1eznfFMOMbTMIRKU=
X-Received: by 2002:a67:d007:: with SMTP id r7mr689536vsi.93.1579645431053;
 Tue, 21 Jan 2020 14:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20200117132754.BlueZ.1.I56a225147d9cabef55f94b57129a5e37ea79d165@changeid>
 <20200117132754.BlueZ.2.Ie24be91b472c0a274606191bc4d14df030fe3598@changeid>
 <CABBYNZJBf_FxO-=nVRqtC9MPEsD8dyXoGhFQPRYg0SB4wQG51Q@mail.gmail.com> <CABBYNZLV_x5zv_McY1bA1253B2j=Yn8KHHiH59xg=eBy07P70w@mail.gmail.com>
In-Reply-To: <CABBYNZLV_x5zv_McY1bA1253B2j=Yn8KHHiH59xg=eBy07P70w@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 21 Jan 2020 14:23:40 -0800
Message-ID: <CANFp7mWkZoOmwobknVMynOTvOV4=3Vi6U9wmFoy9iktoODfzpA@mail.gmail.com>
Subject: Re: [BlueZ PATCH 2/2] input: Make HID devices wake capable
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hey Luiz,

Yes, I will be following up. I sent an email on Friday but I think
with html so it may have been lost.
Will resend the patches today with wake_capable exposed via dbus and
not automatically set by the profile.

Abhishek

On Tue, Jan 21, 2020 at 2:15 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Abhishek,
>
> On Fri, Jan 17, 2020 at 2:16 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Abhishek,
> >
> > On Fri, Jan 17, 2020 at 1:28 PM Abhishek Pandit-Subedi
> > <abhishekpandit@chromium.org> wrote:
> > >
> > > HID devices can wake the host from a suspended state. Mark them as wake
> > > capable when they are accepted.
> >
> > My suggestion is that we do this via application so we let the user
> > decide if he wants or not to wake up the system, you may still opt-in
> > to always enable to wake up in your system setting if you choose to,
> > going this route actually means the user can select not to wake up if
> > the device is somewhat broken or misbehaving in some respect which is
> > not that uncommon nowadays.
>
> Will there be any follow up on this or you didn't quite understand
> what Im suggesting here?
>
> > > ---
> > >
> > >  profiles/input/device.c | 1 +
> > >  profiles/input/hog.c    | 1 +
> > >  2 files changed, 2 insertions(+)
> > >
> > > diff --git a/profiles/input/device.c b/profiles/input/device.c
> > > index 2cb3811c8..a6b0e8053 100644
> > > --- a/profiles/input/device.c
> > > +++ b/profiles/input/device.c
> > > @@ -1381,6 +1381,7 @@ int input_device_register(struct btd_service *service)
> > >         }
> > >
> > >         btd_service_set_user_data(service, idev);
> > > +       device_set_wake_capable(device, true);
> > >
> > >         return 0;
> > >  }
> > > diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> > > index 83c017dcb..8627f3557 100644
> > > --- a/profiles/input/hog.c
> > > +++ b/profiles/input/hog.c
> > > @@ -159,6 +159,7 @@ static int hog_probe(struct btd_service *service)
> > >                 return -EINVAL;
> > >
> > >         btd_service_set_user_data(service, dev);
> > > +       device_set_wake_capable(device, true);
> > >         return 0;
> > >  }
> > >
> > > --
> > > 2.25.0.341.g760bfbb309-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
