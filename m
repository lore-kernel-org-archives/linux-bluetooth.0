Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD2F1F4C8E
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 02:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783737681; cv=pass; b=Sl/vNW+y+RNEBeEBHntAJtawe5Y3Pdo5/TfKgHl/sWdS7Oa5iEsvL7EqR1Ut0Hc4OLTHoIqOm7KIYMFRZ/YduluKUOy8PyPmH1Fxs/RbrcAh0lfmf1Y1A/I7RGTjSbsT0VYFug3RmiatKtC8rZ8ZS70DYU3UqcJrs6Bfd2yJh68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783737681; c=relaxed/simple;
	bh=m+Y9ZE6y6COWI8MmiF8PGxW7tp78hpajwXUXfdwodqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moPtYVJIKYu6jt5Xc+qoeMpm23KulWjwTstSfMo3VDHMEUhol7fp2rFP2RGwed0XJlVakb/2pTZBoYGnlI1kQMQW//socTYUEYzKRaMmBleCiYMxGEx7Oe7S4TgSghnEy5WsWKUliGpfBhShTGFEvA7aNkbiAuAJ8M1O9v9m1Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDEONldU; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDEONldU"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6611669cd16so2262378d50.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 19:41:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783737679; cv=none;
        d=google.com; s=arc-20260327;
        b=jZQ5QwRO+6FzvWhpYWHAoVm9k+gJaZm7CTdqHyUp6sO3k2gCr+7uIZWI7sXMQs3dkE
         Pvsvu+WFsxSDPL33rAgJArkOdM72YGtm5L1QGHO32/1nFq5YN4hFhIRP4nStO/CWIYGX
         X13bQ/6KBr6s8qK0qA9DGoj7dZi8ohWKw//qTTEySVut/ujw9MujAMDObJzRV4wWej8o
         I49Nf902gNnReEmYZU5GHYoETVNHkXVUCfKGHHP9mcWMcE1NDmpHOquDu0Ip2sE9ga7h
         SXfjP+OOWkMQ5CCOOCD1WJH1uNay20D6sxsy2DWXLtUq6RNFR3dZPnb7DWSWRh0lU+Ro
         s1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ve+KgfwCf7WAv7Osnu4Dp5X81+V4g7CuHLm8wADOA7c=;
        fh=ct1BQJJ+RpmIo+wKjaBXhO1JFdwL/1adhR7F7eyOtMg=;
        b=CdPw5/EVYP/CUGpaXSbZL8YUbiatQmEW2zxHHkROyY5gnR/LaZe50KlLu7nBMgxUFC
         sbfEL1fdNE1P8170JRNVG1C893JV3MywbIzhYqNY7tgvQADY+/h4RTCXL2MQYLsr8VxZ
         NTyI2nCDxP+R7Pj+6NN4VgOWDyEvZsptyxPGTI0/tyl8ltxZNqsTpAyWaZ+f5h+K7la4
         LylKfuQ62WgmROSfm6Ww72JUcz28quNpKJnNBHdR+fzcFTZZW42LxqIXv6dLHT3UdMDI
         hJDY3OBQypjgNeWfSAg28ko2lFkXGtraNsBHgbFge5BLnvuBomQW86hqiHoG8dquxIwg
         Xo8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783737679; x=1784342479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ve+KgfwCf7WAv7Osnu4Dp5X81+V4g7CuHLm8wADOA7c=;
        b=LDEONldUNOdpI+H+Wy1X0m1HuXx7pZYMFOFdx36r36k/HiP1wHvkTyOEiPZdAUdSzz
         /7cpwykqMMpJwLYDRGR5h+JZ8MyAKdtqgv2BlpUV1n0wcdy6n/KC1CiG3cE45R7uAGR4
         PS1ikEaJdYNEv6u5mLVAOaHujOnJCOLltkEDmbXEPdfFkqnG2j00PGZBOnO/3TQ1T0K+
         vZcPKPCaGBvTfMAVJjyjtsDWjOlJa/v+NMkUA8p/1wvkC12OyPyihFJhgqjDJJNqh66w
         FDVK7BVLhd+FLLcldd2Z/Fib0WV7Grch5UDi2KuzCJhdmWCW/oqvEGdCSnCmcLZt44hq
         G9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783737679; x=1784342479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ve+KgfwCf7WAv7Osnu4Dp5X81+V4g7CuHLm8wADOA7c=;
        b=NSsiNe1v09aEGzrIIxJmJ29a+SigECsEh5JAgCqG41yrGrJigw5LVQDweDfAnCVNvX
         F6xSCMHFX5Mfu1MretPdhbHpckxt4upWdJnuM01xg6i2WA6GraUYzmBfC3RqM+YQa/pf
         2dwrCi/C3Q2R//HTGv7/jrRJ0LaR77yNtum9M9NzEMZt/19ABeTbt792qDx1eYhOU7zK
         NXm815HQ/b1pBTa2jzvS9Xg2me2HAGmhK2yZhLbwK0dF8kSPxwmsPjOdkDiB5LaiGsum
         rc6MVC7D4j+TAwgKhOJxPjXysC9TrL2yrsPMlRDsXXNC++7+QAYInjkAnyb1fCAJQYAk
         5OWA==
X-Forwarded-Encrypted: i=1; AHgh+RpDJR9SUIu5GUA6n+enNk7SY+aA9hkNjpC6xAE1oUDDgeWx8VPQR/GVxEkoNDaQtWYALbciCu/slNu9NVMpbgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRgo55MpuxlAF+k17cEHSy65iX9O/QN5PK0prgRgWL9nRvasg8
	cMYga3uppolW1Ez2+IIvGsLrz9HizCWfAwk/3vt/4FS5BoHQDG/z7KvF5XM9cBrSh6WsNhc/QV9
	wUQnR8gk0KLOUxJma8sp2UeLZgmXEUK4=
X-Gm-Gg: AfdE7cllE1EWVhSd3idwp2z3OrOpaT5+lHYeIK37KeD+7P463UrSGbIFhrIPY+VAV9N
	l1aBSlNrn7pWVn7Lk607nVxpHaQQ9to6MvK4BiB7PVpS+ZKSFIfFyrMysSnl1a6dltqQsP9bKDD
	LJ1BddjeOvdkxsZ4SB1Myy1DBK3nW6HCG+QfmnBJ8WEs/cClETk5mPgjGKUwdEgipPgSsqhQr3c
	nfuvKAkPcqhggRaTpjynRt2XmtKny0yPbS1oix8lB2t8s+DCs3uDp3GBGe6ty22a+PiwAfB
X-Received: by 2002:a05:690e:43d0:b0:667:b2c3:f047 with SMTP id
 956f58d0204a3-667d7aa0516mr1048576d50.9.1783737678571; Fri, 10 Jul 2026
 19:41:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-btmtk-first-block-bool-v1-1-3602688ec523@gmail.com>
In-Reply-To: <20260710-btmtk-first-block-bool-v1-1-3602688ec523@gmail.com>
From: Miles Krause <mileskrause5200@gmail.com>
Date: Fri, 10 Jul 2026 22:41:07 -0400
X-Gm-Features: AUfX_mzQwDtg2H8ctSQPFDjQKF1EMJLy3qdwid6_YX5jZy6Z9FBBhv1W9Y4YqwM
Message-ID: <CAA6QAMJBJ11YcKKdXxuQ7MZidtta-VAw5EJd-N5_Y-tQDA0FLg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: use bool for first_block
To: mileskrause5200@gmail.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please disregard the duplicate submission. It was sent
unintentionally. I am sorry if I am doing anything wrong. This is one
of my first patches.

On Fri, Jul 10, 2026 at 1:16=E2=80=AFAM Miles Krause via B4 Relay
<devnull+mileskrause5200.gmail.com@kernel.org> wrote:
>
> From: Miles Krause <mileskrause5200@gmail.com>
>
> first_block is reset for each firmware section and is never used outside
> the section loop. Declare it as a bool inside the loop to limit its scope
> and make its two-state purpose explicit.
>
> No functional change.
>
> Signed-off-by: Miles Krause <mileskrause5200@gmail.com>
> ---
> Compile-tested on x86_64 with:
>
>   make O=3Dout allmodconfig
>   make O=3Dout W=3D1 drivers/bluetooth/btmtk.o
>
> Sparse-tested with:
>
>   make O=3Dout-sparse allmodconfig
>   make O=3Dout-sparse C=3D1 CHECK=3Dsparse drivers/bluetooth/btmtk.o
> ---
>  drivers/bluetooth/btmtk.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 809762d64fc6..b809eb82fc73 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -63,7 +63,7 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, con=
st char *fwname,
>         const u8 *fw_ptr;
>         const u8 *fw_bin_ptr;
>         int err, dlen, i, status;
> -       u8 flag, first_block, retry;
> +       u8 flag, retry;
>         u32 section_num, dl_size, section_offset;
>         u8 cmd[64];
>
> @@ -79,7 +79,7 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, con=
st char *fwname,
>         section_num =3D le32_to_cpu(globaldesc->section_num);
>
>         for (i =3D 0; i < section_num; i++) {
> -               first_block =3D 1;
> +               bool first_block =3D true;
>                 fw_ptr =3D fw_bin_ptr;
>                 sectionmap =3D (struct btmtk_section_map *)(fw_ptr + MTK_=
FW_ROM_PATCH_HEADER_SIZE +
>                               MTK_FW_ROM_PATCH_GD_SIZE + MTK_FW_ROM_PATCH=
_SEC_MAP_SIZE * i);
> @@ -132,9 +132,9 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, c=
onst char *fwname,
>
>                         while (dl_size > 0) {
>                                 dlen =3D min_t(int, 250, dl_size);
> -                               if (first_block =3D=3D 1) {
> +                               if (first_block) {
>                                         flag =3D 1;
> -                                       first_block =3D 0;
> +                                       first_block =3D false;
>                                 } else if (dl_size - dlen <=3D 0) {
>                                         flag =3D 3;
>                                 } else {
>
> ---
> base-commit: 64b5c4c8e79c131fe8f135bab5e5dfaa245c5776
> change-id: 20260710-btmtk-first-block-bool-bd047b970821
>
> Best regards,
> --
> Miles Krause <mileskrause5200@gmail.com>
>
>
