Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C72155A4E
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253406; cv=none; b=gvzHGd0zZ+yvDo6bd4Wx0E9+q8LmOvFrZbAP1vlPMT7wy6DtNCx0VYUxYQfAycY84NJKzgurKQIl7O7BvMXpVXEIaXbxolaRCway5Yikhg9DKtBvB3VDloxhvfzMz14o0nTUYZ/ymxB28JaLEqbqDWGwS9LfghEpEA9UxL1gnRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253406; c=relaxed/simple;
	bh=AUksi6ZHbKyeYr8k+s4HXJG3UlqW08lz2dsiETr+XMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jb1gDp+GwOJpRL5TvdeG1V1coCxuQqEOMlEAqKAUNA8BfS0UsYYOLZP3s1pPusr7eNkZRlbjbyf31L9rdK/Gz1JWphQ6Rj2pbT57Z1A7fY+0c7yT0iyvJ8gYUN7avLoaSi1A+aa4m/ygTnRD52LN53RbJiNwS7fRwdQZd+txul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA67DJps; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA67DJps"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3105ef2a071so71431931fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750253402; x=1750858202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SHZ511/VF3ZcuOkHtifXkTapYE4RS6Bun4dzdWS8D0=;
        b=IA67DJpslQij0Z4W9sN7/59BdUexBbjdwR0baLjbSf+Kd5S4m49gsi62GGMCbOz9Xe
         CFmLW9U1mTPTwotKYCCjGq921avPngTUgzLNXl6Uxm0NNPy2K4BuW61JQxGqQV/S/vS5
         oy5C56lm0XjYK99PMtwpHdCDrzUjC8nykl1K6s8IXMq5yDJQp5Mjt+0Ywy9ww0XNQSFd
         gBCF2kt5jww+x2tSPLxE53GplJIo5yaapvOqHiXacziarr0jAccsBI+dG+A0OQVN1+zD
         5JQ3cjeKIAWv0ez0UbNNZP/v2pTAGtqsHVfrR2rrzGY8+ZJCivSmDk5eK+a5UT042ROC
         Rr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750253402; x=1750858202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SHZ511/VF3ZcuOkHtifXkTapYE4RS6Bun4dzdWS8D0=;
        b=ZeYzP3lJI9jyTvIrBjRlzZvyha4D4pqFjSa9CXQsMrhG359JpfafO67ctk1Y/bDiOV
         oFEys+lPAsKIAquz08Fx8EWKQdwd058budnt/KtvftacYZUgJll3LPhzbS455arvEl5B
         4UHl5bq99fnY39aHBBGJgWJSZxBiY0c1lHRXx2XkAPwVZaTHtPgSZKqy1PTMnKYQjyaw
         5Axs88Y7OYOSqnvIr4SniC86/cNL3lMqEVFQ8ArCYfeswAN13QeujiI34QeECDNTFeeJ
         WFf+Amt6wIGgtJkrphl53QeExPNf7UvyfkbxS96X6UJDF24stV68vSg4g/P2eyu4kn8l
         w7gw==
X-Gm-Message-State: AOJu0YwUn5Z1TFyrqv9yCLjLE+r1Z9Rc5UaCfR1vr5hyimTwsOIE/8/H
	mF5kdVvpT6TwaiDZGNFmVxbIFqWLXfVdNqc6UgYi2lePI2pjCEKj0YZw5OPpzvGst8Ymu1xgoxl
	newYjreW0xUldwUlmhUEH1ytx6N2utZlh9A==
X-Gm-Gg: ASbGnct6YW6wF2udh6lfQMNkMRpq7nj9ef0j00/JV/D5PbzU8oPDnNUhQO5Rj/WW5gb
	ZHL+pJg0BJjv1XH3Gx1PbQFBdcb6QuJxJhnaA+g6VGM+ki3wu+AN6FFrRZhEW6uPk0H/w9xpCig
	4tUP/Ys1e421I3Fy+fG4tZgGfHHJketmZiNg0rMOuQyLMZmTUEmZNT
X-Google-Smtp-Source: AGHT+IERxNoGfw6/rN8sIPRbJY3J/3L7mexHIEepE7YkNL+47aopYV23rrrKuI3irIFlTq2KIsZw0NkVgCDIF7tTedk=
X-Received: by 2002:a05:651c:3053:b0:32b:7181:b432 with SMTP id
 38308e7fff4ca-32b7181bbc2mr16315811fa.12.1750253402345; Wed, 18 Jun 2025
 06:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618125555.773327-1-kiran.k@intel.com>
In-Reply-To: <20250618125555.773327-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Jun 2025 09:29:49 -0400
X-Gm-Features: AX0GCFsyel88QFDkHL3t4Lc6B_MagQlQ7ar0PTkZMBSz8EiiKEYgENWMdOpuKAg
Message-ID: <CABBYNZJShtDX_CiJ=pteK5soovyjhE4PxF0Wh7XajwU2ts83=A@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btintel: Add hardware id of BlazarIW
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com, 
	aluvala.sai.teja@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Wed, Jun 18, 2025 at 8:44=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> Add hardware id of BlazarIW cnvi core for USB and PCIe transport.

It might be a good idea to add some trace of what is the expected
response for the likes of the read version command for these
controllers.

> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c      | 3 +++
>  drivers/bluetooth/btintel_pcie.c | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 55cc1652bfe4..f6805027be0a 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -484,6 +484,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
>         case 0x1d:      /* BlazarU (BzrU) */
>         case 0x1e:      /* BlazarI (Bzr) */
>         case 0x1f:      /* Scorpious Peak */
> +       case 0x22:      /* BlazarIW */
>                 break;
>         default:
>                 bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%=
x)",
> @@ -3253,6 +3254,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, =
u8 hw_variant)
>         case 0x1d:
>         case 0x1e:
>         case 0x1f:
> +       case 0x22:
>                 hci_set_msft_opcode(hdev, 0xFC1E);
>                 break;
>         default:
> @@ -3593,6 +3595,7 @@ static int btintel_setup_combined(struct hci_dev *h=
dev)
>         case 0x1d:
>         case 0x1e:
>         case 0x1f:
> +       case 0x22:
>                 /* Display version information of TLV type */
>                 btintel_version_info_tlv(hdev, &ver_tlv);
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index cb3cf2b9acea..1004264128e3 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2137,6 +2137,7 @@ static int btintel_pcie_setup_internal(struct hci_d=
ev *hdev)
>         switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
>         case 0x1e:      /* BzrI */
>         case 0x1f:      /* ScP  */
> +       case 0x22:      /* BlazarIW */
>                 /* Display version information of TLV type */
>                 btintel_version_info_tlv(hdev, &ver_tlv);
>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
