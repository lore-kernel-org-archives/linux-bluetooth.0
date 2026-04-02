Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3893F0744
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147028; cv=pass; b=YHL8vWGwZvMNyyK/0jdzUxiU4fMKCPdpa69ldwcFZsLQr/Mn+yTwJPhJugRdA6JEr3+jjKNnhSDsdGNDVdsAhZBsmdprHuqdtx4+EgD7jbEWIzVeoi9CoKmjZLUTEr2gBneBuDlECSAmtka0rwJJN3pJ5R3fXy9gEwEFhrQYbtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147028; c=relaxed/simple;
	bh=wmiyqCTpMem9gKzrbUnIMkXkr0/7KPQ7UtbKdQrleRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjFK7VigkWUR++9CA7qkIPfoy+jfoQtLW9znaNHC1MN9r/0RC9CRAeRVaukYk5H20oN1joNYP5nRJFh9WZhT+NKztK08zwK+uBQTBUAQPnwC8o0gMxfjb2HnnVtFQaXzdAkZwMwGCjOUNv8SQRzxTzdLoNLlcsMtWuvBarFcaLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhQTOkXu; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhQTOkXu"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6500040f128so1025341d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 09:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775147023; cv=none;
        d=google.com; s=arc-20240605;
        b=TtuaJhXQLpVBxEcTIdpslrskcTeHXLPPYvaqrjArp6wu7qlcSGT79vpkKgG7Om1FrM
         VM/J1wLcDLwM18M7zqrySfgF7UdZjqqfHUB4Cz90xrkieChCHRXQ5YcTjUYbPn4Cie6m
         yJW1nb9qF7+09cTfteuRYiGa+9hqojL6zXnGZiLZ94UbIqpUOjCEQGYuSD1zUBTmYkh1
         WrNRQMPHbybrc6kABwFzBCWatNY+CBd5Ksb3/o5Icujrab2j2GnifYOtAXrATxluIw2M
         kI+GxMHkj1mwWU3K1hxkvKippqR1PeoDH7fowwDVaG5lNR3PxUc6oUf2iT/zqPuAQ69u
         7WxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=idte2KKGh9htUrOU0IQdwWaLrFGjJA+QHTTsFtgSLkU=;
        fh=DBIRJP4DvnAE+M31BcQ50XI3CAn/idN52/MNTtsfw9E=;
        b=CQhkrTqy3QjlGbYA0c21BuOPmCxw/du+g8WaQbz9IFwqdNq73U8O/O5BZ5kMdq79ql
         PyW4mdUGMGdeT8fHNZMUP6RuMQcn11g2lOf4T/HcZUDpxPQOuMO5FgWI7dsv1nCiS7ug
         j3NV5OXMTGCnQolvSbnDNOo1BNAJt/zwOA4rif5JjyLF7FmtUv5E6qHmA+HFEvwxfCWW
         ZtLhtEJJSm6IY2bB1h1aKFFDc0aWejYJIiP9p1g/uctSm/WounVGiT5ngB4rl+zaVn68
         RRFJnbgImAkPmEXwfcHCOuq7dSIPysMjGDJuKUoJJ6xuAXP7XSSqu/QXurU4Hr4bDswR
         c3hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147023; x=1775751823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idte2KKGh9htUrOU0IQdwWaLrFGjJA+QHTTsFtgSLkU=;
        b=OhQTOkXuauIDVqOr1egQnwX2URhZ00yEhdwNeFt8kOKfeTnXcwanuM/SaMh/odExCw
         Tfz2FJ07w4io60DZH9ZvoIu1xe4rHn173jtY8b/KPtU4yOIy8huzhpo/7OYD22zKjgE4
         ogG2i1G/jEDVsNyRq0da0q85Sd3g2yV+/fG6+8A+og5PKZ+ZqAR2tWlM0YCuLGrX63Sp
         bF7mWKc0qfTdpR9sUhre3SbB11gxJh8cHft6eVSQWtUpsOVnieGUrXrFgek3NvLyka0G
         uSNOCpL5BW0tERMMRIlsbZ8QHDSsc96EbpU4WNd5ycvYi0IWiX/uhjXIl12J0iWVxpWa
         iGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147023; x=1775751823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=idte2KKGh9htUrOU0IQdwWaLrFGjJA+QHTTsFtgSLkU=;
        b=MO0W+cbzAhnivMEsKZ/T6kKIeo+lpBmr9jjPVaVZB3P4v5ehqZ6d+EQOVUlvX0C5t2
         VR0ulp81nHcXheWz36GEOSdVgAs1w4nfMmYJiZ7+umLzuizT4nnNlZA0m9pQA6cVHjBO
         kevoLCp8GtVXH+QS6Ku3685yqKk++WcH5a4EDih+xVShgzgNXxWViibmlcjAD2wkfLwt
         jbWStR7fNSv6xI0M8P7ta4LPgyCNpQKsSziZHpH85TPma3Ncoz6W9Nx6WE1YfXXVPYTy
         VsoRI7lNkXt0jhSEfY2UbtvOZo267I+JdjSqll1FMfGsrNMgqTMxgXqzwVDC+nKTUoyK
         6lGw==
X-Gm-Message-State: AOJu0YxhYeowLNk8bCXBbpXTXx7CEtsRX/YB8/FKQV1fJxRhMcX1ArTS
	uR3mItdxhfsTnwkB+CdLXl2q8+EIVLxS9Gna21L3lqRpsVnu2oIyF1pHAbmqJtQBTGgEfPAfrLo
	dgPIu9gXjxQ6Gj66IlaW60O6kFExH3udwhUr4ofs=
X-Gm-Gg: AeBDievP39i7+SDqA1If91e+IaBbZL/cPRwJCMaGRFIQ7q0S8iM88RreJ3KvmaZobAL
	/uYKmlwjAqQX7TNpzSlvkdFuQXYQqohyVm6WUHkPGO8us6ZPzoNOTjUPWil8SrAH2SJ4wqsokk5
	C2WlptmX/cuGPf6jaOa51Qb4RMoDccba8IUopiaOXXWy5Shmgzxo7dDZ5b9188wY6ncPXSEP1HC
	vfkDwgLGFlACpIMOVxQo82lkAMsyqETb3r7XG9DTQiiWvsZBmYTIhnfFgMu97Da27ex3Kp/+3V0
	02tmAmG7FoO2AAL+AH1el3GTPOzh4DdEZff8CT4k5W5AdCpBHSu/6YEZ0IVNosq1u82Yw4k3sZz
	1hw==
X-Received: by 2002:a53:df4c:0:b0:650:18fc:f53e with SMTP id
 956f58d0204a3-6502fe5a150mr6572514d50.53.1775147023308; Thu, 02 Apr 2026
 09:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402154520.48939-1-hadess@hadess.net> <20260402154520.48939-2-hadess@hadess.net>
In-Reply-To: <20260402154520.48939-2-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 2 Apr 2026 12:23:31 -0400
X-Gm-Features: AQROBzDC7lEuBudhCtaxyPoVcHU1vxOSEhWqbDcxIouOkwV4JFCAY4mFrqHzED8
Message-ID: <CABBYNZK1qvGRpGqGXaYDGr5mmekcuEAYmdeKB9WzgXN6Rci38A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] shared: Remove glib dependency from src/shared/ad.c
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Thu, Apr 2, 2026 at 11:48=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> src/shared/ad.c includes src/eir.h, which uses glib, which means that
> the non-glib shared library can't be used without linking to glib.
>
> Use our own linked list implementation to remove the glib use.
> ---
>  plugins/neard.c |  4 ++--
>  src/adapter.c   |  9 +++++----
>  src/device.c    | 22 +++++++++++-----------
>  src/device.h    | 10 ++++++----
>  src/eir.c       | 24 ++++++++++++------------
>  src/eir.h       | 11 +++++------
>  unit/test-eir.c |  5 ++---
>  7 files changed, 43 insertions(+), 42 deletions(-)
>
> diff --git a/plugins/neard.c b/plugins/neard.c
> index c84934025cd8..b2860403d50d 100644
> --- a/plugins/neard.c
> +++ b/plugins/neard.c
> @@ -58,7 +58,7 @@ struct oob_params {
>         bdaddr_t address;
>         uint32_t class;
>         char *name;
> -       GSList *services;
> +       slist_t *services;

No need to come up with another list implementation, just use struct queue.

>         uint8_t *hash;
>         uint8_t *randomizer;
>         uint8_t *pin;
> @@ -68,7 +68,7 @@ struct oob_params {
>
>  static void free_oob_params(struct oob_params *params)
>  {
> -       g_slist_free_full(params->services, free);
> +       slist_clear(params->services, free);
>         g_free(params->name);
>         g_free(params->hash);
>         g_free(params->randomizer);
> diff --git a/src/adapter.c b/src/adapter.c
> index 04568dae6e98..8eb0caa34223 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -43,6 +43,7 @@
>  #include "textfile.h"
>
>  #include "src/shared/util.h"
> +#include "src/shared/list.h"
>  #include "src/shared/queue.h"
>  #include "src/shared/att.h"
>  #include "src/shared/gatt-db.h"
> @@ -7171,10 +7172,10 @@ static void confirm_name(struct btd_adapter *adap=
ter, const bdaddr_t *bdaddr,
>
>  static void adapter_msd_notify(struct btd_adapter *adapter,
>                                                         struct btd_device=
 *dev,
> -                                                       GSList *msd_list)
> +                                                       slist_t *msd_list=
)
>  {
>         GSList *cb_l, *cb_next;
> -       GSList *msd_l, *msd_next;
> +       slist_t *msd_l, *msd_next;
>
>         for (cb_l =3D adapter->msd_callbacks; cb_l !=3D NULL; cb_l =3D cb=
_next) {
>                 btd_msd_cb_t cb =3D cb_l->data;
> @@ -7184,7 +7185,7 @@ static void adapter_msd_notify(struct btd_adapter *=
adapter,
>                 for (msd_l =3D msd_list; msd_l !=3D NULL; msd_l =3D msd_n=
ext) {
>                         const struct eir_msd *msd =3D msd_l->data;
>
> -                       msd_next =3D g_slist_next(msd_l);
> +                       msd_next =3D msd_l->next;
>
>                         cb(adapter, dev, msd->company, msd->data,
>                                                                 msd->data=
_len);
> @@ -7223,7 +7224,7 @@ static bool is_filter_match(GSList *discovery_filte=
r, struct eir_data *eir_data,
>                                 /* m->data contains string representation=
 of
>                                  * uuid.
>                                  */
> -                               if (g_slist_find_custom(eir_data->service=
s,
> +                               if (slist_find(eir_data->services,
>                                                         m->data,
>                                                         g_strcmp) !=3D NU=
LL)
>                                         got_match =3D true;
> diff --git a/src/device.c b/src/device.c
> index 0e8ca28d3809..2a3b23ef3013 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2432,9 +2432,9 @@ unref:
>         dev->connect =3D NULL;
>  }
>
> -void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
> +void device_add_eir_uuids(struct btd_device *dev, slist_t *uuids)
>  {
> -       GSList *l;
> +       slist_t *l;
>         GSList *added =3D NULL;
>
>         if (dev->bredr_state.svc_resolved || dev->le_state.svc_resolved)
> @@ -2465,13 +2465,13 @@ static void add_manufacturer_data(void *data, voi=
d *user_data)
>                                         DEVICE_INTERFACE, "ManufacturerDa=
ta");
>  }
>
> -void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
> +void device_set_manufacturer_data(struct btd_device *dev, slist_t *list,
>                                                                 bool dupl=
icate)
>  {
>         if (duplicate)
>                 bt_ad_clear_manufacturer_data(dev->ad);
>
> -       g_slist_foreach(list, add_manufacturer_data, dev);
> +       slist_foreach(list, add_manufacturer_data, dev);
>  }
>
>  static void add_service_data(void *data, void *user_data)
> @@ -2479,7 +2479,7 @@ static void add_service_data(void *data, void *user=
_data)
>         struct eir_sd *sd =3D data;
>         struct btd_device *dev =3D user_data;
>         bt_uuid_t uuid;
> -       GSList *l;
> +       slist_t *l;
>
>         if (bt_string_to_uuid(&uuid, sd->uuid) < 0)
>                 return;
> @@ -2487,21 +2487,21 @@ static void add_service_data(void *data, void *us=
er_data)
>         if (!bt_ad_add_service_data(dev->ad, &uuid, sd->data, sd->data_le=
n))
>                 return;
>
> -       l =3D g_slist_append(NULL, sd->uuid);
> +       l =3D slist_append(NULL, sd->uuid);
>         device_add_eir_uuids(dev, l);
> -       g_slist_free(l);
> +       slist_free(l);
>
>         g_dbus_emit_property_changed(dbus_conn, dev->path,
>                                         DEVICE_INTERFACE, "ServiceData");
>  }
>
> -void device_set_service_data(struct btd_device *dev, GSList *list,
> +void device_set_service_data(struct btd_device *dev, slist_t *list,
>                                                         bool duplicate)
>  {
>         if (duplicate)
>                 bt_ad_clear_service_data(dev->ad);
>
> -       g_slist_foreach(list, add_service_data, dev);
> +       slist_foreach(list, add_service_data, dev);
>  }
>
>  static void add_data(void *data, void *user_data)
> @@ -2518,13 +2518,13 @@ static void add_data(void *data, void *user_data)
>                                                 "AdvertisingData");
>  }
>
> -void device_set_data(struct btd_device *dev, GSList *list,
> +void device_set_data(struct btd_device *dev, slist_t *list,
>                                                         bool duplicate)
>  {
>         if (duplicate)
>                 bt_ad_clear_data(dev->ad);
>
> -       g_slist_foreach(list, add_data, dev);
> +       slist_foreach(list, add_data, dev);
>  }
>
>  static struct btd_service *find_connectable_service(struct btd_device *d=
ev,
> diff --git a/src/device.h b/src/device.h
> index c7b8b2a16eb9..5ee1f2300223 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -9,6 +9,8 @@
>   *
>   */
>
> +#include "src/shared/list.h"
> +
>  #define DEVICE_INTERFACE       "org.bluez.Device1"
>
>  struct btd_device;
> @@ -78,12 +80,12 @@ void btd_device_gatt_set_service_changed(struct btd_d=
evice *device,
>                                                 uint16_t start, uint16_t =
end);
>  bool device_attach_att(struct btd_device *dev, GIOChannel *io);
>  void btd_device_add_uuid(struct btd_device *device, const char *uuid);
> -void device_add_eir_uuids(struct btd_device *dev, GSList *uuids);
> -void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
> +void device_add_eir_uuids(struct btd_device *dev, slist_t *uuids);
> +void device_set_manufacturer_data(struct btd_device *dev, slist_t *list,
>                                                         bool duplicate);
> -void device_set_service_data(struct btd_device *dev, GSList *list,
> +void device_set_service_data(struct btd_device *dev, slist_t *list,
>                                                         bool duplicate);
> -void device_set_data(struct btd_device *dev, GSList *list,
> +void device_set_data(struct btd_device *dev, slist_t *list,
>                                                         bool duplicate);
>  void device_probe_profile(gpointer a, gpointer b);
>  void device_remove_profile(gpointer a, gpointer b);
> diff --git a/src/eir.c b/src/eir.c
> index 68ed74fe6493..8efca6978b39 100644
> --- a/src/eir.c
> +++ b/src/eir.c
> @@ -49,7 +49,7 @@ static void data_free(void *data)
>
>  void eir_data_free(struct eir_data *eir)
>  {
> -       g_slist_free_full(eir->services, free);
> +       slist_clear(eir->services, free);
>         eir->services =3D NULL;
>         g_free(eir->name);
>         eir->name =3D NULL;
> @@ -57,11 +57,11 @@ void eir_data_free(struct eir_data *eir)
>         eir->hash =3D NULL;
>         free(eir->randomizer);
>         eir->randomizer =3D NULL;
> -       g_slist_free_full(eir->msd_list, g_free);
> +       slist_clear(eir->msd_list, g_free);
>         eir->msd_list =3D NULL;
> -       g_slist_free_full(eir->sd_list, sd_free);
> +       slist_clear(eir->sd_list, sd_free);
>         eir->sd_list =3D NULL;
> -       g_slist_free_full(eir->data_list, data_free);
> +       slist_clear(eir->data_list, data_free);
>         eir->data_list =3D NULL;
>  }
>
> @@ -80,7 +80,7 @@ static void eir_parse_uuid16(struct eir_data *eir, cons=
t void *data,
>                 uuid_str =3D bt_uuid2string(&service);
>                 if (!uuid_str)
>                         continue;
> -               eir->services =3D g_slist_append(eir->services, uuid_str)=
;
> +               eir->services =3D slist_append(eir->services, uuid_str);
>         }
>  }
>
> @@ -99,7 +99,7 @@ static void eir_parse_uuid32(struct eir_data *eir, cons=
t void *data,
>                 uuid_str =3D bt_uuid2string(&service);
>                 if (!uuid_str)
>                         continue;
> -               eir->services =3D g_slist_append(eir->services, uuid_str)=
;
> +               eir->services =3D slist_append(eir->services, uuid_str);
>         }
>  }
>
> @@ -119,7 +119,7 @@ static void eir_parse_uuid128(struct eir_data *eir, c=
onst uint8_t *data,
>                 uuid_str =3D bt_uuid2string(&service);
>                 if (!uuid_str)
>                         continue;
> -               eir->services =3D g_slist_append(eir->services, uuid_str)=
;
> +               eir->services =3D slist_append(eir->services, uuid_str);
>                 uuid_ptr +=3D 16;
>         }
>  }
> @@ -151,7 +151,7 @@ static void eir_parse_msd(struct eir_data *eir, const=
 uint8_t *data,
>         msd->data_len =3D len - 2;
>         memcpy(&msd->data, data + 2, msd->data_len);
>
> -       eir->msd_list =3D g_slist_append(eir->msd_list, msd);
> +       eir->msd_list =3D slist_append(eir->msd_list, msd);
>  }
>
>  static void eir_parse_sd(struct eir_data *eir, uuid_t *service,
> @@ -169,7 +169,7 @@ static void eir_parse_sd(struct eir_data *eir, uuid_t=
 *service,
>         sd->data_len =3D len;
>         memcpy(&sd->data, data, sd->data_len);
>
> -       eir->sd_list =3D g_slist_append(eir->sd_list, sd);
> +       eir->sd_list =3D slist_append(eir->sd_list, sd);
>  }
>
>  static void eir_parse_uuid16_data(struct eir_data *eir, const uint8_t *d=
ata,
> @@ -226,7 +226,7 @@ static void eir_parse_data(struct eir_data *eir, uint=
8_t type,
>         ad->data =3D g_malloc(len);
>         memcpy(ad->data, data, len);
>
> -       eir->data_list =3D g_slist_append(eir->data_list, ad);
> +       eir->data_list =3D slist_append(eir->data_list, ad);
>
>         if (type =3D=3D EIR_CSIP_RSI)
>                 eir->rsi =3D true;
> @@ -605,12 +605,12 @@ static int match_sd_uuid(const void *data, const vo=
id *user_data)
>
>  struct eir_sd *eir_get_service_data(struct eir_data *eir, const char *uu=
id)
>  {
> -       GSList *l;
> +       slist_t *l;
>
>         if (!eir || !uuid)
>                 return NULL;
>
> -       l =3D g_slist_find_custom(eir->sd_list, uuid, match_sd_uuid);
> +       l =3D slist_find(eir->sd_list, uuid, match_sd_uuid);
>         if (!l)
>                 return NULL;
>
> diff --git a/src/eir.h b/src/eir.h
> index b9f7c3874eb3..7adaef7fb0e4 100644
> --- a/src/eir.h
> +++ b/src/eir.h
> @@ -9,10 +9,9 @@
>   *
>   */
>
> -#include <glib.h>
> -
>  #include "bluetooth/sdp.h"
>  #include "bluetooth/uuid.h"
> +#include "src/shared/list.h"
>
>  #define EIR_FLAGS                   0x01  /* flags */
>  #define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more available=
 */
> @@ -73,7 +72,7 @@ struct eir_ad {
>  };
>
>  struct eir_data {
> -       GSList *services;
> +       slist_t *services;
>         unsigned int flags;
>         char *name;
>         uint32_t class;
> @@ -88,9 +87,9 @@ struct eir_data {
>         uint16_t did_product;
>         uint16_t did_version;
>         uint16_t did_source;
> -       GSList *msd_list;
> -       GSList *sd_list;
> -       GSList *data_list;
> +       slist_t *msd_list;
> +       slist_t *sd_list;
> +       slist_t *data_list;
>  };
>
>  void eir_data_free(struct eir_data *eir);
> diff --git a/unit/test-eir.c b/unit/test-eir.c
> index 55967e957c82..5024d43723a8 100644
> --- a/unit/test-eir.c
> +++ b/unit/test-eir.c
> @@ -587,7 +587,7 @@ static void print_debug(const char *str, void *user_d=
ata)
>  static void test_ad(const struct test_data *test, struct eir_data *eir)
>  {
>         struct bt_ad *ad;
> -       GSList *list;
> +       slist_t *list;
>
>         ad =3D bt_ad_new_with_data(test->eir_size, test->eir_data);
>         g_assert(ad);
> @@ -636,7 +636,7 @@ static void test_parsing(gconstpointer data)
>  {
>         const struct test_data *test =3D data;
>         struct eir_data eir;
> -       GSList *list;
> +       slist_t *list;
>
>         memset(&eir, 0, sizeof(eir));
>
> @@ -664,7 +664,6 @@ static void test_parsing(gconstpointer data)
>         g_assert(eir.tx_power =3D=3D test->tx_power);
>
>         if (test->uuid) {
> -               GSList *list;
>                 int n =3D 0;
>
>                 for (list =3D eir.services; list; list =3D list->next, n+=
+) {
> --
> 2.53.0
>
>


--=20
Luiz Augusto von Dentz
