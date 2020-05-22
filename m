Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E53C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 18:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E2E20663
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 18:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk8kZmgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbgEVSEd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 May 2020 14:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbgEVSEc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 May 2020 14:04:32 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E23DC061A0E
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2020 11:04:32 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g25so8856594otp.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2020 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HgdlepUGw+YbJ5xvBRN0hoUxYlLgS4iGvNwAy+KbUkM=;
        b=Zk8kZmgt0BpinkK3Qj+VYyaSO0zOgz9PQr15cnLHcCRbbV8/TcdnQdIp0SGKSfl7Um
         DzSUUO3YAuWeVYvW/CBqERjMtp7oovfVH7/wkMaSfuwSQVKFU9dHfoucp1/QzqvB76lx
         8ithUd84SNstHPXvGZ1EjryHAZGY+2ninmpSsJfqYzzJLjoPlTqKJhSQ4bLYXXfFz+Ax
         DhCAuJxdaVXKGJ/EzRdDWht2c2twPec+J4GubJi76aJYkdTFaKkNEXoOeTgmFzA1ClC4
         fNsV46jRjHuy1sCAma/vmIxehqi3lBMx3GZJLkDZunqjUpY5dp/uv1xhMJybr8TjGx3f
         xrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HgdlepUGw+YbJ5xvBRN0hoUxYlLgS4iGvNwAy+KbUkM=;
        b=ZvXr5OaXw2epKnbhdlI2yALa55zNpJPARdtYfyY/vvC5+ieo/vv9QgrJ8CJwf5v705
         2I8O8Z5WMRrdesZaX0M2RowRVqy0mt2rIHJtkeL6+Dj8bUH2L6ty76kRZSA+I35iKyhB
         caDub9Uo3WX4xvR6N/5T0o1Ib9gkobHQXSjkyIEfxHfNv5KnH1kUqtVqUtA88c1BWRdl
         t5h5pi23QFzFauyUiX116IzAMXDYfsuw/ByHKAgaddVjFntCYg9kh+jHRk4tWxNfN02K
         fxoqK8DQ6QIm2hbPNG+BPr3q2yWtHaH+YK3V2n9IEjqsgbeopgoBjdtIEmWwVlEUC7Sw
         OA+w==
X-Gm-Message-State: AOAM532isuB4wi/q/EfWJj+K2linCpwIpdm7cmTBVDUmHut0/w5O3jCC
        wxKgxAcu4JzP3mFpU8AeX6rMBRUyy6Pp8go1ZDU=
X-Google-Smtp-Source: ABdhPJyPgOFpCAGn+YoXJ0A5mS8KzPXIttGsqYvG3ttPYBOGYVsBFZHXFe4fvWkb/w3wUlxlC6x0uSP09wsY2zBG0Xo=
X-Received: by 2002:a9d:3637:: with SMTP id w52mr10662437otb.177.1590170671784;
 Fri, 22 May 2020 11:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200521145757.245774-1-alainm@chromium.org> <CABBYNZKU4JVHxL5NEaMFgf6-aAOrG4re=T0Yat9b=viz57PcsQ@mail.gmail.com>
 <CALWDO_UQhU5QxZ1eRNWZtAtkcghWEBM5eVeujxhROSr7PG_P=w@mail.gmail.com>
 <CABBYNZ+8ed4qXarr647Q2SKkvqdT3N5AccP4L5a35e--9ybzgg@mail.gmail.com>
 <CALWDO_WT1DmS02jSJSa8GyiPwFz7cEnOjqhXMJsDO=6=MjyGyw@mail.gmail.com>
 <CABBYNZJzSaEvFTt6b6vuEoM3Eof225=bszVvM0ZtyJ0NsqVdGg@mail.gmail.com>
 <CALWDO_XX-xKJ4Se6HwfyroD9uQHj32xf5ZAFkEEA_QjV5MsVNg@mail.gmail.com>
 <CABBYNZ+-29UPnXy8Z_w4VyripQAKzXmZ_Vy-8LZB91ZSmQ7WEQ@mail.gmail.com> <CALWDO_Uhid28nvX5NEngfTa2s76zKpQMK+8sS9Wm2cOf4weHuw@mail.gmail.com>
In-Reply-To: <CALWDO_Uhid28nvX5NEngfTa2s76zKpQMK+8sS9Wm2cOf4weHuw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 22 May 2020 11:04:11 -0700
Message-ID: <CABBYNZ+mwpxtt6SogcsUE3nNjj7cfLyH6TBnGcctir6gy6VKYg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3] doc:adding definitions for load default params
 mgmt op
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Thu, May 21, 2020 at 6:04 PM Alain Michaud <alainmichaud@google.com> wro=
te:
>
>
>
> On Thu., May 21, 2020, 8:14 p.m. Luiz Augusto von Dentz, <luiz.dentz@gmai=
l.com> wrote:
>>
>> Hi Alain,
>>
>> On Thu, May 21, 2020 at 4:44 PM Alain Michaud <alainmichaud@google.com> =
wrote:
>> >
>> > Hi Luiz
>> >
>> > On Thu., May 21, 2020, 7:19 p.m. Luiz Augusto von Dentz, <luiz.dentz@g=
mail.com> wrote:
>> >>
>> >> Hi Alain,
>> >>
>> >> On Thu, May 21, 2020 at 3:28 PM Alain Michaud <alainmichaud@google.co=
m> wrote:
>> >> >
>> >> > Hi Luiz
>> >> >
>> >> >
>> >> > On Thu, May 21, 2020 at 6:05 PM Luiz Augusto von Dentz
>> >> > <luiz.dentz@gmail.com> wrote:
>> >> > >
>> >> > > Hi Alain,
>> >> > >
>> >> > > On Thu, May 21, 2020 at 1:12 PM Alain Michaud <alainmichaud@googl=
e.com> wrote:
>> >> > > >
>> >> > > > Hi Luiz,
>> >> > > >
>> >> > > >
>> >> > > > On Thu, May 21, 2020 at 12:26 PM Luiz Augusto von Dentz <luiz.d=
entz@gmail.com> wrote:
>> >> > > >>
>> >> > > >> Hi Alain,
>> >> > > >>
>> >> > > >> On Thu, May 21, 2020 at 8:05 AM Alain Michaud <alainm@chromium=
.org> wrote:
>> >> > > >> >
>> >> > > >> > This change adds the definition for the load default paramet=
er command.
>> >> > > >> > In particular, this command is used to load default paramete=
rs for
>> >> > > >> > various operations in the kernel. This mechanism is also exp=
andable to
>> >> > > >> > future values that may be necessary.
>> >> > > >> >
>> >> > > >> > This will allow bluetoothd to load parameters from a conf fi=
le that may
>> >> > > >> > be customized for the specific requirements of each platform=
s.
>> >> > > >> >
>> >> > > >> > ---
>> >> > > >> > rebase against current master
>> >> > > >> >
>> >> > > >> >  doc/mgmt-api.txt | 62 +++++++++++++++++++++++++++++++++++++=
+++++++++++
>> >> > > >> >  1 file changed, 62 insertions(+)
>> >> > > >> >
>> >> > > >> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> >> > > >> > index 6ee01fed8..c6575e654 100644
>> >> > > >> > --- a/doc/mgmt-api.txt
>> >> > > >> > +++ b/doc/mgmt-api.txt
>> >> > > >> > @@ -3223,6 +3223,68 @@ Set Experimental Feature Command
>> >> > > >> >                                 Invalid Index
>> >> > > >> >
>> >> > > >> >
>> >> > > >> > +Load Default Controller Parameter Command
>> >> > > >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> > > >> > +
>> >> > > >> > +       Command Code:           0x004b
>> >> > > >> > +       Controller Index:       <controller id>
>> >> > > >> > +       Command Parameters:     Parameter_Count (2 Octets)
>> >> > > >> > +                               Parameter1 {
>> >> > > >> > +                                       Parameter_Type (2 Oc=
tet)
>> >> > > >> > +                                       Value_Length (1 Octe=
t)
>> >> > > >> > +                                       Value (0-255 Octets)
>> >> > > >> > +                               }
>> >> > > >> > +                               Parameter2 { }
>> >> > > >> > +                               ...
>> >> > > >> > +       Return Parameters:
>> >> > > >> > +
>> >> > > >> > +       This command is used to feed the kernel a list of de=
fault controller
>> >> > > >> > +       parameters.
>> >> > > >> > +
>> >> > > >> > +       Currently defined Parameter_Type values are:
>> >> > > >> > +
>> >> > > >> > +               0x0000  BR/EDR Page Scan Type
>> >> > > >> > +               0x0001  BR/EDR Page Scan Interval
>> >> > > >> > +               0x0002  BR/EDR Page Scan Window
>> >> > > >> > +               0x0003  BR/EDR Inquiry Scan Type
>> >> > > >> > +               0x0004  BR/EDR Inquiry Scan Interval
>> >> > > >> > +               0x0005  BR/EDR Inquiry Scan Window
>> >> > > >> > +               0x0006  BR/EDR Link Supervision Timeout
>> >> > > >> > +               0x0007  BR/EDR Page Timeout
>> >> > > >> > +               0x0008  BR/EDR Min Sniff Interval
>> >> > > >> > +               0x0009  BR/EDR Max Sniff Interval
>> >> > > >> > +               0x000a  LE Advertisement Min Interval
>> >> > > >> > +               0x000b  LE Advertisement Max Interval
>> >> > > >> > +               0x000c  LE Multi Advertisement Rotation Inte=
rval
>> >> > > >> > +               0x000d  LE Scanning Interval for auto connec=
t
>> >> > > >> > +               0x000e  LE Scanning Window for auto connect
>> >> > > >> > +               0x000f  LE Scanning Interval for HID only
>> >> > > >> > +               0x0010  LE Scanning Window for HID only
>> >> > > >>
>> >> > > >> I remember commenting that we don't have profile information o=
n the
>> >> > > >> kernel so Im not sure how you are planning to detect the when =
the
>> >> > > >> device is HID or not?
>> >> > > >
>> >> > > > I expect we'll need to add an Add Device flag to carry that inf=
ormation down into the kernel.  The hid profile already sends an op, so it'=
s relatively trivial to carry that information in so we can apply specific =
scanning requirements for that case (which are less aggressive and therefor=
e have less of an impact to Wifi and BT performance).
>> >> > >
>> >> > > Well if we will need to feed that information of the profile type=
 we
>> >> > > might as well just feed the intervals directly, that way any prof=
ile
>> >> > > that needs some different parameters than the default can all use=
 the
>> >> > > same command and we don't have to grow this list when a new profi=
le
>> >> > > want to use different parameters.
>> >> > >
>> >> > That might be another option indeed.  I wonder how far you'd want t=
o
>> >> > take this to have the profile provide all the values.  At some poin=
t,
>> >> > you'd need some logic that would pick the value that meets all the
>> >> > profile requirements so if one wants w:100, i:200 and another wants
>> >> > w:200: i400, you may need to scan at 100% to meet the requirements =
of
>> >> > all profiles...  I think that with the current proposal, while less
>> >> > flexible, may avoid this complexity/condition..
>> >>
>> >> Not sure I follow you here, what I had in mind was that the profile
>> >> provides its own settings for scanning but perhaps you are saying tha=
t
>> >> in case there are multiple profiles involved we would have to
>> >> aggregate the parameters, well that has to be done either way even if
>> >> we use simple types, in which case there can be multiple defaults (on=
e
>> >> for each profile) that the kernel must aggregate or we do aggregate
>> >> them at userspace and just provide the end result. In the end I guess
>> >> this means that the connect scanning parameters should probably be pe=
r
>> >> device rather than a using a globals with per profile exceptions, muc=
h
>> >> like connection parameters are per device as well.
>> >
>> >
>> > You got the idea. Aggregation would be needed, but with simple types, =
we can have simple logic such as if only hid is added (via the flag, we use=
 the smaller duty cycle provided by the hid parameters defined in this patc=
h), else, we use the passive scanning parameters as we do today. In essence=
, with this logic, no aggregation of settings is necessary since it is up t=
o the platform who set the various values via their .conf file.
>>
>> Well you will need to know when to apply the hid params, so to me it
>> still seems a per device policy, what Im missing?
>
> It's effectively passive scanning based on what requested it.
>>
>>
>> > Scan parameters are global, they can't be per connection like the conn=
ection parameters.
>>
>> Not when you are scanning to connect to specifica device, perhaps you
>> want to expand on where each scanning parameter set takes place then.
>
>
> Today, it's all passive scanning. This would introduce the concept of hid=
 only passive scanning where we can have a lower scanning duty cycle and sa=
ve bandwidth and power.

So the intend is to switch passive scanning 'modes', perhaps Im
missing an API or policy to do that, or is the indend to do this
automagically? It is a little bit hard to follow given that a system
can have many different peripherals, each with different scanning
requirements, or the idea is to apply HID mode only if there are HID
devices paired?

>>
>> >>
>> >>
>> >> > > >>
>> >> > > >>
>> >> > > >> > +               0x0012  LE Scanning Interval for wake scenar=
ios
>> >> > > >> > +               0x0013  LE Scanning Window for wake scenario=
s
>> >> > > >> > +               0x0014  LE Scanning Interval for discovery
>> >> > > >> > +               0x0015  LE Scanning Window for discovery
>> >> > > >> > +               0x0016  LE Scanning Interval for adv monitor=
ing
>> >> > > >> > +               0x0017  LE Scanning Window for adv monitorin=
g
>> >> > > >> > +               0x0018  LE Scanning Interval for connect
>> >> > > >> > +               0x0019  LE Scanning Window for connect
>> >> > > >> > +               0x001a  LE Min Connection Interval
>> >> > > >> > +               0x001b  LE Max Connection Interval
>> >> > > >> > +               0x001c  LE Connection Connection Latency
>> >> > > >> > +               0x001d  LE Connection Supervision Timeout
>> >> > > >> > +
>> >> > > >> > +       This command can be used when the controller is not =
powered and
>> >> > > >> > +       all settings will be programmed once powered.  Note =
that these only
>> >> > > >> > +       control the default parameters.  Higher level Apis m=
ay influence the
>> >> > > >> > +       effective value used.
>> >> > > >> > +
>> >> > > >> > +       This command generates a Command Complete event on s=
uccess or
>> >> > > >> > +       a Command Status event on failure.
>> >> > > >> > +
>> >> > > >> > +       Possible errors:        Invalid Parameters
>> >> > > >> > +                               Invalid Index
>> >> > > >> > +
>> >> > > >> > +
>> >> > > >> >  Command Complete Event
>> >> > > >> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>> >> > > >> >
>> >> > > >> > --
>> >> > > >> > 2.26.2.761.g0e0b3e54be-goog
>> >> > > >> >
>> >> > > >>
>> >> > > >>
>> >> > > >> --
>> >> > > >> Luiz Augusto von Dentz
>> >> > >
>> >> > >
>> >> > >
>> >> > > --
>> >> > > Luiz Augusto von Dentz
>> >>
>> >>
>> >>
>> >> --
>> >> Luiz Augusto von Dentz
>>
>>
>>
>> --
>> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
