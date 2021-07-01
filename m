Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9F4C11F67
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jul 2021 22:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F44A61410
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jul 2021 22:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhGAWxQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Jul 2021 18:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhGAWxQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Jul 2021 18:53:16 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83949C061762
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Jul 2021 15:50:44 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id m9so13439362ybo.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Jul 2021 15:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9VFyQcYYvFG3wwO4gx9lxF3Zs7HMjQdIXDTXQZ6iPTA=;
        b=l9MQv5MnUaXCNTmt7CtSijc/DcsO7LHsX1l/Wi0PQ4noBmwDerDP5EGrGRhyoHbAP5
         AqMKRWPCDWR367Rut3kyXSuj44atwSW0FPDP/+fvyPlzRaBfWfbEg0OMOkGqmBgGOhBy
         zfRHrVbBUJ34BJ7tB6esPsVzIUMpSCksY2gOQIUfbxFGcq1sQi65sKXB+jp9zoqSo7YS
         cSG426tf2P0dSECDSllMVeUrYTjNksmtst0G1NFjgf6kPvKsFe0zWVGFbgqfqZnp5V25
         1YDuNy2W09sHg9KNbgf9kK+410C4wTH08UM2XwMVzrqNMPzfSCKRfboC4OV0PvMHerBK
         hB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9VFyQcYYvFG3wwO4gx9lxF3Zs7HMjQdIXDTXQZ6iPTA=;
        b=HhWx3PPqutDy6SHQESWZrjVniCfKUc/WguuoT7tsmGHxaSRJU7APvghwnNAeT7cNEU
         7yodcgycGjqgIDJI3SF83p1dyMT4tffmH7LTX6u5LXGQ4limo4b9RTTsT7EkJ702/lEw
         OWq7xNCMvB3Av/3ADqPVfekfdkie+7NjDrII8CCgOmxOOA8GRHg/hz34A+YlBzCNc5mV
         D6uo8KyUk+JAjpqbJ+tJdd4i3awBUFM7m0PrvmMO9ppmJTR2nFgbD9fEsgKTKk+qPyDy
         /LnUF9iKJjttD+CNFt5UEkya3hFgN+KnFsVzK5vMaPIClIf+PuonLLcjACi4McBUcxA/
         IYsQ==
X-Gm-Message-State: AOAM530QlkBFbr3JlHPJxTlgovD7GFqlUEkRnUbyLmBD+KAwI86CRize
        RXq5Qr1g5J9+EoYkWMMYNnWvQwo6CHq4Xf9kez4=
X-Google-Smtp-Source: ABdhPJybJGYurA1d+/1q4/X5XHyYfbRx4SKcuzobCUVFwGq9M3Ffi+y+kAJr2BLbMKVduso5YkL7tbfnuRCSIU8WnZo=
X-Received: by 2002:a25:7647:: with SMTP id r68mr2838440ybc.432.1625179843693;
 Thu, 01 Jul 2021 15:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210611020728.15233-1-jprvita@endlessos.org> <CA+A7VXVO6cyVCRnEHvPC1jW_+rQ582AA6c9n68xiGg5t0NwnHQ@mail.gmail.com>
In-Reply-To: <CA+A7VXVO6cyVCRnEHvPC1jW_+rQ582AA6c9n68xiGg5t0NwnHQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 1 Jul 2021 15:50:32 -0700
Message-ID: <CABBYNZLJP7FgKgxbKbvuBJejTKeeXvsTDgWTL3n2=HE4fRoTOw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] profile: Fail RegisterProfile if UUID already exists
To:     =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessos.org>,
        linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jo=C3=A3o,

On Tue, Jun 29, 2021 at 4:52 PM Jo=C3=A3o Paulo Rechi Vita <jprvita@gmail.c=
om> wrote:
>
> On Thu, Jun 10, 2021 at 7:07 PM Jo=C3=A3o Paulo Rechi Vita <jprvita@gmail=
.com> wrote:
> >
> > From: Jo=C3=A3o Paulo Rechi Vita <jprvita@gmail.com>
> >
> > If a process tries to register a profile implementation that is already
> > registered, RegisterProfile should fail.
> >
> > This should help address issues when two instances of PulseAudio are
> > running at the same time, and the second instance tries to register an
> > audio profile implementation that has already been registered by the
> > first instance. Two situations where this may happen is when more than
> > one user is logged in, or during the transition between the GDM session
> > and the user session, when PulseAudio gets started on the new session
> > before the old session has been fully terminated.
> >
> > https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/303
> > https://gitlab.gnome.org/GNOME/gdm/-/issues/486
>
> Any feedback on these changes?  I have
> https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/merge_requests/593
> on the PulseAudio side, and we have been shipping these changes on
> Endless OS to address the case where PulseAudio gets started on the
> user session before PulseAudio on the GDM session has finished.
>
> Thanks,
>
> Jo=C3=A3o Paulo.
>
> > ---
> >  src/profile.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/src/profile.c b/src/profile.c
> > index 5e460b639..60d17b6ae 100644
> > --- a/src/profile.c
> > +++ b/src/profile.c
> > @@ -749,6 +749,30 @@ void btd_profile_foreach(void (*func)(struct btd_p=
rofile *p, void *data),
> >         }
> >  }
> >
> > +static struct btd_profile *btd_profile_find_uuid(const char *uuid)
> > +{
> > +       GSList *l, *next;
> > +
> > +       for (l =3D profiles; l !=3D NULL; l =3D next) {
> > +               struct btd_profile *p =3D l->data;
> > +
> > +               if (!g_strcmp0(p->local_uuid, uuid))
> > +                       return p;
> > +               next =3D g_slist_next(l);
> > +       }
> > +
> > +       for (l =3D ext_profiles; l !=3D NULL; l =3D next) {
> > +               struct ext_profile *ext =3D l->data;
> > +               struct btd_profile *p =3D &ext->p;
> > +
> > +               if (!g_strcmp0(p->local_uuid, uuid))
> > +                       return p;
> > +               next =3D g_slist_next(l);
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> >  int btd_profile_register(struct btd_profile *profile)
> >  {
> >         profiles =3D g_slist_append(profiles, profile);
> > @@ -2441,6 +2465,12 @@ static DBusMessage *register_profile(DBusConnect=
ion *conn,
> >         dbus_message_iter_get_basic(&args, &uuid);
> >         dbus_message_iter_next(&args);
> >
> > +       if (btd_profile_find_uuid(uuid)) {
> > +               warn("%s tried to register %s which is already register=
ed",
> > +                                                               sender,=
 uuid);
> > +               return btd_error_not_permitted(msg, "UUID already regis=
tered");
> > +       }
> > +
> >         if (dbus_message_iter_get_arg_type(&args) !=3D DBUS_TYPE_ARRAY)
> >                 return btd_error_invalid_args(msg);
> >
> > --
> > 2.20.1
> >

Applied, thanks.

--=20
Luiz Augusto von Dentz
