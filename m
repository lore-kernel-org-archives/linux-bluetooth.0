Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0334C11F67
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jun 2021 23:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD26A61D7C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jun 2021 23:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhF2XtS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jun 2021 19:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbhF2XtS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jun 2021 19:49:18 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915E3C061760
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jun 2021 16:46:49 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id s129so1863499ybf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jun 2021 16:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FP+kHQ/2T+9JbkqM9X6dbh3XePTDdwySVW4Odxfp830=;
        b=KcFBV5SMQeDHFTiTx74Th2qUR6MYvro+JdzILlVB5Soo1wUbhRDiwKDmsZP9BGv1EY
         OkCMQlQU9nd/cuqR3dSLr2L/DAqkFuPIv0vmB7/pUm7FZSKXRplAjajquBHrLl62YYri
         VZh1Y3Yj68LNXW1j3RulX0rz0qgFXc3TnGo3o2YDXDqg4Y04uowL6RTQbMLsO4401QgU
         4oPXFYEzltZan7Ah1MH9zY10YY4A636uWxVPW80joDPkFY4/x0JFuzxvA9td2USLmqhF
         4oR5laDzdV4MX3V5hsVnbfeWJWGVdblgJ0NpfMEny0bcdC/N+yGJV8lnpsCxdLwCMJIC
         CuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FP+kHQ/2T+9JbkqM9X6dbh3XePTDdwySVW4Odxfp830=;
        b=AT5RxNv0GlGYXsAi8zfw5wKl3ToxNc3kHxvMExImUnAbY6YI/YBnpwt11Oh/AehKSQ
         6iXSwHaUVA3XlN6Yrzu91nxEV1YNvVWEQaNLIefZps2dR9tHutrFXzjiYAcDepyqaVVG
         WF9TAeAQRDJkGbjk/E8F4a48gQ0HRgWprqyVX6xGsCfZq3pI/cFdAysZ/v8tiAY6RZJ6
         aoZkdfJ5u1xFQHhSa2DptdPHUDMnghnKD36GFpKwlHoCnH+Oa2PrCYDbR6M5LQgllJpf
         82t+JKaHUQXA8ArNk7So5epoL2FPdkufmVmba3xV7tqGiT0IL+JReTRcu5Jg1Akvo6qS
         XaYg==
X-Gm-Message-State: AOAM532n4aeyh6Cvkzj9x1klQa6aSygy4iZHBkXgBms1fO7+HpvQdYfo
        0zYanuWiTKg1yOqWo3fanmysLVge2W+zsoIBD30UM5uqqPf00w==
X-Google-Smtp-Source: ABdhPJxckTexSBoM9B7jSdHXIOzzJoqc2KB46gXqcri5QN4lKy85Vi/Mm8XTuR4DjmVYIHyo1ZHTEDclHkxA5AT5RMU=
X-Received: by 2002:a25:3415:: with SMTP id b21mr23044236yba.155.1625010408487;
 Tue, 29 Jun 2021 16:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210611020728.15233-1-jprvita@endlessos.org>
In-Reply-To: <20210611020728.15233-1-jprvita@endlessos.org>
From:   =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date:   Tue, 29 Jun 2021 16:46:12 -0700
Message-ID: <CA+A7VXVO6cyVCRnEHvPC1jW_+rQ582AA6c9n68xiGg5t0NwnHQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] profile: Fail RegisterProfile if UUID already exists
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessos.org>,
        linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Jun 10, 2021 at 7:07 PM Jo=C3=A3o Paulo Rechi Vita <jprvita@gmail.c=
om> wrote:
>
> From: Jo=C3=A3o Paulo Rechi Vita <jprvita@gmail.com>
>
> If a process tries to register a profile implementation that is already
> registered, RegisterProfile should fail.
>
> This should help address issues when two instances of PulseAudio are
> running at the same time, and the second instance tries to register an
> audio profile implementation that has already been registered by the
> first instance. Two situations where this may happen is when more than
> one user is logged in, or during the transition between the GDM session
> and the user session, when PulseAudio gets started on the new session
> before the old session has been fully terminated.
>
> https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/303
> https://gitlab.gnome.org/GNOME/gdm/-/issues/486

Any feedback on these changes?  I have
https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/merge_requests/593
on the PulseAudio side, and we have been shipping these changes on
Endless OS to address the case where PulseAudio gets started on the
user session before PulseAudio on the GDM session has finished.

Thanks,

Jo=C3=A3o Paulo.

> ---
>  src/profile.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/src/profile.c b/src/profile.c
> index 5e460b639..60d17b6ae 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -749,6 +749,30 @@ void btd_profile_foreach(void (*func)(struct btd_pro=
file *p, void *data),
>         }
>  }
>
> +static struct btd_profile *btd_profile_find_uuid(const char *uuid)
> +{
> +       GSList *l, *next;
> +
> +       for (l =3D profiles; l !=3D NULL; l =3D next) {
> +               struct btd_profile *p =3D l->data;
> +
> +               if (!g_strcmp0(p->local_uuid, uuid))
> +                       return p;
> +               next =3D g_slist_next(l);
> +       }
> +
> +       for (l =3D ext_profiles; l !=3D NULL; l =3D next) {
> +               struct ext_profile *ext =3D l->data;
> +               struct btd_profile *p =3D &ext->p;
> +
> +               if (!g_strcmp0(p->local_uuid, uuid))
> +                       return p;
> +               next =3D g_slist_next(l);
> +       }
> +
> +       return NULL;
> +}
> +
>  int btd_profile_register(struct btd_profile *profile)
>  {
>         profiles =3D g_slist_append(profiles, profile);
> @@ -2441,6 +2465,12 @@ static DBusMessage *register_profile(DBusConnectio=
n *conn,
>         dbus_message_iter_get_basic(&args, &uuid);
>         dbus_message_iter_next(&args);
>
> +       if (btd_profile_find_uuid(uuid)) {
> +               warn("%s tried to register %s which is already registered=
",
> +                                                               sender, u=
uid);
> +               return btd_error_not_permitted(msg, "UUID already registe=
red");
> +       }
> +
>         if (dbus_message_iter_get_arg_type(&args) !=3D DBUS_TYPE_ARRAY)
>                 return btd_error_invalid_args(msg);
>
> --
> 2.20.1
>
