Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C138398
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Mar 2024 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678571; cv=none; b=WhzMCJnn/LXINFTai7bF3+DSPKOyewXw2lNz1ofd5IONJ2x8xb9DWOlTbra7N792hhwu7CFiTcBNT2znhuDSJqcMWilWlPHAHi5tEUhO5WOrkqe4UsmZTyuGZb/9cQQxzYoBw48LTxcuqxrNTKYv7jHHmLrhoDRlm4+ufFNChzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678571; c=relaxed/simple;
	bh=x8YvIA2ouzeXAIz3vvelSg9xfh8qMnjXW9JcwOyNZMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7UogQy9DhsFW3DeLWCbQagG3ycOxO7nDqMDlhDbQhoUVcK1fhfC2hYm5Uvwe33z+ZUzVzxt/dBzg1oTDiMuHd+d5C2u8yH498Dx6HHdY+OFKNHb/g7Swi4LzMgcygleRPVyvpU2P+UvThDZkiTsUye1KctHDG5kYFTeIvwG7y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwqNg6R5; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwqNg6R5"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d2fad80eacso76157511fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Mar 2024 14:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709678567; x=1710283367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IteBeniYS/OKvVZR38rtHXB+ryPW+2Re55LISn4Lbto=;
        b=NwqNg6R5k0I8jxZ0egqezoGmtHQD4FYDSpHfX7Vupepmo7ywG6qOtJrMeIzcD3iHmy
         XLKrsVV7XP+pjIGgyDbdw8FEyDw29cAyEcS4s3yivYKgEp/WZlpZi8lzK0tHEZfa0U7S
         VN63BXeK50j0loOBvoVaPN1mAEmeOKokIk1nC9ezpe+Q/aCO/oc9pTWq+gTeuwL9T+os
         peoHJky1i7bqBg3PGx0g2XDpKgT3u37flB5bs1eMS/dQAP3qdy3XTNzyPjTexU5jLjcu
         PCeHf+5NeL5K0Rtnhc1d6EeUfJV59a0+rIc+Oa13PBi70pmT8UsxFF9XNXvEFvHve0wT
         1g9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709678567; x=1710283367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IteBeniYS/OKvVZR38rtHXB+ryPW+2Re55LISn4Lbto=;
        b=faHFOiYOmXtwOh+trCIDQ+5ErtUuHctbGow1bwdVHQJzWX6HxG6NjoDm0SBkE/exyI
         QtI0awhhz5h+OudiwQm4BiOi3Na/vmcTLyjyUIw8kmEXl74Rqv5PMS2oUvPH/s1qAQjI
         3bhLbuq3U6UuWLhgWr/nwsvMvNQsi/krWBG3GI9F1Do1vlw5A3BxGhD/vDnonLARWAAu
         CJe9nesV2IoViOg8G050pLC0kiyFyqLSyjKFWEKd0ts6TbIuTWokt4VqfQOSZU/tpvbq
         CzNWCGCvhIEUrMSWopHgPnNk2PsAPtGG9lOjbS5IP5oBWMDIwGqOO6O5G6MBWlC3J7I6
         KU8A==
X-Gm-Message-State: AOJu0YxS7yAQGWbWG0LYDQWa1Zsel8B0u+ukvQwVhwFVTgbuC4TxiQfA
	jZQPPE2DazGiGZo2jf5ORNMzHYebdCLYkh+cyIbY+tfa2+Ws0UVPXeE2ZUBWOfLkejav12F58Vw
	D7Ul6VavTsxqb3s2kzFRA8njAJRM=
X-Google-Smtp-Source: AGHT+IEnL+GueghtUm2A1pGm1IIcWdCRy1R+X78IrLazrnACBQlqxywUAJa39EnuCpa9ZmQ79vpYI8zv60KYSQ+vLK0=
X-Received: by 2002:a2e:90cd:0:b0:2d2:cb34:2e05 with SMTP id
 o13-20020a2e90cd000000b002d2cb342e05mr2335081ljg.11.1709678567230; Tue, 05
 Mar 2024 14:42:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305144459.119564-1-kiran.k@intel.com>
In-Reply-To: <20240305144459.119564-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 5 Mar 2024 17:42:34 -0500
Message-ID: <CABBYNZJXzX5ppWz5Jt1XGXHZX-y9u09LfnO8F-ZF-3Z9xkZVPg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Bluetooth: btintel: Define macros for image types
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Tue, Mar 5, 2024 at 9:38=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> Use macro for image type instead of using hard code number.
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 12 ++++++------
>  drivers/bluetooth/btintel.h |  3 +++
>  2 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 6ba7f5d1b837..ed98bb867cff 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -489,7 +489,7 @@ static int btintel_version_info_tlv(struct hci_dev *h=
dev,
>         }
>
>         switch (version->img_type) {
> -       case 0x01:
> +       case IMG_BOOTLOADER:
>                 variant =3D "Bootloader";
>                 /* It is required that every single firmware fragment is =
acknowledged
>                  * with a command complete event. If the boot parameters =
indicate
> @@ -521,7 +521,7 @@ static int btintel_version_info_tlv(struct hci_dev *h=
dev,
>                             version->min_fw_build_nn, version->min_fw_bui=
ld_cw,
>                             2000 + version->min_fw_build_yy);
>                 break;
> -       case 0x03:
> +       case IMG_OP:
>                 variant =3D "Firmware";
>                 break;
>         default:
> @@ -535,7 +535,7 @@ static int btintel_version_info_tlv(struct hci_dev *h=
dev,
>         bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u", var=
iant,
>                     2000 + (version->timestamp >> 8), version->timestamp =
& 0xff,
>                     version->build_type, version->build_num);
> -       if (version->img_type =3D=3D 0x03)
> +       if (version->img_type =3D=3D IMG_OP)
>                 bt_dev_info(hdev, "Firmware SHA1: 0x%8.8x", version->git_=
sha1);
>
>         return 0;
> @@ -1172,7 +1172,7 @@ static int btintel_download_fw_tlv(struct hci_dev *=
hdev,
>          * If the firmware version has changed that means it needs to be =
reset
>          * to bootloader when operational so the new firmware can be load=
ed.
>          */
> -       if (ver->img_type =3D=3D 0x03)
> +       if (ver->img_type =3D=3D IMG_OP)
>                 return -EINVAL;
>
>         /* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 suppo=
rt
> @@ -2230,7 +2230,7 @@ static int btintel_prepare_fw_download_tlv(struct h=
ci_dev *hdev,
>          * It is not possible to use the Secure Boot Parameters in this
>          * case since that command is only available in bootloader mode.
>          */
> -       if (ver->img_type =3D=3D 0x03) {
> +       if (ver->img_type =3D=3D IMG_OP) {
>                 btintel_clear_flag(hdev, INTEL_BOOTLOADER);
>                 btintel_check_bdaddr(hdev);
>         } else {
> @@ -2600,7 +2600,7 @@ static int btintel_bootloader_setup_tlv(struct hci_=
dev *hdev,
>                 return err;
>
>         /* check if controller is already having an operational firmware =
*/
> -       if (ver->img_type =3D=3D 0x03)
> +       if (ver->img_type =3D=3D IMG_OP)
>                 goto finish;
>
>         err =3D btintel_boot(hdev, boot_param);
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index d19fcdb9ff0b..52b2f1986f85 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -51,6 +51,9 @@ struct intel_tlv {
>         u8 val[];
>  } __packed;
>
> +#define IMG_BOOTLOADER         0x01    /* Bootloader image */
> +#define IMG_OP                 0x03    /* Operational image */

Lets prefix these with BTINTEL.

>  struct intel_version_tlv {
>         u32     cnvi_top;
>         u32     cnvr_top;
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
