Return-Path: <SRS0=PvgB=3K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE156C2D0CE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 22:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABBC24655
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 22:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6fjjWIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgAUWP5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:15:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41876 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgAUWP5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 17:15:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so4180171oie.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2020 14:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7A+n7aMyGZsqcDuDq2PJMGoI9fJ7D/2Lo7cprD+OZYM=;
        b=T6fjjWIEwqrfXZPyddjQH+Nd8xZ+mfdykp+E2GyrJtLuJkqU726B6dJv79/Hhdl9Dr
         p9SDhuZwzoLe5EuWiPBjckvaHWxpTS64GJk5CieweDmEY+xdE9+a72pGumQfjAa8PE+8
         QIY/5EkqtTf5QIDXt2pMOUvfRe8mNhI12pSmyS8rnlosIZQIqchQhWXDvpifH0NjSTku
         Bgf3eNF4IoZwFLIlHvtIQdvdX3b/zqYtfIW2NL0X8hI3rwO12qJJamrh4oVi6ir3oD5h
         5qqS+qYTAbVwQXS9f0GbxhzIuIW1uy2WyuVL5DBNDo34bnNnls3VZSzEk5ztKj0kJ6qM
         ElVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7A+n7aMyGZsqcDuDq2PJMGoI9fJ7D/2Lo7cprD+OZYM=;
        b=U6iDOfb54rACftB7EpoGJRj85Al41oYHc80hS6bUZS7js36xTTXluM+y5IaT2KBNDH
         fChjOWExLgKpNiI8tPb6/hEmCaH30uiLoVgGKdiXUswBcSFHdrid8VAC7riqpOm9bwOt
         YoiCjrVI2Qbx5oQ/dSVTQy9Y0jXcDgOWyNqBhOYDYinlrHozPxmujXUZCb4gf7QfUwt6
         L6r1VOMQ53Ctn7EWh5MXvTjAJOMSpfb2MRMNLgHbA46JbGqfNxGaMEhzco18JAjm9Ddy
         YqGkixr6KhhyQaaN4dMqMJPs+9KbiH8qA5oFsjzSFe8r8NQZKYjdj61jmMYpv+TXNwVz
         rODQ==
X-Gm-Message-State: APjAAAXkbSicN+YV1M/m4EYKLJCCvWK6IQ4pH6qys7SGChq8xoYg11CS
        g8jC1onwlibbOAtDz7Fvk1dvi+pK5gWI38v0CjuzljSr
X-Google-Smtp-Source: APXvYqz/tcOT+hOtviJQYDR4zk/54MjYiSzE4OTSsXWapeObV4MYHyiBonS1AsBJdAUNVxBrQ/AVIEITy7UM9ZPAlhk=
X-Received: by 2002:aca:481:: with SMTP id 123mr4844983oie.110.1579644956167;
 Tue, 21 Jan 2020 14:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20200117132754.BlueZ.1.I56a225147d9cabef55f94b57129a5e37ea79d165@changeid>
 <20200117132754.BlueZ.2.Ie24be91b472c0a274606191bc4d14df030fe3598@changeid> <CABBYNZJBf_FxO-=nVRqtC9MPEsD8dyXoGhFQPRYg0SB4wQG51Q@mail.gmail.com>
In-Reply-To: <CABBYNZJBf_FxO-=nVRqtC9MPEsD8dyXoGhFQPRYg0SB4wQG51Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Jan 2020 14:15:44 -0800
Message-ID: <CABBYNZLV_x5zv_McY1bA1253B2j=Yn8KHHiH59xg=eBy07P70w@mail.gmail.com>
Subject: Re: [BlueZ PATCH 2/2] input: Make HID devices wake capable
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Fri, Jan 17, 2020 at 2:16 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Abhishek,
>
> On Fri, Jan 17, 2020 at 1:28 PM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> > HID devices can wake the host from a suspended state. Mark them as wake
> > capable when they are accepted.
>
> My suggestion is that we do this via application so we let the user
> decide if he wants or not to wake up the system, you may still opt-in
> to always enable to wake up in your system setting if you choose to,
> going this route actually means the user can select not to wake up if
> the device is somewhat broken or misbehaving in some respect which is
> not that uncommon nowadays.

Will there be any follow up on this or you didn't quite understand
what Im suggesting here?

> > ---
> >
> >  profiles/input/device.c | 1 +
> >  profiles/input/hog.c    | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/profiles/input/device.c b/profiles/input/device.c
> > index 2cb3811c8..a6b0e8053 100644
> > --- a/profiles/input/device.c
> > +++ b/profiles/input/device.c
> > @@ -1381,6 +1381,7 @@ int input_device_register(struct btd_service *service)
> >         }
> >
> >         btd_service_set_user_data(service, idev);
> > +       device_set_wake_capable(device, true);
> >
> >         return 0;
> >  }
> > diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> > index 83c017dcb..8627f3557 100644
> > --- a/profiles/input/hog.c
> > +++ b/profiles/input/hog.c
> > @@ -159,6 +159,7 @@ static int hog_probe(struct btd_service *service)
> >                 return -EINVAL;
> >
> >         btd_service_set_user_data(service, dev);
> > +       device_set_wake_capable(device, true);
> >         return 0;
> >  }
> >
> > --
> > 2.25.0.341.g760bfbb309-goog
> >
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
