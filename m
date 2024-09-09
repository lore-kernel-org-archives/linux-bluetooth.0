Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2017ABA4B
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895827; cv=none; b=s1ihiQZ+pbfGXzLzZJo62FElnwehB/mms/BX7hF6HfebQWp4kNUTfxq2RL4iUED4BpM/DG7cLOnJ5DakW2G46DxXU81VUzDxTrdV7sodVI3i2ljCAgZ/npwKult6HF/LEiB4QxbhUPHA+t3ctmU2h5l8dH5oAN5y12clgcS7f4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895827; c=relaxed/simple;
	bh=IdBlOzjfiVX/bWcr0G+9QfPIQ0pv2p0llQ3embvH4t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZanXXaeWGOTkomnvB82gkB3UxFGtbgONgNboPzFReSmKghkQ/YCccbyjbSXwVohpU7D1HF4ZtUUy7MxzKTz8cZPAK3jwj2+hTzntvYAXy7UZWTf+cN44lGUEC2BqgGdbCFKMJCVyMBNlrvq51e/viw/NNp71hhg1ZjjJn6ea4mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPZmbS5D; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPZmbS5D"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f75c6ed428so24345441fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Sep 2024 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725895824; x=1726500624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxORylBgeY9SdC+MW17BQErjCl/hBzpqHuywBTHZv90=;
        b=PPZmbS5DctYqMlELKhVCA5IKM7nUna8Usa37l5XIi3/mc1eFjOee0hRUG0RqB37RpE
         9g3CWoZ/BByIZY2BCQ8IQ8mAbEXWMK1/iXG+pXNA6ro/Td8bSZHES9YNoQP6r84qbUlv
         J8i0il5+5DNIWiNs/X97jNNVDzpLgAYqqV1Vi/jIyGezOA3QR3ufa+EyvVoCV6WtL+u5
         Kh1MaoMqvvz7uuekHfFdFX5h3qtQxtEeyMe/qwHFomXOcRWpfHFnEezZUETIi7R2KcxC
         SYVtR6ukvf7DWtZSca1y1of7FzhBS1es6aa9DFNOshs8wwCV3lHF/h3wZqyOiMF3y+Ii
         pAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725895824; x=1726500624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxORylBgeY9SdC+MW17BQErjCl/hBzpqHuywBTHZv90=;
        b=blz4xFhk8aqFqXidxbnStyqc9lfhZu36MRLev9z0OrPGwiq5YoqbRlz7/SfQ/4KKFj
         0i/DcGh+zRoikzI8GI8LxsJm+HcmGx03L5/P0EXCQHadvjCQ90RnQAmSLvH91w+mhetA
         izfjxzI5dTtj3upWKtGnjka3Tbv21Cve1CQiifxm/UjRr0xY1qZ41nrDBcU2bDwYEjeo
         yVJntRQMgEDB+ciPZVBRyAANCvhjcWEL0cfRZ96jIsG/1tszYmALGtysHw8XykUblds8
         zmw4eP5IlYbgdIqLOPSylMLXZLnSyMwXqXlIyqAVtYD1D3FI2a5Ilg3CrlP3lnm3Pkbe
         8Vfw==
X-Gm-Message-State: AOJu0Yxvr5b+8TLsNOHWoiAsReFqhCtQOgnOPbGC9avDLjKaWQQeRlp+
	6f8fRgBbIAiOfFaXaxZ1tGxOkaNr0s4Lri5bLD9xdyULPBI1J8ZE4LFln4BAPmWeKhlXR/vjMNF
	YENiwosr6O+0cY4mzfIHQ8rzOggM=
X-Google-Smtp-Source: AGHT+IFXOjwCW+AafnwB/ftXMdyHirGY3mElmBg5v6LoLxsiDQyuQw40emUTCWI49H/uCkjKKp3SixbcDhHmPFbIWlM=
X-Received: by 2002:a2e:9bd3:0:b0:2f3:fd4a:eac6 with SMTP id
 38308e7fff4ca-2f751ee21afmr67682281fa.18.1725895823782; Mon, 09 Sep 2024
 08:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907204941.8006-1-vibhavp@gmail.com>
In-Reply-To: <20240907204941.8006-1-vibhavp@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Sep 2024 11:30:09 -0400
Message-ID: <CABBYNZLVcMqXVXeWf7pSX50yRQNP-NMTUP-u91huuO-kpjU7ZA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] device: Add ConnectionType property.
To: Your Name <vibhavp@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vibhav,

On Sat, Sep 7, 2024 at 4:50=E2=80=AFPM Your Name <vibhavp@gmail.com> wrote:
>
> From: Vibhav Pant <vibhavp@gmail.com>
>
> ---
>  src/device.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 0f18c8c7f..fa149f1d4 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1003,6 +1003,32 @@ static gboolean dev_property_exists_class(const GD=
BusPropertyTable *property,
>         return device->class !=3D 0;
>  }
>
> +static gboolean
> +dev_property_get_connection_type(const GDBusPropertyTable *property,
> +                                DBusMessageIter *iter, void *data)
> +{
> +       struct btd_device *device =3D data;
> +       const char *str;
> +
> +       if (device->le && device->bredr)
> +               str =3D "dual";
> +       else if (device->le)
> +               str =3D "le";
> +       else
> +               str =3D "bredr";
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);
> +       return TRUE;
> +}
> +
> +static gboolean
> +dev_property_exists_connection_type(const GDBusPropertyTable *property,
> +                                   void *data)
> +{
> +       struct btd_device *device =3D data;
> +
> +       return device->bredr || device->le;
> +}
> +
>  static gboolean dev_property_get_class(const GDBusPropertyTable *propert=
y,
>                                         DBusMessageIter *iter, void *data=
)
>  {
> @@ -3234,6 +3260,8 @@ static const GDBusPropertyTable device_properties[]=
 =3D {
>         { "Alias", "s", dev_property_get_alias, dev_property_set_alias },
>         { "Class", "u", dev_property_get_class, NULL,
>                                         dev_property_exists_class },
> +       { "ConnectionType", "s", dev_property_get_connection_type, NULL,
> +                                       dev_property_exists_connection_ty=
pe },

Don't really like where this is going, if we need bearer specific API
like this then we need a whole new interface, besides you didn't
really explain the reason why you needed this, is that to determine if
there are SDP records to be fetched? We could perhaps implement
something like a Bearer property alongside ConnectBearer but many of
the properties of Device are sort of making sense only for one bearer.

>         { "Appearance", "q", dev_property_get_appearance, NULL,
>                                         dev_property_exists_appearance },
>         { "Icon", "s", dev_property_get_icon, NULL,
> --
> 2.46.0
>
>


--=20
Luiz Augusto von Dentz
