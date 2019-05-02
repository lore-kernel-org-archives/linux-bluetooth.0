Return-Path: <SRS0=qzIG=TC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93713C43219
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 20:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494AE2063F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 20:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOAfCYCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEBU6k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 May 2019 16:58:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46124 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBU6k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 May 2019 16:58:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so5185242wrr.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2019 13:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rY7kEXBK2UHLOWrzhvrnev9amzj832Lqb5KHUminhk8=;
        b=IOAfCYCgSvmdAYHKHzTrBQVKXRFRBAplge5Lbu7wFe8a4vxwCP2q0TCz+aSVvmIT2u
         Phs4YI7pDbHbxKpz49FLB6tsmL0SBq2nxo9Ga0FG1V+ds33fO+0HegO/vOpqz56rqAh2
         proGaDMr2FgXDrZ3IKC7nFAfE+I4LJJ+4MvFH6I20bO+Lu6nJN3fsldUp9gvjZQiNdRB
         5IHzbeVaCB3fqa4T3rCMK/5DcQB/lJchO4JUoOBVrQmxQK2DqKwhGskRbdPI/PKtIqmh
         7w0gaZKjqLddRLl1+VqOu+C3r+YpBII6vD+sR4DXBE/t0M4TD8PCUjQP+AS7XXQ3asU+
         Vmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rY7kEXBK2UHLOWrzhvrnev9amzj832Lqb5KHUminhk8=;
        b=GjOmmCypNl9SBn2dXyWwUe5wewe9LUei3jsVTutvH4UiJZDCmre75gg3ElwZeHzKdL
         tzhVyaCGdSyhrl1tyReeutbcqFQivfh91tadMMd7dtZtgAM696RntooONE3KPN2BaaXi
         cz+mORgLEuttI8k3o0b2+ClguMbatXXwL4rZzw88S7ureS41DISeIGtJeLmFZ/25tcDx
         qONKyZOa5/veKekiJO3J/PYDpHrBXAKk3yzqTzWGsYwmhutDWXlhYyldENpZA7MW+ZZU
         pgDOFH34d6/dqv7mQ6Bwf4WWun9Tqvpt3aOH4j/3b7XI9giMjkkS7yGyON3JG4d7SlYN
         wnnA==
X-Gm-Message-State: APjAAAUwjekBz/kDQ6XW2zy1GV4uwXonuhwOTNwY1AV8rbU6OrY1KVmZ
        l3G+b47Ma7Z2BeEh0QFf2FSoHPIw
X-Google-Smtp-Source: APXvYqwmecn7IeLDVOPzugPWuVYW8VDMyR5fJx+ISDCXKmk4e7yAL4CHQyPB2Xp0X9Qh8Lfprq8+yQ==
X-Received: by 2002:adf:f50e:: with SMTP id q14mr4396009wro.48.1556830718201;
        Thu, 02 May 2019 13:58:38 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x18sm343764wrw.14.2019.05.02.13.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 13:58:37 -0700 (PDT)
Date:   Thu, 2 May 2019 22:58:36 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] a2dp: Fix not calling SelectConfiguration on
 other available endpoints
Message-ID: <20190502205836.hxcdip7a3wt6xy3y@pali>
References: <20190429120259.17880-1-luiz.dentz@gmail.com>
 <20190429120259.17880-3-luiz.dentz@gmail.com>
 <CABBYNZK1LRANfR6cwu+xbLsvy4EnB+ZPS78JNK04mJ=pwTGSDw@mail.gmail.com>
 <20190429163916.ngdqk437xbuahl4k@pali>
 <20190502204155.mu4zavpotbujixrs@pali>
 <20190502205349.rrg44khwuv2xaj6b@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ccze2worxhbu2eei"
Content-Disposition: inline
In-Reply-To: <20190502205349.rrg44khwuv2xaj6b@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--ccze2worxhbu2eei
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 02 May 2019 22:53:49 Pali Roh=C3=A1r wrote:
> On Thursday 02 May 2019 22:41:55 Pali Roh=C3=A1r wrote:
> > On Monday 29 April 2019 18:39:16 Pali Roh=C3=A1r wrote:
> > > On Monday 29 April 2019 19:35:24 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >=20
> > > > On Mon, Apr 29, 2019 at 3:03 PM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > >
> > > > > Endpoint may not be able to select a valid configuration but ther=
e could
> > > > > be other endpoints available that could be used, so instead of ju=
st
> > > > > using the first match this collects all the matching endpoints an=
d put
> > > > > them into a queue (ordered by priority) then proceed to next endp=
oint
> > > > > only failing if none of the available endpoits can select a valid
> > > > > configuration.
> > > > > ---
> > > > >  profiles/audio/a2dp.c | 77 ++++++++++++++++++++++++++++---------=
------
> > > > >  1 file changed, 50 insertions(+), 27 deletions(-)
> > > > >
> > > > > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > > > > index a23abdd97..4d378a91a 100644
> > > > > --- a/profiles/audio/a2dp.c
> > > > > +++ b/profiles/audio/a2dp.c
> > > > > @@ -105,6 +105,7 @@ struct a2dp_setup_cb {
> > > > >  struct a2dp_setup {
> > > > >         struct a2dp_channel *chan;
> > > > >         struct avdtp *session;
> > > > > +       struct queue *eps;
> > > > >         struct a2dp_sep *sep;
> > > > >         struct a2dp_remote_sep *rsep;
> > > > >         struct avdtp_stream *stream;
> > > > > @@ -2406,23 +2407,44 @@ void a2dp_remove_sep(struct a2dp_sep *sep)
> > > > >
> > > > >  static void select_cb(struct a2dp_setup *setup, void *ret, int s=
ize)
> > > > >  {
> > > > > -       if (size < 0) {
> > > > > -               DBG("Endpoint replied an invalid configuration");
> > > > > +       struct avdtp_service_capability *service;
> > > > > +       struct avdtp_media_codec_capability *codec;
> > > > > +       int err;
> > > > > +
> > > > > +       if (size) {
> > > > > +               caps_add_codec(&setup->caps, setup->sep->codec, r=
et, size);
> > > > >                 goto done;
> > > > >         }
> > > > >
> > > > > -       caps_add_codec(&setup->caps, setup->sep->codec, ret, size=
);
> > > > > +       setup->sep =3D queue_pop_head(setup->eps);
> > > > > +       if (!setup->sep) {
> > > > > +               error("Unable to select a valid configuration");
> > > > > +               queue_destroy(setup->eps, NULL);
> > > > > +               goto done;
> > > > > +       }
> > > > > +
> > > > > +       setup->rsep =3D find_remote_sep(setup->chan, setup->sep);
> > > > > +       service =3D avdtp_get_codec(setup->rsep->sep);
> > > > > +       codec =3D (struct avdtp_media_codec_capability *) service=
->data;
> > > > > +
> > > > > +       err =3D setup->sep->endpoint->select_configuration(setup-=
>sep,
> > > > > +                                       codec->data,
> > > > > +                                       service->length - sizeof(=
*codec),
> > > > > +                                       setup_ref(setup),
> > > > > +                                       select_cb, setup->sep->us=
er_data);
> > > > > +       if (err =3D=3D 0)
> > > > > +               return;
> > > > >
> > > > >  done:
> > > > >         finalize_select(setup);
> > > > >         setup_unref(setup);
> > > > >  }
> > > > >
> > > > > -static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSL=
ist *list,
> > > > > +static struct queue *a2dp_find_eps(struct avdtp *session, GSList=
 *list,
> > > > >                                         const char *sender)
> > > > >  {
> > > > > -       struct a2dp_sep *first =3D NULL;
> > > > >         struct a2dp_channel *chan =3D find_channel(session);
> > > > > +       struct queue *seps =3D NULL;
> > > > >
> > > > >         for (; list; list =3D list->next) {
> > > > >                 struct a2dp_sep *sep =3D list->data;
> > > > > @@ -2444,26 +2466,25 @@ static struct a2dp_sep *a2dp_find_sep(str=
uct avdtp *session, GSList *list,
> > > > >                 if (!rsep)
> > > > >                         continue;
> > > > >
> > > > > -               /* Locate last used if set */
> > > > > -               if (chan->last_used) {
> > > > > -                       if (chan->last_used->sep =3D=3D rsep)
> > > > > -                               return sep;
> > > > > -                       first =3D sep;
> > > > > -                       continue;
> > > > > -               }
> > > > > +               if (!seps)
> > > > > +                       seps =3D queue_new();
> > > > >
> > > > > -               return sep;
> > > > > +               /* Prepend last used so it is preferred over othe=
rs */
> > > > > +               if (chan->last_used && chan->last_used->sep =3D=
=3D rsep)
> > > > > +                       queue_push_head(seps, sep);
> > > > > +               else
> > > > > +                       queue_push_tail(seps, sep);
> > > > >
> > > > >         }
> > > > >
> > > > > -       return first;
> > > > > +       return seps;
> > > > >  }
> > > > >
> > > > > -static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, u=
int8_t type,
> > > > > +static struct queue *a2dp_select_eps(struct avdtp *session, uint=
8_t type,
> > > > >                                         const char *sender)
> > > > >  {
> > > > >         struct a2dp_server *server;
> > > > > -       struct a2dp_sep *sep;
> > > > > +       struct queue *seps;
> > > > >         GSList *l;
> > > > >
> > > > >         server =3D find_server(servers, avdtp_get_adapter(session=
));
> > > > > @@ -2473,11 +2494,11 @@ static struct a2dp_sep *a2dp_select_sep(s=
truct avdtp *session, uint8_t type,
> > > > >         l =3D type =3D=3D AVDTP_SEP_TYPE_SINK ? server->sources :=
 server->sinks;
> > > > >
> > > > >         /* Check sender's seps first */
> > > > > -       sep =3D a2dp_find_sep(session, l, sender);
> > > > > -       if (sep !=3D NULL)
> > > > > -               return sep;
> > > > > +       seps =3D a2dp_find_eps(session, l, sender);
> > > > > +       if (seps !=3D NULL)
> > > > > +               return seps;
> > > > >
> > > > > -       return a2dp_find_sep(session, l, NULL);
> > > > > +       return a2dp_find_eps(session, l, NULL);
> > > > >  }
> > > > >
> > > > >  static void store_remote_sep(void *data, void *user_data)
> > > > > @@ -2580,13 +2601,13 @@ unsigned int a2dp_select_capabilities(str=
uct avdtp *session,
> > > > >  {
> > > > >         struct a2dp_setup *setup;
> > > > >         struct a2dp_setup_cb *cb_data;
> > > > > -       struct a2dp_sep *sep;
> > > > > +       struct queue *eps;
> > > > >         struct avdtp_service_capability *service;
> > > > >         struct avdtp_media_codec_capability *codec;
> > > > >         int err;
> > > > >
> > > > > -       sep =3D a2dp_select_sep(session, type, sender);
> > > > > -       if (!sep) {
> > > > > +       eps =3D a2dp_select_eps(session, type, sender);
> > > > > +       if (!eps) {
> > > > >                 error("Unable to select SEP");
> > > > >                 return 0;
> > > > >         }
> > > > > @@ -2599,8 +2620,9 @@ unsigned int a2dp_select_capabilities(struc=
t avdtp *session,
> > > > >         cb_data->select_cb =3D cb;
> > > > >         cb_data->user_data =3D user_data;
> > > > >
> > > > > -       setup->sep =3D sep;
> > > > > -       setup->rsep =3D find_remote_sep(setup->chan, sep);
> > > > > +       setup->eps =3D eps;
> > > > > +       setup->sep =3D queue_pop_head(eps);
> > > > > +       setup->rsep =3D find_remote_sep(setup->chan, setup->sep);
> > > > >
> > > > >         if (setup->rsep =3D=3D NULL) {
> > > > >                 error("Could not find remote sep");
> > > > > @@ -2610,10 +2632,11 @@ unsigned int a2dp_select_capabilities(str=
uct avdtp *session,
> > > > >         service =3D avdtp_get_codec(setup->rsep->sep);
> > > > >         codec =3D (struct avdtp_media_codec_capability *) service=
->data;
> > > > >
> > > > > -       err =3D sep->endpoint->select_configuration(sep, codec->d=
ata,
> > > > > +       err =3D setup->sep->endpoint->select_configuration(setup-=
>sep,
> > > > > +                                       codec->data,
> > > > >                                         service->length - sizeof(=
*codec),
> > > > >                                         setup_ref(setup),
> > > > > -                                       select_cb, sep->user_data=
);
> > > > > +                                       select_cb, setup->sep->us=
er_data);
> > > > >         if (err =3D=3D 0)
> > > > >                 return cb_data->id;
> > > > >
> > > > > --
> > > > > 2.20.1
> > > >=20
> > > > Le me know if you find any problem with this change, my headsets se=
ems
> > > > to always succeed the first try so I cannot really reproduce the
> > > > problem.
> > >=20
> > > Ok, I will try it in next days. I can register PA endpoints which alw=
ays
> > > "fails" so I can test if this is working correctly as expected.
> >=20
> > Nope, this your patch does not work. It cause segfaulting of bluetoothd
> > daemon itself. Here is stacktrace of current git master branch (where is
> > your patch too):
> >=20
> > Program received signal SIGSEGV, Segmentation fault.
> > __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-=
vec-unaligned-erms.S:416
> > 416     ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S: Adres=
=C3=A1r alebo s=C3=BAbor neexistuje.
> > (gdb) bt
> > #0  __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memm=
ove-vec-unaligned-erms.S:416
> > #1  0x0000557d2d2f3164 in caps_add_codec (l=3D0x557d2f1a9708, codec=3D<=
optimized out>, caps=3D0x0, size=3D18446744073709551615) at profiles/audio/=
a2dp.c:1519
> > #2  0x0000557d2d2f626a in select_cb (setup=3D0x557d2f1a96c0, ret=3D<opt=
imized out>, size=3D<optimized out>) at profiles/audio/a2dp.c:2422
> > #3  0x0000557d2d2fe016 in endpoint_reply (call=3D<optimized out>, user_=
data=3D0x557d2f187810) at profiles/audio/media.c:316
> > #4  0x00007fd2dc6aa002 in ?? () from /lib/x86_64-linux-gnu/libdbus-1.so=
=2E3
> > #5  0x00007fd2dc6ada5f in dbus_connection_dispatch () from /lib/x86_64-=
linux-gnu/libdbus-1.so.3
> > #6  0x0000557d2d36f320 in message_dispatch (data=3D0x557d2f184560) at g=
dbus/mainloop.c:72
> > #7  0x00007fd2dc9326aa in g_main_context_dispatch () from /lib/x86_64-l=
inux-gnu/libglib-2.0.so.0
> > #8  0x00007fd2dc932a60 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.=
so.0
> > #9  0x00007fd2dc932d82 in g_main_loop_run () from /lib/x86_64-linux-gnu=
/libglib-2.0.so.0
> > #10 0x0000557d2d384a45 in mainloop_run () at src/shared/mainloop-glib.c=
:79
> > #11 0x0000557d2d384e0f in mainloop_run_with_signal (func=3D<optimized o=
ut>, user_data=3D0x0) at src/shared/mainloop-notify.c:201
> > #12 0x0000557d2d2eb0a8 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>) at src/main.c:729
> >=20
> > In syslog for bluetoothd is this last line:
> > bluetoothd[12605]: Endpoint replied with an error: org.bluez.Error.Inva=
lidArguments
> >=20
> > pulseaudio refused only one SelectConfiguration call.
>=20
> In profiles/audio/a2dp.c is:
>=20
> static void select_cb(struct a2dp_setup *setup, void *ret, int size)
> {
> ...
> 	if (size) {
> 		caps_add_codec(&setup->caps, setup->sep->codec, ret, size);
> ...
>=20
> and then there is:
>=20
> tatic void caps_add_codec(GSList **l, uint8_t codec, uint8_t *caps,
> 							size_t size)
> {
> ...
> 	memcpy(cap->data, caps, size);
> ...
>=20
> When select_cb() is called with size=3D-1 then is calls caps_add_codec()
> as size is non-zero and cast signed 32bit int -1 to unsigned 64bit int
> as value 2^64-1. Later is called memcpy with size 2^64-1 and crash is
> there. Moreover caps is NULLL pointer, therefore void *ret in select_cb
> is NULL too. Seems like wrong error handling in select_cb() function.

And seems that ret=3DNULL and size=3D-1 comes from media.c endpoint_reply()
functions. As those values are defaults... Maybe it is a bug here?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--ccze2worxhbu2eei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXMtZ+QAKCRCL8Mk9A+RD
Un4hAJ0QLDvuOpU7B8zFMYtSv4cy/BkTsACgmOScOea3Lmyr7ErFMRXept6lqzM=
=XBal
-----END PGP SIGNATURE-----

--ccze2worxhbu2eei--
