Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8EE3DEADC
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730459; cv=pass; b=PWw8I2U7ai6Ob4m4dupm42+n6nqBROKS0gdh1iGzdupIl/1r47KWifet7QGfblp/U1HgSPv+R8Sy4hPukxVr6EZLS7JsTjS/6EA+AT1FJ/3zgE/QrQj6c1D5oOyOvhAo4dVInTHlW7d5ZzNzy7tOqxX+TO0wHvwtMuxvFn4tO64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730459; c=relaxed/simple;
	bh=CqE4awtrI/P/jZPq/ZPBVBZJoGoLsjflMpvNNkbU4wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQ7YnX+DF+KVcjDQ0B8O73giPYlQKmEEr6vJTv5fMKXWrWFGgmWO09Zh8d2uvQ/ZRAgR0He/51IyaTFIPCJHAYYkZWD1ANUyea1Gt5EC/JG92fSx5966UfpiX3Yh5AwtEQkHnwK/TYLizvBi1dyeAtIrF+JUo0thXGNcVYPkXpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY+nG7ML; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY+nG7ML"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64ad019bbd4so7552553d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2026 09:07:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772730456; cv=none;
        d=google.com; s=arc-20240605;
        b=cyw0d9S8EXCUsDwjmIxOpWqILmEZSstzUUX6h+k4tdJtRGUi9BhnvmGITHiELaHGQO
         5K07CmSQim6JMbJfGaet4gPfoHu+2oPA6uGs38VLkwx/q1ZS0KxqM63Ld/+mSC400Vk4
         OaCIbNjJcWMe1EZDl+PmW269IPt9UnXqWftHjkYDKVk6zuGnx+Q6mpncThev3m+y7/G3
         0mZh0ecIz+60h/cEuB3GOXyo5VYGSe/69eAw0H0AWt1knuyNVc7e65l1n149AK5Ylxae
         u6RE7hwdilHLqT56hYfh53OSYJJwxEm7Ej30pHJs4XjS9ZyE+bFWTI1iJ+So+lm05uFU
         td4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8k9fdqLCftfnxrWQm0u8/OKu6IVCPserpBXK4nosidE=;
        fh=rm4UsBpQoFRUVxuhLKOQAdsxvo9NL1j3b7EyLouuwgY=;
        b=ZsChPNwDjep7WzkNA5E5+0HEMYIVGFUnGosbIi7XkUHLogcTY+i/U49I/EKeLy3xUQ
         cw4jbgux9TVi2fB9ji8+eXGxC7onlj6vY1wk27Fqvhv643QteGPIveJJDNzI93bxFe48
         +G0tVIknp7wftuyN0xwfBM9c293JPdxlx/pPwvdU/s9mFi+3c/GqaKmGvdjB0Cv6Y7Hu
         TYatixz2kizZYnk4rsnD2Wr61nUw2uoSIb/nUTEMhp8ATgq/TmJa5qTeauSzeNQrjheD
         Bqt7eTpSybP/gOsYNMHkc0V6eo+xTxvY5LUHDw3grSU6m5JuGHbn9TCen49oz+ewR2ps
         c5oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772730456; x=1773335256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8k9fdqLCftfnxrWQm0u8/OKu6IVCPserpBXK4nosidE=;
        b=AY+nG7MLs7k6oDT/dCI/iIjmatsoj54he0ONOiNfilhngufQTX3UD1LKKP/xI5OPl5
         pOYdajGlw8nWIhmtDSt63nx1mblnLP4aw56Kmy/nPwmEBklRopelFs5BT19mX+dtUC3Q
         5Ed1NYgauPzqcQpqBUU5P545h9gqoAwqH/QD2GADohBwiWj5D2wpm3kJnMLhkmzfPHHH
         PAFm/EgIbIlG+3JdoprJSZ71jgGTIzqgZYPwLRSXQz5brqe6yh6vdztBXl2Nyd/3JfYf
         GcXMwTECAnV657qZw7a612mUMD+2CDg+XUafgstCW79T7Hb81PubfU/Jd1nl5EpSXc9o
         OFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730456; x=1773335256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8k9fdqLCftfnxrWQm0u8/OKu6IVCPserpBXK4nosidE=;
        b=fxC7kBp9ioCIXlurpxE6Q5Xygntp3m/ismkeBVofJV1cvH9qp+c690GFPXWBbUA8ZD
         rTFj7VNpYgd4sITh2gPiPv5EpCJTG+/3Rg3wYAMFgBZMTznf8bsLG2VbqpTr1f0Har9m
         vmC6zhdn46IFCkps7k4YyD/ay8zJeXbYjU3zThC/duuCoFc8Q+sDQKwWY8w1CkPw1wNW
         N8tNeQE/H4wB6iqOaCoT7K5l3KpvP0Fv6GEwQItMPz+csYDn8b+DvyH5zJdLG23QdlGX
         7hF/pvOFTdm2BczMqk2maNMbPBaq5rcxrvwGafY0xcGD4sBmTE88Zjwq5EFaq5GTw7nC
         V8zA==
X-Gm-Message-State: AOJu0YwaKYReVIexQekPna/79NU/P9OMGn4q+DnMMbuv8PYPRFLHF30E
	qaTujLWTqs9KftZXNrQ5tKggGmJH87rtO9xkzN2NfGuC+1X7zASYfFAZBtO1ucn3ALysHbP/cwb
	aRMrFia+nUoYcyanzc7eTxp5uhWZ1PKjZLw==
X-Gm-Gg: ATEYQzzb5+mU8GNXjZELj3x5wA61lIULKzz3AJGRoi+Z3aZ8OrjIYUVRwussdc3GGQH
	LDy5dkQiaS1rLwWBkDZ5H7SgDH6Sl7h0A3nsXnDCGpV1JKmpZESs0DuDYLqeGri9SEm8TxMZ7+a
	R5Ttcn+iEcssOvT0/k9tAuo+o8rm8BXxL2xv1oC5W1hp4pve+PygH1uGiUjFwqblTwqFVa9I/LL
	BNdPTdaPi0bM3dZtpmPPtldaxKTKcjbEsza61o0pAFSiFje/l1r/957JEf6WlwLfPWnlSYxmouh
	PRGUksuM5AT6PeDWv1IIcVMhQptIj1ewqllHQJJy0ne1qBmp/xT4F7eVFOL8n5yFdrt3fQ==
X-Received: by 2002:a53:ee62:0:b0:64a:d2bb:9072 with SMTP id
 956f58d0204a3-64cf9baea0bmr3944260d50.53.1772730456009; Thu, 05 Mar 2026
 09:07:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177272816248.352280.12453518046823439297@jetm.me> <20260305162928.5E8F11EA006C@mailuser.phl.internal>
In-Reply-To: <20260305162928.5E8F11EA006C@mailuser.phl.internal>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 5 Mar 2026 12:07:24 -0500
X-Gm-Features: AaiRm50hJdKYfYjcvXpxnzZWfAlqiXJnK3reyjb4k1li9opBh6iL5uzdeHgB4HY
Message-ID: <CABBYNZJj0i2aNQdH2DXEnn+JBwNn+xkJU901vLFnnAzdtxtFDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
To: Javier Tia <floss@jetm.me>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Thu, Mar 5, 2026 at 11:33=E2=80=AFAM Javier Tia <floss@jetm.me> wrote:
>
> The MediaTek MT7927 (Filogic 380) combo WiFi 7 + BT 5.4 module uses
> hardware variant 0x6639 for its Bluetooth subsystem. Without this patch,
> the chip fails with "Unsupported hardware variant (00006639)" or hangs
> during firmware download.
>
> Three changes are needed to support MT6639:
>
> 1. Firmware naming: MT6639 uses firmware version prefix "2_1" instead of
>    "1_1" used by MT7925 and other variants. The firmware path is
>    mediatek/mt6639/BT_RAM_CODE_MT6639_2_1_hdr.bin.
>
> 2. Section filtering: The MT6639 firmware binary contains 9 sections, but
>    only sections with (dlmodecrctype & 0xff) =3D=3D 0x01 are Bluetooth-re=
lated.
>    Sending the remaining WiFi/other sections causes an irreversible BT
>    subsystem hang requiring a full power cycle. This matches the Windows
>    driver behavior observed via USB captures.
>
> 3. Firmware persistence: MT6639 firmware persists across BT soft power
>    cycles (WMT_FUNC_CTRL=3D0 does not clear firmware). Skip re-download o=
n
>    subsequent setups to avoid a ~2.6s delay on each BT power toggle.
>
> Also add 0x6639 to the reset register (CONNV3) and firmware setup switch
> cases alongside the existing 0x7925 handling.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221096
> Link: https://github.com/openwrt/mt76/issues/927
> Assisted-by: Claude Code <noreply@anthropic.com> [claude-opus-4-6]

Ditto, we will probably some evidence this was actually tested on
systems e.g. dmesg of the pre/post change, also in this case
specifically we need a mediatek engineer to confim, with a
Signed-off-by, that these changes works as intended.

> Signed-off-by: Javier Tia <floss@jetm.me>
> ---
>  drivers/bluetooth/btmtk.c | 32 ++++++++++++++++++++++++++++++--
>  drivers/bluetooth/btmtk.h |  1 +
>  2 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 2507d587f28a..3821fde9e361 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -112,7 +112,11 @@ static void btmtk_coredump_notify(struct hci_dev *hd=
ev, int state)
>  void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ve=
r,
>                            u32 fw_flavor)
>  {
> -       if (dev_id =3D=3D 0x7925)
> +       if (dev_id =3D=3D 0x6639)
> +               snprintf(buf, size,
> +                        "mediatek/mt%04x/BT_RAM_CODE_MT%04x_2_%x_hdr.bin=
",
> +                        dev_id & 0xffff, dev_id & 0xffff, (fw_ver & 0xff=
) + 1);
> +       else if (dev_id =3D=3D 0x7925)
>                 snprintf(buf, size,
>                          "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x_hdr.bin=
",
>                          dev_id & 0xffff, dev_id & 0xffff, (fw_ver & 0xff=
) + 1);
> @@ -130,6 +134,7 @@ EXPORT_SYMBOL_GPL(btmtk_fw_get_filename);
>  int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
>                               wmt_cmd_sync_func_t wmt_cmd_sync)
>  {
> +       struct btmtk_data *data =3D hci_get_priv(hdev);
>         struct btmtk_hci_wmt_params wmt_params;
>         struct btmtk_patch_header *hdr;
>         struct btmtk_global_desc *globaldesc =3D NULL;
> @@ -166,6 +171,14 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, =
const char *fwname,
>                 section_offset =3D le32_to_cpu(sectionmap->secoffset);
>                 dl_size =3D le32_to_cpu(sectionmap->bin_info_spec.dlsize)=
;
>
> +               /* MT6639: only download sections where dlmode byte0 =3D=
=3D 0x01,
> +                * matching the Windows driver behavior which skips WiFi/=
other
> +                * sections that would cause the chip to hang.
> +                */
> +               if (data->dev_id =3D=3D 0x6639 && dl_size > 0 &&
> +                   (le32_to_cpu(sectionmap->bin_info_spec.dlmodecrctype)=
 & 0xff) !=3D 0x01)
> +                       continue;
> +
>                 if (dl_size > 0) {
>                         retry =3D 20;
>                         while (retry > 0) {
> @@ -852,7 +865,7 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 =
dev_id)
>                 if (err < 0)
>                         return err;
>                 msleep(100);
> -       } else if (dev_id =3D=3D 0x7925) {
> +       } else if (dev_id =3D=3D 0x7925 || dev_id =3D=3D 0x6639) {
>                 err =3D btmtk_usb_uhw_reg_read(hdev, MTK_BT_RESET_REG_CON=
NV3, &val);
>                 if (err < 0)
>                         return err;
> @@ -1339,9 +1352,20 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>         case 0x7925:
>         case 0x7961:
>         case 0x7902:
> +       case 0x6639:
>                 btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), d=
ev_id,
>                                       fw_version, fw_flavor);
>
> +               /* MT6639: firmware persists across BT soft power cycles
> +                * (shutdown only sends WMT_FUNC_CTRL=3D0). Skip re-downl=
oad
> +                * on subsequent setups to avoid ~2.6s delay.
> +                */
> +               if (dev_id =3D=3D 0x6639 &&
> +                   test_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags)) =
{
> +                       bt_dev_info(hdev, "MT6639: firmware already loade=
d, skipping download");
> +                       goto skip_fw_setup_79xx;
> +               }
> +
>                 err =3D btmtk_setup_firmware_79xx(hdev, fw_bin_name,
>                                                 btmtk_usb_hci_wmt_sync);
>                 if (err < 0) {
> @@ -1352,6 +1376,10 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>                         return err;
>                 }
>
> +               if (dev_id =3D=3D 0x6639)
> +                       set_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags=
);
> +
> +skip_fw_setup_79xx:
>                 /* It's Device EndPoint Reset Option Register */
>                 err =3D btmtk_usb_uhw_reg_write(hdev, MTK_EP_RST_OPT,
>                                               MTK_EP_RST_IN_OUT_OPT);
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index adaf385626ee..6645bcadb523 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -8,6 +8,7 @@
>  #define FIRMWARE_MT7902                "mediatek/BT_RAM_CODE_MT7902_1_1_=
hdr.bin"
>  #define FIRMWARE_MT7961                "mediatek/BT_RAM_CODE_MT7961_1_2_=
hdr.bin"
>  #define FIRMWARE_MT7925                "mediatek/mt7925/BT_RAM_CODE_MT79=
25_1_1_hdr.bin"
> +#define FIRMWARE_MT7927                "mediatek/mt6639/BT_RAM_CODE_MT66=
39_2_1_hdr.bin"
>
>  #define HCI_EV_WMT 0xe4
>  #define HCI_WMT_MAX_EVENT_SIZE         64
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz
