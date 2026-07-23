Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D0175A7D
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835167; cv=pass; b=cGGlP8FpA6MGhgZzWxgFOC58KYnJAYqdJdJpznugTMLo06HeQ3pGNGWJyDKehJv06E8IPahtuk4vC521qMLAgcJtvNU6iVtBqSy5J4vVqHoGcWI1YYxddXI7vYuonFGF0283qnVTwlRu11SMbvMVGnIV/ClARTPv3WHPwB4dQh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835167; c=relaxed/simple;
	bh=lpe3VIYhVEy0Ji/bzUYjowWNfXKVbk1+PhnEeCUS/O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdRfLUdW0OjWUXgcxXsXarsoBNqiTeDOUogbx9/cCIm63XPibR738EJDBzBA8IijzQQEF/Rp4trHtPgakxuBvukueqV78+BBRP/bCy+M9zhvpBIdo4/Hr7QsgsAFPPmZAioUD9typOJnVND0ddXCRNKZiU/4uYoK1+qNVwJh6NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qj9ply2H; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj9ply2H"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-667923d86a7so950376d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 12:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784835162; cv=none;
        d=google.com; s=arc-20260327;
        b=o9vmC0kvKZLbbljXZdikfwuMHw4sE3I4rkZ3hJK6hsYS3f7IrjN+H+tXLVMdkuni05
         tIX6Uja4TN1T9+erFeXqkqvq7nclcYywZHM05r+7jafJFHt7uNMYFR680V48I9AqylKu
         2KDmOKVuouCGDgyItpwuSOPHfPC6ymTwSOOsJq7XxKfzAsw8QWhg7bsP77Ekw+SXBgc4
         DGqro2+d2l2ppaf55Gciejmi3HDGQZ0nvbIQvDsCH+XE1/JFEX3Jj/kJFOqCIY569uDo
         H09ExQVdHf61jgAkvyEk+PZIGnMsKf+9e4PN+lQgEFFrfm8Adz2i4w6vxS67PoqgZIUJ
         gK7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=We5OY00B7xf04OTfL4BCMXvHIZhzIdPcRU0ew02t2TU=;
        fh=+K1edB7h43TojSMQ3x70R5W2ulCpl+1Iozz01Fz+K/0=;
        b=L9XoBVALoq8cukv0+L75BejgU8UaErEhmme5dgp198RnSE4rt3QGrJVFRzy3i0M1vp
         vXgs2Wkp05ifRQOmxsouDae4J0hi+4QW+ealrVuc2fcNJbRx31o+Q3EWv7SKViZK6E5b
         7pVemczel/cWMk1sDUp6PBL3A3uYaqedAvDdwlBFT+2987HNrJqGwwmoU0yEXhSWpEJC
         JxY0Mt7uVF6/j+JLpkmttQpY7cN+SF4HuM9AbhVCW4/XYD+TCTS2vJd16htj8/wZWOcy
         LbaZ9tdFlMplyjy+GE388qcvj4j2iQdecpdKTenY75qQlMCioJd1vNdqsnoVcUFvCdsN
         /mGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784835162; x=1785439962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=We5OY00B7xf04OTfL4BCMXvHIZhzIdPcRU0ew02t2TU=;
        b=Qj9ply2H6ouoYsjgSc+90+IX7Za3a7LZbjtG7MxlnCnFP/VO+eIFvA0Q2P5DLSzxYX
         vyuXPuN00vG8xrvr5UmJ/kVSlqXcgDC38WfNBDNVoddxoDolrVQtqV9PBT9cZ6ouuerC
         E0e/lSTk2Uob5+XQhiiBE0qK8YFJxEHr7dS5yZoSYk+Ankahy+LrNqPf+LW2S+Yh/6o3
         Oe41rYy50un9HzT/T9ha9zvKsOWw+JYZeGBqIGI+Sxa6CGtiFzFwwXK0VQ3TE9KNLN/E
         ygVYYydyF3VJK2Q/zi1woWHEDsGs3U+morNeRTkR5z0LJ5EGgEENrIcim4RhD2/cro3o
         rKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784835162; x=1785439962;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=We5OY00B7xf04OTfL4BCMXvHIZhzIdPcRU0ew02t2TU=;
        b=QfcmIQod5IFi7jNAwKC1p6H0PNN5+00sq5ixXcvvT/hgJlAUbFzQQJWsBC/86Jrt3S
         cpdI0MaKYPU0Khv+t2Z1JZE2CXxXhWsJvIhEmMVvE3hhL4VrpZsapeXpRbF65acjaSOO
         wLrpORWyt6x0clmYwV7tXyi3AhnRGGn1hZW41a07k9xn/PmYO6rtKMo1/oHo8PqomGu0
         /vKqL4NR2glMrqZ5mQa79MZjdDT79TCAhR4uLfNFOX+sJNQ6k46CL0Y9/q9IRqR8xJR4
         m+lna+F9K/h5XQGYQF+eDtzfEkcRa/fZHvxzQAYJmkEznk8WT9237s/7BHX7ssx9QJFd
         rjnA==
X-Gm-Message-State: AOJu0Ywx2Pg3V2vrBUVcLt/tONYDRr4NBZz+kOvAHjUzLXHg82tXPLdU
	f60rSGoTdTHmRyA7JKNCrLc617pXaX0MUoorlDFvcbkF945Xgbmo6doXe1cbSYb5FEcwd6whmur
	AhRO0pUswcnJWC/8KLdqwcB0bIMEmmxY=
X-Gm-Gg: AR+sD13yiq+dHxZgDmvg9IgfoRJPUwbOi9VxRAwyp413l6mf9WYxpeRtVp0c01gy6lA
	z8K/OXDk3fvdSKHoHidYsycfVY9lSfMQxXtacTfhjZ2255vWx/P1iDUVV/h5bDp81f4gMgaSR5x
	kfdx9NvQnK0afjXnga1OWj3YjG73CTKrp+uBFUNJ3y37TrJwWwpoluEhTYASg7a87B3aqRHb2Qr
	PkskseAZolymCbZcHBc/EOFa0QyusB2jrHoUeN+PZpLSjclH+MhVw6BguqhmINPZfiVhu5Ljuqw
	vgTvrTD7CrzIUXzOKYDKnC6TjbDaPcdTkDyKkkS2YeVIMxqWKWpe
X-Received: by 2002:a05:690e:e8c:b0:660:6303:f8fa with SMTP id
 956f58d0204a3-668a605a825mr1060431d50.10.1784835162262; Thu, 23 Jul 2026
 12:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723011332.301536-1-kiran.k@intel.com>
In-Reply-To: <20260723011332.301536-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 23 Jul 2026 15:32:31 -0400
X-Gm-Features: AUfX_myiWyW45rYnA0rovM4Nw8J5phbDM4tolujVn4Di3Bxir48wk5SV2Hq7Fn8
Message-ID: <CABBYNZK+P_7yfYziyR6Lh8FAyvF4cV79-O6kD4t0uOTs10w1dA@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: btintel: Add Bluetooth SAR revision 2 support
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com, 
	Ravindra <ravindra@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Wed, Jul 22, 2026 at 8:54=E2=80=AFPM Kiran K <kiran.k@intel.com> wrote:
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
> change in v4:
> - Fix issue reported by Sashiko
>   https://sashiko.dev/#/patchset/20260722155943.296245-1-kiran.k%40intel.=
com
>
> changes in v3:
> - Fix comment in the code.
> - Address comments from Luiz.
>
> changes in v2:
> changes in v2:
> - Update commit message to include logs.
> - Validate the ACPI types/size before accessing.
>
>  drivers/bluetooth/btintel.c | 191 +++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btintel.h |  18 ++++
>  2 files changed, 208 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 5e9cac090bd8..6b14bd01ab8b 100644
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

Why do we need to use a buffer of 64 bytes when the cmd->len is just 4?

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
> @@ -3150,14 +3257,96 @@ static int btintel_acpi_set_sar(struct hci_dev *h=
dev, struct intel_version_tlv *
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
> +               /* Element layout: 0 =3D domain ID (BTINTEL_BT_DOMAIN, 0x=
12),
> +                * 1 =3D bt_sar_bios (u32), 2 =3D inc_power_mode (u32),
> +                * 3..12 =3D per-chain sub-band limits (u8 each).
> +                */
> +               static const u64 rev2_max[13] =3D {
> +                       U8_MAX,                         /* domain ID */
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
> +
> +               if (sar_rev2.bt_sar_bios !=3D 1) {
> +                       bt_dev_warn(hdev, "Bluetooth SAR Rev2 is not enab=
led");
> +                       ret =3D -EOPNOTSUPP;
> +                       goto error;
> +               }
> +
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
> index 37d93abdd5a3..966ec1b02be2 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -65,6 +65,7 @@ struct intel_tlv {
>
>  /* CNVR */
>  #define BTINTEL_CNVR_FMP2              0x910
> +#define BTINTEL_CNVR_WHP2              0xA10   /* Whale Peak2 - Panther =
Lake */
>
>  #define BTINTEL_IMG_BOOTLOADER         0x01    /* Bootloader image */
>  #define BTINTEL_IMG_IML                        0x02    /* Intermediate i=
mage */
> @@ -204,6 +205,23 @@ struct btintel_sar_inc_pwr {
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
