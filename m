Return-Path: <SRS0=qzIG=TC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75725C04AA9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 21:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D87620651
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 21:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq0BLqdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEBVOw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 May 2019 17:14:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53464 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfEBVOv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 May 2019 17:14:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id q15so4733145wmf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2019 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DxSt98mhdGNKUbvlz8tVaQPKEp/jJkqoM7oXvqmOx48=;
        b=Bq0BLqdCL4XeNeyi6ZI5hUfivR0kj//bKV+G3kGHVigXaaO1f1UatK5xx4Y2XhrV9T
         uICH3bhiD4ww5gtIrb20ooKRLaMYheXr4RjsI+0EbiK0AAE+f9dwAd8pm5gO+QPTt9iE
         hbNC0J0grwxJpQI8+njmO1Ouccm7hliLR2Z5bqu5cvd1PTepYeTlezdXQi9sYY2gle/B
         NiKZyJabiMEXH7QgQuKrjA/rEnzcIO8DOpb9bnzjkq9iAadHBRiSKVfOY+SZEltJLzr1
         x1qAgqFWwHMNeogzny27DSU7IBJiVQjtKv8RxlN4GFBozh3kAz2d6LuPXRf0Bm81swCb
         C5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DxSt98mhdGNKUbvlz8tVaQPKEp/jJkqoM7oXvqmOx48=;
        b=fhx6kDU23zgQmIlDvHFbZDBk/deHbnHxschywqtH7pqruL9NiuEgucdDQ5G4AQIVpW
         4GLGFeVnoXXobF4Eu7h4yo8P3G5kpQPW5VERfkaZo5C5bRrcfmjiegB73BHuCJEV/lor
         4higOBG1CcvWv2G8393ZmQdzaDSqEEmgA9wzoXhOOoLtuZGBpHgw4CHctImWSzr8CwMd
         dJxgYckbICafsGJNe7aiMXKcdikYXRUVzakCLEl0LaSDEjtWMzd8kXIlQOsL+J9jYot2
         Ta5P6TR9bJM80VAQwL2vYfts1xeV55gDoGlYvOEpRhm3H2VdiTr389CxPtihgwHsWPlq
         ZCLQ==
X-Gm-Message-State: APjAAAXn7CJGFopMMbUrJm3D1qt4e1wYuTS/iR7yPZEsbIKw6FBQcMD7
        0Yax55c9OuwvOcq03X6du38=
X-Google-Smtp-Source: APXvYqzEhMSxna5FnV7gyFt72ShImSM9CoKf0TcVDnhL1rfeKm40G9kU6+FhBvI3IhXX5UTVBvEXUQ==
X-Received: by 2002:a1c:7d10:: with SMTP id y16mr3701082wmc.83.1556831689575;
        Thu, 02 May 2019 14:14:49 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id w15sm536505wrg.43.2019.05.02.14.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 14:14:48 -0700 (PDT)
Date:   Thu, 2 May 2019 23:14:47 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/2] a2dp: Store last used endpoint
Message-ID: <20190502211447.5xxrrjvxoeiurh3p@pali>
References: <20190424083921.15679-1-luiz.dentz@gmail.com>
 <CABBYNZLcpo_Dx3X9pmKGeqSNFDLKZAqd==6wL5qcthGiqg-EeA@mail.gmail.com>
 <20190424165721.fs7ylixjscqjmqmb@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="s7ojmddsc5vv2btj"
Content-Disposition: inline
In-Reply-To: <20190424165721.fs7ylixjscqjmqmb@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--s7ojmddsc5vv2btj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 24 April 2019 18:57:21 Pali Roh=C3=A1r wrote:
> On Wednesday 24 April 2019 12:42:22 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >=20
> > On Wed, Apr 24, 2019 at 11:39 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > This stores the last used endpoint whenever it is considered open and
> > > then prefer to use it when attempting to reconnect.
> > > ---
> > >  profiles/audio/a2dp.c | 104 ++++++++++++++++++++++++++++++++++++----=
--
> > >  1 file changed, 91 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > > index 8f141739c..78b02dc84 100644
> > > --- a/profiles/audio/a2dp.c
> > > +++ b/profiles/audio/a2dp.c
> > > @@ -147,6 +147,7 @@ struct a2dp_channel {
> > >         unsigned int auth_id;
> > >         struct avdtp *session;
> > >         struct queue *seps;
> > > +       struct a2dp_remote_sep *last_used;
> > >  };
> > >
> > >  static GSList *servers =3D NULL;
> > > @@ -860,6 +861,60 @@ static gboolean open_ind(struct avdtp *session, =
struct avdtp_local_sep *sep,
> > >         return TRUE;
> > >  }
> > >
> > > +static bool match_remote_sep(const void *data, const void *user_data)
> > > +{
> > > +       const struct a2dp_remote_sep *sep =3D data;
> > > +       const struct avdtp_remote_sep *rsep =3D user_data;
> > > +
> > > +       return sep->sep =3D=3D rsep;
> > > +}
> > > +
> > > +static void store_last_used(struct a2dp_channel *chan,
> > > +                                       struct avdtp_remote_sep *rsep)
> > > +{
> > > +       GKeyFile *key_file;
> > > +       char filename[PATH_MAX];
> > > +       char dst_addr[18];
> > > +       char value[4];
> > > +       char *data;
> > > +       size_t len =3D 0;
> > > +
> > > +       ba2str(device_get_address(chan->device), dst_addr);
> > > +
> > > +       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
> > > +               btd_adapter_get_storage_dir(device_get_adapter(chan->=
device)),
> > > +               dst_addr);
> > > +       key_file =3D g_key_file_new();
> > > +       g_key_file_load_from_file(key_file, filename, 0, NULL);
> > > +
> > > +       sprintf(value, "%02hhx", avdtp_get_seid(rsep));
> > > +
> > > +       g_key_file_set_string(key_file, "Endpoints", "LastUsed", valu=
e);
> > > +
> > > +       data =3D g_key_file_to_data(key_file, &len, NULL);
> > > +       g_file_set_contents(filename, data, len, NULL);
> > > +
> > > +       g_free(data);
> > > +       g_key_file_free(key_file);
> > > +}
> > > +
> > > +static void update_last_used(struct a2dp_channel *chan,
> > > +                                               struct avdtp_stream *=
stream)
> > > +{
> > > +       struct avdtp_remote_sep *rsep;
> > > +       struct a2dp_remote_sep *sep;
> > > +
> > > +       rsep =3D avdtp_stream_get_remote_sep(stream);
> > > +
> > > +       /* Update last used */
> > > +       sep =3D queue_find(chan->seps, match_remote_sep, rsep);
> > > +       if (chan->last_used =3D=3D sep)
> > > +               return;
> > > +
> > > +       chan->last_used =3D sep;
> > > +       store_last_used(chan, rsep);
> > > +}
> > > +
> > >  static void open_cfm(struct avdtp *session, struct avdtp_local_sep *=
sep,
> > >                         struct avdtp_stream *stream, struct avdtp_err=
or *err,
> > >                         void *user_data)
> > > @@ -884,7 +939,8 @@ static void open_cfm(struct avdtp *session, struc=
t avdtp_local_sep *sep,
> > >                 setup->err =3D err;
> > >                 if (setup->start)
> > >                         finalize_resume(setup);
> > > -       }
> > > +       } else if (setup->chan)
> > > +               update_last_used(setup->chan, stream);
> > >
> > >         finalize_config(setup);
> > >
> > > @@ -1077,14 +1133,6 @@ static gboolean close_ind(struct avdtp *sessio=
n, struct avdtp_local_sep *sep,
> > >         return TRUE;
> > >  }
> > >
> > > -static bool match_remote_sep(const void *data, const void *user_data)
> > > -{
> > > -       const struct a2dp_remote_sep *sep =3D data;
> > > -       const struct avdtp_remote_sep *rsep =3D user_data;
> > > -
> > > -       return sep->sep =3D=3D rsep;
> > > -}
> > > -
> > >  static struct a2dp_remote_sep *find_remote_sep(struct a2dp_channel *=
chan,
> > >                                                 struct a2dp_sep *sep)
> > >  {
> > > @@ -1791,19 +1839,28 @@ done:
> > >         queue_push_tail(chan->seps, sep);
> > >  }
> > >
> > > +static bool match_seid(const void *data, const void *user_data)
> > > +{
> > > +       const struct a2dp_remote_sep *sep =3D data;
> > > +       const uint8_t *seid =3D user_data;
> > > +
> > > +       return avdtp_get_seid(sep->sep) =3D=3D *seid;
> > > +}
> > > +
> > >  static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key=
_file,
> > >                                                                 char =
**seids)
> > >  {
> > >         struct avdtp_remote_sep *sep;
> > > +       uint8_t seid;
> > > +       char *value;
> > >
> > >         if (!seids)
> > >                 return;
> > >
> > >         for (; *seids; seids++) {
> > > -               uint8_t seid;
> > >                 uint8_t type;
> > >                 uint8_t codec;
> > > -               char *value, caps[256];
> > > +               char caps[256];
> > >                 uint8_t data[128];
> > >                 int i, size;
> > >                 GSList *l =3D NULL;
> > > @@ -1847,6 +1904,15 @@ static void load_remote_sep(struct a2dp_channe=
l *chan, GKeyFile *key_file,
> > >
> > >                 register_remote_sep(sep, chan);
> > >         }
> > > +
> > > +       value =3D g_key_file_get_string(key_file, "Endpoints", "LastU=
sed", NULL);
> > > +       if (!value)
> > > +               return;
> > > +
> > > +       if (sscanf(value, "%02hhx", &seid) !=3D 1)
> > > +               return;
> > > +
> > > +       chan->last_used =3D queue_find(chan->seps, match_seid, &seid);
> > >  }
> > >
> > >  static void load_remote_seps(struct a2dp_channel *chan)
> > > @@ -2355,8 +2421,12 @@ done:
> > >  static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList =
*list,
> > >                                         const char *sender)
> > >  {
> > > +       struct a2dp_sep *first =3D NULL;
> > > +       struct a2dp_channel *chan =3D find_channel(session);
> > > +
> > >         for (; list; list =3D list->next) {
> > >                 struct a2dp_sep *sep =3D list->data;
> > > +               struct avdtp_remote_sep *rsep;
> > >
> > >                 /* Use sender's endpoint if available */
> > >                 if (sender) {
> > > @@ -2370,14 +2440,22 @@ static struct a2dp_sep *a2dp_find_sep(struct =
avdtp *session, GSList *list,
> > >                                 continue;
> > >                 }
> > >
> > > -               if (avdtp_find_remote_sep(session, sep->lsep) =3D=3D =
NULL)
> > > +               rsep =3D avdtp_find_remote_sep(session, sep->lsep);
> > > +               if (!rsep)
> > >                         continue;
> > >
> > > +               /* Locate last used if set */
> > > +               if (chan->last_used) {
> > > +                       if (chan->last_used->sep =3D=3D rsep)
> > > +                               return sep;
> > > +                       first =3D sep;
> > > +               }
> > > +
> > >                 return sep;
> > >
> > >         }
> > >
> > > -       return NULL;
> > > +       return first;
> > >  }
> > >
> > >  static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8=
_t type,
> > > --
> > > 2.20.1
> >=20
> > Can you give this a try, it should make the daemon remember what was
> > the last endpoint used (locally the remote selection we cannot really
> > control).
>=20
> Great, I will try it.

Seems that it does not work as expected when there are more SEPs for one
codec.

Before bluez chose first registered endpoint which matched codec. Now in
git master is bluez choosing last registered endpoint which matched
codec. So before it was SBC at highest quality, now it is SBC at lowest
quality.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--s7ojmddsc5vv2btj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXMtdxAAKCRCL8Mk9A+RD
Uj8EAKDL8udqopenwdMEpQpiP9Z53SISYQCgtURk2t8Z+4SsOnYMuJdFEYqqE30=
=JQq8
-----END PGP SIGNATURE-----

--s7ojmddsc5vv2btj--
