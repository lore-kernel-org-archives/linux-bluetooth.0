Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CC57317F
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154574; cv=none; b=tY1XduVLrqf2ACpOOKRnYOxOc+dzDUidkirKslcDaP8jEZaiRHZt7z4yTY761hBTME9FgReGDdvuQT7h3ooHqA5x/NndSFZMy+fqmj1IpatDQBvAlDmrO3PfF+WY4iMeR0M+5IctQvLX2fUW0GQ3WX0Oi4lCYAWgviKQKS7HMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154574; c=relaxed/simple;
	bh=ugHgPttTCbyTUwVXBA5Y1NDY7KU9Jp7ihYZOs0qaA2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYksyRCqR6Frnt3NcfAPyHQdHXfUMM7dUpbm2aBv90tOJ71QFmAOQWn/alEnSt1BqwZZ6IIHdtHUFZZlmHyNQqSrsAe6bn7RnjdnpkzFRCgnr04b3E5OpQYL2ZiGJzP7NzOtZ0cjdLRkD9hfbiS8cH5ZTS32cA/YD3xgJ6x8Ihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9XbWGkd; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9XbWGkd"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d8129797fcso46926681fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712154571; x=1712759371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dx4ETmoIKjpMhQ/SwS+tH/g6ZdoqBA9XtdCA/EZL0c=;
        b=Y9XbWGkdfXXz2c+6wk9+PVzxY3muNiJxk/XyBuwGPfzeoq/Ondo9nTccYbS6qZmlBJ
         fOi++q9f55vzTlbynUIDyXDcwMh8D8B2Elp4B2NTdJ6dwuQO8bjKN8jf+aj+Alr83V4d
         WBTPzi3jqavOSrOhHXuHH0WAT55u3ge4W/LevEHiBESz8mTqe6XdMzbRGuSM62UrIqGm
         WRCnIzIbDTwpP0MwWdZ5ShCzRFbC18v3y0z46QzrMS1LDFxk2inF9tf1J0+rDsRrADAA
         D4GsSHrYu78JPHK7RdJ6lY6JAmw5slpG45uTlf5bSLXuCUeSW+klQS8Nqm9F00IyzENF
         Cf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712154571; x=1712759371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dx4ETmoIKjpMhQ/SwS+tH/g6ZdoqBA9XtdCA/EZL0c=;
        b=Zp49ZNRpYvz2qOOpnSKd3NT9AdfySjK5R5rmtTDim0Zvd0bKI9W0Zt4lybU1mklw/8
         uJh+K5iXXLqapWtetIVymrQeGJ/76d+UZ84ATql49AahrfIJgcQ+hMgD+ap64FaWfMHD
         tNOq25Xsae7wepd4v2LGgpfhpTkNorO4XBZIhoWjCbFNzHDx2J3ia1+uVyQGKvEpRrEW
         reecD+umdtGZNKomYkdy4JXd9IVmWj4/i91MrqtCl/B+VwkQv40jVsGqvgNB5Q4A/C1n
         BDE+MY54q6W5msPSg3+fA/Mmx4ZkNhSNxl4clxufSZx18Ut/M68gPP8jpKdbL9gKT45H
         vrkw==
X-Gm-Message-State: AOJu0YyKf1NYoxVax7MQ0i/jZXmFpsYI39ZkygF+2w21+wpnm87vzMpV
	5AqGCRKgvxL3MYMPCx4b3WHmopO+NEVazPZf8kYz193ebuy5SlGuTYHSWWilCUXTbDCYGlgMoYs
	Ty9wn6ipa7L0G/R1fPEPEL0dTV3E=
X-Google-Smtp-Source: AGHT+IEepBDSnK4o5vNMZMp5IqP0M6mw+g4i/vYIDTWqPouk5R2cEU7nxUrp6re3LqgiItpGyyeIBPJUtj2YT8zMd/0=
X-Received: by 2002:a2e:87ca:0:b0:2d6:ec7b:b69b with SMTP id
 v10-20020a2e87ca000000b002d6ec7bb69bmr9306077ljj.7.1712154570476; Wed, 03 Apr
 2024 07:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403110549.75516-1-howardchung@google.com> <20240403190511.Bluez.1.I0e799d0a6494565e232db4c86a8979cf898b1840@changeid>
In-Reply-To: <20240403190511.Bluez.1.I0e799d0a6494565e232db4c86a8979cf898b1840@changeid>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Apr 2024 10:29:17 -0400
Message-ID: <CABBYNZKr_gZrvFYLTLax--qErek=h4-xrTd=uHmZMLfR5Tzdcg@mail.gmail.com>
Subject: Re: [Bluez PATCH 1/2] shared/gatt: Rename some gatt insert functions
 to append
To: Howard Chung <howardchung@google.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Howard,

On Wed, Apr 3, 2024 at 7:06=E2=80=AFAM Howard Chung <howardchung@google.com=
> wrote:
>
> Many of the Gatt insert functions are actually append. They append an
> attribute to the end of the service attributes list.
> This simply rename these functions.

Those are 2 different operations, insert takes a handle and attempts
to insert it at the handle position while append you just look into
the next available handle.

> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> ---
>
>  monitor/att.c            |  4 ++--
>  src/gatt-database.c      |  4 ++--
>  src/settings.c           |  4 ++--
>  src/shared/gatt-client.c |  8 ++++----
>  src/shared/gatt-db.c     | 38 +++++++++++++++++++-------------------
>  src/shared/gatt-db.h     | 12 ++++++------
>  unit/test-gatt.c         |  4 ++--
>  7 files changed, 37 insertions(+), 37 deletions(-)
>
> diff --git a/monitor/att.c b/monitor/att.c
> index 3e5d7f12d..ddeb54d9e 100644
> --- a/monitor/att.c
> +++ b/monitor/att.c
> @@ -515,7 +515,7 @@ static struct gatt_db_attribute *insert_chrc(const st=
ruct l2cap_frame *frame,
>         if (!db)
>                 return NULL;
>
> -       return gatt_db_insert_characteristic(db, handle, uuid, 0, prop, N=
ULL,
> +       return gatt_db_append_characteristic(db, handle, uuid, 0, prop, N=
ULL,
>                                                         NULL, NULL);
>  }
>
> @@ -4153,7 +4153,7 @@ static struct gatt_db_attribute *insert_desc(const =
struct l2cap_frame *frame,
>         if (!db)
>                 return NULL;
>
> -       return gatt_db_insert_descriptor(db, handle, uuid, 0, NULL, NULL,=
 NULL);
> +       return gatt_db_append_descriptor(db, handle, uuid, 0, NULL, NULL,=
 NULL);
>  }
>
>  static void att_find_info_rsp_16(const struct l2cap_frame *frame)
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 7221ffc87..4c3554211 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -3178,7 +3178,7 @@ static bool database_add_desc(struct external_servi=
ce *service,
>                 return false;
>         }
>
> -       desc->attrib =3D gatt_db_service_insert_descriptor(service->attri=
b,
> +       desc->attrib =3D gatt_db_service_append_descriptor(service->attri=
b,
>                                                         handle, &uuid,
>                                                         desc->perm,
>                                                         desc_read_cb,
> @@ -3351,7 +3351,7 @@ static bool database_add_chrc(struct external_servi=
ce *service,
>                 return false;
>         }
>
> -       chrc->attrib =3D gatt_db_service_insert_characteristic(service->a=
ttrib,
> +       chrc->attrib =3D gatt_db_service_append_characteristic(service->a=
ttrib,
>                                                 handle, &uuid, chrc->perm=
,
>                                                 chrc->props, chrc_read_cb=
,
>                                                 chrc_write_cb, chrc);
> diff --git a/src/settings.c b/src/settings.c
> index 85534f2c7..025c75b62 100644
> --- a/src/settings.c
> +++ b/src/settings.c
> @@ -78,7 +78,7 @@ static int load_desc(struct gatt_db *db, char *handle, =
char *value,
>         if (!bt_uuid_cmp(&uuid, &ext_uuid) && !val)
>                 return -EIO;
>
> -       att =3D gatt_db_service_insert_descriptor(service, handle_int, &u=
uid,
> +       att =3D gatt_db_service_append_descriptor(service, handle_int, &u=
uid,
>                                                         0, NULL, NULL, NU=
LL);
>         if (!att || gatt_db_attribute_get_handle(att) !=3D handle_int)
>                 return -EIO;
> @@ -125,7 +125,7 @@ static int load_chrc(struct gatt_db *db, char *handle=
, char *value,
>                                 handle_int, value_handle,
>                                 properties, val_len ? val_str : "", uuid_=
str);
>
> -       att =3D gatt_db_service_insert_characteristic(service, value_hand=
le,
> +       att =3D gatt_db_service_append_characteristic(service, value_hand=
le,
>                                                         &uuid, 0, propert=
ies,
>                                                         NULL, NULL, NULL)=
;
>         if (!att || gatt_db_attribute_get_handle(att) !=3D value_handle)
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 6340bcd85..eddbd1778 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -638,7 +638,7 @@ static void discover_incl_cb(bool success, uint8_t at=
t_ecode,
>                         continue;
>                 }
>
> -               attr =3D gatt_db_insert_included(client->db, handle, attr=
);
> +               attr =3D gatt_db_append_included(client->db, handle, attr=
);
>                 if (!attr) {
>                         DBG(client,
>                                 "Unable to add include attribute at 0x%04=
x",
> @@ -734,7 +734,7 @@ static bool discover_descs(struct discovery_op *op, b=
ool *discovering)
>                         op->cur_svc =3D svc;
>                 }
>
> -               attr =3D gatt_db_insert_characteristic(client->db,
> +               attr =3D gatt_db_append_characteristic(client->db,
>                                                         chrc_data->value_=
handle,
>                                                         &chrc_data->uuid,=
 0,
>                                                         chrc_data->proper=
ties,
> @@ -788,7 +788,7 @@ static bool discover_descs(struct discovery_op *op, b=
ool *discovering)
>                          */
>                         bt_uuid16_create(&ccc_uuid,
>                                         GATT_CLIENT_CHARAC_CFG_UUID);
> -                       attr =3D gatt_db_insert_descriptor(client->db, de=
sc_start,
> +                       attr =3D gatt_db_append_descriptor(client->db, de=
sc_start,
>                                                         &ccc_uuid, 0, NUL=
L,
>                                                         NULL, NULL);
>                         if (attr) {
> @@ -952,7 +952,7 @@ static void discover_descs_cb(bool success, uint8_t a=
tt_ecode,
>
>                 DBG(client, "handle: 0x%04x, uuid: %s", handle, uuid_str)=
;
>
> -               attr =3D gatt_db_insert_descriptor(client->db, handle,
> +               attr =3D gatt_db_append_descriptor(client->db, handle,
>                                                         &uuid, 0, NULL, N=
ULL,
>                                                         NULL);
>                 if (!attr) {
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 9559583d1..39bba9b54 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -845,7 +845,7 @@ static uint16_t get_handle_at_index(struct gatt_db_se=
rvice *service,
>  }
>
>  static struct gatt_db_attribute *
> -service_insert_characteristic(struct gatt_db_service *service,
> +service_append_characteristic(struct gatt_db_service *service,
>                                         uint16_t handle,
>                                         const bt_uuid_t *uuid,
>                                         uint32_t permissions,
> @@ -912,7 +912,7 @@ service_insert_characteristic(struct gatt_db_service =
*service,
>  }
>
>  struct gatt_db_attribute *
> -gatt_db_insert_characteristic(struct gatt_db *db,
> +gatt_db_append_characteristic(struct gatt_db *db,
>                                         uint16_t handle,
>                                         const bt_uuid_t *uuid,
>                                         uint32_t permissions,
> @@ -927,14 +927,14 @@ gatt_db_insert_characteristic(struct gatt_db *db,
>         if (!attrib)
>                 return NULL;
>
> -       return service_insert_characteristic(attrib->service, handle, uui=
d,
> +       return service_append_characteristic(attrib->service, handle, uui=
d,
>                                                 permissions, properties,
>                                                 read_func, write_func,
>                                                 user_data);
>  }
>
>  struct gatt_db_attribute *
> -gatt_db_service_insert_characteristic(struct gatt_db_attribute *attrib,
> +gatt_db_service_append_characteristic(struct gatt_db_attribute *attrib,
>                                         uint16_t handle,
>                                         const bt_uuid_t *uuid,
>                                         uint32_t permissions,
> @@ -946,7 +946,7 @@ gatt_db_service_insert_characteristic(struct gatt_db_=
attribute *attrib,
>         if (!attrib)
>                 return NULL;
>
> -       return service_insert_characteristic(attrib->service, handle, uui=
d,
> +       return service_append_characteristic(attrib->service, handle, uui=
d,
>                                                 permissions, properties,
>                                                 read_func, write_func,
>                                                 user_data);
> @@ -964,14 +964,14 @@ gatt_db_service_add_characteristic(struct gatt_db_a=
ttribute *attrib,
>         if (!attrib)
>                 return NULL;
>
> -       return service_insert_characteristic(attrib->service, 0, uuid,
> +       return service_append_characteristic(attrib->service, 0, uuid,
>                                                 permissions, properties,
>                                                 read_func, write_func,
>                                                 user_data);
>  }
>
>  static struct gatt_db_attribute *
> -service_insert_descriptor(struct gatt_db_service *service,
> +service_append_descriptor(struct gatt_db_service *service,
>                                         uint16_t handle,
>                                         const bt_uuid_t *uuid,
>                                         uint32_t permissions,
> @@ -1003,7 +1003,7 @@ service_insert_descriptor(struct gatt_db_service *s=
ervice,
>  }
>
>  struct gatt_db_attribute *
> -gatt_db_insert_descriptor(struct gatt_db *db,
> +gatt_db_append_descriptor(struct gatt_db *db,
>                                         uint16_t handle,
>                                         const bt_uuid_t *uuid,
>                                         uint32_t permissions,
> @@ -1017,13 +1017,13 @@ gatt_db_insert_descriptor(struct gatt_db *db,
>         if (!attrib)
>                 return NULL;
>
> -       return service_insert_descriptor(attrib->service, handle, uuid,
> +       return service_append_descriptor(attrib->service, handle, uuid,
>                                         permissions, read_func, write_fun=
c,
>                                         user_data);
>  }
>
>  struct gatt_db_attribute *
> -gatt_db_service_insert_descriptor(struct gatt_db_attribute *attrib,
> +gatt_db_service_append_descriptor(struct gatt_db_attribute *attrib,
>                                         uint16_t handle,
>                                         const bt_uuid_t *uuid,
>                                         uint32_t permissions,
> @@ -1034,7 +1034,7 @@ gatt_db_service_insert_descriptor(struct gatt_db_at=
tribute *attrib,
>         if (!attrib)
>                 return NULL;
>
> -       return service_insert_descriptor(attrib->service, handle, uuid,
> +       return service_append_descriptor(attrib->service, handle, uuid,
>                                         permissions, read_func, write_fun=
c,
>                                         user_data);
>  }
> @@ -1050,7 +1050,7 @@ gatt_db_service_add_descriptor(struct gatt_db_attri=
bute *attrib,
>         if (!attrib)
>                 return NULL;
>
> -       return service_insert_descriptor(attrib->service, 0, uuid,
> +       return service_append_descriptor(attrib->service, 0, uuid,
>                                         permissions, read_func, write_fun=
c,
>                                         user_data);
>  }
> @@ -1088,7 +1088,7 @@ gatt_db_service_add_ccc(struct gatt_db_attribute *a=
ttrib, uint32_t permissions)
>         if (!value || value->notify_func)
>                 return NULL;
>
> -       ccc =3D service_insert_descriptor(attrib->service, 0, &ccc_uuid,
> +       ccc =3D service_append_descriptor(attrib->service, 0, &ccc_uuid,
>                                         permissions,
>                                         db->ccc->read_func,
>                                         db->ccc->write_func,
> @@ -1121,7 +1121,7 @@ void gatt_db_ccc_register(struct gatt_db *db, gatt_=
db_read_t read_func,
>  }
>
>  static struct gatt_db_attribute *
> -service_insert_included(struct gatt_db_service *service, uint16_t handle=
,
> +service_append_included(struct gatt_db_service *service, uint16_t handle=
,
>                                         struct gatt_db_attribute *include=
)
>  {
>         struct gatt_db_service *included;
> @@ -1186,22 +1186,22 @@ gatt_db_service_add_included(struct gatt_db_attri=
bute *attrib,
>         if (!attrib || !include)
>                 return NULL;
>
> -       return service_insert_included(attrib->service, 0, include);
> +       return service_append_included(attrib->service, 0, include);
>  }
>
>  struct gatt_db_attribute *
> -gatt_db_service_insert_included(struct gatt_db_attribute *attrib,
> +gatt_db_service_append_included(struct gatt_db_attribute *attrib,
>                                 uint16_t handle,
>                                 struct gatt_db_attribute *include)
>  {
>         if (!attrib || !handle || !include)
>                 return NULL;
>
> -       return service_insert_included(attrib->service, handle, include);
> +       return service_append_included(attrib->service, handle, include);
>  }
>
>  struct gatt_db_attribute *
> -gatt_db_insert_included(struct gatt_db *db, uint16_t handle,
> +gatt_db_append_included(struct gatt_db *db, uint16_t handle,
>                         struct gatt_db_attribute *include)
>  {
>         struct gatt_db_attribute *attrib;
> @@ -1210,7 +1210,7 @@ gatt_db_insert_included(struct gatt_db *db, uint16_=
t handle,
>         if (!attrib)
>                 return NULL;
>
> -       return service_insert_included(attrib->service, handle, include);
> +       return service_append_included(attrib->service, handle, include);
>  }
>
>  bool gatt_db_service_set_active(struct gatt_db_attribute *attrib, bool a=
ctive)
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index fb939e40d..ec0eccdfc 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -61,7 +61,7 @@ gatt_db_service_add_characteristic(struct gatt_db_attri=
bute *attrib,
>                                         gatt_db_write_t write_func,
>                                         void *user_data);
>  struct gatt_db_attribute *
> -gatt_db_service_insert_characteristic(struct gatt_db_attribute *attrib,
> +gatt_db_service_append_characteristic(struct gatt_db_attribute *attrib,
>                                         uint16_t handle,
>                                         const bt_uuid_t *uuid,
>                                         uint32_t permissions,
> @@ -71,7 +71,7 @@ gatt_db_service_insert_characteristic(struct gatt_db_at=
tribute *attrib,
>                                         void *user_data);
>
>  struct gatt_db_attribute *
> -gatt_db_insert_characteristic(struct gatt_db *db,
> +gatt_db_append_characteristic(struct gatt_db *db,
>                                         uint16_t handle,
>                                         const bt_uuid_t *uuid,
>                                         uint32_t permissions,
> @@ -81,7 +81,7 @@ gatt_db_insert_characteristic(struct gatt_db *db,
>                                         void *user_data);
>
>  struct gatt_db_attribute *
> -gatt_db_insert_descriptor(struct gatt_db *db,
> +gatt_db_append_descriptor(struct gatt_db *db,
>                                         uint16_t handle,
>                                         const bt_uuid_t *uuid,
>                                         uint32_t permissions,
> @@ -98,7 +98,7 @@ gatt_db_service_add_descriptor(struct gatt_db_attribute=
 *attrib,
>                                         void *user_data);
>
>  struct gatt_db_attribute *
> -gatt_db_service_insert_descriptor(struct gatt_db_attribute *attrib,
> +gatt_db_service_append_descriptor(struct gatt_db_attribute *attrib,
>                                         uint16_t handle,
>                                         const bt_uuid_t *uuid,
>                                         uint32_t permissions,
> @@ -110,14 +110,14 @@ struct gatt_db_attribute *
>  gatt_db_service_add_ccc(struct gatt_db_attribute *attrib, uint32_t permi=
ssions);
>
>  struct gatt_db_attribute *
> -gatt_db_insert_included(struct gatt_db *db, uint16_t handle,
> +gatt_db_append_included(struct gatt_db *db, uint16_t handle,
>                         struct gatt_db_attribute *include);
>
>  struct gatt_db_attribute *
>  gatt_db_service_add_included(struct gatt_db_attribute *attrib,
>                                         struct gatt_db_attribute *include=
);
>  struct gatt_db_attribute *
> -gatt_db_service_insert_included(struct gatt_db_attribute *attrib,
> +gatt_db_service_append_included(struct gatt_db_attribute *attrib,
>                                 uint16_t handle,
>                                 struct gatt_db_attribute *include);
>
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index 5e06d4ed4..20b25cf8c 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -1236,7 +1236,7 @@ add_char_with_value(struct gatt_db_attribute *servi=
ce_att, uint16_t handle,
>         struct gatt_db_attribute *attrib;
>
>         if (handle)
> -               attrib =3D gatt_db_service_insert_characteristic(service_=
att,
> +               attrib =3D gatt_db_service_append_characteristic(service_=
att,
>                                                                 handle, u=
uid,
>                                                                 att_permi=
ssions,
>                                                                 char_prop=
erties,
> @@ -1265,7 +1265,7 @@ add_desc_with_value(struct gatt_db_attribute *att, =
uint16_t handle,
>         struct gatt_db_attribute *desc_att;
>
>         if (handle)
> -               desc_att =3D gatt_db_service_insert_descriptor(att, handl=
e, uuid,
> +               desc_att =3D gatt_db_service_append_descriptor(att, handl=
e, uuid,
>                                                         att_perms, NULL, =
NULL,
>                                                         NULL);
>         else
> --
> 2.44.0.478.gd926399ef9-goog
>


--=20
Luiz Augusto von Dentz
