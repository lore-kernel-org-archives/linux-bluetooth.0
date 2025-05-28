Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECBA22339
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748445280; cv=none; b=oqV1paoqhaH3UcSKp8At7Fxq3kOKw6uDorxkzqGtJHOGV9EZs3RUdXfyc84Hihpi4PZiQInTOAOEoo/X/6y0ilI6f7fSsxsSiKCUIdbSzPoaVDb3gAL7+FomAHGuC4BJYhcd8Y5k1NFbpDUo+zFIeQ+JKw/F9aEuLe6TsLlYaXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748445280; c=relaxed/simple;
	bh=23f6BBvKkT54ae44zDWg08x2I7rNnQJgFNMp9ytf1/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inKme5EASTmBS73D39wRD7APV5rssxKrrmsZ6JpZCOcA0LnlpUAWKPwHCNBpx3MDEaKGig2310W8mef5fPK8WmymXd2YuUNFJfmqK6H7JK8IPtzKkhWnlE/7ItR8DRrOCOVmSfkVb2dkLUPd6p3MHp2YCNTXZpYbq42hafGVDLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O77p3dmw; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O77p3dmw"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30effbfaf4aso50703361fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748445277; x=1749050077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzfyYbJYzo+Rj8D21h5V2G8c7Htw/xSYCfLv2HO+8SE=;
        b=O77p3dmwgAmxJhxoRqa4e7hShAin5pP2GmDvM0FUhV4ivaVlYsYjDfZV0GO/xPiMVI
         00RtuiaLQmCmYoiO9GZh5z03YGfmhhS5iY4XEOO0hRVbch8ug/H4orsBoutmNTP4cLqL
         ibWYIlKn3bQZj2OeSZqWLcMwC95ZMio39hB1+awkqgCjj3SHJ+1nvRejTY3yqJbOUpdb
         7djY1UecKVgJ4B979kB3QRnsjcUm6/pg+bK9MvdO9qpGRxFOmf0AsFb+CEAlgaT7A10W
         PaghMPXfdlder6uJrE70Ft1/7P3H4IZDgLGASl/g2KrYjEV8uulRMq5e0obd8Y9sG6N0
         9nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748445277; x=1749050077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzfyYbJYzo+Rj8D21h5V2G8c7Htw/xSYCfLv2HO+8SE=;
        b=BKPsdLq0A6zNDrHoe+3NCD+1KUapNQMj+3CcG8L901Jv98h+yUmp2sg8PbTIG4NGOv
         1wT+5g0qjeCHR9LXJPjHf/iKGeznkRXnmSyBikPbQt3yNIbFrLH6hn8xV1WPJS/rugdV
         rShizSzwvcVkrc4guO/ZCNQVSSCS3kRVvUfYQTm4f6UhL3L7XA1NS+wM5HPAEc0NOy+N
         lqrLtB99QmrRCqMsh7DLmazQTZVFJ5abZBl7q680LnuP4RZllukb4GW4gOcergMZot4A
         XUkRNon+NhlEawrIONkhXLTejquSvxCPS2yISTggUzAdXxHK6j59FX+A68mRxAkHEynY
         BZ7Q==
X-Gm-Message-State: AOJu0Yy2Af5YC+j8MYVBDC+8y/CB1HemriYOsXPasHX/VyEMQQRQqZAW
	yVWgSc7lOjBXQzfx7BEvBYHbgpSQ1aPCVjund9Zpq4F3QiKc1ztZ2FfaOG0KwaRgAKqioOmZKpC
	xZJz3dzvED+tOpA+mdRfoStOMicu23TRUAmAc
X-Gm-Gg: ASbGnctdO/2Qq6m6iocfxADgta4PCqUAmJKhtGWnmERee8TyDfhcRF5RovMw4Zx0FxP
	X33hbfj5Zb2GwRwoovjQWd0K9h7h38yEK95dQQ+GHL71Bg2waQbQHFc+Me3tl2Hfa4d+ouIBzRd
	sCpe1jJrgcVu8r7a4rshmnNnj7VGc6MLI=
X-Google-Smtp-Source: AGHT+IEzxgkRumdyBsncLrK1hNGVYkWZHfO/6UX/we0Dji9ATyG3nw2XRYW1geQqDU6X4QV3tRSEp6e4VfAtS1t6lxs=
X-Received: by 2002:a05:651c:211f:b0:30b:b987:b68d with SMTP id
 38308e7fff4ca-3295b991be0mr56296121fa.8.1748445276705; Wed, 28 May 2025
 08:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527132831.232633-1-luiz.dentz@gmail.com> <bff9098f-ae62-4d3a-8241-45b833055827@amlogic.com>
In-Reply-To: <bff9098f-ae62-4d3a-8241-45b833055827@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 May 2025 11:14:23 -0400
X-Gm-Features: AX0GCFuY9ylDZbHf09OzckuLYAd9iaf-Y6dC49nGjw0WFNMNE0MjBw-y2dqItSs
Message-ID: <CABBYNZKmahTjjs5Nj+6+JXuDKzt5CYh9WfHO5pw0QPpBhhV_ag@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1] shared/bap: Fix not handling read offset
To: Ye He <ye.he@amlogic.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 28, 2025 at 1:21=E2=80=AFAM Ye He <ye.he@amlogic.com> wrote:
>
> Hi Luiz,
>
> > [ EXTERNAL EMAIL ]
> >
> > From: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
> >
> > Some attributes may need to handle offset other than 0 in case read lon=
g
> > procedure is used, so this properly handles that for PAC_SINK_CHRC_UUID
> > and PAC_SOURCE_CHRC_UUID.
> >
> > In addition to PAC record this also uses
> > gatt_db_attribute_set_fixed_length for attributes that are considered o=
f
> > fixed size so gatt_db can handle offset directly.
> >
> > Fixes:https://github.com/bluez/bluez/issues/1294
> > ---
> >   src/shared/bap.c | 28 ++++++++++++++++++++++++----
> >   1 file changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > index 4bb6e08b5379..f0c6f64855c4 100644
> > --- a/src/shared/bap.c
> > +++ b/src/shared/bap.c
> > @@ -516,8 +516,15 @@ static void pacs_sink_read(struct gatt_db_attribut=
e *attrib,
> >          queue_foreach(bdb->sinks, pac_foreach, &iov);
> >          queue_foreach(bdb->broadcast_sinks, pac_foreach, &iov);
> >
> > -       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> > -                                                       iov.iov_len);
> > +       if (offset > iov.iov_len) {
> > +               gatt_db_attribute_read_result(attrib, id,
> > +                                               BT_ATT_ERROR_INVALID_OF=
FSET,
> > +                                               NULL, 0);
> > +               return;
> > +       }
> > +
> > +       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base + off=
set,
> > +                                                       iov.iov_len - o=
ffset);
> >   }
> >
> >   static void pacs_sink_loc_read(struct gatt_db_attribute *attrib,
> > @@ -549,8 +556,15 @@ static void pacs_source_read(struct gatt_db_attrib=
ute *attrib,
> >
> >          queue_foreach(bdb->sources, pac_foreach, &iov);
> >
> > -       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> > -                                                       iov.iov_len);
> > +       if (offset > iov.iov_len) {
> > +               gatt_db_attribute_read_result(attrib, id,
> > +                                               BT_ATT_ERROR_INVALID_OF=
FSET,
> > +                                               NULL, 0);
> > +               return;
> > +       }
> > +
> > +       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base + off=
set,
> > +                                                       iov.iov_len - o=
ffset);
> >   }
> >
> >   static void pacs_source_loc_read(struct gatt_db_attribute *attrib,
> > @@ -627,6 +641,7 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
> >                                          BT_GATT_CHRC_PROP_NOTIFY,
> >                                          pacs_sink_loc_read, NULL,
> >                                          pacs);
> > +       gatt_db_attribute_set_fixed_length(pacs->sink_loc, sizeof(uint3=
2_t));
> >
> >          pacs->sink_loc_ccc =3D gatt_db_service_add_ccc(pacs->service,
> >                                          BT_ATT_PERM_READ | BT_ATT_PERM=
_WRITE);
> > @@ -649,6 +664,7 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
> >                                          BT_GATT_CHRC_PROP_NOTIFY,
> >                                          pacs_source_loc_read, NULL,
> >                                          pacs);
> > +       gatt_db_attribute_set_fixed_length(pacs->source_loc, sizeof(uin=
t32_t));
> >
> >          pacs->source_loc_ccc =3D gatt_db_service_add_ccc(pacs->service=
,
> >                                          BT_ATT_PERM_READ | BT_ATT_PERM=
_WRITE);
> > @@ -659,6 +675,8 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
> >                                          BT_GATT_CHRC_PROP_READ |
> >                                          BT_GATT_CHRC_PROP_NOTIFY,
> >                                          pacs_context_read, NULL, pacs)=
;
> > +       gatt_db_attribute_set_fixed_length(pacs->context,
> > +                                               sizeof(struct bt_pacs_c=
ontext));
> >
> >          pacs->context_ccc =3D gatt_db_service_add_ccc(pacs->service,
> >                                          BT_ATT_PERM_READ | BT_ATT_PERM=
_WRITE);
> > @@ -671,6 +689,8 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
> >                                          BT_GATT_CHRC_PROP_NOTIFY,
> >                                          pacs_supported_context_read, N=
ULL,
> >                                          pacs);
> > +       gatt_db_attribute_set_fixed_length(pacs->supported_context,
> > +                                               sizeof(struct bt_pacs_c=
ontext));
> >
> >          pacs->supported_context_ccc =3D gatt_db_service_add_ccc(pacs->=
service,
> >                                          BT_ATT_PERM_READ | BT_ATT_PERM=
_WRITE);
> > --
> > 2.49.0
> >
> >
> I am concerned about this solution. It can indeed solve the problem of
> using blob procedure to read sink pacs or source pacs, but if blob
> procedure is used to read other services, will the problem occur again?
> I think we should fix the issue at its root.

Well Ive already explained that doesn't work since the offset is
already part of the interface, so both internal and external attribute
are expected to return that data following the offset:

https://github.com/bluez/bluez/blob/master/doc/org.bluez.GattCharacteristic=
.rst#arraybyte-readvaluedict-options

Also note that although normally the offset means the offset of data
read with a read long operation I wouldn't be surprised if the vendor
does use for something else, e.g. as control point index or something
like that.

What is perhaps more efficient is to cache the read operations so we
can detect when it is a read long operation taking place we just use
the cache to respond, that said Read Blob that doesn't continue from
previous offset shall still be sent to the callback to respond.

--=20
Luiz Augusto von Dentz
