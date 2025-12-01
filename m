Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5318A23A994
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611875; cv=none; b=B+RjQclUbMwtkMZNQxuWwg3V5IXHzZ5EPq0XaPISYLUtNqfJ7vCHYG6fP1IwwTsjQkAtDjqhxGvzimYqJIEw0JHswyMfUlDRA4odFN07k/5UjVAaJsc0W/T3WffAu9MKf+RusVYTmdy/pNGQ9GjskV44vqW5By48TT9ccFZwm9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611875; c=relaxed/simple;
	bh=sBc5NObctg8YJekEgclZeHUSSk+l7ku8gsgsxsL/Oqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaNvI96GlnHQCBv2C13Ya85eH59WYB6dsC+TFvZM/61PqsheLBHobo2UwA6vGanO0xlIUv43PBed/ZngCaDRfi0KynEEq2wcNrT7pUVGzpFP1rrqXBlBiSohsY8q1ymMurT41rSbGXxV+7CqyLs1m7lQiCT+I8W6169WnZ9/onc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEjkR5/1; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEjkR5/1"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37e56b0712aso814791fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Dec 2025 09:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764611871; x=1765216671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEIO/0tfihrMhMGtubzpjT5uEiBHD4pqFdrz4SlSkDc=;
        b=YEjkR5/1ryIxc21Fl3zS9RXSCSL9F09FyDpdsj3cbVI1bUpwz8amQ8tPk0yJObzAzc
         3FYJf5K5AbSFlYgkQxquZ+cbZJ7SK7W1/C75YtA9xrSVAnZYhCKDFYjoqB9Qh3m8XQ5T
         cTOCEh5biQ8AFFpDP5GAkS3eXN9+EmVU/ByrmfBAKMhSQtwCBFuTpIRjZ+QNfS6gzIhw
         hTwqpWdSu+Z5iUvhy4EEoVmx/OUKQhW+fv2EM3ZC8Tg6TM8pWlhAri2IMBsPVSNLGZ2J
         9tS5rtxC3jT52C/oTX5CW0aTrb+49oM50NtKJ/rRn37MsMEy6h/2NqN2+tDKVeswqbP1
         8drA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764611871; x=1765216671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sEIO/0tfihrMhMGtubzpjT5uEiBHD4pqFdrz4SlSkDc=;
        b=uNRqiSItJ6MmUaqZFXASp3va1OhhHVGn0/Cu9aN4r4p0Bw0OohZFRE9EsreCdSeT94
         tc6qWay239cxTRRzZI9MSpOvnBJ/hkJGuIPVf5AojD0ZoNis1kpMCmHalcGiY3Mwd0Mx
         NCGVKkfIeCk+NJgLVvtPge9O+EgyhRCAI1diUIVtz0XWQaAukCl/SYstDr3glzZ8qmr9
         fKSGAqDzGVKcv7oiYXkdo1z7WxKFcpnKXBojZE9SIlMS5uNZ8TvOWi+Hg/4gG/zhJcpF
         onKa68T4akF5Z/booOW/uV4KN0iyEiMcGPFciHQx2/djPk/aDAT6MaCeji6ui8093hY3
         RAkw==
X-Gm-Message-State: AOJu0Yy9o2uKwClXXF9ERUNa3G+xIY7ffbHbvME/ixWunzPKtXVE7Hyx
	vWbSBbtv8SpNgNOdZIZu/chMI5430gp/KC7m6T6zmSyarygCZ5cUmlKxo/tBfxlnCCjUrzk9L9V
	5+pEwAqyw4iNuxT3htTOXlblOBo90NMdPDA==
X-Gm-Gg: ASbGnctvzIwd/1bAEcKvdXcuiQx1KTbsI39vDO5jNmP6GpYk7djFRv5Kd+Uybn1skXu
	dheTNZ4BkcK44Ta217iWIfv2SqZCSGbPtWOiC3hENFwFeU71m4mR8To0VX3IsPxXPoC/NzDychc
	ZJuYHxsg6YHF2yF913YcQhFXcS5rnt9FFlWrJ0MksDEMasxvrzEhTwsXzGbIEQCRcDnvRTYdV18
	ZPRhD4oIbFTRcV6abV4b6O/Z52lw7fPv/XxSAgEHhe3Dj6x4XViVFtLcvRGMfNixXsY8PuIWndV
	RCsN
X-Google-Smtp-Source: AGHT+IFPtkm92Zbh7Kj1CNFR4azkamGeScIshhxwksWtyYI4myLzYnJPmGXrEzWZ+ZlN0pLH3k+cn12r4yQIFMXkG90=
X-Received: by 2002:a05:651c:3251:b0:37a:3615:89f2 with SMTP id
 38308e7fff4ca-37cd9153321mr110605721fa.9.1764611871079; Mon, 01 Dec 2025
 09:57:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764360140.git.pav@iki.fi> <0e68b96a2adb2f49be8ee961496d3033f32139fe.1764360140.git.pav@iki.fi>
 <CABBYNZJievzOzAMGRoCVbXUKr6pwscDBMz2+A9N9uXs7qgrWVg@mail.gmail.com> <52d53a65eab6603b196af8f95e61c52ab1f34f1d.camel@iki.fi>
In-Reply-To: <52d53a65eab6603b196af8f95e61c52ab1f34f1d.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Dec 2025 12:57:38 -0500
X-Gm-Features: AWmQ_bmwpEoAefWmC1RJwMuIkjdtRsnDybtGd87DAFLT7Kl9FJfy4O5gX6OYYvo
Message-ID: <CABBYNZ+MBjLrWy=PscW1nVS7NVTfNbBncWeQHgQTrWTPTT2K9A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 6/9] profile: add after_uuids for ordering
 profile startup
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Dec 1, 2025 at 12:33=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> ma, 2025-12-01 kello 12:00 -0500, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Fri, Nov 28, 2025 at 3:03=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Add btd_profile::after_uuids to specify the profile connect/accept or=
der
> > > for autoconnect.  This is a "soft" dependency so it doesn't fail if t=
he
> > > other services fail to start nor try to start them if they otherwise
> > > wouldn't.
> > >
> > > Add btd_profile_sort_list() for sorting a list according to profile
> > > ordering, taking account priority and after_uuids.
> > >
> > > Add btd_profile_find_remote_uuid() lookup utility, needed when using
> > > btd_profile_sort_list() with uuid lists.
> > > ---
> > >
> > > Notes:
> > >     v2:
> > >     - new commit
> > >
> > >  src/profile.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  src/profile.h | 13 ++++++++
> > >  2 files changed, 102 insertions(+)
> > >
> > > diff --git a/src/profile.c b/src/profile.c
> > > index 66405d7e4..eaf368a4a 100644
> > > --- a/src/profile.c
> > > +++ b/src/profile.c
> > > @@ -773,6 +773,30 @@ static struct btd_profile *btd_profile_find_uuid=
(const char *uuid)
> > >         return NULL;
> > >  }
> > >
> > > +struct btd_profile *btd_profile_find_remote_uuid(const char *uuid)
> > > +{
> > > +       GSList *l, *next;
> > > +
> > > +       for (l =3D profiles; l !=3D NULL; l =3D next) {
> > > +               struct btd_profile *p =3D l->data;
> > > +
> > > +               if (!g_strcmp0(p->remote_uuid, uuid))
> > > +                       return p;
> > > +               next =3D g_slist_next(l);
> > > +       }
> > > +
> > > +       for (l =3D ext_profiles; l !=3D NULL; l =3D next) {
> > > +               struct ext_profile *ext =3D l->data;
> > > +               struct btd_profile *p =3D &ext->p;
> > > +
> > > +               if (!g_strcmp0(p->remote_uuid, uuid))
> > > +                       return p;
> > > +               next =3D g_slist_next(l);
> > > +       }
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > >  int btd_profile_register(struct btd_profile *profile)
> > >  {
> > >         if (profile->experimental && !(g_dbus_get_flags() &
> > > @@ -2650,3 +2674,68 @@ void btd_profile_cleanup(void)
> > >         g_dbus_unregister_interface(btd_get_dbus_connection(),
> > >                                 "/org/bluez", "org.bluez.ProfileManag=
er1");
> > >  }
> > > +
> > > +/* Stable sort of a list according to profile priority & after_uuids=
 */
> > > +GSList *btd_profile_sort_list(GSList *list, btd_profile_list_get get=
,
> > > +                                                       void *user_da=
ta)
> > > +{
> > > +       GSList *result =3D NULL;
> > > +       GSList *remain =3D list;
> > > +       GHashTable *uuids;
> > > +       GSList *entry;
> > > +       const struct btd_profile *p;
> > > +
> > > +       uuids =3D g_hash_table_new_full(g_str_hash, g_str_equal, g_fr=
ee, NULL);
> > > +
> > > +       /* Unsatisfied remote uuids */
> > > +       for (entry =3D remain; entry; entry =3D g_slist_next(entry)) =
{
> > > +               p =3D get(entry->data, user_data);
> > > +               if (p->remote_uuid)
> > > +                       g_hash_table_add(uuids, g_strdup(p->remote_uu=
id));
> > > +       }
> > > +
> > > +       /* Sort */
> > > +       while (remain) {
> > > +               GSList *first_entry =3D remain;
> > > +               int max_priority =3D INT_MIN;
> > > +
> > > +               /* Find max priority */
> > > +               for (entry =3D remain; entry; entry =3D g_slist_next(=
entry)) {
> > > +                       p =3D get(entry->data, user_data);
> > > +                       if (p->priority > max_priority) {
> > > +                               first_entry =3D entry;
> > > +                               max_priority =3D p->priority;
> > > +                       }
> > > +               }
> > > +
> > > +               /* Find max priority entry with no unsatisfied depend=
encies */
> > > +               for (entry =3D remain; entry; entry =3D g_slist_next(=
entry)) {
> > > +                       const char **uuid;
> > > +
> > > +                       p =3D get(entry->data, user_data);
> > > +                       if (p->priority < max_priority)
> > > +                               continue;
> > > +
> > > +                       for (uuid =3D p->after_uuids; uuid && *uuid; =
uuid++)
> > > +                               if (g_hash_table_contains(uuids, *uui=
d))
> > > +                                       break;
> > > +                       if (!(uuid && *uuid))
> > > +                               break;
> > > +               }
> > > +
> > > +               /* If cyclic dependencies: break preserving priority =
& order */
> > > +               if (!entry)
> > > +                       entry =3D first_entry;
> > > +
> > > +               p =3D get(entry->data, user_data);
> > > +               if (p->remote_uuid)
> > > +                       g_hash_table_remove(uuids, p->remote_uuid);
> > > +
> > > +               remain =3D g_slist_remove_link(remain, entry);
> > > +               result =3D g_slist_concat(result, entry);
> > > +       }
> > > +
> > > +       g_hash_table_destroy(uuids);
> > > +
> > > +       return result;
> > > +}
> >
> > We might need to build some unit testing for this sort of function,
> > for checking if we handle cyclic/circular dependencies, if we don't
> > end up with duplicated entries in the list as well, not sure how much
> > testing you have done in this respect since we only really have one
> > plugin using after_uuids.
>
> I think the function should be correct, but yes unit tests would be
> good to have here.

I don't think it is wrong, it seems correct at first glance, the
problem is once it is integrated we can run into corner cases, so
having some way to introduce tests for corner cases is in my opinion
required.

>
> > > diff --git a/src/profile.h b/src/profile.h
> > > index 424ce55ad..a8c2443e3 100644
> > > --- a/src/profile.h
> > > +++ b/src/profile.h
> > > @@ -38,6 +38,12 @@ struct btd_profile {
> > >          */
> > >         bool testing;
> > >
> > > +       /* Indicates the profile should be ordered after profiles pro=
viding
> > > +        * these remote uuids when connecting. A NULL-terminated arra=
y of
> > > +        * strings.
> > > +        */
> > > +       const char **after_uuids;
> >
> > Hmm, I wonder if this shouldn't be a struct with uuids list and
> > function to be called when connected? Perhaps having a macro that
> > initializes the list would be a good idea as well.
>
> So
>
> struct btd_profile_uuid_cb {
>         void (*func)(struct btd_service *service);
>         unsigned int count;
>         const char *remote_uuids[];
> };
>
> struct btd_profile {
>         ...
>
>         const struct btd_profile_uuid_cb *after;
> };
>
> or maybe you meant something different like separate callbacks for each
> UUID?

Yeah, that seems alright, I guess we could have one per uuid as well
in case the profile really need to do something for each profile it
connects, but we need one for when everything has been connected
anyway so Id leave just one callback for now until there is a use case
where it needs callbacks to be run on a per uuid basis.

> >
> > > +
> > >         int (*device_probe) (struct btd_service *service);
> > >         void (*device_remove) (struct btd_service *service);
> > >
> > > @@ -76,3 +82,10 @@ bool btd_profile_remove_custom_prop(const char *uu=
id, const char *name);
> > >
> > >  void btd_profile_init(void);
> > >  void btd_profile_cleanup(void);
> > > +
> > > +struct btd_profile *btd_profile_find_remote_uuid(const char *uuid);
> > > +
> > > +typedef const struct btd_profile *(*btd_profile_list_get)(void *item=
,
> > > +                                                       void *user_da=
ta);
> > > +GSList *btd_profile_sort_list(GSList *list, btd_profile_list_get get=
,
> > > +                                                       void *user_da=
ta);
> >
> > Id use struct queue as return if possible.
>
> device.c used GSList for the pending list, but it could be queue in
> principle

Ah ok, well then I leave it to you if you feel like it doesn't take
too much effort to convert the device.c to also use a queue that would
be great, otherwise I'm fine with GSList as well.

> >
> > > --
> > > 2.51.1
> > >
> > >
> >
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
