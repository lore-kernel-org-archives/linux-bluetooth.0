Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792792201;
	b=42Mz3b9Qw4kTYkJhNczGff3CNFScN0Lj78DQmowx6Ed4ePyLmldxVX0yUFl7QVKt9zqX
	 Sm5Cz5i9fln0hMVpCUfme/N1L47awd9dkr/di4jecVUpsO2SjKizHbrjVy4wf39ZWgsLp
	 qRaiNcIfDuz+T020rfcRhd3zekRpWPg1t39ZZx2pvi8L5FbIMxee3WYY+1KxaWoYLD097
	 //8hGUGYhLR8eluyd89EY31QLqS2d3VmJCmIdZ2ErGfz0ThzdFQb6b/cI9nPDaFeiEqXW
	 lD1mylyEq55FdKM/RhhJ/c7k5aa99dpfeZMTdnXtQ2j68esJsXmcrCFeQKQV8XkT5Zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=dntQEeU5/kjDyK6LEE0hWhBexdIkWEZ7UhgVj/CU25A=;
	b=HIQAbsG7zsVJorOi3NDWWXHlWsuVRUgUSHA+yk6zvYzIJJPTXIdurw4wRebx2H6UhOge
	 4xRtHebeWTJGWdomLIxrVq/J5d2vwdSZRwGrotM4IJV0fmdg9bTkrtb2dUXuNBPG5dzpj
	 fD8ePodpUPMk8OfP5NHp/BRw4FYS1/Wuc/zbdK48vFfxAL3MIubaQ6MhHdPV1nTyhSvOu
	 nKKYqacwfzNr7qq9TKIb/nky91Okhu4dzgzqn+7MZLc6VCMzD21PpsvlaIJA4fWROENJM
	 wh4LsIr7mEEZotAM5cYidJsR65VaCo6pud9SAWj4OdPoobMBcnQHIqBw7VQ0QELRI6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pOcEDQgv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB102606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 21:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB102606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pOcEDQgv
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8ab3d3c5761so12682577b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 14:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792792200; cv=none;
        d=google.com; s=arc-20260327;
        b=R3Ym6nAK1S/zjTeGkgD8YXQQMHuVKaiCC7/96pD/CZea5qWpPr8dvm5asirvj5ju8z
         54P3+icLNwZfLelE+VQNEM/ssCjD2aPJnu86ruDNogxhGf5TmrlI6xVbamb191pzvUzr
         8x/Y41/i8ukhynCJnBowMguEM2KoZYDiqCcQSrmQk4LiG9ooCCabyZD2jFmSqhHSsZn4
         AS2w6I/6M+N/FCEqzrV+b6UMHc+hgd0tLj5ltJhAoP5TiJPK8S0ZYTNVDiJ23wdB0jbR
         7jb6Jwff5/s3Tsm2kom1Gg+/Mtr6wS/2zGIqh2APki+/WsL6BeD4dfphCR9+fugepNfP
         ftMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dntQEeU5/kjDyK6LEE0hWhBexdIkWEZ7UhgVj/CU25A=;
        fh=e+OqhA/hIj9QeOk5DC93/7MC+EmHyQHXuM88IIv3FDk=;
        b=kXADijK+KjdFRKSKeoegx2+NgveY2DrH5I6wgFPFf9YFuQS0rGu7ApiebdkqVW8zRd
         B8FtcIhmavIpcSI9RAyWWcDq2mIG53FoidlJRCLeok+bSrDpbdUWfiqvbZfZnT3O4QGX
         buM0laupJiuRGpAF7hwkE6jxmX9boqstCab+6t5yv3FR354cvS/6UO6BH3hpWnaiD0Nn
         LJWJwDjvdyfiL1i1gsrfd4VI6ceqOGBYNq2WUA14xeriGd9hAZUpTivfk6CduWjw6jmM
         wHxOlm8Yq/umDvZptK4WjYDQ7T3wpnrYI1uTyoyphX4fZwcf328SmrPpX9+A9ST5ncfH
         B8QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792792200; x=1793397000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dntQEeU5/kjDyK6LEE0hWhBexdIkWEZ7UhgVj/CU25A=;
        b=pOcEDQgvuYWeQ4MS/OGsfC0lgP2PSv1XXm6W9FATzvhd87Q3+Yyn7m3LK7CYmn+eim
         tUsgHNsUG9eztOJ8XxswEyS8RupFhepENQoWRVSYujAMkDdrfsBrshkI9P9frp8l5jAM
         2jlmJpc+PTWEhirxhcUfKxuox6nYe7B8GSzZ29Hl7E5zZ09j+fEW7KLz1I4UPaCtDSUw
         hKEtbblhnj+SgHFSZt6HK6D10Ctj1nvlNooHkpolupePtjUJEqPisvCoPFuHUdZLLM4O
         lDXhdhWrRILx2SL2sW4rxA1188nGoQPsOP6wsdcJ2lazdMc32mKgO4/PwH6a05sfe/Yt
         EONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792792200; x=1793397000;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dntQEeU5/kjDyK6LEE0hWhBexdIkWEZ7UhgVj/CU25A=;
        b=tRDJbGykcA/5p4Nb3RF7eHfSinyqy2dFRinbmGkOocvTD84bBT16Pu9MIl16q8lLoL
         UEiTfO5zwz2JULvdvZDTSyKTGNWA/vpUVcRy+fSZNfFM6OLkZhu0GxkbRqPl7BcqTk2L
         ZNnyr1QVIBOBrEjU3drKQ45UhH6Agj3BxX9025YiSKUbbQ+HtB5d/74OdNRMIrjbC5S9
         u6J0xpBoT7s/LuUmLHabhU77+vGe7Dx0rIYh9l2xVE0j8WTdIKUFmpMk9W3xNmrVG5k5
         xDpq/oE6t+K24qDUFbDcKq8ziH6E90Xc6LWfwiJM0f/r2Ky81H/HsushsThQFwD5tHnm
         5yyw==
X-Gm-Message-State: AFq9FYJWWvApN4BQ8Aw5PIrzIkMo2ihTKmCW13ZbHX1iD1mHHQfKCZft
	zaeSNkk8ka2SR2rr59bMtLBc3C695O6+hWjimpRZiJDHx2SdarxN2nJwdzUk0z+C3okbVbl43SV
	pUYBMl/YBnJVb+EIO8QuSxXRXOnh2Gd0=
X-Gm-Gg: AYBFou2d3umpgNp79nobN/EgVPf0apbdYFsd54nYvGGGlSbkizRoz2AIYlOFJyGXRHe
	m1xPQozHjsuaAklnwmuDj+DLKatiayDNi6QKPW98+5ljWjsKYJHHIooT9i7aCKPWt1oPKHJcoYR
	aXyhXTJsTIAhgG1PACWxFoQkNDBY+DWUKHXb0WtG3FgmDiMZsuxXgFOmxmkVpawIWOGYNg9ZKT6
	4Zlxgr8j/aZll3g/SWmHiqW1bMuFGkCd1BX3G8cw2j8XWaBXXKl2yx7rwOZp61kTC/TcoAqMzv+
	VycH+1sCs19kYR9CvAItUeWgyLZUtgcwwfFq+xa4hH9QAppUzgVm/WNhIq7puNQ9wJGJW6+p0au
	JAZyCbUzGx1gPvjpSRkG5O2oHrqRcc1B2NFCubCGhkw+BigQP6+PNLAgSPQ6UvMLa0VyYeAm7xZ
	6pTdaOLxUkSNii3Qp/KLsIwyc=
X-Received: by 2002:a05:690c:89:b0:8b0:e13c:2854 with SMTP id
 00721157ae682-8b1669e55a4mr4464847b3.5.1792792199813; Fri, 23 Oct 2026
 14:49:59 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021130424.3042597-1-kiran.k@intel.com>
In-Reply-To: <20261021130424.3042597-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 23 Oct 2026 17:49:48 -0400
X-Gm-Features: AclHuK-ORHZ-ZSZkO1hSbniPLfe8xSOJYPR5K9SYRDogCDN01UPKw_WxKKzMPQk
Message-ID: <CABBYNZ+_FwM9U-eCwRrq7z_U92y_msrcSFF_kes=O+TnnkPasA@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: check FIPS status before firmware download
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com, 
	chandrashekar.devegowda@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Wed, Oct 21, 2026 at 9:02=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> Intel Bluetooth controllers (PCIe and USB) from Scorpius Peak2 onwards
> report bootloader self-test results (CRC, security, patch) in the
> INTEL_TLV_FIPS_STS TLV of the Intel Read Version event. Act on them
> before firmware download:
>
>   1. CRC failure      -> abort download.
>   2. Security failure -> abort on USB / HW reset and retry on PCIe.
>   3. Patch failure    -> abort on USB / HW reset and retry on PCIe.
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c      | 66 +++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btintel.h      | 10 +++++
>  drivers/bluetooth/btintel_pcie.c | 18 ++++++++-
>  3 files changed, 90 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 0709fb3212f9..f6deb3d7c5a0 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -485,10 +485,18 @@ int btintel_read_version(struct hci_dev *hdev, stru=
ct intel_version *ver)
>  }
>  EXPORT_SYMBOL_GPL(btintel_read_version);
>
> +/* FIPS self-test status is only reported by ScP2 onwards, except Blazar=
IW */
> +static bool btintel_fips_status_supported(u8 hw_variant)
> +{
> +       return hw_variant >=3D BTINTEL_HWID_SCP2 && hw_variant !=3D BTINT=
EL_HWID_BZRIW;
> +}
> +
>  int btintel_version_info_tlv(struct hci_dev *hdev,
>                              struct intel_version_tlv *version)
>  {
>         const char *variant;
> +       bool fips_status =3D false;
> +       u8 hw_variant;
>
>         /* The hardware platform number has a fixed value of 0x37 and
>          * for now only accept this single value.
> @@ -505,7 +513,8 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
>          * This check has been put in place to ensure correct forward
>          * compatibility options when newer hardware variants come along.
>          */
> -       switch (INTEL_HW_VARIANT(version->cnvi_bt)) {
> +       hw_variant =3D INTEL_HW_VARIANT(version->cnvi_bt);
> +       switch (hw_variant) {
>         case 0x17:      /* TyP */
>         case 0x18:      /* Slr */
>         case 0x19:      /* Slr-F */
> @@ -521,10 +530,13 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
>                 break;
>         default:
>                 bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%=
x)",
> -                          INTEL_HW_VARIANT(version->cnvi_bt));
> +                          hw_variant);
>                 return -EINVAL;
>         }
>
> +       fips_status =3D btintel_fips_status_supported(hw_variant) &&
> +               version->img_type =3D=3D BTINTEL_IMG_BOOTLOADER;
> +
>         switch (version->img_type) {
>         case BTINTEL_IMG_BOOTLOADER:
>                 variant =3D "Bootloader";
> @@ -584,6 +596,9 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
>
>         bt_dev_info(hdev, "Unlock policy: 0x%2.2x", version->unlock_polic=
y);
>
> +       if (fips_status)
> +               bt_dev_info(hdev, "crc status: %u security status: %u pat=
ch status: %u",
> +                           version->crc_sts, version->sec_sts, version->=
patch_sts);
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
> @@ -612,6 +627,7 @@ static u8 btintel_version_tlv_min_len(u8 type)
>         case INTEL_TLV_UNLOCK_POLICY:
>                 return sizeof(u8);
>         case INTEL_TLV_MIN_FW:
> +       case INTEL_TLV_FIPS_STS:
>                 return 3;
>         case INTEL_TLV_OTP_BDADDR:
>                 return sizeof(bdaddr_t);
> @@ -720,6 +736,11 @@ int btintel_parse_version_tlv(struct hci_dev *hdev,
>                 case INTEL_TLV_GIT_SHA1:
>                         version->git_sha1 =3D get_unaligned_le32(tlv->val=
);
>                         break;
> +               case INTEL_TLV_FIPS_STS:
> +                       version->crc_sts =3D tlv->val[0];
> +                       version->sec_sts =3D tlv->val[1];
> +                       version->patch_sts =3D tlv->val[2];
> +                       break;
>                 case INTEL_TLV_FW_ID:
>                         snprintf(version->fw_id, sizeof(version->fw_id),
>                                  "%.*s", tlv->len, tlv->val);
> @@ -3831,6 +3852,43 @@ void btintel_print_fseq_info(struct hci_dev *hdev)
>  }
>  EXPORT_SYMBOL_GPL(btintel_print_fseq_info);
>
> +int btintel_check_fips_status(struct hci_dev *hdev,
> +                             struct intel_version_tlv *ver)
> +{
> +       u8 hw_variant;
> +
> +       /* FIPS status is reported only in the bootloader image */
> +       if (ver->img_type !=3D BTINTEL_IMG_BOOTLOADER)
> +               return 0;
> +
> +       hw_variant =3D INTEL_HW_VARIANT(ver->cnvi_bt);
> +
> +       if (!btintel_fips_status_supported(hw_variant))
> +               return 0;
> +
> +       /* 0 -> Test not executed
> +        * 1 -> Test executed and it passed
> +        * any other value -> Test failed
> +        */
> +       if (ver->crc_sts > 1) {
> +               bt_dev_err(hdev, "crc test failed: %u", ver->crc_sts);
> +               return -ENOEXEC;
> +       }
> +
> +       if (ver->sec_sts > 1) {
> +               bt_dev_err(hdev, "security test failed: %u", ver->sec_sts=
);
> +               return -EAGAIN;
> +       }
> +
> +       if (ver->patch_sts > 1) {
> +               bt_dev_err(hdev, "patch test failed: %u", ver->patch_sts)=
;
> +               return -EAGAIN;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(btintel_check_fips_status);
> +
>  static int btintel_setup_combined(struct hci_dev *hdev)
>  {
>         const u8 param[1] =3D { 0xFF };
> @@ -4055,6 +4113,10 @@ static int btintel_setup_combined(struct hci_dev *=
hdev)
>                 /* Display version information of TLV type */
>                 btintel_version_info_tlv(hdev, &ver_tlv);
>
> +               err =3D btintel_check_fips_status(hdev, &ver_tlv);
> +               if (err)
> +                       goto exit_error;
> +
>                 /* Apply the device specific HCI quirks for TLV based dev=
ices
>                  *
>                  * All TLV based devices support WBS
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 9526acf65959..d5e125ec5168 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -43,6 +43,7 @@ enum {
>         INTEL_TLV_OTP_BDADDR,
>         INTEL_TLV_UNLOCKED_STATE,
>         INTEL_TLV_GIT_SHA1,
> +       INTEL_TLV_FIPS_STS =3D 0x3b,
>         INTEL_TLV_UNLOCK_POLICY =3D 0x3c,
>         INTEL_TLV_PLATFORM_ID =3D 0x3d,
>         INTEL_TLV_FW_ID =3D 0x50
> @@ -112,6 +113,7 @@ struct intel_version_tlv {
>         bdaddr_t otp_bd_addr;
>         u8      unlock_policy;
>         u8      platform_id[6];
> +       u8      crc_sts, sec_sts, patch_sts;
>  };
>
>  struct intel_version {
> @@ -331,6 +333,8 @@ int btintel_shutdown_combined(struct hci_dev *hdev);
>  void btintel_hw_error(struct hci_dev *hdev, u8 code);
>  void btintel_print_fseq_info(struct hci_dev *hdev);
>  int btintel_acpi_reset_method(struct hci_dev *hdev);
> +int btintel_check_fips_status(struct hci_dev *hdev,
> +                             struct intel_version_tlv *ver);
>  #else
>
>  static inline int btintel_check_bdaddr(struct hci_dev *hdev)
> @@ -468,4 +472,10 @@ static inline int btintel_acpi_reset_method(struct h=
ci_dev *hdev)
>  {
>         return -ENODEV;
>  }
> +
> +static inline int btintel_check_fips_status(struct hci_dev *hdev,
> +                                           struct intel_version_tlv *ver=
)
> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index df95d16a163c..73822ba2acbb 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -3786,7 +3786,8 @@ static int btintel_pcie_get_debug_info_addr(struct =
hci_dev *hdev)
>         return err;
>  }
>
> -static int btintel_pcie_setup_internal(struct hci_dev *hdev)
> +static int btintel_pcie_setup_internal(struct hci_dev *hdev,
> +                                      bool *fips_crc_failed)
>  {
>         struct btintel_pcie_data *data =3D hci_get_drvdata(hdev);
>         const u8 param[1] =3D { 0xFF };
> @@ -3794,6 +3795,8 @@ static int btintel_pcie_setup_internal(struct hci_d=
ev *hdev)
>         struct sk_buff *skb;
>         int err;
>
> +       *fips_crc_failed =3D false;
> +
>         BT_DBG("%s", hdev->name);
>
>         skb =3D __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> @@ -3855,6 +3858,12 @@ static int btintel_pcie_setup_internal(struct hci_=
dev *hdev)
>                 /* Display version information of TLV type */
>                 btintel_version_info_tlv(hdev, &ver_tlv);
>
> +               err =3D btintel_check_fips_status(hdev, &ver_tlv);
> +               if (err) {
> +                       *fips_crc_failed =3D (err =3D=3D -ENOEXEC);
> +                       goto exit_error;
> +               }
> +
>                 /* Apply the device specific HCI quirks for TLV based dev=
ices
>                  *
>                  * All TLV based devices support WBS
> @@ -3900,8 +3909,13 @@ static int btintel_pcie_setup(struct hci_dev *hdev=
)
>  {
>         int err, fw_dl_retry =3D 0;
>         struct btintel_pcie_data *data =3D hci_get_drvdata(hdev);
> +       bool fips_crc_failed;
> +
> +       while ((err =3D btintel_pcie_setup_internal(hdev, &fips_crc_faile=
d)) &&
> +              fw_dl_retry++ < 1) {
> +               if (fips_crc_failed)
> +                       break;
>
> -       while ((err =3D btintel_pcie_setup_internal(hdev)) && fw_dl_retry=
++ < 1) {
>                 bt_dev_err(hdev, "Firmware download retry count: %d",
>                            fw_dl_retry);
>                 btintel_pcie_dump_debug_registers(hdev);
> --
> 2.54.0

Looks like the second instance of sashiko from netdev catch a problem:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021130424.3042597-=
1-kiran.k%40intel.com

--=20
Luiz Augusto von Dentz
