Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00C421CC4F
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610389; cv=pass; b=uR/i8DTRhalF783rmLSALuPTeZq+lcnKiL4zaOFy4BiuLJnaDGCt7zOQ0e/nGj3Av0bPIK1E9dhZiAHcXMpjsMAXeGSqIbI/xao3C5BKXun1Ca7JHKO/6n0fy+C8NjnRrrYXZiE5xErJPSQYJZD715AHN7lLTyCVKto7DMsYIaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610389; c=relaxed/simple;
	bh=MYxFwJjEoTCYW+73z9xa3DyARVmiAWsFOK/JQiJ+5qo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=adF1G0tx+xvvaEtUdFmPwOW2c8hi+cAgPAZKannGFfQ43W76oqRcMD0EjyqRMKumzyck+S9VFC29LB/7TZj5VfKF64r3DMn8wFOTpzb+aW3FJxB8qzlLHIN17IJIZToRsycVxmU9r1izmoJuSSQt3r+vYBzy9ShYKtblps5iu/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=de0OMp/B; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="de0OMp/B"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4dKrZt1Vmbz49Pxn;
	Mon, 01 Dec 2025 19:32:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1764610374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ne4mNOcoxZewz2+Ae5isVYwQtvJdyq5Dr9ce5dx4AJ8=;
	b=de0OMp/BqxTkFsqhkRsQL13h4kzxFyJWzB4jEm02lQ8pLssvRYAy4NWAKzMvEXKgg9i/uE
	luV6QiaQ/KuXFrM+Q627HFfM82FgZOxOPZNfHbn0mqTBrOvsIdbLsaoMbrC7dHWiOYIRbq
	8/5PQZFLMSVyyATXFVcCXLlO53IZRup3XuRA5eBv6cLQLDVHuFMVnqazUi1ybw8VE6DWmD
	RaZbM1+v1aprYnLxvTprtkrVbC4JPp682sa+ws1QpHyXImcR9tYG/3uktyP8+pynAAuML3
	60Wcr3n4zIXjbMUkZLXkvbK+tT9id5CT9l1n14XCf5N5Og762nFDQQ8KGRH+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1764610374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ne4mNOcoxZewz2+Ae5isVYwQtvJdyq5Dr9ce5dx4AJ8=;
	b=D4/6LCE7iP1Yk1PE7ddSXGazCH70becnRvQPTORc8vs0h/VPrIefghvG4GUqWhIu5YHMOd
	qMlhVvvJrPVhVrUQfCU9Vow2q6AhWQ8plmO2i+foF01/qi76bksBEJl99quVb5+liWiFeJ
	+uEitgQ3yKYN4pYEDB+A8brwDgVAU3Npjpw56OupmU9VJ6n0YA1xFwoeGGOnZFxWVwUuhb
	BD9bvyd8HNm2rYjvA5Rf6oCcrouokxH9w8xvEcGa9IlfXRRC9yHuvNUAOg9zL+mcH6Z6Q8
	ayr++gPKtssCySQMTqLBWc47AnoCittAxMPJTsliFibfko0C7+jWCg5+z714QQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1764610374;
	b=a27xsUBQbOkZNMr18+Cw6Gw+V59FBu9ewh5WT4I7Afcb0/1YmG+4HRcQKdbldwSGhP53s8
	p4b53pngTm0GUrG1PgoCXU3CptoHeiRsCLx8BDOD5lNZeLjhQ5ehil6plDn1kH9DvVtmAy
	Jok5TEMdbeYtH6doiUHme56SrUnGjZWHuwmK0d2QaDdwA4npX7P7nzOfAx2X3H7m4OTJex
	OgZsd6SZiWeW17pF8i43DmAuSzqC+IBDNimbfDJOb1XYMwfwpTc5dBCYWwWMROLIDeiUwF
	nB/ButqbkDFWeuS10zoaP37LsHdfroHHIghPCe8pPicfIOYaTK9EgyO9/MU4Yg==
Message-ID: <52d53a65eab6603b196af8f95e61c52ab1f34f1d.camel@iki.fi>
Subject: Re: [PATCH BlueZ v2 6/9] profile: add after_uuids for ordering
 profile startup
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 01 Dec 2025 19:32:53 +0200
In-Reply-To: <CABBYNZJievzOzAMGRoCVbXUKr6pwscDBMz2+A9N9uXs7qgrWVg@mail.gmail.com>
References: <cover.1764360140.git.pav@iki.fi>
	 <0e68b96a2adb2f49be8ee961496d3033f32139fe.1764360140.git.pav@iki.fi>
	 <CABBYNZJievzOzAMGRoCVbXUKr6pwscDBMz2+A9N9uXs7qgrWVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ma, 2025-12-01 kello 12:00 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Fri, Nov 28, 2025 at 3:03=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Add btd_profile::after_uuids to specify the profile connect/accept orde=
r
> > for autoconnect.  This is a "soft" dependency so it doesn't fail if the
> > other services fail to start nor try to start them if they otherwise
> > wouldn't.
> >=20
> > Add btd_profile_sort_list() for sorting a list according to profile
> > ordering, taking account priority and after_uuids.
> >=20
> > Add btd_profile_find_remote_uuid() lookup utility, needed when using
> > btd_profile_sort_list() with uuid lists.
> > ---
> >=20
> > Notes:
> >     v2:
> >     - new commit
> >=20
> >  src/profile.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  src/profile.h | 13 ++++++++
> >  2 files changed, 102 insertions(+)
> >=20
> > diff --git a/src/profile.c b/src/profile.c
> > index 66405d7e4..eaf368a4a 100644
> > --- a/src/profile.c
> > +++ b/src/profile.c
> > @@ -773,6 +773,30 @@ static struct btd_profile *btd_profile_find_uuid(c=
onst char *uuid)
> >         return NULL;
> >  }
> >=20
> > +struct btd_profile *btd_profile_find_remote_uuid(const char *uuid)
> > +{
> > +       GSList *l, *next;
> > +
> > +       for (l =3D profiles; l !=3D NULL; l =3D next) {
> > +               struct btd_profile *p =3D l->data;
> > +
> > +               if (!g_strcmp0(p->remote_uuid, uuid))
> > +                       return p;
> > +               next =3D g_slist_next(l);
> > +       }
> > +
> > +       for (l =3D ext_profiles; l !=3D NULL; l =3D next) {
> > +               struct ext_profile *ext =3D l->data;
> > +               struct btd_profile *p =3D &ext->p;
> > +
> > +               if (!g_strcmp0(p->remote_uuid, uuid))
> > +                       return p;
> > +               next =3D g_slist_next(l);
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> >  int btd_profile_register(struct btd_profile *profile)
> >  {
> >         if (profile->experimental && !(g_dbus_get_flags() &
> > @@ -2650,3 +2674,68 @@ void btd_profile_cleanup(void)
> >         g_dbus_unregister_interface(btd_get_dbus_connection(),
> >                                 "/org/bluez", "org.bluez.ProfileManager=
1");
> >  }
> > +
> > +/* Stable sort of a list according to profile priority & after_uuids *=
/
> > +GSList *btd_profile_sort_list(GSList *list, btd_profile_list_get get,
> > +                                                       void *user_data=
)
> > +{
> > +       GSList *result =3D NULL;
> > +       GSList *remain =3D list;
> > +       GHashTable *uuids;
> > +       GSList *entry;
> > +       const struct btd_profile *p;
> > +
> > +       uuids =3D g_hash_table_new_full(g_str_hash, g_str_equal, g_free=
, NULL);
> > +
> > +       /* Unsatisfied remote uuids */
> > +       for (entry =3D remain; entry; entry =3D g_slist_next(entry)) {
> > +               p =3D get(entry->data, user_data);
> > +               if (p->remote_uuid)
> > +                       g_hash_table_add(uuids, g_strdup(p->remote_uuid=
));
> > +       }
> > +
> > +       /* Sort */
> > +       while (remain) {
> > +               GSList *first_entry =3D remain;
> > +               int max_priority =3D INT_MIN;
> > +
> > +               /* Find max priority */
> > +               for (entry =3D remain; entry; entry =3D g_slist_next(en=
try)) {
> > +                       p =3D get(entry->data, user_data);
> > +                       if (p->priority > max_priority) {
> > +                               first_entry =3D entry;
> > +                               max_priority =3D p->priority;
> > +                       }
> > +               }
> > +
> > +               /* Find max priority entry with no unsatisfied dependen=
cies */
> > +               for (entry =3D remain; entry; entry =3D g_slist_next(en=
try)) {
> > +                       const char **uuid;
> > +
> > +                       p =3D get(entry->data, user_data);
> > +                       if (p->priority < max_priority)
> > +                               continue;
> > +
> > +                       for (uuid =3D p->after_uuids; uuid && *uuid; uu=
id++)
> > +                               if (g_hash_table_contains(uuids, *uuid)=
)
> > +                                       break;
> > +                       if (!(uuid && *uuid))
> > +                               break;
> > +               }
> > +
> > +               /* If cyclic dependencies: break preserving priority & =
order */
> > +               if (!entry)
> > +                       entry =3D first_entry;
> > +
> > +               p =3D get(entry->data, user_data);
> > +               if (p->remote_uuid)
> > +                       g_hash_table_remove(uuids, p->remote_uuid);
> > +
> > +               remain =3D g_slist_remove_link(remain, entry);
> > +               result =3D g_slist_concat(result, entry);
> > +       }
> > +
> > +       g_hash_table_destroy(uuids);
> > +
> > +       return result;
> > +}
>=20
> We might need to build some unit testing for this sort of function,
> for checking if we handle cyclic/circular dependencies, if we don't
> end up with duplicated entries in the list as well, not sure how much
> testing you have done in this respect since we only really have one
> plugin using after_uuids.

I think the function should be correct, but yes unit tests would be
good to have here.

> > diff --git a/src/profile.h b/src/profile.h
> > index 424ce55ad..a8c2443e3 100644
> > --- a/src/profile.h
> > +++ b/src/profile.h
> > @@ -38,6 +38,12 @@ struct btd_profile {
> >          */
> >         bool testing;
> >=20
> > +       /* Indicates the profile should be ordered after profiles provi=
ding
> > +        * these remote uuids when connecting. A NULL-terminated array =
of
> > +        * strings.
> > +        */
> > +       const char **after_uuids;
>=20
> Hmm, I wonder if this shouldn't be a struct with uuids list and
> function to be called when connected? Perhaps having a macro that
> initializes the list would be a good idea as well.

So

struct btd_profile_uuid_cb {
	void (*func)(struct btd_service *service);
	unsigned int count;
	const char *remote_uuids[];
};

struct btd_profile {
	...

	const struct btd_profile_uuid_cb *after;
};

or maybe you meant something different like separate callbacks for each
UUID?

>=20
> > +
> >         int (*device_probe) (struct btd_service *service);
> >         void (*device_remove) (struct btd_service *service);
> >=20
> > @@ -76,3 +82,10 @@ bool btd_profile_remove_custom_prop(const char *uuid=
, const char *name);
> >=20
> >  void btd_profile_init(void);
> >  void btd_profile_cleanup(void);
> > +
> > +struct btd_profile *btd_profile_find_remote_uuid(const char *uuid);
> > +
> > +typedef const struct btd_profile *(*btd_profile_list_get)(void *item,
> > +                                                       void *user_data=
);
> > +GSList *btd_profile_sort_list(GSList *list, btd_profile_list_get get,
> > +                                                       void *user_data=
);
>=20
> Id use struct queue as return if possible.

device.c used GSList for the pending list, but it could be queue in
principle

>=20
> > --
> > 2.51.1
> >=20
> >=20
>=20

--=20
Pauli Virtanen
