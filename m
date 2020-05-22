Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36165C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1DCB207D8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iilgCA/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgEVAOZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 20:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbgEVAOY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 20:14:24 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92DFC061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 17:14:24 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r25so7853084oij.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 17:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0lwPSEq+cjIFM6vVa/s2uTe29mR0BsE8+j8tJqJVRUE=;
        b=iilgCA/Ioaayg/9r4w6+54PFwBCeFs4hwo2xC73652g44KZLKbi6Ezb7o12qEHNL1G
         1Kpxf6DZBfUqvrKQB3t/zqwmpR5P2EI37G9o7cYKfQz+smKhmLd/5chTWsUcE4aUhx0T
         NdbfsrHLh2pPSKcEtKB6Zkeu6RatD8k6oku3S+36IVZ4XIKKFgPGW/idovxz1VX6hM5P
         SpE80d/+r0DZLj8PMn6LdcNnOyPA3pTvS/NjZFAgJhVyEjzU6u4BjIOUZKBgy+XaIlGx
         6NLUfveXs1Fd08kSGPR3tsjArQ3JermrjCYwRwQTd7sR5s2GNc+RC48wwphkncdbtsjG
         SjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0lwPSEq+cjIFM6vVa/s2uTe29mR0BsE8+j8tJqJVRUE=;
        b=fg0JYvtp9qgIENIluY/jcLiwjBl18ZYuFejGkNdti7OOSRXYYxvFf2pD7WwidfD/YI
         0nn3tm6YTt9Zg1/ayEdxcYb6LN++16vvZFyAlvPPNe/JT9eyXF4/FhT2r9eoa3FFwxw4
         a2nK2dKESwCnx8ghpq93VSn68UVqXqK1co7p3H+8+NHMPcnenu1/TjvTbrid2Eff7VMY
         Ij7EZIUvfOSVUb6muCVVF3WjckRFf6+QSrB1iXNlOzubLXHNvl6aKPErV9wBEz9zlD5l
         SA9KGu/NOwIioorq5qNHI/wfBh9OVLsKu04wI6gXSSJ9d09NqPlUj18U+BziidmkojIp
         ty5Q==
X-Gm-Message-State: AOAM5332jO9siHI5YgpGU5tTQkeT+93DG5FgKxMmpgPGSlaphrLxeyr1
        6wmzMqc7u0JH2zL5uCMpkTsFu+aStW+XFwFCF5Y=
X-Google-Smtp-Source: ABdhPJz7SENvpwMKRXG8J/Z9xXya2LKG3ewCr/BURdavG0Iz4zrUsKVl7uPhuI8G+MQkfxdhF/I0zojf/8aBMVCyvCc=
X-Received: by 2002:aca:6747:: with SMTP id b7mr892665oiy.110.1590106463787;
 Thu, 21 May 2020 17:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200521145757.245774-1-alainm@chromium.org> <CABBYNZKU4JVHxL5NEaMFgf6-aAOrG4re=T0Yat9b=viz57PcsQ@mail.gmail.com>
 <CALWDO_UQhU5QxZ1eRNWZtAtkcghWEBM5eVeujxhROSr7PG_P=w@mail.gmail.com>
 <CABBYNZ+8ed4qXarr647Q2SKkvqdT3N5AccP4L5a35e--9ybzgg@mail.gmail.com>
 <CALWDO_WT1DmS02jSJSa8GyiPwFz7cEnOjqhXMJsDO=6=MjyGyw@mail.gmail.com>
 <CABBYNZJzSaEvFTt6b6vuEoM3Eof225=bszVvM0ZtyJ0NsqVdGg@mail.gmail.com> <CALWDO_XX-xKJ4Se6HwfyroD9uQHj32xf5ZAFkEEA_QjV5MsVNg@mail.gmail.com>
In-Reply-To: <CALWDO_XX-xKJ4Se6HwfyroD9uQHj32xf5ZAFkEEA_QjV5MsVNg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 May 2020 17:14:11 -0700
Message-ID: <CABBYNZ+-29UPnXy8Z_w4VyripQAKzXmZ_Vy-8LZB91ZSmQ7WEQ@mail.gmail.com>
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

On Thu, May 21, 2020 at 4:44 PM Alain Michaud <alainmichaud@google.com> wro=
te:
>
> Hi Luiz
>
> On Thu., May 21, 2020, 7:19 p.m. Luiz Augusto von Dentz, <luiz.dentz@gmai=
l.com> wrote:
>>
>> Hi Alain,
>>
>> On Thu, May 21, 2020 at 3:28 PM Alain Michaud <alainmichaud@google.com> =
wrote:
>> >
>> > Hi Luiz
>> >
>> >
>> > On Thu, May 21, 2020 at 6:05 PM Luiz Augusto von Dentz
>> > <luiz.dentz@gmail.com> wrote:
>> > >
>> > > Hi Alain,
>> > >
>> > > On Thu, May 21, 2020 at 1:12 PM Alain Michaud <alainmichaud@google.c=
om> wrote:
>> > > >
>> > > > Hi Luiz,
>> > > >
>> > > >
>> > > > On Thu, May 21, 2020 at 12:26 PM Luiz Augusto von Dentz <luiz.dent=
z@gmail.com> wrote:
>> > > >>
>> > > >> Hi Alain,
>> > > >>
>> > > >> On Thu, May 21, 2020 at 8:05 AM Alain Michaud <alainm@chromium.or=
g> wrote:
>> > > >> >
>> > > >> > This change adds the definition for the load default parameter =
command.
>> > > >> > In particular, this command is used to load default parameters =
for
>> > > >> > various operations in the kernel. This mechanism is also expand=
able to
>> > > >> > future values that may be necessary.
>> > > >> >
>> > > >> > This will allow bluetoothd to load parameters from a conf file =
that may
>> > > >> > be customized for the specific requirements of each platforms.
>> > > >> >
>> > > >> > ---
>> > > >> > rebase against current master
>> > > >> >
>> > > >> >  doc/mgmt-api.txt | 62 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>> > > >> >  1 file changed, 62 insertions(+)
>> > > >> >
>> > > >> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> > > >> > index 6ee01fed8..c6575e654 100644
>> > > >> > --- a/doc/mgmt-api.txt
>> > > >> > +++ b/doc/mgmt-api.txt
>> > > >> > @@ -3223,6 +3223,68 @@ Set Experimental Feature Command
>> > > >> >                                 Invalid Index
>> > > >> >
>> > > >> >
>> > > >> > +Load Default Controller Parameter Command
>> > > >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > >> > +
>> > > >> > +       Command Code:           0x004b
>> > > >> > +       Controller Index:       <controller id>
>> > > >> > +       Command Parameters:     Parameter_Count (2 Octets)
>> > > >> > +                               Parameter1 {
>> > > >> > +                                       Parameter_Type (2 Octet=
)
>> > > >> > +                                       Value_Length (1 Octet)
>> > > >> > +                                       Value (0-255 Octets)
>> > > >> > +                               }
>> > > >> > +                               Parameter2 { }
>> > > >> > +                               ...
>> > > >> > +       Return Parameters:
>> > > >> > +
>> > > >> > +       This command is used to feed the kernel a list of defau=
lt controller
>> > > >> > +       parameters.
>> > > >> > +
>> > > >> > +       Currently defined Parameter_Type values are:
>> > > >> > +
>> > > >> > +               0x0000  BR/EDR Page Scan Type
>> > > >> > +               0x0001  BR/EDR Page Scan Interval
>> > > >> > +               0x0002  BR/EDR Page Scan Window
>> > > >> > +               0x0003  BR/EDR Inquiry Scan Type
>> > > >> > +               0x0004  BR/EDR Inquiry Scan Interval
>> > > >> > +               0x0005  BR/EDR Inquiry Scan Window
>> > > >> > +               0x0006  BR/EDR Link Supervision Timeout
>> > > >> > +               0x0007  BR/EDR Page Timeout
>> > > >> > +               0x0008  BR/EDR Min Sniff Interval
>> > > >> > +               0x0009  BR/EDR Max Sniff Interval
>> > > >> > +               0x000a  LE Advertisement Min Interval
>> > > >> > +               0x000b  LE Advertisement Max Interval
>> > > >> > +               0x000c  LE Multi Advertisement Rotation Interva=
l
>> > > >> > +               0x000d  LE Scanning Interval for auto connect
>> > > >> > +               0x000e  LE Scanning Window for auto connect
>> > > >> > +               0x000f  LE Scanning Interval for HID only
>> > > >> > +               0x0010  LE Scanning Window for HID only
>> > > >>
>> > > >> I remember commenting that we don't have profile information on t=
he
>> > > >> kernel so Im not sure how you are planning to detect the when the
>> > > >> device is HID or not?
>> > > >
>> > > > I expect we'll need to add an Add Device flag to carry that inform=
ation down into the kernel.  The hid profile already sends an op, so it's r=
elatively trivial to carry that information in so we can apply specific sca=
nning requirements for that case (which are less aggressive and therefore h=
ave less of an impact to Wifi and BT performance).
>> > >
>> > > Well if we will need to feed that information of the profile type we
>> > > might as well just feed the intervals directly, that way any profile
>> > > that needs some different parameters than the default can all use th=
e
>> > > same command and we don't have to grow this list when a new profile
>> > > want to use different parameters.
>> > >
>> > That might be another option indeed.  I wonder how far you'd want to
>> > take this to have the profile provide all the values.  At some point,
>> > you'd need some logic that would pick the value that meets all the
>> > profile requirements so if one wants w:100, i:200 and another wants
>> > w:200: i400, you may need to scan at 100% to meet the requirements of
>> > all profiles...  I think that with the current proposal, while less
>> > flexible, may avoid this complexity/condition..
>>
>> Not sure I follow you here, what I had in mind was that the profile
>> provides its own settings for scanning but perhaps you are saying that
>> in case there are multiple profiles involved we would have to
>> aggregate the parameters, well that has to be done either way even if
>> we use simple types, in which case there can be multiple defaults (one
>> for each profile) that the kernel must aggregate or we do aggregate
>> them at userspace and just provide the end result. In the end I guess
>> this means that the connect scanning parameters should probably be per
>> device rather than a using a globals with per profile exceptions, much
>> like connection parameters are per device as well.
>
>
> You got the idea. Aggregation would be needed, but with simple types, we =
can have simple logic such as if only hid is added (via the flag, we use th=
e smaller duty cycle provided by the hid parameters defined in this patch),=
 else, we use the passive scanning parameters as we do today. In essence, w=
ith this logic, no aggregation of settings is necessary since it is up to t=
he platform who set the various values via their .conf file.

Well you will need to know when to apply the hid params, so to me it
still seems a per device policy, what Im missing?

> Scan parameters are global, they can't be per connection like the connect=
ion parameters.

Not when you are scanning to connect to specifica device, perhaps you
want to expand on where each scanning parameter set takes place then.

>>
>>
>> > > >>
>> > > >>
>> > > >> > +               0x0012  LE Scanning Interval for wake scenarios
>> > > >> > +               0x0013  LE Scanning Window for wake scenarios
>> > > >> > +               0x0014  LE Scanning Interval for discovery
>> > > >> > +               0x0015  LE Scanning Window for discovery
>> > > >> > +               0x0016  LE Scanning Interval for adv monitoring
>> > > >> > +               0x0017  LE Scanning Window for adv monitoring
>> > > >> > +               0x0018  LE Scanning Interval for connect
>> > > >> > +               0x0019  LE Scanning Window for connect
>> > > >> > +               0x001a  LE Min Connection Interval
>> > > >> > +               0x001b  LE Max Connection Interval
>> > > >> > +               0x001c  LE Connection Connection Latency
>> > > >> > +               0x001d  LE Connection Supervision Timeout
>> > > >> > +
>> > > >> > +       This command can be used when the controller is not pow=
ered and
>> > > >> > +       all settings will be programmed once powered.  Note tha=
t these only
>> > > >> > +       control the default parameters.  Higher level Apis may =
influence the
>> > > >> > +       effective value used.
>> > > >> > +
>> > > >> > +       This command generates a Command Complete event on succ=
ess or
>> > > >> > +       a Command Status event on failure.
>> > > >> > +
>> > > >> > +       Possible errors:        Invalid Parameters
>> > > >> > +                               Invalid Index
>> > > >> > +
>> > > >> > +
>> > > >> >  Command Complete Event
>> > > >> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> > > >> >
>> > > >> > --
>> > > >> > 2.26.2.761.g0e0b3e54be-goog
>> > > >> >
>> > > >>
>> > > >>
>> > > >> --
>> > > >> Luiz Augusto von Dentz
>> > >
>> > >
>> > >
>> > > --
>> > > Luiz Augusto von Dentz
>>
>>
>>
>> --
>> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
