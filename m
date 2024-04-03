Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467F487B6
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155028; cv=none; b=SHJtBgYamiujiJshLQcHSKvcr3GoFeVMp8N2hd2YaLShKYAViu7BCZLItQ2w9lGdhtkbOn/8udmwxonkjXVkVU1XO8rtpP17o4EbSuxIqMR6SC8k2jJ3ayDCtjkaoOLNBiXW7ozhm+0IckkOWI5B68U0IuW3eLdvatmSm4qZU3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155028; c=relaxed/simple;
	bh=fHoICP3HXjjRfBaVlWZg1arBBDikU7iqoU5nsGDXKRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtgUEvbDwINfZGLmb+H24ExBtmEIjtlU3mO3WX1auEIk+rxlWBOvfJg0/cRjHqc2nIX1Sstqix1Mb5ih6lFk0u2EV/kNE3pbRam+v68v4Cp47AphfywBL0YWn7QT1neVMXFLtTI8BaAFIw7ebJPOwkswqivPLC6ROMiyk5qyxpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFCepEsR; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFCepEsR"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so85839311fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 07:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712155025; x=1712759825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HU4GSADV4V2ByvG6bjQlHg3rrhNnog9lRiZozgCukcM=;
        b=YFCepEsR4jmkh4KOK2d9eRKb2MOgbNGVB9SYp1+YHZqoCVmmd1NVZuugczI/ObP/zW
         pY8aI7vvZ/kY2ay/Rtc00zE0Fr1I8qHOf1JFyCxccNCe7Yj+H/eark1SvKRc9sZsAkVb
         4tKhh3i6bLHCSkjnW3dzYFDN8FLYbT4kXdYjuY9UR7RdpjV4LYSdfN83S7G4mxv4vJOG
         EUHfxhx8InxkIH4hDQxEQWWfu6cvkGB034vJVi5nVdRhD+WoBRTAfWkZIOyK9ooYZrlB
         ShgUKlgfTN5v065hh0Atsjylvyu+cwgsruf17iz/rvUiC/81kUaXtjmBerUS/JGUPdHq
         M+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712155025; x=1712759825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HU4GSADV4V2ByvG6bjQlHg3rrhNnog9lRiZozgCukcM=;
        b=FAOWlhJs4BQEYTK4IqiAGfLkuabeQUv/1pUfuITcJPKTi4zWnLQ1ZIGeIslHkiSK2r
         M8SMPEiejpw2KYKeYiA7HD+tw+6h3RmaYUJkdL6Ch8URGLp5tDzpPgVUhemZ6s29A+yg
         wPj7ehhSKh+ay88t4NjjPD7LMzrbFRwApceY1fj8lqTUC91wewf19KW2tThmW+TL4osZ
         rvt2RciauQ2Ip3OdAY96hKWGMD4mRF7Clatt19lRv2AKoioZd0nhosvWGIYmUwKwpHzX
         1sZiEldXTExa8O9WAix1K8E9sidpDNZLDQMLichZuYueQkhWJENq0v6xaL9zN6GjA9SD
         q6Ng==
X-Gm-Message-State: AOJu0YxXoqufNQonzM9NCg8IRF6DvCBY6JKxM25JtY8qMZN4boDTFV5N
	Lru9RnCkEo4+hueeg1xDUlvGcC81WHb2gFgZjl1N/GwmvkzUNML5DTydl6VfV8oYygdUEDMx8UN
	vc4LLtKlk52IitoIhpMNYNt4tZfZKmiGK
X-Google-Smtp-Source: AGHT+IE2BXPFFGYy+AJHnpOyBiaNlaG+pIR0kT9FcPJ/rsyFKt1lDlasFjgnJdrNYbK8UOFE7dDNFV1XwKGpDYJTOeo=
X-Received: by 2002:a2e:9216:0:b0:2d8:2761:a90f with SMTP id
 k22-20020a2e9216000000b002d82761a90fmr4885848ljg.33.1712155024685; Wed, 03
 Apr 2024 07:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403110549.75516-1-howardchung@google.com> <20240403110549.75516-2-howardchung@google.com>
In-Reply-To: <20240403110549.75516-2-howardchung@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Apr 2024 10:36:51 -0400
Message-ID: <CABBYNZKpPbnPcfJmi42smd6E-JUh6kBi9aX6EWpq-h7_tBVJMA@mail.gmail.com>
Subject: Re: [Bluez PATCH 2/2] shared/gatt: Add descriptor insert function
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
> service->attributes has an assumption that it should look like:
> |char_uuid|char_1|desc_1_1|desc_1_2|char_uuid|char_2|desc_2_1|char_uuid|.=
..
> where desc_x_y means a descriptor of char_x.

Will need to check the trace but I believe BlueZ always discover all
characteristics before moving to descriptors, if that is not happening
they there is probably a bug somewhere, that said perhaps you are
doing the discovery procedure with another stack which doesn't employ
the same logic, although inefficient it is possible to discover out of
order but that would require reassigning the descriptors to
characteristics once they are found, which is also inefficient but I
would understand if you after supporting other stacks.

> In monitor, an attribute is inserted as soon as it is found. It is not
> guranteed that all the descriptors of a characteristic would be found
> before another characteristic is found.

You might want to include such a trace, don't recall seeing any stack
that does out-order discover.

> This adds a function to insert the descriptor with the given handle to
> an appropriate place in its service attribute list and make monitor to
> use this function when a descripter is found.
>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> ---
>
>  monitor/att.c        |  2 +-
>  src/shared/gatt-db.c | 66 ++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/gatt-db.h |  9 ++++++
>  3 files changed, 76 insertions(+), 1 deletion(-)
>
> diff --git a/monitor/att.c b/monitor/att.c
> index ddeb54d9e..503099745 100644
> --- a/monitor/att.c
> +++ b/monitor/att.c
> @@ -4153,7 +4153,7 @@ static struct gatt_db_attribute *insert_desc(const =
struct l2cap_frame *frame,
>         if (!db)
>                 return NULL;
>
> -       return gatt_db_append_descriptor(db, handle, uuid, 0, NULL, NULL,=
 NULL);
> +       return gatt_db_insert_descriptor(db, handle, uuid, 0, NULL, NULL,=
 NULL);
>  }
>
>  static void att_find_info_rsp_16(const struct l2cap_frame *frame)
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 39bba9b54..f08c5afaa 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -1002,6 +1002,72 @@ service_append_descriptor(struct gatt_db_service *=
service,
>         return service->attributes[i];
>  }
>
> +struct gatt_db_attribute *
> +gatt_db_insert_descriptor(struct gatt_db *db,
> +                                       uint16_t handle,
> +                                       const bt_uuid_t *uuid,
> +                                       uint32_t permissions,
> +                                       gatt_db_read_t read_func,
> +                                       gatt_db_write_t write_func,
> +                                       void *user_data)
> +{
> +       struct gatt_db_attribute *attrib, *iter_attr, *char_attr =3D NULL=
;
> +       struct gatt_db_service *service;
> +       int i, j, num_index, char_index;
> +
> +       attrib =3D gatt_db_get_service(db, handle);
> +       if (!attrib)
> +               return NULL;
> +
> +       service =3D attrib->service;
> +       num_index =3D get_attribute_index(service, 0);
> +       if (!num_index)
> +               return NULL;
> +
> +       // Find the characteristic the descriptor belongs to.
> +       for (i =3D 0; i < num_index; i++) {
> +               iter_attr =3D service->attributes[i];
> +               if (bt_uuid_cmp(&characteristic_uuid, &iter_attr->uuid))
> +                       continue;
> +
> +               if (iter_attr->handle > handle)
> +                       continue;
> +
> +               // Find the characteristic with the largest handle among =
those
> +               // with handles less than the descriptor's handle.
> +               if (!char_attr || iter_attr->handle > char_attr->handle) =
{
> +                       char_attr =3D iter_attr;
> +                       char_index =3D i;
> +               }
> +       }
> +
> +       // There is no characteristic contain this descriptor. Something =
went
> +       // wrong
> +       if (!char_attr)
> +               return NULL;
> +
> +       // Find the end of this characteristic
> +       for (i =3D char_index + 1; i < num_index; i++) {
> +               iter_attr =3D service->attributes[i];
> +
> +               if (!bt_uuid_cmp(&characteristic_uuid, &iter_attr->uuid) =
||
> +                       !bt_uuid_cmp(&included_service_uuid, &iter_attr->=
uuid))
> +                       break;
> +       }
> +
> +       // Move all of the attributes after the end of this characteristi=
c to
> +       // its next index.
> +       for (j =3D num_index; j > i; j--)
> +               service->attributes[j] =3D service->attributes[j - 1];
> +
> +       service->attributes[i] =3D new_attribute(service, handle, uuid, N=
ULL, 0);
> +
> +       set_attribute_data(service->attributes[i], read_func, write_func,
> +                                                       permissions, user=
_data);
> +
> +       return service->attributes[i];
> +}
> +
>  struct gatt_db_attribute *
>  gatt_db_append_descriptor(struct gatt_db *db,
>                                         uint16_t handle,
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index ec0eccdfc..4c4e88d87 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -80,6 +80,15 @@ gatt_db_append_characteristic(struct gatt_db *db,
>                                         gatt_db_write_t write_func,
>                                         void *user_data);
>
> +struct gatt_db_attribute *
> +gatt_db_insert_descriptor(struct gatt_db *db,
> +                                       uint16_t handle,
> +                                       const bt_uuid_t *uuid,
> +                                       uint32_t permissions,
> +                                       gatt_db_read_t read_func,
> +                                       gatt_db_write_t write_func,
> +                                       void *user_data);
> +
>  struct gatt_db_attribute *
>  gatt_db_append_descriptor(struct gatt_db *db,
>                                         uint16_t handle,
> --
> 2.44.0.478.gd926399ef9-goog
>


--=20
Luiz Augusto von Dentz
