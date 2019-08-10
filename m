Return-Path: <SRS0=fX1h=WG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD8DC32751
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Aug 2019 06:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89948208C3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Aug 2019 06:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8upRb0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfHJGzF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 10 Aug 2019 02:55:05 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33797 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfHJGzF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 10 Aug 2019 02:55:05 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5so141339268otk.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Aug 2019 23:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dkHzRfkeai+SEc70CMaXC9uHWlnINjH3tuKnKKaSIQ4=;
        b=A8upRb0hzYbqFPZO2RSHEemwInYZeTlowRMWIATDoEvR8dRVSBoOsVSjFl3UQ0WSlS
         xlh/6cqKbPAMPv0yrZiOF6+OT24KHJsKLHscgaDJy4ggtijhn7jGZKOLrxWHzpspNrMu
         2Q5AdxNAYHp7MKPl+HZQec7Hi8ZorEDlXGegGoD2FFlNpppXabvp4HK6bJkPVD/LPp84
         S4j5LGbP7oN/n9OcQYJN/K2VHRhq8JJVhn9Pv2JFGg8PxMsWVKTz43Hzs/Brw9f64fKn
         M+A7MtkM2mT9GwtnPGrU9w7oDHb9LkJ9HCy2U/l4E91X9K2gWmyVGuAOpqTHWW9jVJVD
         mtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dkHzRfkeai+SEc70CMaXC9uHWlnINjH3tuKnKKaSIQ4=;
        b=XjYEkwFvEY8CwT+fso8GNxaIpsBCO3rFHXpVevtQS+HHqwh8BLChb0hif5plZ/cnW/
         YilVnMRIgZSLG9q35HgHYumKM1lGI6Ij9KvmRVP0d+9hV2se8e4D1pvhBHHrI6v1Zl/O
         5FCpIQvXuPKCmgwMXb6NRmVOfdT0UIW4n6FporJIIr6ungeo7R5faolFBj3zxQym7JVO
         mrXD5xeP+By1asRMhH5CVycM5PI8f942DdzaCjCWLeKSeLFrWdaeVsz8xVFxPRGa4UHg
         +882NpPHupeM82RWvSuOJho/IdrvGzpcg3lknW0SMdOnS+wR0R0+L+qxqgBwGW5Zm3QX
         Q6nA==
X-Gm-Message-State: APjAAAVXzYLverUQRE8sbdtjO0FZLARGLnMTW0H8EEp6TYGV2JX+Eu4o
        /h8Fn3+IdAxnPzLmLwkRgKQ7xT/nqTtr+H5OQYk=
X-Google-Smtp-Source: APXvYqx2KxjteRVQ18f1ARMu0VmULwcuNjkZSYlV4Cdjxhm3WaXGmcpc/lJ8qGclplhbyorIFjUzK7EmiF8wpuB3oFs=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr15808838otf.146.1565420104346;
 Fri, 09 Aug 2019 23:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190712151329.11333-1-luiz.dentz@gmail.com> <CABBYNZLDFAJgkfAFWOOAAqqiX8mpi3KgirBkpwpnBFJ3TxPqyg@mail.gmail.com>
 <20190718100024.ii2igadxb2lmmitm@pali> <20190721155522.3vqt7vsprhpxflqf@pali>
In-Reply-To: <20190721155522.3vqt7vsprhpxflqf@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 10 Aug 2019 09:54:52 +0300
Message-ID: <CABBYNZK6cuz9n4Hu9uRCbQvn9uFEYkn9=mY8J5Fqu0u-D3B1EA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sun, Jul 21, 2019 at 6:55 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Thursday 18 July 2019 12:00:24 Pali Roh=C3=A1r wrote:
> > On Saturday 13 July 2019 17:52:46 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Fri, Jul 12, 2019 at 6:13 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >
> > > > This uses application ObjectManager to discover the MediaEndpoint a=
nd
> > > > MediaPlayer object of an application and deprecates the use of
> > > > RegisterEndpoint and RegisterPlayer.
> > > > ---
> > > >  doc/media-api.txt | 20 ++++++++++++++++++++
> > > >  1 file changed, 20 insertions(+)
> > > >
> > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > index bca8c9563..07f7ac3e0 100644
> > > > --- a/doc/media-api.txt
> > > > +++ b/doc/media-api.txt
> > > > @@ -66,7 +66,27 @@ Methods              void RegisterEndpoint(objec=
t endpoint, dict properties)
> > > >
> > > >                         Unregister sender media player.
> > > >
> > > > +               void RegisterApplication(object root, dict options)
> > > >
> > > > +                       Register endpoints an player objects within=
 root
> > > > +                       object which must implement ObjectManager.
> > > > +
> > > > +                       The application object path together with t=
he D-Bus
> > > > +                       system bus connection ID define the identif=
ication of
> > > > +                       the application.
> > > > +
> > > > +                       Possible errors: org.bluez.Error.InvalidArg=
uments
> > > > +                                        org.bluez.Error.AlreadyExi=
sts
> > > > +
> > > > +               void UnregisterApplication(object application)
> > > > +
> > > > +                       This unregisters the services that has been
> > > > +                       previously registered. The object path para=
meter
> > > > +                       must match the same value that has been use=
d
> > > > +                       on registration.
> > > > +
> > > > +                       Possible errors: org.bluez.Error.InvalidArg=
uments
> > > > +                                        org.bluez.Error.DoesNotExi=
st
> > > >  Media Control hierarchy
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > >
> > > > --
> > > > 2.21.0
> > >
> > > Can you try this set?
> >
> > Hello, I will try it later in next week. To test it would mean to
> > rewrite pulseaudio bluetooth modules to use this new API, so it would
> > take me longer time.
>
> Hi! I looked at it. But I do not know how to implement
> GetManagedObjects() method via libdbus properly. Any idea?

I went ahead and applied this set, you can find some examples of how
to implement ObjectManager interface in gdbus but I guess what you
really need to do is make PA aware of the objects being exposed since
it does make it simpler to to enumerate objects by the clients.

--=20
Luiz Augusto von Dentz
