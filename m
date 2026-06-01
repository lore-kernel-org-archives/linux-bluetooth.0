Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E270C286D56
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780344187; cv=pass; b=q/eIwEvComgQilY+XWRH9nIeCgAupnwIaWS6/C8eKRPtrqjxrY6AvSLFe+vRTh/QCQMBgrZK0u7LusFrKXXLCpIYV6ADylX8K6sMMDP2WfId45xeW/cJkBDWEKFMSu5t4/nhpX0dP7zvxKke5UsPrkYMtbCS/TJkCHPsibX1N5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780344187; c=relaxed/simple;
	bh=lZ7NNDI/UQliA8y1xCcrHAYMofhgpXoM7U66MrkPbi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSzFBSgq54iyn0+p7ZyhTqdGCCP3tOU0d6jo0HTCMdq/ngwevfNlteCuZdAoZ1XOpTSveOZ/y4L49v5gw8m32+/LrcUNMf1+hHpxWekRD9kPCEplgsljumoRcIzAZPQSIO+9yp3M0xAcVgzRq6xAIRKXxFIU7Hy5Cxd2JF7M/F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9qW8m+v; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9qW8m+v"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6605c3453f2so3093559d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 13:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780344185; cv=none;
        d=google.com; s=arc-20240605;
        b=A4J+EiGG6xdeIJhjgZCpDhLWphQ+nfu8KOa4MTJbwKASZIPkMMTicd0c5RyHCwGaIk
         gLaO/XoUMY3fJfJJOTc3KtLtTVfI9AAeKBvCWzS4oT1cpY4v7T6Y+O/MIjtpPivpracY
         EhTi7v2qvfMmfEDTnDIViEKUK/dcWJLIoabwP+2m3YaqE7V45tHlw8O55KcAFAaskC1a
         qA0w6FWVmDs/Whcas1Pi9z7hZi28+LkD7fFXxg3vEQNbIqRHp+8rR9gAt7diDY7qeCgU
         l1lyHhgFVusvAcCLCuihvdEtUeh0sz9s8LceUPnD+jQ3VdjPBdqHFAUnOxrZXbdEyqvP
         Ai2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bGOM776RrqZ9mCwqjyRM9PSsx8hnI6nNOGG5yAsJ5qg=;
        fh=okygQUZx+QQI3TqRPC2/iO6czBVNoHrkvX/v441Gkvw=;
        b=AFJhxaVRrcJvZ1BemYVjhMpjTgAukLuISjHP+BRGyHW31awPwW3MFDxODqZ9KLvefM
         EEvBHHIkm4HwCQ6PiWV2dFrMmJ8FJPHcXCY6dEG5emd52bCOlOq6ZztBXHJ0bO67n4X5
         KGPc0O7pzo0EekdhNNkILk9wcGzcB0HSz5W67Y/DNZ1shuxR0JKKd2NGfexDaGBLR2QQ
         EinjF5JAnIZiEEJ+hYfYUqozJTD5x2/q4LoUCnc6P2Sd9bEfe9B29ck/ZNeqqVraJolH
         YNNzgM52Rrh3qrE4akxV9R1pMm5JXQd7v5pZSNMfek58+b29elayIxXs18CpA+HIrYHW
         1SBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780344185; x=1780948985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGOM776RrqZ9mCwqjyRM9PSsx8hnI6nNOGG5yAsJ5qg=;
        b=D9qW8m+vwHKXjzGSITRuY4izLYeXKO5YTq2CMZnGtLbkCN2HMC2iCRlWHdTJfWtcbi
         3/z8YPbuPp9guv9Q/sv8GG8QhiEI0kZMMV3Txg6Nictikp0v/XuXfGh9GFcSr6IfVkZi
         yVMbh/Nj4/Xs5tH1emSLnBEMxeOVnHndXjNWMa0CPMhj7/I4YrLPNr8e7BRpsXTncCk2
         N/leRdYlQv0V9yLWPEfWXASWpTGPDF/MBAk1L8YjQhxdofdjNEHk1c226C6S0/AeWV6U
         SQrXsQmNIkdEAO0VmIYpcz/kJcUiAI9Ju8tGbudSlaoEZmRauYaOABtbaalZgAEeMIDZ
         ISRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780344185; x=1780948985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bGOM776RrqZ9mCwqjyRM9PSsx8hnI6nNOGG5yAsJ5qg=;
        b=e58oOXwFsRiYcnafzYyeRCk6IiRGh5fPqDCFvrAtYhkfB7Qulf7iuNGVbRcdsVOptK
         mY7inF2NVemYDpY1ZuXNVHUMOQJMnBcMZuM+X0HH9ZsitQ1gaGtfbNEs5GC+nbGFPWwb
         N0YKpQLOlTN9n8zfkYAwYm+R/FskzZWPWg3VQ3kSn8c0Kzq0yHDbgJBLmYfSmAUypU5h
         LPI3DgLk7SUCceDe6Rmgd9pfGwCkzFg03+vg4hyrIGZH+daJk85pgo/rW16rZi/DjPDm
         UmQuJSzhEZqbjyFhyPv8PjndwyjYqRfZgMK2byax/L1GA30D/XxbTft0AauBolEdUmuy
         L4NQ==
X-Gm-Message-State: AOJu0YwGGU4cxG1K7L/p4ihdywVIR9D1ZJe2GvEND8K5gSRTXYUZlTfg
	oHKhzfupPBfrCQ2SAFOJVQ0+hQtZimrOcAq8lCZ/rWLuzUxO9Ah+BnznXAE6cn9xYVyMZhayIgD
	hyNpDQLrVIFuw3kKmLbU5KqxBYeF833tzenomM24KqQ==
X-Gm-Gg: Acq92OGVZCRvVF0hf0HX7YwZoXMBpVXWg8tPH9eO6zu8gPQmZiJ2tqXS/qnZeLSBmoQ
	WfP6R0GgfsSd3tJdebEOL+e46y6V06rQFMKo98U4Mn7GgFEmvES0AZ3Fs50z0MDbln5Mqkv1pvZ
	woil9LvRq6J/oBu5QejQb1YjkrtmKjCKJpX2LzyE3TU7s8tr5NdpDaSUr+zfSKDUb9UEYchLhGh
	+8Yqt9rlWl5MD5w8gzRvtWeBJaBFB+Dg8Df4vGd3eE+d0CckqKBsPmaWvlzxugiEcO7l94RiU6T
	WaI5fy2R37NVPPR+TDSR0SS4J+/ZyW5cBvrHoH8iAzhWML0cfpP1wvLe5Stws3NO9x6X8a6eqFl
	uNzLp
X-Received: by 2002:a05:690e:1916:b0:660:5174:86c9 with SMTP id
 956f58d0204a3-6605ef3d9d1mr10582173d50.47.1780344184697; Mon, 01 Jun 2026
 13:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601124825.216489-1-kiran.k@intel.com>
In-Reply-To: <20260601124825.216489-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Jun 2026 16:02:52 -0400
X-Gm-Features: AVHnY4JygxIpX6CGcF0tishrExDSmCXbllkD5uqxPUuNVZZmsjP_F6wod34aUH8
Message-ID: <CABBYNZK31kxQWAGZk1mWd17H353X53NQHJgux+pr3gLv9r73Kw@mail.gmail.com>
Subject: Re: [PATCH v2] bluetooth: btintel: Add Bluetooth SAR revision 2 support
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, Ravindra <ravindra@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Mon, Jun 1, 2026 at 8:29=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> BRDS revision 2 introduces per-chain (Chain A and Chain B) TX power
> limits across five sub-bands (2.4G, 5.2G, 5.8/5.9G, 6G-low, 6G-high),
> replacing the single-chain per-modulation model of revisions 0 and 1.
>
> - Add btintel_set_sar_rev2() which sends the full Rev2 DDC sequence:
>     0x019e  inc-power-mode enable flag        (1 byte)
>     0x0311  2.4 GHz sub-band limits           (2 bytes)
>     0x0312  5.2 GHz sub-band limits           (2 bytes)
>     0x0313  5.8/5.9 GHz sub-band limits       (2 bytes)
>     0x0314  5.8/5.9 GHz sub-band limits again (2 bytes, duplicate FW reg)
>     0x0315  6 GHz low sub-band limits         (2 bytes)
>     0x0316  6 GHz high sub-band limits        (2 bytes)
>   followed by the SAR-init-complete command (0xfe25).
>
> logs from dmesg when BTSAR2 is enabled in Coreboot/BIOS:
>
> Bluetooth: hci0: BT SAR Rev2: revision=3D2 bt_sar_bios=3D1 inc_power_mode=
=3D1
> Bluetooth: hci0: BT SAR Rev2 Chain A: 2g4=3D76 5g2=3D0 5g8_5g9=3D0 6g1=3D=
0 6g3=3D0
> Bluetooth: hci0: BT SAR Rev2 Chain B: 2g4=3D102 5g2=3D0 5g8_5g9=3D0 6g1=
=3D0 6g3=3D0
>
> Signed-off-by: Ravindra <ravindra@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v2:
> - Update commit message to include logs
> - Validate the ACPI types/size before accessing.
>
>  drivers/bluetooth/btintel.c | 195 +++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btintel.h |  18 ++++
>  2 files changed, 212 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 5e9cac090bd8..3f6e5285c780 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -51,6 +51,7 @@ enum {
>  #define BTINTEL_BT_DOMAIN              0x12
>  #define BTINTEL_SAR_LEGACY             0
>  #define BTINTEL_SAR_INC_PWR            1
> +#define BTINTEL_SAR_REV2               2
>  #define BTINTEL_SAR_INC_PWR_SUPPORTED  0
>
>  #define CMD_WRITE_BOOT_PARAMS  0xfc0e
> @@ -3104,6 +3105,111 @@ static int btintel_set_mutual_sar(struct hci_dev =
*hdev, struct btintel_sar_inc_p
>         return 0;
>  }
>
> +/* btintel_send_sar_rev2_band - send DDC command for one Rev2 sub-band
> + *
> + * Each DDC 0x0311-0x0316 carries 2 bytes: [ChainA_value, ChainB_value].
> + * cmd->len =3D 4  (2 id + 2 data)
> + * HCI total  =3D 5 bytes (1 len + 4)
> + */
> +static int btintel_send_sar_rev2_band(struct hci_dev *hdev,
> +                                     struct btintel_cp_ddc_write *cmd,
> +                                     u16 id, u8 chain_a, u8 chain_b)
> +{
> +       cmd->len =3D 4;
> +       cmd->id =3D cpu_to_le16(id);
> +       cmd->data[0] =3D chain_a;
> +       cmd->data[1] =3D chain_b;
> +       return btintel_send_sar_ddc(hdev, cmd, 5);
> +}
> +
> +static int btintel_set_sar_rev2(struct hci_dev *hdev,
> +                               struct btintel_sar_rev2 *sar)
> +{
> +       struct btintel_cp_ddc_write *cmd;
> +       struct sk_buff *skb;
> +       u8 buffer[64];
> +       u8 enable;
> +       int ret;
> +
> +       cmd =3D (void *)buffer;
> +
> +       /* DDC 0x019e: enable/disable increased power mode SAR (1 byte) *=
/
> +       cmd->len =3D 3;
> +       cmd->id =3D cpu_to_le16(0x019e);
> +       cmd->data[0] =3D (sar->inc_power_mode =3D=3D BTINTEL_SAR_INC_PWR_=
SUPPORTED) ?
> +                       0x01 : 0x00;
> +       ret =3D btintel_send_sar_ddc(hdev, cmd, 4);
> +       if (ret)
> +               return ret;
> +
> +       /* DDC 0x0311-0x0316: per sub-band ChainA + ChainB limits */
> +       ret =3D btintel_send_sar_rev2_band(hdev, cmd, 0x0311,
> +                                        sar->chain_a.subband_2g4,
> +                                        sar->chain_b.subband_2g4);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D btintel_send_sar_rev2_band(hdev, cmd, 0x0312,
> +                                        sar->chain_a.subband_5g2,
> +                                        sar->chain_b.subband_5g2);
> +       if (ret)
> +               return ret;
> +
> +       /* 0x0313 and 0x0314 both carry the 5G8/5G9 value */
> +       ret =3D btintel_send_sar_rev2_band(hdev, cmd, 0x0313,
> +                                        sar->chain_a.subband_5g8_5g9,
> +                                        sar->chain_b.subband_5g8_5g9);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D btintel_send_sar_rev2_band(hdev, cmd, 0x0314,
> +                                        sar->chain_a.subband_5g8_5g9,
> +                                        sar->chain_b.subband_5g8_5g9);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D btintel_send_sar_rev2_band(hdev, cmd, 0x0315,
> +                                        sar->chain_a.subband_6g1,
> +                                        sar->chain_b.subband_6g1);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D btintel_send_sar_rev2_band(hdev, cmd, 0x0316,
> +                                        sar->chain_a.subband_6g3,
> +                                        sar->chain_b.subband_6g3);
> +       if (ret)
> +               return ret;
> +
> +       /* Notify firmware that SAR initialisation is complete */
> +       enable =3D 0x01;
> +       skb =3D __hci_cmd_sync(hdev, 0xfe25, sizeof(enable), &enable, HCI=
_CMD_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_warn(hdev, "Failed to send Intel SAR Rev2 Enable (=
%ld)",
> +                           PTR_ERR(skb));
> +               return PTR_ERR(skb);
> +       }
> +
> +       kfree_skb(skb);
> +       return 0;
> +}
> +
> +static int btintel_sar_rev2_send_to_device(struct hci_dev *hdev,
> +                                          struct btintel_sar_rev2 *sar,
> +                                          struct intel_version_tlv *ver)
> +{
> +       u16 cnvi =3D ver->cnvi_top & 0xfff;
> +       u16 cnvr =3D ver->cnvr_top & 0xfff;
> +
> +       if (cnvi < BTINTEL_CNVI_BLAZARI || cnvr !=3D BTINTEL_CNVR_WHP2) {
> +               bt_dev_dbg(hdev, "BT SAR Rev2 not supported on this platf=
orm (cnvi=3D0x%x cnvr=3D0x%x)",
> +                          cnvi, cnvr);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       bt_dev_info(hdev, "Applying Bluetooth SAR Rev2");
> +       return btintel_set_sar_rev2(hdev, sar);
> +}
> +
>  static int btintel_sar_send_to_device(struct hci_dev *hdev, struct btint=
el_sar_inc_pwr *sar,
>                                       struct intel_version_tlv *ver)
>  {
> @@ -3130,6 +3236,7 @@ static int btintel_acpi_set_sar(struct hci_dev *hde=
v, struct intel_version_tlv *
>  {
>         union acpi_object *bt_pkg, *buffer =3D NULL;
>         struct btintel_sar_inc_pwr sar;
> +       struct btintel_sar_rev2 sar_rev2;
>         acpi_status status;
>         u8 revision;
>         int ret;
> @@ -3150,14 +3257,100 @@ static int btintel_acpi_set_sar(struct hci_dev *=
hdev, struct intel_version_tlv *
>                 goto error;
>         }
>
> +       if (buffer->package.elements[0].type !=3D ACPI_TYPE_INTEGER) {
> +               bt_dev_warn(hdev, "BT_SAR: unexpected ACPI type for revis=
ion field");
> +               ret =3D -EINVAL;
> +               goto error;
> +       }
> +
>         revision =3D buffer->package.elements[0].integer.value;
>
> -       if (revision > BTINTEL_SAR_INC_PWR) {
> +       if (revision > BTINTEL_SAR_REV2) {
>                 bt_dev_dbg(hdev, "BT_SAR: revision: 0x%2.2x not supported=
", revision);
>                 ret =3D -EOPNOTSUPP;
>                 goto error;
>         }
>
> +       if (revision =3D=3D BTINTEL_SAR_REV2 && bt_pkg->package.count =3D=
=3D 13) {
> +               /* Element layout: 0 =3D revision, 1 =3D bt_sar_bios (u32=
),
> +                * 2 =3D inc_power_mode (u32), 3..12 =3D per-chain sub-ba=
nd
> +                * limits (u8 each). Validate each ACPI element is an
> +                * integer and fits its destination width before we read
> +                * the union; otherwise we could misinterpret string
> +                * lengths or buffer pointers as TX power limits, or
> +                * silently truncate out-of-range BIOS values into a
> +                * regulatory-critical sub-band field.
> +                */
> +               static const u64 rev2_max[13] =3D {
> +                       U8_MAX,                         /* revision */

https://sashiko.dev/#/patchset/20260601124825.216489-1-kiran.k%40intel.com

Looks like Sashiko has some comments regarding this.

> +                       U32_MAX, U32_MAX,               /* bt_sar_bios, i=
nc_power_mode */
> +                       U8_MAX, U8_MAX, U8_MAX, U8_MAX, U8_MAX, /* chain =
A */
> +                       U8_MAX, U8_MAX, U8_MAX, U8_MAX, U8_MAX, /* chain =
B */
> +               };
> +               union acpi_object *e;
> +               int i;
> +
> +               for (i =3D 0; i < 13; i++) {
> +                       e =3D &bt_pkg->package.elements[i];
> +                       if (e->type !=3D ACPI_TYPE_INTEGER) {
> +                               bt_dev_warn(hdev, "BT SAR Rev2: unexpecte=
d ACPI type at element %d",
> +                                           i);
> +                               ret =3D -EINVAL;
> +                               goto error;
> +                       }
> +                       if (e->integer.value > rev2_max[i]) {
> +                               bt_dev_warn(hdev, "BT SAR Rev2: element %=
d value 0x%llx out of range",
> +                                           i, e->integer.value);
> +                               ret =3D -ERANGE;
> +                               goto error;
> +                       }
> +               }
> +
> +               memset(&sar_rev2, 0, sizeof(sar_rev2));
> +               sar_rev2.revision       =3D revision;
> +               sar_rev2.bt_sar_bios    =3D bt_pkg->package.elements[1].i=
nteger.value;
> +               sar_rev2.inc_power_mode =3D bt_pkg->package.elements[2].i=
nteger.value;
> +
> +               sar_rev2.chain_a.subband_2g4     =3D bt_pkg->package.elem=
ents[3].integer.value;
> +               sar_rev2.chain_a.subband_5g2     =3D bt_pkg->package.elem=
ents[4].integer.value;
> +               sar_rev2.chain_a.subband_5g8_5g9 =3D bt_pkg->package.elem=
ents[5].integer.value;
> +               sar_rev2.chain_a.subband_6g1     =3D bt_pkg->package.elem=
ents[6].integer.value;
> +               sar_rev2.chain_a.subband_6g3     =3D bt_pkg->package.elem=
ents[7].integer.value;
> +
> +               sar_rev2.chain_b.subband_2g4     =3D bt_pkg->package.elem=
ents[8].integer.value;
> +               sar_rev2.chain_b.subband_5g2     =3D bt_pkg->package.elem=
ents[9].integer.value;
> +               sar_rev2.chain_b.subband_5g8_5g9 =3D bt_pkg->package.elem=
ents[10].integer.value;
> +               sar_rev2.chain_b.subband_6g1     =3D bt_pkg->package.elem=
ents[11].integer.value;
> +               sar_rev2.chain_b.subband_6g3     =3D bt_pkg->package.elem=
ents[12].integer.value;
> +
> +               bt_dev_dbg(hdev, "BT SAR Rev2: revision=3D%u bt_sar_bios=
=3D%u inc_power_mode=3D%u",
> +                          sar_rev2.revision, sar_rev2.bt_sar_bios, sar_r=
ev2.inc_power_mode);
> +               bt_dev_dbg(hdev, "BT SAR Rev2 Chain A: 2g4=3D%u 5g2=3D%u =
5g8_5g9=3D%u 6g1=3D%u 6g3=3D%u",
> +                          sar_rev2.chain_a.subband_2g4, sar_rev2.chain_a=
.subband_5g2,
> +                          sar_rev2.chain_a.subband_5g8_5g9, sar_rev2.cha=
in_a.subband_6g1,
> +                          sar_rev2.chain_a.subband_6g3);
> +               bt_dev_dbg(hdev, "BT SAR Rev2 Chain B: 2g4=3D%u 5g2=3D%u =
5g8_5g9=3D%u 6g1=3D%u 6g3=3D%u",
> +                          sar_rev2.chain_b.subband_2g4, sar_rev2.chain_b=
.subband_5g2,
> +                          sar_rev2.chain_b.subband_5g8_5g9, sar_rev2.cha=
in_b.subband_6g1,
> +                          sar_rev2.chain_b.subband_6g3);
> +
> +               if (sar_rev2.bt_sar_bios !=3D 1) {
> +                       bt_dev_info(hdev, "Bluetooth SAR Rev2 is not enab=
led");

If you are going to return an erro I guess a bt_dev_warn is probably
better here, if this is not an unexpected error then bt_dev_dbg is
probably better. Actually shouldn't you stop loading if bt_sar_bios
doesn't match? Otherwise you might print entries that don't correspond
to the expected fields above, so I'd just bail out early and stop
loading after checking it.

> +                       ret =3D -EOPNOTSUPP;
> +                       goto error;
> +               }
> +
> +               ret =3D btintel_sar_rev2_send_to_device(hdev, &sar_rev2, =
ver);
> +               goto error;
> +       }
> +
> +       if (revision =3D=3D BTINTEL_SAR_REV2) {
> +               bt_dev_warn(hdev, "BT SAR Rev2: unexpected ACPI package c=
ount %d (expected 13)",
> +                           bt_pkg->package.count);
> +               ret =3D -EINVAL;
> +               goto error;
> +       }
> +
>         memset(&sar, 0, sizeof(sar));
>
>         if (revision =3D=3D BTINTEL_SAR_LEGACY && bt_pkg->package.count =
=3D=3D 8) {
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 70d812ad36a2..3b5a228ca3c0 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -64,6 +64,7 @@ struct intel_tlv {
>
>  /* CNVR */
>  #define BTINTEL_CNVR_FMP2              0x910
> +#define BTINTEL_CNVR_WHP2              0xA10   /* Whale Peak2 - Panther =
Lake */
>
>  #define BTINTEL_IMG_BOOTLOADER         0x01    /* Bootloader image */
>  #define BTINTEL_IMG_IML                        0x02    /* Intermediate i=
mage */
> @@ -202,6 +203,23 @@ struct btintel_sar_inc_pwr {
>         u8      le_lr;
>  };
>
> +/* Bluetooth SAR feature (BRDS), Revision 2 - per-chain sub-band power l=
imits */
> +struct btintel_sar_band_limits {
> +       u8      subband_2g4;
> +       u8      subband_5g2;
> +       u8      subband_5g8_5g9;
> +       u8      subband_6g1;
> +       u8      subband_6g3;
> +};
> +
> +struct btintel_sar_rev2 {
> +       u8      revision;
> +       u32     bt_sar_bios;    /* 1: BIOS-managed SAR enabled */
> +       u32     inc_power_mode; /* 0: supported, 1: disabled */
> +       struct btintel_sar_band_limits chain_a;
> +       struct btintel_sar_band_limits chain_b;
> +};
> +
>  #define INTEL_HW_PLATFORM(cnvx_bt)     ((u8)(((cnvx_bt) & 0x0000ff00) >>=
 8))
>  #define INTEL_HW_VARIANT(cnvx_bt)      ((u8)(((cnvx_bt) & 0x003f0000) >>=
 16))
>  #define INTEL_CNVX_TOP_TYPE(cnvx_top)  ((cnvx_top) & 0x00000fff)
> --
> 2.54.0
>
>


--=20
Luiz Augusto von Dentz
