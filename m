Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509253CA4B6
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694278; cv=pass; b=APWJUhKuHnpneVpmIw20xY+qCkpbxvcCItP6cgyCy3Vy0rwuNNTB0haklIoYgMQgTMlxSFsn6r0nyW4MB4IWQtca4olsRPGxei2q9mhJV0ElXx+gRK7jgLP8dHvwh/oR3dsNh3As4aigEn9dul+Hz8dYkXLG8+PEnhip5XnBcrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694278; c=relaxed/simple;
	bh=zkWHCCZWgo3jDXIeWz0r7v5fkDUWcKDOttatR7QNFhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPf3ezOSi0D476+IdxYDHIPhZRl1qaBiyVu7KcRnWOfzXQmHk2VCibTgsCaW1LurLTKeYgnwHZEE1YH+KJ0zeU8cGu07DTs5KtcnUpdKvLIqEtei3Q4u4gtYA76CV0Eotn29TQOCiOBnfR4B8KqrP2H0XFUF1QnVNGSWql6J/mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnaLHJPh; arc=pass smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnaLHJPh"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ab402b4716so7008197b3.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 08:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790694275; cv=none;
        d=google.com; s=arc-20260327;
        b=E/AHulfOoSqBWOTxH59V0zAGjOmgCuGyM5T2fZSS9WwxZqEstfy5zJOj0xD94aqZep
         xVyBbFxKj2FXphemtO+nHt/zCiuk/DwSqTcizmYxCyNQ5DmctFuJcDqnwj+qzav9mUDA
         51V3FiI1JpteEyYhU1HrnuL+m2oyXInNR59UqlmJ5xW7wpqho/5gUfX5iVZSn03t59lR
         8Sxek7CviMWlwGOreIsJlM1aJjAXabwBo1NUdiz3vXYTKAgLJTnAlDkTgk30DcnT96Ep
         gCS5Utkaxojyr4EYHbixqb0EexGj6okykmIHVXFEHWFnmurT3xw6BdL1CwQVyi3ijmvh
         iegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lq2CCuJtNtJG3QB0dDQx0QlU+qFzFBjJixlkMAfuSts=;
        fh=4FIVDCMwcNku3Ck42oqGTL5zJeaPTUMSwL20JoVbcJE=;
        b=ZClXPQHwPlwDsS77eAusc23cuwjl5/eaTCIw098S21k8ozQkZVFcGPC/58HH8ILSpg
         V53EA4noAW8dLmr1Nyl/pSIUANXqHPqTTLSjIO/MisllPKnRaYA/4m9xbquH72KdgiaN
         D21gjA/UEa/6g5BnWH085RiAZnjRYUf8IuuJK82MTK+hLgRN89BlD4ipiFK5+YaiDrbj
         hyljS4OEAR3FiC7rdv8zBVU3RxLOpUSKYrWpX78LLfMPfwkvstphmMzFTubcsc3fkV7h
         6vj2NBU26JTgMYLUVETDrcYXZ9MZdAu9Pm1PWLwt5aaVopAFFRRu7dHazhwpTM97tcn+
         9ZwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790694275; x=1791299075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lq2CCuJtNtJG3QB0dDQx0QlU+qFzFBjJixlkMAfuSts=;
        b=KnaLHJPhC+qW03gxIlPXHgvSCLv84TD9N1Jm22TXE46OimWMGQW2pWDrN1VV6OTrij
         k7MzLysfzFZGj72iRUyd1jDEe3HNEI4b8ClArBxypxuEzlHyrGwG4CgrWvuBedfc3zmV
         6XQSmUkVZAwG0/L7gKH0vaIVA0iztRX4STlX2N0RA6J7dEmmILNHSCRO0mtsiRTIoWyj
         6cG73+K35pxwkHFMiO+bNFfid0EOyCX5pftBbb9m22sgkIMkSERZVt5RpZrmDmCEJW9s
         K0HgmRLJNasIHbNM1/3lpE5Vv9UtQ2SzlCFunqP+g/KxA/ZVp3tlqQ0PptH/JkLHd0QC
         pn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790694275; x=1791299075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lq2CCuJtNtJG3QB0dDQx0QlU+qFzFBjJixlkMAfuSts=;
        b=YOB98MkVjhd210gsPsMb+Fgfozd0rBqEH6cVro2LW7TeL4RXBBfV/rCLnLhfPoKsOG
         sDUCiaUabUGQN08Sh7IihxRV/cxREIuRexxF+2iUYj1lhptjpA58jByTWPczFrkZbZLL
         3vTrvDNXrNtuUuOY28zWPaRBcQ+f6JSMccZQdo3sp+qHzFP7YtNlR7KXv8rfdk7Ws5+r
         KI5UtVJspzzrltFWlp+x0F4ICliLpY5Ssi6qVPRL3kWF4vhj3r7lqdVvlOIIVW3Pp073
         FODJxI3JwuIW2ls9PNaWame8knEjFqAz+5Yol17tV0/17D4jTkaMmSJ8UbYTNBH8boSB
         cghA==
X-Gm-Message-State: AFq9FYKAP3g4GT3T06FV8xXEsH7LJee2drqMUkzpkYCIWAvY2yB4w3YA
	NKiQfRlECac6e8JoQrcxple5/snI+PCExuXVkTGhCxikJv5lpegUweT3xUQ4yAZPDWHAPx2UkjG
	P3PwBv8mFmUx/8EKYRO3yVk7l2aetezU=
X-Gm-Gg: AYBFou1X6vkUkya0KKgpQgY+JzzqVCYFN8PgR2WawhlQBGRUqgb+EpJp80ECXwreGdf
	L5sUC4Rc5mgmauWgRT3mO9Xmz9NpeG4KyJ9lK8AW/BEYDMx0d2a0DonMD4mT+x/8XY2OpnFeZ51
	/NRvRSZfWoBELz7OC8gJGxIzzp1tulfee8ytpKE/5wZV/tYKxSk533RDM6vIqQDaz00Qvx4thzP
	BglZIdC8Gw2/+YURrob/WvSNM+fwxlDonsJAkFudoI5XiEHoa4x5Kh51kQcgoZPYrudflSr8UQ+
	kHFfC0ESaa/Sr0bUAz0H1vvfmYzV4FtzdcYJhpBckfApwFpGW3xvffafJ6LDAv7PaIkceZ1Zqom
	Wy0aVxyLYn28solG/O+M3v+nB8qWpsCnH9NJ+Isq/xnk=
X-Received: by 2002:a05:690c:19:b0:8a2:2973:5dc0 with SMTP id
 00721157ae682-8a64bc39ac3mr73152627b3.27.1790694274780; Tue, 29 Sep 2026
 08:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929021056.1396791-1-kiran.k@intel.com>
In-Reply-To: <20260929021056.1396791-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Sep 2026 11:04:22 -0400
X-Gm-Features: AclHuK_TWttlnHSlFsUhyxiq3x4wq-PGEAEiNl9emkG_JClGxmJTfhwb4JmSsOQ
Message-ID: <CABBYNZKUk2s4-fnCj3d=HeXU3SKf+vSs-NARuEfX5Xtv0S=d6A@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btintel: load unlocker.sfi to allow
 unsigned firmware
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com, 
	chandrashekar.devegowda@intel.com, Ravindra <ravindra@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Mon, Sep 28, 2026 at 9:50=E2=80=AFPM Kiran K <kiran.k@intel.com> wrote:
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
> changes in v2:
>  - Updated commit message
>
>  drivers/bluetooth/btintel.c | 92 +++++++++++++++++++++++++++++++++++--
>  drivers/bluetooth/btintel.h |  5 ++
>  2 files changed, 93 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index f298c91f4f4e..3bcb13de1a4d 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -576,8 +576,13 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
>         bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u", var=
iant,
>                     2000 + (version->timestamp >> 8), version->timestamp =
& 0xff,
>                     version->build_type, version->build_num);
> -       if (version->img_type =3D=3D BTINTEL_IMG_OP)
> +
> +       if (version->img_type =3D=3D BTINTEL_IMG_OP) {
>                 bt_dev_info(hdev, "Firmware SHA1: 0x%8.8x", version->git_=
sha1);
> +               bt_dev_info(hdev, "Platform ID: %6phN", version->platform=
_id);
> +       }
> +
> +       bt_dev_info(hdev, "Unlock policy: 0x%2.2x", version->unlock_polic=
y);
>
>         return 0;
>  }
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
> @@ -2429,6 +2444,7 @@ static int btintel_prepare_fw_download_tlv(struct h=
ci_dev *hdev,
>         char fwname[128];
>         int err;
>         ktime_t calltime;
> +       struct btintel_data *data =3D hci_get_priv(hdev);
>
>         if (!ver || !boot_param)
>                 return -EINVAL;
> @@ -2472,7 +2488,12 @@ static int btintel_prepare_fw_download_tlv(struct =
hci_dev *hdev,
>                 else
>                         btintel_get_fw_name_tlv(ver, fwname, sizeof(fwnam=
e), "sfi");
>         } else {
> -               btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi=
");
> +               if (data->unlocker) {
> +                       strscpy(fwname, "intel/unlocker.sfi");
> +                       data->unlocker =3D false;
> +               } else {
> +                       btintel_get_fw_name_tlv(ver, fwname, sizeof(fwnam=
e), "sfi");
> +               }
>         }
>
>         err =3D firmware_request_nowarn(&fw, fwname, &hdev->dev);
> @@ -3489,6 +3510,36 @@ static int btintel_set_specific_absorption_rate(st=
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
> @@ -3496,6 +3547,8 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hd=
ev,
>         char ddcname[64];
>         int err;
>         struct intel_version_tlv new_ver;
> +       struct btintel_data *data =3D hci_get_priv(hdev);
> +       u8 hw_variant =3D INTEL_HW_VARIANT(ver->cnvi_bt);
>
>         bt_dev_dbg(hdev, "");
>
> @@ -3514,6 +3567,26 @@ int btintel_bootloader_setup_tlv(struct hci_dev *h=
dev,
>
>         btintel_set_flag(hdev, INTEL_BOOTLOADER);
>
> +       data->unlocker =3D false;
> +
> +       /* Legacy unlocker flow (BlazarI / BlazarIW / BlazarU / Gale Peak=
):
> +        * Boot ROM -> unlocker.sfi -> IML -> OPFW
> +        */
> +       if (ver->api_lock && ver->unlock_policy =3D=3D 0) {
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
> @@ -3537,8 +3610,19 @@ int btintel_bootloader_setup_tlv(struct hci_dev *h=
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

There are some comments from sashiko that we need to clear:

https://sashiko.dev/#/patchset/20260929021056.1396791-1-kiran.k%40intel.com


--=20
Luiz Augusto von Dentz
