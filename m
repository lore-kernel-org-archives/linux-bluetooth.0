Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512F55E5B;
	Fri, 24 May 2024 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716578559; cv=none; b=GLt7bw5vobFY9+93qiar6u5B4BobXOkB3DN6Os6A/F5e9x2klMFZkVmXEQ+aerY0FBgt9z8+DraOBlekuDnqg6tQ7+u9/j5Dr29zfceCpCkb2dIPkUJQfN3w1c+Vx8+M9IYoFeb34ZNcrI3nW20QqK6XQkggzt8eVFxEK53F8MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716578559; c=relaxed/simple;
	bh=o+O4qg3jlg+Kj0uo37ivxe16BIKMl4kpu2HAeKhw0Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6/YrAuuj/vqkoFlYuqlseCCW73MJAOO0pUja0a1Db9HY9p+Bky3SpCAtosYXaAvpxhWocCfl2wl2pQIMHmTzLYD7bCKiGX0ltRiumz72Bucdv/uOo9H9B/ltMHV1ri3vtiJ2XaxiwRf4mVFurF+veIGJfoE0l8nM43fw+j5C0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndYxUEx3; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndYxUEx3"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e3efa18e6aso33712971fa.0;
        Fri, 24 May 2024 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716578556; x=1717183356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id4dzP3Wcb5ApEWbbo6ZZWSl9MfSzG4QR1RyXqGKis8=;
        b=ndYxUEx3odyBX80ewnTV00IcawruHrZPIqCkFjjSHSWQnFlnI1JgHdeszBoI+qKyA8
         Jz3+eXcm8aEo8zx9Cyxfz+Hr4T8KCFY4WTNoXhYMUx87WisuuGtRSI4UXLuHWV2UJZjq
         i1qke9epZiW8AHUiTOke8bKym6RfH6zO+qyNm1EIxZc5HaEbmcG6mr2Xe7PCGChuKN5X
         EpFTNAyXutuCZJ85lkX7niHL4/JVQoy8IzelAU/Nrm2vtTG7/qWsquwVAkNK8mDGuK5X
         r72e9PVFNethfcC3gufrHX/uaMLcKRpRz4fsID9IJTnwjTFZVGtDDj4dm4AMToApawBF
         yDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716578556; x=1717183356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id4dzP3Wcb5ApEWbbo6ZZWSl9MfSzG4QR1RyXqGKis8=;
        b=iUcl77kH3lfeZbRZV7VIsyGTBuC8VOq0phV/FW0oJcSrSU1YxrDUfm5Zvk60odBjHL
         XX6MXOjQPlvV8WGlLKxmjx70ZYN7Rfimmkq8thGKaxPuGaNTrczKsbuQ4cY5ykrqW3QP
         HmpJa3eWfqstKD3P1I+yTcz+RFZ5TMPp08XPv8mQb9YmPva5PUVduPyeTxXIxhhuYoqN
         oTNn+nUjeHEQm9weLL7F2SDXGOidgJQj9ICy5PZrhkXiwrr4VBOpvVT5uoEosBbYVLsb
         XHCzNwxtGQQCIjfIkyLIykLdCR70/Y9XjGTHqhFBkAmr6DVUOCEDbMFCVioRajPGI8w3
         w51w==
X-Forwarded-Encrypted: i=1; AJvYcCWphAwnakOmqBfGkyJS80Qb4r9Dq7VA61oyzATbFibF70leAnYHeavbMk/7WKmg2/o/G5RU3FXYqnfbOIK1Qcl68WTL43Y3y/vA3e4GLP6TWVczGtWIL/0v+ddXqvjWhEEBmhznSMwbSKybxcyG
X-Gm-Message-State: AOJu0YyDrmw73/lRmyPMuIUFCTJjoQ6D4XmS9Elt/ueOZS4M/g8kV+Wz
	gBV4aPsZdyPMlpquobpihHPaOAZzHpnkTsSQijreRqHXwVHqd0OVlj4uVIdj38hzJ6auQcCJR6q
	VKS4Gtl/rGnkrSNkO/pXiNNh6b8o=
X-Google-Smtp-Source: AGHT+IHqyCYbmdYS3ZS0dAvkeGUOFauCUjjEiZV5AYEknncFQ8vSdNjVsqZSlXzLRynGH4NofRN4A5SfgO0cWICS+nE=
X-Received: by 2002:a2e:a795:0:b0:2e1:c97b:6f25 with SMTP id
 38308e7fff4ca-2e95a096142mr13050031fa.1.1716578555411; Fri, 24 May 2024
 12:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524013127.434500-1-nobuaki.tsunashima@infineon.com>
In-Reply-To: <20240524013127.434500-1-nobuaki.tsunashima@infineon.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 May 2024 15:22:22 -0400
Message-ID: <CABBYNZ+yvQL0KBagUXtzrBUFmFxp-ek_5aFDJNVyUKsA-xJ-Zg@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: btbcm: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER
 to CYW4373
To: Nobuaki Tsunashima <nobuaki.tsunashima@infineon.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nobuaki,

On Thu, May 23, 2024 at 9:31=E2=80=AFPM Nobuaki Tsunashima
<nobuaki.tsunashima@infineon.com> wrote:
>
> From: Nobuaki Tsunashima <Nobuaki.Tsunashima@infineon.com>
>
> CYW4373 ROM FW has an issue that it claims LE_Read_Transmit_Power command
> as supported in a response of Read_Local_Supported_Command command but
> rejects the LE_Read_Transmit_Power command with "Unknown HCI Command"
> status. Because Bluetooth driver of kernel 5.11 added sending the
> LE_Read_Transmit_Power command in initialize phase, hci up fails due to t=
he
> issue.
>
> Especially in USB i/f case, it would be difficult to download patch FW th=
at
> includes its fix unless hci is up.
>
> The driver already contains infrastructure to apply the quirk for the
> issue, but currently it only supports DMI based matching. Add support to
> match by chip id and baseline FW version to detect CYW4373 ROM FW build
> in generic system.
>
> Fixes: 7c395ea521e6 ("Bluetooth: Query LE tx power on startup")
> Signed-off-by: Nobuaki Tsunashima <Nobuaki.Tsunashima@infineon.com>
> ---
> V3 -> V4: Fix a few coding style warnings and refine comments for clarify=
.
> V2 -> V3: Fix a few coding style warnings and change the subject as more =
specific.
> V1 -> V2: Fix several coding style warnings.
>
>  drivers/bluetooth/btbcm.c | 32 +++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btusb.c |  4 ++++
>  2 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 0a5445ac5e1b..29e3f83a19fa 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -437,18 +437,48 @@ static const struct dmi_system_id disable_broken_re=
ad_transmit_power[] =3D {
>         { }
>  };
>
> +struct bcm_chip_version_table {
> +       u8 chip_id;                     /* Chip ID */
> +       u16 baseline;           /* Baseline version of patch FW */
> +};
> +#define BCM_ROMFW_BASELINE_NUM 0xFFFF
> +static const struct bcm_chip_version_table disable_broken_read_transmit_=
power_by_chip_ver[] =3D {
> +       { 0x87, BCM_ROMFW_BASELINE_NUM }                /* CYW4373/4373E =
*/
> +};
> +static bool btbcm_is_disable_broken_read_tx_power_by_chip_ver(u8 chip_id=
, u16 baseline)
> +{
> +       int i;
> +       size_t table_size =3D ARRAY_SIZE(disable_broken_read_transmit_pow=
er_by_chip_ver);
> +       const struct bcm_chip_version_table *entry =3D
> +                                               &disable_broken_read_tran=
smit_power_by_chip_ver[0];
> +
> +       for (i =3D 0 ; i < table_size ; i++, entry++)     {
> +               if ((chip_id =3D=3D entry->chip_id) && (baseline =3D=3D e=
ntry->baseline))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  static int btbcm_read_info(struct hci_dev *hdev)
>  {
>         struct sk_buff *skb;
> +       u8 chip_id;
> +       u16 baseline;
>
>         /* Read Verbose Config Version Info */
>         skb =3D btbcm_read_verbose_config(hdev);
>         if (IS_ERR(skb))
>                 return PTR_ERR(skb);
> -
> +       chip_id =3D skb->data[1];
> +       baseline =3D skb->data[3] | (skb->data[4] << 8);

This is not really safe, you shouldn't attempt to access skb->data
without first checking skb->len, actually it would be much better that
you would use skb_pull_data which does skb->len check before pulling
data.

>         bt_dev_info(hdev, "BCM: chip id %u", skb->data[1]);
>         kfree_skb(skb);
>
> +       /* Check Chip ID and disable broken Read LE Min/Max Tx Power */
> +       if (btbcm_is_disable_broken_read_tx_power_by_chip_ver(chip_id, ba=
seline))
> +               set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quir=
ks);
> +
>         return 0;
>  }
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d31edad7a056..52561c8d8828 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -142,6 +142,10 @@ static const struct usb_device_id btusb_table[] =3D =
{
>         { USB_VENDOR_AND_INTERFACE_INFO(0x04ca, 0xff, 0x01, 0x01),
>           .driver_info =3D BTUSB_BCM_PATCHRAM },
>
> +       /* Cypress devices with vendor specific id */
> +       { USB_VENDOR_AND_INTERFACE_INFO(0x04b4, 0xff, 0x01, 0x01),
> +         .driver_info =3D BTUSB_BCM_PATCHRAM },
> +
>         /* Broadcom devices with vendor specific id */
>         { USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01),
>           .driver_info =3D BTUSB_BCM_PATCHRAM },
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
