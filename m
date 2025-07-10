Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F727A112;
	Thu, 10 Jul 2025 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163103; cv=none; b=BACIegAou+ozHj6pDuN5a4CpYJ8iLuL6MbsxwhTISdBm93c68arlZms3Xcrg0MOUuSfqSF5+Wu3HTdHJckmddnfIShs4NUM5Sz9Ynx+fJgffef2NfJcca2duEFYL00wwGHIdrxuTf5t0Km8pyBx4P7OEVQWlGd0sSJeZxLQE+nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163103; c=relaxed/simple;
	bh=rik6+uWEIEs048SBfPwZy3acGuuYSqmlCRdFdfWkKbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kg4nxAbxVm6HMMmU22rA6spf18N16Kl556Q+kS6aYpr0z0p4v74tTJomVi5wSfRV6/xulua7gmziu/wVD79UH+q6gKHhWWqu7mmSjJJCaYxTjAG3niwgNUSP8dxuuZ+BtKTOQzth6Cm5IZDNL33DtkkRYIHRocxMiFLpVlBKwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ig+742tP; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ig+742tP"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32f1763673cso14810161fa.3;
        Thu, 10 Jul 2025 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752163098; x=1752767898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAYtkMAVE0egdHhQfg2aZBOtnuYta5iU24Ca9Csv8Qo=;
        b=Ig+742tPU9BMzy7Xb6cYSSzYVSCvztqP5quQiLDIoX9/AgXc8XDnahZk6yGEr91i4e
         KMHtCZrFiPIavdZr+xdX3q1g+hhtMJq2Ntx9YsEdh/OCC1+E1EcPa1hb0/YIumH1EVFl
         YJwzjBxpau6Yu6ZgQ+RK9+dKR/HVmwjt9jg+sN6XuaNdoX1v8LSojVxmO+6VcD1UIHQA
         gWDOfmMPYnkg4UsvE+AtuCP2qda/W7DzYrGQXInzp3+jiBOUb6WRjtlrFvg3JOBa64Oz
         ilupLJDgdjy7GhiKgOYeUg3YdynrHPKMt2BSS1e0tvtUkRgHwVLIkAH6JK+rlxE2AJp9
         tk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163098; x=1752767898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAYtkMAVE0egdHhQfg2aZBOtnuYta5iU24Ca9Csv8Qo=;
        b=f7BEODjsI9NrF5wAGFMkaRQAXXr0fH0dX5rDtcRG7It194eNAU9OC+lppqk1jjIHwv
         WX7hFSlKs1Uyhf2+DlxvAdevV0qKbHTwq+ZxVMmVQikTFdGFW+5hGypyO1bzmQu8p2op
         emCo+im+EZDVqcIbOhxZqpqF0d+l+sqERXL86q7oJZeXqIOWQydum07F6oVmCCbn5/jR
         h9e4uh124b9XWLSHHWPxYYAkmP0ltaLAtCdh6t/FmoXlLNzxwPohjmBXKiLc+XEAPDbG
         ymka8cJVBEZ/60vVofpIv8d9rB7m3aMxfZvQC7TKMy4TtNzAFxWn3eJg7Whd4fE6r93i
         DQqg==
X-Forwarded-Encrypted: i=1; AJvYcCXAfrrUhXn75L7dMO30SrL0sO2+VcCiGGxhio5tu78JUMJgTLGfHf35C9UxFo0XwHEGnWwXaybhuRIq40q18u8=@vger.kernel.org, AJvYcCXAxVoah0GHjJyMICx9hQqU/ad+f1ceOxTTJHDlwN70v3OUqN9XlJiHwRGGc4ORkNS6vLgvWh2KvJV+jBAt@vger.kernel.org
X-Gm-Message-State: AOJu0YzBQs9Ee5dMqMh/8ikGXIMe5SxkFSojI6FR1XlZFKCOysROkBhV
	vxwNRwqecIsQLfNsaWxY3joa2B6iX04NS48SJpDwhRmud46Ycnmlz6TOuhGzc3o9aEIcI3Is3Mv
	co3rmm/m+QpzpQzYhaod0pIAfYFxKnmk=
X-Gm-Gg: ASbGncsD9gVgKnl2nseB9rP/y+O7XN3igPaR2WLBW9SGPN0e8d9se2XBM7g9eBL14Oo
	sCWDIUiRMc/Q+p/fjSbNY9BhJ6UNCGRLq9QyGiSxDMQ9DN9597YlusQhlhiBoXn4lbnvm4GuCIL
	RrfqM8+XRfkEP+u+ohlU4kFbhe86Xr4ReFt3VJ0jzfgg==
X-Google-Smtp-Source: AGHT+IFF93635vR1XqaYRJGacTMy6DHiUIEqjGPmR5KKVJk2crgzEiklGvygYbnIhODvOxPqn09wNhlPL22RXXkHEHo=
X-Received: by 2002:a2e:ae18:0:10b0:32c:a771:9899 with SMTP id
 38308e7fff4ca-32fab95f137mr9718771fa.9.1752163097985; Thu, 10 Jul 2025
 08:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708124516.2836881-1-hildawu@realtek.com>
In-Reply-To: <20250708124516.2836881-1-hildawu@realtek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 10 Jul 2025 11:58:02 -0400
X-Gm-Features: Ac12FXwUQCNs5xJ0oBEC2zZaVR_66uzTghQ_gSdfVE6VLhGu_Up3msAPRpGKqx4
Message-ID: <CABBYNZ+_aocMGOdugwF3uP9h3NN4Dv5XYRyiN50W0AJ3rSETTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Bluetooth: btrtl: Firmware format v3 support
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex_lu@realsil.com.cn, max.chou@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hilda,

On Tue, Jul 8, 2025 at 8:45=E2=80=AFAM Hilda Wu <hildawu@realtek.com> wrote=
:
>
> Realtek changed the format of the firmware file as v3. The driver
> should implement the patch to extract the firmware data from the
> firmware file. The future chips must apply this patch for firmware loadin=
g.
> This patch is compatible with the both previous format, v2 and v3 as well=
.

Can you please add the expected output, there seems to be a lot of
info being added. Is this really necessary for regular users to see
these messages? Also please review all the access to skb->data without
first checking its boundaries with skb->len, I catch of few of them
but there might be more.

> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
> Change in V3:
> - Fixed cocci warning
>
> Change in V2:
> - Fill in the missing symbols
> - Fix build warnings
> ---
> ---
>  drivers/bluetooth/btrtl.c | 669 +++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btrtl.h | 102 ++++++
>  drivers/bluetooth/btusb.c |   3 +
>  3 files changed, 766 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 7838c89e529e..af28f5355aa1 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -22,6 +22,12 @@
>  #define RTL_CHIP_8723CS_XX     5
>  #define RTL_EPATCH_SIGNATURE   "Realtech"
>  #define RTL_EPATCH_SIGNATURE_V2        "RTBTCore"
> +#define RTL_EPATCH_SIGNATURE_V3        "BTNIC003"
> +#define RTL_PATCH_V3_1                 0x01
> +#define RTL_PATCH_V3_PATCH_IMAGE       0x02
> +#define IMAGE_ID_F000          0xf000
> +#define IMAGE_ID_F001          0xf001
> +#define IMAGE_ID_F002          0xf002
>  #define RTL_ROM_LMP_8703B      0x8703
>  #define RTL_ROM_LMP_8723A      0x1200
>  #define RTL_ROM_LMP_8723B      0x8723
> @@ -72,6 +78,7 @@ enum btrtl_chip_id {
>         CHIP_ID_8851B =3D 36,
>         CHIP_ID_8922A =3D 44,
>         CHIP_ID_8852BT =3D 47,
> +       CHIP_ID_8922D =3D 55,
>  };
>
>  struct id_table {
> @@ -98,8 +105,11 @@ struct btrtl_device_info {
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
> @@ -328,6 +338,15 @@ static const struct id_table ic_id_table[] =3D {
>           .fw_name  =3D "rtl_bt/rtl8852btu_fw",
>           .cfg_name =3D "rtl_bt/rtl8852btu_config",
>           .hw_info  =3D "rtl8852btu" },
> +
> +       /* 8922DU */
> +       { IC_INFO(RTL_ROM_LMP_8922A, 0xd, 0xe, HCI_USB),
> +         .config_needed =3D false,
> +         .has_rom_version =3D true,
> +         .has_msft_ext =3D true,
> +         .fw_name  =3D "rtl_bt/rtl8922du_fw",
> +         .cfg_name =3D "rtl_bt/rtl8922du_config",
> +         .hw_info  =3D "rtl8922du" },
>         };
>
>  static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev=
,
> @@ -361,6 +380,33 @@ static const struct id_table *btrtl_match_ic(u16 lmp=
_subver, u16 hci_rev,
>         return &ic_id_table[i];
>  }
>
> +static int btrtl_read_chip_id(struct hci_dev *hdev, u8 *chip_id)
> +{
> +       struct rtl_rp_read_chip_id *rp;
> +       struct sk_buff *skb;
> +
> +       /* Read RTL chip id command */
> +       skb =3D __hci_cmd_sync(hdev, 0xfc6f, 0, NULL, HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb))
> +               return PTR_ERR(skb);
> +
> +       if (skb->len !=3D sizeof(*rp)) {
> +               rtl_dev_err(hdev, "read chip id event length mismatch");
> +               kfree_skb(skb);
> +               return -EIO;
> +       }
> +
> +       rp =3D (struct rtl_rp_read_chip_id *)skb->data;

You don't need to do checks for the size and casts if you use skb_pull_data=
.

> +       rtl_dev_info(hdev, "chip_id status=3D0x%02x id=3D0x%02x",
> +                    rp->status, rp->chip_id);
> +
> +       if (chip_id)
> +               *chip_id =3D rp->chip_id;
> +
> +       kfree_skb(skb);
> +       return 0;
> +}
> +
>  static struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev)
>  {
>         struct sk_buff *skb;
> @@ -439,6 +485,26 @@ static int btrtl_vendor_read_reg16(struct hci_dev *h=
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
> +       cp.type =3D 0x21;
> +       cp.addr =3D cpu_to_le32(addr);
> +       cp.val =3D cpu_to_le32(val);
> +       skb =3D __hci_cmd_sync(hdev, 0xfc62, sizeof(cp), &cp, HCI_INIT_TI=
MEOUT);
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
> @@ -452,6 +518,30 @@ static void *rtl_iov_pull_data(struct rtl_iovec *iov=
, u32 len)
>         return data;
>  }
>
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
> @@ -629,6 +719,295 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *=
hdev,
>                 return -EPERM;
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
> +       int len;
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
> +       if (str)
> +               snprintf(filename + ret, sizeof(filename) - ret, ".%s", s=
tr);
> +       else
> +               snprintf(filename + ret, sizeof(filename) - ret, ".bin");
> +load_fw:
> +       rtl_dev_info(hdev, "config file: %s", filename);
> +       ret =3D request_firmware(&fw, filename, &hdev->dev);
> +       if (ret < 0) {
> +               rtl_dev_err(hdev, "request_firmware [%s] error", filename=
);
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
> +       u32 patch_image_len;
> +       u8 *ptr;
> +       int ret =3D 0;
> +       u8 i;
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
> +               case RTL_PATCH_V3_PATCH_IMAGE:
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
n %08x"
> +                    , image_id, hdr->index, chip_id, hdr->ic_cut,
> +                    patch_image_len);
> +
> +       if (btrtl_dev->key_id && btrtl_dev->key_id !=3D hdr->key_id) {
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
> +       patch_image =3D kzalloc(sizeof(*patch_image), GFP_KERNEL);
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
> +       struct rtl_vendor_cmd cmd_data =3D { {0x10, 0xa4, 0xad, 0x00, 0xb=
0} };
> +       u8 reg_val[2];
> +
> +       if (btrtl_dev->project_id >=3D CHIP_ID_8922D) {
> +               /* A0010DA4 */
> +               cmd_data.param[2] =3D 0x0d;
> +               cmd_data.param[3] =3D 0x01;
> +               cmd_data.param[4] =3D 0xa0;
> +       }
> +
> +       rc =3D btrtl_vendor_read_reg16(hdev, &cmd_data, reg_val);
> +       if (rc < 0)
> +               return -EIO;
> +
> +       rtl_dev_info(hdev, "key id %u", reg_val[0]);
> +
> +       btrtl_dev->key_id =3D reg_val[0];
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
> +               case RTL_PATCH_V3_PATCH_IMAGE:
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
> @@ -673,6 +1052,9 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev=
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
> @@ -808,10 +1190,11 @@ static int rtlbt_parse_firmware(struct hci_dev *hd=
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
> @@ -822,6 +1205,13 @@ static int rtl_download_firmware(struct hci_dev *hd=
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
>         dl_cmd =3D kmalloc(sizeof(*dl_cmd), GFP_KERNEL);
>         if (!dl_cmd)
> @@ -834,7 +1224,7 @@ static int rtl_download_firmware(struct hci_dev *hde=
v,
>                 if (dl_cmd->index =3D=3D 0x7f)
>                         j =3D 1;
>
> -               if (i =3D=3D (frag_num - 1)) {
> +               if (i =3D=3D (frag_num - 1) && !is_v3_fw(fw_type)) {
>                         dl_cmd->index |=3D 0x80; /* data end */
>                         frag_len =3D fw_len % RTL_FRAG_LEN;
>                 }
> @@ -852,7 +1242,7 @@ static int rtl_download_firmware(struct hci_dev *hde=
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
> @@ -863,6 +1253,9 @@ static int rtl_download_firmware(struct hci_dev *hde=
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
> @@ -880,6 +1273,226 @@ static int rtl_download_firmware(struct hci_dev *h=
dev,
>         return ret;
>  }
>
> +static int rtl_check_download_state(struct hci_dev *hdev,
> +                                   struct btrtl_device_info *btrtl_dev)
> +{
> +       struct sk_buff *skb;
> +       int ret =3D 0;
> +       u8 state;
> +
> +       skb =3D __hci_cmd_sync(hdev, 0xfdcf, 0, NULL, HCI_CMD_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               rtl_dev_err(hdev, "write tb error %lu", PTR_ERR(skb));
> +               return -EIO;
> +       }
> +
> +       /* Other driver might be downloading the combined firmware. */
> +       state =3D skb->data[0];

skb->len can be zero so accessing data[0] is not safe above, then
again there is the likes of skb_pull_data to ensure there is enough
data under the skb.

> +       kfree_skb(skb);
> +       if (state =3D=3D 0x03) {
> +               btrealtek_set_flag(hdev, REALTEK_DOWNLOADING);
> +               ret =3D btrealtek_wait_on_flag_timeout(hdev, REALTEK_DOWN=
LOADING,
> +                                                    TASK_INTERRUPTIBLE,
> +                                                    msecs_to_jiffies(500=
0));
> +               if (ret =3D=3D -EINTR) {
> +                       bt_dev_err(hdev, "Firmware loading interrupted");
> +                       return ret;
> +               }
> +
> +               if (ret) {
> +                       bt_dev_err(hdev, "Firmware loading timeout");
> +                       return -ETIMEDOUT;
> +               }
> +
> +               ret =3D -EALREADY;
> +       }
> +
> +       return 0;
> +}
> +
> +static int rtl_finalize_download(struct hci_dev *hdev,
> +                                struct btrtl_device_info *btrtl_dev)
> +{
> +       struct hci_rp_read_local_version *rp_ver;
> +       u8 params[2] =3D { 0x03, 0xb2 };
> +       struct sk_buff *skb;
> +       u16 opcode;
> +       u32 len;
> +       int ret;
> +
> +       opcode =3D 0xfc8e;
> +       len =3D 2;
> +       if (btrtl_dev->opcode =3D=3D RTL_PATCH_V3_1) {
> +               opcode =3D 0xfc20;
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
> +       rtl_dev_info(hdev, "Watchdog reset status %02x", skb->data[0]);

Ditto.

> +       kfree_skb(skb);
> +
> +       skb =3D btrtl_read_local_version(hdev);
> +       if (IS_ERR(skb)) {
> +               ret =3D PTR_ERR(skb);
> +               rtl_dev_err(hdev, "read local version failed (%d)", ret);
> +               return ret;
> +       }
> +
> +       rp_ver =3D (struct hci_rp_read_local_version *)skb->data;
> +       rtl_dev_info(hdev, "fw version 0x%04x%04x",
> +                    __le16_to_cpu(rp_ver->hci_rev),
> +                    __le16_to_cpu(rp_ver->lmp_subver));
> +       kfree_skb(skb);
> +
> +       return 0;
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
> +               skb =3D __hci_cmd_sync(hdev, 0xfc20, 1, &i, HCI_CMD_TIMEO=
UT);
> +               if (IS_ERR(skb)) {
> +                       ret =3D -EIO;
> +                       rtl_dev_err(hdev, "Failed to issue last cmd fc20,=
 %ld",
> +                                   PTR_ERR(skb));
> +                       goto done;
> +               }
> +               rp =3D (void *)skb->data;

Again unsafe access, use skb_pull_data.

> +               ret =3D rp->err;
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
> @@ -913,7 +1526,7 @@ static int btrtl_setup_rtl8723a(struct hci_dev *hdev=
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
> @@ -928,7 +1541,7 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev=
,
>         if (ret < 0)
>                 goto out;
>
> -       if (btrtl_dev->cfg_len > 0) {
> +       if (!is_v3_fw(btrtl_dev->fw_type) && btrtl_dev->cfg_len > 0) {
>                 tbuff =3D kvzalloc(ret + btrtl_dev->cfg_len, GFP_KERNEL);
>                 if (!tbuff) {
>                         ret =3D -ENOMEM;
> @@ -944,9 +1557,14 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hde=
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
> @@ -1042,6 +1660,7 @@ static int rtl_read_chip_type(struct hci_dev *hdev,=
 u8 *type)
>  void btrtl_free(struct btrtl_device_info *btrtl_dev)
>  {
>         struct rtl_subsection *entry, *tmp;
> +       struct rtl_section_patch_image *image, *next;
>
>         kvfree(btrtl_dev->fw_data);
>         kvfree(btrtl_dev->cfg_data);
> @@ -1051,6 +1670,13 @@ void btrtl_free(struct btrtl_device_info *btrtl_de=
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
> @@ -1058,7 +1684,7 @@ EXPORT_SYMBOL_GPL(btrtl_free);
>  struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>                                            const char *postfix)
>  {
> -       struct btrealtek_data *coredump_info =3D hci_get_priv(hdev);
> +       struct btrealtek_data *btrtl_data =3D hci_get_priv(hdev);
>         struct btrtl_device_info *btrtl_dev;
>         struct sk_buff *skb;
>         struct hci_rp_read_local_version *resp;
> @@ -1069,6 +1695,7 @@ struct btrtl_device_info *btrtl_initialize(struct h=
ci_dev *hdev,
>         u8 hci_ver, lmp_ver, chip_type =3D 0;
>         int ret;
>         u8 reg_val[2];
> +       u8 chip_id =3D 0;
>
>         btrtl_dev =3D kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
>         if (!btrtl_dev) {
> @@ -1077,8 +1704,15 @@ struct btrtl_device_info *btrtl_initialize(struct =
hci_dev *hdev,
>         }
>
>         INIT_LIST_HEAD(&btrtl_dev->patch_subsecs);
> +       INIT_LIST_HEAD(&btrtl_dev->patch_images);
>
>  check_version:
> +       ret =3D btrtl_read_chip_id(hdev, &chip_id);
> +       if (!ret && chip_id =3D=3D CHIP_ID_8922D) {
> +               btrtl_dev->project_id =3D chip_id;
> +               goto read_local_ver;
> +       }
> +
>         ret =3D btrtl_vendor_read_reg16(hdev, RTL_CHIP_SUBVER, reg_val);
>         if (ret < 0)
>                 goto err_free;
> @@ -1101,6 +1735,7 @@ struct btrtl_device_info *btrtl_initialize(struct h=
ci_dev *hdev,
>                 }
>         }
>
> +read_local_ver:
>         skb =3D btrtl_read_local_version(hdev);
>         if (IS_ERR(skb)) {
>                 ret =3D PTR_ERR(skb);
> @@ -1228,7 +1863,7 @@ struct btrtl_device_info *btrtl_initialize(struct h=
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
> @@ -1301,6 +1936,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct =
btrtl_device_info *btrtl_dev)
>         case CHIP_ID_8851B:
>         case CHIP_ID_8922A:
>         case CHIP_ID_8852BT:
> +       case CHIP_ID_8922D:
>                 set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirk=
s);
>
>                 /* RTL8852C needs to transmit mSBC data continuously with=
out
> @@ -1387,6 +2023,23 @@ int btrtl_shutdown_realtek(struct hci_dev *hdev)
>  }
>  EXPORT_SYMBOL_GPL(btrtl_shutdown_realtek);
>
> +int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       struct hci_event_hdr *hdr =3D (void *)skb->data;

Unsafe access, use skb_pull_data and check that it doesn't return NULL.

> +
> +       if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt =3D=3D 0xff &&
> +           hdr->plen > 0) {
> +               if (skb->data[2] =3D=3D 0x77 &&
> +                   btrealtek_test_and_clear_flag(hdev, REALTEK_DOWNLOADI=
NG)) {
> +                       btrealtek_wake_up_flag(hdev, REALTEK_DOWNLOADING)=
;
> +                       return 0;
> +               }
> +       }
> +
> +       return hci_recv_frame(hdev, skb);
> +}
> +EXPORT_SYMBOL_GPL(btrtl_recv_event);
> +
>  static unsigned int btrtl_convert_baudrate(u32 device_baudrate)
>  {
>         switch (device_baudrate) {
> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> index a2d9d34f9fb0..f6f03a5fefba 100644
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
> +       test_and_clear_bit((nr), btrealtek_get_flag(hdev))
> +
> +#define btrealtek_wait_on_flag_timeout(hdev, nr, m, to)                 =
       \
> +       wait_on_bit_timeout(btrealtek_get_flag(hdev), (nr), m, to)
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
> @@ -195,4 +292,9 @@ static inline void btrtl_set_driver_name(struct hci_d=
ev *hdev, const char *drive
>  {
>  }
>
> +static inline int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff =
*skb)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f8f256ff79a3..a87ea836d730 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2677,6 +2677,9 @@ static int btusb_recv_event_realtek(struct hci_dev =
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
>


--=20
Luiz Augusto von Dentz
