Return-Path: <SRS0=qzIG=TC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F55BC43219
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 20:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90C520578
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 20:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nESwTzz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfEBUxy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 May 2019 16:53:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38036 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfEBUxx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 May 2019 16:53:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so4345054wmc.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2019 13:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iXC3zw8eSrGhtzl8bHHPX5qiVfexjy6fGPH2tbEyU2g=;
        b=nESwTzz3/CsfBHWE7+4jdjsdS3Svdd9n1p9jRwEpGetfpca4oJsvCzN7PcF8hB9s21
         aIeFWjumJDWDjQfg/Ro9J+4AhSkA0Mma40PSl3knNhsFvtayhVV55N1i1H4/laqWFhJx
         G8Fblou6T6NjegRqmTe47d6Mfcm4rysooo9W2610vI4BUPCFpM/AYB0WSdGSex3Wknu6
         /w5R2wwc/G9hjh8RycSfywOpKRDOWzW8pLedyRna8RDMs0CeucumDNc9PlETIpoBTslh
         dNHj8aKjnI9oH0LeLALsTI+ITTyGNjXkVEDweOmf/k/3IInM1ViE5ArkSdXYSlOSUQ6E
         W87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iXC3zw8eSrGhtzl8bHHPX5qiVfexjy6fGPH2tbEyU2g=;
        b=VujoK6DJCJMlirglMyB9Lt5NzOxOtM91VNdQC9+QVL5S+0kHQ44r5/xcfTMnrNeArO
         cRgbL0mxodUiGR1iVslkXOifbr7dkIeRXeV8h4JbA1ak2HoSpxJ5t6rTZtNjkVW5fMU+
         XP600KR0B74XZNuoQ/jKh5xQqv/ttS7D5oo22uvt1wnPrVUspoQpcfaa09XieR0VubqL
         w386te/WRzCKLZ55kVhfTa+9UKXPehv/1mnYxmx2JVEwe4qsJqH+5CbF/pGC2mUsnZ7D
         2vYP2ecO9/HocseiDWa39soRoxcUoYwtbJaSnrykmYBpqIijgsX3vlIOltgCxg0YKSoI
         JHSw==
X-Gm-Message-State: APjAAAXPByKXz+DSgvKRso4ZwR/w84+8f3wDDCCvJFUMqAQ8q+MZDtjW
        0mlatsBSQotvCGmP4jPltAs=
X-Google-Smtp-Source: APXvYqxOd97ulehllYnyC5LyQVcWpsxcCNsaYC8IirJdIl+dD+70LX5Tvy9OVneIVrOHJRk3bcY/og==
X-Received: by 2002:a1c:c54c:: with SMTP id v73mr47899wmf.85.1556830431588;
        Thu, 02 May 2019 13:53:51 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id 7sm135620wro.85.2019.05.02.13.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 13:53:50 -0700 (PDT)
Date:   Thu, 2 May 2019 22:53:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] a2dp: Fix not calling SelectConfiguration on
 other available endpoints
Message-ID: <20190502205349.rrg44khwuv2xaj6b@pali>
References: <20190429120259.17880-1-luiz.dentz@gmail.com>
 <20190429120259.17880-3-luiz.dentz@gmail.com>
 <CABBYNZK1LRANfR6cwu+xbLsvy4EnB+ZPS78JNK04mJ=pwTGSDw@mail.gmail.com>
 <20190429163916.ngdqk437xbuahl4k@pali>
 <20190502204155.mu4zavpotbujixrs@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xd3tjt5mgjw4kent"
Content-Disposition: inline
In-Reply-To: <20190502204155.mu4zavpotbujixrs@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--xd3tjt5mgjw4kent
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 02 May 2019 22:41:55 Pali Roh=C3=A1r wrote:
> On Monday 29 April 2019 18:39:16 Pali Roh=C3=A1r wrote:
> > On Monday 29 April 2019 19:35:24 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >=20
> > > On Mon, Apr 29, 2019 at 3:03 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >
> > > > Endpoint may not be able to select a valid configuration but there =
could
> > > > be other endpoints available that could be used, so instead of just
> > > > using the first match this collects all the matching endpoints and =
put
> > > > them into a queue (ordered by priority) then proceed to next endpoi=
nt
> > > > only failing if none of the available endpoits can select a valid
> > > > configuration.
> > > > ---
> > > >  profiles/audio/a2dp.c | 77 ++++++++++++++++++++++++++++-----------=
----
> > > >  1 file changed, 50 insertions(+), 27 deletions(-)
> > > >
> > > > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > > > index a23abdd97..4d378a91a 100644
> > > > --- a/profiles/audio/a2dp.c
> > > > +++ b/profiles/audio/a2dp.c
> > > > @@ -105,6 +105,7 @@ struct a2dp_setup_cb {
> > > >  struct a2dp_setup {
> > > >         struct a2dp_channel *chan;
> > > >         struct avdtp *session;
> > > > +       struct queue *eps;
> > > >         struct a2dp_sep *sep;
> > > >         struct a2dp_remote_sep *rsep;
> > > >         struct avdtp_stream *stream;
> > > > @@ -2406,23 +2407,44 @@ void a2dp_remove_sep(struct a2dp_sep *sep)
> > > >
> > > >  static void select_cb(struct a2dp_setup *setup, void *ret, int siz=
e)
> > > >  {
> > > > -       if (size < 0) {
> > > > -               DBG("Endpoint replied an invalid configuration");
> > > > +       struct avdtp_service_capability *service;
> > > > +       struct avdtp_media_codec_capability *codec;
> > > > +       int err;
> > > > +
> > > > +       if (size) {
> > > > +               caps_add_codec(&setup->caps, setup->sep->codec, ret=
, size);
> > > >                 goto done;
> > > >         }
> > > >
> > > > -       caps_add_codec(&setup->caps, setup->sep->codec, ret, size);
> > > > +       setup->sep =3D queue_pop_head(setup->eps);
> > > > +       if (!setup->sep) {
> > > > +               error("Unable to select a valid configuration");
> > > > +               queue_destroy(setup->eps, NULL);
> > > > +               goto done;
> > > > +       }
> > > > +
> > > > +       setup->rsep =3D find_remote_sep(setup->chan, setup->sep);
> > > > +       service =3D avdtp_get_codec(setup->rsep->sep);
> > > > +       codec =3D (struct avdtp_media_codec_capability *) service->=
data;
> > > > +
> > > > +       err =3D setup->sep->endpoint->select_configuration(setup->s=
ep,
> > > > +                                       codec->data,
> > > > +                                       service->length - sizeof(*c=
odec),
> > > > +                                       setup_ref(setup),
> > > > +                                       select_cb, setup->sep->user=
_data);
> > > > +       if (err =3D=3D 0)
> > > > +               return;
> > > >
> > > >  done:
> > > >         finalize_select(setup);
> > > >         setup_unref(setup);
> > > >  }
> > > >
> > > > -static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSLis=
t *list,
> > > > +static struct queue *a2dp_find_eps(struct avdtp *session, GSList *=
list,
> > > >                                         const char *sender)
> > > >  {
> > > > -       struct a2dp_sep *first =3D NULL;
> > > >         struct a2dp_channel *chan =3D find_channel(session);
> > > > +       struct queue *seps =3D NULL;
> > > >
> > > >         for (; list; list =3D list->next) {
> > > >                 struct a2dp_sep *sep =3D list->data;
> > > > @@ -2444,26 +2466,25 @@ static struct a2dp_sep *a2dp_find_sep(struc=
t avdtp *session, GSList *list,
> > > >                 if (!rsep)
> > > >                         continue;
> > > >
> > > > -               /* Locate last used if set */
> > > > -               if (chan->last_used) {
> > > > -                       if (chan->last_used->sep =3D=3D rsep)
> > > > -                               return sep;
> > > > -                       first =3D sep;
> > > > -                       continue;
> > > > -               }
> > > > +               if (!seps)
> > > > +                       seps =3D queue_new();
> > > >
> > > > -               return sep;
> > > > +               /* Prepend last used so it is preferred over others=
 */
> > > > +               if (chan->last_used && chan->last_used->sep =3D=3D =
rsep)
> > > > +                       queue_push_head(seps, sep);
> > > > +               else
> > > > +                       queue_push_tail(seps, sep);
> > > >
> > > >         }
> > > >
> > > > -       return first;
> > > > +       return seps;
> > > >  }
> > > >
> > > > -static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uin=
t8_t type,
> > > > +static struct queue *a2dp_select_eps(struct avdtp *session, uint8_=
t type,
> > > >                                         const char *sender)
> > > >  {
> > > >         struct a2dp_server *server;
> > > > -       struct a2dp_sep *sep;
> > > > +       struct queue *seps;
> > > >         GSList *l;
> > > >
> > > >         server =3D find_server(servers, avdtp_get_adapter(session));
> > > > @@ -2473,11 +2494,11 @@ static struct a2dp_sep *a2dp_select_sep(str=
uct avdtp *session, uint8_t type,
> > > >         l =3D type =3D=3D AVDTP_SEP_TYPE_SINK ? server->sources : s=
erver->sinks;
> > > >
> > > >         /* Check sender's seps first */
> > > > -       sep =3D a2dp_find_sep(session, l, sender);
> > > > -       if (sep !=3D NULL)
> > > > -               return sep;
> > > > +       seps =3D a2dp_find_eps(session, l, sender);
> > > > +       if (seps !=3D NULL)
> > > > +               return seps;
> > > >
> > > > -       return a2dp_find_sep(session, l, NULL);
> > > > +       return a2dp_find_eps(session, l, NULL);
> > > >  }
> > > >
> > > >  static void store_remote_sep(void *data, void *user_data)
> > > > @@ -2580,13 +2601,13 @@ unsigned int a2dp_select_capabilities(struc=
t avdtp *session,
> > > >  {
> > > >         struct a2dp_setup *setup;
> > > >         struct a2dp_setup_cb *cb_data;
> > > > -       struct a2dp_sep *sep;
> > > > +       struct queue *eps;
> > > >         struct avdtp_service_capability *service;
> > > >         struct avdtp_media_codec_capability *codec;
> > > >         int err;
> > > >
> > > > -       sep =3D a2dp_select_sep(session, type, sender);
> > > > -       if (!sep) {
> > > > +       eps =3D a2dp_select_eps(session, type, sender);
> > > > +       if (!eps) {
> > > >                 error("Unable to select SEP");
> > > >                 return 0;
> > > >         }
> > > > @@ -2599,8 +2620,9 @@ unsigned int a2dp_select_capabilities(struct =
avdtp *session,
> > > >         cb_data->select_cb =3D cb;
> > > >         cb_data->user_data =3D user_data;
> > > >
> > > > -       setup->sep =3D sep;
> > > > -       setup->rsep =3D find_remote_sep(setup->chan, sep);
> > > > +       setup->eps =3D eps;
> > > > +       setup->sep =3D queue_pop_head(eps);
> > > > +       setup->rsep =3D find_remote_sep(setup->chan, setup->sep);
> > > >
> > > >         if (setup->rsep =3D=3D NULL) {
> > > >                 error("Could not find remote sep");
> > > > @@ -2610,10 +2632,11 @@ unsigned int a2dp_select_capabilities(struc=
t avdtp *session,
> > > >         service =3D avdtp_get_codec(setup->rsep->sep);
> > > >         codec =3D (struct avdtp_media_codec_capability *) service->=
data;
> > > >
> > > > -       err =3D sep->endpoint->select_configuration(sep, codec->dat=
a,
> > > > +       err =3D setup->sep->endpoint->select_configuration(setup->s=
ep,
> > > > +                                       codec->data,
> > > >                                         service->length - sizeof(*c=
odec),
> > > >                                         setup_ref(setup),
> > > > -                                       select_cb, sep->user_data);
> > > > +                                       select_cb, setup->sep->user=
_data);
> > > >         if (err =3D=3D 0)
> > > >                 return cb_data->id;
> > > >
> > > > --
> > > > 2.20.1
> > >=20
> > > Le me know if you find any problem with this change, my headsets seems
> > > to always succeed the first try so I cannot really reproduce the
> > > problem.
> >=20
> > Ok, I will try it in next days. I can register PA endpoints which always
> > "fails" so I can test if this is working correctly as expected.
>=20
> Nope, this your patch does not work. It cause segfaulting of bluetoothd
> daemon itself. Here is stacktrace of current git master branch (where is
> your patch too):
>=20
> Program received signal SIGSEGV, Segmentation fault.
> __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-ve=
c-unaligned-erms.S:416
> 416     ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S: Adres=
=C3=A1r alebo s=C3=BAbor neexistuje.
> (gdb) bt
> #0  __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmov=
e-vec-unaligned-erms.S:416
> #1  0x0000557d2d2f3164 in caps_add_codec (l=3D0x557d2f1a9708, codec=3D<op=
timized out>, caps=3D0x0, size=3D18446744073709551615) at profiles/audio/a2=
dp.c:1519
> #2  0x0000557d2d2f626a in select_cb (setup=3D0x557d2f1a96c0, ret=3D<optim=
ized out>, size=3D<optimized out>) at profiles/audio/a2dp.c:2422
> #3  0x0000557d2d2fe016 in endpoint_reply (call=3D<optimized out>, user_da=
ta=3D0x557d2f187810) at profiles/audio/media.c:316
> #4  0x00007fd2dc6aa002 in ?? () from /lib/x86_64-linux-gnu/libdbus-1.so.3
> #5  0x00007fd2dc6ada5f in dbus_connection_dispatch () from /lib/x86_64-li=
nux-gnu/libdbus-1.so.3
> #6  0x0000557d2d36f320 in message_dispatch (data=3D0x557d2f184560) at gdb=
us/mainloop.c:72
> #7  0x00007fd2dc9326aa in g_main_context_dispatch () from /lib/x86_64-lin=
ux-gnu/libglib-2.0.so.0
> #8  0x00007fd2dc932a60 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so=
=2E0
> #9  0x00007fd2dc932d82 in g_main_loop_run () from /lib/x86_64-linux-gnu/l=
ibglib-2.0.so.0
> #10 0x0000557d2d384a45 in mainloop_run () at src/shared/mainloop-glib.c:79
> #11 0x0000557d2d384e0f in mainloop_run_with_signal (func=3D<optimized out=
>, user_data=3D0x0) at src/shared/mainloop-notify.c:201
> #12 0x0000557d2d2eb0a8 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>) at src/main.c:729
>=20
> In syslog for bluetoothd is this last line:
> bluetoothd[12605]: Endpoint replied with an error: org.bluez.Error.Invali=
dArguments
>=20
> pulseaudio refused only one SelectConfiguration call.

In profiles/audio/a2dp.c is:

static void select_cb(struct a2dp_setup *setup, void *ret, int size)
{
=2E..
	if (size) {
		caps_add_codec(&setup->caps, setup->sep->codec, ret, size);
=2E..

and then there is:

tatic void caps_add_codec(GSList **l, uint8_t codec, uint8_t *caps,
							size_t size)
{
=2E..
	memcpy(cap->data, caps, size);
=2E..

When select_cb() is called with size=3D-1 then is calls caps_add_codec()
as size is non-zero and cast signed 32bit int -1 to unsigned 64bit int
as value 2^64-1. Later is called memcpy with size 2^64-1 and crash is
there. Moreover caps is NULLL pointer, therefore void *ret in select_cb
is NULL too. Seems like wrong error handling in select_cb() function.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--xd3tjt5mgjw4kent
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXMtY2wAKCRCL8Mk9A+RD
UpzuAJ0RglChM6gkwOCh99UnJET+MgcpbgCbB9De81rJJf/HK1A/ew1PWajk+v8=
=i1D0
-----END PGP SIGNATURE-----

--xd3tjt5mgjw4kent--
