Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D52233342A
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608470; cv=none; b=G6iGKZ9tyUtybwWJU0JW1diSMXroEKBdgiNpXCx8NQbBK1J37ZAp1DI03Lgfh+DsFX0SAiGvqgENPMoAqFqhyHajvKscjJXoL951CM7dtpXefGndcqGfnFKbc0Ce96/Ci8a6Hh1d413Pt0DCx7+V2zNzT/yOcnpIWOhQW4TNuX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608470; c=relaxed/simple;
	bh=gjfNB7F38JvBSQ0BBm3olBglEwo19w4tNGGuEEbNMUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tmu9A438AJEbzLPy1psHdRNmvWV1jUqvYJsHNV1utuVpkqiXOILZwV5fpTehh8TMHM8LDb02ikneBadOJS8VGnT4y6soo6sxOvg7/fcvLRySVs06522cItKJMHkMJdiEkMFnGXc+RqJq1grQlrP2HBdLlrFWZx1ktLtLyDf0QKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeNeaKY2; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeNeaKY2"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37bac34346dso31212771fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Dec 2025 09:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764608466; x=1765213266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9Kp25JDz6OBGS5ayYEQKOwOXtpOXcJVL5rXgNnfnVY=;
        b=AeNeaKY2ea/3kNw8KwqN8N84Y22IIrb3MtyY5jmqzIguZfbymWHQDWMLat+eMVXEwy
         eoppUYcQgoKEPr9PRXEZC4cdIR+TgPRCMW2ghfFuM0YC30pgZ1IO9qBpZlWAULiqKsd7
         mIP1oedrML4R5nEdyd4y0OtHZJOi4jDPRxLQ2WgbNqPK1PjkwaUSfsGSwsndKpYfAgXS
         33d64T8ET2kDpJmqvZW1McyU1CsAgrPWp0OrFOt6JjKQDo2tj0Ky48Nt2jZAXA22FI02
         DvtReYgYxnrgQ0yrj6JJkImkBtSVI/NXd2vcj1ssciKlivK1s3IiqSRkhzxxJtwSj5yb
         zEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764608466; x=1765213266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g9Kp25JDz6OBGS5ayYEQKOwOXtpOXcJVL5rXgNnfnVY=;
        b=qtQwn0btusL5gF/B/Wk5IpsN44cK4A83AALivynGGzEgGhTfF1oOpCqBsw0FxfFWg/
         Zf4h+WcDJgePmb27AxTB6uEqXrSHpbmJN1LqGZboiTot3eGDMgPN1zw2l/DzWdE3YOrf
         Y68LQXeZBOi0W8i0PBlxb8A8X7Cdq5HHQrqgWtl3IwLBHzvaXZD/zS4RX1M88JB0v5rX
         5LTYQfXV+WssT2jO0zLtXrRNwsHxKFMv3bwcdxNDVCJVyFOch5cYwijvEsV5oyVtz42z
         VXW3SgJc/j/0hsQMM62F5hpuMgBt1nMjZ7tPEczRlfGGkkMfWnxJRShopPiKPUXjqQWY
         9e8A==
X-Gm-Message-State: AOJu0YyS1bWJgR/ECuQf0wqU6ZVEylzLL4abzUylKbatzBNfzq8MxOq2
	50STZ6JORhApm99yQ9OEIGvrHo6bXZPAgwKUAMEQjCI1BEYexB5Dnd1K9zLyHOIUOPpqHS4V0vu
	77J9GamSrNY0jI3ZF1UdmtC4qryhmjXkhGQ==
X-Gm-Gg: ASbGnctJYF6RwF5onLP8+OHSpKuVuc7npHD01BXx5EtGVaMSNmp9WngPgpaRX7M7y3Z
	VA2Vz3ROpoSHPSb5ld/4CVi3J8OlcA3Otun4FsYSDDCwsB33B2ftVxOQVkWmj4O4xbgj8loNN9v
	JSDnGT51mSunFHKY/gzRJ3H3x/IZM8XdjEnzSrfyppLEkNm3oYbuLUr9pd4CKBoSINMKlqnXGZ5
	Ng+V0pycG7u0moiuTShhuwQt6Zje5jOBFjeGaObS0UmWVU3IFGZsL8bpvr9r+5Eulu5Zg==
X-Google-Smtp-Source: AGHT+IEAIvnrMqDoYa0qIrwlFLZA4DFKDAp901ayDu13JPOmGlR7BnwWm/u9YToOpwlry+kwlYUV3GT37P8nTQgpT/A=
X-Received: by 2002:a05:651c:e18:b0:375:ebfa:2986 with SMTP id
 38308e7fff4ca-37cd92c191fmr77792371fa.34.1764608464585; Mon, 01 Dec 2025
 09:01:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764360140.git.pav@iki.fi> <0e68b96a2adb2f49be8ee961496d3033f32139fe.1764360140.git.pav@iki.fi>
In-Reply-To: <0e68b96a2adb2f49be8ee961496d3033f32139fe.1764360140.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Dec 2025 12:00:52 -0500
X-Gm-Features: AWmQ_blYg-MeqTj_lD9RYyQFzlTl0Wf04NPxZngBazJSHhuDwpoovxKJFW7wf-E
Message-ID: <CABBYNZJievzOzAMGRoCVbXUKr6pwscDBMz2+A9N9uXs7qgrWVg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 6/9] profile: add after_uuids for ordering
 profile startup
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Nov 28, 2025 at 3:03=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add btd_profile::after_uuids to specify the profile connect/accept order
> for autoconnect.  This is a "soft" dependency so it doesn't fail if the
> other services fail to start nor try to start them if they otherwise
> wouldn't.
>
> Add btd_profile_sort_list() for sorting a list according to profile
> ordering, taking account priority and after_uuids.
>
> Add btd_profile_find_remote_uuid() lookup utility, needed when using
> btd_profile_sort_list() with uuid lists.
> ---
>
> Notes:
>     v2:
>     - new commit
>
>  src/profile.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/profile.h | 13 ++++++++
>  2 files changed, 102 insertions(+)
>
> diff --git a/src/profile.c b/src/profile.c
> index 66405d7e4..eaf368a4a 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -773,6 +773,30 @@ static struct btd_profile *btd_profile_find_uuid(con=
st char *uuid)
>         return NULL;
>  }
>
> +struct btd_profile *btd_profile_find_remote_uuid(const char *uuid)
> +{
> +       GSList *l, *next;
> +
> +       for (l =3D profiles; l !=3D NULL; l =3D next) {
> +               struct btd_profile *p =3D l->data;
> +
> +               if (!g_strcmp0(p->remote_uuid, uuid))
> +                       return p;
> +               next =3D g_slist_next(l);
> +       }
> +
> +       for (l =3D ext_profiles; l !=3D NULL; l =3D next) {
> +               struct ext_profile *ext =3D l->data;
> +               struct btd_profile *p =3D &ext->p;
> +
> +               if (!g_strcmp0(p->remote_uuid, uuid))
> +                       return p;
> +               next =3D g_slist_next(l);
> +       }
> +
> +       return NULL;
> +}
> +
>  int btd_profile_register(struct btd_profile *profile)
>  {
>         if (profile->experimental && !(g_dbus_get_flags() &
> @@ -2650,3 +2674,68 @@ void btd_profile_cleanup(void)
>         g_dbus_unregister_interface(btd_get_dbus_connection(),
>                                 "/org/bluez", "org.bluez.ProfileManager1"=
);
>  }
> +
> +/* Stable sort of a list according to profile priority & after_uuids */
> +GSList *btd_profile_sort_list(GSList *list, btd_profile_list_get get,
> +                                                       void *user_data)
> +{
> +       GSList *result =3D NULL;
> +       GSList *remain =3D list;
> +       GHashTable *uuids;
> +       GSList *entry;
> +       const struct btd_profile *p;
> +
> +       uuids =3D g_hash_table_new_full(g_str_hash, g_str_equal, g_free, =
NULL);
> +
> +       /* Unsatisfied remote uuids */
> +       for (entry =3D remain; entry; entry =3D g_slist_next(entry)) {
> +               p =3D get(entry->data, user_data);
> +               if (p->remote_uuid)
> +                       g_hash_table_add(uuids, g_strdup(p->remote_uuid))=
;
> +       }
> +
> +       /* Sort */
> +       while (remain) {
> +               GSList *first_entry =3D remain;
> +               int max_priority =3D INT_MIN;
> +
> +               /* Find max priority */
> +               for (entry =3D remain; entry; entry =3D g_slist_next(entr=
y)) {
> +                       p =3D get(entry->data, user_data);
> +                       if (p->priority > max_priority) {
> +                               first_entry =3D entry;
> +                               max_priority =3D p->priority;
> +                       }
> +               }
> +
> +               /* Find max priority entry with no unsatisfied dependenci=
es */
> +               for (entry =3D remain; entry; entry =3D g_slist_next(entr=
y)) {
> +                       const char **uuid;
> +
> +                       p =3D get(entry->data, user_data);
> +                       if (p->priority < max_priority)
> +                               continue;
> +
> +                       for (uuid =3D p->after_uuids; uuid && *uuid; uuid=
++)
> +                               if (g_hash_table_contains(uuids, *uuid))
> +                                       break;
> +                       if (!(uuid && *uuid))
> +                               break;
> +               }
> +
> +               /* If cyclic dependencies: break preserving priority & or=
der */
> +               if (!entry)
> +                       entry =3D first_entry;
> +
> +               p =3D get(entry->data, user_data);
> +               if (p->remote_uuid)
> +                       g_hash_table_remove(uuids, p->remote_uuid);
> +
> +               remain =3D g_slist_remove_link(remain, entry);
> +               result =3D g_slist_concat(result, entry);
> +       }
> +
> +       g_hash_table_destroy(uuids);
> +
> +       return result;
> +}

We might need to build some unit testing for this sort of function,
for checking if we handle cyclic/circular dependencies, if we don't
end up with duplicated entries in the list as well, not sure how much
testing you have done in this respect since we only really have one
plugin using after_uuids.

> diff --git a/src/profile.h b/src/profile.h
> index 424ce55ad..a8c2443e3 100644
> --- a/src/profile.h
> +++ b/src/profile.h
> @@ -38,6 +38,12 @@ struct btd_profile {
>          */
>         bool testing;
>
> +       /* Indicates the profile should be ordered after profiles providi=
ng
> +        * these remote uuids when connecting. A NULL-terminated array of
> +        * strings.
> +        */
> +       const char **after_uuids;

Hmm, I wonder if this shouldn't be a struct with uuids list and
function to be called when connected? Perhaps having a macro that
initializes the list would be a good idea as well.

> +
>         int (*device_probe) (struct btd_service *service);
>         void (*device_remove) (struct btd_service *service);
>
> @@ -76,3 +82,10 @@ bool btd_profile_remove_custom_prop(const char *uuid, =
const char *name);
>
>  void btd_profile_init(void);
>  void btd_profile_cleanup(void);
> +
> +struct btd_profile *btd_profile_find_remote_uuid(const char *uuid);
> +
> +typedef const struct btd_profile *(*btd_profile_list_get)(void *item,
> +                                                       void *user_data);
> +GSList *btd_profile_sort_list(GSList *list, btd_profile_list_get get,
> +                                                       void *user_data);

Id use struct queue as return if possible.

> --
> 2.51.1
>
>


--=20
Luiz Augusto von Dentz
