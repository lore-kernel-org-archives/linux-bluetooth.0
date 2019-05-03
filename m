Return-Path: <SRS0=8q+o=TD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15111C43219
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 09:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA437206C3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 09:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEPqyOva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfECJTD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 May 2019 05:19:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38131 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfECJTD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 May 2019 05:19:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id f2so919875wmj.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 May 2019 02:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vP60vXpLueo3ijcU3fXFDDOlVepR69JEl2rEfWFUL30=;
        b=NEPqyOvaMPDbkQTsoDevruCv0SMOETRVc10RRQi9GiZT+EFgvK1VOJ/Q2Rr8p1oujk
         1nwuhNZHe1qHeG8POhuZ4NIasVGxvUioMEHgdz3TgR/TM+b5ryrw9jcXV77YwmhLn4ly
         fyq5KxsBhPn/S/+D3eEo+oirq85pX0e3UkL38RFXP4BDqTMgYD9MKhtl4w+dtJsEzlz3
         5ySa2IxH7BqrJra8xWh/DcI3QlBwe+f5xAKr+hX9sBS2m07k7OMGb7G+f34TnKrhqewv
         ZksRv4awFUA6qBlxssFGNEfLnWSCsZNHdcld4RhtrU2QqWti3Ax+6vlDUo6d04cHa6Bs
         z+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vP60vXpLueo3ijcU3fXFDDOlVepR69JEl2rEfWFUL30=;
        b=fLemBn7D8QbN6s7HzNpw5L03sKuIGuNieaeiZZIXd4hKTCeoxtcha0MLeUsIyMV/xv
         xxKzZL6oe4337Je4wiEKvoP2xugih9nalNGlnPCSy6mbtzLaEewXqJKtL9wVwauJyLtx
         bz7LC1oreDmlFbY8/NiVpsPbXPHFJRBOTxhCqfx7Eyxw5BennWlXtRRj67wiHF+5aQxR
         Q7hsX801q7326MwUgSv6hSC5tEtCteDbJvxlpN6zB8weDArfV+23PJCCLWDVm8aj9iH2
         jEXFt8VB/kvzRBdE5s/oVu/gQF1U6BpMQ61ClM0DsvhkhNkixftw8Fqt5DkWdJa/5u9/
         npxQ==
X-Gm-Message-State: APjAAAVhYZMYHF7+TaMp9XQ86e2MGpmQIuDuPRJjE6ccjUhrBBiHZpVv
        h7gQrosHaVspaXetg3nsjqRiQgod
X-Google-Smtp-Source: APXvYqz5ofaL2a6xGBPxp+etVynh883mwzjVNrtdW27/aFvTCDx+awGwLKLd5AEMUi+TUXtLFRSfFA==
X-Received: by 2002:a1c:5f42:: with SMTP id t63mr5162909wmb.94.1556875139384;
        Fri, 03 May 2019 02:18:59 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id e5sm1211679wrh.79.2019.05.03.02.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 02:18:58 -0700 (PDT)
Date:   Fri, 3 May 2019 11:18:57 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] a2dp: Fix not calling SelectConfiguration on
 other available endpoints
Message-ID: <20190503091857.qatz3sfx5utxte6s@pali>
References: <20190429120259.17880-1-luiz.dentz@gmail.com>
 <20190429120259.17880-3-luiz.dentz@gmail.com>
 <CABBYNZK1LRANfR6cwu+xbLsvy4EnB+ZPS78JNK04mJ=pwTGSDw@mail.gmail.com>
 <20190429163916.ngdqk437xbuahl4k@pali>
 <20190502204155.mu4zavpotbujixrs@pali>
 <20190502205349.rrg44khwuv2xaj6b@pali>
 <20190502205836.hxcdip7a3wt6xy3y@pali>
 <20190502211054.edon3q2l3kacwsv4@pali>
 <CABBYNZJq5ODCuaQHbPOpcx_Sju7M-fcV9iHiXNNpFjFhhCFpCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="y4w7i7bucnrtehir"
Content-Disposition: inline
In-Reply-To: <CABBYNZJq5ODCuaQHbPOpcx_Sju7M-fcV9iHiXNNpFjFhhCFpCw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--y4w7i7bucnrtehir
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 03 May 2019 11:55:38 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Fri, May 3, 2019 at 12:10 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > On Thursday 02 May 2019 22:58:36 Pali Roh=C3=A1r wrote:
> > > On Thursday 02 May 2019 22:53:49 Pali Roh=C3=A1r wrote:
> > > > On Thursday 02 May 2019 22:41:55 Pali Roh=C3=A1r wrote:
> > > > > On Monday 29 April 2019 18:39:16 Pali Roh=C3=A1r wrote:
> > > > > > On Monday 29 April 2019 19:35:24 Luiz Augusto von Dentz wrote:
> > > > > > > Hi Pali,
> > > > > > >
> > > > > > > On Mon, Apr 29, 2019 at 3:03 PM Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > > >
> > > > > > > > Endpoint may not be able to select a valid configuration bu=
t there could
> > > > > > > > be other endpoints available that could be used, so instead=
 of just
> > > > > > > > using the first match this collects all the matching endpoi=
nts and put
> > > > > > > > them into a queue (ordered by priority) then proceed to nex=
t endpoint
> > > > > > > > only failing if none of the available endpoits can select a=
 valid
> > > > > > > > configuration.
> > > > > > > > ---
> > > > > > > >  profiles/audio/a2dp.c | 77 ++++++++++++++++++++++++++++---=
------------
> > > > > > > >  1 file changed, 50 insertions(+), 27 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > > > > > > > index a23abdd97..4d378a91a 100644
> > > > > > > > --- a/profiles/audio/a2dp.c
> > > > > > > > +++ b/profiles/audio/a2dp.c
> > > > > > > > @@ -105,6 +105,7 @@ struct a2dp_setup_cb {
> > > > > > > >  struct a2dp_setup {
> > > > > > > >         struct a2dp_channel *chan;
> > > > > > > >         struct avdtp *session;
> > > > > > > > +       struct queue *eps;
> > > > > > > >         struct a2dp_sep *sep;
> > > > > > > >         struct a2dp_remote_sep *rsep;
> > > > > > > >         struct avdtp_stream *stream;
> > > > > > > > @@ -2406,23 +2407,44 @@ void a2dp_remove_sep(struct a2dp_se=
p *sep)
> > > > > > > >
> > > > > > > >  static void select_cb(struct a2dp_setup *setup, void *ret,=
 int size)
> > > > > > > >  {
> > > > > > > > -       if (size < 0) {
> > > > > > > > -               DBG("Endpoint replied an invalid configurat=
ion");
> > > > > > > > +       struct avdtp_service_capability *service;
> > > > > > > > +       struct avdtp_media_codec_capability *codec;
> > > > > > > > +       int err;
> > > > > > > > +
> > > > > > > > +       if (size) {
> > > > > > > > +               caps_add_codec(&setup->caps, setup->sep->co=
dec, ret, size);
> > > > > > > >                 goto done;
> > > > > > > >         }
> > > > > > > >
> > > > > > > > -       caps_add_codec(&setup->caps, setup->sep->codec, ret=
, size);
> > > > > > > > +       setup->sep =3D queue_pop_head(setup->eps);
> > > > > > > > +       if (!setup->sep) {
> > > > > > > > +               error("Unable to select a valid configurati=
on");
> > > > > > > > +               queue_destroy(setup->eps, NULL);
> > > > > > > > +               goto done;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       setup->rsep =3D find_remote_sep(setup->chan, setup-=
>sep);
> > > > > > > > +       service =3D avdtp_get_codec(setup->rsep->sep);
> > > > > > > > +       codec =3D (struct avdtp_media_codec_capability *) s=
ervice->data;
> > > > > > > > +
> > > > > > > > +       err =3D setup->sep->endpoint->select_configuration(=
setup->sep,
> > > > > > > > +                                       codec->data,
> > > > > > > > +                                       service->length - s=
izeof(*codec),
> > > > > > > > +                                       setup_ref(setup),
> > > > > > > > +                                       select_cb, setup->s=
ep->user_data);
> > > > > > > > +       if (err =3D=3D 0)
> > > > > > > > +               return;
> > > > > > > >
> > > > > > > >  done:
> > > > > > > >         finalize_select(setup);
> > > > > > > >         setup_unref(setup);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -static struct a2dp_sep *a2dp_find_sep(struct avdtp *sessio=
n, GSList *list,
> > > > > > > > +static struct queue *a2dp_find_eps(struct avdtp *session, =
GSList *list,
> > > > > > > >                                         const char *sender)
> > > > > > > >  {
> > > > > > > > -       struct a2dp_sep *first =3D NULL;
> > > > > > > >         struct a2dp_channel *chan =3D find_channel(session);
> > > > > > > > +       struct queue *seps =3D NULL;
> > > > > > > >
> > > > > > > >         for (; list; list =3D list->next) {
> > > > > > > >                 struct a2dp_sep *sep =3D list->data;
> > > > > > > > @@ -2444,26 +2466,25 @@ static struct a2dp_sep *a2dp_find_s=
ep(struct avdtp *session, GSList *list,
> > > > > > > >                 if (!rsep)
> > > > > > > >                         continue;
> > > > > > > >
> > > > > > > > -               /* Locate last used if set */
> > > > > > > > -               if (chan->last_used) {
> > > > > > > > -                       if (chan->last_used->sep =3D=3D rse=
p)
> > > > > > > > -                               return sep;
> > > > > > > > -                       first =3D sep;
> > > > > > > > -                       continue;
> > > > > > > > -               }
> > > > > > > > +               if (!seps)
> > > > > > > > +                       seps =3D queue_new();
> > > > > > > >
> > > > > > > > -               return sep;
> > > > > > > > +               /* Prepend last used so it is preferred ove=
r others */
> > > > > > > > +               if (chan->last_used && chan->last_used->sep=
 =3D=3D rsep)
> > > > > > > > +                       queue_push_head(seps, sep);
> > > > > > > > +               else
> > > > > > > > +                       queue_push_tail(seps, sep);
> > > > > > > >
> > > > > > > >         }
> > > > > > > >
> > > > > > > > -       return first;
> > > > > > > > +       return seps;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -static struct a2dp_sep *a2dp_select_sep(struct avdtp *sess=
ion, uint8_t type,
> > > > > > > > +static struct queue *a2dp_select_eps(struct avdtp *session=
, uint8_t type,
> > > > > > > >                                         const char *sender)
> > > > > > > >  {
> > > > > > > >         struct a2dp_server *server;
> > > > > > > > -       struct a2dp_sep *sep;
> > > > > > > > +       struct queue *seps;
> > > > > > > >         GSList *l;
> > > > > > > >
> > > > > > > >         server =3D find_server(servers, avdtp_get_adapter(s=
ession));
> > > > > > > > @@ -2473,11 +2494,11 @@ static struct a2dp_sep *a2dp_select=
_sep(struct avdtp *session, uint8_t type,
> > > > > > > >         l =3D type =3D=3D AVDTP_SEP_TYPE_SINK ? server->sou=
rces : server->sinks;
> > > > > > > >
> > > > > > > >         /* Check sender's seps first */
> > > > > > > > -       sep =3D a2dp_find_sep(session, l, sender);
> > > > > > > > -       if (sep !=3D NULL)
> > > > > > > > -               return sep;
> > > > > > > > +       seps =3D a2dp_find_eps(session, l, sender);
> > > > > > > > +       if (seps !=3D NULL)
> > > > > > > > +               return seps;
> > > > > > > >
> > > > > > > > -       return a2dp_find_sep(session, l, NULL);
> > > > > > > > +       return a2dp_find_eps(session, l, NULL);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static void store_remote_sep(void *data, void *user_data)
> > > > > > > > @@ -2580,13 +2601,13 @@ unsigned int a2dp_select_capabiliti=
es(struct avdtp *session,
> > > > > > > >  {
> > > > > > > >         struct a2dp_setup *setup;
> > > > > > > >         struct a2dp_setup_cb *cb_data;
> > > > > > > > -       struct a2dp_sep *sep;
> > > > > > > > +       struct queue *eps;
> > > > > > > >         struct avdtp_service_capability *service;
> > > > > > > >         struct avdtp_media_codec_capability *codec;
> > > > > > > >         int err;
> > > > > > > >
> > > > > > > > -       sep =3D a2dp_select_sep(session, type, sender);
> > > > > > > > -       if (!sep) {
> > > > > > > > +       eps =3D a2dp_select_eps(session, type, sender);
> > > > > > > > +       if (!eps) {
> > > > > > > >                 error("Unable to select SEP");
> > > > > > > >                 return 0;
> > > > > > > >         }
> > > > > > > > @@ -2599,8 +2620,9 @@ unsigned int a2dp_select_capabilities=
(struct avdtp *session,
> > > > > > > >         cb_data->select_cb =3D cb;
> > > > > > > >         cb_data->user_data =3D user_data;
> > > > > > > >
> > > > > > > > -       setup->sep =3D sep;
> > > > > > > > -       setup->rsep =3D find_remote_sep(setup->chan, sep);
> > > > > > > > +       setup->eps =3D eps;
> > > > > > > > +       setup->sep =3D queue_pop_head(eps);
> > > > > > > > +       setup->rsep =3D find_remote_sep(setup->chan, setup-=
>sep);
> > > > > > > >
> > > > > > > >         if (setup->rsep =3D=3D NULL) {
> > > > > > > >                 error("Could not find remote sep");
> > > > > > > > @@ -2610,10 +2632,11 @@ unsigned int a2dp_select_capabiliti=
es(struct avdtp *session,
> > > > > > > >         service =3D avdtp_get_codec(setup->rsep->sep);
> > > > > > > >         codec =3D (struct avdtp_media_codec_capability *) s=
ervice->data;
> > > > > > > >
> > > > > > > > -       err =3D sep->endpoint->select_configuration(sep, co=
dec->data,
> > > > > > > > +       err =3D setup->sep->endpoint->select_configuration(=
setup->sep,
> > > > > > > > +                                       codec->data,
> > > > > > > >                                         service->length - s=
izeof(*codec),
> > > > > > > >                                         setup_ref(setup),
> > > > > > > > -                                       select_cb, sep->use=
r_data);
> > > > > > > > +                                       select_cb, setup->s=
ep->user_data);
> > > > > > > >         if (err =3D=3D 0)
> > > > > > > >                 return cb_data->id;
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.20.1
> > > > > > >
> > > > > > > Le me know if you find any problem with this change, my heads=
ets seems
> > > > > > > to always succeed the first try so I cannot really reproduce =
the
> > > > > > > problem.
> > > > > >
> > > > > > Ok, I will try it in next days. I can register PA endpoints whi=
ch always
> > > > > > "fails" so I can test if this is working correctly as expected.
> > > > >
> > > > > Nope, this your patch does not work. It cause segfaulting of blue=
toothd
> > > > > daemon itself. Here is stacktrace of current git master branch (w=
here is
> > > > > your patch too):
> > > > >
> > > > > Program received signal SIGSEGV, Segmentation fault.
> > > > > __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/me=
mmove-vec-unaligned-erms.S:416
> > > > > 416     ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:=
 Adres=C3=A1r alebo s=C3=BAbor neexistuje.
> > > > > (gdb) bt
> > > > > #0  __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarc=
h/memmove-vec-unaligned-erms.S:416
> > > > > #1  0x0000557d2d2f3164 in caps_add_codec (l=3D0x557d2f1a9708, cod=
ec=3D<optimized out>, caps=3D0x0, size=3D18446744073709551615) at profiles/=
audio/a2dp.c:1519
> > > > > #2  0x0000557d2d2f626a in select_cb (setup=3D0x557d2f1a96c0, ret=
=3D<optimized out>, size=3D<optimized out>) at profiles/audio/a2dp.c:2422
> > > > > #3  0x0000557d2d2fe016 in endpoint_reply (call=3D<optimized out>,=
 user_data=3D0x557d2f187810) at profiles/audio/media.c:316
> > > > > #4  0x00007fd2dc6aa002 in ?? () from /lib/x86_64-linux-gnu/libdbu=
s-1.so.3
> > > > > #5  0x00007fd2dc6ada5f in dbus_connection_dispatch () from /lib/x=
86_64-linux-gnu/libdbus-1.so.3
> > > > > #6  0x0000557d2d36f320 in message_dispatch (data=3D0x557d2f184560=
) at gdbus/mainloop.c:72
> > > > > #7  0x00007fd2dc9326aa in g_main_context_dispatch () from /lib/x8=
6_64-linux-gnu/libglib-2.0.so.0
> > > > > #8  0x00007fd2dc932a60 in ?? () from /lib/x86_64-linux-gnu/libgli=
b-2.0.so.0
> > > > > #9  0x00007fd2dc932d82 in g_main_loop_run () from /lib/x86_64-lin=
ux-gnu/libglib-2.0.so.0
> > > > > #10 0x0000557d2d384a45 in mainloop_run () at src/shared/mainloop-=
glib.c:79
> > > > > #11 0x0000557d2d384e0f in mainloop_run_with_signal (func=3D<optim=
ized out>, user_data=3D0x0) at src/shared/mainloop-notify.c:201
> > > > > #12 0x0000557d2d2eb0a8 in main (argc=3D<optimized out>, argv=3D<o=
ptimized out>) at src/main.c:729
> > > > >
> > > > > In syslog for bluetoothd is this last line:
> > > > > bluetoothd[12605]: Endpoint replied with an error: org.bluez.Erro=
r.InvalidArguments
> > > > >
> > > > > pulseaudio refused only one SelectConfiguration call.
> > > >
> > > > In profiles/audio/a2dp.c is:
> > > >
> > > > static void select_cb(struct a2dp_setup *setup, void *ret, int size)
> > > > {
> > > > ...
> > > >     if (size) {
> > > >             caps_add_codec(&setup->caps, setup->sep->codec, ret, si=
ze);
> > > > ...
> > > >
> > > > and then there is:
> > > >
> > > > tatic void caps_add_codec(GSList **l, uint8_t codec, uint8_t *caps,
> > > >                                                     size_t size)
> > > > {
> > > > ...
> > > >     memcpy(cap->data, caps, size);
> > > > ...
> > > >
> > > > When select_cb() is called with size=3D-1 then is calls caps_add_co=
dec()
> > > > as size is non-zero and cast signed 32bit int -1 to unsigned 64bit =
int
> > > > as value 2^64-1. Later is called memcpy with size 2^64-1 and crash =
is
> > > > there. Moreover caps is NULLL pointer, therefore void *ret in selec=
t_cb
> > > > is NULL too. Seems like wrong error handling in select_cb() functio=
n.
> > >
> > > And seems that ret=3DNULL and size=3D-1 comes from media.c endpoint_r=
eply()
> > > functions. As those values are defaults... Maybe it is a bug here?
> >
> > Here is patch which fixes above problem with crashing:
> >
> > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > index d0676b577..b06eafae0 100644
> > --- a/profiles/audio/a2dp.c
> > +++ b/profiles/audio/a2dp.c
> > @@ -1703,7 +1703,7 @@ static DBusMessage *set_configuration(DBusConnect=
ion *conn, DBusMessage *msg,
> >         if (dbus_message_iter_get_arg_type(&props) !=3D DBUS_TYPE_DICT_=
ENTRY)
> >                 return btd_error_invalid_args(msg);
> >
> > -       if (parse_properties(&props, &caps, &size) < 0)
> > +       if (parse_properties(&props, &caps, &size) < 0 || size <=3D 0)
> >                 return btd_error_invalid_args(msg);
> >
> >         err =3D a2dp_reconfig(chan, sender, lsep, rsep, caps, size,
> > @@ -2418,7 +2418,7 @@ static void select_cb(struct a2dp_setup *setup, v=
oid *ret, int size)
> >         struct avdtp_media_codec_capability *codec;
> >         int err;
> >
> > -       if (size) {
> > +       if (ret && size > 0) {
> >                 caps_add_codec(&setup->caps, setup->sep->codec, ret, si=
ze);
> >                 goto done;
> >         }
>=20
> Ive sent a similar fix, there is also a patch to abort if stream
> cannot be closed when switching streams. Regarding the endpoint
> selection it seems to be working correctly at least it does choose the
> endpoints in the order they are registered.

Ok, seems that crashing with those 3 patches on ML is fixed.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--y4w7i7bucnrtehir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXMwHfwAKCRCL8Mk9A+RD
UpROAJ49Qt0F7XSIW6RuPvEAEwHwPGRCHgCfX5WUKSWil+aYU9o3/J+4oJha4R8=
=uvYD
-----END PGP SIGNATURE-----

--y4w7i7bucnrtehir--
