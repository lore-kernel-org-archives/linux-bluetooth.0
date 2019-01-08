Return-Path: <SRS0=sr2f=PQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03322C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 16:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA10420883
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 16:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIrx7uDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfAHQoi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:44:38 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:45958 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfAHQoh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jan 2019 11:44:37 -0500
Received: by mail-oi1-f179.google.com with SMTP id y1so3807856oie.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jan 2019 08:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kiB9bR9DtV0Jzj+nNBAHgVNcd0MEGtWFOqu2zri1AeM=;
        b=DIrx7uDnQ1/UBVCbxaHSVRYd9pRO0Vg9ey8JqE23yK4qT3LR//1DmDg4pTTdj4O81W
         +xPvKjrO2EJuR4LbTm1sgDh0Mw5m/7w6CrgAALlFT83V10RrwwfXMtskfCVWNXDrI1Wd
         YqJLIzNgDQAZXP3yeo+JuBts6iO3jOjEPB2CLRPHN1ck1U/GDM9hjLD5pZJZvsYnW9IW
         +IKg0kOUGHAG9hEzUzbhnEDBIMOJmDmIseXIaMOLQYHmNcORX2NpZW5CaV3M7IVRLlm2
         Ze2+2OJtvUh0wEz01t+cNOxkoOvq0qrviHOtUYQae0U0nHZmwepfSsAeQUPq6tAvzVFA
         EZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kiB9bR9DtV0Jzj+nNBAHgVNcd0MEGtWFOqu2zri1AeM=;
        b=kkwy2pEY4HDFGVKDGsBsxde2ey3htVbRUko6sGnmXu7YUCIjdUhx32t1YkV6YVIeWk
         f98v1vTN+7jaUkiWeNUjASwbAu+3FJeaGZkmvA2eb1fIW76nYMbogKNXb8vioNECNmY7
         VR5UIJcHB2dhAU3n6myACYVoap+cZOKGEMbO7LJd3NqAfN4HGA/2EI9elZXNYyqcY0l3
         MJ65OIuOgw6eICmjUp5WNOFn4M2zhOiBPKyaqKMWKTPzDKTSqW06nWAj7sIayWptVOgk
         uftydwsmDqA5bxL4nLwaTpeMLaxAL026wcdqqyudwQ/nsBq4Mv0dHsTfINK/0iXUswcN
         gEfQ==
X-Gm-Message-State: AJcUuke5/sjPz4j2Rd5pKviy1teI+TZz+4n14Z43FL7WeHpA9o0+SjOO
        115PFXigk3G3/jDXY8/DEvrRdH7CtL6e0DruSro=
X-Google-Smtp-Source: ALg8bN5+VMeY0ZstNLP+hW2fsPP6vj0EU+3qBi58ynlEHWHlCVmod+0qpkMYf7fmIdzwy0OzBionvRaoiUVJ4qgcU+U=
X-Received: by 2002:aca:ea57:: with SMTP id i84mr1594465oih.346.1546965875971;
 Tue, 08 Jan 2019 08:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20180711082352.oo6srapfnol5nkxq@pali> <CABBYNZJuGT5_zhg-BkAc4XjtVu5His92cHTujrin=SMOVbaodQ@mail.gmail.com>
 <20180711144501.ovdxc2expa4bg6sc@pali> <20181215202910.j24amjshrvjqprll@pali>
 <CABBYNZLK4tyL8nvWbXxr6VctyEyJkMdwNiWMy4gUge9h9Vb4SQ@mail.gmail.com>
 <20181228191102.GA31975@reaktio.net> <CABBYNZ+bwbSkH4qtkuzhE=JY6KAGwJ_E4ABGT_LE6E277eTNDQ@mail.gmail.com>
 <20181229130818.jdcpwlpyoyhdqlf3@pali>
In-Reply-To: <20181229130818.jdcpwlpyoyhdqlf3@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 8 Jan 2019 13:44:24 -0300
Message-ID: <CABBYNZK4+K5vRF0JCHFcUjbfzWanp_ju6XfQQJWBtiLqKi=e7Q@mail.gmail.com>
Subject: Re: bluez: dbus method call for switching endpoint
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali, Pasi,

On Sat, Dec 29, 2018 at 10:08 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> On Friday 28 December 2018 19:10:11 Luiz Augusto von Dentz wrote:
> > Hi Pasi,
> >
> > On Fri, Dec 28, 2018 at 4:46 PM Pasi K=C3=A4rkk=C3=A4inen <pasik@iki.fi=
> wrote:
> > >
> > > Hi Luiz,
> > >
> > > On Tue, Dec 18, 2018 at 01:02:39PM -0300, Luiz Augusto von Dentz wrot=
e:
> > > > Hi Pali,
> > > >
> > > > On Sat, Dec 15, 2018 at 5:29 PM Pali Roh=C3=A1r <pali.rohar@gmail.c=
om> wrote:
> > > > >
> > > > > On Wednesday 11 July 2018 16:45:01 Pali Roh=C3=A1r wrote:
> > > > > > On Wednesday 11 July 2018 16:27:07 Luiz Augusto von Dentz wrote=
:
> > > > > > > One way to solve all of these is that we would expose the rem=
ote
> > > > > > > endpoints using MediaEndpoint1
> > > > > >
> > > > > > So client application (like pulseadio) would see list of remote
> > > > > > endpoints (one for each codec) and choose one for connection?
> > > > > >
> > > > > > Looks like this should solve this problem.
> > > > >
> > > > > Are there any progress on such API in bluez?
> > > > >
> > > > > On pulseaudio mailing list other people proposed patches for othe=
r A2DP
> > > > > codecs and basically bluez API for choosing A2DP codec is still m=
issing
> > > > > part...
> > > >
> > > > Im currenlty on vacation but will try to find time for that, that s=
aid
> > > > that shouldn't stop us to include support for other codecs, the las=
t
> > > > set seems to have some sort of priority for ordering the registrati=
on
> > > > of the codecs.
> > > >
> > >
> > > Let us know when you have something to see/try!
> > > I'm happy to do testing of the patches.
> > >
> > > People are currently eager to get support for multiple BT audio codec=
s working and merged upstream :)
> >
> > Note that it is very unlikely that this API would allow multiple
> > codecs at the same time, headsets normally only allow one
> > configuration at time.
>
> Multiple codecs at the same time is not needed.
>
> > Making it possible to switch codecs is more of
> > a workaround for headsets that don't honor the codec priority since
> > they normally codec back, although some model no longer configure a
> > stream just wait the source.
>
> First thing is to provide list of supported codecs via dbus, so
> pulseaudio would know which codecs remote device (headset) support. And
> ideally tell it also to user.
>
> Second thing which is needed, is ability to switch to different
> supported codec. If headset supports 4 codecs, then user wants to switch
> from first codec to second and compare which is "better for him".
>
> And third thing, some headsets remember last used codec for particular
> notebook and when headset initialize connection it uses this codec.
> So if pulseaudio (or any other application) adds support for a new
> codec, which is also supported by that headset, then this codec would
> not be used -- even when it has higher priority in pulseaudio.
>
> I think probably all headsets (or at least majority of them) initialize
> connection to last "notebook/phone" device after starting it up.
>
> So priority defined by pulseaudio is not going to be used in above cases
> and we need a way in pulseaudio to switch from one codec to another.
>
> And forth thing, people lot of times listen music and their music is
> stored in some lossy compression codecs (MP3, AAC, ...). A2DP supports
> of these codecs and pulseaudio has already support for pass-through
> different codec payloads to sound card (if sound card driver support
> is). So this would allow us to e.g. pass-through MP3 or AAC data to
> supported headset without need to decode and encode again. Pulseaudio in
> this case can take care for switching from "better A2DP codec" to AAC
> when input application source is already in AAC; and then back to that
> previous "better A2DP codec" after AAC playback file finish.
>
> I think that similar technique is already used in Apple products which
> propagates AAC format.
>
> Therefore I do not think switching codec is some king of workaround or
> hack, but fully valid use case.

Except that we can't do that because we cannot garanteed there wont be
other sources active e.g. system notifications, etc, so in practice
complex/expensive codecs such as MP3 and AAC are hard to use since
that would mean we would have to encode on the fly. Perhaps there we
could have a setting for these type of codecs so the user would have
to opt-in if he want to just listen to those files, though if they are
using streaming services they normally decode on their own so AAC and
MP3 endpoint are not that useful with the likes of youtube, spotify,
etc.

> > Regarding the API I still didn't have time to start it, so it will
> > take a little longer than I antecipated.

Ive just sent the patches adding support to switch the endpoints, Ive
only tested with a couple of sony headsets so I would appreciate if
you guys could try it as well. Note that the SetConfiguration must
come from the same D-Bus connection as the endpoint that would be
used, also if there is already an stream in place it must also be from
the same client since it would be terminated in the process, this is
to prevent entities fighting to configure with its own priority though
usually we only PA endpoints, if you want to bypass this just for now
I have you can use the following changes:

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index cda2b6c64..e5e1e0d1c 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1574,10 +1574,11 @@ static int a2dp_reconfig(struct a2dp_channel
*chan, const char *sender,

                /* Attempt to reconfigure if a stream already exists */
                if (tmp->stream) {
-                       /* Only allow switching sep from the same sender */
-                       if (strcmp(sender, lsep->endpoint->get_name(tmp,
+                       /* Only allow switching sep from the same sender
+                       if (strcmp(sender, tmp->endpoint->get_name(tmp,
                                                        tmp->user_data)))
                                return -EPERM;
+                       */

                        err =3D avdtp_close(chan->session, tmp->stream, FAL=
SE);
                        if (err < 0) {
@@ -1627,12 +1628,31 @@ static DBusMessage
*set_configuration(DBusConnection *conn, DBusMessage *msg,
        dbus_message_iter_get_basic(&args, &path);
        dbus_message_iter_next(&args);

-       lsep =3D find_sep(chan->server, avdtp_get_type(rsep->sep), sender, =
path);
+       service =3D avdtp_get_codec(rsep->sep);
+       codec =3D (struct avdtp_media_codec_capability *) service->data;
+
+       if (!strcmp(path, "/")) {
+               GSList *l;
+
+               l =3D avdtp_get_type(rsep->sep) =3D=3D AVDTP_SEP_TYPE_SINK =
?
+                                       chan->server->sources :
+                                       chan->server->sinks;
+
+               for (; l; l =3D g_slist_next(l)) {
+                       if (endpoint_match_codec_ind(chan->session, codec,
+                                                               l->data))
+                               break;
+               }
+
+               if (l)
+                       lsep =3D l->data;
+       } else
+               lsep =3D find_sep(chan->server, avdtp_get_type(rsep->sep), =
sender,
+                               path);
+
        if (!lsep)
                return btd_error_invalid_args(msg);

-       service =3D avdtp_get_codec(rsep->sep);
-       codec =3D (struct avdtp_media_codec_capability *) service->data;

        /* Check if codec really matches */
        if (!endpoint_match_codec_ind(chan->session, codec, lsep))


--=20
Luiz Augusto von Dentz
