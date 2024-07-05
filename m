Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A7ECF;
	Fri,  5 Jul 2024 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720143269; cv=none; b=Bz0ilDa/f01vO7iZ/C9ZTB/kBGCeCjlsYeUAyFTFdnEV5OetUjF9FU8+jhSOSx+J+2myroZHB2KLuwrXSJOg5lX4mMP3NsuISvaun6O9dyFLB4yEj2szm4JX6O0wNHdf5cbiSHr+FltCRV7u3lMt5MoWVmv1z0CJri19RroI8XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720143269; c=relaxed/simple;
	bh=CkmYUB+Wb0PVAVfXRxDHlsvFmu+OM+8wtTiAsHFpwPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6O84KnJK8vjyiYwDIXLI+4ODv1iZbmZSAzoJ8OFFowBQ1IbeZ0RylHcuw3F5Ql8qOuCTP8QepayL1ZtjdF3KtFY/ZoVIRQaYJYAF6ibnuiwU9WbZnrr87g7fh8Jrm6jjooIszybTyhx5NTz6uju/JGCclhrQsUgeYBWXEPwF0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIOR+9Xc; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIOR+9Xc"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ee4ab4076bso18116051fa.0;
        Thu, 04 Jul 2024 18:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720143266; x=1720748066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnvA9qdYRI8IFnTgozQAGatw1H+Gapz2OYIN09IDyec=;
        b=TIOR+9XcTvJMWfGT8E9Ux9W/+WNW9hWdEbY2NxmEiz6LuLMvaRh9vMyyCG39eEumGb
         Oy3SW56FKP9+XCGjG5sqW5d3t+ZNYWDig4tmr5KOChuiS4fZKk/OJohhbowPvAS08liE
         P1k7hoBrTCxTnQMdkXc1jpWxGYtOkJ9DdR66eBgXIi9oywj2oRdX9g9023WAh9SoZfX1
         b1GfACKBwuUYQLUY/brPr5COGCmS8fsv3pd66P8TxyE5O7OEdD8vm0S2wlM7b1/I/2rM
         2O5tK7lPFx22r7Usrs6hmtS2ajiG7F/aN2bfl3g+3Mgg9xjM/w5lDVjnu8cf8te7ayry
         kLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720143266; x=1720748066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnvA9qdYRI8IFnTgozQAGatw1H+Gapz2OYIN09IDyec=;
        b=b3XGz53n6+kwQhYdCHK54srLIiJUa5n77Sct93hcj5dx9+RTgjXns2MvdE+PPKDy23
         1Xrxo2CH32RvtWrCZAcbahFDpRDmXQQva8P5DZrwpO425jzTFLYTejmJ4cGDhm4T8gFc
         zv2vxx0xdH/qvmwGwL6uPbfBMDrP3GooKRCxi2IBfU638/HjVPIzF4RjXAnXz9RB0bVI
         2fLC3mXCkoE/dppl8mXl2UxG1ej2RNpL+MQwZGozwvh/7Xli6UhV37/KEPD9LYh+sqaD
         kPdMsFGgBCmNoYpsM/31GbwDavL3xKQDsBM0TVyQHkJC22fdZlFGcCCdzzKxY5XEz6Gi
         yX5g==
X-Forwarded-Encrypted: i=1; AJvYcCVzjplzDPta4ruSHlSGOhrBJTj/fWFhAl3WvRxnx/eHl87WzfEe+AUt3tMJUROwZ9naJIju3GLxgsiRE7taD+UFzOBi48qvAJB1BbphDBhXjTWjUWZHUtsOlj+YP1pIn0eJZHA8Ij/0WrFMUHaI
X-Gm-Message-State: AOJu0YzbJK+4zp1ERlIfLxRMxieWyKLSSUBYWVBPK3IEC8Pxi0woFgh8
	WmiEgp6nYcAJANXr9692ooUJpiAqvsWtdOOKLbVwcMGD3Nd2B/Wp/cTzF597V2i2yHuqcSvy/CM
	PRA+N5OKufiHr2V+b/V06u20yjrs=
X-Google-Smtp-Source: AGHT+IE4vKywFszF27KWciwCz3YLJq1WM+m0xB8siGXi2m2TTkznG5lADS5x5zLGA2oCtnl87N3iz7FaIsYNhTUfhGk=
X-Received: by 2002:a2e:3506:0:b0:2ec:266:f59e with SMTP id
 38308e7fff4ca-2ee8f309a57mr8880561fa.24.1720143265433; Thu, 04 Jul 2024
 18:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705011525.402650-1-nobuaki.tsunashima@infineon.com>
In-Reply-To: <20240705011525.402650-1-nobuaki.tsunashima@infineon.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 4 Jul 2024 21:34:10 -0400
Message-ID: <CABBYNZLo2P5VLFJ0XahNyh8CeOAA6rg1WTWpMx3WRqhYby3uOQ@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: btbcm: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER
 to CYW4373
To: Nobuaki Tsunashima <nobuaki.tsunashima@infineon.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nobuaki,

On Thu, Jul 4, 2024 at 9:16=E2=80=AFPM Nobuaki Tsunashima
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
> V4 -> V5: Use skb_pull_data() to access skb->data as safer manner.
> V3 -> V4: Fix a few coding style warnings and refine comments for clarify=
.
> V2 -> V3: Fix a few coding style warnings and change the subject as more =
specific.
> V1 -> V2: Fix several coding style warnings.
>
>  drivers/bluetooth/btbcm.c | 41 +++++++++++++++++++++++++++++++++++++--
>  drivers/bluetooth/btusb.c |  4 ++++
>  2 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 0a5445ac5e1b..dd7262a8dc8e 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -437,16 +437,53 @@ static const struct dmi_system_id disable_broken_re=
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

Can we have a little less verbose names? e.g. broken_read_tx_power and
btbcm_broken_read_tx_power sounds a lot better imo.

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
> +       u8 *chip_id;
> +       u16 *baseline;
>
>         /* Read Verbose Config Version Info */
>         skb =3D btbcm_read_verbose_config(hdev);
>         if (IS_ERR(skb))
>                 return PTR_ERR(skb);
> -
> -       bt_dev_info(hdev, "BCM: chip id %u", skb->data[1]);
> +       skb_pull_data(skb, 1);
> +       chip_id =3D skb_pull_data(skb, sizeof(*chip_id));
> +       skb_pull_data(skb, 1);
> +       baseline =3D skb_pull_data(skb, sizeof(*baseline));
> +
> +       if (chip_id) {
> +               bt_dev_info(hdev, "BCM: chip id %u", *chip_id);
> +
> +               if (baseline) {
> +                       /* Check Chip ID and disable broken Read LE Min/M=
ax Tx Power */
> +                       if (btbcm_is_disable_broken_read_tx_power_by_chip=
_ver(*chip_id, *baseline))
> +                               set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_PO=
WER, &hdev->quirks);
> +               }
> +       }
>         kfree_skb(skb);
>
>         return 0;
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
