Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9018296BA4
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Oct 2025 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923899; cv=none; b=dc4LJ1tPfq8Qj/YMJio4doo4dZxk6tvtKFl3I2e6X80mCCVqQQSEzHg6jUuaT8Dq5tyzUJM7MgzMI5cCZWJkZvJYUWRFc8RTotuVGZ7QpS1jfMd2tQ2aTKQp+xksC8gHYlpK/Cs32RwUHTHk9Rb0d2Ob8T8Z+xdjXeooV/5eMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923899; c=relaxed/simple;
	bh=On3cALU8nBb0+4ieggXOsWPvMWQU83j2ni/F0KAU+8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AC80f9BUk4vg8N1U/YCmBiqvYpb6PpX1xjMiYAWLGkYTRajatkX7gdDQzYkdMjZ6GEafExlyM11LWluQmbffQr+1CW5tPnV4+oDJxe9sz+ZVn5BW6Z25jDj/4XTRhbD7r4PCjL8F4vo/doiVfDmsUoODRVzcYEqTbITPn4jMLwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUQI39Pu; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUQI39Pu"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-378cffe5e1aso26268311fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Oct 2025 08:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761923895; x=1762528695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWTZKkOkYcn9N/iXeT7lTpb6wx5Kgm29lLrZZWz6S0Y=;
        b=NUQI39PutpnQtcrVBQp3FC3sNqrkkV7ZC8PAzdjeWSW8gfiVVE3+EiLjGsssBFCjws
         LXnO8PNgfkuqWzFGVKbeRJNYFT11TqWxdk0M8UG6MKeV7Og+6X2JYcSp8Bhx7WnCBBx7
         wV2gkxe7ZfAwsopmHY4JP34khkX8W38eFFIh1L/fBb95oV/WA6Lq7aNPZ7/RszRfh6Hb
         47pxXkqCistkPkkcAgZg+QVeL51px149xmU9DWYCm41+ZdAtUkfRtY047mv/hPgftfTd
         5qtZ1eUXuGPG1wQExkKtFega/oWWB9SDKmZlIdqY18RoNyRbufXpOnxfL+Srb0LjUEKF
         +lJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761923895; x=1762528695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWTZKkOkYcn9N/iXeT7lTpb6wx5Kgm29lLrZZWz6S0Y=;
        b=fnv55d9svG/xgJ4mmhIcLK/ZGrPU8P1zGtCuGQOmCsXkel9xYdxNgpjTllx4TQ1mtE
         rPN/lg+LGANSPCmnZsHcyM/v2tNf7ptX8RoHbatVaaevLoQcCPZ8VEQwpDmI1zXy5Y6U
         PXzlHGmNuKpjGcWIc0Lnh/YwaLM16Vd9zFqOAenhQa8XwWcgIOSvKujlHKdjcJvP7qh9
         A95ytE0lLhd/4cMpTYWhLC5oCEzfk5UC8xMOZvpUWtJKAe3namId3vd+puTpf9TL2TZs
         yj9HW1DLGtfPogDTSxOcKKphj+kzpfoz/tbrAyvZrDS+C22zjMDGsyEBwT7feK8XkIc1
         +LJA==
X-Forwarded-Encrypted: i=1; AJvYcCXI3ny1Q8iawroLhg9tCMdt0kGfjKn7qXjx3anqjiZ3uOxXXHWMz3HZyCeA3IlkRXvvDaWE2tVZItggX6P/ysE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyodh5EGlQeobWP21z2lFx9JoR6fIZ1IvCh7nU7EWm2GBxs+rU5
	9l8sNpLa+fETL3rmU/HjGxMmtEN3lsPHoREIHLNUzQKjTqTIHLXgl8Pt1oTMovx4M+I0MxZWvfk
	FqlYMKksDy7b6dPxMKqfpgfwXuOEahzU=
X-Gm-Gg: ASbGncvhwna2POwKIdn3uhXf1IQqerBhBsyqvNPnniPvrujXPxil5AsLPZ+Ph/UQ6j0
	j28//Ksqnw35osgqtQZnri87KcJEFCgtiqZjPvM6Tq9UAOGYgXHOMmeNhlzsB0RuBVzUGwfkpAi
	7CYBNZunuwFloEXTuzbfgmtPbiZls8zL9YBpe80jhFKvKgQCbVyk/BFJ00TtxizcRnQn+1bnDPP
	L3apsyIOaWTtjEB/ZjuO8OyPZYGkC50ikAW+02NaGIEp/0rvOKoJPKDMfRGQZAOER4Qhw==
X-Google-Smtp-Source: AGHT+IHhCyX5WgD/BnEfxs9+rDfxqdatiMXwvRpqYTj0+QM5LEWR/Zg4MlR9SQpm0sfZglZhrIAAIz4nl5FkspVBkEw=
X-Received: by 2002:a05:651c:2209:b0:336:9232:fb91 with SMTP id
 38308e7fff4ca-37a18d84e13mr14682981fa.4.1761923894307; Fri, 31 Oct 2025
 08:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029022955.827475-1-quic_shuaz@quicinc.com> <20251029022955.827475-2-quic_shuaz@quicinc.com>
In-Reply-To: <20251029022955.827475-2-quic_shuaz@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 31 Oct 2025 11:18:02 -0400
X-Gm-Features: AWmQ_bnmEoXSHQbwofIVHDVHm8UazbPDGWMN_lWJ04lJ7qFjiRa0BctPyX2rqPk
Message-ID: <CABBYNZKh5_Ed0Jm-rjpPZKEf26zo3Lz-ZZrEKAJJWkZWQy3o7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: btusb: add default nvm file
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: dmitry.baryshkov@oss.qualcomm.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, stable@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_chejiang@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 28, 2025 at 10:30=E2=80=AFPM Shuai Zhang <quic_shuaz@quicinc.co=
m> wrote:
>
> If no NVM file matches the board_id, load the default NVM file.
>
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/bluetooth/btusb.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index dcbff7641..6903606d3 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3482,15 +3482,14 @@ static int btusb_setup_qca_load_rampatch(struct h=
ci_dev *hdev,
>  }
>
>  static void btusb_generate_qca_nvm_name(char *fwname, size_t max_size,
> -                                       const struct qca_version *ver)
> +                                       const struct qca_version *ver,
> +                                       u16 board_id)
>  {
>         u32 rom_version =3D le32_to_cpu(ver->rom_version);
>         const char *variant, *fw_subdir;
>         int len;
> -       u16 board_id;
>
>         fw_subdir =3D qca_get_fw_subdirectory(ver);
> -       board_id =3D qca_extract_board_id(ver);
>
>         switch (le32_to_cpu(ver->ram_version)) {
>         case WCN6855_2_0_RAM_VERSION_GF:
> @@ -3522,14 +3521,28 @@ static int btusb_setup_qca_load_nvm(struct hci_de=
v *hdev,
>         const struct firmware *fw;
>         char fwname[80];
>         int err;
> +       u16 board_id =3D 0;
>
> -       btusb_generate_qca_nvm_name(fwname, sizeof(fwname), ver);
> +       board_id =3D qca_extract_board_id(ver);
>
> +retry:
> +       btusb_generate_qca_nvm_name(fwname, sizeof(fwname), ver, board_id=
);
>         err =3D request_firmware(&fw, fwname, &hdev->dev);
>         if (err) {
> +               if (err =3D=3D -EINVAL) {
> +                       bt_dev_err(hdev, "QCOM BT firmware file request f=
ailed (%d)", err);
> +                       return err;
> +               }
> +
>                 bt_dev_err(hdev, "failed to request NVM file: %s (%d)",
>                            fwname, err);
> -               return err;
> +               if (err =3D=3D -ENOENT && board_id !=3D 0) {
> +                       board_id =3D 0;
> +                       goto retry;

goto backwards is asking for trouble, just split the required code
into its own function and then call it again with board set to 0.

> +               } else {
> +                       bt_dev_err(hdev, "QCOM BT firmware file request f=
ailed (%d)", err);
> +                       return err;
> +               }
>         }
>
>         bt_dev_info(hdev, "using NVM file: %s", fwname);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
