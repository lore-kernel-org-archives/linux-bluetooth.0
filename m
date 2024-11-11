Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6237F19C569
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342735; cv=none; b=PVBsqeEC9Zs3bY2E61H4s6S47cSyKAn1x0lORhecm7PflFvdgY3J/FxUOefJ/hq8Wff86CC4NPKZDO6ciYLK+zGGkY4cbfN5RCTLoAq3l9gJqykiXJPulcRYM14jfQUMUMPPQ0yOaLSN4/m5BB4c337fqWJ/zPyJvH9eH82QHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342735; c=relaxed/simple;
	bh=+BCIOXT/I7uM93UC7tt9A0P4cM6Pbeg86QmCodmUETM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5RvZI0+T4jPUuYhPGVex9cCiiVTOD7RBe0gbNB0fR1P5Yq6dYbaZb6ZDBNN7rbu74RJWPlTyNNH/O36K1TtbOGoYPDqf42BzOo65KdIj9OeuMOWFraPm6qAr1n2O6GpGOSIp2vdMw3qXo9hhGaR5TsQxNB7WEvansXIzzj6wFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/S/QbOm; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/S/QbOm"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7183a3f3beaso2497877a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 08:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731342732; x=1731947532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHXA5z45c7Yg6iJ+/Eu/yNn4T/7zp+iU26SNLh6guMs=;
        b=f/S/QbOmol41K3njX0p7HcE8u4/x8N9Sqy7gzKHUvdcsAWjl08M/hqf6c2+TmuHMos
         7fjDOQpf/DXDscykUV6zfbXxqs56B91xzvpzuEQAdc5krX7srChsnF0S09bYWpN3QR/z
         xypjFtdyT05/UDfnDtWaLNygCqPDv8a/ZOC9w8/usCzTde0aF4z6DU7ryr1PBQyWQUcD
         zJ5cZxCTUNUIyTV0Zk2PIW5hXCbacyiYa5/dRDPXlwVTzN6IulZapLpgQk++WlJdru84
         aPlji8L9pgBVX6ZERzFShzadd6dFnE7S0795HL3fXhjNnOextPJ2gU9/AmIFoLXzSpb4
         BM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731342732; x=1731947532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHXA5z45c7Yg6iJ+/Eu/yNn4T/7zp+iU26SNLh6guMs=;
        b=cEwOCQqpRzVMsIbODPFAfXPrtIB3ib400dN6nRcm14rM4qeV2UO5xvi3J2L6/l2eYj
         9lXRy76cF9wmTf/G33RBrbCtADSNwfdiDJ4wOaqXQomiVmQ6o0rYkAt+BtwWgr7HV9f2
         wYGYW/lRIbDm3p17KPglqMeQR+wMGQWU+6YASM9wUywe18TrE8LowdQ76UUcJ1IUXR9y
         QxeAQAeZZm4Z0MsI61H0z019RoADdSXJLxBhqHq/5z6fonckVG0DrjTjnLbD/MWemJ0f
         1snl4Y9a5heFNvLJ5JiHylIfb9PsHyYeNkJOOtZziq5QC3fVMuH5Z3uUCdpqR6op584r
         mmAw==
X-Gm-Message-State: AOJu0YwkuHeDd247G06yvF/7WU/z5mttYv7MhbdV0UF8fWljxOrxO3Ii
	kDvNA1E+GzzoNQ9kBSQc0wOCplTKQbnmW4VPsZkG/GW36W0gruxHa++PO9RYQ161mQUpOwlSUOf
	UMwHnm8PPUnmmkzCMA4qJr/1sXdIuif9uuXY=
X-Google-Smtp-Source: AGHT+IEPMpsq44gbo2Vi1HaxF7jDwaG7SLR+q4Qyiait77qDE29RGEo+7llfiykIYZEv1DMFMp88Vy+B7SCQgdXS1ek=
X-Received: by 2002:a05:6830:d13:b0:718:9df:997f with SMTP id
 46e09a7af769-71a1c2307ddmr12306000a34.14.1731342732246; Mon, 11 Nov 2024
 08:32:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111135250.2319622-1-yuxinwang9999@gmail.com> <CABBYNZKoDQxd9__tzZVeJwUQ0ZDQVRgRPG-XAvkoWqm+mVCp9Q@mail.gmail.com>
In-Reply-To: <CABBYNZKoDQxd9__tzZVeJwUQ0ZDQVRgRPG-XAvkoWqm+mVCp9Q@mail.gmail.com>
From: Yuxin Wang <yuxinwang9999@gmail.com>
Date: Tue, 12 Nov 2024 00:32:52 +0800
Message-ID: <CAPGQxBRbaj4tpciULLTKZ6h77FU3VT7shewa6u7-fbMJWwm4_Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] advertising: Add scan response properties to LEAdvertisement1
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

I would ideally like to use Extended Advertising (EA) as well.
However, EA is an optional feature that not all BLE 5.0 devices
support, such as the Raspberry Pi 4. For devices that do not support
EA, including BLE 4.2 devices, using Scan Response Data is the only
option to advertise more content.

In my scenario, the advertising data is about 50 bytes. Therefore,
using Scan Response Data is a reasonable solution to be compatible
with all devices.

I'm not sure how useful the Scan Response Data is, but there may be
others looking for this feature:

- https://www.linux.org/threads/bluez-how-to-fully-use-adv-and-scan-resp-pa=
ckets.53468/
- https://github.com/bluez/bluez/issues/667

The Scan Response Data is also mentioned in the Matter Core
Specification, which states, "Note that if additional vendor-specific
information is to be conveyed and does not fit within the Advertising
Data, it may be included in the Scan Response Data."

While advanced users may manipulate Scan Response Data via the
Management Socket or btmgmt, these methods are less user-friendly.
Setting Scan Response Data has already been implemented in the
underlying code but has not yet been made accessible via DBus.


On Mon, Nov 11, 2024 at 10:26=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Yuxin,
>
> On Mon, Nov 11, 2024 at 8:53=E2=80=AFAM Yuxin Wang <yuxinwang9999@gmail.c=
om> wrote:
> >
> > This update introduces a few properties to org.bluez.LEAdvertisement1
> > for manipulating Scan Response Data, similar to the existing properties
> > for Advertising Data.
>
> Why would it matter if it's part of the scan data or not? Also ever
> since the introduction of extended advertising (EA) these fields are
> no longer separated so introducing these fields now is not really
> solving any problem in my opinion.
>
> > Resolves: https://github.com/bluez/bluez/issues/667
> > ---
> >  doc/org.bluez.LEAdvertisement.rst |  37 ++++++++-
> >  src/advertising.c                 | 132 ++++++++++++++++++++++--------
> >  2 files changed, 130 insertions(+), 39 deletions(-)
> >
> > diff --git a/doc/org.bluez.LEAdvertisement.rst b/doc/org.bluez.LEAdvert=
isement.rst
> > index d3f9cc4..40be2ff 100644
> > --- a/doc/org.bluez.LEAdvertisement.rst
> > +++ b/doc/org.bluez.LEAdvertisement.rst
> > @@ -75,13 +75,14 @@ dict ManufacturerData
> >  array{string} SolicitUUIDs
> >  ``````````````````````````
> >
> > -       Array of UUIDs to include in "Service Solicitation" Advertiseme=
nt Data.
> > +       List of UUIDs to include in the "Service Solicitation" field of=
 the
> > +       Advertising Data.
> >
> >  dict ServiceData
> >  ````````````````
> >
> > -       Service Data elements to include. The keys are the UUID to asso=
ciate
> > -       with the data.
> > +       Service Data elements to include in the Advertising Data. The k=
eys
> > +       are the UUID to associate with the data.
> >
> >  dict Data
> >  `````````
> > @@ -101,6 +102,36 @@ dict Data
> >                 <Transport Discovery> <Organization Flags...>
> >                 0x26                   0x01         0x01...
> >
> > +array{string} ScanResponseServiceUUIDs
> > +``````````````````````````````````````
> > +
> > +       List of UUIDs to include in the "Service UUID" field of the Sca=
n
> > +       Response Data.
> > +
> > +dict ScanResponseManufacturerData
> > +`````````````````````````````````
> > +
> > +       Manufacturer Data fields to include in the Scan Response Data. =
Keys
> > +       are the Manufacturer ID to associate with the data.
> > +
> > +array{string} ScanResponseSolicitUUIDs
> > +``````````````````````````````````````
> > +
> > +       List of UUIDs to include in the "Service Solicitation" field of=
 the
> > +       Scan Response Data.
> > +
> > +dict ScanResponseServiceData
> > +````````````````````````````
> > +
> > +       Service Data elements to include in the Scan Response Data. The=
 keys
> > +       are the UUID to associate with the data.
> > +
> > +dict ScanResponseData
> > +`````````````````````
> > +
> > +       Scan Response Data to include. Key is the advertising type and =
value is
> > +       the data as byte array.
> > +
> >  bool Discoverable
> >  `````````````````
> >
> > diff --git a/src/advertising.c b/src/advertising.c
> > index bd121e5..ba70419 100644
> > --- a/src/advertising.c
> > +++ b/src/advertising.c
> > @@ -255,13 +255,12 @@ static bool parse_type(DBusMessageIter *iter, str=
uct btd_adv_client *client)
> >         return false;
> >  }
> >
> > -static bool parse_service_uuids(DBusMessageIter *iter,
> > -                                       struct btd_adv_client *client)
> > +static bool parse_service_uuids(DBusMessageIter *iter, struct bt_ad *a=
d)
> >  {
> >         DBusMessageIter ariter;
> >
> >         if (!iter) {
> > -               bt_ad_clear_service_uuid(client->data);
> > +               bt_ad_clear_service_uuid(ad);
> >                 return true;
> >         }
> >
> > @@ -270,7 +269,7 @@ static bool parse_service_uuids(DBusMessageIter *it=
er,
> >
> >         dbus_message_iter_recurse(iter, &ariter);
> >
> > -       bt_ad_clear_service_uuid(client->data);
> > +       bt_ad_clear_service_uuid(ad);
> >
> >         while (dbus_message_iter_get_arg_type(&ariter) =3D=3D DBUS_TYPE=
_STRING) {
> >                 const char *uuid_str;
> > @@ -283,7 +282,7 @@ static bool parse_service_uuids(DBusMessageIter *it=
er,
> >                 if (bt_string_to_uuid(&uuid, uuid_str) < 0)
> >                         goto fail;
> >
> > -               if (!bt_ad_add_service_uuid(client->data, &uuid))
> > +               if (!bt_ad_add_service_uuid(ad, &uuid))
> >                         goto fail;
> >
> >                 dbus_message_iter_next(&ariter);
> > @@ -292,17 +291,28 @@ static bool parse_service_uuids(DBusMessageIter *=
iter,
> >         return true;
> >
> >  fail:
> > -       bt_ad_clear_service_uuid(client->data);
> > +       bt_ad_clear_service_uuid(ad);
> >         return false;
> >  }
> >
> > -static bool parse_solicit_uuids(DBusMessageIter *iter,
> > +static bool parse_service_uuids_ad(DBusMessageIter *iter,
> > +                                       struct btd_adv_client *client)
> > +{
> > +       return parse_service_uuids(iter, client->data);
> > +}
> > +
> > +static bool parse_service_uuids_sr(DBusMessageIter *iter,
> >                                         struct btd_adv_client *client)
> > +{
> > +       return parse_service_uuids(iter, client->scan);
> > +}
> > +
> > +static bool parse_solicit_uuids(DBusMessageIter *iter, struct bt_ad *a=
d)
> >  {
> >         DBusMessageIter ariter;
> >
> >         if (!iter) {
> > -               bt_ad_clear_solicit_uuid(client->data);
> > +               bt_ad_clear_solicit_uuid(ad);
> >                 return true;
> >         }
> >
> > @@ -311,7 +321,7 @@ static bool parse_solicit_uuids(DBusMessageIter *it=
er,
> >
> >         dbus_message_iter_recurse(iter, &ariter);
> >
> > -       bt_ad_clear_solicit_uuid(client->data);
> > +       bt_ad_clear_solicit_uuid(ad);
> >
> >         while (dbus_message_iter_get_arg_type(&ariter) =3D=3D DBUS_TYPE=
_STRING) {
> >                 const char *uuid_str;
> > @@ -324,7 +334,7 @@ static bool parse_solicit_uuids(DBusMessageIter *it=
er,
> >                 if (bt_string_to_uuid(&uuid, uuid_str) < 0)
> >                         goto fail;
> >
> > -               if (!bt_ad_add_solicit_uuid(client->data, &uuid))
> > +               if (!bt_ad_add_solicit_uuid(ad, &uuid))
> >                         goto fail;
> >
> >                 dbus_message_iter_next(&ariter);
> > @@ -333,17 +343,28 @@ static bool parse_solicit_uuids(DBusMessageIter *=
iter,
> >         return true;
> >
> >  fail:
> > -       bt_ad_clear_solicit_uuid(client->data);
> > +       bt_ad_clear_solicit_uuid(ad);
> >         return false;
> >  }
> >
> > -static bool parse_manufacturer_data(DBusMessageIter *iter,
> > +static bool parse_solicit_uuids_ad(DBusMessageIter *iter,
> >                                         struct btd_adv_client *client)
> > +{
> > +       return parse_solicit_uuids(iter, client->data);
> > +}
> > +
> > +static bool parse_solicit_uuids_sr(DBusMessageIter *iter,
> > +                                       struct btd_adv_client *client)
> > +{
> > +       return parse_solicit_uuids(iter, client->scan);
> > +}
> > +
> > +static bool parse_manufacturer_data(DBusMessageIter *iter, struct bt_a=
d *ad)
> >  {
> >         DBusMessageIter entries;
> >
> >         if (!iter) {
> > -               bt_ad_clear_manufacturer_data(client->data);
> > +               bt_ad_clear_manufacturer_data(ad);
> >                 return true;
> >         }
> >
> > @@ -352,7 +373,7 @@ static bool parse_manufacturer_data(DBusMessageIter=
 *iter,
> >
> >         dbus_message_iter_recurse(iter, &entries);
> >
> > -       bt_ad_clear_manufacturer_data(client->data);
> > +       bt_ad_clear_manufacturer_data(ad);
> >
> >         while (dbus_message_iter_get_arg_type(&entries)
> >                                                 =3D=3D DBUS_TYPE_DICT_E=
NTRY) {
> > @@ -383,7 +404,7 @@ static bool parse_manufacturer_data(DBusMessageIter=
 *iter,
> >
> >                 DBG("Adding ManufacturerData for %04x", manuf_id);
> >
> > -               if (!bt_ad_add_manufacturer_data(client->data, manuf_id=
,
> > +               if (!bt_ad_add_manufacturer_data(ad, manuf_id,
> >                                                         manuf_data, len=
))
> >                         goto fail;
> >
> > @@ -393,17 +414,28 @@ static bool parse_manufacturer_data(DBusMessageIt=
er *iter,
> >         return true;
> >
> >  fail:
> > -       bt_ad_clear_manufacturer_data(client->data);
> > +       bt_ad_clear_manufacturer_data(ad);
> >         return false;
> >  }
> >
> > -static bool parse_service_data(DBusMessageIter *iter,
> > +static bool parse_manufacturer_data_ad(DBusMessageIter *iter,
> > +                                       struct btd_adv_client *client)
> > +{
> > +       return parse_manufacturer_data(iter, client->data);
> > +}
> > +
> > +static bool parse_manufacturer_data_sr(DBusMessageIter *iter,
> >                                         struct btd_adv_client *client)
> > +{
> > +       return parse_manufacturer_data(iter, client->scan);
> > +}
> > +
> > +static bool parse_service_data(DBusMessageIter *iter, struct bt_ad *ad=
)
> >  {
> >         DBusMessageIter entries;
> >
> >         if (!iter) {
> > -               bt_ad_clear_service_data(client->data);
> > +               bt_ad_clear_service_data(ad);
> >                 return true;
> >         }
> >
> > @@ -412,7 +444,7 @@ static bool parse_service_data(DBusMessageIter *ite=
r,
> >
> >         dbus_message_iter_recurse(iter, &entries);
> >
> > -       bt_ad_clear_service_data(client->data);
> > +       bt_ad_clear_service_data(ad);
> >
> >         while (dbus_message_iter_get_arg_type(&entries)
> >                                                 =3D=3D DBUS_TYPE_DICT_E=
NTRY) {
> > @@ -447,7 +479,7 @@ static bool parse_service_data(DBusMessageIter *ite=
r,
> >
> >                 DBG("Adding ServiceData for %s", uuid_str);
> >
> > -               if (!bt_ad_add_service_data(client->data, &uuid, servic=
e_data,
> > +               if (!bt_ad_add_service_data(ad, &uuid, service_data,
> >                                                                        =
 len))
> >                         goto fail;
> >
> > @@ -457,10 +489,22 @@ static bool parse_service_data(DBusMessageIter *i=
ter,
> >         return true;
> >
> >  fail:
> > -       bt_ad_clear_service_data(client->data);
> > +       bt_ad_clear_service_data(ad);
> >         return false;
> >  }
> >
> > +static bool parse_service_data_ad(DBusMessageIter *iter,
> > +                                       struct btd_adv_client *client)
> > +{
> > +       return parse_service_data(iter, client->data);
> > +}
> > +
> > +static bool parse_service_data_sr(DBusMessageIter *iter,
> > +                                       struct btd_adv_client *client)
> > +{
> > +       return parse_service_data(iter, client->scan);
> > +}
> > +
> >  static bool set_rsi(struct btd_adv_client *client)
> >  {
> >         struct bt_crypto *crypto;
> > @@ -667,12 +711,12 @@ static bool parse_timeout(DBusMessageIter *iter,
> >         return true;
> >  }
> >
> > -static bool parse_data(DBusMessageIter *iter, struct btd_adv_client *c=
lient)
> > +static bool parse_data(DBusMessageIter *iter, struct bt_ad *ad)
> >  {
> >         DBusMessageIter entries;
> >
> >         if (!iter) {
> > -               bt_ad_clear_data(client->data);
> > +               bt_ad_clear_data(ad);
> >                 return true;
> >         }
> >
> > @@ -681,7 +725,7 @@ static bool parse_data(DBusMessageIter *iter, struc=
t btd_adv_client *client)
> >
> >         dbus_message_iter_recurse(iter, &entries);
> >
> > -       bt_ad_clear_data(client->data);
> > +       bt_ad_clear_data(ad);
> >
> >         while (dbus_message_iter_get_arg_type(&entries)
> >                                                 =3D=3D DBUS_TYPE_DICT_E=
NTRY) {
> > @@ -712,7 +756,7 @@ static bool parse_data(DBusMessageIter *iter, struc=
t btd_adv_client *client)
> >
> >                 DBG("Adding Data for type 0x%02x len %u", type, len);
> >
> > -               if (!bt_ad_add_data(client->data, type, data, len))
> > +               if (!bt_ad_add_data(ad, type, data, len))
> >                         goto fail;
> >
> >                 dbus_message_iter_next(&entries);
> > @@ -721,10 +765,22 @@ static bool parse_data(DBusMessageIter *iter, str=
uct btd_adv_client *client)
> >         return true;
> >
> >  fail:
> > -       bt_ad_clear_data(client->data);
> > +       bt_ad_clear_data(ad);
> >         return false;
> >  }
> >
> > +static bool parse_data_ad(DBusMessageIter *iter,
> > +                                       struct btd_adv_client *client)
> > +{
> > +       return parse_data(iter, client->data);
> > +}
> > +
> > +static bool parse_data_sr(DBusMessageIter *iter,
> > +                                       struct btd_adv_client *client)
> > +{
> > +       return parse_data(iter, client->scan);
> > +}
> > +
> >  static bool set_flags(struct btd_adv_client *client, uint8_t flags)
> >  {
> >         /* Set BR/EDR Not Supported for LE only */
> > @@ -832,15 +888,14 @@ static uint8_t *generate_adv_data(struct btd_adv_=
client *client,
> >  static uint8_t *generate_scan_rsp(struct btd_adv_client *client,
> >                                                 uint32_t *flags, size_t=
 *len)
> >  {
> > -       if (!client->name) {
> > +       if (client->name) {
> > +               *flags &=3D ~MGMT_ADV_FLAG_LOCAL_NAME;
> > +               bt_ad_add_name(client->scan, client->name);
> > +       } else if (bt_ad_is_empty(client->scan)) {
> >                 *len =3D 0;
> >                 return NULL;
> >         }
> >
> > -       *flags &=3D ~MGMT_ADV_FLAG_LOCAL_NAME;
> > -
> > -       bt_ad_add_name(client->scan, client->name);
> > -
> >         return bt_ad_generate(client->scan, len);
> >  }
> >
> > @@ -1212,16 +1267,21 @@ static struct adv_parser {
> >         bool (*func)(DBusMessageIter *iter, struct btd_adv_client *clie=
nt);
> >  } parsers[] =3D {
> >         { "Type", parse_type },
> > -       { "ServiceUUIDs", parse_service_uuids },
> > -       { "SolicitUUIDs", parse_solicit_uuids },
> > -       { "ManufacturerData", parse_manufacturer_data },
> > -       { "ServiceData", parse_service_data },
> > +       { "ServiceUUIDs", parse_service_uuids_ad },
> > +       { "ScanResponseServiceUUIDs", parse_service_uuids_sr },
> > +       { "SolicitUUIDs", parse_solicit_uuids_ad },
> > +       { "ScanResponseSolicitUUIDs", parse_solicit_uuids_sr },
> > +       { "ManufacturerData", parse_manufacturer_data_ad },
> > +       { "ScanResponseManufacturerData", parse_manufacturer_data_sr },
> > +       { "ServiceData", parse_service_data_ad },
> > +       { "ScanResponseServiceData", parse_service_data_sr },
> >         { "Includes", parse_includes },
> >         { "LocalName", parse_local_name },
> >         { "Appearance", parse_appearance },
> >         { "Duration", parse_duration },
> >         { "Timeout", parse_timeout },
> > -       { "Data", parse_data },
> > +       { "Data", parse_data_ad },
> > +       { "ScanResponseData", parse_data_sr },
> >         { "Discoverable", parse_discoverable },
> >         { "DiscoverableTimeout", parse_discoverable_timeout },
> >         { "SecondaryChannel", parse_secondary },
> > --
> > 2.39.5
> >
>
>
> --
> Luiz Augusto von Dentz
