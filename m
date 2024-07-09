Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E1F150981
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557238; cv=none; b=kc6xEu4bNwX0JLEFBHHMdIL2QUx2TG+My6qokYdIpjDVR2iHTl0EWnigKR52acQoh6QvFeJs2/94+n/8rsKc9Wxq/78cIrAkKNszal6yliVUXqPk8MjoOS1Rd/ihm9StlUje51xmwWV8lwPGDQeoqGgU9oTiCmo8ILUVW5fGHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557238; c=relaxed/simple;
	bh=OL1WJt5P8XK3wOWC1l1XUG6L7TiOtom60QY9yoLileM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkrtBJMae68+FptBBlFCFXoIjrpBCZfd0X2bSDaThOEBwXz2GkXm93oBqtx0vKjUYxKKRJQtgD07unvLse9SfoFPMN77Bll7PckEpkVfqSIwH3IkuK7H9EFHC3RLFy+IZYhlOEzWI3NDNr0gmmi6vIPKM9UrXyuWQUN4qs/FixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cr/xQH+k; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr/xQH+k"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ee4ae13aabso56522291fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2024 13:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720557235; x=1721162035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvaheOfQKcTUEbWUXRhCIe8SrRk4TyoGsOvVD1RP8gU=;
        b=cr/xQH+knjFu1CoZaMKiqE9f1ldg/u2RjopdW23TXAdzIwJLbx71FbH8NQSiwaZpxx
         OGIlCv3d1PPOmYTYFlB1yxbXsN05TwTj5Aj9vNlVrI4BrNWSgTIlEGxrQPAJzXNgEWl6
         w5RjYHmLuUzqrdMBmxQe9DMCMM12m+6xr+hHvqRWgdxucgtY7Hl2kuPLHrkaZDCVbuHw
         EKKCA8A7NffxGPHbmMYgCnyPSndM7E+moEeagL2EsepNQcCSe8/oZK5IoP2upsWcgSRh
         NeS29CtSVgpMiObuhKNvbtyJw2fP0GgL1B6YDqaIDEaJndEXFgbFm1TJBBDJIbkQFizK
         9G8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720557235; x=1721162035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvaheOfQKcTUEbWUXRhCIe8SrRk4TyoGsOvVD1RP8gU=;
        b=t6SC9XeDk6YD5eiPPLoZKGCSlYHHSrogWpxZx1Ww92acgWRlnBC998JZfXpcdsQswE
         iQsjF8lZ4le6Ekw+PX4Aekeqj3mZkM729zu8q3cPAVfqaKOqsrZ9owDJ0GxvZ7GCamEk
         h/lGbkzL/5YvSyA9xqAMWBaYhprZ4Eu+SfXnPbsWrsUMrNjaenXq+gnlBLwEPZ0WFtao
         muJ0ynwTKm3UhDCW1VJKeLAE/wN0if4RV6MC0YgjgGduB7KIRztuco9W3vVz9f4jfqAR
         Ffl5Yj/rgPM9PvlgfnSIwy5dBn4sGh8WRHONZNqJK6CBTvpy2p/cm1+wgfm1W2eSUs7H
         6C4Q==
X-Gm-Message-State: AOJu0YztDfiQ7FuAaTA0a+dB9JK/1gvgd38gmXnjAk1KpRyxSzyfM6tQ
	P87qkwfFbJAlsCpdk5tDIWCv+w82Jn+3T4lctSpuCJqANPkwGRxpjDe+H1i3Yzlbci4UljeuW5y
	igmJ3AYnqi+/MdwY3GxM5ssIXS0b2mYIi
X-Google-Smtp-Source: AGHT+IFB4+H7R8tAzGpwyg+GusWsCF+eORx4E6zR4RNmdSM/iLdgSSWNDxziWolrnAA82/0goHCbxWov7Dns1+5mzos=
X-Received: by 2002:a2e:9482:0:b0:2ec:56b9:259f with SMTP id
 38308e7fff4ca-2eeb319134dmr22341471fa.48.1720557234841; Tue, 09 Jul 2024
 13:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SN4PR19MB5421B1226EA92B735CADEA44E4C82@SN4PR19MB5421.namprd19.prod.outlook.com>
 <SN4PR19MB54215EF3B4E7380A21387D2EE4DB2@SN4PR19MB5421.namprd19.prod.outlook.com>
In-Reply-To: <SN4PR19MB54215EF3B4E7380A21387D2EE4DB2@SN4PR19MB5421.namprd19.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 9 Jul 2024 16:33:40 -0400
Message-ID: <CABBYNZ+8ca5f6nWG3D3x8mL3g=57Z0pogQP-+ww_aQuC0R1DWw@mail.gmail.com>
Subject: Re: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14) Prepare
 Write req (0x16)
To: "Ramsay, Trey" <Trey.Ramsay@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Trey,

On Tue, Jul 9, 2024 at 1:34=E2=80=AFPM Ramsay, Trey <Trey.Ramsay@dell.com> =
wrote:
>
> Bluez Maintainers,
> Here is a fix for attribute writes not working in src/shared/gatt-db.c. T=
he prep_write_complete_cb was not getting called. The attrib->write_func co=
de block should not be called when len is 0
>
> commit 5a9baa10d4fde7ca8ab88ecd68e17671c33cb587 (HEAD -> gat-db, master)
> Author: Trey_Ramsay <trey_ramsay@dell.com>
> Date:   Fri May 31 15:39:27 2024 -0500
>
>     shared/gatt-db: Prepare Write req error BT_ATT_ERROR_UNLIKELY
>
>     Fixes Prepare Write req error: BT_ATT_ERROR_UNLIKELY
>
>         ATT: Error (0x01)
>           Error: Unlikely error (14)
>           Prepare Write req (0x16) on handle 0x0069
>
>     The prep_write_complete_cb was not getting called
>     The attrib->write_func code block does not need to be called when len=
 is 0

This doesn't sound quite right, 0 length still needs to be passed to
the attribute to confirm since we don't know if it could be a
procedure or not. Can you explain what attribute is being written and
if it could be due to the application not responding and the procedure
timing out (e.g. write_timeout is called?), perhaps if you can paste a
btmon trace as well that could help checking what attribute it is
trying to use prepare write.

> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 2c8e7d31e..678aef4cf 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -2127,6 +2127,10 @@ bool gatt_db_attribute_write(struct gatt_db_attrib=
ute *attrib, uint16_t offset,
>      if (!attrib || (!func && attrib->write_func))
>          return false;
>
> +    /* Nothing to write just skip */
> +    if (len =3D=3D 0)
> +        goto done;
> +
>      if (attrib->write_func) {
>          struct pending_write *p;
>
> @@ -2162,10 +2166,6 @@ bool gatt_db_attribute_write(struct gatt_db_attrib=
ute *attrib, uint16_t offset,
>          return true;
>      }
>
> -    /* Nothing to write just skip */
> -    if (len =3D=3D 0)
> -        goto done;
> -
>      /* For values stored in db allocate on demand */
>      if (!attrib->value || offset >=3D attrib->value_len ||
>                  len > (unsigned) (attrib->value_len - offset)) {
>
>
>
> -----Original Message-----
> From: Ramsay, Trey <Trey.Ramsay@dell.com>
> Sent: Thursday, June 20, 2024 1:58 PM
> To: linux-bluetooth@vger.kernel.org
> Subject: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14) Prepare W=
rite req (0x16)
>
>
> Bluez Maintainers
> Here is a fix for attribute writes not working in src/shared/gatt-db.c
>
> https://urldefense.com/v3/__https://github.com/tramsay/bluez-tramsay/comm=
it/246bc960629dff34e744c728f048e9f50f1a005d__;!!LpKI!jkJYamzU8bOdd1qt-sWpj6=
gy1YwS30UyamHLUJj9Uy0UecrB6QxvCdSWFAUH7Dvq2wVJqu1C5jjoX5amywJH$ [github[.]c=
om]
>
> shared/gatt-db: Prepare Write req error BT_ATT_ERROR_UNLIKELY Fixes Prepa=
re Write req error: BT_ATT_ERROR_UNLIKELY
>
>     ATT: Error (0x01)
>       Error: Unlikely error (14)
>       Prepare Write req (0x16) on handle 0x0069
>
> The prep_write_complete_cb was not getting called The attrib->write_func =
code block should not be called when len is 0
>


--=20
Luiz Augusto von Dentz
