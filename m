Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4164B3126CA
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412798; cv=pass; b=hjxvOixFMUJ/nsIu+RHhVSQxkHIU6Ejl1sYqJe0Co5l2uJpPmvd2DkGqLZ5ppFzdkN/mCYa44CH/0p9B51kF3T79jl4a7ij1QtO7Ozdsd1PjiZnpw3vt08D8wwQXyMOD/H9cZBnClNt9hkJbrPfk069LlRvmP7r9lHhxbb0h7B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412798; c=relaxed/simple;
	bh=4PwpWCqnqwbZaHj6bMLECfvTTbX6VvhsXsddQLcEdH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txsMaHrkA178cLZM+8q3pXsO7O2x9HRfQD1uGp3LML5OjtI+W3xnHvTfupy0gxQANnoIvWPB5/jbNQfZlG/i6td8WqrRZvFT47f5YzpvO1ZpJNMJsM8wlO7z7Rv3uYthfshuRYkhJtAjVN+XKI26HD2wNWG84SSlUxQO1lQEd38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6onKLA2; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6onKLA2"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6647c26a4a3so236239d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 11:39:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782412794; cv=none;
        d=google.com; s=arc-20260327;
        b=RssCUziRyIW9oO3cjpFnmQsp3+1wyWuWtyGFMxJBip6FJSGfxdZjqntk7yxM2QP+Xs
         0YSLoZWvMPv9oU2UIHHRfctLr6URSoUDIIkWz8sLYR55mzbUz4D9FUZVJWRU0J4+DbKa
         QgV1cY6rmwOrmXBtktDvnFwamQriyGv/rMwW61gtwqNOB56l3eDo/+IXt4H8y9pmSNnb
         wNm2hnUk/Ou05IJLBpw2XR0AIEmbwGkLbQdqPcs0+cJp8Q7e0PUMTkJ+qKKGs9yLK+M6
         DUql3mBNpSOYuhSSyZWfQbsV4JmIblJOUHMs3eIJLu07jN0r7VcM18lDi/5xplK8xIo8
         tSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NLGFpRO6oCXazxFNN01n2/MLSgwZq8gccBHj2LTrKEI=;
        fh=Hsrkh+BqVPZXNjdDgNsvcM7WWtRde7T76hOAeQdJ7FI=;
        b=E5r9zJaqWLUjrOXszgrLj7ACcV1t21WqCnttd2yOFjtxzKPvvtt6HT8Z/TzMbXfNjx
         t5hPeO7OSaNGcdwDsaFswwa493Z97TmOUzz17jpSec0H3UDEJDNFoDntK0bnJykSjyTG
         GrOJJ3Bfb4ZzENnGarguECjfIRkfR78pG+DIDBRDtalPFxCXYszxwv1w6fD0E3bTUlqB
         4HBfbqSoRBz4g9n7cAv/3PCFqAOjtKuxhd8w9AaDZdHF2uNRjgYgbZN4399qcg1w/37+
         BrY5mNt8GY4MrbXFPGBSJTCj6tniquWayUwdbJ7OssC8EqzZitA0zgnCqi/sdNVC5YlX
         cMww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782412794; x=1783017594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLGFpRO6oCXazxFNN01n2/MLSgwZq8gccBHj2LTrKEI=;
        b=n6onKLA2gRb1Z4801a7L475M/ZovsgZK8XL1nPL2kKml6s+0wA0us7YcXjnxDBzhXW
         PH8FEqYcZe23BSasJ3rk2TbY3nu/AwWOhdVS8Dvm0rxzmQhiZFe+e8hwSlAHsapCs6Bv
         nixckDgCMvxd4GuTIBc99A4KWUgBbpGcpmPmFnJWJ5fq3skl/Lt31eoUyYaR1JTHtPnC
         lmPUYzruWxNml8BzF7Pa2SNq8YjVJrvPqMY8vKCz4cVGSN8vithP6LEkDqoobLE8Kv6I
         wjg2Hwyl9oVWRmIPjG9mSkh4Vbg+6vmZa9jQ9DOuw6KpshY6c8KlrQDUBpHAyDajzmBV
         0iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782412794; x=1783017594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NLGFpRO6oCXazxFNN01n2/MLSgwZq8gccBHj2LTrKEI=;
        b=QrYl1E2QnKkgOkg4KGYxblywbUgSF40A3OVA6KXUOMSNvTiRLnV5bC04Zmcqf3guxp
         O7h4jPSLOspLitKBucpBmmnVQ/nM6tcPQvYhUD1gYYjVjJcQzRhGI9mCwNftQxFpq1Sw
         Eay4KJ4tbyy/JzAUk/ATHFcd1lHj0wHC4rS29BeErLFljqTEp4M6RXPwqkV2zFj07sO3
         59Tye8O63qKSF5HnRo0VSE0Lo3We7p266OFdTAkR8pUHN7ZfigeL1s+mjyJEkWzYj7IU
         yDVorr52SM0yyNGCiFgEtPtGoR9CDBf4eJJjwjhPU85T0kih69SA31DHNS4eBq4YsBnT
         D7Cw==
X-Forwarded-Encrypted: i=1; AHgh+Rocl06jx1ssSwRO6Alpbn/cQAQwcY5SxfTO/60OpWI+jFaP1m51XcfMZ7/nw3dZqE+h326FplZ3XdQ35ww8pVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2ATwDajcQjmICUx6MJlzlhrXJ0jo7nmgBRVLD1cCUQwTRaeB
	sAU/tdtyFHSisB5sw2js6DtgqCVtxR9LKJKkmK10aF5MikIzrH36FWdG4Ym6TupLpVu0pWt3XfR
	4l0cXucTADLQwuwc6D+1jaEKFyUmsLhk=
X-Gm-Gg: AfdE7ckoc/8mD9RVFwhm1rdlfXxH73u8m1aYmOq0tILGUC0zfGPfs4OtYkLuLwV2QAK
	YKKv4y4Rn+VLlaJqBXFB5j16L5jQ+e7ow9ItCXB0XcBU3KvGq0vUK8QF6ACEQtmm76aSjnez1up
	SsI0PpsfyWsWKt0KKMe+ehftRDGtGmW8CS0fmxyxW3eThbr8NMEQ0F/VygbNPlnfWPKw/Nq00Cl
	e6Sq1lINR9/jMp5AVl3zTba+efWGng7+mMYw5PilIMJmwDniunlUB+woem4qvLlhqgxUwmJ8NE6
	L+ZrC1df15nlPUhJ/MfywCS2icONaQ2yIDbDAJcJPWBJO2IjI2ElaIn6IDw=
X-Received: by 2002:a05:690e:a4f:b0:65c:468:7b6f with SMTP id
 956f58d0204a3-66487c6ca7emr3096937d50.25.1782412794009; Thu, 25 Jun 2026
 11:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZ+_aocMGOdugwF3uP9h3NN4Dv5XYRyiN50W0AJ3rSETTA@mail.gmail.com>
 <20260624053334.3151885-1-hildawu@realtek.com>
In-Reply-To: <20260624053334.3151885-1-hildawu@realtek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 25 Jun 2026 14:39:42 -0400
X-Gm-Features: AVVi8CdBm99nquagbbj_KhXgrtyEYoQ5pv4WfI1Bb4I3Szha2bfJ0SAXpvd4WR0
Message-ID: <CABBYNZK075E597LHYN3QbK2NOqmb59iZTC4kQ_fNy9O3kgHLiA@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: btrtl: Add firmware format v3 support
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex_lu@realsil.com.cn, 
	jason_mao@realsil.com.cn, zoey_zhou@realsil.com.cn, max.chou@realtek.com, 
	kidman@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hilda,

On Wed, Jun 24, 2026 at 1:33=E2=80=AFAM Hilda Wu <hildawu@realtek.com> wrot=
e:
>
> Realtek updated its Bluetooth firmware format to v3.
> This patch extends the btrtl driver to recognise and parse the new v3 fil=
e
> format, including:
> - New signature string and image ID definitions
> - Extension of btrtl_device_info to store v3-specific metadata
> - Logic to extract and load firmware data out of v3 images
> - Maintains compatibility with existing v2 firmware format
>
> This is required for future Realtek Bluetooth chips that ship with
> v3 firmware.
> The RTL8922D is the first IC to use firmware format V3, so the following
> example uses the RTL8922D's log as expected fw format v3 output:
>
> Bluetooth: btrtl_read_chip_id() hci0: RTL: chip_id status=3D0x00 id=3D0x3=
7
> Bluetooth: btrtl_initialize() hci0: RTL: examining hci_ver=3D0d
> hci_rev=3D000d lmp_ver=3D0d lmp_subver=3D8922
> Bluetooth: rtl_read_rom_version() hci0: RTL: rom_version status=3D0 versi=
on=3D1
> Bluetooth: btrtl_initialize() hci0: RTL: btrtl_initialize: key id 0
> Bluetooth: rtl_load_file() hci0: RTL: loading rtl_bt/rtl8922du_fw.bin
> Bluetooth: rtl_load_file() hci0: RTL: loading rtl_bt/rtl8922du_config.bin
> Bluetooth: rtlbt_parse_firmware_v3() hci0: RTL: key id 0
> Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image (f000:00), chip id
> 55, cut 0x02, len 00007185
> Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image version: 35fd7908
> Bluetooth: rtlbt_parse_config() hci0: RTL: config file:
> rtl_bt/rtl8922du_config_f000.bin
> Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image (f002:00), chip id
> 55, cut 0x02, len 000078f5
> Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image version: 47b6874d
> Bluetooth: rtlbt_parse_config() hci0: RTL: config file:
> rtl_bt/rtl8922du_config_f002.bin
> Bluetooth: rtlbt_parse_firmware_v3() hci0: RTL: image payload total len:
> 0x0000ea7a
> Bluetooth: rtl_finalize_download() hci0: RTL: Watchdog reset status 00
> Bluetooth: rtl_finalize_download() hci0: RTL: fw version 0x47b6874d
>
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> Signed-off-by: Zoey Zhou <zoey_zhou@realsil.com.cn>
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
>
> ---
> V4 -> V5::
> - Add independent support for RTL8922D section
> - Introduce macros to improve code readability
> - Document firmware format v3 and its differences
> - Align implementation with reviewer feedback
>
> V3 -> V4:
> - Rework skb->data access and add clarifying comments
> - Fix latent issues
>
> V2 -> V3:
> - Address coccinelle warning
>
> V1 -> V2:
> - Add missing symbols
> - Resolve build warnings
> ---
>  drivers/bluetooth/btrtl.c | 698 +++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btrtl.h | 102 ++++++
>  drivers/bluetooth/btusb.c |   3 +
>  3 files changed, 786 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 49ecb18fea45..450b32bcfa63 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -22,6 +22,12 @@
>  #define RTL_CHIP_8723CS_XX     5
>  #define RTL_EPATCH_SIGNATURE   "Realtech"
>  #define RTL_EPATCH_SIGNATURE_V2        "RTBTCore"
> +#define RTL_EPATCH_SIGNATURE_V3        "BTNIC003"
> +#define RTL_PATCH_V3_1         0x01
> +#define RTL_PATCH_V3_2         0x02
> +#define IMAGE_ID_F000          0xf000
> +#define IMAGE_ID_F001          0xf001
> +#define IMAGE_ID_F002          0xf002
>  #define RTL_ROM_LMP_8703B      0x8703
>  #define RTL_ROM_LMP_8723A      0x1200
>  #define RTL_ROM_LMP_8723B      0x8723
> @@ -33,7 +39,14 @@
>  #define RTL_ROM_LMP_8922A      0x8922
>  #define RTL_CONFIG_MAGIC       0x8723ab55
>
> -#define RTL_VSC_OP_COREDUMP    0xfcff
> +#define RTL_VSC_OP_DOWNLOAD_CMD                0xfc20
> +#define RTL_VSC_OP_READ_VENDER         0xfc61
> +#define RTL_VSC_OP_WRITE_VENDOR                0xfc62
> +#define RTL_VSC_OP_READ_ROM_VER                0xfc6d
> +#define RTL_VSC_OP_READ_CHIP_ID                0xfc6f
> +#define RTL_VSC_OP_COREDUMP            0xfcff
> +#define RTL_VSC_OP_CHECK_DOWNLOAD_STATE        0xfdcf
> +#define RTL_VSC_OP_WDG_RESET_CMD       0xfc8e
>
>  #define IC_MATCH_FL_LMPSUBV    (1 << 0)
>  #define IC_MATCH_FL_HCIREV     (1 << 1)
> @@ -50,12 +63,16 @@
>
>  #define        RTL_CHIP_SUBVER (&(struct rtl_vendor_cmd) {{0x10, 0x38, 0=
x04, 0x28, 0x80}})
>  #define        RTL_CHIP_REV    (&(struct rtl_vendor_cmd) {{0x10, 0x3A, 0=
x04, 0x28, 0x80}})
> -#define        RTL_SEC_PROJ    (&(struct rtl_vendor_cmd) {{0x10, 0xA4, 0=
xAD, 0x00, 0xb0}})
> +#define        RTL_SEC_PROJ_V2 (&(struct rtl_vendor_cmd) {{0x10, 0xA4, 0=
xAD, 0x00, 0xb0}})
> +#define        RTL_SEC_PROJ_V3 (&(struct rtl_vendor_cmd) {{0x10, 0xA4, 0=
x0D, 0x01, 0xa0}})
>
>  #define RTL_PATCH_SNIPPETS             0x01
>  #define RTL_PATCH_DUMMY_HEADER         0x02
>  #define RTL_PATCH_SECURITY_HEADER      0x03
>
> +#define CHIP_ID_V3_BASE                55
> +#define RTL_VENDOR_WRITE_TYPE          0x21
> +
>  enum btrtl_chip_id {
>         CHIP_ID_8723A,
>         CHIP_ID_8723B,
> @@ -99,8 +116,11 @@ struct btrtl_device_info {
>         int cfg_len;
>         bool drop_fw;
>         int project_id;
> +       u32 opcode;
> +       u8 fw_type;
>         u8 key_id;
>         struct list_head patch_subsecs;
> +       struct list_head patch_images;
>  };
>
>  static const struct id_table ic_id_table[] =3D {
> @@ -371,6 +391,33 @@ static const struct id_table *btrtl_match_ic(u16 lmp=
_subver, u16 hci_rev,
>         return &ic_id_table[i];
>  }
>
> +static int btrtl_read_chip_id(struct hci_dev *hdev, u8 *chip_id)
> +{
> +       struct rtl_rp_read_chip_id *rp;
> +       struct sk_buff *skb;
> +       int ret =3D 0;
> +
> +       skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_READ_CHIP_ID, 0, NULL, HC=
I_INIT_TIMEOUT);
> +       if (IS_ERR(skb))
> +               return PTR_ERR(skb);
> +
> +       rp =3D skb_pull_data(skb, sizeof(*rp));
> +       if (!rp) {
> +               ret =3D -EIO;
> +               goto out;
> +       }
> +
> +       rtl_dev_info(hdev, "chip_id status=3D0x%02x id=3D0x%02x",
> +                    rp->status, rp->chip_id);
> +
> +       if (chip_id)
> +               *chip_id =3D rp->chip_id;
> +
> +out:
> +       kfree_skb(skb);
> +       return ret;
> +}
> +
>  static struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev)
>  {
>         struct sk_buff *skb;
> @@ -397,8 +444,7 @@ static int rtl_read_rom_version(struct hci_dev *hdev,=
 u8 *version)
>         struct rtl_rom_version_evt *rom_version;
>         struct sk_buff *skb;
>
> -       /* Read RTL ROM version command */
> -       skb =3D __hci_cmd_sync(hdev, 0xfc6d, 0, NULL, HCI_INIT_TIMEOUT);
> +       skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_READ_ROM_VER, 0, NULL, HC=
I_INIT_TIMEOUT);
>         if (IS_ERR(skb)) {
>                 rtl_dev_err(hdev, "Read ROM version failed (%ld)",
>                             PTR_ERR(skb));
> @@ -427,7 +473,7 @@ static int btrtl_vendor_read_reg16(struct hci_dev *hd=
ev,
>         struct sk_buff *skb;
>         int err =3D 0;
>
> -       skb =3D __hci_cmd_sync(hdev, 0xfc61, sizeof(*cmd), cmd,
> +       skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_READ_VENDER, sizeof(*cmd)=
, cmd,
>                              HCI_INIT_TIMEOUT);
>         if (IS_ERR(skb)) {
>                 err =3D PTR_ERR(skb);
> @@ -449,6 +495,26 @@ static int btrtl_vendor_read_reg16(struct hci_dev *h=
dev,
>         return 0;
>  }
>
> +static int btrtl_vendor_write_mem(struct hci_dev *hdev, u32 addr, u32 va=
l)
> +{
> +       struct rtl_vendor_write_cmd cp;
> +       struct sk_buff *skb;
> +       int err =3D 0;
> +
> +       cp.type =3D RTL_VENDOR_WRITE_TYPE;
> +       cp.addr =3D cpu_to_le32(addr);
> +       cp.val =3D cpu_to_le32(val);
> +       skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_WRITE_VENDOR, sizeof(cp),=
 &cp, HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               err =3D PTR_ERR(skb);
> +               bt_dev_err(hdev, "RTL: Write mem32 failed (%d)", err);
> +               return err;
> +       }
> +
> +       kfree_skb(skb);
> +       return 0;
> +}
> +
>  static void *rtl_iov_pull_data(struct rtl_iovec *iov, u32 len)
>  {
>         void *data =3D iov->data;
> @@ -462,6 +528,31 @@ static void *rtl_iov_pull_data(struct rtl_iovec *iov=
, u32 len)
>         return data;
>  }
>
> +
> +static void btrtl_insert_ordered_patch_image(struct rtl_section_patch_im=
age *image,
> +                                            struct btrtl_device_info *bt=
rtl_dev)
> +{
> +       struct list_head *pos;
> +       struct list_head *next;
> +       struct rtl_section_patch_image *node;
> +
> +       list_for_each_safe(pos, next, &btrtl_dev->patch_images) {
> +               node =3D list_entry(pos, struct rtl_section_patch_image, =
list);
> +
> +               if (node->image_id > image->image_id) {
> +                       __list_add(&image->list, pos->prev, pos);
> +                       return;
> +               }
> +
> +               if (node->image_id =3D=3D image->image_id &&
> +                   node->index > image->index) {
> +                       __list_add(&image->list, pos->prev, pos);
> +                       return;
> +               }
> +       }
> +       __list_add(&image->list, pos->prev, pos);
> +}
> +
>  static void btrtl_insert_ordered_subsec(struct rtl_subsection *node,
>                                         struct btrtl_device_info *btrtl_d=
ev)
>  {
> @@ -633,6 +724,279 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *=
hdev,
>         }
>
>         *_buf =3D ptr;
> +       btrtl_dev->fw_type =3D FW_TYPE_V2;
> +       return len;
> +}
> +
> +static int rtlbt_parse_config(struct hci_dev *hdev,
> +                             struct rtl_section_patch_image *patch_image=
,
> +                             struct btrtl_device_info *btrtl_dev)
> +{
> +       const struct id_table *ic_info =3D NULL;
> +       const struct firmware *fw;
> +       char tmp_name[32];
> +       char filename[64];
> +       u8 *cfg_buf;
> +       char *str;
> +       char *p;
> +       size_t len;
> +       int ret;
> +
> +       if (btrtl_dev && btrtl_dev->ic_info)
> +               ic_info =3D btrtl_dev->ic_info;
> +
> +       if (!ic_info)
> +               return -EINVAL;
> +
> +       str =3D ic_info->cfg_name;
> +       if (btrtl_dev->fw_type =3D=3D FW_TYPE_V3_1) {
> +               if (!patch_image->image_id && !patch_image->index) {
> +                       snprintf(filename, sizeof(filename), "%s.bin", st=
r);
> +                       goto load_fw;
> +               }
> +               goto done;
> +       }
> +
> +       len =3D strlen(str);
> +       if (len > sizeof(tmp_name) - 1)
> +               len =3D sizeof(tmp_name) - 1;
> +       memcpy(tmp_name, str, len);
> +       tmp_name[len] =3D '\0';
> +
> +       str =3D tmp_name;
> +       p =3D strsep(&str, ".");
> +
> +       ret =3D snprintf(filename, sizeof(filename), "%s", p);
> +       if (patch_image->config_rule && patch_image->need_config) {
> +               switch (patch_image->image_id) {
> +               case IMAGE_ID_F000:
> +               case IMAGE_ID_F001:
> +               case IMAGE_ID_F002:
> +                       ret +=3D snprintf(filename + ret, sizeof(filename=
) - ret,
> +                                       "_%04x", patch_image->image_id);
> +                       break;
> +               default:
> +                       goto done;
> +               }
> +       } else {
> +               goto done;
> +       }
> +
> +       snprintf(filename + ret, sizeof(filename) - ret, ".%s", str ? str=
 : "bin");
> +
> +load_fw:
> +       rtl_dev_info(hdev, "config file: %s", filename);
> +       ret =3D request_firmware(&fw, filename, &hdev->dev);
> +       if (ret < 0) {
> +               if (btrtl_dev->fw_type =3D=3D FW_TYPE_V3_2) {
> +                       len =3D 4;
> +                       cfg_buf =3D kvmalloc(len, GFP_KERNEL);
> +                       if (!cfg_buf)
> +                               return -ENOMEM;
> +
> +                       memset(cfg_buf, 0xff, len);
> +                       patch_image->cfg_buf =3D cfg_buf;
> +                       patch_image->cfg_len =3D len;
> +                       return 0;
> +               }
> +               goto err_req_fw;
> +       }
> +       rtl_dev_info(hdev, "config file: %s found", filename);
> +       cfg_buf =3D kvmalloc(fw->size, GFP_KERNEL);
> +       if (!cfg_buf) {
> +               ret =3D -ENOMEM;
> +               goto err;
> +       }
> +       memcpy(cfg_buf, fw->data, fw->size);
> +       len =3D fw->size;
> +       release_firmware(fw);
> +
> +       patch_image->cfg_buf =3D cfg_buf;
> +       patch_image->cfg_len =3D len;
> +done:
> +       return 0;
> +err:
> +       release_firmware(fw);
> +err_req_fw:
> +       rtl_dev_info(hdev, "config file: [%s] not found", filename);
> +       return ret;
> +}
> +
> +static int rtlbt_parse_section_v3(struct hci_dev *hdev,
> +                                 struct btrtl_device_info *btrtl_dev,
> +                                 u32 opcode, u8 *data, u32 len)
> +{
> +       struct rtl_section_patch_image *patch_image;
> +       struct rtl_patch_image_hdr *hdr;
> +       u16 image_id;
> +       u16 chip_id;
> +       size_t patch_image_len;
> +       u8 *ptr;
> +       int ret =3D 0;
> +       size_t i;
> +       struct rtl_iovec iov =3D {
> +               .data =3D data,
> +               .len  =3D len,
> +       };
> +
> +       hdr =3D rtl_iov_pull_data(&iov, sizeof(*hdr));
> +       if (!hdr)
> +               return -EINVAL;
> +
> +       if (btrtl_dev->opcode && btrtl_dev->opcode !=3D opcode) {
> +               rtl_dev_err(hdev, "invalid opcode 0x%02x", opcode);
> +               return -EINVAL;
> +       }
> +
> +       if (!btrtl_dev->opcode) {
> +               btrtl_dev->opcode =3D opcode;
> +               switch (btrtl_dev->opcode) {
> +               case RTL_PATCH_V3_1:
> +                       btrtl_dev->fw_type =3D FW_TYPE_V3_1;
> +                       break;
> +               case RTL_PATCH_V3_2:
> +                       btrtl_dev->fw_type =3D FW_TYPE_V3_2;
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       patch_image_len =3D (u32)le64_to_cpu(hdr->patch_image_len);
> +       chip_id =3D le16_to_cpu(hdr->chip_id);
> +       image_id =3D le16_to_cpu(hdr->image_id);
> +       rtl_dev_info(hdev, "image (%04x:%02x), chip id %u, cut 0x%02x, le=
n %08zx"
> +                    , image_id, hdr->index, chip_id, hdr->ic_cut,
> +                    patch_image_len);
> +
> +       if (btrtl_dev->key_id !=3D hdr->key_id) {
> +               rtl_dev_err(hdev, "invalid key_id (%u, %u)", hdr->key_id,
> +                           btrtl_dev->key_id);
> +               return -EINVAL;
> +       }
> +
> +       if (hdr->ic_cut !=3D btrtl_dev->rom_version + 1) {
> +               rtl_dev_info(hdev, "unused ic_cut (%u, %u)", hdr->ic_cut,
> +                           btrtl_dev->rom_version + 1);
> +               return -EINVAL;
> +       }
> +
> +       if (btrtl_dev->fw_type =3D=3D FW_TYPE_V3_1 && !btrtl_dev->project=
_id)
> +               btrtl_dev->project_id =3D chip_id;
> +
> +       if (btrtl_dev->fw_type =3D=3D FW_TYPE_V3_2 &&
> +           chip_id !=3D btrtl_dev->project_id) {
> +               rtl_dev_err(hdev, "invalid chip_id (%u, %d)", chip_id,
> +                           btrtl_dev->project_id);
> +               return -EINVAL;
> +       }
> +
> +       ptr =3D rtl_iov_pull_data(&iov, patch_image_len);
> +       if (!ptr)
> +               return -ENODATA;
> +
> +       patch_image =3D kzalloc_obj(*patch_image);
> +       if (!patch_image)
> +               return -ENOMEM;
> +       patch_image->index =3D hdr->index;
> +       patch_image->image_id =3D image_id;
> +       patch_image->config_rule =3D hdr->config_rule;
> +       patch_image->need_config =3D hdr->need_config;
> +
> +       for (i =3D 0; i < DL_FIX_ADDR_MAX; i++) {
> +               patch_image->fix[i].addr =3D
> +                       (u32)le64_to_cpu(hdr->addr_fix[i * 2]);
> +               patch_image->fix[i].value =3D
> +                       (u32)le64_to_cpu(hdr->addr_fix[i * 2 + 1]);
> +       }
> +
> +       patch_image->image_len =3D patch_image_len;
> +       patch_image->image_data =3D kvmalloc(patch_image_len, GFP_KERNEL)=
;
> +       if (!patch_image->image_data) {
> +               ret =3D -ENOMEM;
> +               goto err;
> +       }
> +       memcpy(patch_image->image_data, ptr, patch_image_len);
> +       patch_image->image_ver =3D
> +               get_unaligned_le32(ptr + patch_image->image_len - 4);
> +       rtl_dev_info(hdev, "image version: %08x", patch_image->image_ver)=
;
> +
> +       rtlbt_parse_config(hdev, patch_image, btrtl_dev);
> +
> +       ret =3D patch_image->image_len;
> +
> +       btrtl_insert_ordered_patch_image(patch_image, btrtl_dev);
> +
> +       return ret;
> +err:
> +       kfree(patch_image);
> +       return ret;
> +}
> +
> +static int rtlbt_parse_firmware_v3(struct hci_dev *hdev,
> +                                  struct btrtl_device_info *btrtl_dev)
> +{
> +       struct rtl_epatch_header_v3 *hdr;
> +       int rc;
> +       u32 num_sections;
> +       struct rtl_section_v3 *section;
> +       u32 section_len;
> +       u32 opcode;
> +       int len =3D 0;
> +       int i;
> +       u8 *ptr;
> +       struct rtl_iovec iov =3D {
> +               .data =3D btrtl_dev->fw_data,
> +               .len  =3D btrtl_dev->fw_len,
> +       };
> +
> +       rtl_dev_info(hdev, "key id %u", btrtl_dev->key_id);
> +
> +       hdr =3D rtl_iov_pull_data(&iov, sizeof(*hdr));
> +       if (!hdr)
> +               return -EINVAL;
> +       num_sections =3D le32_to_cpu(hdr->num_sections);
> +
> +       rtl_dev_dbg(hdev, "timpstamp %08x-%08x", *((u32 *)hdr->timestamp)=
,
> +                   *((u32 *)(hdr->timestamp + 4)));
> +
> +       for (i =3D 0; i < num_sections; i++) {
> +               section =3D rtl_iov_pull_data(&iov, sizeof(*section));
> +               if (!section)
> +                       break;
> +
> +               section_len =3D (u32)le64_to_cpu(section->len);
> +               opcode =3D le32_to_cpu(section->opcode);
> +
> +               rtl_dev_dbg(hdev, "opcode 0x%04x", section->opcode);
> +
> +               ptr =3D rtl_iov_pull_data(&iov, section_len);
> +               if (!ptr)
> +                       break;
> +
> +               rc =3D 0;
> +               switch (opcode) {
> +               case RTL_PATCH_V3_1:
> +               case RTL_PATCH_V3_2:
> +                       rc =3D rtlbt_parse_section_v3(hdev, btrtl_dev, op=
code,
> +                                                   ptr, section_len);
> +                       break;
> +               default:
> +                       rtl_dev_warn(hdev, "Unknown opcode %08x", opcode)=
;
> +                       break;
> +               }
> +               if (rc < 0) {
> +                       rtl_dev_err(hdev, "Parse section (%u) err (%d)",
> +                                   opcode, rc);
> +                       continue;
> +               }
> +               len +=3D rc;
> +       }
> +
> +       rtl_dev_info(hdev, "image payload total len: 0x%08x", len);
> +       if (!len)
> +               return -ENODATA;
> +
>         return len;
>  }
>
> @@ -678,6 +1042,9 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev=
,
>         if (btrtl_dev->fw_len <=3D 8)
>                 return -EINVAL;
>
> +       if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE_V3, 8))
> +               return rtlbt_parse_firmware_v3(hdev, btrtl_dev);
> +
>         if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE, 8))
>                 min_size =3D sizeof(struct rtl_epatch_header) +
>                                 sizeof(extension_sig) + 3;
> @@ -813,10 +1180,11 @@ static int rtlbt_parse_firmware(struct hci_dev *hd=
ev,
>         memcpy(buf + patch_length - 4, &epatch_info->fw_version, 4);
>
>         *_buf =3D buf;
> +       btrtl_dev->fw_type =3D FW_TYPE_V1;
>         return len;
>  }
>
> -static int rtl_download_firmware(struct hci_dev *hdev,
> +static int rtl_download_firmware(struct hci_dev *hdev, u8 fw_type,
>                                  const unsigned char *data, int fw_len)
>  {
>         struct rtl_download_cmd *dl_cmd;
> @@ -827,6 +1195,13 @@ static int rtl_download_firmware(struct hci_dev *hd=
ev,
>         int j =3D 0;
>         struct sk_buff *skb;
>         struct hci_rp_read_local_version *rp;
> +       u8 dl_rp_len =3D sizeof(struct rtl_download_response);
> +
> +       if (is_v3_fw(fw_type)) {
> +               j =3D 1;
> +               if (fw_type =3D=3D FW_TYPE_V3_2)
> +                       dl_rp_len++;
> +       }
>
>         dl_cmd =3D kmalloc_obj(*dl_cmd);
>         if (!dl_cmd)
> @@ -840,15 +1215,15 @@ static int rtl_download_firmware(struct hci_dev *h=
dev,
>                         j =3D 1;
>
>                 if (i =3D=3D (frag_num - 1)) {
> -                       dl_cmd->index |=3D 0x80; /* data end */
> +                       if (!is_v3_fw(fw_type))
> +                               dl_cmd->index |=3D 0x80; /* data end */
>                         frag_len =3D fw_len % RTL_FRAG_LEN;
>                 }
>                 rtl_dev_dbg(hdev, "download fw (%d/%d). index =3D %d", i,
>                                 frag_num, dl_cmd->index);
>                 memcpy(dl_cmd->data, data, frag_len);
>
> -               /* Send download command */
> -               skb =3D __hci_cmd_sync(hdev, 0xfc20, frag_len + 1, dl_cmd=
,
> +               skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_DOWNLOAD_CMD, fra=
g_len + 1, dl_cmd,
>                                      HCI_INIT_TIMEOUT);
>                 if (IS_ERR(skb)) {
>                         rtl_dev_err(hdev, "download fw command failed (%l=
d)",
> @@ -857,7 +1232,7 @@ static int rtl_download_firmware(struct hci_dev *hde=
v,
>                         goto out;
>                 }
>
> -               if (skb->len !=3D sizeof(struct rtl_download_response)) {
> +               if (skb->len !=3D dl_rp_len) {
>                         rtl_dev_err(hdev, "download fw event length misma=
tch");
>                         kfree_skb(skb);
>                         ret =3D -EIO;
> @@ -868,6 +1243,9 @@ static int rtl_download_firmware(struct hci_dev *hde=
v,
>                 data +=3D RTL_FRAG_LEN;
>         }
>
> +       if (is_v3_fw(fw_type))
> +               goto out;
> +
>         skb =3D btrtl_read_local_version(hdev);
>         if (IS_ERR(skb)) {
>                 ret =3D PTR_ERR(skb);
> @@ -885,6 +1263,237 @@ static int rtl_download_firmware(struct hci_dev *h=
dev,
>         return ret;
>  }
>
> +static int rtl_check_download_state(struct hci_dev *hdev,
> +                                   struct btrtl_device_info *btrtl_dev)
> +{
> +       struct sk_buff *skb;
> +       int ret =3D 0;
> +       u8 *state;
> +
> +       skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_CHECK_DOWNLOAD_STATE, 0, =
NULL, HCI_CMD_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               rtl_dev_err(hdev, "write tb error %lu", PTR_ERR(skb));
> +               return -EIO;
> +       }
> +
> +       /* Other driver might be downloading the combined firmware. */
> +       state =3D skb_pull_data(skb, sizeof(*state));
> +       if (state && *state =3D=3D 0x03) {
> +               btrealtek_set_flag(hdev, REALTEK_DOWNLOADING);
> +               ret =3D btrealtek_wait_on_flag_timeout(hdev, REALTEK_DOWN=
LOADING,
> +                                                    TASK_INTERRUPTIBLE,
> +                                                    msecs_to_jiffies(500=
0));
> +               if (ret =3D=3D -EINTR) {
> +                       bt_dev_err(hdev, "Firmware loading interrupted");
> +                       goto out;
> +               }
> +
> +               if (ret) {
> +                       bt_dev_err(hdev, "Firmware loading timeout");
> +                       ret =3D -ETIMEDOUT;
> +               } else {
> +                       ret =3D -EALREADY;
> +               }
> +
> +       }
> +
> +out:
> +       kfree_skb(skb);
> +       return ret;
> +}
> +
> +static int rtl_finalize_download(struct hci_dev *hdev,
> +                                struct btrtl_device_info *btrtl_dev)
> +{
> +       struct hci_rp_read_local_version *rp_ver;
> +       u8 params[2] =3D { 0x03, 0xb2 };
> +       struct sk_buff *skb;
> +       int ret =3D 0;
> +       u16 opcode;
> +       u32 len;
> +       u8 *p;
> +
> +       opcode =3D RTL_VSC_OP_WDG_RESET_CMD;
> +       len =3D 2;
> +       if (btrtl_dev->opcode =3D=3D RTL_PATCH_V3_1) {
> +               opcode =3D RTL_VSC_OP_DOWNLOAD_CMD;
> +               params[0] =3D 0x80;
> +               len =3D 1;
> +       }
> +       skb =3D __hci_cmd_sync(hdev, opcode, len, params, HCI_CMD_TIMEOUT=
);
> +       if (IS_ERR(skb)) {
> +               rtl_dev_err(hdev, "Watchdog reset err (%ld)", PTR_ERR(skb=
));
> +               return -EIO;
> +       }
> +       p =3D skb_pull_data(skb, 1);
> +       if (!p) {
> +               ret =3D -ENODATA;
> +               goto out;
> +       }
> +       rtl_dev_info(hdev, "Watchdog reset status %02x", *p);
> +       kfree_skb(skb);
> +
> +       skb =3D btrtl_read_local_version(hdev);
> +       if (IS_ERR(skb)) {
> +               ret =3D PTR_ERR(skb);
> +               rtl_dev_err(hdev, "read local version failed (%d)", ret);
> +               return ret;
> +       }
> +
> +       rp_ver =3D skb_pull_data(skb, sizeof(*rp_ver));
> +       if (rp_ver)
> +               rtl_dev_info(hdev, "fw version 0x%04x%04x",
> +                            __le16_to_cpu(rp_ver->hci_rev),
> +                            __le16_to_cpu(rp_ver->lmp_subver));
> +out:
> +       kfree_skb(skb);
> +       return ret;
> +}
> +
> +static int rtl_security_check(struct hci_dev *hdev,
> +                             struct btrtl_device_info *btrtl_dev)
> +{
> +       struct rtl_section_patch_image *tmp =3D NULL;
> +       struct rtl_section_patch_image *image =3D NULL;
> +       u32 val;
> +       int ret;
> +
> +       list_for_each_entry_reverse(tmp, &btrtl_dev->patch_images, list) =
{
> +               /* Check security hdr */
> +               if (!tmp->fix[DL_FIX_SEC_HDR_ADDR].value ||
> +                   !tmp->fix[DL_FIX_SEC_HDR_ADDR].addr ||
> +                   tmp->fix[DL_FIX_SEC_HDR_ADDR].addr =3D=3D 0xffffffff)
> +                       continue;
> +               rtl_dev_info(hdev, "addr 0x%08x, value 0x%08x",
> +                            tmp->fix[DL_FIX_SEC_HDR_ADDR].addr,
> +                            tmp->fix[DL_FIX_SEC_HDR_ADDR].value);
> +               image =3D tmp;
> +               break;
> +       }
> +
> +       if (!image)
> +               return 0;
> +
> +       rtl_dev_info(hdev, "sec image (%04x:%02x)", image->image_id,
> +                    image->index);
> +       val =3D image->fix[DL_FIX_PATCH_ADDR].value + image->image_len -
> +                                       image->fix[DL_FIX_SEC_HDR_ADDR].v=
alue;
> +       ret =3D btrtl_vendor_write_mem(hdev, image->fix[DL_FIX_PATCH_ADDR=
].addr,
> +                                    val);
> +       if (ret) {
> +               rtl_dev_err(hdev, "write sec reg failed (%d)", ret);
> +               return ret;
> +       }
> +       return 0;
> +}
> +
> +static int rtl_download_firmware_v3(struct hci_dev *hdev,
> +                                   struct btrtl_device_info *btrtl_dev)
> +{
> +       struct rtl_section_patch_image *image, *tmp;
> +       struct rtl_rp_dl_v3 *rp;
> +       struct sk_buff *skb;
> +       u8 *fw_data;
> +       int fw_len;
> +       int ret =3D 0;
> +       u8 i;
> +
> +       if (btrtl_dev->fw_type =3D=3D FW_TYPE_V3_2) {
> +               ret =3D rtl_check_download_state(hdev, btrtl_dev);
> +               if (ret) {
> +                       if (ret =3D=3D -EALREADY)
> +                               return 0;
> +                       return ret;
> +               }
> +       }
> +
> +       list_for_each_entry_safe(image, tmp, &btrtl_dev->patch_images, li=
st) {
> +               rtl_dev_dbg(hdev, "image (%04x:%02x)", image->image_id,
> +                           image->index);
> +
> +               for (i =3D DL_FIX_CI_ID; i < DL_FIX_ADDR_MAX; i++) {
> +                       if (!image->fix[i].addr ||
> +                           image->fix[i].addr =3D=3D 0xffffffff) {
> +                               rtl_dev_dbg(hdev, "no need to write addr =
%08x",
> +                                           image->fix[i].addr);
> +                               continue;
> +                       }
> +                       rtl_dev_dbg(hdev, "write addr and val, 0x%08x, 0x=
%08x",
> +                                   image->fix[i].addr, image->fix[i].val=
ue);
> +                       if (btrtl_vendor_write_mem(hdev, image->fix[i].ad=
dr,
> +                                                  image->fix[i].value)) =
{
> +                               rtl_dev_err(hdev, "write reg failed");
> +                               ret =3D -EIO;
> +                               goto done;
> +                       }
> +               }
> +
> +               fw_len =3D image->image_len + image->cfg_len;
> +               fw_data =3D kvmalloc(fw_len, GFP_KERNEL);
> +               if (!fw_data) {
> +                       rtl_dev_err(hdev, "Couldn't alloc buf for image d=
ata");
> +                       ret =3D -ENOMEM;
> +                       goto done;
> +               }
> +               memcpy(fw_data, image->image_data, image->image_len);
> +               if (image->cfg_len > 0)
> +                       memcpy(fw_data + image->image_len, image->cfg_buf=
,
> +                              image->cfg_len);
> +
> +               rtl_dev_dbg(hdev, "patch image (%04x:%02x). len: %d",
> +                           image->image_id, image->index, fw_len);
> +               rtl_dev_dbg(hdev, "fw_data %p, image buf %p, len %u", fw_=
data,
> +                           image->image_data, image->image_len);
> +
> +               ret =3D rtl_download_firmware(hdev, btrtl_dev->fw_type, f=
w_data,
> +                                           fw_len);
> +               kvfree(fw_data);
> +               if (ret < 0) {
> +                       rtl_dev_err(hdev, "download firmware failed (%d)"=
, ret);
> +                       goto done;
> +               }
> +
> +               if (image->list.next !=3D &btrtl_dev->patch_images &&
> +                   image->image_id =3D=3D tmp->image_id)
> +                       continue;
> +
> +               if (btrtl_dev->fw_type =3D=3D FW_TYPE_V3_1)
> +                       continue;
> +
> +               i =3D 0x80;
> +               skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_DOWNLOAD_CMD, 1, =
&i, HCI_CMD_TIMEOUT);
> +               if (IS_ERR(skb)) {
> +                       ret =3D -EIO;
> +                       rtl_dev_err(hdev, "Failed to issue last cmd fc20,=
 %ld",
> +                                   PTR_ERR(skb));
> +                       goto done;
> +               }
> +               ret =3D 2;
> +               rp =3D skb_pull_data(skb, sizeof(*rp));
> +               if (rp)
> +                       ret =3D rp->err;
> +               kfree_skb(skb);
> +               if (ret =3D=3D 2) {
> +                       /* Verification failure */
> +                       ret =3D -EFAULT;
> +                       goto done;
> +               }
> +       }
> +
> +       if (btrtl_dev->fw_type =3D=3D FW_TYPE_V3_1) {
> +               ret =3D rtl_security_check(hdev, btrtl_dev);
> +               if (ret) {
> +                       rtl_dev_err(hdev, "Security check failed (%d)", r=
et);
> +                       goto done;
> +               }
> +       }
> +
> +       ret =3D rtl_finalize_download(hdev, btrtl_dev);
> +
> +done:
> +       return ret;
> +}
> +
>  static int rtl_load_file(struct hci_dev *hdev, const char *name, u8 **bu=
ff)
>  {
>         const struct firmware *fw;
> @@ -918,7 +1527,7 @@ static int btrtl_setup_rtl8723a(struct hci_dev *hdev=
,
>                 return -EINVAL;
>         }
>
> -       return rtl_download_firmware(hdev, btrtl_dev->fw_data,
> +       return rtl_download_firmware(hdev, FW_TYPE_V0, btrtl_dev->fw_data=
,
>                                      btrtl_dev->fw_len);
>  }
>
> @@ -933,7 +1542,7 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev=
,
>         if (ret < 0)
>                 goto out;
>
> -       if (btrtl_dev->cfg_len > 0) {
> +       if (!is_v3_fw(btrtl_dev->fw_type) && btrtl_dev->cfg_len > 0) {
>                 tbuff =3D kvzalloc(ret + btrtl_dev->cfg_len, GFP_KERNEL);
>                 if (!tbuff) {
>                         ret =3D -ENOMEM;
> @@ -949,9 +1558,14 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hde=
v,
>                 fw_data =3D tbuff;
>         }
>
> +       if (is_v3_fw(btrtl_dev->fw_type)) {
> +               ret =3D rtl_download_firmware_v3(hdev, btrtl_dev);
> +               goto out;
> +       }
> +
>         rtl_dev_info(hdev, "cfg_sz %d, total sz %d", btrtl_dev->cfg_len, =
ret);
>
> -       ret =3D rtl_download_firmware(hdev, fw_data, ret);
> +       ret =3D rtl_download_firmware(hdev, btrtl_dev->fw_type, fw_data, =
ret);
>
>  out:
>         kvfree(fw_data);
> @@ -1021,7 +1635,7 @@ static int rtl_read_chip_type(struct hci_dev *hdev,=
 u8 *type)
>         const unsigned char cmd_buf[] =3D {0x00, 0x94, 0xa0, 0x00, 0xb0};
>
>         /* Read RTL chip type command */
> -       skb =3D __hci_cmd_sync(hdev, 0xfc61, 5, cmd_buf, HCI_INIT_TIMEOUT=
);
> +       skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_READ_VENDER, 5, cmd_buf, =
HCI_INIT_TIMEOUT);
>         if (IS_ERR(skb)) {
>                 rtl_dev_err(hdev, "Read chip type failed (%ld)",
>                             PTR_ERR(skb));
> @@ -1047,6 +1661,7 @@ static int rtl_read_chip_type(struct hci_dev *hdev,=
 u8 *type)
>  void btrtl_free(struct btrtl_device_info *btrtl_dev)
>  {
>         struct rtl_subsection *entry, *tmp;
> +       struct rtl_section_patch_image *image, *next;
>
>         kvfree(btrtl_dev->fw_data);
>         kvfree(btrtl_dev->cfg_data);
> @@ -1056,6 +1671,13 @@ void btrtl_free(struct btrtl_device_info *btrtl_de=
v)
>                 kfree(entry);
>         }
>
> +       list_for_each_entry_safe(image, next, &btrtl_dev->patch_images, l=
ist) {
> +               list_del(&image->list);
> +               kvfree(image->image_data);
> +               kvfree(image->cfg_buf);
> +               kfree(image);
> +       }
> +
>         kfree(btrtl_dev);
>  }
>  EXPORT_SYMBOL_GPL(btrtl_free);
> @@ -1063,7 +1685,7 @@ EXPORT_SYMBOL_GPL(btrtl_free);
>  struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>                                            const char *postfix)
>  {
> -       struct btrealtek_data *coredump_info =3D hci_get_priv(hdev);
> +       struct btrealtek_data *btrtl_data  =3D hci_get_priv(hdev);
>         struct btrtl_device_info *btrtl_dev;
>         struct sk_buff *skb;
>         struct hci_rp_read_local_version *resp;
> @@ -1072,6 +1694,7 @@ struct btrtl_device_info *btrtl_initialize(struct h=
ci_dev *hdev,
>         char cfg_name[40];
>         u16 hci_rev, lmp_subver;
>         u8 hci_ver, lmp_ver, chip_type =3D 0;
> +       u8 chip_id =3D 0;
>         int ret;
>         int rc;
>         u8 key_id;
> @@ -1084,8 +1707,15 @@ struct btrtl_device_info *btrtl_initialize(struct =
hci_dev *hdev,
>         }
>
>         INIT_LIST_HEAD(&btrtl_dev->patch_subsecs);
> +       INIT_LIST_HEAD(&btrtl_dev->patch_images);
>
>  check_version:
> +       ret =3D btrtl_read_chip_id(hdev, &chip_id);
> +       if (!ret && chip_id >=3D CHIP_ID_V3_BASE) {
> +               btrtl_dev->project_id =3D chip_id;
> +               goto read_local_ver;
> +       }
> +
>         ret =3D btrtl_vendor_read_reg16(hdev, RTL_CHIP_SUBVER, reg_val);
>         if (ret < 0)
>                 goto err_free;
> @@ -1108,6 +1738,7 @@ struct btrtl_device_info *btrtl_initialize(struct h=
ci_dev *hdev,
>                 }
>         }
>
> +read_local_ver:
>         skb =3D btrtl_read_local_version(hdev);
>         if (IS_ERR(skb)) {
>                 ret =3D PTR_ERR(skb);
> @@ -1185,7 +1816,11 @@ struct btrtl_device_info *btrtl_initialize(struct =
hci_dev *hdev,
>                 goto err_free;
>         }
>
> -       rc =3D btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
> +       if (btrtl_dev->project_id >=3D CHIP_ID_V3_BASE)
> +               rc =3D btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ_V3, reg=
_val);
> +       else
> +               rc =3D btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ_V2, reg=
_val);
> +
>         if (rc < 0)
>                 goto err_free;
>
> @@ -1243,7 +1878,7 @@ struct btrtl_device_info *btrtl_initialize(struct h=
ci_dev *hdev,
>                 hci_set_msft_opcode(hdev, 0xFCF0);
>
>         if (btrtl_dev->ic_info)
> -               coredump_info->rtl_dump.controller =3D btrtl_dev->ic_info=
->hw_info;
> +               btrtl_data->rtl_dump.controller =3D btrtl_dev->ic_info->h=
w_info;
>
>         return btrtl_dev;
>
> @@ -1416,6 +2051,35 @@ int btrtl_shutdown_realtek(struct hci_dev *hdev)
>  }
>  EXPORT_SYMBOL_GPL(btrtl_shutdown_realtek);
>
> +
> +int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       struct sk_buff *clone =3D skb_clone(skb, GFP_ATOMIC);
> +       struct hci_event_hdr *hdr;
> +       u8 *p;
> +
> +       if (!clone)
> +               goto out;
> +
> +       hdr =3D skb_pull_data(clone, sizeof(*hdr));
> +       if (!hdr || hdr->evt !=3D HCI_VENDOR_PKT)
> +               goto out;
> +
> +       p =3D skb_pull_data(clone, 1);
> +       if (!p)
> +               goto out;
> +       switch (*p) {
> +       case 0x77:
> +               if (btrealtek_test_and_clear_flag(hdev, REALTEK_DOWNLOADI=
NG))
> +                       btrealtek_wake_up_flag(hdev, REALTEK_DOWNLOADING)=
;
> +               break;
> +       }
> +out:
> +       consume_skb(clone);
> +       return hci_recv_frame(hdev, skb);
> +}
> +EXPORT_SYMBOL_GPL(btrtl_recv_event);
> +
>  static unsigned int btrtl_convert_baudrate(u32 device_baudrate)
>  {
>         switch (device_baudrate) {
> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> index a2d9d34f9fb0..dd4acdf29b2f 100644
> --- a/drivers/bluetooth/btrtl.h
> +++ b/drivers/bluetooth/btrtl.h
> @@ -12,6 +12,19 @@
>  #define rtl_dev_info(dev, fmt, ...) bt_dev_info(dev, "RTL: " fmt, ##__VA=
_ARGS__)
>  #define rtl_dev_dbg(dev, fmt, ...) bt_dev_dbg(dev, "RTL: " fmt, ##__VA_A=
RGS__)
>
> +#define FW_TYPE_V0             0
> +#define FW_TYPE_V1             1
> +#define FW_TYPE_V2             2
> +#define FW_TYPE_V3_1           3
> +#define FW_TYPE_V3_2           4
> +#define is_v3_fw(type) (type =3D=3D FW_TYPE_V3_1 || type =3D=3D FW_TYPE_=
V3_2)
> +
> +#define DL_FIX_CI_ID           0
> +#define DL_FIX_CI_ADDR         1
> +#define DL_FIX_PATCH_ADDR      2
> +#define DL_FIX_SEC_HDR_ADDR    3
> +#define DL_FIX_ADDR_MAX                4
> +
>  struct btrtl_device_info;
>
>  struct rtl_chip_type_evt {
> @@ -103,8 +116,79 @@ struct rtl_vendor_cmd {
>         __u8 param[5];
>  } __packed;
>
> +struct rtl_vendor_write_cmd {
> +       u8 type;
> +       __le32 addr;
> +       __le32 val;
> +} __packed;
> +
> +struct rtl_rp_read_chip_id {
> +       __u8 status;
> +       __u8 chip_id;
> +} __packed;
> +
> +struct rtl_rp_dl_v3 {
> +       __u8 status;
> +       __u8 index;
> +       __u8 err;
> +} __packed;
> +
> +struct rtl_epatch_header_v3 {
> +       __u8 signature[8];
> +       __u8 timestamp[8];
> +       __le32 ver_rsvd;
> +       __le32 num_sections;
> +} __packed;
> +
> +struct rtl_section_v3 {
> +       __le32 opcode;
> +       __le64 len;
> +       u8 data[];
> +} __packed;
> +
> +struct rtl_addr_fix {
> +       u32 addr;
> +       u32 value;
> +};
> +
> +struct rtl_section_patch_image {
> +       u16 image_id;
> +       u8 index;
> +       u8 config_rule;
> +       u8 need_config;
> +
> +       struct rtl_addr_fix fix[DL_FIX_ADDR_MAX];
> +
> +       u32 image_len;
> +       u8 *image_data;
> +       u32 image_ver;
> +
> +       u8  *cfg_buf;
> +       u16 cfg_len;
> +
> +       struct list_head list;
> +};
> +
> +struct rtl_patch_image_hdr {
> +       __le16 chip_id;
> +       u8 ic_cut;
> +       u8 key_id;
> +       u8 enable_ota;
> +       __le16 image_id;
> +       u8 config_rule;
> +       u8 need_config;
> +       u8 rsv[950];
> +
> +       __le64 addr_fix[DL_FIX_ADDR_MAX * 2];
> +       u8 index;
> +
> +       __le64 patch_image_len;
> +       __u8 data[];
> +} __packed;
> +
>  enum {
>         REALTEK_ALT6_CONTINUOUS_TX_CHIP,
> +       REALTEK_DOWNLOADING,
>
>         __REALTEK_NUM_FLAGS,
>  };
> @@ -130,8 +214,20 @@ struct btrealtek_data {
>  #define btrealtek_get_flag(hdev)                                       \
>         (((struct btrealtek_data *)hci_get_priv(hdev))->flags)
>
> +#define btrealtek_wake_up_flag(hdev, nr)                               \
> +       do {                                                            \
> +               struct btrealtek_data *rtl =3D hci_get_priv((hdev));     =
 \
> +               wake_up_bit(rtl->flags, (nr));                          \
> +       } while (0)
> +
>  #define btrealtek_test_flag(hdev, nr)  test_bit((nr), btrealtek_get_flag=
(hdev))
>
> +#define btrealtek_test_and_clear_flag(hdev, nr)                         =
       \
> +               test_and_clear_bit((nr), btrealtek_get_flag(hdev))
> +
> +#define btrealtek_wait_on_flag_timeout(hdev, nr, m, to)                 =
       \
> +               wait_on_bit_timeout(btrealtek_get_flag(hdev), (nr), m, to=
)
> +
>  #if IS_ENABLED(CONFIG_BT_RTL)
>
>  struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
> @@ -148,6 +244,7 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
>                             unsigned int *controller_baudrate,
>                             u32 *device_baudrate, bool *flow_control);
>  void btrtl_set_driver_name(struct hci_dev *hdev, const char *driver_name=
);
> +int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb);
>
>  #else
>
> @@ -157,6 +254,11 @@ static inline struct btrtl_device_info *btrtl_initia=
lize(struct hci_dev *hdev,
>         return ERR_PTR(-EOPNOTSUPP);
>  }
>
> +static inline int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff =
*skb)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  static inline void btrtl_free(struct btrtl_device_info *btrtl_dev)
>  {
>  }
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 7f14ce96319b..55a845efaeb5 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2798,6 +2798,9 @@ static int btusb_recv_event_realtek(struct hci_dev =
*hdev, struct sk_buff *skb)
>                 return 0;
>         }
>
> +       if (skb->data[0] =3D=3D HCI_VENDOR_PKT)
> +               return btrtl_recv_event(hdev, skb);
> +
>         return hci_recv_frame(hdev, skb);
>  }
>
> --
> 2.34.1

Sashiko flagged quite a few problems with these changes:

https://sashiko.dev/#/patchset/20260624053334.3151885-1-hildawu%40realtek.c=
om

--=20
Luiz Augusto von Dentz
