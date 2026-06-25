Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665633126CA
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412690; cv=pass; b=fiKRKaR0rJVlx5ZDokyXdhw1h2s2vAK2P1+2CUuDggYAqwZNehM3mXUah+/rG7B2iydPEoSA6cRgGDdDmpGo1CoXvhSfUWPemguEdDw9fbzkMpMhcvY1mo+Aj0Q7rKj2vyGoZWXseBRnfQ6EmFQhn88c+QHApSkxJm1DvD5CvnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412690; c=relaxed/simple;
	bh=K8AU7D0EUiiTQGFhtne3ZvzRgaDcst+8aMEGiHAUAdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkgR9kE4g5FEvea62odogC5t1/T0IGV7rAtOwLTavKQd1xDL7fU4e3eSlksO5tv2yuEXGW6Q6RPrJipf37LelyMhXThoOOT/L3zmFwJ7EZOgHBl6x5HLqxdLQfJ5WNTW9SDxu59FmmEDOc7jWbo7JuxUEe8UkIoZr3zpD8bfxGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rGxdaiar; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGxdaiar"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-800619d5e7eso4572637b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 11:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782412687; cv=none;
        d=google.com; s=arc-20260327;
        b=k9317CJR9FYYOpmLOVmAwYCoasNbYYfY0HGIdnmQ9Q08rMnLcXUySgfh4/9dnEBKuo
         n7chqzArK0UR2UptULko5caGrhoTkf5/ALkytbswSyKsW37NzluLPS/trBFm7l7cSt1U
         byCPt6PZYp/RQbvnvm7ENMD/Te8ThcbSCHe7ynyqKVhoBF5v2a5kypW2I8HYKZ8DICdo
         yCNikDvrxQ6L/4FseF528fu/dI2R2Xt05qb4LSv8mZFrxJ83+ZcVmH0u6r5VEgUNlu06
         qHuX5eViwti4vctmsmmidYqBnm0Ll99h/nyqCZhj0Ryo9/B5QO4OgcsFK6+JNLMEmwgj
         pDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bj+H8KyqSqZJemvQ7/+PsCTryvM5ixfErY6XCGM2XsE=;
        fh=6UxMcYllVRH5YvMbeS2T5Rg/hmIr5L/RWhoNsZehY/g=;
        b=cnGkWMOLbeC5fhs3bLBhbIXaTyPT68XMOrv6p05TP86D4QcgW6f97U0gkYB4OwrRpt
         CoN1ZnZ3OlOF48VtgYG6y2bHF3WhLB7UbKi7su4/SHT4OKZLm3CQrEDTCHn6QO+5t3Al
         sYN/JnuG3VXjoZtDKXcp2nCPB97AT60auByHZdx1QbehDvdawTZPELYDZW7w7HLiRzc/
         ENW8GaRSMosJRq9zxbfUy94hA9inJ7HDU/jt14+3r2/wKAw/hrRNHLpR2QGcvF9J+2JF
         7CUZNPs8M21gqXFpOO/McO81kvBYnxSWag//q3kYDyaX7vWt34LTI21Dlxiz9J5fdjFm
         Mrig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782412687; x=1783017487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bj+H8KyqSqZJemvQ7/+PsCTryvM5ixfErY6XCGM2XsE=;
        b=rGxdaiarNcJtk3Ovw5InKw4mnjt2GPWiqebZLIGbMxWwTUlnV1vk0zBawpytOIgGMZ
         /oipx+r8+4C7I2EXWV5vS61ErEQSr3tabuy5lXNMa8DJBl1wF0j/KaWwyd4S6zBYljVA
         +n43SXnNU8BQ3HMWCIoRBcTklpGWqC/1JAi8mf3BWhpWPexeMULJDlYDqmwGwn8YSMdQ
         1gyluHOr+pp8Xy8Eq6sZLeCMnsEijtX9KyKtqo6uwfLhHTvtIbqxc8He1lsUlma3Nkqn
         QObKpsTARvKcae4gP/tFs+S4deDuuhadMelyKfaR7sWzj3sb5LUu5L0Gynl71jITcIkS
         /i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782412687; x=1783017487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bj+H8KyqSqZJemvQ7/+PsCTryvM5ixfErY6XCGM2XsE=;
        b=R+rOEjyksEd1oh2EaYh596FDonzzAXbTzF9f2d8v44xqPvf7zLa45C9flGSnTsW5Qs
         NEjISlCMt7Q9UAoqYwvrg1i+k8ifn5Psk7FoSEDC1DoyKapruO9HkOtw/fxpCw5kT37K
         9f1RQIsLBvbGIJH4z3A8phdliiU0LePVUjIzMf2+lXoXlxl3VhZ7pBOYa1GbcGCgi1Bc
         Vrr0Ut8MioMyfK1dADs3d589CG6xdic2lNYKa18SGZVSk5DfxJfo7G8jFIfoq/SV2kfx
         Da3mPntzVZ0/dgJMNGu9XAvTJ052JeUWhbuVH5jxJBAFQtAx062iBSJhDapFj0/DIGFF
         06Gw==
X-Forwarded-Encrypted: i=1; AHgh+Rof+39SCBV/P8f11gw1/bSofbcvWF3UPJXmpxbk0+CRhueGXQFMbOaHTVo/kt2Sf6iOtUqTzXUxfGbn5zFV/6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd/MGf0uKyPywVc3cthSO7VvdkNEK4WLgcHj4Tw4YSfVAUFcBt
	e06/nsD8L6CEZvmOmoJY2lSn/zVxuuPFYjhXxoKzothZ3qMyiDbeRAxvmcdNFTRx81fDaiGJepv
	5gMvo8vGeBAhYGcKGSYVCObQemzOEfYkTOXxq17H4pikm
X-Gm-Gg: AfdE7cmSJkxSFh5aj7yI+DPfg8FMLfEau0UbMLd09+zwL72HURNH9oeEygRvXVkPQuV
	dxH3nQv9Z6ZFCkbFYoCYbqQLiOPk7ZT9jtYRsf1jZDTFbsoSPOzwtpskMSF8w9hujg1Zm4oOGHs
	TYHzfUGHdmANaCqNMAkG0uNy01iV/f0RUYXrrKidugDAxo9TtVqKBUXfUdc6CQICE6dX1+eCzVV
	q1hS5i/ts085t3dtm3xxmV/TGIqpcX/XrY5+EeluyCMKyMiDRpVZ/kRZAR2vOLVvsxDK7DqQbzS
	Q87o7ZbQtyBQep227LKE389r42mWe3Okoapi2vHj5NQHbRNO5uj8cP9E1Eg=
X-Received: by 2002:a05:690e:bc5:b0:662:e60e:c64d with SMTP id
 956f58d0204a3-66487e66e64mr3055298d50.60.1782412686983; Thu, 25 Jun 2026
 11:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624075505.1318804-1-chris.lu@mediatek.com> <20260624075505.1318804-4-chris.lu@mediatek.com>
In-Reply-To: <20260624075505.1318804-4-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 25 Jun 2026 14:37:56 -0400
X-Gm-Features: AVVi8CcSVHHZu_oc-Fw56cPbLv6uQyk2gutBATSnej4XAyrGkPeisStV2zybtbY
Message-ID: <CABBYNZ+yLUnQrcecDBMGGL5VmvgmOjqJ=v82iicp1e6PCoXhcw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] Bluetooth: btmtk: Add MT7928 support
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>, 
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>, Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Wed, Jun 24, 2026 at 3:57=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wr=
ote:
>
> Add support for MT7928 (internal device ID is MT7935) which requires
> additional firmware (CBMCU firmware) loading before Bluetooth firmware.
>
> CBMCU is a new component on MT7928 to handle common part shared across
> the combo chip (Wi-Fi/Bluetooth's subsystem), providing a better user
> experience through improved coordination between subsystems.
>
> Implement two-phase CBMCU firmware download: Phase 1 loads section with
> type 0x5 containing global descriptor, section maps and signature data;
> Phase 2 loads remaining firmware sections. Add retry mechanism for
> concurrent download protection.
>
> After CBMCU firmware loads successfully, the driver continues to load
> corresponding BT firmware based on device ID through fallthrough to
> case 0x7922/0x7925.
>
> The firmware(CBMCU_CODE_MT7935_1_1.bin/BT_RAM_CODE_MT7935_1_1_hdr.bin)
> required for MT7928 will be scheduled for upload to linux-firmware at
> a later stage.
>
> MT7928 bring-up kernel log:
> [  159.784050] usb 1-3: New USB device found, idVendor=3D0e8d, idProduct=
=3D7935, bcdDevice=3D 1.00
> [  159.784107] usb 1-3: New USB device strings: Mfr=3D5, Product=3D6, Ser=
ialNumber=3D7
> [  159.784140] usb 1-3: Product: Wireless_Device
> [  159.784166] usb 1-3: Manufacturer: MediaTek Inc.
> [  159.784192] usb 1-3: SerialNumber: 000000000
> [  159.795736] Bluetooth: hci1: Loading CBMCU firmware: mediatek/mt7928/C=
BMCU_CODE_MT7935_1_1.bin
> [  159.807197] Bluetooth: hci1: CBMCU HW ver: 0x7935, SW ver: 0x0000, Bui=
ld Time: 20260601T161751+0800
> [  160.123155] Bluetooth: hci1: CBMCU firmware download completed
> [  160.143013] Bluetooth: hci1: Loading BT firmware: mediatek/mt7928/BT_R=
AM_CODE_MT7935_1_1_hdr.bin
> [  160.152775] Bluetooth: hci1: BT HW ver: 0x7935, SW ver: 0x0000, Build =
Time: 20260527000816
> [  163.242266] Bluetooth: hci1: Device setup in 3367430 usecs
> [  163.242280] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection=
 command is advertised, but not supported.
> [  163.355900] Bluetooth: hci1: AOSP extensions version v2.00
> [  163.355956] Bluetooth: hci1: AOSP quality report is supported
> [  163.357902] Bluetooth: MGMT ver 1.23
>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reviewed-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/bluetooth/btmtk.c | 355 +++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btmtk.h |   3 +
>  2 files changed, 357 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index dc40820bfea0..1b08db862c20 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -21,6 +21,12 @@
>  #define MTK_FW_ROM_PATCH_SEC_MAP_SIZE  64
>  #define MTK_SEC_MAP_COMMON_SIZE        12
>  #define MTK_SEC_MAP_NEED_SEND_SIZE     52
> +#define MTK_SEC_MAP_LENGTH_SIZE        4
> +#define MTK_SEC_CBMCU_DESC     0x5
> +
> +/* CBMCU WMT command flags */
> +#define BTMTK_CBMCU_FLAG_QUERY_STATUS  0xF0
> +#define BTMTK_CBMCU_FLAG_ENABLE_PATCH  0xF1
>
>  /* It is for mt79xx iso data transmission setting */
>  #define MTK_ISO_THRESHOLD      264
> @@ -120,6 +126,11 @@ void btmtk_fw_get_filename(char *buf, size_t size, u=
32 dev_id, u32 fw_ver,
>                 snprintf(buf, size,
>                          "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x_hdr.bin=
",
>                          dev_id & 0xffff, dev_id & 0xffff, (fw_ver & 0xff=
) + 1);
> +       /* MT7928 */
> +       else if (dev_id =3D=3D 0x7935)
> +               snprintf(buf, size,
> +                        "mediatek/mt7928/BT_RAM_CODE_MT%04x_1_1_hdr.bin"=
,
> +                        dev_id & 0xffff);
>         else if (dev_id =3D=3D 0x7961 && fw_flavor)
>                 snprintf(buf, size,
>                          "mediatek/BT_RAM_CODE_MT%04x_1a_%x_hdr.bin",
> @@ -736,6 +747,7 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hde=
v,
>                         status =3D BTMTK_WMT_ON_UNDONE;
>                 break;
>         case BTMTK_WMT_PATCH_DWNLD:
> +       case BTMTK_WMT_CBMCU_DWNLD:
>                 if (wmt_evt->whdr.flag =3D=3D 2)
>                         status =3D BTMTK_WMT_PATCH_DONE;
>                 else if (wmt_evt->whdr.flag =3D=3D 1)
> @@ -872,6 +884,336 @@ static u32 btmtk_usb_reset_done(struct hci_dev *hde=
v)
>         return val & MTK_BT_RST_DONE;
>  }
>
> +static int btmtk_cbmcu_patch_status(struct hci_dev *hdev,
> +                                   wmt_cmd_sync_func_t wmt_cmd_sync,
> +                                   u8 *patch_status)
> +{
> +       struct btmtk_hci_wmt_params wmt_params;
> +       int status, err, retry =3D 20;
> +
> +       do {
> +               wmt_params.op =3D BTMTK_WMT_CBMCU_DWNLD;
> +               wmt_params.flag =3D BTMTK_CBMCU_FLAG_QUERY_STATUS;
> +               wmt_params.dlen =3D 0;
> +               wmt_params.data =3D NULL;
> +               wmt_params.status =3D &status;
> +
> +               err =3D wmt_cmd_sync(hdev, &wmt_params);
> +               if (err < 0) {
> +                       bt_dev_err(hdev, "Failed to query CBMCU patch sta=
tus (%d)", err);
> +                       return err;
> +               }
> +
> +               *patch_status =3D (u8)status;
> +
> +               if (*patch_status =3D=3D BTMTK_WMT_PATCH_PROGRESS) {
> +                       msleep(100);
> +                       retry--;
> +               } else {
> +                       break;
> +               }
> +       } while (retry > 0);
> +
> +       return 0;
> +}
> +
> +static int btmtk_query_cbmcu_section(struct hci_dev *hdev,
> +                                    wmt_cmd_sync_func_t wmt_cmd_sync,
> +                                    u8 cbmcu_type,
> +                                    const u8 *section_map,
> +                                    u32 cert_len)
> +{
> +       struct btmtk_hci_wmt_params wmt_params;
> +       u8 cmd[64];
> +       int status, err;
> +
> +       cmd[0] =3D 0;
> +       cmd[1] =3D cbmcu_type;
> +
> +       if (cbmcu_type =3D=3D 0)
> +               put_unaligned_le32(cert_len, &cmd[2]);
> +       else
> +               memcpy(&cmd[2], section_map, MTK_SEC_MAP_NEED_SEND_SIZE);
> +
> +       wmt_params.op =3D BTMTK_WMT_CBMCU_DWNLD;
> +       wmt_params.flag =3D 0;
> +       wmt_params.dlen =3D cbmcu_type ?
> +               MTK_SEC_MAP_NEED_SEND_SIZE + 2 :
> +               MTK_SEC_MAP_LENGTH_SIZE + 2;
> +       wmt_params.data =3D cmd;
> +       wmt_params.status =3D &status;
> +
> +       err =3D wmt_cmd_sync(hdev, &wmt_params);
> +       if (err < 0) {
> +               bt_dev_err(hdev, "Failed to query CBMCU section (%d)", er=
r);
> +               return err;
> +       }
> +
> +       /* Query should return UNDONE status for successful section query=
 */
> +       if (status !=3D BTMTK_WMT_PATCH_UNDONE) {
> +               bt_dev_err(hdev, "CBMCU section query status error (%d)",=
 status);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int btmtk_download_cbmcu_section(struct hci_dev *hdev,
> +                                       wmt_cmd_sync_func_t wmt_cmd_sync,
> +                                       const u8 *fw_data,
> +                                       u32 dl_size)
> +{
> +       struct btmtk_hci_wmt_params wmt_params;
> +       u32 sent_len, total_size =3D dl_size;
> +       int err;
> +
> +       wmt_params.op =3D BTMTK_WMT_CBMCU_DWNLD;
> +       wmt_params.status =3D NULL;
> +
> +       while (dl_size > 0) {
> +               sent_len =3D min_t(u32, 250, dl_size);
> +
> +               if (dl_size =3D=3D total_size)
> +                       wmt_params.flag =3D BTMTK_WMT_PKT_START;
> +               else if (dl_size =3D=3D sent_len)
> +                       wmt_params.flag =3D BTMTK_WMT_PKT_END;
> +               else
> +                       wmt_params.flag =3D BTMTK_WMT_PKT_CONTINUE;
> +
> +               wmt_params.dlen =3D sent_len;
> +               wmt_params.data =3D fw_data;
> +
> +               err =3D wmt_cmd_sync(hdev, &wmt_params);
> +               if (err < 0) {
> +                       bt_dev_err(hdev, "Failed to send CBMCU section da=
ta (%d)", err);
> +                       return err;
> +               }
> +
> +               dl_size -=3D sent_len;
> +               fw_data +=3D sent_len;
> +       }
> +
> +       return 0;
> +}
> +
> +static int btmtk_enable_cbmcu_patch(struct hci_dev *hdev,
> +                                   wmt_cmd_sync_func_t wmt_cmd_sync)
> +{
> +       struct btmtk_hci_wmt_params wmt_params;
> +       int err;
> +
> +       wmt_params.op =3D BTMTK_WMT_CBMCU_DWNLD;
> +       wmt_params.flag =3D BTMTK_CBMCU_FLAG_ENABLE_PATCH;
> +       wmt_params.dlen =3D 0;
> +       wmt_params.data =3D NULL;
> +       wmt_params.status =3D NULL;
> +
> +       err =3D wmt_cmd_sync(hdev, &wmt_params);
> +       if (err < 0) {
> +               bt_dev_err(hdev, "Failed to enable CBMCU patch (%d)", err=
);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int btmtk_load_cbmcu_firmware(struct hci_dev *hdev,
> +                                    const char *fwname,
> +                                    wmt_cmd_sync_func_t wmt_cmd_sync,
> +                                    u32 dev_id)
> +{
> +       struct btmtk_patch_header *hdr;
> +       struct btmtk_global_desc *globaldesc;
> +       struct btmtk_section_map *sectionmap;
> +       const struct firmware *fw;
> +       const u8 *fw_ptr;
> +       u8 *cert_buf =3D NULL;
> +       u32 section_num, section_offset, dl_size, cert_len;
> +       int i, err;
> +
> +       err =3D request_firmware(&fw, fwname, &hdev->dev);
> +       if (err < 0) {
> +               bt_dev_err(hdev, "Failed to load CBMCU firmware file %s (=
%d)",
> +                          fwname, err);
> +               return err;
> +       }
> +
> +       if (fw->size < MTK_FW_ROM_PATCH_HEADER_SIZE + MTK_FW_ROM_PATCH_GD=
_SIZE) {
> +               bt_dev_err(hdev, "CBMCU firmware too small: size=3D%zu, m=
in=3D%u",
> +                          fw->size,
> +                          MTK_FW_ROM_PATCH_HEADER_SIZE + MTK_FW_ROM_PATC=
H_GD_SIZE);
> +               err =3D -EINVAL;
> +               goto err_release_fw;
> +       }
> +
> +       fw_ptr =3D fw->data;
> +       hdr =3D (struct btmtk_patch_header *)fw_ptr;
> +       globaldesc =3D (struct btmtk_global_desc *)(fw_ptr + MTK_FW_ROM_P=
ATCH_HEADER_SIZE);
> +       section_num =3D le32_to_cpu(globaldesc->section_num);
> +
> +       if (fw->size < MTK_FW_ROM_PATCH_HEADER_SIZE + MTK_FW_ROM_PATCH_GD=
_SIZE +
> +                      (size_t)MTK_FW_ROM_PATCH_SEC_MAP_SIZE * section_nu=
m) {
> +               bt_dev_err(hdev, "CBMCU firmware truncated: size=3D%zu, e=
xpected=3D%zu (section_num=3D%u)",
> +                          fw->size,
> +                          MTK_FW_ROM_PATCH_HEADER_SIZE + MTK_FW_ROM_PATC=
H_GD_SIZE +
> +                          (size_t)MTK_FW_ROM_PATCH_SEC_MAP_SIZE * sectio=
n_num,
> +                          section_num);
> +               err =3D -EINVAL;
> +               goto err_release_fw;
> +       }
> +
> +       bt_dev_info(hdev, "CBMCU HW ver: 0x%04x, SW ver: 0x%04x, Build Ti=
me: %s",
> +                   dev_id & 0xffff, le16_to_cpu(hdr->swver), hdr->dateti=
me);
> +
> +       /* Phase 1: Download section type MTK_SEC_CBMCU_DESC */
> +       for (i =3D 0; i < section_num; i++) {
> +               sectionmap =3D (struct btmtk_section_map *)
> +                       (fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE +
> +                        MTK_FW_ROM_PATCH_GD_SIZE +
> +                        MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i);
> +
> +               /* Only process MTK_SEC_CBMCU_DESC section in Phase 1 */
> +               if ((le32_to_cpu(sectionmap->sectype) & 0xFFFF) !=3D MTK_=
SEC_CBMCU_DESC)
> +                       continue;
> +
> +               section_offset =3D le32_to_cpu(sectionmap->secoffset);
> +               dl_size =3D le32_to_cpu(sectionmap->secsize);
> +
> +               if (dl_size =3D=3D 0)
> +                       continue;
> +
> +               if (section_offset > fw->size ||
> +                   dl_size > fw->size - section_offset) {
> +                       bt_dev_err(hdev, "CBMCU Phase 1 section out of bo=
unds");
> +                       err =3D -EINVAL;
> +                       goto err_release_fw;
> +               }
> +
> +               cert_len =3D MTK_FW_ROM_PATCH_GD_SIZE +
> +                          MTK_FW_ROM_PATCH_SEC_MAP_SIZE * section_num +
> +                          dl_size;
> +
> +               /* Query cbmcu section */
> +               err =3D btmtk_query_cbmcu_section(hdev, wmt_cmd_sync, 0, =
NULL,
> +                                               cert_len);
> +               if (err < 0)
> +                       goto err_release_fw;
> +
> +               cert_buf =3D kmalloc(cert_len, GFP_KERNEL);
> +               if (!cert_buf) {
> +                       err =3D -ENOMEM;
> +                       goto err_release_fw;
> +               }
> +
> +               /* Copy Global Descriptor + All Section Maps */
> +               memcpy(cert_buf,
> +                      fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE,
> +                      MTK_FW_ROM_PATCH_GD_SIZE + MTK_FW_ROM_PATCH_SEC_MA=
P_SIZE * section_num);
> +
> +               /* Copy Phase 1 section data */
> +               memcpy(cert_buf + MTK_FW_ROM_PATCH_GD_SIZE +
> +                      MTK_FW_ROM_PATCH_SEC_MAP_SIZE * section_num,
> +                      fw_ptr + section_offset,
> +                      dl_size);
> +
> +               /* Download Phase 1 section */
> +               err =3D btmtk_download_cbmcu_section(hdev, wmt_cmd_sync,
> +                                                  cert_buf, cert_len);
> +               kfree(cert_buf);
> +               cert_buf =3D NULL;
> +
> +               if (err < 0) {
> +                       bt_dev_err(hdev, "Failed to download CBMCU Phase =
1 section (%d)", err);
> +                       goto err_release_fw;
> +               }
> +
> +               break;
> +       }
> +
> +       /* Phase 2: Download other sections (type !=3D MTK_SEC_CBMCU_DESC=
) */
> +       for (i =3D 0; i < section_num; i++) {
> +               sectionmap =3D (struct btmtk_section_map *)
> +                       (fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE +
> +                        MTK_FW_ROM_PATCH_GD_SIZE +
> +                        MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i);
> +
> +               /* Skip MTK_SEC_CBMCU_DESC section in Phase 2 */
> +               if ((le32_to_cpu(sectionmap->sectype) & 0xFFFF) =3D=3D MT=
K_SEC_CBMCU_DESC)
> +                       continue;
> +
> +               section_offset =3D le32_to_cpu(sectionmap->secoffset);
> +               dl_size =3D le32_to_cpu(sectionmap->bin_info_spec.dlsize)=
;
> +
> +               if (dl_size =3D=3D 0)
> +                       continue;
> +
> +               if (section_offset > fw->size ||
> +                   dl_size > fw->size - section_offset) {
> +                       bt_dev_err(hdev, "CBMCU Phase 2 section %d out of=
 bounds", i);
> +                       err =3D -EINVAL;
> +                       goto err_release_fw;
> +               }
> +
> +               /* Query cbmcu section */
> +               err =3D btmtk_query_cbmcu_section(hdev, wmt_cmd_sync, 1,
> +                                               (u8 *)&sectionmap->bin_in=
fo_spec,
> +                                               0);
> +               if (err < 0)
> +                       goto err_release_fw;
> +
> +               /* Download section data */
> +               err =3D btmtk_download_cbmcu_section(hdev, wmt_cmd_sync,
> +                                                  fw_ptr + section_offse=
t,
> +                                                  dl_size);
> +               if (err < 0) {
> +                       bt_dev_err(hdev, "Failed to download CBMCU sectio=
n %d (%d)", i, err);
> +                       goto err_release_fw;
> +               }
> +       }
> +
> +       bt_dev_info(hdev, "CBMCU firmware download completed");
> +
> +err_release_fw:
> +       release_firmware(fw);
> +       return err;
> +}
> +
> +static int btmtk_setup_cbmcu_firmware(struct hci_dev *hdev,
> +                                     wmt_cmd_sync_func_t wmt_cmd_sync,
> +                                     u32 dev_id)
> +{
> +       char cbmcu_fwname[64];
> +       u8 patch_status;
> +       int err;
> +
> +       err =3D btmtk_cbmcu_patch_status(hdev, wmt_cmd_sync, &patch_statu=
s);
> +       if (err < 0)
> +               return err;
> +
> +       bt_dev_dbg(hdev, "CBMCU patch status: 0x%02x", patch_status);
> +
> +       if (patch_status !=3D BTMTK_WMT_PATCH_UNDONE)
> +               return 0;
> +
> +       snprintf(cbmcu_fwname, sizeof(cbmcu_fwname),
> +                "mediatek/mt7928/CBMCU_CODE_MT%04x_1_1.bin",
> +                dev_id & 0xffff);
> +
> +       bt_dev_info(hdev, "Loading CBMCU firmware: %s", cbmcu_fwname);
> +
> +       err =3D btmtk_load_cbmcu_firmware(hdev, cbmcu_fwname, wmt_cmd_syn=
c, dev_id);
> +       if (err < 0) {
> +               bt_dev_err(hdev, "Failed to download CBMCU firmware (%d)"=
, err);
> +               return err;
> +       }
> +
> +       err =3D btmtk_enable_cbmcu_patch(hdev, wmt_cmd_sync);
> +       if (err < 0)
> +               return err;
> +
> +       return 0;
> +}
> +
>  int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
>  {
>         u32 val;
> @@ -896,7 +1238,7 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32=
 dev_id)
>                 if (err < 0)
>                         return err;
>                 msleep(100);
> -       } else if (dev_id =3D=3D 0x7925 || dev_id =3D=3D 0x6639) {
> +       } else if (dev_id =3D=3D 0x7925 || dev_id =3D=3D 0x6639 || dev_id=
 =3D=3D 0x7935) {
>                 err =3D btmtk_usb_uhw_reg_read(hdev, MTK_BT_RESET_REG_CON=
NV3, &val);
>                 if (err < 0)
>                         return err;
> @@ -1381,6 +1723,15 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>         case 0x7668:
>                 fwname =3D FIRMWARE_MT7668;
>                 break;
> +       case 0x7935:
> +               /* Requires CBMCU firmware before BT firmware */
> +               err =3D btmtk_setup_cbmcu_firmware(hdev, btmtk_usb_hci_wm=
t_sync,
> +                                                dev_id);
> +               if (err < 0) {
> +                       bt_dev_err(hdev, "Failed to set up CBMCU firmware=
 (%d)", err);
> +                       return err;
> +               }
> +               fallthrough;
>         case 0x7922:
>         case 0x7925:
>                 /*
> @@ -1598,3 +1949,5 @@ MODULE_FIRMWARE(FIRMWARE_MT7922);
>  MODULE_FIRMWARE(FIRMWARE_MT7961);
>  MODULE_FIRMWARE(FIRMWARE_MT7925);
>  MODULE_FIRMWARE(FIRMWARE_MT7927);
> +MODULE_FIRMWARE(FIRMWARE_MT7928);
> +MODULE_FIRMWARE(FIRMWARE_MT7928_CBMCU);
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index 51c18dde0a80..5fe4964b031b 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -9,6 +9,8 @@
>  #define FIRMWARE_MT7961                "mediatek/BT_RAM_CODE_MT7961_1_2_=
hdr.bin"
>  #define FIRMWARE_MT7925                "mediatek/mt7925/BT_RAM_CODE_MT79=
25_1_1_hdr.bin"
>  #define FIRMWARE_MT7927                "mediatek/mt7927/BT_RAM_CODE_MT66=
39_2_1_hdr.bin"
> +#define FIRMWARE_MT7928                "mediatek/mt7928/BT_RAM_CODE_MT79=
35_1_1_hdr.bin"
> +#define FIRMWARE_MT7928_CBMCU  "mediatek/mt7928/CBMCU_CODE_MT7935_1_1.bi=
n"
>
>  #define HCI_EV_WMT 0xe4
>  #define HCI_WMT_MAX_EVENT_SIZE         64
> @@ -54,6 +56,7 @@ enum {
>         BTMTK_WMT_RST =3D 0x7,
>         BTMTK_WMT_REGISTER =3D 0x8,
>         BTMTK_WMT_SEMAPHORE =3D 0x17,
> +       BTMTK_WMT_CBMCU_DWNLD =3D 0x58,
>  };
>
>  enum {
> --
> 2.45.2

Sashiko seems to have found quite a few problems with this set:

https://sashiko.dev/#/patchset/20260624075505.1318804-1-chris.lu%40mediatek=
.com

--=20
Luiz Augusto von Dentz
