Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794323474;
	b=zRGb+ApVrVjKUYD6W/LHF09xPqMsv4p41lX3cjkGaROWEgpRmALbhADPBZliY3hoWEId
	 bhGoWoQ44i/nlj+Wz6YmepvVs/dMSSodXE3nHzZ5fE3H/7lRJ8duNKBXYZR/TdlV+f5Mx
	 50kQnXZUqsaeEG58B/oFoQsKIs3FCJ8u+Y0qhKBof31MlkNc/iNJHpbU6JSOMuxsmmiwW
	 dVyneOneKLkwqJkIo1uXGrLdOHdDRml07TroGsjRLBp2wgeJESwVZzEVbPhKQ8VcOFafz
	 2WMNXZZq1gXSFn44JhtXG2W/KwnQ/qOhL9OD3ve9jrvZvYTmpm09ZOSqHzQCBts3QSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JfImUIKbgBOvjOPJtdSabfWvasfWg/hSkuUqdlRqigQ=;
	b=2z2sMomDGsPAMf+NjPH+uH13jYEuI2n/BbuWW1bUek7zTeyffcLkNg44O//B9P40bRWF
	 dQ9WFqHy+LG9GMB0O5Y0DzCVBs17VVWSVIbU89T94C9KahT68ElIqMHXldR8xu82B5Be/
	 yWDw8daBN7dWI3F9BEbmpcBUm8V3EDID4fTkQQdFO1fu7bvxjM8yugHnwz/ZmLhGwCYBa
	 B0yrqZWhjeFYx5DMrjAnhe9Qa6S/CCwSu/gxuKe2QkjzGytTKfTjCi5D8IsuEXJHJiVlQ
	 Z+UdIhrrqVf/Whwuh7nDA52QhmXYQXbuiiUK8bP9xw1uieDI/9ONUQNfZX8WeLZ/TnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BEkxyspm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A5606A339
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 15:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 348A5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BEkxyspm
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b32daac9d7so16613917b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 07:11:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794323473; cv=none;
        d=google.com; s=arc-20260327;
        b=jxwgZlT1QXi/LjBOQA8FHtkBfXySRCIQixzMV0ci7QGSqb1MJw/FaRQafokopSVe4Q
         cWp+K7RD6c8yhyU/lxksjhAcKsUL7J0yy+FWFuq3IJqTovCE9wUgbbtqegvgWxlt1gGO
         ykMVr7kH2jr0eCLubf/MlVw3G8W9g77Ra/e3DJIJszJdlDLcFEFwch41VDj6diiPwXMU
         /HlAbUk55rA25BXFyrgwf1J4wgHmp5pYN0E8IoN1C+IDRp7Qo55SMj7dxKenM5hAlpxh
         H1aGjS+HXgUhzxCwWYvFgG0KFRyNuR2vBBuXZN07uNRI29hXvtHOShqqbfVufPutI3vG
         v5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JfImUIKbgBOvjOPJtdSabfWvasfWg/hSkuUqdlRqigQ=;
        fh=G1GLFTTJWoXVbkB4H7LKEhxoOx4uevt0MqVYtjFKmbQ=;
        b=qnvmx85Chv2mTb5UwSmaTZAieLtcJQltuAAbIvUi2jn4foXw4aAdMbavyYCuvFIcFE
         Vl6kXk73aIpr4vn5TIK/PBdYG/GcZRlMvscFpD0BLu5167cVO0nE9+/Jauh9nMAtrueA
         AWGtdL2no0+cFKZO0XqwoGlAcowzSqyAKNVllFBGX0VLvLWNAaF3lIvbR71npXlf5MFu
         qKYBqhP00HBUo0QV3ZF/X+CusCTKxbipvCj1HVx2ZQddMSooBe2+h9GJr/TVXg8sSXm+
         HazJaTlXFGftYCunkJnoW0i9iK22GJcPgYY/+o7AIEAWp+xI67+ptcsz9t0YHCtKBGUo
         MBMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323473; x=1794928273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JfImUIKbgBOvjOPJtdSabfWvasfWg/hSkuUqdlRqigQ=;
        b=BEkxyspmKNnBwgGD1le3LUrb6O7S9br2n9OnXxyeKH4vPKd6lDXl68kyuhSP5MbCvr
         6c4sPDhrHcgdHDrzs1BeIRwb4segvJ/I+JsnVuU5ZJgf8sRlb6eTp4TF0zerTYF1p1jg
         5OATx40g9K7KyUGFdH/8f4VJy0RUNptqnMTXwJ2eriPsp3/1FTTyj6DPRM2l5QkFJ28u
         4l89PKqrvLF4M/WoBpDrvpg+mzrCJaaqZaugKTzpSlPSF2Bg/Uz3dyqGvZNGI8VjZeeO
         x7v7Mu5eQUqGM261FojIPuwuss6/0nK78r8diDzbN1eVDnAoSBGXSpbE302W28Jtt3gl
         suVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323473; x=1794928273;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JfImUIKbgBOvjOPJtdSabfWvasfWg/hSkuUqdlRqigQ=;
        b=0zyU7ApyYR/KZtkWSLvx9LeFIX9k9Xf+mSp+qPGJvyfhRMVQbeBxN4PePsL38gUf10
         2maTb9vQbPwrwk9ncJW6LpeWaIsF+t9MzSN/mo/EFCCVQlO0LC92sV33sFzCEn3ws9xR
         GRsSff2HIUcp8iDhhbgJrI1SzvIhehUm+yzX1YdbX6HU00pBEMSWlYPfD8qdLG6RfaDx
         mImeQxjeK9h7y5VdzM2THzzz+EmOJyEIGCL4oLsz423b6v2aYaQg/zTe9dKL5hNyJesf
         199Heo7to0wUd6TjbnC4wtvwzgx0JfisUeKYE4WeifXkS/2mA5DJdp7ko28IjDAWG8MO
         7ZFg==
X-Forwarded-Encrypted: i=1; AL+hErHDloJ8c3oqqkJKKVcFXTm6QRn+ZaWb/6WgD65L/sbBFZVvHgZLqyDfrpK957nOfMevZKkkQnLpZCffdVDQLCQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kwvuLI1+76C7qz/3Kp7hDRvrmeV0ApOgiTl5hePHx3riTy3uv
	3bRsyN4TwreRoOYdvmOAy8zMj3rOHKQSog+IO85LU03qeZ3vW15nuT+dRXPAlKY77rXjqE6vQlT
	9w4SU2EYLSq5yatZfl7XwNPSg2HmIsh0=
X-Gm-Gg: AYBFou2QRa5oFOVtc5pnFvNtOTPxaGvXjEIPQbpEgwbtit0yFLj8VjDq/86Xjmeuznp
	wKneSKqR+ze+CcIIENMOFiY7i5WFE1GQCsQdNlI4EkiPh7Pt40uVLJZDzgRwomBj6JAmI1IDODf
	+SojGXGPg5TiNiWjM6LeUXW+tUUghmuhTbiY2KbsH87BV6GNUOlVz/tWgQJeiGDXSwmeFoEMO1s
	g3lXgnaW0bieFmqJbdet+aAm1n2kZAgve/MC0LxDddWYjiRoqK0WKuFUGIKaOk+kFEyVuvNHsPs
	Se8FtBQXbxN/Ed65Oq79Td6INpuet/Za7mTLyJYrB95cFb5MeTS1jmvqlGJ0KrmWMb3mZQUy6WK
	XmUCR24SfT7/qLxLQAbcNCnSisIQNwjfsJtqrbQqvrDp9UB5P2bWDM8ER2lPFBx25rnpicKXWLq
	TuKMZh+di4qKZV3AY7LpbR4xLf1KDrpqdWYv9PZLGPRZHstXPuj1OAajUQ
X-Received: by 2002:a05:690c:f8f:b0:8b0:cd32:b8dd with SMTP id
 00721157ae682-8b392630812mr20533077b3.17.1794323473171; Tue, 10 Nov 2026
 07:11:13 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CADq=QSxw-5LstC5McTqfsp9NaVrsUcemepw2g_TJXNrdpgFdRQ@mail.gmail.com>
In-Reply-To: <CADq=QSxw-5LstC5McTqfsp9NaVrsUcemepw2g_TJXNrdpgFdRQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Nov 2026 10:11:00 -0500
X-Gm-Features: AclHuK_GUiwCVuUhAn-ajDH8D9wFR1ipOXSYvJeuudI1cZ9x_iMQK-rERRc69EA
Message-ID: <CABBYNZJ2zD42-szQ5KWExOVkSLPmO8AH-FNyO2Eq3V4bfSrVxg@mail.gmail.com>
Subject: Re: [BUG] Bluetooth: stack out-of-bounds write in eir_create_adv_data()
 and eir_create_scan_rsp() when a controller stops reporting LE Extended
 Advertising (seen on 7.3.1)
To: Piyus Kedia <piyus@iiitd.ac.in>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kapil Vaswani <kapil@presceralabs.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Piyus,

On Mon, Nov 9, 2026 at 11:57=E2=80=AFPM Piyus Kedia <piyus@iiitd.ac.in> wro=
te:
> diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
>
> --- a/net/bluetooth/eir.c
>
> +++ b/net/bluetooth/eir.c
>
> @@ -300,6 +300,16 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8 inst=
ance, u8 *ptr, u8 size)
>
>
>
>  skip_flags:
>
>      if (adv) {
>
> +        /* The instance's length was validated against max_adv_len()
>
> +         * when it was set, and max_adv_len() depends on a controller
>
> +         * capability that is re-read on every bring-up - so by now it
>
> +         * can be larger than the caller's buffer. Refuse rather than
>
> +         * overflow; a truncated AD structure would not be parseable
>
> +         * by a peer anyway.
>
> +         */
>
> +        if (ad_len + adv->adv_data_len > size)
>
> +            return 0;
>
> +

We probably need to unregister the advertising instances if the
controller changes its max size.

>          memcpy(ptr, adv->adv_data, adv->adv_data_len);
>
>          ad_len +=3D adv->adv_data_len;
>
>          ptr +=3D adv->adv_data_len;
>
> @@ -342,7 +352,7 @@ static u8 create_default_scan_rsp(struct hci_dev *hde=
v, u8 *ptr)
>
>      return eir_append_local_name(hdev, ptr, scan_rsp_len);
>
>  }
>
>
>
> -u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr)
>
> +u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 si=
ze)
>
>  {
>
>      struct adv_info *adv;
>
>      u8 scan_rsp_len =3D 0;
>
> @@ -357,6 +367,10 @@ u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 inst=
ance, u8 *ptr)
>
>      if ((adv->flags & MGMT_ADV_FLAG_APPEARANCE) && hdev->appearance)
>
>          scan_rsp_len =3D eir_append_appearance(hdev, ptr, scan_rsp_len);
>
>
>
> +    /* See the matching check in eir_create_adv_data(). */
>
> +    if (scan_rsp_len + adv->scan_rsp_len > size)
>
> +        return 0;
>
> +
>
>      memcpy(&ptr[scan_rsp_len], adv->scan_rsp_data, adv->scan_rsp_len);
>
>
>
>      scan_rsp_len +=3D adv->scan_rsp_len;
>
> diff --git a/net/bluetooth/eir.h b/net/bluetooth/eir.h
>
> --- a/net/bluetooth/eir.h
>
> +++ b/net/bluetooth/eir.h
>
> @@ -10,7 +10,7 @@
>
>  void eir_create(struct hci_dev *hdev, u8 *data);
>
>
>
>  u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 si=
ze);
>
> -u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr);
>
> +u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 si=
ze);
>
>  u8 eir_create_per_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr);
>
>
>
>  u8 eir_append_local_name(struct hci_dev *hdev, u8 *eir, u8 ad_len);
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>
> --- a/net/bluetooth/hci_sync.c
>
> +++ b/net/bluetooth/hci_sync.c
>
> @@ -1563,7 +1563,8 @@ static int hci_set_ext_scan_rsp_data_sync(struct hc=
i_dev *hdev, u8 instance)
>
>          }
>
>      }
>
>
>
> -    len =3D eir_create_scan_rsp(hdev, instance, pdu->data);
>
> +    len =3D eir_create_scan_rsp(hdev, instance, pdu->data,
>
> +                  HCI_MAX_EXT_AD_LENGTH);

Ditto

>
>
>      pdu->handle =3D adv ? adv->handle : instance;
>
>      pdu->length =3D len;
>
> @@ -1609,7 +1610,7 @@ static int __hci_set_scan_rsp_data_sync(struct hci_=
dev *hdev, u8 instance)
>
>      if (instance)
>
>          hci_dev_lock(hdev);
>
>
>
> -    len =3D eir_create_scan_rsp(hdev, instance, cp.data);
>
> +    len =3D eir_create_scan_rsp(hdev, instance, cp.data, sizeof(cp.data)=
);

Ditto.

>
>
>      if (instance)
>
>          hci_dev_unlock(hdev);

Next time, send it as a proper patch, so CI can pick it up and Sashiko
can analyze the changes. Also, and also address the claims about it
being material to security@kernel.org don't hold anymore since you
just published it to linux-bluetooth.
