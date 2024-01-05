Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7322DF8F
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jan 2024 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uumb5Y7h"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ccbbb5eb77so20359731fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jan 2024 07:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704467298; x=1705072098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IOHe52kM5xf8Gq2125VMnx5+Etlfw9nOV/7D4MGUfo=;
        b=Uumb5Y7hS99FWqbbQToLssmUaGkbtk6er2vPTapjDBzpgLaqI4iwhhNlEdtFbWJGD7
         bEzhNRKpX0C9Q/hrbeoe1ic3QmzWVIAahL6HZX5AqTD3B7IqBK+U8Qly287tLqBZBfhv
         wwJJztFV6ASHt09HVtays0xflRpAqHHRAatXKXUqqMjWtqCLr5IGBk+VP64a48HYQX4J
         bTF6i4W0YV9sus6tyu2OTZn2yZteZg4+DEhWjY7lrlOaWREyGncmEzIaVOXdVL1LkRNk
         +KCruh/uE3IVajQJXnlbg9z4d7RunOz3mK02fM2xTTkK2+j8ihFKJn0qRZPhWKpn57Yo
         0cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704467298; x=1705072098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IOHe52kM5xf8Gq2125VMnx5+Etlfw9nOV/7D4MGUfo=;
        b=NhjopOmPJLDvsBLjmwW5PaQLqR2DuM0UYZ7tcxqiCP8yolToSxQclWQxcYNck269dQ
         XFt4zCmP7zd7/RW538uUA+aVRjCpFA0sZ5wBxN5TCjByxRXHiw0IcwpKkzuETMBBUloB
         Xj9bMe//MeMqd94EgvPWWtVxXXkGywaW/WKNPweODrLs0Ta6rfJH0PkpFSgUxcoMQApx
         wwjODCgQz6sAWmTO4418vsA7Ogcuv9uELWybpE3502RRkmcGS7pCmSuI+MjLKk8aBZB9
         5QZRQN92wgIYkqqbr3Q3SaPCW6+tBRX5hx65KxCrcRr8YgiXaCasUPXduZiTzuXVAtUY
         rNRg==
X-Gm-Message-State: AOJu0YzYcg5ZUju9u2jC2k0ebBKFiL4WX3Ab0fzww/TKUOkHKEjX58Bj
	/Vj6npDrmsu44WtzQtqyehMbFL/hsvMAiKEkfu4=
X-Google-Smtp-Source: AGHT+IHNaOwkBFJGIwAjQSO89VyRLe9i+HM7FhpkvJiI6WXV4q/9I6bcOa+1HGiq19qK7/eT5Y2pm7ytBcF39NTM9tE=
X-Received: by 2002:a05:651c:b2a:b0:2cc:95a7:68f9 with SMTP id
 b42-20020a05651c0b2a00b002cc95a768f9mr1493075ljr.13.1704467297636; Fri, 05
 Jan 2024 07:08:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105123404.151860-1-frederic.danis@collabora.com>
In-Reply-To: <20240105123404.151860-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 5 Jan 2024 10:08:04 -0500
Message-ID: <CABBYNZ+xUJ=XJOzOtq0inJmKA_MwxGaYokWqpDBjgBcmNc5koA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3] shared/gatt-db: Fix munmap_chunk invalid pointer
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Fri, Jan 5, 2024 at 7:34=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> PTS test GATT/CL/GAD/BV-03-C published a service starting at handle 0xfff=
d
> and ending at 0xffff.
> This resets the next_handle to 0 in gatt_db_insert_service() instead of
> setting it to 0x10000. Other services are added later.
> This could end-up by a crash in db_hash_update() if not enough space has
> been allocated for hash.iov and some entries are overwritten.
> ---
> v1 -> v2: Replace next_handle by last_handle
>           Check empty db using gatt_db_isempty(db) instead of
>             next_handle =3D=3D 0
>           Add robustness unit test to check that gatt_db_get_hash()
>             doesn't crash
> v2 -> v3: Fix line length checkpatch errors
> ---
>  src/shared/gatt-db.c | 19 ++++++-----
>  unit/test-gatt.c     | 80 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 89 insertions(+), 10 deletions(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 676f963ec..9559583d1 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -58,7 +58,7 @@ struct gatt_db {
>         struct bt_crypto *crypto;
>         uint8_t hash[16];
>         unsigned int hash_id;
> -       uint16_t next_handle;
> +       uint16_t last_handle;

Don't we have the last_handle already by doing queue_peek_tail, etc
and look into the database? Perhaps we want to avoid this sort of
lookup though, but I'd leave a comment in that case.

>         struct queue *services;
>
>         struct queue *notify_list;
> @@ -255,7 +255,7 @@ struct gatt_db *gatt_db_new(void)
>         db->crypto =3D bt_crypto_new();
>         db->services =3D queue_new();
>         db->notify_list =3D queue_new();
> -       db->next_handle =3D 0x0001;
> +       db->last_handle =3D 0x0000;
>
>         return gatt_db_ref(db);
>  }
> @@ -356,14 +356,15 @@ static bool db_hash_update(void *user_data)
>
>         db->hash_id =3D 0;
>
> -       if (!db->next_handle)
> +       if (gatt_db_isempty(db))
>                 return false;
>
> -       hash.iov =3D new0(struct iovec, db->next_handle);
> +       hash.iov =3D new0(struct iovec, db->last_handle + 1);
>         hash.i =3D 0;
>
>         gatt_db_foreach_service(db, NULL, service_gen_hash_m, &hash);
> -       bt_crypto_gatt_hash(db->crypto, hash.iov, db->next_handle, db->ha=
sh);
> +       bt_crypto_gatt_hash(db->crypto, hash.iov, db->last_handle + 1,
> +                               db->hash);
>
>         for (i =3D 0; i < hash.i; i++)
>                 free(hash.iov[i].iov_base);
> @@ -624,7 +625,7 @@ bool gatt_db_clear_range(struct gatt_db *db, uint16_t=
 start_handle,
>
>  done:
>         if (gatt_db_isempty(db))
> -               db->next_handle =3D 0;
> +               db->last_handle =3D 0;
>
>         return true;
>  }
> @@ -700,7 +701,7 @@ struct gatt_db_attribute *gatt_db_insert_service(stru=
ct gatt_db *db,
>                 return NULL;
>
>         if (!handle)
> -               handle =3D db->next_handle;
> +               handle =3D db->last_handle + 1;
>
>         if (num_handles < 1 || (handle + num_handles - 1) > UINT16_MAX)
>                 return NULL;
> @@ -747,8 +748,8 @@ struct gatt_db_attribute *gatt_db_insert_service(stru=
ct gatt_db *db,
>         service->attributes[0]->handle =3D handle;
>         service->num_handles =3D num_handles;
>
> -       /* Fast-forward next_handle if the new service was added to the e=
nd */
> -       db->next_handle =3D MAX(handle + num_handles, db->next_handle);
> +       /* Fast-forward last_handle if the new service was added to the e=
nd */
> +       db->last_handle =3D MAX(handle + num_handles - 1, db->last_handle=
);
>
>         return service->attributes[0];

Let's split the new test case into its own patch.

> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index f92d860c4..9457d9079 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -1908,6 +1908,67 @@ static struct gatt_db *make_test_spec_large_db_1(v=
oid)
>         return make_db(specs);
>  }
>
> +/*
> + * Defined Test database 3:
> + * Tiny database fits into a single minimum sized-pdu with services unor=
dered.
> + * Satisfies requirements:
> + * 5. At least one characteristic at the MAX handle
> + * 7. at least one service uuid with multiple instances
> + * 8. Some simple services, some with included services
> + * 9. an instance where handle of included service comes before the incl=
uding
> + * service
> + * 11. Simple characteristics (no desc) and complex characteristics
> + *     (multiple descriptors)
> + * 12. Instances of complex chars with 16-bit and 128-bit uuids
> + *     (although not in scrambled order)
> + */
> +
> +static struct gatt_db *make_test_spec_unordered_db(void)
> +{
> +       const struct att_handle_spec specs[] =3D {
> +               SECONDARY_SERVICE(0x0003, DEVICE_INFORMATION_UUID, 16),
> +               CHARACTERISTIC_STR(GATT_CHARAC_MANUFACTURER_NAME_STRING,
> +                                               BT_ATT_PERM_READ |
> +                                               BT_ATT_PERM_WRITE,
> +                                               BT_GATT_CHRC_PROP_READ |
> +                                               BT_GATT_CHRC_PROP_NOTIFY =
|
> +                                               BT_GATT_CHRC_PROP_INDICAT=
E |
> +                                               BT_GATT_CHRC_PROP_EXT_PRO=
P,
> +                                               "BlueZ"),
> +               DESCRIPTOR(GATT_CLIENT_CHARAC_CFG_UUID, BT_ATT_PERM_READ =
|
> +                                               BT_ATT_PERM_WRITE, 0x00, =
0x00),
> +               DESCRIPTOR_STR(GATT_CHARAC_USER_DESC_UUID, BT_ATT_PERM_RE=
AD,
> +                                                       "Manufacturer Nam=
e"),
> +               DESCRIPTOR(GATT_CHARAC_EXT_PROPER_UUID, BT_ATT_PERM_READ,=
 0x01,
> +                                                                       0=
x00),
> +               CHARACTERISTIC_STR(GATT_CHARAC_SOFTWARE_REVISION_STRING,
> +                                               BT_ATT_PERM_READ,
> +                                               BT_GATT_CHRC_PROP_READ |
> +                                               BT_GATT_CHRC_PROP_INDICAT=
E,
> +                                               "5.59"),
> +               DESCRIPTOR(GATT_CLIENT_CHARAC_CFG_UUID, BT_ATT_PERM_READ
> +                       | BT_ATT_PERM_WRITE, 0x00, 0x00),
> +
> +               PRIMARY_SERVICE(0xFFFF - 9 + 1, GAP_UUID, 9),
> +               INCLUDE(0x0003),
> +               CHARACTERISTIC_STR(GATT_CHARAC_DEVICE_NAME, BT_ATT_PERM_R=
EAD,
> +                                                       BT_GATT_CHRC_PROP=
_READ,
> +                                                       "BlueZ Unit Teste=
r"),
> +               CHARACTERISTIC(0000B009-0000-0000-0123-456789abcdef,
> +                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE,
> +                                       BT_GATT_CHRC_PROP_READ |
> +                                       BT_GATT_CHRC_PROP_EXT_PROP, 0x09)=
,
> +               DESCRIPTOR(GATT_CHARAC_EXT_PROPER_UUID, BT_ATT_PERM_READ,=
 0x01,
> +                                                                       0=
x00),
> +               CHARACTERISTIC(GATT_CHARAC_APPEARANCE, BT_ATT_PERM_READ,
> +                                       BT_GATT_CHRC_PROP_READ, 0x00, 0x0=
0),
> +               PRIMARY_SERVICE(0x0001, DEVICE_INFORMATION_UUID, 1),
> +               { }
> +       };
> +
> +       return make_db(specs);
> +}
> +
>  static void test_client(gconstpointer data)
>  {
>         create_context(512, data);
> @@ -2345,10 +2406,22 @@ static const struct test_step test_indication_ser=
ver_1 =3D {
>         .length =3D 0x03,
>  };
>
> +static void test_hash_db(gconstpointer data)
> +{
> +       struct context *context =3D create_context(512, data);
> +
> +       /* test that gatt_db_get_hash is able to manage unordered db and
> +        * doesn't crash
> +        */
> +       gatt_db_get_hash(context->server_db);
> +
> +       context_quit(context);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         struct gatt_db *service_db_1, *service_db_2, *service_db_3;
> -       struct gatt_db *ts_small_db, *ts_large_db_1;
> +       struct gatt_db *ts_small_db, *ts_large_db_1, *ts_unordered_db;
>
>         tester_init(&argc, &argv);
>
> @@ -2357,6 +2430,7 @@ int main(int argc, char *argv[])
>         service_db_3 =3D make_service_data_3_db();
>         ts_small_db =3D make_test_spec_small_db();
>         ts_large_db_1 =3D make_test_spec_large_db_1();
> +       ts_unordered_db =3D make_test_spec_unordered_db();

Afaik the db cannot be unordered, handles always must be in ascending
order, what can happen is to have gaps in between, so I'd rename this
to be something like ts_tail_db or something like that. Is there a
specific test case in the test spec that does require this db though,
looks like you are just introducing a custom one, which is valid, but
I also want  to make use of this db on the standard tests as well if
that is how they are intended.

>
>         /*
>          * Server Configuration
> @@ -4487,5 +4561,9 @@ int main(int argc, char *argv[])
>                         raw_pdu(0xff, 0x00),
>                         raw_pdu());
>
> +       define_test_server("/robustness/hash-db",
> +                       test_hash_db, ts_unordered_db, NULL,
> +                       {});
> +
>         return tester_run();
>  }
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
