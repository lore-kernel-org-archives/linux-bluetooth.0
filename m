Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9A191F91
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555175; cv=none; b=T+dBa1aGdWPp1A441QCytneoJDt92Fl3ozxnYQdH/KCUuBTWDx+gSBKoh+t2ApxG7lK+lzEcMO5/+8mjY2zI8tCyPY3TKZf5XD5NYaNI/zeFOKa5bB+YoEXAI8+4pEgIl0yivhfmKPd3A1iT94i2PSEj19Tdq5agufP3iuTuhts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555175; c=relaxed/simple;
	bh=1yGqn08rKjq06qMF+bj/uOaXNr8K05ciaP2AZIaovNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5iwIyyo766pUoRp2ZKfewk42xl8kR3yjePxF28yGoCnZqKnltDMRyBgdf3AwwRhv8bBLQ22dUdHZ5+7ZYyh7643S3NU3z+uUSvWL5hVbd1CdWOeMknNeJyoFb76O678rSEPL5CPvH79+x1pSFHOy0c3WG3SiaMesgVIGaVWL1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXP/OKgG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXP/OKgG"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffc86948dcso8683621fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 09:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732555171; x=1733159971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqR2Uvr/4Cd0khPX6IaUTMwjHfajubdml1k0WXZeYyU=;
        b=mXP/OKgG25k7xknCvJt1AByhDCvXaiWaw518GrcU7MXXRpzSuYv5yjRk3aGnwFycKv
         Tmug9/FyggBwRubDn7iMIz9aYhCF4jEYPciRNlqmfIzGIwbqRIpTbneT0Vehb4qlPFtd
         ELveMs0suwnLGhZrxMtRs5YtHcvPHZbBRnSo0Tq5fb4woEeninB6txDIjCgEEV+y/Gao
         n0LxZxr8W86Qz7mkI7Hcp+kWjKQrvS3RQ17cUBrXeafyl2SDSF4W+vVEBZOTump6FEb0
         DJmqz1xEKAdFOeeRkzkYu+gOvob+AGY902t9TOIlimA2TU2eifQeQxqWD7R2hEkQx34Z
         DnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732555171; x=1733159971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqR2Uvr/4Cd0khPX6IaUTMwjHfajubdml1k0WXZeYyU=;
        b=HihUAFs3Etz8QGafnhKiD5ieHkAU1em4VEwHiaw6pFfznjDBVX8vw72T9JNXlXEXNp
         1Fj6gqauEG6Cj5TCDXiUsEPmLbYZG0Lfkaos4N5OP5kmPc65ZYs8PRfFRvDCZeYTM3HZ
         GHAMVdSqJZT5qomDoVsCf2wjvX2d95Y6EeX18HnnsHDGGeWm03asvpeCKqZIFF4rNVrn
         u1a7Wnq3QegF7qY8FTkpo7yiDt1NMegVW6Jm742eiwDrr22EFs7CVVMMKYA4Y8UXJqJh
         qsS9Av/ex1P+SiGbc1ykjnPzZDnxWNyzthZPuvXh73R7VB4Xc1pkOCScvAhbSoHOo3Zf
         37Kg==
X-Gm-Message-State: AOJu0YyCiq+zkM++qnDR+ZFvPxZqtFpSEfyp3jMYjMQewmafvbckOXiz
	eBV9i3PUHtpw6Kny5pHHiqnOutopFn+UGTZvCdK3hLpt11cWp+gq34tSMgkPQz1tbggWJoERcqV
	fLC4ZJLuVG8TriL0kBjgS5gTYOiUMNw==
X-Gm-Gg: ASbGncv+WvZP0iV4ODVJVSuhWL9Z9Si3fmCUh0E/91rogWdtPsf8H158ibpSO1Br8VC
	Qs04LVA+ixNrc4Q8Gbuey+Jgnm5hcpA==
X-Google-Smtp-Source: AGHT+IEJtslJk9S6AqUzf8lhtfrsaXeTRhj25xc8ixM3Ipc2uzqjXmIjDhgx+jA+gr6puojfQ8YcCvMWXVAsunWA3b0=
X-Received: by 2002:a05:651c:1145:b0:2fb:591d:3db8 with SMTP id
 38308e7fff4ca-2ffa7193bfcmr67382201fa.35.1732555170077; Mon, 25 Nov 2024
 09:19:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124165539.2913146-1-yuxinwang9999@gmail.com> <20241124165539.2913146-3-yuxinwang9999@gmail.com>
In-Reply-To: <20241124165539.2913146-3-yuxinwang9999@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 25 Nov 2024 12:19:17 -0500
Message-ID: <CABBYNZLoyG+i4ztkbgZNwjp+ReRyakog8BdXT1HVxyvLuJaGAg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] advertising: Add scan response support in bluetoothctl
To: Yuxin Wang <yuxinwang9999@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yuxin,

On Sun, Nov 24, 2024 at 11:56=E2=80=AFAM Yuxin Wang <yuxinwang9999@gmail.co=
m> wrote:
>
> Add commands in the bluetoothctl advertising submenu to manage
> scan response data.
> ---
>  client/advertising.c              | 486 +++++++++++++++++++++++-------
>  client/advertising.h              |  25 +-
>  client/bluetoothctl-advertise.rst |  39 +++
>  client/main.c                     |  95 +++++-
>  4 files changed, 515 insertions(+), 130 deletions(-)
>
> diff --git a/client/advertising.c b/client/advertising.c
> index 4a98121..46af2e0 100644
> --- a/client/advertising.c
> +++ b/client/advertising.c
> @@ -59,11 +59,13 @@ static struct ad {
>         uint16_t duration;
>         uint16_t timeout;
>         uint16_t discoverable_to;
> -       char **uuids;
> -       size_t uuids_len;
> -       struct service_data service;
> -       struct manufacturer_data manufacturer;
> -       struct data data;
> +       char **uuids[AD_TYPE_COUNT];
> +       size_t uuids_len[AD_TYPE_COUNT];
> +       char **solicit[AD_TYPE_COUNT];
> +       size_t solicit_len[AD_TYPE_COUNT];
> +       struct service_data service[AD_TYPE_COUNT];
> +       struct manufacturer_data manufacturer[AD_TYPE_COUNT];
> +       struct data data[AD_TYPE_COUNT];
>         bool discoverable;
>         bool tx_power;
>         bool name;
> @@ -111,7 +113,7 @@ static void register_setup(DBusMessageIter *iter, voi=
d *user_data)
>         dbus_message_iter_close_container(iter, &dict);
>  }
>
> -static void print_uuid(const char *uuid)
> +static void print_uuid(const char *prefix, const char *uuid)
>  {
>         const char *text;
>
> @@ -130,37 +132,70 @@ static void print_uuid(const char *uuid)
>                                 str[sizeof(str) - 4] =3D '.';
>                 }
>
> -               bt_shell_printf("UUID: %s(%s)\n", str, uuid);
> +               bt_shell_printf("%s: %s(%s)\n", prefix, str, uuid);
>         } else
> -               bt_shell_printf("UUID: (%s)\n", uuid ? uuid : "");
> +               bt_shell_printf("%s: (%s)\n", prefix, uuid ? uuid : "");
> +}
> +
> +static const struct {
> +    const char* uuid[AD_TYPE_COUNT];
> +    const char* solicit[AD_TYPE_COUNT];
> +    const char* service[AD_TYPE_COUNT];
> +    const char* manufacturer[AD_TYPE_COUNT];
> +    const char* data[AD_TYPE_COUNT];
> +} ad_names =3D {
> +    .uuid =3D { "UUID", "Scan Response UUID" },
> +    .solicit =3D { "Solicit UUID", "Scan Response Solicit UUID" },
> +    .service =3D { "UUID", "Scan Response UUID" },
> +    .manufacturer =3D { "Manufacturer", "Scan Response Manufacturer" },
> +    .data =3D { "Data", "Scan Response Data" }
> +};
> +
> +static void print_ad_uuids(int type)
> +{
> +       char **uuid;
> +
> +       for (uuid =3D ad.uuids[type]; uuid && *uuid; uuid++)
> +               print_uuid(ad_names.uuid[type], *uuid);
>  }
>
> -static void print_ad_uuids(void)
> +static void print_ad_solicit(int type)
>  {
>         char **uuid;
>
> -       for (uuid =3D ad.uuids; uuid && *uuid; uuid++)
> -               print_uuid(*uuid);
> +       for (uuid =3D ad.solicit[type]; uuid && *uuid; uuid++)
> +               print_uuid(ad_names.solicit[type], *uuid);
>  }
>
>  static void print_ad(void)
>  {
> -       print_ad_uuids();
> +       int type;
>
> -       if (ad.service.uuid) {
> -               print_uuid(ad.service.uuid);
> -               bt_shell_hexdump(ad.service.data.data, ad.service.data.le=
n);
> -       }
> +       for (type =3D AD_TYPE_AD; type <=3D AD_TYPE_SRD; type++) {
> +               print_ad_uuids(type);
> +               print_ad_solicit(type);
>
> -       if (ad.manufacturer.data.len) {
> -               bt_shell_printf("Manufacturer: %u\n", ad.manufacturer.id)=
;
> -               bt_shell_hexdump(ad.manufacturer.data.data,
> -                                               ad.manufacturer.data.len)=
;
> -       }
> +               if (ad.service[type].uuid) {
> +                       print_uuid(ad_names.service[type],
> +                                               ad.service[type].uuid);
> +                       bt_shell_hexdump(ad.service[type].data.data,
> +                                               ad.service[type].data.len=
);
> +               }
> +
> +               if (ad.manufacturer[type].data.len) {
> +                       bt_shell_printf("%s: %u\n", ad_names.manufacturer=
[type],
> +                                               ad.manufacturer[type].id)=
;
> +                       bt_shell_hexdump(ad.manufacturer[type].data.data,
> +                                               ad.manufacturer[type].dat=
a.len);
> +               }
>
> -       if (ad.data.valid) {
> -               bt_shell_printf("Data Type: 0x%02x\n", ad.data.type);
> -               bt_shell_hexdump(ad.data.data.data, ad.data.data.len);
> +               if (ad.data[type].valid) {
> +                       bt_shell_printf("%s Type: 0x%02x\n",
> +                                               ad_names.data[type],
> +                                               ad.data[type].type);
> +                       bt_shell_hexdump(ad.data[type].data.data,
> +                                               ad.data[type].data.len);
> +               }
>         }
>
>         bt_shell_printf("Tx Power: %s\n", ad.tx_power ? "on" : "off");
> @@ -228,12 +263,13 @@ static gboolean get_type(const GDBusPropertyTable *=
property,
>         return TRUE;
>  }
>
> -static gboolean uuids_exists(const GDBusPropertyTable *property, void *d=
ata)
> +static gboolean uuids_exists(int type, const GDBusPropertyTable *propert=
y,
> +                                                               void *dat=
a)
>  {
> -       return ad.uuids_len !=3D 0;
> +       return ad.uuids_len[type] !=3D 0;
>  }
>
> -static gboolean get_uuids(const GDBusPropertyTable *property,
> +static gboolean get_uuids(int type, const GDBusPropertyTable *property,
>                                 DBusMessageIter *iter, void *user_data)
>  {
>         DBusMessageIter array;
> @@ -241,55 +277,149 @@ static gboolean get_uuids(const GDBusPropertyTable=
 *property,
>
>         dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "as", &ar=
ray);
>
> -       for (i =3D 0; i < ad.uuids_len; i++)
> +       for (i =3D 0; i < ad.uuids_len[type]; i++)
>                 dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
> -                                                       &ad.uuids[i]);
> +                                               &ad.uuids[type][i]);
>
>         dbus_message_iter_close_container(iter, &array);
>
>         return TRUE;
>  }
>
> -static gboolean service_data_exists(const GDBusPropertyTable *property,
> +static gboolean ad_uuids_exists(const GDBusPropertyTable *property, void=
 *data)
> +{
> +       return uuids_exists(AD_TYPE_AD, property, data);
> +}
> +
> +static gboolean get_ad_uuids(const GDBusPropertyTable *property,
> +                               DBusMessageIter *iter, void *user_data)
> +{
> +       return get_uuids(AD_TYPE_AD, property, iter, user_data);
> +}
> +
> +static gboolean sr_uuids_exists(const GDBusPropertyTable *property, void=
 *data)
> +{
> +       return uuids_exists(AD_TYPE_SRD, property, data);
> +}
> +
> +static gboolean get_sr_uuids(const GDBusPropertyTable *property,
> +                               DBusMessageIter *iter, void *user_data)
> +{
> +       return get_uuids(AD_TYPE_SRD, property, iter, user_data);
> +}
> +
> +static gboolean solicit_uuids_exists(int type,
> +                               const GDBusPropertyTable *property, void =
*data)
> +{
> +       return ad.solicit_len[type] !=3D 0;
> +}
> +
> +static gboolean get_solicit_uuids(int type, const GDBusPropertyTable *pr=
operty,
> +                               DBusMessageIter *iter, void *user_data)
> +{
> +       DBusMessageIter array;
> +       size_t i;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "as", &ar=
ray);
> +
> +       for (i =3D 0; i < ad.solicit_len[type]; i++)
> +               dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
> +                                               &ad.solicit[type][i]);
> +
> +       dbus_message_iter_close_container(iter, &array);
> +
> +       return TRUE;
> +}
> +
> +static gboolean ad_solicit_uuids_exists(const GDBusPropertyTable *proper=
ty,
> +                                                               void *dat=
a)
> +{
> +       return solicit_uuids_exists(AD_TYPE_AD, property, data);
> +}
> +
> +static gboolean get_ad_solicit_uuids(const GDBusPropertyTable *property,
> +                               DBusMessageIter *iter, void *user_data)
> +{
> +       return get_solicit_uuids(AD_TYPE_AD, property, iter, user_data);
> +}
> +
> +static gboolean sr_solicit_uuids_exists(const GDBusPropertyTable *proper=
ty,
>                                                                 void *dat=
a)
>  {
> -       return ad.service.uuid !=3D NULL;
> +       return solicit_uuids_exists(AD_TYPE_SRD, property, data);
>  }
>
> -static gboolean get_service_data(const GDBusPropertyTable *property,
> +static gboolean get_sr_solicit_uuids(const GDBusPropertyTable *property,
> +                               DBusMessageIter *iter, void *user_data)
> +{
> +       return get_solicit_uuids(AD_TYPE_SRD, property, iter, user_data);
> +}
> +
> +static gboolean service_data_exists(int type,
> +                               const GDBusPropertyTable *property, void =
*data)
> +{
> +       return ad.service[type].uuid !=3D NULL;
> +}
> +
> +static gboolean get_service_data(int type, const GDBusPropertyTable *pro=
perty,
>                                 DBusMessageIter *iter, void *user_data)
>  {
>         DBusMessageIter dict;
> -       struct ad_data *data =3D &ad.service.data;
> +       struct ad_data *data =3D &ad.service[type].data;
>         uint8_t *val =3D data->data;
>
>         dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &=
dict);
>
> -       g_dbus_dict_append_array(&dict, ad.service.uuid, DBUS_TYPE_BYTE, =
&val,
> -                                                               data->len=
);
> +       g_dbus_dict_append_array(&dict, ad.service[type].uuid, DBUS_TYPE_=
BYTE,
> +                                                       &val, data->len);
>
>         dbus_message_iter_close_container(iter, &dict);
>
>         return TRUE;
>  }
>
> -static gboolean manufacturer_data_exists(const GDBusPropertyTable *prope=
rty,
> +static gboolean ad_service_data_exists(const GDBusPropertyTable *propert=
y,
>                                                                 void *dat=
a)
>  {
> -       return ad.manufacturer.id !=3D 0;
> +       return service_data_exists(AD_TYPE_AD, property, data);
>  }
>
> -static gboolean get_manufacturer_data(const GDBusPropertyTable *property=
,
> -                                       DBusMessageIter *iter, void *user=
_data)
> +static gboolean get_ad_service_data(const GDBusPropertyTable *property,
> +                               DBusMessageIter *iter, void *user_data)
> +{
> +       return get_service_data(AD_TYPE_AD, property, iter, user_data);
> +}
> +
> +static gboolean sr_service_data_exists(const GDBusPropertyTable *propert=
y,
> +                                                               void *dat=
a)
> +{
> +       return service_data_exists(AD_TYPE_SRD, property, data);
> +}
> +
> +static gboolean get_sr_service_data(const GDBusPropertyTable *property,
> +                               DBusMessageIter *iter, void *user_data)
> +{
> +       return get_service_data(AD_TYPE_SRD, property, iter, user_data);
> +}
> +
> +static gboolean manufacturer_data_exists(int type,
> +                               const GDBusPropertyTable *property, void =
*data)
> +{
> +       return ad.manufacturer[type].id !=3D 0;
> +}
> +
> +static gboolean get_manufacturer_data(int type,
> +                               const GDBusPropertyTable *property,
> +                               DBusMessageIter *iter, void *user_data)
>  {
>         DBusMessageIter dict;
> -       struct ad_data *data =3D &ad.manufacturer.data;
> +       struct ad_data *data =3D &ad.manufacturer[type].data;
>         uint8_t *val =3D data->data;
>
>         dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{qv}", &=
dict);
>
>         g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_UINT16,
> -                                       &ad.manufacturer.id,
> +                                       &ad.manufacturer[type].id,
>                                         DBUS_TYPE_BYTE, &val, data->len);
>
>         dbus_message_iter_close_container(iter, &dict);
> @@ -297,6 +427,30 @@ static gboolean get_manufacturer_data(const GDBusPro=
pertyTable *property,
>         return TRUE;
>  }
>
> +static gboolean ad_manufacturer_data_exists(const GDBusPropertyTable *pr=
operty,
> +                                                               void *dat=
a)
> +{
> +       return manufacturer_data_exists(AD_TYPE_AD, property, data);
> +}
> +
> +static gboolean get_ad_manufacturer_data(const GDBusPropertyTable *prope=
rty,
> +                                       DBusMessageIter *iter, void *user=
_data)
> +{
> +       return get_manufacturer_data(AD_TYPE_AD, property, iter, user_dat=
a);
> +}
> +
> +static gboolean sr_manufacturer_data_exists(const GDBusPropertyTable *pr=
operty,
> +                                                               void *dat=
a)
> +{
> +       return manufacturer_data_exists(AD_TYPE_SRD, property, data);
> +}
> +
> +static gboolean get_sr_manufacturer_data(const GDBusPropertyTable *prope=
rty,
> +                                       DBusMessageIter *iter, void *user=
_data)
> +{
> +       return get_manufacturer_data(AD_TYPE_SRD, property, iter, user_da=
ta);
> +}
> +
>  static gboolean includes_exists(const GDBusPropertyTable *property, void=
 *data)
>  {
>         return ad.tx_power || ad.name || ad.appearance || ad.rsi;
> @@ -394,28 +548,51 @@ static gboolean get_timeout(const GDBusPropertyTabl=
e *property,
>         return TRUE;
>  }
>
> -static gboolean data_exists(const GDBusPropertyTable *property, void *da=
ta)
> +static gboolean data_exists(int type, const GDBusPropertyTable *property=
,
> +                                                               void *dat=
a)
>  {
> -       return ad.data.valid;
> +       return ad.data[type].valid;
>  }
>
> -static gboolean get_data(const GDBusPropertyTable *property,
> +static gboolean get_data(int type, const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *user=
_data)
>  {
>         DBusMessageIter dict;
> -       struct ad_data *data =3D &ad.data.data;
> +       struct ad_data *data =3D &ad.data[type].data;
>         uint8_t *val =3D data->data;
>
>         dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{yv}", &=
dict);
>
> -       g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_BYTE, &ad.data.ty=
pe,
> -                                       DBUS_TYPE_BYTE, &val, data->len);
> +       g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_BYTE,
> +                       &ad.data[type].type, DBUS_TYPE_BYTE, &val, data->=
len);
>
>         dbus_message_iter_close_container(iter, &dict);
>
>         return TRUE;
>  }
>
> +static gboolean ad_data_exists(const GDBusPropertyTable *property, void =
*data)
> +{
> +       return data_exists(AD_TYPE_AD, property, data);
> +}
> +
> +static gboolean get_ad_data(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *user=
_data)
> +{
> +       return get_data(AD_TYPE_AD, property, iter, user_data);
> +}
> +
> +static gboolean sr_data_exists(const GDBusPropertyTable *property, void =
*data)
> +{
> +       return data_exists(AD_TYPE_SRD, property, data);
> +}
> +
> +static gboolean get_sr_data(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *user=
_data)
> +{
> +       return get_data(AD_TYPE_SRD, property, iter, user_data);
> +}
> +
>  static gboolean get_discoverable(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *user=
_data)
>  {
> @@ -487,11 +664,23 @@ static gboolean get_max_interval(const GDBusPropert=
yTable *property,
>
>  static const GDBusPropertyTable ad_props[] =3D {
>         { "Type", "s", get_type },
> -       { "ServiceUUIDs", "as", get_uuids, NULL, uuids_exists },
> -       { "ServiceData", "a{sv}", get_service_data, NULL, service_data_ex=
ists },
> -       { "ManufacturerData", "a{qv}", get_manufacturer_data, NULL,
> -                                               manufacturer_data_exists =
},
> -       { "Data", "a{yv}", get_data, NULL, data_exists },
> +       { "ServiceUUIDs", "as", get_ad_uuids, NULL, ad_uuids_exists },
> +       { "SolicitUUIDs", "as", get_ad_solicit_uuids, NULL,
> +                                               ad_solicit_uuids_exists }=
,
> +       { "ServiceData", "a{sv}", get_ad_service_data, NULL,
> +                                               ad_service_data_exists },
> +       { "ManufacturerData", "a{qv}", get_ad_manufacturer_data, NULL,
> +                                               ad_manufacturer_data_exis=
ts },
> +       { "Data", "a{yv}", get_ad_data, NULL, ad_data_exists },
> +       { "ScanResponseServiceUUIDs", "as", get_sr_uuids, NULL,
> +                                               sr_uuids_exists },
> +       { "ScanResponseSolicitUUIDs", "as", get_sr_solicit_uuids, NULL,
> +                                               sr_solicit_uuids_exists }=
,
> +       { "ScanResponseServiceData", "a{sv}", get_sr_service_data, NULL,
> +                                               sr_service_data_exists },
> +       { "ScanResponseManufacturerData", "a{qv}", get_sr_manufacturer_da=
ta,
> +                                       NULL, sr_manufacturer_data_exists=
 },
> +       { "ScanResponseData", "a{yv}", get_sr_data, NULL, sr_data_exists =
},
>         { "Discoverable", "b", get_discoverable, NULL, NULL },
>         { "DiscoverableTimeout", "q", get_discoverable_timeout, NULL,
>                                                 discoverable_timeout_exis=
ts },
> @@ -582,50 +771,109 @@ void ad_unregister(DBusConnection *conn, GDBusProx=
y *manager)
>         }
>  }
>
> -static void ad_clear_uuids(void)
> +static const struct {
> +    const char* uuid[AD_TYPE_COUNT];
> +    const char* solicit[AD_TYPE_COUNT];
> +    const char* service[AD_TYPE_COUNT];
> +    const char* manufacturer[AD_TYPE_COUNT];
> +    const char* data[AD_TYPE_COUNT];
> +} prop_names =3D {
> +    .uuid =3D { "ServiceUUIDs",  "ScanResponseServiceUUIDs" },
> +    .solicit =3D { "SolicitUUIDs", "ScanResponseSolicitUUIDs" },
> +    .service =3D { "ServiceData", "ScanResponseServiceData" },
> +    .manufacturer =3D { "ManufacturerData", "ScanResponseManufacturerDat=
a" },
> +    .data =3D { "Data", "ScanResponseData" }
> +};
> +
> +static void ad_clear_uuids(int type)
>  {
> -       g_strfreev(ad.uuids);
> -       ad.uuids =3D NULL;
> -       ad.uuids_len =3D 0;
> +       g_strfreev(ad.uuids[type]);
> +       ad.uuids[type] =3D NULL;
> +       ad.uuids_len[type] =3D 0;
>  }
>
> -void ad_advertise_uuids(DBusConnection *conn, int argc, char *argv[])
> +void ad_advertise_uuids(DBusConnection *conn, int type, int argc, char *=
argv[])
>  {
>         if (argc < 2 || !strlen(argv[1])) {
> -               print_ad_uuids();
> +               print_ad_uuids(type);
>                 return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>         }
>
> -       ad_clear_uuids();
> +       ad_clear_uuids(type);
>
> -       ad.uuids =3D g_strdupv(&argv[1]);
> -       if (!ad.uuids) {
> +       ad.uuids[type] =3D g_strdupv(&argv[1]);
> +       if (!ad.uuids[type]) {
>                 bt_shell_printf("Failed to parse input\n");
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
>
> -       ad.uuids_len =3D g_strv_length(ad.uuids);
> +       ad.uuids_len[type] =3D g_strv_length(ad.uuids[type]);
>
> -       g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceUUI=
Ds");
> +       g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
> +                                                       prop_names.uuid[t=
ype]);
>
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> -void ad_disable_uuids(DBusConnection *conn)
> +void ad_disable_uuids(DBusConnection *conn, int type)
>  {
> -       if (!ad.uuids)
> +       if (!ad.uuids[type])
>                 return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>
> -       ad_clear_uuids();
> -       g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceUUI=
Ds");
> +       ad_clear_uuids(type);
> +       g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
> +                                                       prop_names.uuid[t=
ype]);
>
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> -static void ad_clear_service(void)
> +static void ad_clear_solicit(int type)
>  {
> -       g_free(ad.service.uuid);
> -       memset(&ad.service, 0, sizeof(ad.service));
> +       g_strfreev(ad.solicit[type]);
> +       ad.solicit[type] =3D NULL;
> +       ad.solicit_len[type] =3D 0;
> +}
> +
> +void ad_advertise_solicit(DBusConnection *conn, int type,
> +                                                       int argc, char *a=
rgv[])
> +{
> +       if (argc < 2 || !strlen(argv[1])) {
> +               print_ad_solicit(type);
> +               return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +       }
> +
> +       ad_clear_solicit(type);
> +
> +       ad.solicit[type] =3D g_strdupv(&argv[1]);
> +       if (!ad.solicit[type]) {
> +               bt_shell_printf("Failed to parse input\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       ad.solicit_len[type] =3D g_strv_length(ad.solicit[type]);
> +
> +       g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
> +                                               prop_names.solicit[type])=
;
> +
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +void ad_disable_solicit(DBusConnection *conn, int type)
> +{
> +       if (!ad.solicit[type])
> +               return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +
> +       ad_clear_solicit(type);
> +       g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
> +                                               prop_names.solicit[type])=
;
> +
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void ad_clear_service(int type)
> +{
> +       g_free(ad.service[type].uuid);
> +       memset(&ad.service[type], 0, sizeof(ad.service[type]));
>
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
> @@ -658,15 +906,17 @@ static bool ad_add_data(struct ad_data *data, int a=
rgc, char *argv[])
>         return true;
>  }
>
> -void ad_advertise_service(DBusConnection *conn, int argc, char *argv[])
> +void ad_advertise_service(DBusConnection *conn, int type,
> +                                                       int argc, char *a=
rgv[])
>  {
>         struct ad_data data;
>
>         if (argc < 2 || !strlen(argv[1])) {
> -               if (ad.service.uuid) {
> -                       print_uuid(ad.service.uuid);
> -                       bt_shell_hexdump(ad.service.data.data,
> -                                               ad.service.data.len);
> +               if (ad.service[type].uuid) {
> +                       print_uuid(ad_names.service[type],
> +                                               ad.service[type].uuid);
> +                       bt_shell_hexdump(ad.service[type].data.data,
> +                                               ad.service[type].data.len=
);
>                 }
>                 return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>         }
> @@ -674,46 +924,49 @@ void ad_advertise_service(DBusConnection *conn, int=
 argc, char *argv[])
>         if (!ad_add_data(&data, argc - 2, argv + 2))
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>
> -       ad_clear_service();
> +       ad_clear_service(type);
>
> -       ad.service.uuid =3D g_strdup(argv[1]);
> -       ad.service.data =3D data;
> +       ad.service[type].uuid =3D g_strdup(argv[1]);
> +       ad.service[type].data =3D data;
>
> -       g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceDat=
a");
> +       g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
> +                                               prop_names.service[type])=
;
>
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> -void ad_disable_service(DBusConnection *conn)
> +void ad_disable_service(DBusConnection *conn, int type)
>  {
> -       if (!ad.service.uuid)
> +       if (!ad.service[type].uuid)
>                 return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>
> -       ad_clear_service();
> -       g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceDat=
a");
> +       ad_clear_service(type);
> +       g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
> +                                               prop_names.service[type])=
;
>
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> -static void ad_clear_manufacturer(void)
> +static void ad_clear_manufacturer(int type)
>  {
> -       memset(&ad.manufacturer, 0, sizeof(ad.manufacturer));
> +       memset(&ad.manufacturer[type], 0, sizeof(ad.manufacturer[type]));
>
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> -void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *arg=
v[])
> +void ad_advertise_manufacturer(DBusConnection *conn, int type,
> +                                                       int argc, char *a=
rgv[])
>  {
>         char *endptr =3D NULL;
>         long int val;
>         struct ad_data data;
>
>         if (argc < 2 || !strlen(argv[1])) {
> -               if (ad.manufacturer.data.len) {
> -                       bt_shell_printf("Manufacturer: %u\n",
> -                                               ad.manufacturer.id);
> -                       bt_shell_hexdump(ad.manufacturer.data.data,
> -                                               ad.manufacturer.data.len)=
;
> +               if (ad.manufacturer[type].data.len) {
> +                       bt_shell_printf("%s: %u\n", ad_names.manufacturer=
[type],
> +                                               ad.manufacturer[type].id)=
;
> +                       bt_shell_hexdump(ad.manufacturer[type].data.data,
> +                                               ad.manufacturer[type].dat=
a.len);
>                 }
>
>                 return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> @@ -728,45 +981,48 @@ void ad_advertise_manufacturer(DBusConnection *conn=
, int argc, char *argv[])
>         if (!ad_add_data(&data, argc - 2, argv + 2))
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>
> -       ad_clear_manufacturer();
> -       ad.manufacturer.id =3D val;
> -       ad.manufacturer.data =3D data;
> +       ad_clear_manufacturer(type);
> +       ad.manufacturer[type].id =3D val;
> +       ad.manufacturer[type].data =3D data;
>
>         g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
> -                                                       "ManufacturerData=
");
> +                                               prop_names.manufacturer[t=
ype]);
>
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> -void ad_disable_manufacturer(DBusConnection *conn)
> +void ad_disable_manufacturer(DBusConnection *conn, int type)
>  {
> -       if (!ad.manufacturer.id && !ad.manufacturer.data.len)
> +       if (!ad.manufacturer[type].id && !ad.manufacturer[type].data.len)
>                 return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>
> -       ad_clear_manufacturer();
> +       ad_clear_manufacturer(type);
>         g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
> -                                                       "ManufacturerData=
");
> +                                               prop_names.manufacturer[t=
ype]);
>
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> -static void ad_clear_data(void)
> +static void ad_clear_data(int type)
>  {
> -       memset(&ad.data, 0, sizeof(ad.data));
> +       memset(&ad.data[type], 0, sizeof(ad.data[type]));
>
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> -void ad_advertise_data(DBusConnection *conn, int argc, char *argv[])
> +void ad_advertise_data(DBusConnection *conn, int type, int argc, char *a=
rgv[])
>  {
>         char *endptr =3D NULL;
>         long int val;
>         struct ad_data data;
>
>         if (argc < 2 || !strlen(argv[1])) {
> -               if (ad.data.data.len) {
> -                       bt_shell_printf("Type: 0x%02x\n", ad.data.type);
> -                       bt_shell_hexdump(ad.data.data.data, ad.data.data.=
len);
> +               if (ad.data[type].data.len) {
> +                       bt_shell_printf("%s Type: 0x%02x\n",
> +                                                       ad_names.data[typ=
e],
> +                                                       ad.data[type].typ=
e);
> +                       bt_shell_hexdump(ad.data[type].data.data,
> +                                                       ad.data[type].dat=
a.len);
>                 }
>
>                 return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> @@ -781,23 +1037,25 @@ void ad_advertise_data(DBusConnection *conn, int a=
rgc, char *argv[])
>         if (!ad_add_data(&data, argc - 2, argv + 2))
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>
> -       ad_clear_data();
> -       ad.data.valid =3D true;
> -       ad.data.type =3D val;
> -       ad.data.data =3D data;
> +       ad_clear_data(type);
> +       ad.data[type].valid =3D true;
> +       ad.data[type].type =3D val;
> +       ad.data[type].data =3D data;
>
> -       g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Data");
> +       g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
> +                                                       prop_names.data[t=
ype]);
>
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> -void ad_disable_data(DBusConnection *conn)
> +void ad_disable_data(DBusConnection *conn, int type)
>  {
> -       if (!ad.data.type && !ad.data.data.len)
> +       if (!ad.data[type].type && !ad.data[type].data.len)
>                 return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>
> -       ad_clear_data();
> -       g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Data");
> +       ad_clear_data(type);
> +       g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
> +                                                       prop_names.data[t=
ype]);
>
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
> diff --git a/client/advertising.h b/client/advertising.h
> index 145ac80..9d124c7 100644
> --- a/client/advertising.h
> +++ b/client/advertising.h
> @@ -8,15 +8,24 @@
>   *
>   */
>
> +#define AD_TYPE_AD     0
> +#define AD_TYPE_SRD    1
> +#define AD_TYPE_COUNT  2
> +
>  void ad_register(DBusConnection *conn, GDBusProxy *manager, const char *=
type);
>  void ad_unregister(DBusConnection *conn, GDBusProxy *manager);
>
> -void ad_advertise_uuids(DBusConnection *conn, int argc, char *argv[]);
> -void ad_disable_uuids(DBusConnection *conn);
> -void ad_advertise_service(DBusConnection *conn, int argc, char *argv[]);
> -void ad_disable_service(DBusConnection *conn);
> -void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *arg=
v[]);
> -void ad_disable_manufacturer(DBusConnection *conn);
> +void ad_advertise_uuids(DBusConnection *conn, int type, int argc, char *=
argv[]);
> +void ad_disable_uuids(DBusConnection *conn, int type);
> +void ad_advertise_solicit(DBusConnection *conn, int type,
> +                                                       int argc, char *a=
rgv[]);
> +void ad_disable_solicit(DBusConnection *conn, int type);
> +void ad_advertise_service(DBusConnection *conn, int type,
> +                                                       int argc, char *a=
rgv[]);
> +void ad_disable_service(DBusConnection *conn, int type);
> +void ad_advertise_manufacturer(DBusConnection *conn, int type,
> +                                                       int argc, char *a=
rgv[]);
> +void ad_disable_manufacturer(DBusConnection *conn, int type);
>  void ad_advertise_tx_power(DBusConnection *conn, dbus_bool_t *value);
>  void ad_advertise_name(DBusConnection *conn, bool value);
>  void ad_advertise_appearance(DBusConnection *conn, bool value);
> @@ -24,8 +33,8 @@ void ad_advertise_local_name(DBusConnection *conn, cons=
t char *name);
>  void ad_advertise_local_appearance(DBusConnection *conn, long int *value=
);
>  void ad_advertise_duration(DBusConnection *conn, long int *value);
>  void ad_advertise_timeout(DBusConnection *conn, long int *value);
> -void ad_advertise_data(DBusConnection *conn, int argc, char *argv[]);
> -void ad_disable_data(DBusConnection *conn);
> +void ad_advertise_data(DBusConnection *conn, int type, int argc, char *a=
rgv[]);
> +void ad_disable_data(DBusConnection *conn, int type);
>  void ad_advertise_discoverable(DBusConnection *conn, dbus_bool_t *value)=
;
>  void ad_advertise_discoverable_timeout(DBusConnection *conn, long int *v=
alue);
>  void ad_advertise_secondary(DBusConnection *conn, const char *value);
> diff --git a/client/bluetoothctl-advertise.rst b/client/bluetoothctl-adve=
rtise.rst
> index 4b56324..008f800 100644
> --- a/client/bluetoothctl-advertise.rst
> +++ b/client/bluetoothctl-advertise.rst
> @@ -31,6 +31,12 @@ Set/Get advertise uuids.
>  :Example: **# uuids 0x12345678**
>  :Example: **# uuids 90f95193-35de-4306-a6e9-699328f15059**
>
> +solicit
> +-------
> +
> +Set/Get advertise solicit uuids.
> +:Usage: **# solicit [all/uuid1 uuid2 ...]**
> +
>  service
>  -------
>
> @@ -71,6 +77,39 @@ To get the currently set data use the command data wit=
hout any arguments.
>  :Usage: **# data [type] [data=3Dxx xx ...]**
>  :Example: **# data 0x0C 01 0x0F 13**
>
> +sr-uuids
> +--------
> +
> +Set/Get scan response uuids.
> +
> +:Usage: **# sr-uuids [all/uuid1 uuid2 ...]**
> +
> +sr-solicit
> +----------
> +
> +Set/Get scan response solicit uuids.
> +:Usage: **# sr-solicit [all/uuid1 uuid2 ...]**
> +
> +sr-service
> +----------
> +
> +Set/Get scan response service data.
> +
> +:Usage: **# sr-service [uuid] [data=3Dxx xx ...]**
> +
> +sr-manufacturer
> +---------------
> +
> +Set/Get scan response manufacturer data.
> +
> +:Usage: **# sr-manufacturer [id] [data=3Dxx xx ...]**
> +
> +sr-data
> +-------
> +
> +Set/Get scan response data.
> +:Usage: **# sr-data [type] [data=3Dxx xx ...]**
> +
>  discoverable
>  ------------
>
> diff --git a/client/main.c b/client/main.c
> index 3f8143d..3485e1a 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -2538,22 +2538,52 @@ static char *ad_generator(const char *text, int s=
tate)
>
>  static void cmd_advertise_uuids(int argc, char *argv[])
>  {
> -       ad_advertise_uuids(dbus_conn, argc, argv);
> +       ad_advertise_uuids(dbus_conn, AD_TYPE_AD, argc, argv);
> +}
> +
> +static void cmd_advertise_solicit(int argc, char *argv[])
> +{
> +       ad_advertise_solicit(dbus_conn, AD_TYPE_AD, argc, argv);
>  }
>
>  static void cmd_advertise_service(int argc, char *argv[])
>  {
> -       ad_advertise_service(dbus_conn, argc, argv);
> +       ad_advertise_service(dbus_conn, AD_TYPE_AD, argc, argv);
>  }
>
>  static void cmd_advertise_manufacturer(int argc, char *argv[])
>  {
> -       ad_advertise_manufacturer(dbus_conn, argc, argv);
> +       ad_advertise_manufacturer(dbus_conn, AD_TYPE_AD, argc, argv);
>  }
>
>  static void cmd_advertise_data(int argc, char *argv[])
>  {
> -       ad_advertise_data(dbus_conn, argc, argv);
> +       ad_advertise_data(dbus_conn, AD_TYPE_AD, argc, argv);
> +}
> +
> +static void cmd_advertise_sr_uuids(int argc, char *argv[])
> +{
> +       ad_advertise_uuids(dbus_conn, AD_TYPE_SRD, argc, argv);
> +}
> +
> +static void cmd_advertise_sr_solicit(int argc, char *argv[])
> +{
> +       ad_advertise_solicit(dbus_conn, AD_TYPE_SRD, argc, argv);
> +}
> +
> +static void cmd_advertise_sr_service(int argc, char *argv[])
> +{
> +       ad_advertise_service(dbus_conn, AD_TYPE_SRD, argc, argv);
> +}
> +
> +static void cmd_advertise_sr_manufacturer(int argc, char *argv[])
> +{
> +       ad_advertise_manufacturer(dbus_conn, AD_TYPE_SRD, argc, argv);
> +}
> +
> +static void cmd_advertise_sr_data(int argc, char *argv[])
> +{
> +       ad_advertise_data(dbus_conn, AD_TYPE_SRD, argc, argv);
>  }
>
>  static void cmd_advertise_discoverable(int argc, char *argv[])
> @@ -2753,22 +2783,52 @@ static void cmd_advertise_rsi(int argc, char *arg=
v[])
>
>  static void ad_clear_uuids(void)
>  {
> -       ad_disable_uuids(dbus_conn);
> +       ad_disable_uuids(dbus_conn, AD_TYPE_AD);
> +}
> +
> +static void ad_clear_solicit(void)
> +{
> +       ad_disable_solicit(dbus_conn, AD_TYPE_AD);
>  }
>
>  static void ad_clear_service(void)
>  {
> -       ad_disable_service(dbus_conn);
> +       ad_disable_service(dbus_conn, AD_TYPE_AD);
>  }
>
>  static void ad_clear_manufacturer(void)
>  {
> -       ad_disable_manufacturer(dbus_conn);
> +       ad_disable_manufacturer(dbus_conn, AD_TYPE_AD);
>  }
>
>  static void ad_clear_data(void)
>  {
> -       ad_disable_data(dbus_conn);
> +       ad_disable_data(dbus_conn, AD_TYPE_AD);
> +}
> +
> +static void ad_clear_sr_uuids(void)
> +{
> +       ad_disable_uuids(dbus_conn, AD_TYPE_SRD);
> +}
> +
> +static void ad_clear_sr_solicit(void)
> +{
> +       ad_disable_solicit(dbus_conn, AD_TYPE_SRD);
> +}
> +
> +static void ad_clear_sr_service(void)
> +{
> +       ad_disable_service(dbus_conn, AD_TYPE_SRD);
> +}
> +
> +static void ad_clear_sr_manufacturer(void)
> +{
> +       ad_disable_manufacturer(dbus_conn, AD_TYPE_SRD);
> +}
> +
> +static void ad_clear_sr_data(void)
> +{
> +       ad_disable_data(dbus_conn, AD_TYPE_SRD);
>  }
>
>  static void ad_clear_tx_power(void)
> @@ -2819,9 +2879,15 @@ static void ad_clear_interval(void)
>
>  static const struct clear_entry ad_clear[] =3D {
>         { "uuids",              ad_clear_uuids },
> +       { "solicit",            ad_clear_solicit },
>         { "service",            ad_clear_service },
>         { "manufacturer",       ad_clear_manufacturer },
>         { "data",               ad_clear_data },
> +       { "sr-uuids",           ad_clear_sr_uuids },
> +       { "sr-solicit",         ad_clear_sr_solicit },
> +       { "sr-service",         ad_clear_sr_service },
> +       { "sr-manufacturer",    ad_clear_sr_manufacturer },
> +       { "sr-data",            ad_clear_sr_data },
>         { "tx-power",           ad_clear_tx_power },
>         { "name",               ad_clear_name },
>         { "appearance",         ad_clear_appearance },
> @@ -2922,6 +2988,8 @@ static const struct bt_shell_menu advertise_menu =
=3D {
>         .entries =3D {
>         { "uuids", "[uuid1 uuid2 ...]", cmd_advertise_uuids,
>                         "Set/Get advertise uuids" },
> +       { "solicit", "[uuid1 uuid2 ...]", cmd_advertise_solicit,
> +                       "Set/Get advertise solicit uuids" },
>         { "service", "[uuid] [data=3Dxx xx ...]", cmd_advertise_service,
>                         "Set/Get advertise service data" },
>         { "manufacturer", "[id] [data=3Dxx xx ...]",
> @@ -2929,6 +2997,17 @@ static const struct bt_shell_menu advertise_menu =
=3D {
>                         "Set/Get advertise manufacturer data" },
>         { "data", "[type] [data=3Dxx xx ...]", cmd_advertise_data,
>                         "Set/Get advertise data" },
> +       { "sr-uuids", "[uuid1 uuid2 ...]", cmd_advertise_sr_uuids,
> +                       "Set/Get scan response uuids" },
> +       { "sr-solicit", "[uuid1 uuid2 ...]", cmd_advertise_sr_solicit,
> +                       "Set/Get scan response solicit uuids" },
> +       { "sr-service", "[uuid] [data=3Dxx xx ...]", cmd_advertise_sr_ser=
vice,
> +                       "Set/Get scan response service data" },
> +       { "sr-manufacturer", "[id] [data=3Dxx xx ...]",
> +                       cmd_advertise_sr_manufacturer,
> +                       "Set/Get scan response manufacturer data" },
> +       { "sr-data", "[type] [data=3Dxx xx ...]", cmd_advertise_sr_data,
> +                       "Set/Get scan response data" },

We got a few options here:

1. As separate commands
2. As extra optional argument to existing commands
3. As mandatory argument that indicates its type to existing commands

I think option 2 is the better one if we could skip entering ad with
an empty array e.g:

advertise.data type "" "srd..."

Option 3 would break existing scripts since we need to change the
argument positions, but we don't really care about it since now, so I
don't think it would be a problem, but since we have option 2 I guess
that is better in this sense.

>         { "discoverable", "[on/off]", cmd_advertise_discoverable,
>                         "Set/Get advertise discoverable" },
>         { "discoverable-timeout", "[seconds]",
> --
> 2.39.5
>


--=20
Luiz Augusto von Dentz
