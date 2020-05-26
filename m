Return-Path: <SRS0=5fy2=7I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B5CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 13:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 081E12084C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 13:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ksJFfLRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgEZNrh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 May 2020 09:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgEZNrh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 May 2020 09:47:37 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85D2C03E96D
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 06:47:35 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a25so12927525ljp.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dKJoU8u1mzuDW+Vh82xOkiZ4PemHn2UzypFNlRg4Abo=;
        b=ksJFfLRv2mlKElX++E1zUy4yWg2wFWTV8OUlQ/ekOsZ+kZJU8iQr0ICU8SN3OwbPf9
         h7+tIlPQRZxT/r3e/I6mNjd8vWSsXaga3PS9DxcuhaEYsVsLNSmHIm0f2+gjBrrz5QDm
         5uq2CFjL+DzwwGMXQDTyNXSau47hs7Extf9Ah96+CBgeKZUQLrKtn+Th8fX1jN6ZxvZr
         EioTNhOzix+5mut0dU9mGFwfy0339Slq+TwiFL9/Dbmh65OmCWIAwqDWssyJv+XJamY1
         vs9bw0VDoz+1Qd0+UBeeO9ftMVHLHXSscJRG6eOyip2tg3hsFHwZCa9tbFaTrMMPqxuX
         l+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dKJoU8u1mzuDW+Vh82xOkiZ4PemHn2UzypFNlRg4Abo=;
        b=TV8rR73OoMW0Bdd0kLjXNxV9Yaface9Ry2ku74JJCq/zGU9/v1/J4Z/ATt40TF7hIr
         MY7AlDFnUvQCMqA1+Gz/nSRXMqcIMieypOWPATgb43C+cferyPDdftuXWZngFSY8kpQ/
         0Pxdk6d0cy5oj+2CrK7SEAiOB+I5T4RLgAJ7jiH3pA8b+cyYHwqlEWjroQViQkekQZm+
         TNZxYJHgS4IUdAgo8jjD+UiR52KnU1dj5TRR6es+6lJ4ttlURISCSr4yui0iQf/uiYyT
         m7pYi8wdxXn/zf/+Jfbn9+h7vq0I3nR2kl1Ug5VelaONR8zR8ACzv3m3mMb7RO8V/TSS
         AOoA==
X-Gm-Message-State: AOAM530tkgdkS1Brwsphc6J/VuJejoiPmzpTz0VadAOcyokzkuNYrtlY
        oR4EfWp4qAT5frcsvr6frCYnh21890wMfrrECKtVeQ==
X-Google-Smtp-Source: ABdhPJwwmqOw1enLppibQBWMmra4SHucJh4MBrquv2Uzl4POJh8F8gCip36zTZ6fP5I/xoLJeSmbBrvA6y+ammf0Efk=
X-Received: by 2002:a2e:a209:: with SMTP id h9mr641934ljm.39.1590500854002;
 Tue, 26 May 2020 06:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200521145757.245774-1-alainm@chromium.org> <CABBYNZKU4JVHxL5NEaMFgf6-aAOrG4re=T0Yat9b=viz57PcsQ@mail.gmail.com>
 <CALWDO_UQhU5QxZ1eRNWZtAtkcghWEBM5eVeujxhROSr7PG_P=w@mail.gmail.com>
 <CABBYNZ+8ed4qXarr647Q2SKkvqdT3N5AccP4L5a35e--9ybzgg@mail.gmail.com>
 <CALWDO_WT1DmS02jSJSa8GyiPwFz7cEnOjqhXMJsDO=6=MjyGyw@mail.gmail.com>
 <CABBYNZJzSaEvFTt6b6vuEoM3Eof225=bszVvM0ZtyJ0NsqVdGg@mail.gmail.com>
 <CALWDO_XX-xKJ4Se6HwfyroD9uQHj32xf5ZAFkEEA_QjV5MsVNg@mail.gmail.com>
 <CABBYNZ+-29UPnXy8Z_w4VyripQAKzXmZ_Vy-8LZB91ZSmQ7WEQ@mail.gmail.com>
 <CALWDO_Uhid28nvX5NEngfTa2s76zKpQMK+8sS9Wm2cOf4weHuw@mail.gmail.com>
 <CABBYNZ+mwpxtt6SogcsUE3nNjj7cfLyH6TBnGcctir6gy6VKYg@mail.gmail.com> <CALWDO_XiuiB6viANARXZ9hhSKkfW+stwwr44pMJbTBOUzxUDew@mail.gmail.com>
In-Reply-To: <CALWDO_XiuiB6viANARXZ9hhSKkfW+stwwr44pMJbTBOUzxUDew@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 26 May 2020 09:47:22 -0400
Message-ID: <CALWDO_VO3ea01OF0B_SSdMs2WGGcyW8YoZUhSV6JX_tKyK5jPg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3] doc:adding definitions for load default params
 mgmt op
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz, Marcel.

Would you feel more comfortable if I remove the HID only mode
reference from this for now until it is officially introduced in the
kernel?

I'd like to make progress on the rest in the meantime.

Thanks,
Alain


On Fri, May 22, 2020 at 8:47 PM Alain Michaud <alainmichaud@google.com> wro=
te:
>
> Hi Luiz,
>
> On Fri., May 22, 2020, 2:04 p.m. Luiz Augusto von Dentz, <luiz.dentz@gmai=
l.com> wrote:
>>
>> Hi Alain,
>>
>> On Thu, May 21, 2020 at 6:04 PM Alain Michaud <alainmichaud@google.com> =
wrote:
>> >
>> >
>> >
>> > On Thu., May 21, 2020, 8:14 p.m. Luiz Augusto von Dentz, <luiz.dentz@g=
mail.com> wrote:
>> >>
>> >> Hi Alain,
>> >>
>> >> On Thu, May 21, 2020 at 4:44 PM Alain Michaud <alainmichaud@google.co=
m> wrote:
>> >> >
>> >> > Hi Luiz
>> >> >
>> >> > On Thu., May 21, 2020, 7:19 p.m. Luiz Augusto von Dentz, <luiz.dent=
z@gmail.com> wrote:
>> >> >>
>> >> >> Hi Alain,
>> >> >>
>> >> >> On Thu, May 21, 2020 at 3:28 PM Alain Michaud <alainmichaud@google=
.com> wrote:
>> >> >> >
>> >> >> > Hi Luiz
>> >> >> >
>> >> >> >
>> >> >> > On Thu, May 21, 2020 at 6:05 PM Luiz Augusto von Dentz
>> >> >> > <luiz.dentz@gmail.com> wrote:
>> >> >> > >
>> >> >> > > Hi Alain,
>> >> >> > >
>> >> >> > > On Thu, May 21, 2020 at 1:12 PM Alain Michaud <alainmichaud@go=
ogle.com> wrote:
>> >> >> > > >
>> >> >> > > > Hi Luiz,
>> >> >> > > >
>> >> >> > > >
>> >> >> > > > On Thu, May 21, 2020 at 12:26 PM Luiz Augusto von Dentz <lui=
z.dentz@gmail.com> wrote:
>> >> >> > > >>
>> >> >> > > >> Hi Alain,
>> >> >> > > >>
>> >> >> > > >> On Thu, May 21, 2020 at 8:05 AM Alain Michaud <alainm@chrom=
ium.org> wrote:
>> >> >> > > >> >
>> >> >> > > >> > This change adds the definition for the load default para=
meter command.
>> >> >> > > >> > In particular, this command is used to load default param=
eters for
>> >> >> > > >> > various operations in the kernel. This mechanism is also =
expandable to
>> >> >> > > >> > future values that may be necessary.
>> >> >> > > >> >
>> >> >> > > >> > This will allow bluetoothd to load parameters from a conf=
 file that may
>> >> >> > > >> > be customized for the specific requirements of each platf=
orms.
>> >> >> > > >> >
>> >> >> > > >> > ---
>> >> >> > > >> > rebase against current master
>> >> >> > > >> >
>> >> >> > > >> >  doc/mgmt-api.txt | 62 ++++++++++++++++++++++++++++++++++=
++++++++++++++
>> >> >> > > >> >  1 file changed, 62 insertions(+)
>> >> >> > > >> >
>> >> >> > > >> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> >> >> > > >> > index 6ee01fed8..c6575e654 100644
>> >> >> > > >> > --- a/doc/mgmt-api.txt
>> >> >> > > >> > +++ b/doc/mgmt-api.txt
>> >> >> > > >> > @@ -3223,6 +3223,68 @@ Set Experimental Feature Command
>> >> >> > > >> >                                 Invalid Index
>> >> >> > > >> >
>> >> >> > > >> >
>> >> >> > > >> > +Load Default Controller Parameter Command
>> >> >> > > >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> >> > > >> > +
>> >> >> > > >> > +       Command Code:           0x004b
>> >> >> > > >> > +       Controller Index:       <controller id>
>> >> >> > > >> > +       Command Parameters:     Parameter_Count (2 Octets=
)
>> >> >> > > >> > +                               Parameter1 {
>> >> >> > > >> > +                                       Parameter_Type (2=
 Octet)
>> >> >> > > >> > +                                       Value_Length (1 O=
ctet)
>> >> >> > > >> > +                                       Value (0-255 Octe=
ts)
>> >> >> > > >> > +                               }
>> >> >> > > >> > +                               Parameter2 { }
>> >> >> > > >> > +                               ...
>> >> >> > > >> > +       Return Parameters:
>> >> >> > > >> > +
>> >> >> > > >> > +       This command is used to feed the kernel a list of=
 default controller
>> >> >> > > >> > +       parameters.
>> >> >> > > >> > +
>> >> >> > > >> > +       Currently defined Parameter_Type values are:
>> >> >> > > >> > +
>> >> >> > > >> > +               0x0000  BR/EDR Page Scan Type
>> >> >> > > >> > +               0x0001  BR/EDR Page Scan Interval
>> >> >> > > >> > +               0x0002  BR/EDR Page Scan Window
>> >> >> > > >> > +               0x0003  BR/EDR Inquiry Scan Type
>> >> >> > > >> > +               0x0004  BR/EDR Inquiry Scan Interval
>> >> >> > > >> > +               0x0005  BR/EDR Inquiry Scan Window
>> >> >> > > >> > +               0x0006  BR/EDR Link Supervision Timeout
>> >> >> > > >> > +               0x0007  BR/EDR Page Timeout
>> >> >> > > >> > +               0x0008  BR/EDR Min Sniff Interval
>> >> >> > > >> > +               0x0009  BR/EDR Max Sniff Interval
>> >> >> > > >> > +               0x000a  LE Advertisement Min Interval
>> >> >> > > >> > +               0x000b  LE Advertisement Max Interval
>> >> >> > > >> > +               0x000c  LE Multi Advertisement Rotation I=
nterval
>> >> >> > > >> > +               0x000d  LE Scanning Interval for auto con=
nect
>> >> >> > > >> > +               0x000e  LE Scanning Window for auto conne=
ct
>> >> >> > > >> > +               0x000f  LE Scanning Interval for HID only
>> >> >> > > >> > +               0x0010  LE Scanning Window for HID only
>> >> >> > > >>
>> >> >> > > >> I remember commenting that we don't have profile informatio=
n on the
>> >> >> > > >> kernel so Im not sure how you are planning to detect the wh=
en the
>> >> >> > > >> device is HID or not?
>> >> >> > > >
>> >> >> > > > I expect we'll need to add an Add Device flag to carry that =
information down into the kernel.  The hid profile already sends an op, so =
it's relatively trivial to carry that information in so we can apply specif=
ic scanning requirements for that case (which are less aggressive and there=
fore have less of an impact to Wifi and BT performance).
>> >> >> > >
>> >> >> > > Well if we will need to feed that information of the profile t=
ype we
>> >> >> > > might as well just feed the intervals directly, that way any p=
rofile
>> >> >> > > that needs some different parameters than the default can all =
use the
>> >> >> > > same command and we don't have to grow this list when a new pr=
ofile
>> >> >> > > want to use different parameters.
>> >> >> > >
>> >> >> > That might be another option indeed.  I wonder how far you'd wan=
t to
>> >> >> > take this to have the profile provide all the values.  At some p=
oint,
>> >> >> > you'd need some logic that would pick the value that meets all t=
he
>> >> >> > profile requirements so if one wants w:100, i:200 and another wa=
nts
>> >> >> > w:200: i400, you may need to scan at 100% to meet the requiremen=
ts of
>> >> >> > all profiles...  I think that with the current proposal, while l=
ess
>> >> >> > flexible, may avoid this complexity/condition..
>> >> >>
>> >> >> Not sure I follow you here, what I had in mind was that the profil=
e
>> >> >> provides its own settings for scanning but perhaps you are saying =
that
>> >> >> in case there are multiple profiles involved we would have to
>> >> >> aggregate the parameters, well that has to be done either way even=
 if
>> >> >> we use simple types, in which case there can be multiple defaults =
(one
>> >> >> for each profile) that the kernel must aggregate or we do aggregat=
e
>> >> >> them at userspace and just provide the end result. In the end I gu=
ess
>> >> >> this means that the connect scanning parameters should probably be=
 per
>> >> >> device rather than a using a globals with per profile exceptions, =
much
>> >> >> like connection parameters are per device as well.
>> >> >
>> >> >
>> >> > You got the idea. Aggregation would be needed, but with simple type=
s, we can have simple logic such as if only hid is added (via the flag, we =
use the smaller duty cycle provided by the hid parameters defined in this p=
atch), else, we use the passive scanning parameters as we do today. In esse=
nce, with this logic, no aggregation of settings is necessary since it is u=
p to the platform who set the various values via their .conf file.
>> >>
>> >> Well you will need to know when to apply the hid params, so to me it
>> >> still seems a per device policy, what Im missing?
>> >
>> > It's effectively passive scanning based on what requested it.
>> >>
>> >>
>> >> > Scan parameters are global, they can't be per connection like the c=
onnection parameters.
>> >>
>> >> Not when you are scanning to connect to specifica device, perhaps you
>> >> want to expand on where each scanning parameter set takes place then.
>> >
>> >
>> > Today, it's all passive scanning. This would introduce the concept of =
hid only passive scanning where we can have a lower scanning duty cycle and=
 save bandwidth and power.
>>
>> So the intend is to switch passive scanning 'modes', perhaps Im
>> missing an API or policy to do that, or is the indend to do this
>> automagically? It is a little bit hard to follow given that a system
>> can have many different peripherals, each with different scanning
>> requirements, or the idea is to apply HID mode only if there are HID
>> devices paired?
>>
>> Yes, the idea is to use a hid only mode if there are only hid devices. N=
ote that there is a precedent for this already (see suspend mode that was r=
ecently added).
>
>
>> >>
>> >> >>
>> >> >>
>> >> >> > > >>
>> >> >> > > >>
>> >> >> > > >> > +               0x0012  LE Scanning Interval for wake sce=
narios
>> >> >> > > >> > +               0x0013  LE Scanning Window for wake scena=
rios
>> >> >> > > >> > +               0x0014  LE Scanning Interval for discover=
y
>> >> >> > > >> > +               0x0015  LE Scanning Window for discovery
>> >> >> > > >> > +               0x0016  LE Scanning Interval for adv moni=
toring
>> >> >> > > >> > +               0x0017  LE Scanning Window for adv monito=
ring
>> >> >> > > >> > +               0x0018  LE Scanning Interval for connect
>> >> >> > > >> > +               0x0019  LE Scanning Window for connect
>> >> >> > > >> > +               0x001a  LE Min Connection Interval
>> >> >> > > >> > +               0x001b  LE Max Connection Interval
>> >> >> > > >> > +               0x001c  LE Connection Connection Latency
>> >> >> > > >> > +               0x001d  LE Connection Supervision Timeout
>> >> >> > > >> > +
>> >> >> > > >> > +       This command can be used when the controller is n=
ot powered and
>> >> >> > > >> > +       all settings will be programmed once powered.  No=
te that these only
>> >> >> > > >> > +       control the default parameters.  Higher level Api=
s may influence the
>> >> >> > > >> > +       effective value used.
>> >> >> > > >> > +
>> >> >> > > >> > +       This command generates a Command Complete event o=
n success or
>> >> >> > > >> > +       a Command Status event on failure.
>> >> >> > > >> > +
>> >> >> > > >> > +       Possible errors:        Invalid Parameters
>> >> >> > > >> > +                               Invalid Index
>> >> >> > > >> > +
>> >> >> > > >> > +
>> >> >> > > >> >  Command Complete Event
>> >> >> > > >> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> >> >> > > >> >
>> >> >> > > >> > --
>> >> >> > > >> > 2.26.2.761.g0e0b3e54be-goog
>> >> >> > > >> >
>> >> >> > > >>
>> >> >> > > >>
>> >> >> > > >> --
>> >> >> > > >> Luiz Augusto von Dentz
>> >> >> > >
>> >> >> > >
>> >> >> > >
>> >> >> > > --
>> >> >> > > Luiz Augusto von Dentz
>> >> >>
>> >> >>
>> >> >>
>> >> >> --
>> >> >> Luiz Augusto von Dentz
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
