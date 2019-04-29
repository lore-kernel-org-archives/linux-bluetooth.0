Return-Path: <SRS0=fAjn=S7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62AFC43219
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 16:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDEB2147A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 16:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAsqa2vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfD2QjV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:39:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39886 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfD2QjU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Apr 2019 12:39:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so77044wmk.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2019 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u3tYI1HSpDWL5U7ClTh6mZK+h3G3lRdiqSWVcSfxagY=;
        b=WAsqa2vhM0GzBLSJAFn9VYu335uor8AUmpc7IUIQEo/jZgj0lYLTjNl22StzKJlxMU
         KrLfdLR9xBS/M/SjboY5wsW9QZr/tAjbemcuAnEbb53CB2QM5ebcfnGw0L2W52pRRikL
         wspx7FB4mjheaYXnMtelxRFUoRnnPUc3n0kUzlmhvBjy0ysnSzgK/32VrpfylwovN7CY
         7B+zBcXzXUufBUhT9EpGIi0NaZU7yy8M8dgS4tIjqEPr2f69HmYL/PhCuWbi8/JTlKwG
         1vuQOq2BYvlaAq+4P00afLvMeAgwKjoWHUeORYvGeMuXoVfD5RGBCMxzlk91bKFpLlLj
         NAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u3tYI1HSpDWL5U7ClTh6mZK+h3G3lRdiqSWVcSfxagY=;
        b=RqoUx7uklmhF5Rm5qcviA/JuxezSQdgMbMUZ+oDAUYDQNxMcOrgolqyY0J1zCJjJjA
         yMT7FoUCPedS6aVuG4WRVPzkHKem0Reml6IXInH+wUMUVdII9sJhkT16H77Fv+6noWML
         yi1jMiunk16fXbY3MoMyPEp3sXzh33J5HGdzpQHOczaoXtc8o69t8btfBX+6u1wfjZj0
         fd18mgGdPCkcqBtxVUkqvRvAfabvPywlA5ShrsDpIk3BvKcqQykKQcCAr/7U4FzqEvN7
         OV5EDKGQ3MdY+qu403Lep6Amf0ml4n02GuRg9hKw4AzyMAfPFek0nd3tRZsNE5hmgElD
         madg==
X-Gm-Message-State: APjAAAVNylU97L/2B2hujecbjMGJXShDj+gmxtzBio6JHt6j76j+Kz1a
        gpjqu423aBm0afAaD9Pj5ik=
X-Google-Smtp-Source: APXvYqyJJQQ2ETun7iD0hIRNdgic1z/8IsL8ZaU82P/t/ySYsJ/h1Fsw0c0gWeeXyOwecY+vLIlUeA==
X-Received: by 2002:a1c:2d45:: with SMTP id t66mr18015246wmt.106.1556555958687;
        Mon, 29 Apr 2019 09:39:18 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b184sm28364wmh.17.2019.04.29.09.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 09:39:17 -0700 (PDT)
Date:   Mon, 29 Apr 2019 18:39:16 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] a2dp: Fix not calling SelectConfiguration on
 other available endpoints
Message-ID: <20190429163916.ngdqk437xbuahl4k@pali>
References: <20190429120259.17880-1-luiz.dentz@gmail.com>
 <20190429120259.17880-3-luiz.dentz@gmail.com>
 <CABBYNZK1LRANfR6cwu+xbLsvy4EnB+ZPS78JNK04mJ=pwTGSDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lv4xcf2gga6zz6ag"
Content-Disposition: inline
In-Reply-To: <CABBYNZK1LRANfR6cwu+xbLsvy4EnB+ZPS78JNK04mJ=pwTGSDw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--lv4xcf2gga6zz6ag
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 29 April 2019 19:35:24 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Mon, Apr 29, 2019 at 3:03 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > Endpoint may not be able to select a valid configuration but there could
> > be other endpoints available that could be used, so instead of just
> > using the first match this collects all the matching endpoints and put
> > them into a queue (ordered by priority) then proceed to next endpoint
> > only failing if none of the available endpoits can select a valid
> > configuration.
> > ---
> >  profiles/audio/a2dp.c | 77 ++++++++++++++++++++++++++++---------------
> >  1 file changed, 50 insertions(+), 27 deletions(-)
> >
> > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > index a23abdd97..4d378a91a 100644
> > --- a/profiles/audio/a2dp.c
> > +++ b/profiles/audio/a2dp.c
> > @@ -105,6 +105,7 @@ struct a2dp_setup_cb {
> >  struct a2dp_setup {
> >         struct a2dp_channel *chan;
> >         struct avdtp *session;
> > +       struct queue *eps;
> >         struct a2dp_sep *sep;
> >         struct a2dp_remote_sep *rsep;
> >         struct avdtp_stream *stream;
> > @@ -2406,23 +2407,44 @@ void a2dp_remove_sep(struct a2dp_sep *sep)
> >
> >  static void select_cb(struct a2dp_setup *setup, void *ret, int size)
> >  {
> > -       if (size < 0) {
> > -               DBG("Endpoint replied an invalid configuration");
> > +       struct avdtp_service_capability *service;
> > +       struct avdtp_media_codec_capability *codec;
> > +       int err;
> > +
> > +       if (size) {
> > +               caps_add_codec(&setup->caps, setup->sep->codec, ret, si=
ze);
> >                 goto done;
> >         }
> >
> > -       caps_add_codec(&setup->caps, setup->sep->codec, ret, size);
> > +       setup->sep =3D queue_pop_head(setup->eps);
> > +       if (!setup->sep) {
> > +               error("Unable to select a valid configuration");
> > +               queue_destroy(setup->eps, NULL);
> > +               goto done;
> > +       }
> > +
> > +       setup->rsep =3D find_remote_sep(setup->chan, setup->sep);
> > +       service =3D avdtp_get_codec(setup->rsep->sep);
> > +       codec =3D (struct avdtp_media_codec_capability *) service->data;
> > +
> > +       err =3D setup->sep->endpoint->select_configuration(setup->sep,
> > +                                       codec->data,
> > +                                       service->length - sizeof(*codec=
),
> > +                                       setup_ref(setup),
> > +                                       select_cb, setup->sep->user_dat=
a);
> > +       if (err =3D=3D 0)
> > +               return;
> >
> >  done:
> >         finalize_select(setup);
> >         setup_unref(setup);
> >  }
> >
> > -static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *l=
ist,
> > +static struct queue *a2dp_find_eps(struct avdtp *session, GSList *list,
> >                                         const char *sender)
> >  {
> > -       struct a2dp_sep *first =3D NULL;
> >         struct a2dp_channel *chan =3D find_channel(session);
> > +       struct queue *seps =3D NULL;
> >
> >         for (; list; list =3D list->next) {
> >                 struct a2dp_sep *sep =3D list->data;
> > @@ -2444,26 +2466,25 @@ static struct a2dp_sep *a2dp_find_sep(struct av=
dtp *session, GSList *list,
> >                 if (!rsep)
> >                         continue;
> >
> > -               /* Locate last used if set */
> > -               if (chan->last_used) {
> > -                       if (chan->last_used->sep =3D=3D rsep)
> > -                               return sep;
> > -                       first =3D sep;
> > -                       continue;
> > -               }
> > +               if (!seps)
> > +                       seps =3D queue_new();
> >
> > -               return sep;
> > +               /* Prepend last used so it is preferred over others */
> > +               if (chan->last_used && chan->last_used->sep =3D=3D rsep)
> > +                       queue_push_head(seps, sep);
> > +               else
> > +                       queue_push_tail(seps, sep);
> >
> >         }
> >
> > -       return first;
> > +       return seps;
> >  }
> >
> > -static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t=
 type,
> > +static struct queue *a2dp_select_eps(struct avdtp *session, uint8_t ty=
pe,
> >                                         const char *sender)
> >  {
> >         struct a2dp_server *server;
> > -       struct a2dp_sep *sep;
> > +       struct queue *seps;
> >         GSList *l;
> >
> >         server =3D find_server(servers, avdtp_get_adapter(session));
> > @@ -2473,11 +2494,11 @@ static struct a2dp_sep *a2dp_select_sep(struct =
avdtp *session, uint8_t type,
> >         l =3D type =3D=3D AVDTP_SEP_TYPE_SINK ? server->sources : serve=
r->sinks;
> >
> >         /* Check sender's seps first */
> > -       sep =3D a2dp_find_sep(session, l, sender);
> > -       if (sep !=3D NULL)
> > -               return sep;
> > +       seps =3D a2dp_find_eps(session, l, sender);
> > +       if (seps !=3D NULL)
> > +               return seps;
> >
> > -       return a2dp_find_sep(session, l, NULL);
> > +       return a2dp_find_eps(session, l, NULL);
> >  }
> >
> >  static void store_remote_sep(void *data, void *user_data)
> > @@ -2580,13 +2601,13 @@ unsigned int a2dp_select_capabilities(struct av=
dtp *session,
> >  {
> >         struct a2dp_setup *setup;
> >         struct a2dp_setup_cb *cb_data;
> > -       struct a2dp_sep *sep;
> > +       struct queue *eps;
> >         struct avdtp_service_capability *service;
> >         struct avdtp_media_codec_capability *codec;
> >         int err;
> >
> > -       sep =3D a2dp_select_sep(session, type, sender);
> > -       if (!sep) {
> > +       eps =3D a2dp_select_eps(session, type, sender);
> > +       if (!eps) {
> >                 error("Unable to select SEP");
> >                 return 0;
> >         }
> > @@ -2599,8 +2620,9 @@ unsigned int a2dp_select_capabilities(struct avdt=
p *session,
> >         cb_data->select_cb =3D cb;
> >         cb_data->user_data =3D user_data;
> >
> > -       setup->sep =3D sep;
> > -       setup->rsep =3D find_remote_sep(setup->chan, sep);
> > +       setup->eps =3D eps;
> > +       setup->sep =3D queue_pop_head(eps);
> > +       setup->rsep =3D find_remote_sep(setup->chan, setup->sep);
> >
> >         if (setup->rsep =3D=3D NULL) {
> >                 error("Could not find remote sep");
> > @@ -2610,10 +2632,11 @@ unsigned int a2dp_select_capabilities(struct av=
dtp *session,
> >         service =3D avdtp_get_codec(setup->rsep->sep);
> >         codec =3D (struct avdtp_media_codec_capability *) service->data;
> >
> > -       err =3D sep->endpoint->select_configuration(sep, codec->data,
> > +       err =3D setup->sep->endpoint->select_configuration(setup->sep,
> > +                                       codec->data,
> >                                         service->length - sizeof(*codec=
),
> >                                         setup_ref(setup),
> > -                                       select_cb, sep->user_data);
> > +                                       select_cb, setup->sep->user_dat=
a);
> >         if (err =3D=3D 0)
> >                 return cb_data->id;
> >
> > --
> > 2.20.1
>=20
> Le me know if you find any problem with this change, my headsets seems
> to always succeed the first try so I cannot really reproduce the
> problem.

Ok, I will try it in next days. I can register PA endpoints which always
"fails" so I can test if this is working correctly as expected.

Btw, for future patches please directly CC them to me as I'm not
subscribed to list and either extracting them from '> ' quotes or
finding them in web archive is quite impractical.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--lv4xcf2gga6zz6ag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXMcosAAKCRCL8Mk9A+RD
Uo0PAJ9Sm5XK6j/r8ZmCBo3t6Y58qZLbowCfXfqQF7DhCeNUxfbMNKGHt0ZYj9U=
=mPSy
-----END PGP SIGNATURE-----

--lv4xcf2gga6zz6ag--
