Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C415531E
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545367; cv=none; b=Iyu235zmCOzkvjBGuqS4B2k64yFpbmU5xh01xEvm6BtvvcNYkG4oZ5Mw8KOiMLE1o3a102+jGDKtXAQZC4SV30Vvi7VHcmGsR4VOWJAVKCPe6bnhY3mH+3zLMT5vUGdIhoqImYs2pHL53noDLzCIcRqUc4mY/e3qNRTZNxZnBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545367; c=relaxed/simple;
	bh=MIxMGT000iQtcdRloV7rhzFz4GnCIgWIZ/OSFpUySlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eULcuReOP1AkFNIQG7x3HjAxGZW/IZdceG3meGrxSB26mHbPCricXqsgakNkXzMxhtaOjQv5eBVmSB61ykSxSygzWV6XcVZH6eQU2AhRCzDYYxhI8CqIVcGjaMV6TeP0Kry13RlNRogwmq7FldbPEWw0IZxdbhPwhEwxtpU4j8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5M+Hm1w; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5M+Hm1w"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d040a62a76so16304961fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 08:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706545363; x=1707150163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ibq/C1PHfbUzyPiCU+Zb70UIMKQSn70SZrLQDXeEl0=;
        b=K5M+Hm1w5AC/shCY8Posw+7xVE4b9jZ1RAo5sAPZVyW678lxk8RACRSrJlGhm9kw0w
         b8Za/Grzp6meMs5UcptWyup/vKXwlWh3liS1ZyM9PxWrZmdQR8ffdCwJN+whGY2z9rnf
         my5p0Y5E7OGSfFWDmrGBm+MqNbVNKd4Mgyb1WJUO95hqUFz0bWp2OtDNHxNTU6a9fjkD
         QaokYansbsLjt9qHHEefDufdYnG+AqVzyS0oMWeDHBMftA32xz6r19LZvmuHKg39gMsI
         3lfZAni7eAburDcbu0sDScah+sKHjdH3MeKr8ultPWBFsIk+RybAX7gGmR2RygCX/MFZ
         5CXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706545363; x=1707150163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ibq/C1PHfbUzyPiCU+Zb70UIMKQSn70SZrLQDXeEl0=;
        b=P4T3hAxau82Q7UytaavK5tZcMib5tpLcEd1aevyHL/+MI9wgw3KAtSRQpZO2Epn0s/
         Cb3RrTjVAQENsTgFbDMoyfJ3uMb0rxcnGJuV5SnIXFy21yN03G49uGAepKHgKeO0s43p
         YN7x1XqaISoz6OEYqxedDcof8GVElw9m/5QIm4dKhgmMcICY0unPx1wTToxMjbuhLOx/
         6WdELbnAY/U3G75VQVEvqAQ08YOd8J8XCLcMyshL7roPx8+E16CLWb9Ju974iygywRsh
         /sG97ieMGTIkOb+cfinccFEQ60tzTfFF6xZREbV2Fs28hT1gp9jVNtIUvyUKEbuhg4SQ
         7Xkw==
X-Gm-Message-State: AOJu0Ywtx57VrzVqEoFiiYuUhpFric4a4faqBpAQgoq2t9SYo8cV04uT
	JZfzfz1ZCXPsRwpAMGqli9OUl+GrWjIuL43Hj7e4lNtI/PGuKvUnlPZQzm0cq+7LIA8lKCzmDSt
	lgly+xE76OBfeGOpwqPYBoqwWWajrwHyG
X-Google-Smtp-Source: AGHT+IHmo93ZlLpSN6Q6zHyDsgG3Q9KeNuJUeql9nx/oEihZ1Hybh5XSVenGgNax2oBhF4nnYLO4VPuXpkpsyfo4pyE=
X-Received: by 2002:a05:651c:23b:b0:2cc:9491:6743 with SMTP id
 z27-20020a05651c023b00b002cc94916743mr4266564ljn.27.1706545363219; Mon, 29
 Jan 2024 08:22:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
 <20240129-rm-ext-plugins-v4-7-bfd1e08c7f99@gmail.com> <a97398e2-856b-4034-b8d3-e65f54b2bb17@molgen.mpg.de>
In-Reply-To: <a97398e2-856b-4034-b8d3-e65f54b2bb17@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Jan 2024 11:22:30 -0500
Message-ID: <CABBYNZJY0-hfvUEM101fE4WogdH_cosP65_ai=QUKUcs57JFUA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 7/8] bluetoothd: change plugin loading alike obexd
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Emil Velikov <emil.velikov@collabora.com>, linux-bluetooth@vger.kernel.org, 
	emil.l.velikov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon, Jan 29, 2024 at 10:37=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear Emil,
>
>
> Thank you for your patches.
>
> Am 29.01.24 um 15:44 schrieb Emil Velikov via B4 Relay:
> > From: Emil Velikov <emil.velikov@collabora.com>
> >
> > Currently, we print "Loading foobar" for every plugin, before we try th=
e
> > respective init() callback. Instead we handle the latter in a bunch, at
> > the end of the process.
>
> Excuse my ignorance, but would you be so kind to state the problem. It=E2=
=80=99s
> causing confusion to have `Loading foobar`, in case it fails? It
> clutters the output or uses unnecessory resources?

To me it sounds quite clear that he is refering to the fact that obexd
prints it a little differently so he is just trying to align the
behavior of the daemons.

> > Do the init() call early, print "Loaded" once it's actually successful
> > and drop the no-longer "active" tracking.
>
> It would help me, if you pasted the logs without and with your patch.
>
>
> Kind regards,
>
> Paul
>
>
> > ---
> >   src/plugin.c | 53 +++++++++++++++++++++++++++++----------------------=
--
> >   1 file changed, 29 insertions(+), 24 deletions(-)
> >
> > diff --git a/src/plugin.c b/src/plugin.c
> > index b6a84299a..e6d05be4c 100644
> > --- a/src/plugin.c
> > +++ b/src/plugin.c
> > @@ -32,7 +32,6 @@ static GSList *plugins =3D NULL;
> >
> >   struct bluetooth_plugin {
> >       void *handle;
> > -     gboolean active;
> >       const struct bluetooth_plugin_desc *desc;
> >   };
> >
> > @@ -44,6 +43,22 @@ static int compare_priority(gconstpointer a, gconstp=
ointer b)
> >       return plugin2->desc->priority - plugin1->desc->priority;
> >   }
> >
> > +static int init_plugin(const struct bluetooth_plugin_desc *desc)
> > +{
> > +     int err;
> > +
> > +     err =3D desc->init();
> > +     if (err < 0) {
> > +             if (err =3D=3D -ENOSYS || err =3D=3D -ENOTSUP)
> > +                     warn("System does not support %s plugin",
> > +                                             desc->name);
> > +             else
> > +                     error("Failed to init %s plugin",
> > +                                             desc->name);
> > +     }
> > +     return err;
> > +}
> > +
> >   static gboolean add_external_plugin(void *handle,
> >                               const struct bluetooth_plugin_desc *desc)
> >   {
> > @@ -57,19 +72,22 @@ static gboolean add_external_plugin(void *handle,
> >               return FALSE;
> >       }
> >
> > -     DBG("Loading %s plugin", desc->name);
> > -
> >       plugin =3D g_try_new0(struct bluetooth_plugin, 1);
> >       if (plugin =3D=3D NULL)
> >               return FALSE;
> >
> >       plugin->handle =3D handle;
> > -     plugin->active =3D FALSE;
> >       plugin->desc =3D desc;
> >
> > +     if (init_plugin(desc) < 0) {
> > +             g_free(plugin);
> > +             return FALSE;
> > +     }
> > +
> >       __btd_enable_debug(desc->debug_start, desc->debug_stop);
> >
> >       plugins =3D g_slist_insert_sorted(plugins, plugin, compare_priori=
ty);
> > +     DBG("Plugin %s loaded", desc->name);
> >
> >       return TRUE;
> >   }
> > @@ -86,7 +104,13 @@ static void add_plugin(const struct bluetooth_plugi=
n_desc *desc)
> >
> >       plugin->desc =3D desc;
> >
> > +     if (init_plugin(desc) < 0) {
> > +             g_free(plugin);
> > +             return;
> > +     }
> > +
> >       plugins =3D g_slist_insert_sorted(plugins, plugin, compare_priori=
ty);
> > +     DBG("Plugin %s loaded", desc->name);
> >   }
> >
> >   static gboolean enable_plugin(const char *name, char **cli_enable,
> > @@ -177,7 +201,6 @@ static void external_plugin_init(char **cli_disable=
d, char **cli_enabled)
> >
> >   void plugin_init(const char *enable, const char *disable)
> >   {
> > -     GSList *list;
> >       char **cli_disabled =3D NULL;
> >       char **cli_enabled =3D NULL;
> >       unsigned int i;
> > @@ -205,24 +228,6 @@ void plugin_init(const char *enable, const char *d=
isable)
> >       if IS_ENABLED(EXTERNAL_PLUGINS)
> >               external_plugin_init(cli_enabled, cli_disabled);
> >
> > -     for (list =3D plugins; list; list =3D list->next) {
> > -             struct bluetooth_plugin *plugin =3D list->data;
> > -             int err;
> > -
> > -             err =3D plugin->desc->init();
> > -             if (err < 0) {
> > -                     if (err =3D=3D -ENOSYS || err =3D=3D -ENOTSUP)
> > -                             warn("System does not support %s plugin",
> > -                                                     plugin->desc->nam=
e);
> > -                     else
> > -                             error("Failed to init %s plugin",
> > -                                                     plugin->desc->nam=
e);
> > -                     continue;
> > -             }
> > -
> > -             plugin->active =3D TRUE;
> > -     }
> > -
> >       g_strfreev(cli_enabled);
> >       g_strfreev(cli_disabled);
> >   }
> > @@ -236,7 +241,7 @@ void plugin_cleanup(void)
> >       for (list =3D plugins; list; list =3D list->next) {
> >               struct bluetooth_plugin *plugin =3D list->data;
> >
> > -             if (plugin->active =3D=3D TRUE && plugin->desc->exit)
> > +             if (plugin->desc->exit)
> >                       plugin->desc->exit();
> >
> >               if (plugin->handle !=3D NULL)
> >
>


--=20
Luiz Augusto von Dentz
