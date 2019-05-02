Return-Path: <SRS0=qzIG=TC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED131C43219
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 20:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0F82085A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 20:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDc533Kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEBUmA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 May 2019 16:42:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40610 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfEBUmA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 May 2019 16:42:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so5172007wre.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2019 13:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oJ4LMzCTgn77lXiAwI3lxipgDUnJX4lFG2o1LPezsRo=;
        b=UDc533Kd7gg/xeh4Kg5AiDgoo/USuyfOGQQLBm7BSqqmAXWp0FJpSkJIqfGFDn/eRv
         gptVw4MmU3kNkT+MVdDdmxPTBBG2YgCLTMCYorZYf1YvRGxQG4D+EoKe4CloeHz8sKmt
         ovPVEM8TGP1coZbIPaBDVVmboXYvkykKL1ysbHtZl26bYJcvE8zkUff7C7j98UyGT64g
         vcnPRz3K/ExDpz7cJfU04DuXQaL5hvKD4PG5o+BuO1ol7JRAFLceghw48UxITPHvmV8w
         httMfDERzF06rRREWiJVxnVT3sVIpFJ3z77gWlYyLqNg9oFPXNbuLhuwD8j0/5pHQAkP
         XaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oJ4LMzCTgn77lXiAwI3lxipgDUnJX4lFG2o1LPezsRo=;
        b=DoifMQH7sRDZ2Eg/F6TgPNggf91c52lvMsRZarzb2ptS1SIj6/3IEH8uqPIc+QQ+HV
         L6MX7R4SqBGfAO5TqScRMRAr4qt3G8hUT9KlakC5gqjNiDVBzo50weFlPc9wlgA7HL4V
         VuGHbqiTyQ17+f/Xr4W+bceSleulDHQC29yTftTpZdkVU6zALNTqc0Sz/31/xM2evKWT
         SjUonPSgmLhoiFTy0SVd0DuejXt7IMYvI7ZP8lKimDiaEoRsrA/p6shlALfwB0i0CwIw
         aniyk832LGCsSw89kR3idCOmCLj9jhoJCU8w/lHFE0i4wkbUo0s0w3x4DoboLM21Vj5B
         +uQg==
X-Gm-Message-State: APjAAAVB8K0uanFKOnIAQo9/c/kaxpZIJVIkaJA5VEQZ8ahfG/reML00
        ntHCCXh7zXWeYtTQnIfshC0=
X-Google-Smtp-Source: APXvYqxyQJbPyXhjnp9s0LyjP9msCVZZxcyXeKTrYrDUu3RFXd1CTkRclo0Uh0d7qRaEFs8DhOuH7Q==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr4397979wrv.131.1556829717518;
        Thu, 02 May 2019 13:41:57 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id h131sm254921wmh.44.2019.05.02.13.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 13:41:56 -0700 (PDT)
Date:   Thu, 2 May 2019 22:41:55 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] a2dp: Fix not calling SelectConfiguration on
 other available endpoints
Message-ID: <20190502204155.mu4zavpotbujixrs@pali>
References: <20190429120259.17880-1-luiz.dentz@gmail.com>
 <20190429120259.17880-3-luiz.dentz@gmail.com>
 <CABBYNZK1LRANfR6cwu+xbLsvy4EnB+ZPS78JNK04mJ=pwTGSDw@mail.gmail.com>
 <20190429163916.ngdqk437xbuahl4k@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4j2322atninogjjl"
Content-Disposition: inline
In-Reply-To: <20190429163916.ngdqk437xbuahl4k@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--4j2322atninogjjl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 29 April 2019 18:39:16 Pali Roh=C3=A1r wrote:
> On Monday 29 April 2019 19:35:24 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >=20
> > On Mon, Apr 29, 2019 at 3:03 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > Endpoint may not be able to select a valid configuration but there co=
uld
> > > be other endpoints available that could be used, so instead of just
> > > using the first match this collects all the matching endpoints and put
> > > them into a queue (ordered by priority) then proceed to next endpoint
> > > only failing if none of the available endpoits can select a valid
> > > configuration.
> > > ---
> > >  profiles/audio/a2dp.c | 77 ++++++++++++++++++++++++++++-------------=
--
> > >  1 file changed, 50 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > > index a23abdd97..4d378a91a 100644
> > > --- a/profiles/audio/a2dp.c
> > > +++ b/profiles/audio/a2dp.c
> > > @@ -105,6 +105,7 @@ struct a2dp_setup_cb {
> > >  struct a2dp_setup {
> > >         struct a2dp_channel *chan;
> > >         struct avdtp *session;
> > > +       struct queue *eps;
> > >         struct a2dp_sep *sep;
> > >         struct a2dp_remote_sep *rsep;
> > >         struct avdtp_stream *stream;
> > > @@ -2406,23 +2407,44 @@ void a2dp_remove_sep(struct a2dp_sep *sep)
> > >
> > >  static void select_cb(struct a2dp_setup *setup, void *ret, int size)
> > >  {
> > > -       if (size < 0) {
> > > -               DBG("Endpoint replied an invalid configuration");
> > > +       struct avdtp_service_capability *service;
> > > +       struct avdtp_media_codec_capability *codec;
> > > +       int err;
> > > +
> > > +       if (size) {
> > > +               caps_add_codec(&setup->caps, setup->sep->codec, ret, =
size);
> > >                 goto done;
> > >         }
> > >
> > > -       caps_add_codec(&setup->caps, setup->sep->codec, ret, size);
> > > +       setup->sep =3D queue_pop_head(setup->eps);
> > > +       if (!setup->sep) {
> > > +               error("Unable to select a valid configuration");
> > > +               queue_destroy(setup->eps, NULL);
> > > +               goto done;
> > > +       }
> > > +
> > > +       setup->rsep =3D find_remote_sep(setup->chan, setup->sep);
> > > +       service =3D avdtp_get_codec(setup->rsep->sep);
> > > +       codec =3D (struct avdtp_media_codec_capability *) service->da=
ta;
> > > +
> > > +       err =3D setup->sep->endpoint->select_configuration(setup->sep,
> > > +                                       codec->data,
> > > +                                       service->length - sizeof(*cod=
ec),
> > > +                                       setup_ref(setup),
> > > +                                       select_cb, setup->sep->user_d=
ata);
> > > +       if (err =3D=3D 0)
> > > +               return;
> > >
> > >  done:
> > >         finalize_select(setup);
> > >         setup_unref(setup);
> > >  }
> > >
> > > -static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList =
*list,
> > > +static struct queue *a2dp_find_eps(struct avdtp *session, GSList *li=
st,
> > >                                         const char *sender)
> > >  {
> > > -       struct a2dp_sep *first =3D NULL;
> > >         struct a2dp_channel *chan =3D find_channel(session);
> > > +       struct queue *seps =3D NULL;
> > >
> > >         for (; list; list =3D list->next) {
> > >                 struct a2dp_sep *sep =3D list->data;
> > > @@ -2444,26 +2466,25 @@ static struct a2dp_sep *a2dp_find_sep(struct =
avdtp *session, GSList *list,
> > >                 if (!rsep)
> > >                         continue;
> > >
> > > -               /* Locate last used if set */
> > > -               if (chan->last_used) {
> > > -                       if (chan->last_used->sep =3D=3D rsep)
> > > -                               return sep;
> > > -                       first =3D sep;
> > > -                       continue;
> > > -               }
> > > +               if (!seps)
> > > +                       seps =3D queue_new();
> > >
> > > -               return sep;
> > > +               /* Prepend last used so it is preferred over others */
> > > +               if (chan->last_used && chan->last_used->sep =3D=3D rs=
ep)
> > > +                       queue_push_head(seps, sep);
> > > +               else
> > > +                       queue_push_tail(seps, sep);
> > >
> > >         }
> > >
> > > -       return first;
> > > +       return seps;
> > >  }
> > >
> > > -static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8=
_t type,
> > > +static struct queue *a2dp_select_eps(struct avdtp *session, uint8_t =
type,
> > >                                         const char *sender)
> > >  {
> > >         struct a2dp_server *server;
> > > -       struct a2dp_sep *sep;
> > > +       struct queue *seps;
> > >         GSList *l;
> > >
> > >         server =3D find_server(servers, avdtp_get_adapter(session));
> > > @@ -2473,11 +2494,11 @@ static struct a2dp_sep *a2dp_select_sep(struc=
t avdtp *session, uint8_t type,
> > >         l =3D type =3D=3D AVDTP_SEP_TYPE_SINK ? server->sources : ser=
ver->sinks;
> > >
> > >         /* Check sender's seps first */
> > > -       sep =3D a2dp_find_sep(session, l, sender);
> > > -       if (sep !=3D NULL)
> > > -               return sep;
> > > +       seps =3D a2dp_find_eps(session, l, sender);
> > > +       if (seps !=3D NULL)
> > > +               return seps;
> > >
> > > -       return a2dp_find_sep(session, l, NULL);
> > > +       return a2dp_find_eps(session, l, NULL);
> > >  }
> > >
> > >  static void store_remote_sep(void *data, void *user_data)
> > > @@ -2580,13 +2601,13 @@ unsigned int a2dp_select_capabilities(struct =
avdtp *session,
> > >  {
> > >         struct a2dp_setup *setup;
> > >         struct a2dp_setup_cb *cb_data;
> > > -       struct a2dp_sep *sep;
> > > +       struct queue *eps;
> > >         struct avdtp_service_capability *service;
> > >         struct avdtp_media_codec_capability *codec;
> > >         int err;
> > >
> > > -       sep =3D a2dp_select_sep(session, type, sender);
> > > -       if (!sep) {
> > > +       eps =3D a2dp_select_eps(session, type, sender);
> > > +       if (!eps) {
> > >                 error("Unable to select SEP");
> > >                 return 0;
> > >         }
> > > @@ -2599,8 +2620,9 @@ unsigned int a2dp_select_capabilities(struct av=
dtp *session,
> > >         cb_data->select_cb =3D cb;
> > >         cb_data->user_data =3D user_data;
> > >
> > > -       setup->sep =3D sep;
> > > -       setup->rsep =3D find_remote_sep(setup->chan, sep);
> > > +       setup->eps =3D eps;
> > > +       setup->sep =3D queue_pop_head(eps);
> > > +       setup->rsep =3D find_remote_sep(setup->chan, setup->sep);
> > >
> > >         if (setup->rsep =3D=3D NULL) {
> > >                 error("Could not find remote sep");
> > > @@ -2610,10 +2632,11 @@ unsigned int a2dp_select_capabilities(struct =
avdtp *session,
> > >         service =3D avdtp_get_codec(setup->rsep->sep);
> > >         codec =3D (struct avdtp_media_codec_capability *) service->da=
ta;
> > >
> > > -       err =3D sep->endpoint->select_configuration(sep, codec->data,
> > > +       err =3D setup->sep->endpoint->select_configuration(setup->sep,
> > > +                                       codec->data,
> > >                                         service->length - sizeof(*cod=
ec),
> > >                                         setup_ref(setup),
> > > -                                       select_cb, sep->user_data);
> > > +                                       select_cb, setup->sep->user_d=
ata);
> > >         if (err =3D=3D 0)
> > >                 return cb_data->id;
> > >
> > > --
> > > 2.20.1
> >=20
> > Le me know if you find any problem with this change, my headsets seems
> > to always succeed the first try so I cannot really reproduce the
> > problem.
>=20
> Ok, I will try it in next days. I can register PA endpoints which always
> "fails" so I can test if this is working correctly as expected.

Nope, this your patch does not work. It cause segfaulting of bluetoothd
daemon itself. Here is stacktrace of current git master branch (where is
your patch too):

Program received signal SIGSEGV, Segmentation fault.
__memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-=
unaligned-erms.S:416
416     ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S: Adres=C3=
=A1r alebo s=C3=BAbor neexistuje.
(gdb) bt
#0  __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-=
vec-unaligned-erms.S:416
#1  0x0000557d2d2f3164 in caps_add_codec (l=3D0x557d2f1a9708, codec=3D<opti=
mized out>, caps=3D0x0, size=3D18446744073709551615) at profiles/audio/a2dp=
=2Ec:1519
#2  0x0000557d2d2f626a in select_cb (setup=3D0x557d2f1a96c0, ret=3D<optimiz=
ed out>, size=3D<optimized out>) at profiles/audio/a2dp.c:2422
#3  0x0000557d2d2fe016 in endpoint_reply (call=3D<optimized out>, user_data=
=3D0x557d2f187810) at profiles/audio/media.c:316
#4  0x00007fd2dc6aa002 in ?? () from /lib/x86_64-linux-gnu/libdbus-1.so.3
#5  0x00007fd2dc6ada5f in dbus_connection_dispatch () from /lib/x86_64-linu=
x-gnu/libdbus-1.so.3
#6  0x0000557d2d36f320 in message_dispatch (data=3D0x557d2f184560) at gdbus=
/mainloop.c:72
#7  0x00007fd2dc9326aa in g_main_context_dispatch () from /lib/x86_64-linux=
-gnu/libglib-2.0.so.0
#8  0x00007fd2dc932a60 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#9  0x00007fd2dc932d82 in g_main_loop_run () from /lib/x86_64-linux-gnu/lib=
glib-2.0.so.0
#10 0x0000557d2d384a45 in mainloop_run () at src/shared/mainloop-glib.c:79
#11 0x0000557d2d384e0f in mainloop_run_with_signal (func=3D<optimized out>,=
 user_data=3D0x0) at src/shared/mainloop-notify.c:201
#12 0x0000557d2d2eb0a8 in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>) at src/main.c:729

In syslog for bluetoothd is this last line:
bluetoothd[12605]: Endpoint replied with an error: org.bluez.Error.InvalidA=
rguments

pulseaudio refused only one SelectConfiguration call.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--4j2322atninogjjl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXMtWEAAKCRCL8Mk9A+RD
Ur9hAKCojxbhS1V0aPVYgg0gUUWqrjXR2ACfSoho5Laxk9Gjx6malqF1ygnKOQk=
=C59T
-----END PGP SIGNATURE-----

--4j2322atninogjjl--
