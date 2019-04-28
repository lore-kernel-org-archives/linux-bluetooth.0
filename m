Return-Path: <SRS0=Ax9e=S6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AE0C43219
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 Apr 2019 18:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6667620679
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 Apr 2019 18:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMJSN1Hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfD1SxG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 Apr 2019 14:53:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47070 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfD1SxF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 Apr 2019 14:53:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so12431700wrw.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Apr 2019 11:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vUU0XoxM0b6NRQOH2qLfrXSS8pIOM64krdc6mecGw7c=;
        b=nMJSN1HfS7kmGJ8Rb9UfJoCr9c9Ukb2MjD5SXWszEJj2cYDwC/VXxcM4PI6LsV8tWd
         +VAkd8Ra375cKXX7ju1e8ptJTMn0OxKskfHhSkKxrko2ZpK/A1lwkk5D5DoZ7eP4gW3u
         MmMdSEE+3DNihzugX4MDs6VVkn2BBR+EEFtS9U6gK56VYii71fhHs94+OZbxG1OOKsGp
         vSd8ELoMBTlcnutVo9uYrPPq3pfpz4t4lb3jdCKdYB/0hXb9rtBeP6+Z2f9vtqTaGZIh
         L+GZ1U4ejBcBq+nei3CMFyjgORObs9PdjehX/CZT77RfUgnSTElcM/L40H+myCBWu+C6
         HjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vUU0XoxM0b6NRQOH2qLfrXSS8pIOM64krdc6mecGw7c=;
        b=CsRoRwt1vlnqSCcje8erE+mgU3ODugXk6c5sK6nzdmgL6icv3lIm0wbwyFkWvNWFB8
         b/QtCpoV5/8Cr6yhznEHhhCSSjvpZL69B0BX1c9Yk7b/xmc9E2UaPKsH6Gxx53gFwxcq
         9JZBNCk0oaf42ASzTYOqaevhJVxOoouFFeVe5NyK98nmuojQS8cTe/aKxJOzCHgmIibF
         kTHhF2WboDi8wJaWaA1EojYjrCbatPIHSsr5tuOElXYSp90EAyNdTL6dWVnEhmhRXoPr
         qs23bVQzTSdydfaxy3i5bSkZdc9Wh7hfhHfr4135A/VpmG7qjoAvaFjiQUcJV/fLjGMN
         xSNw==
X-Gm-Message-State: APjAAAVR8VwCnqUIUyeWa0Pzf3jmIEIcPyYCHKV0D+IQkG5fOhb5PeAK
        u1KFTA8sf+hyQ9t7+tEZvLM=
X-Google-Smtp-Source: APXvYqz8aDEaso1jEHopRqXHYBxcpz3lSWr84eaFbqIyzeLhUBih3bR9YbohvHFenox6fNPqS5/vUw==
X-Received: by 2002:a05:6000:11ce:: with SMTP id i14mr10301539wrx.37.1556477583272;
        Sun, 28 Apr 2019 11:53:03 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id d6sm29829551wrp.9.2019.04.28.11.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 11:53:01 -0700 (PDT)
Date:   Sun, 28 Apr 2019 20:53:00 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/2] a2dp: Store last used endpoint
Message-ID: <20190428185300.d227pgogss3qh7ul@pali>
References: <20190424083921.15679-1-luiz.dentz@gmail.com>
 <CABBYNZLcpo_Dx3X9pmKGeqSNFDLKZAqd==6wL5qcthGiqg-EeA@mail.gmail.com>
 <20190424165721.fs7ylixjscqjmqmb@pali>
 <CABBYNZL=8sigG=Sg-0ZdJSCd6KvW1OEAzS0uxTDcFD_fiRUmLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qrvmrn3qtuq3tf7s"
Content-Disposition: inline
In-Reply-To: <CABBYNZL=8sigG=Sg-0ZdJSCd6KvW1OEAzS0uxTDcFD_fiRUmLw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--qrvmrn3qtuq3tf7s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 25 April 2019 11:00:07 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Wed, Apr 24, 2019 at 7:57 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > On Wednesday 24 April 2019 12:42:22 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Wed, Apr 24, 2019 at 11:39 AM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >
> > > > This stores the last used endpoint whenever it is considered open a=
nd
> > > > then prefer to use it when attempting to reconnect.
> > > > ---
> > > >  profiles/audio/a2dp.c | 104 ++++++++++++++++++++++++++++++++++++--=
----
> > > >  1 file changed, 91 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > > > index 8f141739c..78b02dc84 100644
> > > > --- a/profiles/audio/a2dp.c
> > > > +++ b/profiles/audio/a2dp.c
> > > > @@ -147,6 +147,7 @@ struct a2dp_channel {
> > > >         unsigned int auth_id;
> > > >         struct avdtp *session;
> > > >         struct queue *seps;
> > > > +       struct a2dp_remote_sep *last_used;
> > > >  };
> > > >
> > > >  static GSList *servers =3D NULL;
> > > > @@ -860,6 +861,60 @@ static gboolean open_ind(struct avdtp *session=
, struct avdtp_local_sep *sep,
> > > >         return TRUE;
> > > >  }
> > > >
> > > > +static bool match_remote_sep(const void *data, const void *user_da=
ta)
> > > > +{
> > > > +       const struct a2dp_remote_sep *sep =3D data;
> > > > +       const struct avdtp_remote_sep *rsep =3D user_data;
> > > > +
> > > > +       return sep->sep =3D=3D rsep;
> > > > +}
> > > > +
> > > > +static void store_last_used(struct a2dp_channel *chan,
> > > > +                                       struct avdtp_remote_sep *rs=
ep)
> > > > +{
> > > > +       GKeyFile *key_file;
> > > > +       char filename[PATH_MAX];
> > > > +       char dst_addr[18];
> > > > +       char value[4];
> > > > +       char *data;
> > > > +       size_t len =3D 0;
> > > > +
> > > > +       ba2str(device_get_address(chan->device), dst_addr);
> > > > +
> > > > +       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
> > > > +               btd_adapter_get_storage_dir(device_get_adapter(chan=
->device)),
> > > > +               dst_addr);
> > > > +       key_file =3D g_key_file_new();
> > > > +       g_key_file_load_from_file(key_file, filename, 0, NULL);
> > > > +
> > > > +       sprintf(value, "%02hhx", avdtp_get_seid(rsep));
> > > > +
> > > > +       g_key_file_set_string(key_file, "Endpoints", "LastUsed", va=
lue);
> > > > +
> > > > +       data =3D g_key_file_to_data(key_file, &len, NULL);
> > > > +       g_file_set_contents(filename, data, len, NULL);
> > > > +
> > > > +       g_free(data);
> > > > +       g_key_file_free(key_file);
> > > > +}
> > > > +
> > > > +static void update_last_used(struct a2dp_channel *chan,
> > > > +                                               struct avdtp_stream=
 *stream)
> > > > +{
> > > > +       struct avdtp_remote_sep *rsep;
> > > > +       struct a2dp_remote_sep *sep;
> > > > +
> > > > +       rsep =3D avdtp_stream_get_remote_sep(stream);
> > > > +
> > > > +       /* Update last used */
> > > > +       sep =3D queue_find(chan->seps, match_remote_sep, rsep);
> > > > +       if (chan->last_used =3D=3D sep)
> > > > +               return;
> > > > +
> > > > +       chan->last_used =3D sep;
> > > > +       store_last_used(chan, rsep);
> > > > +}
> > > > +
> > > >  static void open_cfm(struct avdtp *session, struct avdtp_local_sep=
 *sep,
> > > >                         struct avdtp_stream *stream, struct avdtp_e=
rror *err,
> > > >                         void *user_data)
> > > > @@ -884,7 +939,8 @@ static void open_cfm(struct avdtp *session, str=
uct avdtp_local_sep *sep,
> > > >                 setup->err =3D err;
> > > >                 if (setup->start)
> > > >                         finalize_resume(setup);
> > > > -       }
> > > > +       } else if (setup->chan)
> > > > +               update_last_used(setup->chan, stream);
> > > >
> > > >         finalize_config(setup);
> > > >
> > > > @@ -1077,14 +1133,6 @@ static gboolean close_ind(struct avdtp *sess=
ion, struct avdtp_local_sep *sep,
> > > >         return TRUE;
> > > >  }
> > > >
> > > > -static bool match_remote_sep(const void *data, const void *user_da=
ta)
> > > > -{
> > > > -       const struct a2dp_remote_sep *sep =3D data;
> > > > -       const struct avdtp_remote_sep *rsep =3D user_data;
> > > > -
> > > > -       return sep->sep =3D=3D rsep;
> > > > -}
> > > > -
> > > >  static struct a2dp_remote_sep *find_remote_sep(struct a2dp_channel=
 *chan,
> > > >                                                 struct a2dp_sep *se=
p)
> > > >  {
> > > > @@ -1791,19 +1839,28 @@ done:
> > > >         queue_push_tail(chan->seps, sep);
> > > >  }
> > > >
> > > > +static bool match_seid(const void *data, const void *user_data)
> > > > +{
> > > > +       const struct a2dp_remote_sep *sep =3D data;
> > > > +       const uint8_t *seid =3D user_data;
> > > > +
> > > > +       return avdtp_get_seid(sep->sep) =3D=3D *seid;
> > > > +}
> > > > +
> > > >  static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *k=
ey_file,
> > > >                                                                 cha=
r **seids)
> > > >  {
> > > >         struct avdtp_remote_sep *sep;
> > > > +       uint8_t seid;
> > > > +       char *value;
> > > >
> > > >         if (!seids)
> > > >                 return;
> > > >
> > > >         for (; *seids; seids++) {
> > > > -               uint8_t seid;
> > > >                 uint8_t type;
> > > >                 uint8_t codec;
> > > > -               char *value, caps[256];
> > > > +               char caps[256];
> > > >                 uint8_t data[128];
> > > >                 int i, size;
> > > >                 GSList *l =3D NULL;
> > > > @@ -1847,6 +1904,15 @@ static void load_remote_sep(struct a2dp_chan=
nel *chan, GKeyFile *key_file,
> > > >
> > > >                 register_remote_sep(sep, chan);
> > > >         }
> > > > +
> > > > +       value =3D g_key_file_get_string(key_file, "Endpoints", "Las=
tUsed", NULL);
> > > > +       if (!value)
> > > > +               return;
> > > > +
> > > > +       if (sscanf(value, "%02hhx", &seid) !=3D 1)
> > > > +               return;
> > > > +
> > > > +       chan->last_used =3D queue_find(chan->seps, match_seid, &sei=
d);
> > > >  }
> > > >
> > > >  static void load_remote_seps(struct a2dp_channel *chan)
> > > > @@ -2355,8 +2421,12 @@ done:
> > > >  static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSLis=
t *list,
> > > >                                         const char *sender)
> > > >  {
> > > > +       struct a2dp_sep *first =3D NULL;
> > > > +       struct a2dp_channel *chan =3D find_channel(session);
> > > > +
> > > >         for (; list; list =3D list->next) {
> > > >                 struct a2dp_sep *sep =3D list->data;
> > > > +               struct avdtp_remote_sep *rsep;
> > > >
> > > >                 /* Use sender's endpoint if available */
> > > >                 if (sender) {
> > > > @@ -2370,14 +2440,22 @@ static struct a2dp_sep *a2dp_find_sep(struc=
t avdtp *session, GSList *list,
> > > >                                 continue;
> > > >                 }
> > > >
> > > > -               if (avdtp_find_remote_sep(session, sep->lsep) =3D=
=3D NULL)
> > > > +               rsep =3D avdtp_find_remote_sep(session, sep->lsep);
> > > > +               if (!rsep)
> > > >                         continue;
> > > >
> > > > +               /* Locate last used if set */
> > > > +               if (chan->last_used) {
> > > > +                       if (chan->last_used->sep =3D=3D rsep)
> > > > +                               return sep;
> > > > +                       first =3D sep;
> > > > +               }
> > > > +
> > > >                 return sep;
> > > >
> > > >         }
> > > >
> > > > -       return NULL;
> > > > +       return first;
> > > >  }
> > > >
> > > >  static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uin=
t8_t type,
> > > > --
> > > > 2.20.1
> > >
> > > Can you give this a try, it should make the daemon remember what was
> > > the last endpoint used (locally the remote selection we cannot really
> > > control).
> >
> > Great, I will try it. Remote selection is done by remote device so this
> > really cannot be controlled.
> >
> > I have there another suggestion for improvement. bluez support
> > registering more endpoints for one codec. I'm going to use it for
> > registering one SBC endpoint with fixed bitpool as UHQ profile and
> > another with lower bitpool values. To distinguish in pulseaudio between
> > low and high quality of SBC. Seems that bluez sometimes try to only
> > select only one endpoint, even there are more and do not try another if
> > first one selection fails (e.g. because remote capability of bitpool is
> > too low and our local selection needs higher). Could be bluez modified
> > to try another local endpoint if there are more registered until some
> > accept capabilities?
>=20
> Well that was actually one of the reason Ive recommended not
> registering more than one endpoint for the same codec, we should
> perhaps fix that since those endpoints can belong to different
> processes but if we do insist to have PA with multiple SBC endpoints
> that means it would not be backward compatible since it may try to
> configure with UHQ as it should be higher priority, besides having a
> higher fixed range means we can no longer reduce the quality at
> runtime, but perhaps there is a way to make it work if PA detects it
> has multiple endpoints that could be used it could just switch to
> normal quality if UHQ cannot be used, this is actually beneficial in
> terms of latency as well since we don't have extra D-Bus round trips
> asking different endpoints.

Registering multiple endpoints is the only way how to enforce SBC UHQ.
Most of headset supports only SBC bitpools 1-53, therefore for SBC UHQ
is needed Dualchannel mode, not Joint Stereo.

So I see there only one backward-compatible implementation: Runtime
check of bluez version (or capability or whatever). Also this is
probably also useful/needed to check if bluez supports API for changing
codec.

So... can you implement that "fallback" mechanisms of trying to use all
possible endpoints until one succeed; and provide ability for
applications to detect this functionality is supported?

Application (like pulseaudio) would register multiple endpoints only in
the case then bluez declares its functionality to be code backward
compatible. And if case it is not supported then application would not
support fixed profiles like SBC UHQ.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--qrvmrn3qtuq3tf7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXMX2igAKCRCL8Mk9A+RD
UuU5AKCFei/cD0CG5E7qkA9srsNesDpdvACeIuQb26mc7furrLkhm5Nwk59hjwQ=
=xFHR
-----END PGP SIGNATURE-----

--qrvmrn3qtuq3tf7s--
