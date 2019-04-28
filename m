Return-Path: <SRS0=Ax9e=S6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91E5C43219
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 Apr 2019 19:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F4E2067C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 Apr 2019 19:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neEMWgbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfD1TPd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 Apr 2019 15:15:33 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39920 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfD1TPc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 Apr 2019 15:15:32 -0400
Received: by mail-oi1-f193.google.com with SMTP id n187so6727869oih.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Apr 2019 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SlrbCvaQj+TzO7uyFoKBve7dwnMt0ndEekUAVaR6gXU=;
        b=neEMWgbi873MrX08SOVX3/FIcFa8IteotjgVzXE3VLPDcZ05GpGx4cztlXmKmvxlc3
         KauHnDk0TMgunX025QqdwOiascuRRSeGt9AJ8csQfJ49NLvsTYDAb3h+PcpFRJPcTLB2
         4wErY8HaWbn1plRqHWmM26rz9UHlVjVzYMMOnmPBOiaPWZRJBxr+862EJ9BpXpH5/E0r
         d8blbQ+HiB42+WMOZTO8Uesb5zuldRNFyYKfLDySlaEl6YHktXTBJqnT8yFOuxk3c36X
         1CXSKRP85oQnylA3x5k1s5O/S7B/Fd5w9g5vHmEM/Viu0nIVNhal/JzaZSNVqfAZZAV8
         HojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SlrbCvaQj+TzO7uyFoKBve7dwnMt0ndEekUAVaR6gXU=;
        b=Br0bpYI9Mi/g56+z1KYNSzVyVxpbz6Hc+Ue2ciIiFBi9FAlH9OfDoHkcxcep/9Bpo7
         wetSmHsacxAtr5lDYAuNvQdnELLE49ianZjMauvfiEckYB2pxw391XGU/mwMxEI+0Bic
         4P3DTcoyxV+EstM0l3CMEXat7+sG1X/lYqxxWCMiQnT6xvRjch3wo0bB0Wcr3UIrv31g
         9reAEuZcSGVUamuZ75APUEp4GPOb0kfQ3nn02Sqw92zoWLPkvO0ZfFSR4eO/COP9KBmd
         Qcpvpf5gVta5rbOiUG3Jg5f9UDf2POnK56IDLqpmW9VvHJmDdGJM6Vh4Gwp+XSQ8nkBB
         b6yw==
X-Gm-Message-State: APjAAAVLrgF3q6bVqqDE8RWj+wP2shmBoHn9Gq9elTP1RDlpBz98UUwO
        dZksBY1tqIDm3jTAUhvRXSKQ5w0MUrH/pSdzClI=
X-Google-Smtp-Source: APXvYqyog8dsQ7dDSLEmx2bbcxYr5Pru6fkQPDr0zMURbSu2nDtv4ioA2yU2ae82dyrR+yCLqVGGypkedg0EsmPbts4=
X-Received: by 2002:aca:ab10:: with SMTP id u16mr99473oie.8.1556478931349;
 Sun, 28 Apr 2019 12:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190424083921.15679-1-luiz.dentz@gmail.com> <CABBYNZLcpo_Dx3X9pmKGeqSNFDLKZAqd==6wL5qcthGiqg-EeA@mail.gmail.com>
 <20190424165721.fs7ylixjscqjmqmb@pali> <CABBYNZL=8sigG=Sg-0ZdJSCd6KvW1OEAzS0uxTDcFD_fiRUmLw@mail.gmail.com>
 <20190428185300.d227pgogss3qh7ul@pali>
In-Reply-To: <20190428185300.d227pgogss3qh7ul@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 28 Apr 2019 22:15:21 +0300
Message-ID: <CABBYNZJs_3o8c97k0Gq0rYeZjOMNbXAP+YxhNe2zjt8rF9UFTw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] a2dp: Store last used endpoint
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sun, Apr 28, 2019 at 9:53 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Thursday 25 April 2019 11:00:07 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Wed, Apr 24, 2019 at 7:57 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
> > >
> > > On Wednesday 24 April 2019 12:42:22 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >
> > > > On Wed, Apr 24, 2019 at 11:39 AM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > >
> > > > > This stores the last used endpoint whenever it is considered open=
 and
> > > > > then prefer to use it when attempting to reconnect.
> > > > > ---
> > > > >  profiles/audio/a2dp.c | 104 ++++++++++++++++++++++++++++++++++++=
------
> > > > >  1 file changed, 91 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > > > > index 8f141739c..78b02dc84 100644
> > > > > --- a/profiles/audio/a2dp.c
> > > > > +++ b/profiles/audio/a2dp.c
> > > > > @@ -147,6 +147,7 @@ struct a2dp_channel {
> > > > >         unsigned int auth_id;
> > > > >         struct avdtp *session;
> > > > >         struct queue *seps;
> > > > > +       struct a2dp_remote_sep *last_used;
> > > > >  };
> > > > >
> > > > >  static GSList *servers =3D NULL;
> > > > > @@ -860,6 +861,60 @@ static gboolean open_ind(struct avdtp *sessi=
on, struct avdtp_local_sep *sep,
> > > > >         return TRUE;
> > > > >  }
> > > > >
> > > > > +static bool match_remote_sep(const void *data, const void *user_=
data)
> > > > > +{
> > > > > +       const struct a2dp_remote_sep *sep =3D data;
> > > > > +       const struct avdtp_remote_sep *rsep =3D user_data;
> > > > > +
> > > > > +       return sep->sep =3D=3D rsep;
> > > > > +}
> > > > > +
> > > > > +static void store_last_used(struct a2dp_channel *chan,
> > > > > +                                       struct avdtp_remote_sep *=
rsep)
> > > > > +{
> > > > > +       GKeyFile *key_file;
> > > > > +       char filename[PATH_MAX];
> > > > > +       char dst_addr[18];
> > > > > +       char value[4];
> > > > > +       char *data;
> > > > > +       size_t len =3D 0;
> > > > > +
> > > > > +       ba2str(device_get_address(chan->device), dst_addr);
> > > > > +
> > > > > +       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
> > > > > +               btd_adapter_get_storage_dir(device_get_adapter(ch=
an->device)),
> > > > > +               dst_addr);
> > > > > +       key_file =3D g_key_file_new();
> > > > > +       g_key_file_load_from_file(key_file, filename, 0, NULL);
> > > > > +
> > > > > +       sprintf(value, "%02hhx", avdtp_get_seid(rsep));
> > > > > +
> > > > > +       g_key_file_set_string(key_file, "Endpoints", "LastUsed", =
value);
> > > > > +
> > > > > +       data =3D g_key_file_to_data(key_file, &len, NULL);
> > > > > +       g_file_set_contents(filename, data, len, NULL);
> > > > > +
> > > > > +       g_free(data);
> > > > > +       g_key_file_free(key_file);
> > > > > +}
> > > > > +
> > > > > +static void update_last_used(struct a2dp_channel *chan,
> > > > > +                                               struct avdtp_stre=
am *stream)
> > > > > +{
> > > > > +       struct avdtp_remote_sep *rsep;
> > > > > +       struct a2dp_remote_sep *sep;
> > > > > +
> > > > > +       rsep =3D avdtp_stream_get_remote_sep(stream);
> > > > > +
> > > > > +       /* Update last used */
> > > > > +       sep =3D queue_find(chan->seps, match_remote_sep, rsep);
> > > > > +       if (chan->last_used =3D=3D sep)
> > > > > +               return;
> > > > > +
> > > > > +       chan->last_used =3D sep;
> > > > > +       store_last_used(chan, rsep);
> > > > > +}
> > > > > +
> > > > >  static void open_cfm(struct avdtp *session, struct avdtp_local_s=
ep *sep,
> > > > >                         struct avdtp_stream *stream, struct avdtp=
_error *err,
> > > > >                         void *user_data)
> > > > > @@ -884,7 +939,8 @@ static void open_cfm(struct avdtp *session, s=
truct avdtp_local_sep *sep,
> > > > >                 setup->err =3D err;
> > > > >                 if (setup->start)
> > > > >                         finalize_resume(setup);
> > > > > -       }
> > > > > +       } else if (setup->chan)
> > > > > +               update_last_used(setup->chan, stream);
> > > > >
> > > > >         finalize_config(setup);
> > > > >
> > > > > @@ -1077,14 +1133,6 @@ static gboolean close_ind(struct avdtp *se=
ssion, struct avdtp_local_sep *sep,
> > > > >         return TRUE;
> > > > >  }
> > > > >
> > > > > -static bool match_remote_sep(const void *data, const void *user_=
data)
> > > > > -{
> > > > > -       const struct a2dp_remote_sep *sep =3D data;
> > > > > -       const struct avdtp_remote_sep *rsep =3D user_data;
> > > > > -
> > > > > -       return sep->sep =3D=3D rsep;
> > > > > -}
> > > > > -
> > > > >  static struct a2dp_remote_sep *find_remote_sep(struct a2dp_chann=
el *chan,
> > > > >                                                 struct a2dp_sep *=
sep)
> > > > >  {
> > > > > @@ -1791,19 +1839,28 @@ done:
> > > > >         queue_push_tail(chan->seps, sep);
> > > > >  }
> > > > >
> > > > > +static bool match_seid(const void *data, const void *user_data)
> > > > > +{
> > > > > +       const struct a2dp_remote_sep *sep =3D data;
> > > > > +       const uint8_t *seid =3D user_data;
> > > > > +
> > > > > +       return avdtp_get_seid(sep->sep) =3D=3D *seid;
> > > > > +}
> > > > > +
> > > > >  static void load_remote_sep(struct a2dp_channel *chan, GKeyFile =
*key_file,
> > > > >                                                                 c=
har **seids)
> > > > >  {
> > > > >         struct avdtp_remote_sep *sep;
> > > > > +       uint8_t seid;
> > > > > +       char *value;
> > > > >
> > > > >         if (!seids)
> > > > >                 return;
> > > > >
> > > > >         for (; *seids; seids++) {
> > > > > -               uint8_t seid;
> > > > >                 uint8_t type;
> > > > >                 uint8_t codec;
> > > > > -               char *value, caps[256];
> > > > > +               char caps[256];
> > > > >                 uint8_t data[128];
> > > > >                 int i, size;
> > > > >                 GSList *l =3D NULL;
> > > > > @@ -1847,6 +1904,15 @@ static void load_remote_sep(struct a2dp_ch=
annel *chan, GKeyFile *key_file,
> > > > >
> > > > >                 register_remote_sep(sep, chan);
> > > > >         }
> > > > > +
> > > > > +       value =3D g_key_file_get_string(key_file, "Endpoints", "L=
astUsed", NULL);
> > > > > +       if (!value)
> > > > > +               return;
> > > > > +
> > > > > +       if (sscanf(value, "%02hhx", &seid) !=3D 1)
> > > > > +               return;
> > > > > +
> > > > > +       chan->last_used =3D queue_find(chan->seps, match_seid, &s=
eid);
> > > > >  }
> > > > >
> > > > >  static void load_remote_seps(struct a2dp_channel *chan)
> > > > > @@ -2355,8 +2421,12 @@ done:
> > > > >  static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSL=
ist *list,
> > > > >                                         const char *sender)
> > > > >  {
> > > > > +       struct a2dp_sep *first =3D NULL;
> > > > > +       struct a2dp_channel *chan =3D find_channel(session);
> > > > > +
> > > > >         for (; list; list =3D list->next) {
> > > > >                 struct a2dp_sep *sep =3D list->data;
> > > > > +               struct avdtp_remote_sep *rsep;
> > > > >
> > > > >                 /* Use sender's endpoint if available */
> > > > >                 if (sender) {
> > > > > @@ -2370,14 +2440,22 @@ static struct a2dp_sep *a2dp_find_sep(str=
uct avdtp *session, GSList *list,
> > > > >                                 continue;
> > > > >                 }
> > > > >
> > > > > -               if (avdtp_find_remote_sep(session, sep->lsep) =3D=
=3D NULL)
> > > > > +               rsep =3D avdtp_find_remote_sep(session, sep->lsep=
);
> > > > > +               if (!rsep)
> > > > >                         continue;
> > > > >
> > > > > +               /* Locate last used if set */
> > > > > +               if (chan->last_used) {
> > > > > +                       if (chan->last_used->sep =3D=3D rsep)
> > > > > +                               return sep;
> > > > > +                       first =3D sep;
> > > > > +               }
> > > > > +
> > > > >                 return sep;
> > > > >
> > > > >         }
> > > > >
> > > > > -       return NULL;
> > > > > +       return first;
> > > > >  }
> > > > >
> > > > >  static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, u=
int8_t type,
> > > > > --
> > > > > 2.20.1
> > > >
> > > > Can you give this a try, it should make the daemon remember what wa=
s
> > > > the last endpoint used (locally the remote selection we cannot real=
ly
> > > > control).
> > >
> > > Great, I will try it. Remote selection is done by remote device so th=
is
> > > really cannot be controlled.
> > >
> > > I have there another suggestion for improvement. bluez support
> > > registering more endpoints for one codec. I'm going to use it for
> > > registering one SBC endpoint with fixed bitpool as UHQ profile and
> > > another with lower bitpool values. To distinguish in pulseaudio betwe=
en
> > > low and high quality of SBC. Seems that bluez sometimes try to only
> > > select only one endpoint, even there are more and do not try another =
if
> > > first one selection fails (e.g. because remote capability of bitpool =
is
> > > too low and our local selection needs higher). Could be bluez modifie=
d
> > > to try another local endpoint if there are more registered until some
> > > accept capabilities?
> >
> > Well that was actually one of the reason Ive recommended not
> > registering more than one endpoint for the same codec, we should
> > perhaps fix that since those endpoints can belong to different
> > processes but if we do insist to have PA with multiple SBC endpoints
> > that means it would not be backward compatible since it may try to
> > configure with UHQ as it should be higher priority, besides having a
> > higher fixed range means we can no longer reduce the quality at
> > runtime, but perhaps there is a way to make it work if PA detects it
> > has multiple endpoints that could be used it could just switch to
> > normal quality if UHQ cannot be used, this is actually beneficial in
> > terms of latency as well since we don't have extra D-Bus round trips
> > asking different endpoints.
>
> Registering multiple endpoints is the only way how to enforce SBC UHQ.
> Most of headset supports only SBC bitpools 1-53, therefore for SBC UHQ
> is needed Dualchannel mode, not Joint Stereo.

Sure, but that is just one extra endpoint, not the 4 or so you have
currently in your set.

> So I see there only one backward-compatible implementation: Runtime
> check of bluez version (or capability or whatever). Also this is
> probably also useful/needed to check if bluez supports API for changing
> codec.
>
> So... can you implement that "fallback" mechanisms of trying to use all
> possible endpoints until one succeed; and provide ability for
> applications to detect this functionality is supported?

I will have a fix for that, but cycling thru that many endpoints might
not be the best experience, Id really just leave 2 endpoints for SBC,
one for dual channel and another for the rest.

> Application (like pulseaudio) would register multiple endpoints only in
> the case then bluez declares its functionality to be code backward
> compatible. And if case it is not supported then application would not
> support fixed profiles like SBC UHQ.

Well, going with 76 bitpool is in fact supported by early versions of
BlueZ, thus why I was suggesting to register just 2 SBC endpoints as
explained above since you can order register the joint-stereo before
the dual-band that should not be affected by the lack of retrying
logic.

> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
Luiz Augusto von Dentz
