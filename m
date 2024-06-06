Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BE119922B;
	Thu,  6 Jun 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693381; cv=none; b=sgLHdZO9HX/JB1r5LCQxRY6xii2/O3PyrbwiajRqZWqYgjBDzs0eSn7Zgy3GV1fdS9hZSFz3ZargWG0c5K9LbinmJMdLSIIrxQkG2RcnQG88tF12LVZ04MufMC0OnWgkBayDdfKq/N5B1CMMaCpTV6EGL3A6xV0RU3X0qFSCq7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693381; c=relaxed/simple;
	bh=ggzn+VB4VUR6nQvAcJsdA05/JkXney5QTdx0Lok4+pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ju+FKGQKJg+ecLOVvgh4vQORvQ4pq6RirSYnQZq4KZ+3G2sI4BweHLelhFqB1CxwCuaehHNcCqVq2sUmlm/6BKbILz0pkOR4+QFrVkFlllK3oIB+jIKM4GKqgpEFMmQyF3HCbhI+B3ogoAmmUVkpcGnJgf7bShIb3j0NiKbwLFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a68b5f18fc5so145804566b.1;
        Thu, 06 Jun 2024 10:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717693377; x=1718298177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6E3JGAnNdlUSj+6x83Fb8gt3zLtuaMS1NY1zybVIG/Y=;
        b=artOMAKemzhjRe3tr8fIhdaZyJvJp8W/Cjs0At0WNKazatrYSD0apw7PvG/iSU/2pN
         vErbbBpbNg+N32XVHHuwKVReSBwlH78ClotUuQtEl9nR9uoQzYcdqDAvhj4lQjb22Ve7
         KH2/zfiakMuqXspptlRBUU9m4h0D6Z6dZRnTyY5+duNAAJNM+AjhOpFot4lHqZPSPB3y
         MaHeYNsNEfjTzDiVZoQxRtBH6YrT4AH/sDqszCXAixE5Xle+/U8wa9swxJOnjozl0uP/
         b8qiTAR9oxoAq4Ye90NDz1CTtBsv3qJvpob9w27W1+IOWbRKbuMf/ZIKVDKTYUkXTzxr
         Dytw==
X-Forwarded-Encrypted: i=1; AJvYcCULKTvgpPGerygPl94fe9aM832dh3chzStn9avzybP1ktctycgMgPUK/H7DmEuDYp3Fqsf9HjJJgIhtjcjOPudlMaD6ixtPw/05TjSRzw0wGOrXoIdtR6tI2JalPUn9wJbgxskuJgLKqwXMRIPw
X-Gm-Message-State: AOJu0YxR0aTtoeuma67N91ze1t+/LmvNieWjCcOx73bNHAi2B4ZyUBp+
	YZYnZzwkdxaolI4Szfxr+NaQC9WcAumTsu5FiuNPzzRilrw/CxNle2MrvUn5
X-Google-Smtp-Source: AGHT+IEyWLx+LEoW7opUkxXTkqD0HEURj0QaTB1w7nh0BMJ6gqhCTDMrQ2i40qODUcUVOJuuhLIQxA==
X-Received: by 2002:a17:906:32c7:b0:a52:3583:b9d0 with SMTP id a640c23a62f3a-a6cd560fb20mr12921266b.3.1717693376891;
        Thu, 06 Jun 2024 10:02:56 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805c96d9sm119676566b.52.2024.06.06.10.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 10:02:56 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a2f032007so1524483a12.0;
        Thu, 06 Jun 2024 10:02:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZArm5PWCSkPc4jQ950bUrhrUBwfJvThvHIp1O/DZVhKP2U9J+JAsSNENuLHUnzb4/GF4lPMqCXYB/AJUaqyT68CTreFtILwDj+K0aYV5hK7orbaFyV3+1vxSVVV8QlkbJz7jfsX4dNNvhd798
X-Received: by 2002:a50:f69d:0:b0:57a:79c2:e9d7 with SMTP id
 4fb4d7f45d1cf-57a8b7c6141mr4117440a12.27.1717693375858; Thu, 06 Jun 2024
 10:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602-btbcm4388-v1-1-210e4b4eeb3b@svenpeter.dev>
In-Reply-To: <20240602-btbcm4388-v1-1-210e4b4eeb3b@svenpeter.dev>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 6 Jun 2024 10:02:18 -0700
X-Gmail-Original-Message-ID: <CAEg-Je9VKMN7HrXjrTvDYNQEcR0dq31kkNsV9_Jvthpd-X0UKg@mail.gmail.com>
Message-ID: <CAEg-Je9VKMN7HrXjrTvDYNQEcR0dq31kkNsV9_Jvthpd-X0UKg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: Add BCM4388 support
To: sven@svenpeter.dev
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Hector Martin <marcan@marcan.st>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 2:57=E2=80=AFAM Sven Peter via B4 Relay
<devnull+sven.svenpeter.dev@kernel.org> wrote:
>
> From: Hector Martin <marcan@marcan.st>
>
> This new variant needs a different core2_window1 and always uses
> beamforming.
> The BAR2 also has an offset (RAM start, presumably), so add that.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Sven Peter <sven@svenpeter.dev>
> [sven: rebased, updated some comments, mentioned 4388 in Kconfig]
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
> Hi,
>
> This is just a single commit mostly written by Hector that adds support
> for BCM4388 chips. I've just rebased this to the current bluetooth-next
> since it also needs 9dc8ac15ca5 and adjusted some comments.
>
> Best,
>
> Sven
> ---
>  drivers/bluetooth/Kconfig       |  6 ++--
>  drivers/bluetooth/hci_bcm4377.c | 61 +++++++++++++++++++++++++++++++----=
------
>  2 files changed, 50 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 0b5f218ac505..87484f5de8e3 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -287,12 +287,12 @@ config BT_HCIBCM203X
>
>
>  config BT_HCIBCM4377
> -       tristate "HCI BCM4377/4378/4387 PCIe driver"
> +       tristate "HCI BCM4377/4378/4387/4388 PCIe driver"
>         depends on PCI
>         select FW_LOADER
>         help
> -         Support for Broadcom BCM4377/4378/4387 Bluetooth chipsets attac=
hed via
> -         PCIe. These are usually found in Apple machines.
> +         Support for Broadcom BCM4377/4378/4387/4388 Bluetooth chipsets
> +         attached via PCIe. These are usually found in Apple machines.
>
>           Say Y here to compile support for HCI BCM4377 family devices in=
to the
>           kernel or say M to compile it as module (hci_bcm4377).
> diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4=
377.c
> index e6644cb0163c..77a5454a8721 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only OR MIT
>  /*
> - * Bluetooth HCI driver for Broadcom 4377/4378/4387 devices attached via=
 PCIe
> + * Bluetooth HCI driver for Broadcom 4377/4378/4387/4388 devices attache=
d via PCIe
>   *
>   * Copyright (C) The Asahi Linux Contributors
>   */
> @@ -26,11 +26,13 @@ enum bcm4377_chip {
>         BCM4377 =3D 0,
>         BCM4378,
>         BCM4387,
> +       BCM4388,
>  };
>
>  #define BCM4377_DEVICE_ID 0x5fa0
>  #define BCM4378_DEVICE_ID 0x5f69
>  #define BCM4387_DEVICE_ID 0x5f71
> +#define BCM4388_DEVICE_ID 0x5f72
>
>  #define BCM4377_TIMEOUT msecs_to_jiffies(1000)
>  #define BCM4377_BOOT_TIMEOUT msecs_to_jiffies(5000)
> @@ -488,6 +490,7 @@ struct bcm4377_data;
>   *                     second window in BAR0
>   * has_bar0_core2_window2: Set to true if this chip requires the second =
core's
>   *                         second window to be configured
> + * bar2_offset: Offset to the start of the variables in BAR2
>   * clear_pciecfg_subsystem_ctrl_bit19: Set to true if bit 19 in the
>   *                                     vendor-specific subsystem control
>   *                                     register has to be cleared
> @@ -511,6 +514,7 @@ struct bcm4377_hw {
>         u32 bar0_window1;
>         u32 bar0_window2;
>         u32 bar0_core2_window2;
> +       u32 bar2_offset;
>
>         unsigned long has_bar0_core2_window2 : 1;
>         unsigned long clear_pciecfg_subsystem_ctrl_bit19 : 1;
> @@ -836,8 +840,8 @@ static irqreturn_t bcm4377_irq(int irq, void *data)
>         struct bcm4377_data *bcm4377 =3D data;
>         u32 bootstage, rti_status;
>
> -       bootstage =3D ioread32(bcm4377->bar2 + BCM4377_BAR2_BOOTSTAGE);
> -       rti_status =3D ioread32(bcm4377->bar2 + BCM4377_BAR2_RTI_STATUS);
> +       bootstage =3D ioread32(bcm4377->bar2 + bcm4377->hw->bar2_offset +=
 BCM4377_BAR2_BOOTSTAGE);
> +       rti_status =3D ioread32(bcm4377->bar2 + bcm4377->hw->bar2_offset =
+ BCM4377_BAR2_RTI_STATUS);
>
>         if (bootstage !=3D bcm4377->bootstage ||
>             rti_status !=3D bcm4377->rti_status) {
> @@ -1197,6 +1201,14 @@ static int bcm4387_send_calibration(struct bcm4377=
_data *bcm4377)
>                                                   bcm4377->taurus_cal_siz=
e);
>  }
>
> +static int bcm4388_send_calibration(struct bcm4377_data *bcm4377)
> +{
> +       /* BCM4388 always uses beamforming */
> +       return __bcm4378_send_calibration(
> +               bcm4377, bcm4377->taurus_beamforming_cal_blob,
> +               bcm4377->taurus_beamforming_cal_size);
> +}
> +
>  static const struct firmware *bcm4377_request_blob(struct bcm4377_data *=
bcm4377,
>                                                    const char *suffix)
>  {
> @@ -1820,8 +1832,8 @@ static int bcm4377_boot(struct bcm4377_data *bcm437=
7)
>         int ret =3D 0;
>         u32 bootstage, rti_status;
>
> -       bootstage =3D ioread32(bcm4377->bar2 + BCM4377_BAR2_BOOTSTAGE);
> -       rti_status =3D ioread32(bcm4377->bar2 + BCM4377_BAR2_RTI_STATUS);
> +       bootstage =3D ioread32(bcm4377->bar2 + bcm4377->hw->bar2_offset +=
 BCM4377_BAR2_BOOTSTAGE);
> +       rti_status =3D ioread32(bcm4377->bar2 + bcm4377->hw->bar2_offset =
+ BCM4377_BAR2_RTI_STATUS);
>
>         if (bootstage !=3D 0) {
>                 dev_err(&bcm4377->pdev->dev, "bootstage is %d and not 0\n=
",
> @@ -1855,9 +1867,12 @@ static int bcm4377_boot(struct bcm4377_data *bcm43=
77)
>         iowrite32(BCM4377_DMA_MASK,
>                   bcm4377->bar0 + BCM4377_BAR0_HOST_WINDOW_SIZE);
>
> -       iowrite32(lower_32_bits(fw_dma), bcm4377->bar2 + BCM4377_BAR2_FW_=
LO);
> -       iowrite32(upper_32_bits(fw_dma), bcm4377->bar2 + BCM4377_BAR2_FW_=
HI);
> -       iowrite32(fw->size, bcm4377->bar2 + BCM4377_BAR2_FW_SIZE);
> +       iowrite32(lower_32_bits(fw_dma),
> +                 bcm4377->bar2 + bcm4377->hw->bar2_offset + BCM4377_BAR2=
_FW_LO);
> +       iowrite32(upper_32_bits(fw_dma),
> +                 bcm4377->bar2 + bcm4377->hw->bar2_offset + BCM4377_BAR2=
_FW_HI);
> +       iowrite32(fw->size,
> +                 bcm4377->bar2 + bcm4377->hw->bar2_offset + BCM4377_BAR2=
_FW_SIZE);
>         iowrite32(0, bcm4377->bar0 + BCM4377_BAR0_FW_DOORBELL);
>
>         dev_dbg(&bcm4377->pdev->dev, "waiting for firmware to boot\n");
> @@ -1914,16 +1929,16 @@ static int bcm4377_setup_rti(struct bcm4377_data =
*bcm4377)
>         dev_dbg(&bcm4377->pdev->dev, "RTI is in state 1\n");
>
>         /* allow access to the entire IOVA space again */
> -       iowrite32(0, bcm4377->bar2 + BCM4377_BAR2_RTI_WINDOW_LO);
> -       iowrite32(0, bcm4377->bar2 + BCM4377_BAR2_RTI_WINDOW_HI);
> +       iowrite32(0, bcm4377->bar2 + bcm4377->hw->bar2_offset + BCM4377_B=
AR2_RTI_WINDOW_LO);
> +       iowrite32(0, bcm4377->bar2 + bcm4377->hw->bar2_offset + BCM4377_B=
AR2_RTI_WINDOW_HI);
>         iowrite32(BCM4377_DMA_MASK,
> -                 bcm4377->bar2 + BCM4377_BAR2_RTI_WINDOW_SIZE);
> +                 bcm4377->bar2 + bcm4377->hw->bar2_offset + BCM4377_BAR2=
_RTI_WINDOW_SIZE);
>
>         /* setup "Converged IPC" context */
>         iowrite32(lower_32_bits(bcm4377->ctx_dma),
> -                 bcm4377->bar2 + BCM4377_BAR2_CONTEXT_ADDR_LO);
> +                 bcm4377->bar2 + bcm4377->hw->bar2_offset + BCM4377_BAR2=
_CONTEXT_ADDR_LO);
>         iowrite32(upper_32_bits(bcm4377->ctx_dma),
> -                 bcm4377->bar2 + BCM4377_BAR2_CONTEXT_ADDR_HI);
> +                 bcm4377->bar2 + bcm4377->hw->bar2_offset + BCM4377_BAR2=
_CONTEXT_ADDR_HI);
>         iowrite32(2, bcm4377->bar0 + BCM4377_BAR0_RTI_CONTROL);
>
>         ret =3D wait_for_completion_interruptible_timeout(&bcm4377->event=
,
> @@ -2489,6 +2504,21 @@ static const struct bcm4377_hw bcm4377_hw_variants=
[] =3D {
>                 .send_calibration =3D bcm4387_send_calibration,
>                 .send_ptb =3D bcm4378_send_ptb,
>         },
> +
> +       [BCM4388] =3D {
> +               .id =3D 0x4388,
> +               .otp_offset =3D 0x415c,
> +               .bar2_offset =3D 0x200000,
> +               .bar0_window1 =3D 0x18002000,
> +               .bar0_window2 =3D 0x18109000,
> +               .bar0_core2_window2 =3D 0x18106000,
> +               .has_bar0_core2_window2 =3D true,
> +               .broken_mws_transport_config =3D true,
> +               .broken_le_coded =3D true,
> +               .broken_le_ext_adv_report_phy =3D true,
> +               .send_calibration =3D bcm4388_send_calibration,
> +               .send_ptb =3D bcm4378_send_ptb,
> +       },
>  };
>
>  #define BCM4377_DEVID_ENTRY(id)                                         =
    \
> @@ -2502,6 +2532,7 @@ static const struct pci_device_id bcm4377_devid_tab=
le[] =3D {
>         BCM4377_DEVID_ENTRY(4377),
>         BCM4377_DEVID_ENTRY(4378),
>         BCM4377_DEVID_ENTRY(4387),
> +       BCM4377_DEVID_ENTRY(4388),
>         {},
>  };
>  MODULE_DEVICE_TABLE(pci, bcm4377_devid_table);
> @@ -2516,7 +2547,7 @@ static struct pci_driver bcm4377_pci_driver =3D {
>  module_pci_driver(bcm4377_pci_driver);
>
>  MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
> -MODULE_DESCRIPTION("Bluetooth support for Broadcom 4377/4378/4387 device=
s");
> +MODULE_DESCRIPTION("Bluetooth support for Broadcom 4377/4378/4387/4388 d=
evices");
>  MODULE_LICENSE("Dual MIT/GPL");
>  MODULE_FIRMWARE("brcm/brcmbt4377*.bin");
>  MODULE_FIRMWARE("brcm/brcmbt4377*.ptb");
> @@ -2524,3 +2555,5 @@ MODULE_FIRMWARE("brcm/brcmbt4378*.bin");
>  MODULE_FIRMWARE("brcm/brcmbt4378*.ptb");
>  MODULE_FIRMWARE("brcm/brcmbt4387*.bin");
>  MODULE_FIRMWARE("brcm/brcmbt4387*.ptb");
> +MODULE_FIRMWARE("brcm/brcmbt4388*.bin");
> +MODULE_FIRMWARE("brcm/brcmbt4388*.ptb");
>
> ---
> base-commit: 3c376f35eb13a144d5039d911b35110c2beef815
> change-id: 20240602-btbcm4388-431aed90d763
>

This looks good to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
