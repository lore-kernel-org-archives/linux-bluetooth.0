Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED9D34C815
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 05:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774501522; cv=none; b=n+7CI9adMP6DKYKaRjb2yiB/ojRDzsmiSYfbDKbfUe17PkCE7C6M8iX/2mkdTuaCrLguSK5gxSeSnanja6t0WClCjTsO3eJ1O0ksa9skeA03RH6iuT8ofX2xYftkh+HlpXIecaeOfp1sOrDVM57xy0Ov7dp0amd9VMGTyNJK7TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774501522; c=relaxed/simple;
	bh=TyLg5thFWaqlzjvd8zu1XKcqeTfoSr+Jj2R8vgCS6KA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gU9LSgn6AgUMA3VmT3EuJpG6mUizeDlXJICuzXfWiwefEAfcw069o6ebJvQD5lkIITvx8SghhhH9KejYGKrWW9FG8tSklD7IZqwrxZi54WhIgRPrOVxZPteaj5w/g+zw4T8ln9ej+95Sy2QND5HEEspZy6huJVwmKNyFSCYASa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0vhoR5Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0vhoR5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E173C19424
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 05:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774501522;
	bh=TyLg5thFWaqlzjvd8zu1XKcqeTfoSr+Jj2R8vgCS6KA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s0vhoR5QLERHe3jxWNy3J1dO/sE08j7FukSfKmJVmcEiRRmXTrBf6/rfNCyYS5FLW
	 nrGrRKU0QPnU7CHhtVm9WXMENXrq/jzqdIHfANx+R9D2ELhq3SIlNS5KNYuarj23BY
	 PBAUUyYdGUCMl9CCkBjFrXjPkL83mL8lDz4YelI0nYeKgXohGE8KIG7IqIQcdASFqD
	 OwPz+IqID6L/4p0F5CA/nd0ShZsyjJdmDDVGY+jk7vkkc0Ev5wXPbdcqoJyblmUkL0
	 5M0SNSTGnzzMFKXmjxAcZHk6B/WNL+1Y2vRACoMIRCreORSy3UtnJUnWq8bI/LaL3/
	 mteRrAYYKMMmw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3878de20527so3822631fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 22:05:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwgi10x3fvVEkSKaghIeupwVLV1SAgUcE7dmw3NzYpHAF88MKUyWJUrAtTGZXFL4xas/QHk/ckcnHg4G/h+6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8t9pXWze8QQUA2sgEWrupNHaa/b2EJpco9Aq3JCPse+O5aAK
	F53V4QXnQEexHe2VrOvs/7r6xw0v0y2sL2MAffCqXM3/SX5SXJ/sS6frtGXRDRxgDPMlkUhrcts
	AClmkdunnxIV7/bjx5peKpDsEOaB20ns=
X-Received: by 2002:a05:651c:41d5:b0:38a:8602:71e7 with SMTP id
 38308e7fff4ca-38c4311b956mr22846451fa.28.1774501520757; Wed, 25 Mar 2026
 22:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-mt7927-bt-support-v2-0-b892a3252880@jetm.me> <20260325-mt7927-bt-support-v2-1-b892a3252880@jetm.me>
In-Reply-To: <20260325-mt7927-bt-support-v2-1-b892a3252880@jetm.me>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 26 Mar 2026 00:05:11 -0500
X-Gmail-Original-Message-ID: <CAGp9Lzrme_J2UyzzG+7AWGU4MKx4yehgUy4biy4ZbtP9OkbfnQ@mail.gmail.com>
X-Gm-Features: AQROBzAPG2S2pavEhvwOU-i45Vxw9QY7jzh-VaM4p7aDsscxDyjnvBriDVDFaS4
Message-ID: <CAGp9Lzrme_J2UyzzG+7AWGU4MKx4yehgUy4biy4ZbtP9OkbfnQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
To: Javier Tia <floss@jetm.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Ryan Gilbert <xelnaga@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Javier

This is already a clear improvement over the previous version, but I
think there are still a few areas that could be refined further.

On Wed, Mar 25, 2026 at 6:33=E2=80=AFPM Javier Tia <floss@jetm.me> wrote:
>
> The MediaTek MT7927 (Filogic 380) combo WiFi 7 + BT 5.4 module uses
> hardware variant 0x6639 for its Bluetooth subsystem. Without this patch,
> the chip fails with "Unsupported hardware variant (00006639)" or hangs
> during firmware download.
>
> Three changes are needed to support MT6639:
>
> 1. CHIPID workaround: On some boards the BT USB MMIO register reads
>    0x0000 for dev_id, causing the driver to skip the 0x6639 init path.
>    Force dev_id to 0x6639 when it reads zero, matching the equivalent
>    WiFi-side workaround that forces chip=3D0x7927.
>
> 2. Firmware naming: MT6639 uses firmware version prefix "2_1" instead of
>    "1_1" used by MT7925 and other variants. The firmware path is
>    mediatek/mt6639/BT_RAM_CODE_MT6639_2_1_hdr.bin.
>
> 3. Section filtering: The MT6639 firmware binary contains 9 sections, but
>    only sections with (dlmodecrctype & 0xff) =3D=3D 0x01 are Bluetooth-re=
lated.
>    Sending the remaining WiFi/other sections causes an irreversible BT
>    subsystem hang requiring a full power cycle. This matches the Windows
>    driver behavior observed via USB captures.
>
> Also add 0x6639 to the reset register (CONNV3) and firmware setup switch
> cases alongside the existing 0x7925 handling.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221096
> Link: https://github.com/openwrt/mt76/issues/927
> Reported-by: Ryan Gilbert <xelnaga@gmail.com>
> Signed-off-by: Javier Tia <floss@jetm.me>
> ---
>  drivers/bluetooth/btmtk.c | 23 +++++++++++++++++++++--
>  drivers/bluetooth/btmtk.h |  1 +
>  2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 2507d587f28a..13c6e45deede 100644
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
> @@ -1322,6 +1335,11 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>                 fw_flavor =3D (fw_flavor & 0x00000080) >> 7;
>         }
>
> +       if (!dev_id) {
> +               bt_dev_info(hdev, "MT6639: raw CHIPID=3D0x0000, forcing c=
hip=3D0x6639");
> +               dev_id =3D 0x6639;
> +       }

Using raw CHIPID=3D0x0000 to unconditionally force 0x6639 seems fragile.
If another device later hits the same missing-ID condition, it would
also be misdetected as MT6639. Normally this kind of quirk could be
carried in .driver_data, but since btusb.c is shared, I'm not sure
that is the right fit here either. This should probably be handled
through a more device-specific fallback instead of mapping all zero
CHIPID cases to 0x6639.

> +
>         btmtk_data->dev_id =3D dev_id;
>
>         err =3D btmtk_register_coredump(hdev, btmtk_data->drv_name, fw_ve=
rsion);
> @@ -1339,6 +1357,7 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>         case 0x7925:
>         case 0x7961:
>         case 0x7902:
> +       case 0x6639:
>                 btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), d=
ev_id,
>                                       fw_version, fw_flavor);
>
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

Sorry I did not respond to this earlier.
I would prefer using the mediatek/mt7927/ folder naming here. mt7927
is more widely recognized, and using it would avoid unnecessary
confusion.

>
>  #define HCI_EV_WMT 0xe4
>  #define HCI_WMT_MAX_EVENT_SIZE         64
>
> --
> 2.53.0
>
>
