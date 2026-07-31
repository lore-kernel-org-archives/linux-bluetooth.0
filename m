Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFB53B6BE5
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521164; cv=pass; b=E+9Gz0iHtqpJL804HHrriqFdkwlPGGVrV57eHY3C5ac43JSj3uWL4egm04gzJNkjf+taVHGxbhDyly+rCwL9l7UiAerjQGXDnTQOIhNIpSLQqMRjpEkmKPCHEavbThO0mmLVj51+nf2nWkoDH5xuIt3BFkIf8k+2GGzf6V2pZyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521164; c=relaxed/simple;
	bh=Iz8ffwhw26CpaI+mvyVjJUmyX9kTePoajvDT+kROQLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGxlfkkzhDL4KVYDSS0Q7rIOnDsWS9HAMYTdFcgAusTOOdHSbGE0bZA1L/phkfMUxBk9XQd3ewVjZzMzLn8HY45AUgzOiAJiMKlPVld7qOlt/CGIfLgjAiNt9N9MwiWf+O399dMlha1EsSAUDBNYItiTiD2eP5vgdqUhi9+z2pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYlo65lF; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYlo65lF"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66807ba2f0fso1803991d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 11:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785521162; cv=none;
        d=google.com; s=arc-20260327;
        b=rDdd/oeNEktKp3OvyYs3p+inx3dQ+ZlPpC9FBNiGDpe2vwgjBPP1s6Pi3KQET4KugG
         osdM6DDpJNJkBloX9vBcgAZlXCCrBuHQcafThWG9qMAfJCluD/EZXxvSu+0ew3Kw/ce3
         HMkz51snu/0Rx5EruXB4OEE9+MpPsJxDGWu5xV9w9Aps1Nbu+cPBpmK1Myvu8SeUwqJ9
         Y+1mKjyZI0/dm/+ELGpmcq+YXNSe2UVZpYV+M+qwkekmbeXEVE9gFvkXiUm8OK+JpPGq
         3wVCo2EsihL5cYPpLmvcZy52Z7DyPVQWmd01KseuM576L2tiV/AEr5uzpKepAXJUCD5l
         ajOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Be92gGmY7KrSGIMznvcDGv4P9viWnD9BIV+7S2IaULc=;
        fh=D0I9AJMsyXPO3IGUjlWNQ+79di7hl3haTtzHwJBhUkE=;
        b=biAVVFnXpO+yaHYPTMlg2kwYISItdlbnPzNyEbQSvwso9uspthKerZkr5P6SRCwZv+
         WJwagADkuGiDZ7tTsyZMsaQdhWDiX14agsUq41jZRSGQe81EozStSuBxhsVwoqNAJavs
         KQpde8Zjl0Dqhy42OSyfRCM59lsK11VOtWwCVwC8ndXhZG72Ha8NYpa7e3jz+ufGJwKu
         SajzlYGIa4j3PkHyc2e93noDYxTJxOQG0yEgOehv9KOUxmc9/nuocSqfYNIwODxI6lqj
         GfFr3cyvpgmpA+7ZxIXTo0IVLB5IJY1y1AbVa8wzsRPGgWfXc0BtB+yLCwyBt3CpgieI
         3N2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785521162; x=1786125962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Be92gGmY7KrSGIMznvcDGv4P9viWnD9BIV+7S2IaULc=;
        b=hYlo65lFjffXRZ8XlctB4GgPGWdwP6OtMAkVsFpizR8KgmeruiVasXlTRI0M6l7QwJ
         VjrS/mesBm2TMdnPQOaXTey7AIHCCgF06pciwm/tp0AQIOzAJNycCrD1r3jWShDUeCXN
         KplSGAuHpV5OYvzqo1ZtgN7h1ZrK31JS+ELVfL9QqJF+o2YEjfYuTbP9q+QHIw21m2hE
         kwFDtI8yOSw8dFkRl+noHeLnDgkjrFLy9ViSCOVYFijbnyRvN/e1SkEa/9WGRaZtA46k
         Hc2wgIxNVSa5gWFcEyb+uze/mk4bLVTpXQk53eW8HxcCI/GiUFq2Utefe/eIfGqHxXp7
         Ty0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521162; x=1786125962;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Be92gGmY7KrSGIMznvcDGv4P9viWnD9BIV+7S2IaULc=;
        b=cEtlzU/MhkdRjWzSxVJSg51saqEOayGy9djlnCvBrQLwaWTxXKC6C9bn+/Zdt+iYnY
         K6YKoo14fEKXv8W0EFqS5YgclX+ssLZCAbhR1njGUuMjP6NT382NNzAWPLWkSO9FLVlB
         svJiLKruKQNvh37bM/3c5zeafxElEGueMD/CJzi/naC/L/tuDbZXhfK6dYdFYflKVsja
         a7BKBuC+dxCCXKPE4ZBHhS4uFx1xnLXbYpOZ9SXXcnnYyNzTOmsziBewedUpKlQ6XfAX
         omPxBbEiQnJzBErgx+laiikmwik16Re5xiqmWIKA1XdtsFMnYOHyj0PDAbQNXto1700h
         rrIQ==
X-Forwarded-Encrypted: i=1; AHgh+RqyaExcWU+BHI18W8NcrxlFVJxf8zDlkQMiHBh6ABKq5MmBMS3tXf3vPc0y35aZDKSrrhTZ6HQyxShBbu+JOsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzj7IDrA5MFBDBsclVBk1ZKLNNS2b/qbcLxDRlDPMvfNmolqQX
	e9Gnbsj9r7/ReZl4m4a3XXTLWa4DA1d2s4lfskF0Bpi0xcoLctiAT6z5VwMltxfDi2lmQsnmJ9I
	xlv4S6ZZO96Gz92Ry0K8fkRwzw6BR6Pg=
X-Gm-Gg: AR+sD12qn9tMpawUSVx6GiK4CqACTzxyHEJlQgDJFAZkVynaDOg3rLuFLplMhIDfcPc
	f4tuYMvhG4qOnjGr2OGrWMW0OvnIkwjlcsydFf6K3x7LDcbRshF/on+yxP6T7wUECc9qdJUPa+U
	UbIf5xxVCP9bTkh0oWLybCqjqVNPxL20bMqq1d47Hr+4WUBsEs/yYr8aLI0L+kdLmhWjGlXvWF+
	d0sJwnRLLPCOtL9qJRz4EOcPIR9n5udROHY1/sOHRuM9TgLWQCwNFOHu1Ww6rg/gYvqiJ4XaMMi
	MZqcIvmTqOh5ixY5ESZyE5L9g5qoio/KIqgE3ypYRqIPEUu+t+5grJIKU0LrEHZ2NdZ1/Obyv88
	3mGuhePw6fjgZ6+qnsEJO2jA+7qDBDhI7
X-Received: by 2002:a05:690e:4851:b0:667:c7ba:99ee with SMTP id
 956f58d0204a3-6694efe2747mr922756d50.2.1785521161655; Fri, 31 Jul 2026
 11:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730161820.11631-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260730161820.11631-1-acharyalaxman8848@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 31 Jul 2026 14:05:50 -0400
X-Gm-Features: AUfX_mzEFRNqbfRb9bkSDwPElPkYkV4Dq0BpSLwrwXx6XC8tKKsLy43fDAdEeHc
Message-ID: <CABBYNZ+odi_ncMBjTTcrix9_sOMpa+d7_pNWuH6ePkQVmRwiuw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: validate QCA rampatch size
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laxman,

On Thu, Jul 30, 2026 at 12:18=E2=80=AFPM Laxman Acharya Padhya
<acharyalaxman8848@gmail.com> wrote:
>
> btusb_setup_qca_load_rampatch() reads the rampatch version structure at
> fw->data + info->ver_offset. A truncated rampatch can therefore make the
> driver read beyond the firmware buffer while parsing the version fields.
>
> The download path also expects the complete device-specific rampatch
> header. Reject files too short to contain both the header and version
> structure before accessing either.
>
> Fixes: 3267c884cefa ("Bluetooth: btusb: Add support for QCA ROME chipset =
family")
> Cc: stable@vger.kernel.org
> Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
> ---
>  drivers/bluetooth/btusb.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 8f7ed469cac..9801835d7c7 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3526,6 +3526,7 @@ static int btusb_setup_qca_load_rampatch(struct hci=
_dev *hdev,
>         struct qca_rampatch_version *rver;
>         const struct firmware *fw;
>         const char *fw_subdir;
> +       size_t min_size;
>         u32 ver_rom, ver_patch, rver_rom;
>         u16 rver_rom_low, rver_rom_high, rver_patch;
>         char fwname[80];
> @@ -3551,6 +3552,15 @@ static int btusb_setup_qca_load_rampatch(struct hc=
i_dev *hdev,
>
>         bt_dev_info(hdev, "using rampatch file: %s", fwname);
>
> +       min_size =3D max_t(size_t, info->rampatch_hdr,
> +                        info->ver_offset + sizeof(*rver));
> +       if (fw->size < min_size) {
> +               bt_dev_err(hdev, "rampatch file is truncated (%zu < %zu)"=
,
> +                          fw->size, min_size);
> +               err =3D -EINVAL;
> +               goto done;
> +       }

Has Qualcomm engineers verified that this is the correct way to check
the image size?

>         rver =3D (struct qca_rampatch_version *)(fw->data + info->ver_off=
set);
>         rver_rom_low =3D le16_to_cpu(rver->rom_version_low);
>         rver_patch =3D le16_to_cpu(rver->patch_version);
> --
> 2.51.2
>


--=20
Luiz Augusto von Dentz
