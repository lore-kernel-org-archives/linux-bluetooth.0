Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA01FC08
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680634; cv=none; b=t3SQhGeA7VL+KbqvvlTpkzMe+tC2fxmlH9kKOUciJy23BIpZTrCVQ8f8vm0Y3isgJWrGlZYmZyQQj5C9z+dHj85ABWk0+dv7+GZT3dtkNZFBKRlr+1SUomrwuyKeSowMosgfL58ai6iPzxuzrj6uDDdP6Fx+ZEay32MlyXZYjOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680634; c=relaxed/simple;
	bh=dyx5ge/O8wuEWdgr6fAgf4XZBlyAXn6JNB0paW5mBhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gao2RA/amIrgYPEd5jAPvzTnXqoSrs2Cek4qs7eXwLqeVj2af6h2uAMoiJe9IQI1ml8n38hj9/Fmc8v1RuwsUIweak0ZvoOwOABSAVHqHewTGkiyI2T++7U/kkopHClqxJRd8T7Q/mNm8tFd22VyxJKxZCenRt/qb/rC3REwV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTVy9F2p; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTVy9F2p"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f3cb747fafso45216561fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724680630; x=1725285430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/k03tGNaYfk6Re/GvIHKEFJUgoMBYxCmQyq7/yoqts=;
        b=KTVy9F2pBBFJRqPbygdeWN9y9Nty0dBMlAQSQCOWVzoiME32IFwhQGWw1SoxZuSI5F
         io2X48osBft7eLzrwECwVMItCbX5JtoixsOohym14Exoq7FZHqevsynBdaIKLH5sjejd
         GW6sM5eb/bXg4E5oQKWzbKhSdddTqiNnhNVYiwPCeKz7yxZXVkDEvY3xMOG0PUHFxsPv
         eNNxGQ+2pBfs/dDQPm1VwKb1LF3TS6xQkllXW5uSwUWh/NA04j78naOaEm3cuwAaMNBV
         Mdw0hY2qbbFjQG9kA+uMQ+MnKdVqx/8Qp9vQuZdjrCyfINRpr5uaNDY7z0EBc9iXp2tP
         G5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680630; x=1725285430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/k03tGNaYfk6Re/GvIHKEFJUgoMBYxCmQyq7/yoqts=;
        b=F4c3pSyrk9TtsVZPJPORllAitEHcY3bTy7ZlZ6ZW/Qctc9FctW1NcvyMVh4Pn5+MZg
         5LgdSWZ4fixgI60g6MQWsdlxrTCq9+A9jcddbP+Us/KtHs0RWJVzyvoz+xJAQlk/vrwH
         OdSy2qOsBfSRnK7L9+1ww3XFfNQa1Fo7Ba7bTJyot8BEss8EKh8UZ+oeGP8sH0rh/Jzf
         s6TWp3/jkH8wkPf02I/ube2URf/8fhct6ShmuRi1asJq0Uz3/04JCZVohNY+3u4uHriB
         Dj/uN9n1/K5F6Qx+Qw88h1eRaxbclcuHVMQzSU0abuN/cOyFjAAes1lxdKHF85+3mvRQ
         p7fw==
X-Gm-Message-State: AOJu0YwWDCQlSrEiCd0c2qcM2atcqco2iVVK4PqLEtgvHTbHhK3W4F0a
	SgS8OeJHmQ1mYsrqP3cm2CXa0OKOgjOXgLgeNrwxavxzmqsZf87qw6epKcpIwGdsGv3ljgVgOlV
	vgrvmSy/wa1K8x405t5oKtZwwgHDkSw==
X-Google-Smtp-Source: AGHT+IFLw7JKEcrNPaOc/1a0m7RCaRWzbO6rwR+zAOK1+2rhnw6SqjjUtfvJPTfnh6GQ98SEjxQwP9vpMyBEB3DK6Y0=
X-Received: by 2002:a2e:be03:0:b0:2f0:1d51:a8fa with SMTP id
 38308e7fff4ca-2f4f4938743mr66222611fa.30.1724680629644; Mon, 26 Aug 2024
 06:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826070438.557107-1-quic_chejiang@quicinc.com>
In-Reply-To: <20240826070438.557107-1-quic_chejiang@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 26 Aug 2024 09:56:56 -0400
Message-ID: <CABBYNZL5A5SoDrthoyvwuauEnnyOzebHgtkqwptcHZ1em=dAjg@mail.gmail.com>
Subject: Re: [PATCH v1] adapter: Manage device state of cross-transport SMP keys
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cheng,

On Mon, Aug 26, 2024 at 3:05=E2=80=AFAM Cheng Jiang <quic_chejiang@quicinc.=
com> wrote:
>
> Cross-transport derived ltk/csrk/irk are reported to bluetoothd from
> kernel with BR/EDR address type, and bluetoothd doesn't treat it as LE
> paired/bonded. In this case, bluetoothd won't send remove bond operation
> with LE address type to kernel when executing unpair, so SMP keys are
> retained in kernel list. Then RPA is getting resolved since we still
> have irk which was not deleted when unpair device is done because only
> link key is deleted since addr type is bredr.
>
> What=E2=80=99s more, pair LE of the same address will always fail in kern=
el
> for ltk existence, and send back AlreadyExists error, but device state
> is still unpaired/unbonded in bluetoothd.
>
> So bluetoothd needs to consider LE paired/bonded when receiving SMP keys
> even if they are cross-transport derived.
> ---
>  src/adapter.c | 53 ++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 40 insertions(+), 13 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 245de4456..4e5af9579 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -8647,6 +8647,7 @@ static void new_link_key_callback(uint16_t index, u=
int16_t length,
>         struct btd_adapter *adapter =3D user_data;
>         struct btd_device *device;
>         char dst[18];
> +       uint8_t addr_type;
>
>         if (length < sizeof(*ev)) {
>                 btd_error(adapter->dev_id, "Too small new link key event"=
);
> @@ -8666,7 +8667,13 @@ static void new_link_key_callback(uint16_t index, =
uint16_t length,
>                 return;
>         }
>
> -       device =3D btd_adapter_get_device(adapter, &addr->bdaddr, addr->t=
ype);
> +       /*
> +        * For LE public address, key here is cross-transport derived,
> +        * so consider it as BR/EDR public address.
> +        *
> +        */
> +       addr_type =3D addr->type =3D=3D BDADDR_LE_PUBLIC ? BDADDR_BREDR :=
 addr->type;
> +       device =3D btd_adapter_get_device(adapter, &addr->bdaddr, addr_ty=
pe);
>         if (!device) {
>                 btd_error(adapter->dev_id,
>                                 "Unable to get device object for %s", dst=
);
> @@ -8682,7 +8689,7 @@ static void new_link_key_callback(uint16_t index, u=
int16_t length,
>                 device_set_bonded(device, BDADDR_BREDR);
>         }
>
> -       bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
> +       bonding_complete(adapter, &addr->bdaddr, addr_type, 0);
>  }
>
>  static void store_ltk_group(struct btd_adapter *adapter, const bdaddr_t =
*peer,
> @@ -8773,6 +8780,7 @@ static void new_long_term_key_callback(uint16_t ind=
ex, uint16_t length,
>         struct btd_device *device;
>         bool persistent;
>         char dst[18];
> +       uint8_t addr_type;
>
>         if (length < sizeof(*ev)) {
>                 btd_error(adapter->dev_id, "Too small long term key event=
");
> @@ -8784,7 +8792,13 @@ static void new_long_term_key_callback(uint16_t in=
dex, uint16_t length,
>         DBG("hci%u new LTK for %s type %u enc_size %u",
>                 adapter->dev_id, dst, ev->key.type, ev->key.enc_size);
>
> -       device =3D btd_adapter_get_device(adapter, &addr->bdaddr, addr->t=
ype);
> +       /*
> +        * For BR/EDR public address, key here is cross-transport derived=
,
> +        * so consider it as LE public address for SMP.
> +        *
> +        */

This is only the case if, an only if, the device is a dual-mode
device, so this probably need to be checked that we don't attempt to
do this regardless.

> +       addr_type =3D addr->type =3D=3D BDADDR_BREDR ? BDADDR_LE_PUBLIC :=
 addr->type;
> +       device =3D btd_adapter_get_device(adapter, &addr->bdaddr, addr_ty=
pe);
>         if (!device) {
>                 btd_error(adapter->dev_id,
>                                 "Unable to get device object for %s", dst=
);
> @@ -8802,8 +8816,7 @@ static void new_long_term_key_callback(uint16_t ind=
ex, uint16_t length,
>          * be persistently stored.
>          *
>          */
> -       if (addr->type =3D=3D BDADDR_LE_RANDOM &&
> -                               (addr->bdaddr.b[5] & 0xc0) !=3D 0xc0)
> +       if (addr_type =3D=3D BDADDR_LE_RANDOM && (addr->bdaddr.b[5] & 0xc=
0) !=3D 0xc0)
>                 persistent =3D false;
>         else
>                 persistent =3D !!ev->store_hint;
> @@ -8817,15 +8830,15 @@ static void new_long_term_key_callback(uint16_t i=
ndex, uint16_t length,
>                 rand =3D le64_to_cpu(key->rand);
>
>                 store_longtermkey(adapter, &key->addr.bdaddr,
> -                                       key->addr.type, key->val, key->ce=
ntral,
> +                                       addr_type, key->val, key->central=
,
>                                         key->type, key->enc_size, ediv, r=
and);
>
> -               device_set_bonded(device, addr->type);
> +               device_set_bonded(device, addr_type);
>         }
>
>         device_set_ltk(device, ev->key.val, ev->key.central, ev->key.enc_=
size);
>
> -       bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
> +       bonding_complete(adapter, &addr->bdaddr, addr_type, 0);
>  }
>
>  static void new_csrk_callback(uint16_t index, uint16_t length,
> @@ -8837,6 +8850,7 @@ static void new_csrk_callback(uint16_t index, uint1=
6_t length,
>         struct btd_adapter *adapter =3D user_data;
>         struct btd_device *device;
>         char dst[18];
> +       uint8_t addr_type;
>
>         if (length < sizeof(*ev)) {
>                 btd_error(adapter->dev_id, "Too small CSRK event");
> @@ -8848,7 +8862,13 @@ static void new_csrk_callback(uint16_t index, uint=
16_t length,
>         DBG("hci%u new CSRK for %s type %u", adapter->dev_id, dst,
>                                                                 ev->key.t=
ype);
>
> -       device =3D btd_adapter_get_device(adapter, &addr->bdaddr, addr->t=
ype);
> +       /*
> +        * For BR/EDR public address, key here is cross-transport derived=
,
> +        * so consider it as LE public address for SMP.
> +        *
> +        */
> +       addr_type =3D addr->type =3D=3D BDADDR_BREDR ? BDADDR_LE_PUBLIC :=
 addr->type;

Ditto.

> +       device =3D btd_adapter_get_device(adapter, &addr->bdaddr, addr_ty=
pe);
>         if (!device) {
>                 btd_error(adapter->dev_id,
>                                 "Unable to get device object for %s", dst=
);
> @@ -8911,6 +8931,7 @@ static void new_irk_callback(uint16_t index, uint16=
_t length,
>         struct btd_device *device, *duplicate;
>         bool persistent;
>         char dst[18], rpa[18];
> +       uint8_t addr_type;
>
>         if (length < sizeof(*ev)) {
>                 btd_error(adapter->dev_id, "Too small New IRK event");
> @@ -8922,16 +8943,22 @@ static void new_irk_callback(uint16_t index, uint=
16_t length,
>
>         DBG("hci%u new IRK for %s RPA %s", adapter->dev_id, dst, rpa);
>
> +       /*
> +        * For BR/EDR public address, key here is cross-transport derived=
,
> +        * so consider it as LE public address for SMP.
> +        *
> +        */
> +       addr_type =3D addr->type =3D=3D BDADDR_BREDR ? BDADDR_LE_PUBLIC :=
 addr->type;

Ditto.

>         if (bacmp(&ev->rpa, BDADDR_ANY)) {
>                 device =3D btd_adapter_get_device(adapter, &ev->rpa,
>                                                         BDADDR_LE_RANDOM)=
;
>                 duplicate =3D btd_adapter_find_device(adapter, &addr->bda=
ddr,
> -                                                               addr->typ=
e);
> +                                                               addr_type=
);
>                 if (duplicate =3D=3D device)
>                         duplicate =3D NULL;
>         } else {
>                 device =3D btd_adapter_get_device(adapter, &addr->bdaddr,
> -                                                               addr->typ=
e);
> +                                                               addr_type=
);
>                 duplicate =3D NULL;
>         }
>
> @@ -8941,7 +8968,7 @@ static void new_irk_callback(uint16_t index, uint16=
_t length,
>                 return;
>         }
>
> -       device_update_addr(device, &addr->bdaddr, addr->type);
> +       device_update_addr(device, &addr->bdaddr, addr_type);
>
>         if (duplicate)
>                 device_merge_duplicate(device, duplicate);
> @@ -8950,7 +8977,7 @@ static void new_irk_callback(uint16_t index, uint16=
_t length,
>         if (!persistent)
>                 return;
>
> -       store_irk(adapter, &addr->bdaddr, addr->type, irk->val);
> +       store_irk(adapter, &addr->bdaddr, addr_type, irk->val);
>
>         btd_device_set_temporary(device, false);
>  }
> --
> 2.25.1
>
>


--=20
Luiz Augusto von Dentz
