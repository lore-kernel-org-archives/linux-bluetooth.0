Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571571AE086
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896256; cv=none; b=cDOE0C/RiZtUlJBLeCu4MXjfpQaN2cua59Z0m9dxUy+MJSKe+fJM5Nvt5yz2owmsqMgTw3sHxua5QjJ6OpzFDEJ7yvGDMjndCeDMRb4i0R7wS4vfbN5QggHOnz8HFkvOCi3vkRwaSwOQwlINPouE8icLUeF0qyg7PAMp6mq7PAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896256; c=relaxed/simple;
	bh=jLtRHAoJTMJT1UQLvRetjwlkY79An8E3lIAr+utztT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLq++lNZa4dMscqWxu2GsDQIGQdTB2PygjwRJuzXxHWVjBY2Lyt/tx4QtyuvWRl6G9baKsWAAv+vFLJ1i/d462K2hvMpgyCGJzDs2FQclNXa2qW4b3H33Nj2RtiaZbqZO0eE/66PpzYiNMd7DXw79lYJrx5iGdcsLT/z+HxtHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aik7g5ko; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aik7g5ko"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so10786531fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718896252; x=1719501052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Bchqe4mUPSa01zAXk79qs3AYCxtywGajmvCX9HFkjs=;
        b=Aik7g5ko+wTK9hXYaQrN7UCI9NFqMxoqyGhP74at3FzwCIM2xM41Pha7KgQPjTG4bE
         hb/ow16oGmbWWLkjpJXQgvuY1IBbkoaJ5fAPqNBJIK7kEgR+H/iF5jS5gSQ0XGG4iKIz
         GP8Ddu3GhQ5mis3qVXWrCp8FZWrqSmFjrOjTH001sOjH2MlqdKDMCYTIEGUMsOriM9T0
         w7uuzOyD/UHpP6kaOZ+cT8LZ+FW/GhTlVgtS8gY3+cx+isJZ8YJp0njO30uytjfqydIa
         pu1aGZCsUnt97mTspAowi+V8PNOXK0CDJxRGKf+9gDeF6Xxh9ory0KEzj1CSfJpfLKWh
         Gqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896252; x=1719501052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Bchqe4mUPSa01zAXk79qs3AYCxtywGajmvCX9HFkjs=;
        b=ed07uqTtzkFAUhCIsSNSiHNg/QeCBz/3knlcr2JreBjS6z5I3cqDQ8ySVypS7CfgES
         30kEN7oIF7aisM7NAoyOQ5JOZu6398QHb8zWZuXXOGSDvFWz4XwsmX7Gg4jhybbcvC6Z
         8+9uvAHmCzl4y95cVNBH4QCHszpVE7jE+L4Hs6xqM1qh3q2Jepr3/YKGLVA6ay2r7K12
         ACk+hEbOnU9UGMuW8hYUmXvHVuljMc5wXUMeiFdEI6aWuYJR/9K50JsHCnVo2ti6MJNO
         ZSGUGL6wN8YVFQ7bXbDGwtQfGZ6NM2muGzo56/HxGXalkygP/2RH5RCaLq9VSdKwhAW9
         IlRw==
X-Gm-Message-State: AOJu0Yx56OXmCrXgFW32XDWdujZAngIGWYhFhz/9Z3aWUWy/A4o9Mb+D
	24IlDuGnY2qu63Pn0IQZWhAnDmKRA+OGA89LvgTWD/2rXX70VBBhAVWsS6fJDMGxn9xwTtc6Alr
	+UFiDpupuIFoPBOPiyDHV7gbxizMrSw==
X-Google-Smtp-Source: AGHT+IGzVKnY52xBe8q4cWD9FGLYuYrrlFVSt3scjmkQMdTaY1Euu3/DxmAFy/bbvtwotxpHCqA77/25Bbkd8qchj+0=
X-Received: by 2002:a2e:b0d5:0:b0:2eb:eb8b:738 with SMTP id
 38308e7fff4ca-2ec3cecc2ecmr35912161fa.29.1718896252305; Thu, 20 Jun 2024
 08:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620150635.2119398-1-kiran.k@intel.com>
In-Reply-To: <20240620150635.2119398-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Jun 2024 11:10:39 -0400
Message-ID: <CABBYNZJ1wxgEU0xQvtYc+gr1U886DpbTDJUGhszjY_5ifEuRXA@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Allow lowering of drive strength
 of BRI
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com, 
	vijay.satija@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Thu, Jun 20, 2024 at 10:52=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> BRI (Bluetooth Radio Interface) traffic from CNVr to CNVi was found
> causing cross talk step errors to WiFi. As a workaround, driver needs to
> reduce the drive strength of BRI. During *setup*, driver reads the drive
> strength value from efi variable and passes it controller via vendor
> specific command with opcode 0xfc0a.
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 115 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 5d735391545a..1d6586b30c8d 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -12,6 +12,8 @@
>  #include <linux/acpi.h>
>  #include <acpi/acpi_bus.h>
>  #include <asm/unaligned.h>
> +#include <linux/efi.h>
> +
>
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> @@ -49,6 +51,39 @@ static const guid_t btintel_guid_dsm =3D
>         GUID_INIT(0xaa10f4e0, 0x81ac, 0x4233,
>                   0xab, 0xf6, 0x3b, 0x2a, 0xc5, 0x0e, 0x28, 0xd9);
>
> +static void *btintel_uefi_get_variable(efi_char16_t *name, efi_guid_t *g=
uid)
> +{
> +#if defined(CONFIG_EFI)

iirc IS_ENABLED is normally preferred over #if defined, well except if
you have undefined symbols but that usually indicates the APIs have
not been done with usage of IS_ENABLED in mind.

> +       void *data;
> +       efi_status_t status;
> +       size_t data_size =3D 0;
> +
> +       if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
> +               return ERR_PTR(-EOPNOTSUPP);
> +
> +       status =3D efi.get_variable(name, guid, NULL, &data_size, NULL);
> +
> +       if (status !=3D EFI_BUFFER_TOO_SMALL || !data_size)
> +               return ERR_PTR(-EIO);
> +
> +       data =3D kmalloc(data_size, GFP_KERNEL);
> +
> +       if (!data)
> +               return ERR_PTR(-ENOMEM);
> +
> +       status =3D efi.get_variable(name, guid, NULL, &data_size, data);
> +
> +       if (status !=3D EFI_SUCCESS) {
> +               kfree(data);
> +               return ERR_PTR(-ENXIO);
> +       }
> +
> +       return data;
> +#else
> +       return ERR_PTR(-EOPNOTSUPP);
> +#endif
> +}
> +
>  int btintel_check_bdaddr(struct hci_dev *hdev)
>  {
>         struct hci_rp_read_bd_addr *bda;
> @@ -2615,6 +2650,80 @@ static u8 btintel_classify_pkt_type(struct hci_dev=
 *hdev, struct sk_buff *skb)
>         return hci_skb_pkt_type(skb);
>  }
>
> +static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_t=
lv *ver)
> +{
> +       struct btintel_dsbr_cmd {
> +               u8 enable;
> +               u8 dsbr;
> +       } __packed;
> +
> +       struct btintel_dsbr {
> +               u8 header;
> +               u32 dsbr;
> +       } __packed;
> +
> +       struct btintel_dsbr *dsbr;
> +       struct btintel_dsbr_cmd cmd;
> +       struct sk_buff *skb;
> +       u8 status;
> +       efi_guid_t guid =3D EFI_GUID(0xe65d8884, 0xd4af, 0x4b20, 0x8d, 0x=
03,
> +                                  0x77, 0x2e, 0xcc, 0x3d, 0xa5, 0x31);
> +
> +       memset(&cmd, 0, sizeof(cmd));
> +       dsbr =3D btintel_uefi_get_variable(L"UefiCnvCommonDSBR", &guid);
> +       if (IS_ERR(dsbr)) {
> +               /* If efi variable is not present, driver still needs to =
send
> +                * 0xfc0a command with default values
> +                */
> +               bt_dev_dbg(hdev, "Error reading efi DSBR (%ld)",
> +                          PTR_ERR(dsbr));
> +               dsbr =3D NULL;
> +       }
> +
> +       if (dsbr) {
> +               /* bit0: 0 - Use firmware default value
> +                *       1 - Override firmware value
> +                * bit3:1 - Reserved
> +                * bit7:4 - DSBR override values
> +                * bt31:7 - Reserved
> +                */
> +               cmd.enable =3D dsbr->dsbr & BIT(0);
> +               if (cmd.enable)
> +                       cmd.dsbr =3D dsbr->dsbr >> 4 & 0xF;
> +               kfree(dsbr);
> +       }
> +
> +       bt_dev_info(hdev, "dsbr: enabled: 0x%2.2x value: 0x%2.2x", cmd.en=
able,
> +                   cmd.dsbr);
> +
> +       skb =3D __hci_cmd_sync(hdev, 0xfc0a, sizeof(cmd), &cmd,  HCI_CMD_=
TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_err(hdev, "Failed to send Intel DSBR command (%ld)=
",
> +                          PTR_ERR(skb));
> +               return -bt_to_errno(PTR_ERR(skb));
> +       }
> +
> +       status =3D skb->data[0];
> +       kfree_skb(skb);
> +
> +       if (status) {
> +               bt_dev_err(hdev, "Set DSBR failed 0x%2.2x", status);
> +               return -bt_to_errno(status);
> +       }
> +       return 0;
> +}
> +
> +static int btintel_apply_dsbr(struct hci_dev *hdev,
> +                             struct intel_version_tlv *ver)
> +{
> +       /* For BlazarI + B0 step, DSBR command needs to be sent just afte=
r
> +        * downloading IML firmware
> +        */
> +       return ver->img_type =3D=3D BTINTEL_IMG_IML &&
> +               ((ver->cnvi_top & 0xfff) =3D=3D BTINTEL_CNVI_BLAZARI) &&
> +               INTEL_CNVX_TOP_STEP(ver->cnvi_top) =3D=3D 0x01;
> +}
> +
>  int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>                                  struct intel_version_tlv *ver)
>  {
> @@ -2649,6 +2758,12 @@ int btintel_bootloader_setup_tlv(struct hci_dev *h=
dev,
>         if (err)
>                 return err;
>
> +       if (btintel_apply_dsbr(hdev, ver)) {
> +               err =3D btintel_set_dsbr(hdev, ver);
> +               if (err)
> +                       return err;
> +       }
> +
>         /* If image type returned is BTINTEL_IMG_IML, then controller sup=
ports
>          * intermediae loader image
>          */
> --
> 2.40.1
>
>


--=20
Luiz Augusto von Dentz
