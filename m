Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0848C8B4
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921313; cv=pass; b=lZM7ZQZ+YfAyhPnrgzYXBCBaG6c4A7htDzp1oe+dbB/rUkFjcHL7tF9QV1sPL5mTeS3W46rCtoltEJinMDy/XZcbEAC1V01msG2WS1RphVDOfi7ztSpzcBuAHILpezPkDVX/PGQnuwNHzKrOM/ErHIQtOQ5yI37X+azIip1pIjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921313; c=relaxed/simple;
	bh=sCLJX+qJhodReDkoeJC9g/BGwOIq04v1mlFoZc/q2Fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLbC5bPpkb3lU233HOTKJjkgZbRIGSJG2GVnWyoQO7Enot7aP1HBEMOo+1n3ZfZ49q6uuqv3uC1tLn0TOdLmm1lETxeinMxEw65Vdef7IhRP5/qkWwzVhNMNq48gv+fQv4eofaEga6x0XIBwLTS0KhDY+L23Nz4wU2q/2+I0ubU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dilW1tyL; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dilW1tyL"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664d4478a64so930604d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 08:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782921312; cv=none;
        d=google.com; s=arc-20260327;
        b=aIFcczHoEBE41Ai1MlSzHsetodEUcVmiFn8ZyICx2FXnNU1a11JY/foiMlHnlIAqtb
         v5XluBDGs8LEzvAvKevTDkvuITVa2dFx8O1kLfuvcZZUWaScachBpokuufWLBfAkW/wU
         wvy5p1WIKE9dt4szVvuU8EJjnU0NdeamGJJ6c8HOekkZsuHMQiEPmjQkI1Zfuy1RgMRG
         GzxuWeefJvsg1quftD5OhGfHFKxoA7cKAmtGxv1mfY62yzdNTb3C1PpJlSVqD0dMHOyA
         Fgci2Us9Dcb+wxBv32JPdp2zIXW5KsdZ6SKEGCsL5yHwfqz6Fb8D9AbX6TXKTvzK+mJa
         DVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PXa34OubSbzCty4qUjMoYcxwd7ic9Igd3aMKODlP5w8=;
        fh=7EusqFjU2qR1aJIjDDEnD8/d1p2pzFNweE1ZlKVoa9I=;
        b=jaVXZ9OLXy281mAK+3Roxq0Ijnm/6MTcOVXI5szgV4dF0ofQpV5CEQ/bA/+Zy2qezh
         NCpQ2vRone0iQ0eid/+RJ5l+wuzPS67K9m3ewmBB6xpzsdbBXeJOqFJG27r6C27n0rtw
         xFfZ2bpeXZk63F7F4OHXYURnOegmM8/jnjXya7OFptKrZ5oqvU7V18R5lMR5CKP5zw3C
         h+Cl0JSg3xG9524VH6LK0RYG748OZG+n3kehTQAwy+NT03VeowZoO61hPLwkQaEVLm7I
         iU75E6kx60AxLt5lRJGNRF8raU1W70Fd+9VpMTQfNeAc1ODc71pKg4kt2C/RmlXCIwHt
         p4qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782921312; x=1783526112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXa34OubSbzCty4qUjMoYcxwd7ic9Igd3aMKODlP5w8=;
        b=dilW1tyLJ2LdsF2h5Lbc3U1Dbh1vuNGbUteWZH8lVQGBJBQmB3/c8pc1vS1QtzeOfJ
         WZJPB/ITWiJj3AN8vVn6+pS31K2RiV9YoEjpgGcKE35EAT9KWjvQGcIFzV/Q+lApuYZW
         F3F0tCbqcosnt+6ReXgjXPSfgrZtqI8x7wa0ubrkznRx23JW+22mnItr3fxHjr6AYj3l
         1xMdxn8bFyMQFuvXgiKZCu96nvH3wKP97qLhtg8pjlgUpq/N9pzFYkjsP+JyRzKlKUdh
         qHM9FLdnx8dXJSqbPz3f3EfeSkWtq8Po5DscRpYNTYivUsM7CfAspywKwnh+gO7JFURe
         3ysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921312; x=1783526112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PXa34OubSbzCty4qUjMoYcxwd7ic9Igd3aMKODlP5w8=;
        b=HVDETceYF5ytJdpx/H8Zb1TRI/K2Ds7AzNNJlrD9uM9Tz+q9OR/7pBbuGCQEYwvnnn
         OAQnX30W/68ISlow4kxM+Hvw3CJu4ikHGhc/Xppmtstdi2ElIU+G6yWRfOb6VG3jOAom
         228WC5xjwKQn/znxMHHxAZL6umlERypjuIp6AAGHWt0md1SsxOl4dWtMs2wvyPs3jJ2s
         1L7Z9C6I13mqXzk1oB6G7ieCCk9N8w4yZ/3Q2BTbvz2LDc5xov/wyoJPA47j6vS47D0d
         BaIXebLTQeSzBtN4QJfnHiNA8cA7V6HX5BljPzLI9r1SHYeQmcAi1qWRbq4IUQ+3OJRI
         J8eQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJWGLneXUL45IlZqkOj5oghTdBEfv3okv2abWBSC55hUDFRADh36G8paSsNkMgAn8vcbgRt/DydheVxdO2AE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyongLR8qVQGpJp5OMWic8KujXJ8S+JJ4z5C3BrgTAPU2EpAETe
	ryPQJ3ckCDzgkyg6meQqCllncGLD0Kmc3ZTUqupxe+laAvAGZ6/16mQL44q6vp0tTQspvLQYw/I
	ypo3NAq7LYQmiEles0/gD1liNg7BkSvo=
X-Gm-Gg: AfdE7cmAJO8YADE2/6lZ79CaIQMG0amNvRhXENECgmTMFrdnH5BNDU7YfgO4ANk4agc
	RS3HdNz3KB68wwBbWsnIEt51Rtp0Jeip6QjZveVSw9q8cM5tTY60f7YZ1oVl0SW7K1etTUjnGt9
	ETkW17ioJNk1/ol8N6WxzieUS2m6O8rrQQ2FONklPzy/4B1vmOcdwawBsOxcvoK2uGB2ijcKrxU
	+aascL2F7IQ+QMi2aAKiFxb34o9jbmw/ZQRPIgI2bQGEKnw+3kcMgVj45ulPRxhQN9IjJLh2/o3
	4sdXvs9rCY0dC52XPRACChj657fjJIih+t7w9qGNxdga4pSA/HMHNnLZbG3LSzyB3II=
X-Received: by 2002:a05:690e:1449:b0:664:c053:d6a2 with SMTP id
 956f58d0204a3-66521a0acd3mr2114483d50.23.1782921311536; Wed, 01 Jul 2026
 08:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701121345.1231906-1-chris.lu@mediatek.com> <20260701121345.1231906-2-chris.lu@mediatek.com>
In-Reply-To: <20260701121345.1231906-2-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 1 Jul 2026 11:55:00 -0400
X-Gm-Features: AVVi8Cc0zrlvMcYjXiLQwVVmWaxkK7Jt0w4udvPGfPhOH5l9CxGEp5ydFE3Z1pA
Message-ID: <CABBYNZKOD8xFk2PVcKAqB=wYnhtSyDOiUTaXSOkumMF5o-dwxg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] Bluetooth: btmtk: Replace magic numbers with WMT
 packet flag enum
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>, 
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>, Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Wed, Jul 1, 2026 at 8:13=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wro=
te:
>
> Add BTMTK_WMT_PKT_* enum to represent WMT download packet sequence flags,
> improving code readability. Replace magic numbers (1, 2, 3) in
> btmtk_setup_firmware_79xx() and btmtk_setup_firmware() with descriptive
> enum values:
>
> - BTMTK_WMT_PKT_START (1): First packet of a sequence
> - BTMTK_WMT_PKT_CONTINUE (2): Continuation packet
> - BTMTK_WMT_PKT_END (3): Final packet of a sequence
>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Assisted-by: Claude:Sonnet-4.5
> ---
>  drivers/bluetooth/btmtk.c | 12 ++++++------
>  drivers/bluetooth/btmtk.h |  6 ++++++
>  2 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 02a96342e964..40c2a64aa6b7 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -230,12 +230,12 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev,=
 const char *fwname,
>                         while (dl_size > 0) {
>                                 dlen =3D min_t(int, 250, dl_size);
>                                 if (first_block =3D=3D 1) {
> -                                       flag =3D 1;
> +                                       flag =3D BTMTK_WMT_PKT_START;
>                                         first_block =3D 0;
>                                 } else if (dl_size - dlen <=3D 0) {
> -                                       flag =3D 3;
> +                                       flag =3D BTMTK_WMT_PKT_END;
>                                 } else {
> -                                       flag =3D 2;
> +                                       flag =3D BTMTK_WMT_PKT_CONTINUE;
>                                 }
>
>                                 wmt_params.flag =3D flag;
> @@ -314,7 +314,7 @@ int btmtk_setup_firmware(struct hci_dev *hdev, const =
char *fwname,
>
>         fw_size -=3D 30;
>         fw_ptr +=3D 30;
> -       flag =3D 1;
> +       flag =3D BTMTK_WMT_PKT_START;
>
>         wmt_params.op =3D BTMTK_WMT_PATCH_DWNLD;
>         wmt_params.status =3D NULL;
> @@ -324,9 +324,9 @@ int btmtk_setup_firmware(struct hci_dev *hdev, const =
char *fwname,
>
>                 /* Tell device the position in sequence */
>                 if (fw_size - dlen <=3D 0)
> -                       flag =3D 3;
> +                       flag =3D BTMTK_WMT_PKT_END;
>                 else if (fw_size < fw->size - 30)
> -                       flag =3D 2;
> +                       flag =3D BTMTK_WMT_PKT_CONTINUE;
>
>                 wmt_params.flag =3D flag;
>                 wmt_params.dlen =3D dlen;
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index c83c24897c95..51c18dde0a80 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -66,6 +66,12 @@ enum {
>         BTMTK_WMT_ON_PROGRESS,
>  };
>
> +enum {
> +       BTMTK_WMT_PKT_START =3D 1,
> +       BTMTK_WMT_PKT_CONTINUE =3D 2,
> +       BTMTK_WMT_PKT_END =3D 3,
> +};
> +
>  struct btmtk_wmt_hdr {
>         u8      dir;
>         u8      op;
> --
> 2.45.2

Ones last issue regarding SDIO from sashiko:

https://sashiko.dev/#/patchset/20260701121345.1231906-1-chris.lu%40mediatek=
.com

--=20
Luiz Augusto von Dentz
