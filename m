Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BB7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 23:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6101208C9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 23:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpSBK1gZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgEUXTN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 19:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbgEUXTN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 19:19:13 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7BBC061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 16:19:12 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 23so6518844oiq.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 16:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UOeHTWoXRWRmyOdgj5FtSZK1CcJMJPUqJEJ+fQz6M34=;
        b=YpSBK1gZUnRvXZRljmeTNd/AMpDeDP1QfPKff11mA8lusNiQP3J3He5lT1tXqgcLyn
         VaRsvavSPV/IGodgYkPzZS1FfrGdA0NH1fp0+hoAmiD+ekcu0jlkZ9UUmH69JBY2uTgV
         mZMwNbyQOZqcqxJD9/O0n/5NBI1Ft5mOo2Mquwa4JzHVI1lE7mFE4BORTgaO8vatnT8U
         xP8TD6/Ki7lrbkgNldHeNMgQ7TqP1GIaBaMF7QJxalHsKLRGjrMnKKDQFA0qy1Ot4g7E
         Nb4cI9wyH8uPR7ims8/C18E9KZHgL33GNXoC9ENPM7hc+zJOUxS04RCghr+oTIYmRZ7D
         1RRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UOeHTWoXRWRmyOdgj5FtSZK1CcJMJPUqJEJ+fQz6M34=;
        b=LIwVT1/8jOzWx8aspeGMxmZBerKNumu4a7DKTJW98q2otKnI/YF6LGski4Puh4dg8Z
         AH73cvwZF9mZK+cxln0EFlQ6JrMsmA6pYm35kJYxXi4G6yku3/H8mEq9++iy78K3LvJ1
         SYdrCAHwGADMv35i7SkfuxeK6YIShOWmXJ/8E9q2iDoYF8viIJQliZ9RSfZg6wwTvvKk
         JlRsf22eSLA+3zlS9An5plxzJWsDSEirP7eqVOR0sdptISStPYfO6elR+k0TqWgnkpMM
         3Qwn62tdmja9AGyErasP4lkMPCW2pce+u3PL3gyzOQbwZ3be5znY5mBzRz/azlu/NVzQ
         5blg==
X-Gm-Message-State: AOAM532gfAFcA8CjyMP6QwdjPIuyOhPPlLNWgp6R7cC9HzwM8nIKulw8
        SSt4rnP8+LYRBvP11TU6Ntu2Mp1IeS805CCbYyE=
X-Google-Smtp-Source: ABdhPJzP/p+yIshyJoqttcAsaLPdWXtjnTLjMF7nzHXQ1fV2GvozVRNjgbOr1tt/gtNOvsQ3Gpgq/YSolMWBjeZ5t+M=
X-Received: by 2002:aca:6747:: with SMTP id b7mr758232oiy.110.1590103151952;
 Thu, 21 May 2020 16:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200521145757.245774-1-alainm@chromium.org> <CABBYNZKU4JVHxL5NEaMFgf6-aAOrG4re=T0Yat9b=viz57PcsQ@mail.gmail.com>
 <CALWDO_UQhU5QxZ1eRNWZtAtkcghWEBM5eVeujxhROSr7PG_P=w@mail.gmail.com>
 <CABBYNZ+8ed4qXarr647Q2SKkvqdT3N5AccP4L5a35e--9ybzgg@mail.gmail.com> <CALWDO_WT1DmS02jSJSa8GyiPwFz7cEnOjqhXMJsDO=6=MjyGyw@mail.gmail.com>
In-Reply-To: <CALWDO_WT1DmS02jSJSa8GyiPwFz7cEnOjqhXMJsDO=6=MjyGyw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 May 2020 16:18:59 -0700
Message-ID: <CABBYNZJzSaEvFTt6b6vuEoM3Eof225=bszVvM0ZtyJ0NsqVdGg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3] doc:adding definitions for load default params
 mgmt op
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Thu, May 21, 2020 at 3:28 PM Alain Michaud <alainmichaud@google.com> wro=
te:
>
> Hi Luiz
>
>
> On Thu, May 21, 2020 at 6:05 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Alain,
> >
> > On Thu, May 21, 2020 at 1:12 PM Alain Michaud <alainmichaud@google.com>=
 wrote:
> > >
> > > Hi Luiz,
> > >
> > >
> > > On Thu, May 21, 2020 at 12:26 PM Luiz Augusto von Dentz <luiz.dentz@g=
mail.com> wrote:
> > >>
> > >> Hi Alain,
> > >>
> > >> On Thu, May 21, 2020 at 8:05 AM Alain Michaud <alainm@chromium.org> =
wrote:
> > >> >
> > >> > This change adds the definition for the load default parameter com=
mand.
> > >> > In particular, this command is used to load default parameters for
> > >> > various operations in the kernel. This mechanism is also expandabl=
e to
> > >> > future values that may be necessary.
> > >> >
> > >> > This will allow bluetoothd to load parameters from a conf file tha=
t may
> > >> > be customized for the specific requirements of each platforms.
> > >> >
> > >> > ---
> > >> > rebase against current master
> > >> >
> > >> >  doc/mgmt-api.txt | 62 +++++++++++++++++++++++++++++++++++++++++++=
+++++
> > >> >  1 file changed, 62 insertions(+)
> > >> >
> > >> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > >> > index 6ee01fed8..c6575e654 100644
> > >> > --- a/doc/mgmt-api.txt
> > >> > +++ b/doc/mgmt-api.txt
> > >> > @@ -3223,6 +3223,68 @@ Set Experimental Feature Command
> > >> >                                 Invalid Index
> > >> >
> > >> >
> > >> > +Load Default Controller Parameter Command
> > >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > >> > +
> > >> > +       Command Code:           0x004b
> > >> > +       Controller Index:       <controller id>
> > >> > +       Command Parameters:     Parameter_Count (2 Octets)
> > >> > +                               Parameter1 {
> > >> > +                                       Parameter_Type (2 Octet)
> > >> > +                                       Value_Length (1 Octet)
> > >> > +                                       Value (0-255 Octets)
> > >> > +                               }
> > >> > +                               Parameter2 { }
> > >> > +                               ...
> > >> > +       Return Parameters:
> > >> > +
> > >> > +       This command is used to feed the kernel a list of default =
controller
> > >> > +       parameters.
> > >> > +
> > >> > +       Currently defined Parameter_Type values are:
> > >> > +
> > >> > +               0x0000  BR/EDR Page Scan Type
> > >> > +               0x0001  BR/EDR Page Scan Interval
> > >> > +               0x0002  BR/EDR Page Scan Window
> > >> > +               0x0003  BR/EDR Inquiry Scan Type
> > >> > +               0x0004  BR/EDR Inquiry Scan Interval
> > >> > +               0x0005  BR/EDR Inquiry Scan Window
> > >> > +               0x0006  BR/EDR Link Supervision Timeout
> > >> > +               0x0007  BR/EDR Page Timeout
> > >> > +               0x0008  BR/EDR Min Sniff Interval
> > >> > +               0x0009  BR/EDR Max Sniff Interval
> > >> > +               0x000a  LE Advertisement Min Interval
> > >> > +               0x000b  LE Advertisement Max Interval
> > >> > +               0x000c  LE Multi Advertisement Rotation Interval
> > >> > +               0x000d  LE Scanning Interval for auto connect
> > >> > +               0x000e  LE Scanning Window for auto connect
> > >> > +               0x000f  LE Scanning Interval for HID only
> > >> > +               0x0010  LE Scanning Window for HID only
> > >>
> > >> I remember commenting that we don't have profile information on the
> > >> kernel so Im not sure how you are planning to detect the when the
> > >> device is HID or not?
> > >
> > > I expect we'll need to add an Add Device flag to carry that informati=
on down into the kernel.  The hid profile already sends an op, so it's rela=
tively trivial to carry that information in so we can apply specific scanni=
ng requirements for that case (which are less aggressive and therefore have=
 less of an impact to Wifi and BT performance).
> >
> > Well if we will need to feed that information of the profile type we
> > might as well just feed the intervals directly, that way any profile
> > that needs some different parameters than the default can all use the
> > same command and we don't have to grow this list when a new profile
> > want to use different parameters.
> >
> That might be another option indeed.  I wonder how far you'd want to
> take this to have the profile provide all the values.  At some point,
> you'd need some logic that would pick the value that meets all the
> profile requirements so if one wants w:100, i:200 and another wants
> w:200: i400, you may need to scan at 100% to meet the requirements of
> all profiles...  I think that with the current proposal, while less
> flexible, may avoid this complexity/condition..

Not sure I follow you here, what I had in mind was that the profile
provides its own settings for scanning but perhaps you are saying that
in case there are multiple profiles involved we would have to
aggregate the parameters, well that has to be done either way even if
we use simple types, in which case there can be multiple defaults (one
for each profile) that the kernel must aggregate or we do aggregate
them at userspace and just provide the end result. In the end I guess
this means that the connect scanning parameters should probably be per
device rather than a using a globals with per profile exceptions, much
like connection parameters are per device as well.

> > >>
> > >>
> > >> > +               0x0012  LE Scanning Interval for wake scenarios
> > >> > +               0x0013  LE Scanning Window for wake scenarios
> > >> > +               0x0014  LE Scanning Interval for discovery
> > >> > +               0x0015  LE Scanning Window for discovery
> > >> > +               0x0016  LE Scanning Interval for adv monitoring
> > >> > +               0x0017  LE Scanning Window for adv monitoring
> > >> > +               0x0018  LE Scanning Interval for connect
> > >> > +               0x0019  LE Scanning Window for connect
> > >> > +               0x001a  LE Min Connection Interval
> > >> > +               0x001b  LE Max Connection Interval
> > >> > +               0x001c  LE Connection Connection Latency
> > >> > +               0x001d  LE Connection Supervision Timeout
> > >> > +
> > >> > +       This command can be used when the controller is not powere=
d and
> > >> > +       all settings will be programmed once powered.  Note that t=
hese only
> > >> > +       control the default parameters.  Higher level Apis may inf=
luence the
> > >> > +       effective value used.
> > >> > +
> > >> > +       This command generates a Command Complete event on success=
 or
> > >> > +       a Command Status event on failure.
> > >> > +
> > >> > +       Possible errors:        Invalid Parameters
> > >> > +                               Invalid Index
> > >> > +
> > >> > +
> > >> >  Command Complete Event
> > >> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > >> >
> > >> > --
> > >> > 2.26.2.761.g0e0b3e54be-goog
> > >> >
> > >>
> > >>
> > >> --
> > >> Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
