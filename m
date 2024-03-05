Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0215A796
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Mar 2024 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677614; cv=none; b=HgmihPC83VKRGexBQwVYNK3ZC/JEvXiqqm1iJG30WRndpSzo8HxAXguugmSjAtwFvtpOamr9ch1IgxqC0eed4M1pmsnBgaQO473gKxMZBkW6OfsLDcVgZqfbxOfaX9H6pDkYPv868PEjYcjt9YzAEs1sys9HrB3S3b+yKpu008A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677614; c=relaxed/simple;
	bh=vuxEEQhF9ljQxrJBKANYSTLYdMr0KSL4+89DeODs4dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFI4if9RDNm7LZ4w1vjQYsr1qXvcXWCv+8b1XKvtl2Dz+cHJnKtnpsBx3R54lNiZ+MINAceYwKHIYeyReynwFUZYkjk1u31Zb+U53AftBdIcbd4eOxa6vYVKGezQM5rjJPM2OA4XrIo4IVcRMrrtV3mmeoTahcX6Nc3/m8EpXg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxfJ/Dfq; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxfJ/Dfq"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5135ab96dcbso260076e87.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Mar 2024 14:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709677611; x=1710282411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5IsMhS4qiyaxF7cAsLPGgyePF5EOexduNvIBvhLmfU=;
        b=NxfJ/DfqmUmtHmxGM3vvbdrlHmFJgOA6tufq7sJ61dsmwiUbTKoDSpj0tbSGxRdC5m
         hOitrR5REknLCSJfluPT/Wr9FzUlfIHweWDAfVON4uSm5MEfnvxJhYlFkzBsf/32TjFH
         l9kQRH4Uxj0I6aOI69LdXEYfEKnFwabsLk9XZsvhGHIPbYWzUJp6k5VVf97iZzEwJ67w
         5m6iUrGTqRB+jhhuv+N/DkD2/qlat3wGb1mg27qKqQXDyKBwVMKLcNKWumSUrrdAfqLE
         BJRd+BMkzdaiLKjBRgJC3o3+R5U3zgfb9Q9QKhFdFsbbthlmLCLmo+CT59v2RKj+HJNY
         yVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709677611; x=1710282411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5IsMhS4qiyaxF7cAsLPGgyePF5EOexduNvIBvhLmfU=;
        b=hgB93VbFwkFv/rd4vSwbvXRNE+pe2XrXqfUVkG4/v1X5jkJ/EfvaoBegjLHRwS5ED3
         Xg6Ydu9nYiGnY3wQrG8WIHzP+xQqMDnTz/s4yVsEv9XRFx9xH1gqIqfnSUJYhZaoZVmr
         f5ccZx+GmRybkDi/0w0DgYBDN0ggqLMGqlcUbyBtOZqkGMATMgel25t/uxC22z/dYmDP
         dx4hYJbP3YVxWzzKaVECFA66XveQh4iK0U/6uyOUC6Rrm0fxyBqgn1n4Jqkz9V3Azmhv
         RvOMM41zfLSYHAwyTHyOWAMbneF7zM2XESRWDo1+r8kOKd98ECBQy1ATHY9bhla0/416
         ziEw==
X-Gm-Message-State: AOJu0Yy7YPAeSpAljukngC12Aw8soHgvtvnyY2whaPCx96GwS00zk60O
	kFrHPN3xsef1VUZU327+d4AHgMY/pYw5m8MrhGO+e0OWUWNE2rmTQDIRhLZ1ll8l/wxDi92knEY
	/smtHWgPLq2mbrGbwSrKnptA8YvQ=
X-Google-Smtp-Source: AGHT+IEZCKubJazeiawtQ9EuG7IiB3KwQeH8CSJvK8+OjSlTB3kfvAIzp3l3nY1EDa0rP4QVP4NnWc14xR9FB9GPGDU=
X-Received: by 2002:ac2:46ca:0:b0:512:f389:d6e0 with SMTP id
 p10-20020ac246ca000000b00512f389d6e0mr1226389lfo.4.1709677610699; Tue, 05 Mar
 2024 14:26:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305144459.119564-1-kiran.k@intel.com> <20240305144459.119564-2-kiran.k@intel.com>
In-Reply-To: <20240305144459.119564-2-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 5 Mar 2024 17:26:37 -0500
Message-ID: <CABBYNZJC60s9m8D_KmYOT6R8+QY5_c5-4VgcgO8phpWD7ZTqWQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Bluetooth: btintel: Add support for downloading
 intermediate loader
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Tue, Mar 5, 2024 at 9:31=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> Some variants of Intel controllers like BlazarI supports downloading of
> Intermediate bootloader (IML) image. IML gives flexibility to fix issues =
as its
> not possible to fix issue in Primary bootloader once flashed to ROM. This=
 patch
> adds the support to download IML before downloading operational firmware =
image.
>
> dmesg logs:
> [13.399003] Bluetooth: Core ver 2.22
> [13.399006] Bluetooth: Starting self testing
> [13.401194] Bluetooth: ECDH test passed in 2135 usecs
> [13.421175] Bluetooth: SMP test passed in 597 usecs
> [13.421184] Bluetooth: Finished self testing
> [13.422919] Bluetooth: HCI device and connection manager initialized
> [13.422923] Bluetooth: HCI socket layer initialized
> [13.422925] Bluetooth: L2CAP socket layer initialized
> [13.422930] Bluetooth: SCO socket layer initialized
> [13.458065] Bluetooth: hci0: Device revision is 0
> [13.458071] Bluetooth: hci0: Secure boot is disabled
> [13.458072] Bluetooth: hci0: OTP lock is disabled
> [13.458072] Bluetooth: hci0: API lock is enabled
> [13.458073] Bluetooth: hci0: Debug lock is disabled
> [13.458073] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [13.458075] Bluetooth: hci0: Bootloader timestamp 2022.46 buildtype 1 bui=
ld 26590
> [13.458324] Bluetooth: hci0: DSM reset method type: 0x00
> [13.460678] Bluetooth: hci0: Found device firmware: intel/ibt-0090-0291-i=
ml.sfi
> [13.460684] Bluetooth: hci0: Boot Address: 0x30099000
> [13.460685] Bluetooth: hci0: Firmware Version: 227-11.24
> [13.562554] Bluetooth: hci0: Waiting for firmware download to complete
> [13.563023] Bluetooth: hci0: Firmware loaded in 99941 usecs
> [13.563057] Bluetooth: hci0: Waiting for device to boot
> [13.565029] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
> [13.565148] Bluetooth: hci0: Device booted in 2064 usecs
> [13.567065] Bluetooth: hci0: No device address configured
> [13.569010] Bluetooth: hci0: Found device firmware: intel/ibt-0090-0291.s=
fi
> [13.569061] Bluetooth: hci0: Boot Address: 0x10000800
> [13.569062] Bluetooth: hci0: Firmware Version: 227-11.24
> [13.788891] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [13.788897] Bluetooth: BNEP filters: protocol multicast
> [13.788902] Bluetooth: BNEP socket layer initialized
> [15.435905] Bluetooth: hci0: Waiting for firmware download to complete
> [15.436016] Bluetooth: hci0: Firmware loaded in 1823233 usecs
> [15.436258] Bluetooth: hci0: Waiting for device to boot
> [15.471140] Bluetooth: hci0: Device booted in 34277 usecs
> [15.471201] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
> [15.471487] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0090-0=
291.ddc
> [15.474353] Bluetooth: hci0: Applying Intel DDC parameters completed
> [15.474486] Bluetooth: hci0: Found Intel DDC parameters: intel/bdaddress.=
cfg
> [15.475299] Bluetooth: hci0: Applying Intel DDC parameters completed
> [15.479381] Bluetooth: hci0: Firmware timestamp 2024.10 buildtype 3 build=
 58595
> [15.479385] Bluetooth: hci0: Firmware SHA1: 0xb4f3cc46
> [15.483243] Bluetooth: hci0: Fseq status: Success (0x00)
> [15.483246] Bluetooth: hci0: Fseq executed: 00.00.00.00
> [15.483247] Bluetooth: hci0: Fseq BT Top: 00.00.00.00
> [15.578712] Bluetooth: MGMT ver 1.22
> [15.822682] Bluetooth: RFCOMM TTY layer initialized
> [15.822690] Bluetooth: RFCOMM socket layer initialized
> [15.822695] Bluetooth: RFCOMM ver 1.11
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 38 ++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btintel.h |  3 +++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index ed98bb867cff..00e98606cf02 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -521,6 +521,9 @@ static int btintel_version_info_tlv(struct hci_dev *h=
dev,
>                             version->min_fw_build_nn, version->min_fw_bui=
ld_cw,
>                             2000 + version->min_fw_build_yy);
>                 break;
> +       case IMG_IML:
> +               variant =3D "Intermediate loader";
> +               break;
>         case IMG_OP:
>                 variant =3D "Firmware";
>                 break;
> @@ -2194,10 +2197,26 @@ static void btintel_get_fw_name_tlv(const struct =
intel_version_tlv *ver,
>                                     char *fw_name, size_t len,
>                                     const char *suffix)
>  {
> +       const char *format;
>         /* The firmware file name for new generation controllers will be
>          * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step=
>
>          */
> -       snprintf(fw_name, len, "intel/ibt-%04x-%04x.%s",
> +       switch (ver->cnvi_top & 0xfff) {
> +       /* Only Blazar  product supports downloading of intermediate load=
er
> +        * image
> +        */
> +       case CNVI_BLAZARI:
> +               if (ver->img_type =3D=3D IMG_BOOTLOADER)
> +                       format =3D "intel/ibt-%04x-%04x-iml.%s";

Shouldn't iml be the extension rather than the name? Like in
intel/ibt-0090-0291.iml which you can probably achieve by just
replacing suffix, that said this function seems to be called with .ddc
as suffix as well so I assume there is some check preventing it to be
called while version is IMG_BOOTLOADER?

> +               else
> +                       format =3D "intel/ibt-%04x-%04x.%s";
> +               break;
> +       default:
> +                       format =3D "intel/ibt-%04x-%04x.%s";
> +               break;
> +       }
> +
> +       snprintf(fw_name, len, format,
>                  INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvi_t=
op),
>                                           INTEL_CNVX_TOP_STEP(ver->cnvi_t=
op)),
>                  INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvr_t=
op),
> @@ -2607,6 +2626,23 @@ static int btintel_bootloader_setup_tlv(struct hci=
_dev *hdev,
>         if (err)
>                 return err;
>
> +       err =3D btintel_read_version_tlv(hdev, ver);
> +       if (err)
> +               return err;
> +
> +       /* If image type returned is IMG_IML, then controller supports
> +        * intermediae loader image
> +        */
> +       if (ver->img_type =3D=3D IMG_IML) {
> +               err =3D btintel_prepare_fw_download_tlv(hdev, ver, &boot_=
param);
> +               if (err)
> +                       return err;
> +
> +               err =3D btintel_boot(hdev, boot_param);
> +               if (err)
> +                       return err;
> +       }
> +
>         btintel_clear_flag(hdev, INTEL_BOOTLOADER);
>
>         btintel_get_fw_name_tlv(ver, ddcname, sizeof(ddcname), "ddc");
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 52b2f1986f85..ae15b2253b6d 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -51,7 +51,10 @@ struct intel_tlv {
>         u8 val[];
>  } __packed;
>
> +#define CNVI_BLAZARI           0x900
> +
>  #define IMG_BOOTLOADER         0x01    /* Bootloader image */
> +#define IMG_IML                        0x02    /* Intermediate image */
>  #define IMG_OP                 0x03    /* Operational image */
>
>  struct intel_version_tlv {
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
