Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4013815D0
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387875; cv=pass; b=CU3rwiaH52iHYc3NV7rF8M4EL0vpRkBcQuW6LslPY33t9NoIqzdDZ8Pdn+Qxb7kEBiYzmY9TLjNSgvsWg0vdGbH6BiXnsX6xjeigyiEFVRkJKbAc2Hys2MAcjxwe6rg9pETX9k4jM6LX5HzyBTGrGoZn/347ZANQjHfdchfacwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387875; c=relaxed/simple;
	bh=iHnaRSIkdbgUFeK5EBvMFGfrzG3huj1QvOgcFwqV+bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KphruvYYos6AkRMWyidjqeURGfDMZFibKYsSriWSU8hWVGydYQdnWwQWk/1Ah/F1CuCTK9KuMscsxhsNt4kbEZF5iUZXrLYIS07YJBDl7vKs11XVjou+1h5J/g/jlDLCBoG/xuTOQUugOxw2V57cceZX6JxJe9VbytdQRtYlpiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBe5WEU1; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBe5WEU1"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-836ce6cbe1eso21751137b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 08:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791387871; cv=none;
        d=google.com; s=arc-20260327;
        b=J4aqiNWy+dS/AoknLKqGWD+ke9ei2/6xzrnUJQvbW6XzwRHmuEZZ2J4r3C0Qd3r9EW
         wXWGjGkFEsedOWobBU299gt3fgCfxcOCe3TP6P+ZxEvN34K+sIcKv7iKoaontFSQpCY7
         zjwZJ/YuxJTdGs19rQyejzb3kHjT2v5UyLigP1jW1aJeUTqx2dyOkIsdieJt/kLQdqxX
         xGaKWs1ovH7JlGAlNGyrtmTTrgivi0OPJFDpOBRKZw0btiRqb8X9lr1qaa5nFgMUEmFO
         wTU0cbsvU5mgnjlpWuTMFC18kpazxffBtZva0uQuOd5t4FGmDNKpkNA47z2yI3TNdS9N
         FV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uj0q99pRzd2OhAPeKAKaDTTIE4ZFDBJpz0EgNUZL5PA=;
        fh=4FIVDCMwcNku3Ck42oqGTL5zJeaPTUMSwL20JoVbcJE=;
        b=GLTldlyYikcBcLXnzP4ie88vo6quFZCGrxJwa+OxuSMleUAzaYAzG0jeIMnUbuDvJT
         S8pyU+gmS1IGnmEHNGjqaNzgeh4MWFKuNQc58RY795JsZ9wzMDmm6csLYUTb95AbPsDP
         88heEI98/5nW2RO5Cux5vob8LFW/3HnO0gI61WzNfZNfMbbjWWOMKUS1rkyNzusYa1H+
         JsiBwyIrQc5VbX2i6ENq0KAihh+FVR7EJnhoztmUjeZb1MEA2R5aoDEkCR+CWbsgV1FG
         pv5k0YIOQDvcBMK/yPwZFxpWHavLBRDY8b29hxQIr3tE53OLidduh31lo6GZlj/Vs8Be
         IQoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791387871; x=1791992671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uj0q99pRzd2OhAPeKAKaDTTIE4ZFDBJpz0EgNUZL5PA=;
        b=HBe5WEU1/MPzFYlq2TJNpGOahGUyjZb3cOURiLi0O8BLMnmRqZ1LOOgkHmrtKxh5to
         uMvawnq0V1eQQG/e9iiYSkGE2MNR2TXnq38PkLWoqAbn2wQcBZzRDi7nugz+nfeiiJm0
         DtPMtssksInIwEEMXzhOSzf2hItpPWwkyFapvJSlqrb1BvA3boIQ0nlSX8dnkQEWSyPI
         WtMCrOEBSNwRX8xxpV70amqmitzopKN4c+OUYqEPRTk/aYfHR935CaddGZ3SoY5amJ8Z
         KeXMgPeIxR4SyD4/satpystmSJp1Aa5AN8JCDwLB9WYcJJEsaU+OBszrSFcitpTXFR4c
         N1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791387871; x=1791992671;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uj0q99pRzd2OhAPeKAKaDTTIE4ZFDBJpz0EgNUZL5PA=;
        b=bdYZ9cCKymhdesDLl9sVMgZheKJrO63+TIgPR3w/lkr7ZBgUe9GNkH7GsjxPbNyqzL
         ISIK7OTwzos2ipIsFJMVOTlqr6o4wSdB/rVL106kGT0AFv1bWeX1LatWs3Mlu97bmHQc
         lCsZbv7obUcjKEl+ByoO5Boc/ahopVm9Z8qnKWJR11uBuAUejcsnlu0mNQ+LK1+NyJk7
         t9FtVU5d9kEC430SbYfflUCjcNYNBsS6ZA7gGFA7JEipOy7IHeGbi+YlhDoqj2IcdJ/X
         HK21JUZgB6pHQTGFcKdn8hJJeyFvpkLbLhhwMiSwdTtWpv0uEY91aNPh/hliCgEQDjLa
         6Dcw==
X-Gm-Message-State: AFq9FYJfgr8pPQtKXDtBuvx8/dnstzJvEP2WwIOMJMlbiSkv8iI1kzmV
	AeA6+hIZksMmuEGU8wusfCn7Jmqv4oa4MYt68zhoQ95YmtMb+cdJbqNSy2+LPls6UKlLIG4/8ER
	iXYM0Esxu6BgFbg5nyOa41zQSeuQsxo4=
X-Gm-Gg: AYBFou2Po8PMA9Rnqq1iwFfvRRZ1vw/j/tZ3XFl2xNTkHDSN4Pe4qKuQQxfNzkUpw47
	LILUXSjoxh/HCHN1wymJvbyyg+J6kll+xUzu670HiNKVtIMFncShlrTO41JgSDb3oDTPf/rD/gH
	ikyTLjZs9T4pFvK+wc1BBKP2ZNgX/tx+NoTF8U7TpeKZ8pTfEWom6rd91Y58knpghyi/Nkfqoy9
	+I4GSmQg3jq/zhEBBxLj4JibN7bH2kx1ktkZy7ouGmSXsC9lbtH6PnT13r7N0alg8KVD4ZkrLht
	qj7Yop7aLuOtSxz8gcULi2+W19cfeBEzwwVG4+st8+64CcJkay4jWK36JgOmGHu8iylhtczrYiZ
	D9EOoY7an7BsPLNdbXu/2KsXf2eSu17rAH5P2TWxkhw==
X-Received: by 2002:a05:690c:c3c4:b0:8af:18b5:d5e3 with SMTP id
 00721157ae682-8b05b085badmr15565297b3.68.1791387870960; Wed, 07 Oct 2026
 08:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007124721.2521956-1-kiran.k@intel.com>
In-Reply-To: <20261007124721.2521956-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 7 Oct 2026 11:44:19 -0400
X-Gm-Features: AclHuK8iPy_DyCklHCKGdRGyoBYpuupmTt4OOCQvhWdJojbH_FkVAfEDVhmv9Ew
Message-ID: <CABBYNZKOm_5Zcfe_etmR3dtBScajZRysfXxJbSVvG80WVMO-nQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btintel: load unlocker.sfi to allow
 unsigned firmware
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com, 
	chandrashekar.devegowda@intel.com, Ravindra <ravindra@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Wed, Oct 7, 2026 at 8:44=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> When an unsigned operational firmware image is needed for debug, the
> controller requires intel/unlocker.sfi to be loaded first. Without the
> unlocker image, the controller rejects the unsigned operational firmware.
>
> Support both firmware download flows based on the unlock policy advertise=
d
> in the version TLV:
>
>   BlazarI/BlazarIW/BlazarU/Gale Peak (unlock_policy =3D=3D 0):
>       Boot ROM -> unlocker.sfi -> IML -> OPFW
>
>   Scorpius Peak onwards (unlock_policy =3D=3D 1):
>       Boot ROM -> IML -> unlocker.sfi -> OPFW
>
> Parse the new INTEL_TLV_UNLOCK_POLICY and INTEL_TLV_PLATFORM_ID TLVs
> into struct intel_version_tlv, track the pending unlocker load through
> a new btintel_data::unlocker flag, and pick intel/unlocker.sfi as the
> firmware filename when that flag is set. If the unlocker image is not
> present in the firmware search path, the driver silently falls through
> to the normal firmware download path. If the unlocker image is present
> but fails to download to the controller, the driver logs the error and
> aborts bootloader setup, since continuing would leave the controller in
> an inconsistent state.
>
> [  413.375247] Bluetooth: hci0: Found device firmware: intel/unlocker.sfi
> [  413.501051] Bluetooth: hci0: Waiting for firmware download to complete
> [  413.501058] Bluetooth: hci0: Firmware loaded in 122864 usecs
> [  413.501537] Bluetooth: hci0: Found device firmware: intel/ibt-02a2-01a=
1.sfi
> [  413.501547] Bluetooth: hci0: Boot Address: 0x10001000
> [  413.501548] Bluetooth: hci0: Firmware Version: 137-39.26
> [  414.103473] Bluetooth: hci0: Waiting for firmware download to complete
> [  414.103478] Bluetooth: hci0: Firmware loaded in 587841 usecs
> [  414.149576] Bluetooth: hci0: Applying Intel DDC parameters completed
> [  414.150089] Bluetooth: hci0: Firmware timestamp 2026.39 buildtype 3 bu=
ild 86921
> [  414.150092] Bluetooth: hci0: Firmware SHA1: 0xeb2e0a4b
> [  414.150093] Bluetooth: hci0: Platform ID: 570c6ffbcbe6
> [  414.150094] Bluetooth: hci0: Fseq status: Success (0x00)
> [  414.150730] Bluetooth: hci0: Fseq executed: 15.255.00.98
> [  414.150734] Bluetooth: hci0: Fseq BT Top: 06.32.00.02
>
> Assisted-by: Copilot:Claude Opus 4.7
> Signed-off-by: Ravindra <ravindra@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v3:
> - Address Sashiko review comments
>   https://sashiko.dev/#/patchset/20260929021056.1396791-1-kiran.k%40intel=
.com
> changes in v2:
> - Updated commit message
>
>  drivers/bluetooth/btintel.c | 94 +++++++++++++++++++++++++++++++++++--
>  drivers/bluetooth/btintel.h |  5 ++
>  2 files changed, 96 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index f298c91f4f4e..3bc59a2f3ba8 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -579,6 +579,11 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
>         if (version->img_type =3D=3D BTINTEL_IMG_OP)
>                 bt_dev_info(hdev, "Firmware SHA1: 0x%8.8x", version->git_=
sha1);
>
> +       if (!mem_is_zero(version->platform_id, sizeof(version->platform_i=
d)))
> +               bt_dev_info(hdev, "Platform ID: %6phN", version->platform=
_id);
> +
> +       bt_dev_info(hdev, "Unlock policy: 0x%2.2x", version->unlock_polic=
y);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
> @@ -604,11 +609,14 @@ static u8 btintel_version_tlv_min_len(u8 type)
>         case INTEL_TLV_DEBUG_LOCK:
>         case INTEL_TLV_LIMITED_CCE:
>         case INTEL_TLV_SBE_TYPE:
> +       case INTEL_TLV_UNLOCK_POLICY:
>                 return sizeof(u8);
>         case INTEL_TLV_MIN_FW:
>                 return 3;
>         case INTEL_TLV_OTP_BDADDR:
>                 return sizeof(bdaddr_t);
> +       case INTEL_TLV_PLATFORM_ID:
> +               return sizeof(((struct intel_version_tlv *)0)->platform_i=
d);
>         default:
>                 return 0;
>         }
> @@ -716,6 +724,13 @@ int btintel_parse_version_tlv(struct hci_dev *hdev,
>                         snprintf(version->fw_id, sizeof(version->fw_id),
>                                  "%.*s", tlv->len, tlv->val);
>                         break;
> +               case INTEL_TLV_UNLOCK_POLICY:
> +                       version->unlock_policy =3D tlv->val[0];
> +                       break;
> +               case INTEL_TLV_PLATFORM_ID:
> +                       memcpy(version->platform_id, tlv->val,
> +                              sizeof(version->platform_id));
> +                       break;
>                 default:
>                         /* Ignore rest of information */
>                         break;
> @@ -2472,7 +2487,12 @@ static int btintel_prepare_fw_download_tlv(struct =
hci_dev *hdev,
>                 else
>                         btintel_get_fw_name_tlv(ver, fwname, sizeof(fwnam=
e), "sfi");
>         } else {
> -               btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi=
");
> +               if (intel_data->unlocker) {
> +                       strscpy(fwname, "intel/unlocker.sfi");
> +                       intel_data->unlocker =3D false;
> +               } else {
> +                       btintel_get_fw_name_tlv(ver, fwname, sizeof(fwnam=
e), "sfi");
> +               }
>         }
>
>         err =3D firmware_request_nowarn(&fw, fwname, &hdev->dev);
> @@ -3489,6 +3509,36 @@ static int btintel_set_specific_absorption_rate(st=
ruct hci_dev *hdev,
>         return 0;
>  }
>
> +/* Attempt to load intel/unlocker.sfi if it is present in the firmware
> + * search path. If the file is not available the device will be booted
> + * with a signed operational firmware, which is the common case, so its
> + * absence must be treated as normal and not logged as an error.
> + */
> +static int btintel_try_load_unlocker(struct hci_dev *hdev,
> +                                    struct intel_version_tlv *ver)
> +{
> +       struct btintel_data *data =3D hci_get_priv(hdev);
> +       const struct firmware *fw;
> +       u32 boot_param =3D 0;
> +       int err;
> +
> +       err =3D firmware_request_nowarn(&fw, "intel/unlocker.sfi", &hdev-=
>dev);
> +       if (err) {
> +               bt_dev_dbg(hdev, "intel/unlocker.sfi not present (%d), sk=
ipping unlocker load",
> +                          err);
> +               return 0;
> +       }
> +       release_firmware(fw);
> +
> +       data->unlocker =3D true;
> +       err =3D btintel_prepare_fw_download_tlv(hdev, ver, &boot_param);
> +       if (err) {
> +               bt_dev_err(hdev, "Failed to load intel/unlocker.sfi (%d)"=
, err);
> +               data->unlocker =3D false;
> +       }
> +       return err;
> +}
> +
>  int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>                                  struct intel_version_tlv *ver)
>  {
> @@ -3496,6 +3546,8 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hd=
ev,
>         char ddcname[64];
>         int err;
>         struct intel_version_tlv new_ver;
> +       struct btintel_data *data =3D hci_get_priv(hdev);
> +       u8 hw_variant =3D INTEL_HW_VARIANT(ver->cnvi_bt);
>
>         bt_dev_dbg(hdev, "");
>
> @@ -3514,6 +3566,31 @@ int btintel_bootloader_setup_tlv(struct hci_dev *h=
dev,
>
>         btintel_set_flag(hdev, INTEL_BOOTLOADER);
>
> +       data->unlocker =3D false;
> +
> +       /* Legacy unlocker flow (BlazarI / BlazarIW / BlazarU / Gale Peak=
):
> +        * Boot ROM -> unlocker.sfi -> IML -> OPFW
> +        *
> +        * Skip the unlocker check when the controller is already running
> +        * operational firmware (can happen on USB); the unlocker flow is
> +        * only meaningful from the bootloader stage.
> +        */
> +       if (ver->img_type !=3D BTINTEL_IMG_OP &&
> +           ver->api_lock && ver->unlock_policy =3D=3D 0) {
> +               switch (hw_variant) {
> +               case BTINTEL_HWID_BZRI:
> +               case BTINTEL_HWID_BZRIW:
> +               case BTINTEL_HWID_BZRU:
> +               case BTINTEL_HWID_GAP:
> +                       err =3D btintel_try_load_unlocker(hdev, ver);
> +                       if (err)
> +                               return err;
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +
>         err =3D btintel_prepare_fw_download_tlv(hdev, ver, &boot_param);
>         if (err)
>                 return err;
> @@ -3537,8 +3614,19 @@ int btintel_bootloader_setup_tlv(struct hci_dev *h=
dev,
>                 return err;
>         }
>
> -       /* If image type returned is BTINTEL_IMG_IML, then controller sup=
ports
> -        * intermediate loader image
> +       /* New unlocker flow (Scorpius Peak onwards):
> +        * Boot ROM -> IML -> unlocker.sfi -> OPFW
> +        */
> +       if (hw_variant >=3D BTINTEL_HWID_SCP &&
> +           ver->api_lock && ver->unlock_policy =3D=3D 1) {
> +               err =3D btintel_try_load_unlocker(hdev, ver);
> +               if (err)
> +                       return err;
> +       }
> +
> +       /* Transition to Operational Firmware
> +        * If image type returned is BTINTEL_IMG_IML, then controller sup=
ports
> +        * intermediate loader image.
>          */
>         if (ver->img_type =3D=3D BTINTEL_IMG_IML) {
>                 err =3D btintel_prepare_fw_download_tlv(hdev, ver, &boot_=
param);
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index ff7c1d623007..9526acf65959 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -43,6 +43,8 @@ enum {
>         INTEL_TLV_OTP_BDADDR,
>         INTEL_TLV_UNLOCKED_STATE,
>         INTEL_TLV_GIT_SHA1,
> +       INTEL_TLV_UNLOCK_POLICY =3D 0x3c,
> +       INTEL_TLV_PLATFORM_ID =3D 0x3d,
>         INTEL_TLV_FW_ID =3D 0x50
>  };
>
> @@ -108,6 +110,8 @@ struct intel_version_tlv {
>         u32     git_sha1;
>         u8      fw_id[BTINTEL_FWID_MAXLEN];
>         bdaddr_t otp_bd_addr;
> +       u8      unlock_policy;
> +       u8      platform_id[6];
>  };
>
>  struct intel_version {
> @@ -261,6 +265,7 @@ struct btintel_data {
>         DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
>         int (*acpi_reset_method)(struct hci_dev *hdev);
>         u32 cnvi_bt;
> +       bool    unlocker;
>  };
>
>  #define btintel_set_flag(hdev, nr)                                     \
> --
> 2.54.0

Sashiko found a couple of problems:

https://sashiko.dev/#/patchset/20261007124721.2521956-1-kiran.k%40intel.com

--=20
Luiz Augusto von Dentz
