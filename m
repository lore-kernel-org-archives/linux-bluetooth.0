Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1B6C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 22:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjE3Wik (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 18:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjE3Wij (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 18:38:39 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1441A93
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 15:38:38 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2af318fa2b8so54218521fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 15:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685486316; x=1688078316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwhXQ1RBSIzXL3f/jXFSri4k4+IDEhMrD0eSonTsAHw=;
        b=rY9nvJit/LDluxFJP2/UWC2YOpjO56Qz6eV461BYGBhR/TWn5M9G+x1YyvRR4JMqGQ
         tTKKWpCIiwWshLdznhEPoKx1D791jIPjKQVe1glhdqJktwQuop6OEzjNaMRlvDl9RK9z
         h9fHF4S+x1ar+g9jz19PmNncBOTTzikT1gMD9DkdVeOVfoHfqaBJEVRtj9bMHLgWD0Wn
         b7E+xasnBBvmOIJGwWBhfaZFYcELSd32tAW3IT/6zz9xI6K3XssfqQ3SdYiR2EIcmTTr
         aN7VhqAF8VvhfgBZx6r/GltEN/xtuNIyiO+1CB9u25edp4TU0kc6uSqTa+v0K/U/UHwu
         xWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685486316; x=1688078316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwhXQ1RBSIzXL3f/jXFSri4k4+IDEhMrD0eSonTsAHw=;
        b=Kz0+GsAqiWBVo2MIm1UpQDxAmLBhzB7c7c3tOoaNOnGuZv0ejDLYRrComQ0M8BaF+M
         wl+aEN3zyXbAjfVhtWkYYFpRA6fo64oBTrn8LAuFkAecGdPqlOFSJ4IwA5RKFDYdnOrP
         Pd5Fs+dwIV4eXIN5GAtSBa0JqKo824Fowx0SCCvfpw9PJ6wHKTAk5h74wbmmnGCCAnR2
         CG+Mv0npWA7sg73kRZeXIBnvwTFWnm1I6eJpjHBwHHqPeiQIvJIdpXj1NB9sN9xqDR4e
         RiD4aRV+Xba8jyCcByBL2fjqxMMHXrMNRzZllp72jwf91hbyC813WK8eXEL+XKylh73X
         YraA==
X-Gm-Message-State: AC+VfDx52JQ+JGFsfgSFLRCL6u+wEvM/7U7Pl+tISmCxM+/oubGrk4TZ
        c/SZKknAv4rvlrb4VpbhqdNr2pyXVtnes1t3X1M=
X-Google-Smtp-Source: ACHHUZ45pknV1/vsol7DyxyfOcyEK2UPibqiIbuPncyGUMyqImD/JYARxCIp/y7H5VAA7mmqPX23ppXI5iyPiz8HOik=
X-Received: by 2002:a2e:720f:0:b0:2ad:8cc6:135a with SMTP id
 n15-20020a2e720f000000b002ad8cc6135amr1587232ljc.33.1685486316016; Tue, 30
 May 2023 15:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230311003826.454858-1-marijn.suijten@somainline.org>
 <20230311003826.454858-2-marijn.suijten@somainline.org> <CABBYNZJimKVz46=6b=B4M9O=FW7hXJZBaRSM50U47oWtxcj0rQ@mail.gmail.com>
 <sh2dylmzfw4whlcru7gxwnaddzc5u7padivf47bllk7mwlfu5b@ebugmc2vjghg>
In-Reply-To: <sh2dylmzfw4whlcru7gxwnaddzc5u7padivf47bllk7mwlfu5b@ebugmc2vjghg>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 May 2023 15:38:23 -0700
Message-ID: <CABBYNZJVZ=obOAwcDhRd1Y877b-aT4itPdiqi2v4-hm9d5YZCw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/3] audio/avrcp: Guard SetAbsoluteVolume without
 target behind config value
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     linux-bluetooth@vger.kernel.org, Yu Liu <yudiliu@google.com>,
        Bartosz Fabianowski <bartosz@fabianowski.eu>,
        Pauli Virtanen <pav@iki.fi>,
        Marek Czerski <ma.czerski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Tue, May 30, 2023 at 3:18=E2=80=AFPM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Hi Luiz,
>
> I'm still clueless why this reply didn't reach my inbox.  I thought it
> was going into ignore-land again (sorry) but randomly found your replies
> on the BlueZ mailing list.  The bot message didn't make it through
> either, but it did notify me about "audio/transport: Propagate errors
> from avrcp_set_volume to DBus" being applied.

Now that you mentioned it, I did receive:

The response from the remote server was:

550 5.7.1 Blocked due to message content - please contact postmaster@seeweb=
.it

So perhaps that is the reason you didn't get any responses for a while.


> On 2023-03-14 16:16:55, Luiz Augusto von Dentz wrote:
> > Hi Marijn,
> >
> > On Fri, Mar 10, 2023 at 4:39=E2=80=AFPM Marijn Suijten
> > <marijn.suijten@somainline.org> wrote:
> > >
> > > Commit 179ccb936 ("avrcp: Set volume if volume changed event is
> > > registered") introduced a catch that allows SetAbsoluteVolume to be s=
ent
> > > to a remote device that does _not_ implement the AVRCP TG profile.  T=
his
> > > is strange as the TG role is required to be able to send commands to =
the
> > > peer, but the commit must have been applied to the tree for a reason.
> > >
> > > We discussed in [1] that workarounds for dubious peers and software
> > > stacks should be guarded behind a config entry in main.conf, so this
> > > starts out by introducing a new [AVRCP] category to to it that will
> > > later be extended with other workarounds.
> > >
> > > [1]: https://marc.info/?l=3Dlinux-bluetooth&m=3D163519566912788&w=3D2
> > > ---
> > >  profiles/audio/avrcp.c | 12 +++++++++---
> > >  src/btd.h              |  5 +++++
> > >  src/main.c             | 13 +++++++++++++
> > >  src/main.conf          |  6 ++++++
> > >  4 files changed, 33 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > > index 80f34c7a7..5e6322916 100644
> > > --- a/profiles/audio/avrcp.c
> > > +++ b/profiles/audio/avrcp.c
> > > @@ -48,6 +48,7 @@
> > >  #include "src/dbus-common.h"
> > >  #include "src/shared/timeout.h"
> > >  #include "src/shared/util.h"
> > > +#include "src/btd.h"
> > >
> > >  #include "avctp.h"
> > >  #include "avrcp.h"
> > > @@ -4577,9 +4578,14 @@ int avrcp_set_volume(struct btd_device *dev, i=
nt8_t volume, bool notify)
> > >                                                                 &volu=
me);
> > >         }
> > >
> > > -       if (!session->controller && !avrcp_event_registered(session,
> > > -                                       AVRCP_EVENT_VOLUME_CHANGED))
> > > -               return -ENOTSUP;
> > > +       if (btd_opts.avrcp.set_absolute_volume_without_target) {
> > > +               if (!session->controller && !avrcp_event_registered(s=
ession,
> > > +                                               AVRCP_EVENT_VOLUME_CH=
ANGED))
> > > +                       return -ENOTSUP;
> > > +       } else {
> > > +               if (!session->controller || session->controller->vers=
ion < 0x0104)
> > > +                       return -ENOTSUP;
> > > +       }
> > >
> > >         memset(buf, 0, sizeof(buf));
> > >
> > > diff --git a/src/btd.h b/src/btd.h
> > > index 42cffcde4..31c04a990 100644
> > > --- a/src/btd.h
> > > +++ b/src/btd.h
> > > @@ -97,6 +97,10 @@ struct btd_avdtp_opts {
> > >         uint8_t  stream_mode;
> > >  };
> > >
> > > +struct btd_avrcp_opts {
> > > +       gboolean set_absolute_volume_without_target;
> > > +};
> > > +
> > >  struct btd_advmon_opts {
> > >         uint8_t         rssi_sampling_period;
> > >  };
> > > @@ -136,6 +140,7 @@ struct btd_opts {
> > >         enum mps_mode_t mps;
> > >
> > >         struct btd_avdtp_opts avdtp;
> > > +       struct btd_avrcp_opts avrcp;
> > >
> > >         uint8_t         key_size;
> > >
> > > diff --git a/src/main.c b/src/main.c
> > > index 99d9c508f..92f74e381 100644
> > > --- a/src/main.c
> > > +++ b/src/main.c
> > > @@ -152,6 +152,11 @@ static const char *avdtp_options[] =3D {
> > >         NULL
> > >  };
> > >
> > > +static const char *avrcp_options[] =3D {
> > > +       "SetAbsoluteVolumeWithoutTarget",
> > > +       NULL
> > > +};
> > > +
> > >  static const char *advmon_options[] =3D {
> > >         "RSSISamplingPeriod",
> > >         NULL
> > > @@ -167,6 +172,7 @@ static const struct group_table {
> > >         { "Policy",     policy_options },
> > >         { "GATT",       gatt_options },
> > >         { "AVDTP",      avdtp_options },
> > > +       { "AVRCP",      avrcp_options },
> > >         { "AdvMon",     advmon_options },
> > >         { }
> > >  };
> > > @@ -975,6 +981,13 @@ static void parse_config(GKeyFile *config)
> > >                 g_free(str);
> > >         }
> > >
> > > +       boolean =3D g_key_file_get_boolean(config, "AVRCP",
> > > +                                               "SetAbsoluteVolumeWit=
houtTarget", &err);
> > > +       if (err)
> > > +               g_clear_error(&err);
> > > +       else
> > > +               btd_opts.avrcp.set_absolute_volume_without_target =3D=
 boolean;
> > > +
> > >         val =3D g_key_file_get_integer(config, "AdvMon", "RSSISamplin=
gPeriod",
> > >                                                                      =
   &err);
> > >         if (err) {
> > > diff --git a/src/main.conf b/src/main.conf
> > > index f187c9aaa..ca00ed03e 100644
> > > --- a/src/main.conf
> > > +++ b/src/main.conf
> > > @@ -271,6 +271,12 @@
> > >  # streaming: Use L2CAP Streaming Mode
> > >  #StreamMode =3D basic
> > >
> > > +[AVRCP]
> > > +# Allow SetAbsoluteVolume calls to a peer device that
> > > +# does not advertise the AVRCP remote control target
> > > +# profile.
> > > +#SetAbsoluteVolumeWithoutTarget =3D false
> >
> > Let's do just VolumeWithoutTarget and we should probably mention that
> > it would ignore the version as well.
>
> Sure, sounds good.  We can also invert the condition to validate the
> version in the event that ->controller is non-NULL, even if
> VolumeWithoutTarget is set.
>
> - Marijn
>
> >
> > > +
> > >  [Policy]
> > >  #
> > >  # The ReconnectUUIDs defines the set of remote services that should =
try
> > > --
> > > 2.39.2
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
