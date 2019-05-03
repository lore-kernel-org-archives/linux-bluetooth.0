Return-Path: <SRS0=8q+o=TD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7177DC43219
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 08:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5362075C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 08:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvLNGQ3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfECIzy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 May 2019 04:55:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44461 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfECIzx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 May 2019 04:55:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id a5so1066919otb.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 May 2019 01:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2kn5LO72AUr6/anX6GvNMnc+hNNqvwoJTFA/VYVKRuE=;
        b=kvLNGQ3KcD7hPxsqCIzQsvoIL/yyOuki+OjBLGqEF4Qs8xHIJN44Yd585GpVVFxj+r
         Ic6j+xbAH8ROmNcLJ6xrLss293joBaIl87kI0dyDbHJLc18U7PN+L7Swzz/jFYE5mUBC
         3tp5GOjG00fWisU0mWi3uslLRBkHyIYUTvEqxpTlghIiukemq7Tocy6ms0KQ0QVn4KzF
         dzydnc3azu2s6IkRjuLcmSU1DG1/86ThjJHcCpmQRKlaVhZjxQdi51uaaf1ggMmD5dcs
         KEY66KACrD376pfLnQuE6F8a7U+ESkQjB24JDhLux4dQxWtV+aOoAro8tgLhpWHxassl
         xaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2kn5LO72AUr6/anX6GvNMnc+hNNqvwoJTFA/VYVKRuE=;
        b=Dv/UWb792bSmESQNwW8K/dRULJQ7KmODyswCeBRO5tykK3KFYLCfZKuI8wy70WXrln
         tNJI+OzIbFpF3WT75GpQAW7qrZBrZajRfRcZ8qU5pmOK0KouBa1FSgRS7jSc6UWImOL7
         ssFiKhdW4Z0o3VzH3q0mfzrtt5pNKjItQahL1ind8vRX7JTIm9BpVzIngxZdXZpKGP2T
         kAIft8dzyizvS9sK8c8tzJe2t/ya0aLWMbxXEpJOkVPvZLKU7+tyDVDNGJbJXUQfdrUC
         GyP5Uz+33NNRXlT6j5fScS5RN0I8pnn5dXOlWVUB+XT7y6qU1V9Z4SaP16ztd65mYxBH
         ZevQ==
X-Gm-Message-State: APjAAAWsDre3235TLl5FgPMuQMq8Ugi2ai1u/kxDciiR267d5QRbxZcN
        nOCDTt+5ZtzNf9MbZX2CIJNqE2aMqVAoKIfQRYobquSVPoA=
X-Google-Smtp-Source: APXvYqyBg/+PAsPgTbY9zncZ+x3cQqoc70UbaOcUZbvnXcPLJ0BMqdqqSEARIaymyDpohqdtKgrV90Du1q7c5g7RgMw=
X-Received: by 2002:a9d:39c3:: with SMTP id y61mr736760otb.84.1556873752402;
 Fri, 03 May 2019 01:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190429120259.17880-1-luiz.dentz@gmail.com> <20190429120259.17880-3-luiz.dentz@gmail.com>
 <CABBYNZK1LRANfR6cwu+xbLsvy4EnB+ZPS78JNK04mJ=pwTGSDw@mail.gmail.com>
 <20190429163916.ngdqk437xbuahl4k@pali> <20190502204155.mu4zavpotbujixrs@pali>
 <20190502205349.rrg44khwuv2xaj6b@pali> <20190502205836.hxcdip7a3wt6xy3y@pali> <20190502211054.edon3q2l3kacwsv4@pali>
In-Reply-To: <20190502211054.edon3q2l3kacwsv4@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 3 May 2019 11:55:38 +0300
Message-ID: <CABBYNZJq5ODCuaQHbPOpcx_Sju7M-fcV9iHiXNNpFjFhhCFpCw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] a2dp: Fix not calling SelectConfiguration on other
 available endpoints
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Fri, May 3, 2019 at 12:10 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Thursday 02 May 2019 22:58:36 Pali Roh=C3=A1r wrote:
> > On Thursday 02 May 2019 22:53:49 Pali Roh=C3=A1r wrote:
> > > On Thursday 02 May 2019 22:41:55 Pali Roh=C3=A1r wrote:
> > > > On Monday 29 April 2019 18:39:16 Pali Roh=C3=A1r wrote:
> > > > > On Monday 29 April 2019 19:35:24 Luiz Augusto von Dentz wrote:
> > > > > > Hi Pali,
> > > > > >
> > > > > > On Mon, Apr 29, 2019 at 3:03 PM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > >
> > > > > > > Endpoint may not be able to select a valid configuration but =
there could
> > > > > > > be other endpoints available that could be used, so instead o=
f just
> > > > > > > using the first match this collects all the matching endpoint=
s and put
> > > > > > > them into a queue (ordered by priority) then proceed to next =
endpoint
> > > > > > > only failing if none of the available endpoits can select a v=
alid
> > > > > > > configuration.
> > > > > > > ---
> > > > > > >  profiles/audio/a2dp.c | 77 ++++++++++++++++++++++++++++-----=
----------
> > > > > > >  1 file changed, 50 insertions(+), 27 deletions(-)
> > > > > > >
> > > > > > > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > > > > > > index a23abdd97..4d378a91a 100644
> > > > > > > --- a/profiles/audio/a2dp.c
> > > > > > > +++ b/profiles/audio/a2dp.c
> > > > > > > @@ -105,6 +105,7 @@ struct a2dp_setup_cb {
> > > > > > >  struct a2dp_setup {
> > > > > > >         struct a2dp_channel *chan;
> > > > > > >         struct avdtp *session;
> > > > > > > +       struct queue *eps;
> > > > > > >         struct a2dp_sep *sep;
> > > > > > >         struct a2dp_remote_sep *rsep;
> > > > > > >         struct avdtp_stream *stream;
> > > > > > > @@ -2406,23 +2407,44 @@ void a2dp_remove_sep(struct a2dp_sep =
*sep)
> > > > > > >
> > > > > > >  static void select_cb(struct a2dp_setup *setup, void *ret, i=
nt size)
> > > > > > >  {
> > > > > > > -       if (size < 0) {
> > > > > > > -               DBG("Endpoint replied an invalid configuratio=
n");
> > > > > > > +       struct avdtp_service_capability *service;
> > > > > > > +       struct avdtp_media_codec_capability *codec;
> > > > > > > +       int err;
> > > > > > > +
> > > > > > > +       if (size) {
> > > > > > > +               caps_add_codec(&setup->caps, setup->sep->code=
c, ret, size);
> > > > > > >                 goto done;
> > > > > > >         }
> > > > > > >
> > > > > > > -       caps_add_codec(&setup->caps, setup->sep->codec, ret, =
size);
> > > > > > > +       setup->sep =3D queue_pop_head(setup->eps);
> > > > > > > +       if (!setup->sep) {
> > > > > > > +               error("Unable to select a valid configuration=
");
> > > > > > > +               queue_destroy(setup->eps, NULL);
> > > > > > > +               goto done;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       setup->rsep =3D find_remote_sep(setup->chan, setup->s=
ep);
> > > > > > > +       service =3D avdtp_get_codec(setup->rsep->sep);
> > > > > > > +       codec =3D (struct avdtp_media_codec_capability *) ser=
vice->data;
> > > > > > > +
> > > > > > > +       err =3D setup->sep->endpoint->select_configuration(se=
tup->sep,
> > > > > > > +                                       codec->data,
> > > > > > > +                                       service->length - siz=
eof(*codec),
> > > > > > > +                                       setup_ref(setup),
> > > > > > > +                                       select_cb, setup->sep=
->user_data);
> > > > > > > +       if (err =3D=3D 0)
> > > > > > > +               return;
> > > > > > >
> > > > > > >  done:
> > > > > > >         finalize_select(setup);
> > > > > > >         setup_unref(setup);
> > > > > > >  }
> > > > > > >
> > > > > > > -static struct a2dp_sep *a2dp_find_sep(struct avdtp *session,=
 GSList *list,
> > > > > > > +static struct queue *a2dp_find_eps(struct avdtp *session, GS=
List *list,
> > > > > > >                                         const char *sender)
> > > > > > >  {
> > > > > > > -       struct a2dp_sep *first =3D NULL;
> > > > > > >         struct a2dp_channel *chan =3D find_channel(session);
> > > > > > > +       struct queue *seps =3D NULL;
> > > > > > >
> > > > > > >         for (; list; list =3D list->next) {
> > > > > > >                 struct a2dp_sep *sep =3D list->data;
> > > > > > > @@ -2444,26 +2466,25 @@ static struct a2dp_sep *a2dp_find_sep=
(struct avdtp *session, GSList *list,
> > > > > > >                 if (!rsep)
> > > > > > >                         continue;
> > > > > > >
> > > > > > > -               /* Locate last used if set */
> > > > > > > -               if (chan->last_used) {
> > > > > > > -                       if (chan->last_used->sep =3D=3D rsep)
> > > > > > > -                               return sep;
> > > > > > > -                       first =3D sep;
> > > > > > > -                       continue;
> > > > > > > -               }
> > > > > > > +               if (!seps)
> > > > > > > +                       seps =3D queue_new();
> > > > > > >
> > > > > > > -               return sep;
> > > > > > > +               /* Prepend last used so it is preferred over =
others */
> > > > > > > +               if (chan->last_used && chan->last_used->sep =
=3D=3D rsep)
> > > > > > > +                       queue_push_head(seps, sep);
> > > > > > > +               else
> > > > > > > +                       queue_push_tail(seps, sep);
> > > > > > >
> > > > > > >         }
> > > > > > >
> > > > > > > -       return first;
> > > > > > > +       return seps;
> > > > > > >  }
> > > > > > >
> > > > > > > -static struct a2dp_sep *a2dp_select_sep(struct avdtp *sessio=
n, uint8_t type,
> > > > > > > +static struct queue *a2dp_select_eps(struct avdtp *session, =
uint8_t type,
> > > > > > >                                         const char *sender)
> > > > > > >  {
> > > > > > >         struct a2dp_server *server;
> > > > > > > -       struct a2dp_sep *sep;
> > > > > > > +       struct queue *seps;
> > > > > > >         GSList *l;
> > > > > > >
> > > > > > >         server =3D find_server(servers, avdtp_get_adapter(ses=
sion));
> > > > > > > @@ -2473,11 +2494,11 @@ static struct a2dp_sep *a2dp_select_s=
ep(struct avdtp *session, uint8_t type,
> > > > > > >         l =3D type =3D=3D AVDTP_SEP_TYPE_SINK ? server->sourc=
es : server->sinks;
> > > > > > >
> > > > > > >         /* Check sender's seps first */
> > > > > > > -       sep =3D a2dp_find_sep(session, l, sender);
> > > > > > > -       if (sep !=3D NULL)
> > > > > > > -               return sep;
> > > > > > > +       seps =3D a2dp_find_eps(session, l, sender);
> > > > > > > +       if (seps !=3D NULL)
> > > > > > > +               return seps;
> > > > > > >
> > > > > > > -       return a2dp_find_sep(session, l, NULL);
> > > > > > > +       return a2dp_find_eps(session, l, NULL);
> > > > > > >  }
> > > > > > >
> > > > > > >  static void store_remote_sep(void *data, void *user_data)
> > > > > > > @@ -2580,13 +2601,13 @@ unsigned int a2dp_select_capabilities=
(struct avdtp *session,
> > > > > > >  {
> > > > > > >         struct a2dp_setup *setup;
> > > > > > >         struct a2dp_setup_cb *cb_data;
> > > > > > > -       struct a2dp_sep *sep;
> > > > > > > +       struct queue *eps;
> > > > > > >         struct avdtp_service_capability *service;
> > > > > > >         struct avdtp_media_codec_capability *codec;
> > > > > > >         int err;
> > > > > > >
> > > > > > > -       sep =3D a2dp_select_sep(session, type, sender);
> > > > > > > -       if (!sep) {
> > > > > > > +       eps =3D a2dp_select_eps(session, type, sender);
> > > > > > > +       if (!eps) {
> > > > > > >                 error("Unable to select SEP");
> > > > > > >                 return 0;
> > > > > > >         }
> > > > > > > @@ -2599,8 +2620,9 @@ unsigned int a2dp_select_capabilities(s=
truct avdtp *session,
> > > > > > >         cb_data->select_cb =3D cb;
> > > > > > >         cb_data->user_data =3D user_data;
> > > > > > >
> > > > > > > -       setup->sep =3D sep;
> > > > > > > -       setup->rsep =3D find_remote_sep(setup->chan, sep);
> > > > > > > +       setup->eps =3D eps;
> > > > > > > +       setup->sep =3D queue_pop_head(eps);
> > > > > > > +       setup->rsep =3D find_remote_sep(setup->chan, setup->s=
ep);
> > > > > > >
> > > > > > >         if (setup->rsep =3D=3D NULL) {
> > > > > > >                 error("Could not find remote sep");
> > > > > > > @@ -2610,10 +2632,11 @@ unsigned int a2dp_select_capabilities=
(struct avdtp *session,
> > > > > > >         service =3D avdtp_get_codec(setup->rsep->sep);
> > > > > > >         codec =3D (struct avdtp_media_codec_capability *) ser=
vice->data;
> > > > > > >
> > > > > > > -       err =3D sep->endpoint->select_configuration(sep, code=
c->data,
> > > > > > > +       err =3D setup->sep->endpoint->select_configuration(se=
tup->sep,
> > > > > > > +                                       codec->data,
> > > > > > >                                         service->length - siz=
eof(*codec),
> > > > > > >                                         setup_ref(setup),
> > > > > > > -                                       select_cb, sep->user_=
data);
> > > > > > > +                                       select_cb, setup->sep=
->user_data);
> > > > > > >         if (err =3D=3D 0)
> > > > > > >                 return cb_data->id;
> > > > > > >
> > > > > > > --
> > > > > > > 2.20.1
> > > > > >
> > > > > > Le me know if you find any problem with this change, my headset=
s seems
> > > > > > to always succeed the first try so I cannot really reproduce th=
e
> > > > > > problem.
> > > > >
> > > > > Ok, I will try it in next days. I can register PA endpoints which=
 always
> > > > > "fails" so I can test if this is working correctly as expected.
> > > >
> > > > Nope, this your patch does not work. It cause segfaulting of blueto=
othd
> > > > daemon itself. Here is stacktrace of current git master branch (whe=
re is
> > > > your patch too):
> > > >
> > > > Program received signal SIGSEGV, Segmentation fault.
> > > > __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memm=
ove-vec-unaligned-erms.S:416
> > > > 416     ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S: A=
dres=C3=A1r alebo s=C3=BAbor neexistuje.
> > > > (gdb) bt
> > > > #0  __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/=
memmove-vec-unaligned-erms.S:416
> > > > #1  0x0000557d2d2f3164 in caps_add_codec (l=3D0x557d2f1a9708, codec=
=3D<optimized out>, caps=3D0x0, size=3D18446744073709551615) at profiles/au=
dio/a2dp.c:1519
> > > > #2  0x0000557d2d2f626a in select_cb (setup=3D0x557d2f1a96c0, ret=3D=
<optimized out>, size=3D<optimized out>) at profiles/audio/a2dp.c:2422
> > > > #3  0x0000557d2d2fe016 in endpoint_reply (call=3D<optimized out>, u=
ser_data=3D0x557d2f187810) at profiles/audio/media.c:316
> > > > #4  0x00007fd2dc6aa002 in ?? () from /lib/x86_64-linux-gnu/libdbus-=
1.so.3
> > > > #5  0x00007fd2dc6ada5f in dbus_connection_dispatch () from /lib/x86=
_64-linux-gnu/libdbus-1.so.3
> > > > #6  0x0000557d2d36f320 in message_dispatch (data=3D0x557d2f184560) =
at gdbus/mainloop.c:72
> > > > #7  0x00007fd2dc9326aa in g_main_context_dispatch () from /lib/x86_=
64-linux-gnu/libglib-2.0.so.0
> > > > #8  0x00007fd2dc932a60 in ?? () from /lib/x86_64-linux-gnu/libglib-=
2.0.so.0
> > > > #9  0x00007fd2dc932d82 in g_main_loop_run () from /lib/x86_64-linux=
-gnu/libglib-2.0.so.0
> > > > #10 0x0000557d2d384a45 in mainloop_run () at src/shared/mainloop-gl=
ib.c:79
> > > > #11 0x0000557d2d384e0f in mainloop_run_with_signal (func=3D<optimiz=
ed out>, user_data=3D0x0) at src/shared/mainloop-notify.c:201
> > > > #12 0x0000557d2d2eb0a8 in main (argc=3D<optimized out>, argv=3D<opt=
imized out>) at src/main.c:729
> > > >
> > > > In syslog for bluetoothd is this last line:
> > > > bluetoothd[12605]: Endpoint replied with an error: org.bluez.Error.=
InvalidArguments
> > > >
> > > > pulseaudio refused only one SelectConfiguration call.
> > >
> > > In profiles/audio/a2dp.c is:
> > >
> > > static void select_cb(struct a2dp_setup *setup, void *ret, int size)
> > > {
> > > ...
> > >     if (size) {
> > >             caps_add_codec(&setup->caps, setup->sep->codec, ret, size=
);
> > > ...
> > >
> > > and then there is:
> > >
> > > tatic void caps_add_codec(GSList **l, uint8_t codec, uint8_t *caps,
> > >                                                     size_t size)
> > > {
> > > ...
> > >     memcpy(cap->data, caps, size);
> > > ...
> > >
> > > When select_cb() is called with size=3D-1 then is calls caps_add_code=
c()
> > > as size is non-zero and cast signed 32bit int -1 to unsigned 64bit in=
t
> > > as value 2^64-1. Later is called memcpy with size 2^64-1 and crash is
> > > there. Moreover caps is NULLL pointer, therefore void *ret in select_=
cb
> > > is NULL too. Seems like wrong error handling in select_cb() function.
> >
> > And seems that ret=3DNULL and size=3D-1 comes from media.c endpoint_rep=
ly()
> > functions. As those values are defaults... Maybe it is a bug here?
>
> Here is patch which fixes above problem with crashing:
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index d0676b577..b06eafae0 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -1703,7 +1703,7 @@ static DBusMessage *set_configuration(DBusConnectio=
n *conn, DBusMessage *msg,
>         if (dbus_message_iter_get_arg_type(&props) !=3D DBUS_TYPE_DICT_EN=
TRY)
>                 return btd_error_invalid_args(msg);
>
> -       if (parse_properties(&props, &caps, &size) < 0)
> +       if (parse_properties(&props, &caps, &size) < 0 || size <=3D 0)
>                 return btd_error_invalid_args(msg);
>
>         err =3D a2dp_reconfig(chan, sender, lsep, rsep, caps, size,
> @@ -2418,7 +2418,7 @@ static void select_cb(struct a2dp_setup *setup, voi=
d *ret, int size)
>         struct avdtp_media_codec_capability *codec;
>         int err;
>
> -       if (size) {
> +       if (ret && size > 0) {
>                 caps_add_codec(&setup->caps, setup->sep->codec, ret, size=
);
>                 goto done;
>         }

Ive sent a similar fix, there is also a patch to abort if stream
cannot be closed when switching streams. Regarding the endpoint
selection it seems to be working correctly at least it does choose the
endpoints in the order they are registered.

--=20
Luiz Augusto von Dentz
