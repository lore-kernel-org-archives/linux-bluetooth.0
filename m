Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA2D156678
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335208; cv=none; b=sT/zIjZz5P+A2TIOsjBUZXRnxgV9MUzBxOLiecw8J/sLNCCRX+oh0NYErNuRLNNnY1kAbN08XZnKZSacFRQplTaqkK4SHMU+DXx0kMTUwRnIlZBQpL5d0oFQ9n01wNAtU+KfOUmpTfjhizpbC8UVrtUpyF0kyUvG/JqB3wiabtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335208; c=relaxed/simple;
	bh=0VLtW/H1edlxUCP/EvBHLyY8RAdKO5KpBTXpWRPfMFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdWjOEln+G93Es5rfxxBjKPg7XcCOTZKtshY0HJ8y7DVUmZLwCL1bPDZFHEc1oiS8lEOBQQ35LYAc6c+hOmxNScU5bum7pEtTqE5EAfmVhE2XgLcrdL1ENbKMiANcSICoqtt3tJpNdxEE85s7VPabAntYmNfbp3GehzJJQiC3bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5zVYRMa; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5zVYRMa"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb3110b964so36638571fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 06:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731335204; x=1731940004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD91a8OkDyPzqB/JmDw1D0H40g7qk+7OeAYNDkhRSTE=;
        b=S5zVYRMauvvwLj8RpCwlu57X+LYzJOW4uYm7SVftqc1K3ev7mGetap0cWItQ3VULB/
         KDTpZ46AW8+On3tMkHOEd0vB1evd5M5WwBb4R/1ojeAD9Maaujc7aXPHaClX95rdlkxC
         +llX9t+cUZrFHqNTFtefDSvReYoyHJnU1XSUmZIiWcO/SoDS/sAO1bwkKdTf5HmTq5Rj
         MAU8G+6zhU+IxhKRolB/2fm5PjxNv4E0Ty73MtjwUSJuItM2s7E1Gvtn1hRd0WWIRn1K
         snysdej97F2OYNpNgprdlEvvM5aEkBRmwCPtMBu8fUw2VUvBti+D8yHJilNGfvB7jrP/
         iogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335204; x=1731940004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD91a8OkDyPzqB/JmDw1D0H40g7qk+7OeAYNDkhRSTE=;
        b=jmP9O+iZbscCKr2Ku9h7wCSXF6MFTZhy64xI6Z17a1GpgMRRN4HdEt8JRdZfyBp0vL
         tMBXBdwmK08VooLUxncPnMIKexfBh+VvMzq3t26gErF3XivF1TdDTXnyMeojp6xRZXS7
         CvwGTUITKQRIK7m4tytr0UkEUDyXxKSgwgGuk4bIUXHpSXz/Z2OyqbnY03/Nc5gmCVld
         OyQorFHlwLmQLnOM2BJIprbtDQ7BGEEJ3XnHOMB2W6NWipSvqNuXPbZAPXPk9h8z2S6B
         jNwdkx+55tIak7m4SmXBlHD44NoofRAue/yvtCmirS+4sUU8bomB5oD+9WFlN6JcRzQf
         vlpg==
X-Gm-Message-State: AOJu0YwAdgLyeLP2JD5e8vb0jFIr58my552url1suuPf/col5CHzOdYS
	HI/patGcAuuWD0yJX/uMEx0DxMWy3ZftxN3wPjsqP5oDm3q3WREf1QgPK89EQa3vOStTKCfG6W0
	sDDYIAHMEYALZ9Xhtm+3ucp/G//b2Cw==
X-Google-Smtp-Source: AGHT+IESzMQf42NGhezTE2vjBIIV9Q5r/MByjXErKK1qcHd03crdnFyM9SOcS6x1D8vbtlNeavHnef7K2rnP40Qb/50=
X-Received: by 2002:a05:651c:2109:b0:2fb:6110:c5cb with SMTP id
 38308e7fff4ca-2ff202ac51cmr51116691fa.34.1731335204107; Mon, 11 Nov 2024
 06:26:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111135250.2319622-1-yuxinwang9999@gmail.com>
In-Reply-To: <20241111135250.2319622-1-yuxinwang9999@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 11 Nov 2024 09:26:30 -0500
Message-ID: <CABBYNZKoDQxd9__tzZVeJwUQ0ZDQVRgRPG-XAvkoWqm+mVCp9Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] advertising: Add scan response properties to LEAdvertisement1
To: Yuxin Wang <yuxinwang9999@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yuxin,

On Mon, Nov 11, 2024 at 8:53=E2=80=AFAM Yuxin Wang <yuxinwang9999@gmail.com=
> wrote:
>
> This update introduces a few properties to org.bluez.LEAdvertisement1
> for manipulating Scan Response Data, similar to the existing properties
> for Advertising Data.

Why would it matter if it's part of the scan data or not? Also ever
since the introduction of extended advertising (EA) these fields are
no longer separated so introducing these fields now is not really
solving any problem in my opinion.

> Resolves: https://github.com/bluez/bluez/issues/667
> ---
>  doc/org.bluez.LEAdvertisement.rst |  37 ++++++++-
>  src/advertising.c                 | 132 ++++++++++++++++++++++--------
>  2 files changed, 130 insertions(+), 39 deletions(-)
>
> diff --git a/doc/org.bluez.LEAdvertisement.rst b/doc/org.bluez.LEAdvertis=
ement.rst
> index d3f9cc4..40be2ff 100644
> --- a/doc/org.bluez.LEAdvertisement.rst
> +++ b/doc/org.bluez.LEAdvertisement.rst
> @@ -75,13 +75,14 @@ dict ManufacturerData
>  array{string} SolicitUUIDs
>  ``````````````````````````
>
> -       Array of UUIDs to include in "Service Solicitation" Advertisement=
 Data.
> +       List of UUIDs to include in the "Service Solicitation" field of t=
he
> +       Advertising Data.
>
>  dict ServiceData
>  ````````````````
>
> -       Service Data elements to include. The keys are the UUID to associ=
ate
> -       with the data.
> +       Service Data elements to include in the Advertising Data. The key=
s
> +       are the UUID to associate with the data.
>
>  dict Data
>  `````````
> @@ -101,6 +102,36 @@ dict Data
>                 <Transport Discovery> <Organization Flags...>
>                 0x26                   0x01         0x01...
>
> +array{string} ScanResponseServiceUUIDs
> +``````````````````````````````````````
> +
> +       List of UUIDs to include in the "Service UUID" field of the Scan
> +       Response Data.
> +
> +dict ScanResponseManufacturerData
> +`````````````````````````````````
> +
> +       Manufacturer Data fields to include in the Scan Response Data. Ke=
ys
> +       are the Manufacturer ID to associate with the data.
> +
> +array{string} ScanResponseSolicitUUIDs
> +``````````````````````````````````````
> +
> +       List of UUIDs to include in the "Service Solicitation" field of t=
he
> +       Scan Response Data.
> +
> +dict ScanResponseServiceData
> +````````````````````````````
> +
> +       Service Data elements to include in the Scan Response Data. The k=
eys
> +       are the UUID to associate with the data.
> +
> +dict ScanResponseData
> +`````````````````````
> +
> +       Scan Response Data to include. Key is the advertising type and va=
lue is
> +       the data as byte array.
> +
>  bool Discoverable
>  `````````````````
>
> diff --git a/src/advertising.c b/src/advertising.c
> index bd121e5..ba70419 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -255,13 +255,12 @@ static bool parse_type(DBusMessageIter *iter, struc=
t btd_adv_client *client)
>         return false;
>  }
>
> -static bool parse_service_uuids(DBusMessageIter *iter,
> -                                       struct btd_adv_client *client)
> +static bool parse_service_uuids(DBusMessageIter *iter, struct bt_ad *ad)
>  {
>         DBusMessageIter ariter;
>
>         if (!iter) {
> -               bt_ad_clear_service_uuid(client->data);
> +               bt_ad_clear_service_uuid(ad);
>                 return true;
>         }
>
> @@ -270,7 +269,7 @@ static bool parse_service_uuids(DBusMessageIter *iter=
,
>
>         dbus_message_iter_recurse(iter, &ariter);
>
> -       bt_ad_clear_service_uuid(client->data);
> +       bt_ad_clear_service_uuid(ad);
>
>         while (dbus_message_iter_get_arg_type(&ariter) =3D=3D DBUS_TYPE_S=
TRING) {
>                 const char *uuid_str;
> @@ -283,7 +282,7 @@ static bool parse_service_uuids(DBusMessageIter *iter=
,
>                 if (bt_string_to_uuid(&uuid, uuid_str) < 0)
>                         goto fail;
>
> -               if (!bt_ad_add_service_uuid(client->data, &uuid))
> +               if (!bt_ad_add_service_uuid(ad, &uuid))
>                         goto fail;
>
>                 dbus_message_iter_next(&ariter);
> @@ -292,17 +291,28 @@ static bool parse_service_uuids(DBusMessageIter *it=
er,
>         return true;
>
>  fail:
> -       bt_ad_clear_service_uuid(client->data);
> +       bt_ad_clear_service_uuid(ad);
>         return false;
>  }
>
> -static bool parse_solicit_uuids(DBusMessageIter *iter,
> +static bool parse_service_uuids_ad(DBusMessageIter *iter,
> +                                       struct btd_adv_client *client)
> +{
> +       return parse_service_uuids(iter, client->data);
> +}
> +
> +static bool parse_service_uuids_sr(DBusMessageIter *iter,
>                                         struct btd_adv_client *client)
> +{
> +       return parse_service_uuids(iter, client->scan);
> +}
> +
> +static bool parse_solicit_uuids(DBusMessageIter *iter, struct bt_ad *ad)
>  {
>         DBusMessageIter ariter;
>
>         if (!iter) {
> -               bt_ad_clear_solicit_uuid(client->data);
> +               bt_ad_clear_solicit_uuid(ad);
>                 return true;
>         }
>
> @@ -311,7 +321,7 @@ static bool parse_solicit_uuids(DBusMessageIter *iter=
,
>
>         dbus_message_iter_recurse(iter, &ariter);
>
> -       bt_ad_clear_solicit_uuid(client->data);
> +       bt_ad_clear_solicit_uuid(ad);
>
>         while (dbus_message_iter_get_arg_type(&ariter) =3D=3D DBUS_TYPE_S=
TRING) {
>                 const char *uuid_str;
> @@ -324,7 +334,7 @@ static bool parse_solicit_uuids(DBusMessageIter *iter=
,
>                 if (bt_string_to_uuid(&uuid, uuid_str) < 0)
>                         goto fail;
>
> -               if (!bt_ad_add_solicit_uuid(client->data, &uuid))
> +               if (!bt_ad_add_solicit_uuid(ad, &uuid))
>                         goto fail;
>
>                 dbus_message_iter_next(&ariter);
> @@ -333,17 +343,28 @@ static bool parse_solicit_uuids(DBusMessageIter *it=
er,
>         return true;
>
>  fail:
> -       bt_ad_clear_solicit_uuid(client->data);
> +       bt_ad_clear_solicit_uuid(ad);
>         return false;
>  }
>
> -static bool parse_manufacturer_data(DBusMessageIter *iter,
> +static bool parse_solicit_uuids_ad(DBusMessageIter *iter,
>                                         struct btd_adv_client *client)
> +{
> +       return parse_solicit_uuids(iter, client->data);
> +}
> +
> +static bool parse_solicit_uuids_sr(DBusMessageIter *iter,
> +                                       struct btd_adv_client *client)
> +{
> +       return parse_solicit_uuids(iter, client->scan);
> +}
> +
> +static bool parse_manufacturer_data(DBusMessageIter *iter, struct bt_ad =
*ad)
>  {
>         DBusMessageIter entries;
>
>         if (!iter) {
> -               bt_ad_clear_manufacturer_data(client->data);
> +               bt_ad_clear_manufacturer_data(ad);
>                 return true;
>         }
>
> @@ -352,7 +373,7 @@ static bool parse_manufacturer_data(DBusMessageIter *=
iter,
>
>         dbus_message_iter_recurse(iter, &entries);
>
> -       bt_ad_clear_manufacturer_data(client->data);
> +       bt_ad_clear_manufacturer_data(ad);
>
>         while (dbus_message_iter_get_arg_type(&entries)
>                                                 =3D=3D DBUS_TYPE_DICT_ENT=
RY) {
> @@ -383,7 +404,7 @@ static bool parse_manufacturer_data(DBusMessageIter *=
iter,
>
>                 DBG("Adding ManufacturerData for %04x", manuf_id);
>
> -               if (!bt_ad_add_manufacturer_data(client->data, manuf_id,
> +               if (!bt_ad_add_manufacturer_data(ad, manuf_id,
>                                                         manuf_data, len))
>                         goto fail;
>
> @@ -393,17 +414,28 @@ static bool parse_manufacturer_data(DBusMessageIter=
 *iter,
>         return true;
>
>  fail:
> -       bt_ad_clear_manufacturer_data(client->data);
> +       bt_ad_clear_manufacturer_data(ad);
>         return false;
>  }
>
> -static bool parse_service_data(DBusMessageIter *iter,
> +static bool parse_manufacturer_data_ad(DBusMessageIter *iter,
> +                                       struct btd_adv_client *client)
> +{
> +       return parse_manufacturer_data(iter, client->data);
> +}
> +
> +static bool parse_manufacturer_data_sr(DBusMessageIter *iter,
>                                         struct btd_adv_client *client)
> +{
> +       return parse_manufacturer_data(iter, client->scan);
> +}
> +
> +static bool parse_service_data(DBusMessageIter *iter, struct bt_ad *ad)
>  {
>         DBusMessageIter entries;
>
>         if (!iter) {
> -               bt_ad_clear_service_data(client->data);
> +               bt_ad_clear_service_data(ad);
>                 return true;
>         }
>
> @@ -412,7 +444,7 @@ static bool parse_service_data(DBusMessageIter *iter,
>
>         dbus_message_iter_recurse(iter, &entries);
>
> -       bt_ad_clear_service_data(client->data);
> +       bt_ad_clear_service_data(ad);
>
>         while (dbus_message_iter_get_arg_type(&entries)
>                                                 =3D=3D DBUS_TYPE_DICT_ENT=
RY) {
> @@ -447,7 +479,7 @@ static bool parse_service_data(DBusMessageIter *iter,
>
>                 DBG("Adding ServiceData for %s", uuid_str);
>
> -               if (!bt_ad_add_service_data(client->data, &uuid, service_=
data,
> +               if (!bt_ad_add_service_data(ad, &uuid, service_data,
>                                                                         l=
en))
>                         goto fail;
>
> @@ -457,10 +489,22 @@ static bool parse_service_data(DBusMessageIter *ite=
r,
>         return true;
>
>  fail:
> -       bt_ad_clear_service_data(client->data);
> +       bt_ad_clear_service_data(ad);
>         return false;
>  }
>
> +static bool parse_service_data_ad(DBusMessageIter *iter,
> +                                       struct btd_adv_client *client)
> +{
> +       return parse_service_data(iter, client->data);
> +}
> +
> +static bool parse_service_data_sr(DBusMessageIter *iter,
> +                                       struct btd_adv_client *client)
> +{
> +       return parse_service_data(iter, client->scan);
> +}
> +
>  static bool set_rsi(struct btd_adv_client *client)
>  {
>         struct bt_crypto *crypto;
> @@ -667,12 +711,12 @@ static bool parse_timeout(DBusMessageIter *iter,
>         return true;
>  }
>
> -static bool parse_data(DBusMessageIter *iter, struct btd_adv_client *cli=
ent)
> +static bool parse_data(DBusMessageIter *iter, struct bt_ad *ad)
>  {
>         DBusMessageIter entries;
>
>         if (!iter) {
> -               bt_ad_clear_data(client->data);
> +               bt_ad_clear_data(ad);
>                 return true;
>         }
>
> @@ -681,7 +725,7 @@ static bool parse_data(DBusMessageIter *iter, struct =
btd_adv_client *client)
>
>         dbus_message_iter_recurse(iter, &entries);
>
> -       bt_ad_clear_data(client->data);
> +       bt_ad_clear_data(ad);
>
>         while (dbus_message_iter_get_arg_type(&entries)
>                                                 =3D=3D DBUS_TYPE_DICT_ENT=
RY) {
> @@ -712,7 +756,7 @@ static bool parse_data(DBusMessageIter *iter, struct =
btd_adv_client *client)
>
>                 DBG("Adding Data for type 0x%02x len %u", type, len);
>
> -               if (!bt_ad_add_data(client->data, type, data, len))
> +               if (!bt_ad_add_data(ad, type, data, len))
>                         goto fail;
>
>                 dbus_message_iter_next(&entries);
> @@ -721,10 +765,22 @@ static bool parse_data(DBusMessageIter *iter, struc=
t btd_adv_client *client)
>         return true;
>
>  fail:
> -       bt_ad_clear_data(client->data);
> +       bt_ad_clear_data(ad);
>         return false;
>  }
>
> +static bool parse_data_ad(DBusMessageIter *iter,
> +                                       struct btd_adv_client *client)
> +{
> +       return parse_data(iter, client->data);
> +}
> +
> +static bool parse_data_sr(DBusMessageIter *iter,
> +                                       struct btd_adv_client *client)
> +{
> +       return parse_data(iter, client->scan);
> +}
> +
>  static bool set_flags(struct btd_adv_client *client, uint8_t flags)
>  {
>         /* Set BR/EDR Not Supported for LE only */
> @@ -832,15 +888,14 @@ static uint8_t *generate_adv_data(struct btd_adv_cl=
ient *client,
>  static uint8_t *generate_scan_rsp(struct btd_adv_client *client,
>                                                 uint32_t *flags, size_t *=
len)
>  {
> -       if (!client->name) {
> +       if (client->name) {
> +               *flags &=3D ~MGMT_ADV_FLAG_LOCAL_NAME;
> +               bt_ad_add_name(client->scan, client->name);
> +       } else if (bt_ad_is_empty(client->scan)) {
>                 *len =3D 0;
>                 return NULL;
>         }
>
> -       *flags &=3D ~MGMT_ADV_FLAG_LOCAL_NAME;
> -
> -       bt_ad_add_name(client->scan, client->name);
> -
>         return bt_ad_generate(client->scan, len);
>  }
>
> @@ -1212,16 +1267,21 @@ static struct adv_parser {
>         bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client=
);
>  } parsers[] =3D {
>         { "Type", parse_type },
> -       { "ServiceUUIDs", parse_service_uuids },
> -       { "SolicitUUIDs", parse_solicit_uuids },
> -       { "ManufacturerData", parse_manufacturer_data },
> -       { "ServiceData", parse_service_data },
> +       { "ServiceUUIDs", parse_service_uuids_ad },
> +       { "ScanResponseServiceUUIDs", parse_service_uuids_sr },
> +       { "SolicitUUIDs", parse_solicit_uuids_ad },
> +       { "ScanResponseSolicitUUIDs", parse_solicit_uuids_sr },
> +       { "ManufacturerData", parse_manufacturer_data_ad },
> +       { "ScanResponseManufacturerData", parse_manufacturer_data_sr },
> +       { "ServiceData", parse_service_data_ad },
> +       { "ScanResponseServiceData", parse_service_data_sr },
>         { "Includes", parse_includes },
>         { "LocalName", parse_local_name },
>         { "Appearance", parse_appearance },
>         { "Duration", parse_duration },
>         { "Timeout", parse_timeout },
> -       { "Data", parse_data },
> +       { "Data", parse_data_ad },
> +       { "ScanResponseData", parse_data_sr },
>         { "Discoverable", parse_discoverable },
>         { "DiscoverableTimeout", parse_discoverable_timeout },
>         { "SecondaryChannel", parse_secondary },
> --
> 2.39.5
>


--=20
Luiz Augusto von Dentz
