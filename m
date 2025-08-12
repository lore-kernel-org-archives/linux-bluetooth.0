Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D76307AEA
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008145; cv=none; b=tAVshO3FQfuhcxSDKt9woK72e3b/n2r4yj0xnauCDDdQFoF2mvT3M6HjzcgnF60pPCltbqHb87h7XAmqypjypGvr8OHaDBv+g0ze+JVYNIZ0lDrI+Xq29HgoGS0AcBu2XzqeNXvpdAJeMIhWVSQ+/SfN/IFZcnEGZ6fDxZGEYNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008145; c=relaxed/simple;
	bh=qW78FGvSom1QF61HtV+Payz4yIz4C3uuqHjixcgYq48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgFxc1yI9YsZY/mGz8xkklafLvAd420UmqgIZQnHeeDHxPkzRl8gYG8HIufqCnonBsFhO9jjmjz+OuwR1Yz7ek7E5ZAMIW4CVQjVKCzJCenDaghhbrD1RF3PVVZkauf/fDO9VPhYCwC0SxC7osK7QUsH3xqpxyMgychn+B4CCMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axdCdc/q; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axdCdc/q"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3323b99094fso47428611fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755008141; x=1755612941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8B2ST0nZihWFspztNfvbcjv4EFDajesELVCHVHKT/Lw=;
        b=axdCdc/qjfz1MwzcqpJZg2d16SfCtm/lXh/CS7sT1niXXDSn52j5gITRb9jEsFpOh7
         YzjXgJSx6XydzKZ6iS95BfepZHPRLctteqjerk+VWlfYwUUeaHIam16dEjdxBlMkKKwy
         e+/ymewrW0uTs4X5mENZMNxEMFfq45Yg28NPJAkP4T+Dy7etLIUn2FtFdRh5+eCFoInw
         NDpxcnJtHfd22osPCdQJFjnuhcAXN02iHnhjEhU7r+6DAVoM4r2fR7zYdmdr/QrTubxP
         xby5S2dHk6AFlHT3hbMmdQhELvDgae7dqbeoAX/RBiSHvKHQyOZ+NiwyzPjXVcnJ2Gpu
         yS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755008141; x=1755612941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8B2ST0nZihWFspztNfvbcjv4EFDajesELVCHVHKT/Lw=;
        b=EX94eiuSFZn02mNs01lQSehgAiobzZWrVnMJV/LmuOwPH5fRhjhMYSHMLoajQ/vwYW
         3x3HMDlaOcHWud37O3KMowMcCqkFawuf9ZKLbdqzGfTNHTizi1J3DFmlVtf1V9cfGnOu
         bYbGL4MtnoUEwn/hSmrpOnGo/h9UyN6EqQ3jwjpG3yh0pffx0cNTNWRnK6l5DLKfmsJz
         +UYbiZuK/SnKySWUacxOUqQ4UYsPfV9fRMfIQILFpte1uAnQJh8PDbqBT+Qcs/20y0QB
         PJSlExRjMTU69awB7NpFFJOCV9hRCTlyZID2xoWNIRHERNalEyn3ovQhx97n9F5fbpWt
         c/jg==
X-Gm-Message-State: AOJu0YwjhpX7+ujgEVTXtQV5CWmVINQgK+XGPofpfx8tRWy8kTBPWHuh
	w9IfCnOFnskF1HH1LWGk7w3J0AgcJ8fUDOCUcHVaeojvokWchBYhr0eO6QiXqaEM6elcXHTkb9B
	+xX5yPfjH9PCkY0SPD78scdhYJKSD+dDEE5QQ3kI=
X-Gm-Gg: ASbGnctZAVT0xZFVP12BSSX7u4wXWXhjRLzoP43CKyrORfRQzzA71y+QFhB5CTH7TNA
	xlTDBPUA6qBJMIAaMOfR0uAyKF6tceFI3cyIrGGgIBtRkYH5siQWAudtT7TMJNtJ7yUR4WhI9FF
	i7ervruI454Vl6ciNyiq/jmeZIeKmXr3oX4KIkp2rb96h+YVyacClGrfuF4pT+nZuS+woXVVCFq
	4iWSZYrM/pGgZB6
X-Google-Smtp-Source: AGHT+IFDz5P9BzKIKd78ZYQHN8Hp+GeZINyTFSODinOaNmlmdMEl9cTiRXt/RhZJPUKTofyMhCAGVi1PiNJt1NBpcRs=
X-Received: by 2002:a05:651c:198d:b0:333:accc:ef87 with SMTP id
 38308e7fff4ca-333acccf975mr40031701fa.18.1755008140559; Tue, 12 Aug 2025
 07:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812114704.1596969-1-kiran.k@intel.com>
In-Reply-To: <20250812114704.1596969-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 12 Aug 2025 10:15:28 -0400
X-Gm-Features: Ac12FXxKfRqJ-hUUASOJygBaCkLJxvmwl_bIfJ-RI_N5KB9Mn8E1s47Cf5OXRQ0
Message-ID: <CABBYNZ+nc=oh4UiARp4qNsZfQNkYwaujOKdT_HSYO+K5R5zzbA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Bluetooth: btintel_pcie: Refactor Device Coredump
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chandrashekar.devegowda@intel.com, chethan.tumkur.narayan@intel.com, 
	Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Tue, Aug 12, 2025 at 7:30=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> Device coredumps do not include HCI traces, so the dependency on
> hdev_devcd*() for generating device coredumps has been removed. In the
> current implementation, firmware traces are embedded in skb and sent to
> the host for coredump processing. This refactor updates the driver to
> use devcore_dumpv() to generate coredumps directly, streamlining the
> process.
>
> Test:
> 1. cd /sys/bus/pci/devices/0000:00:14.7/
> 2. echo 1 > coredump
> 3. check /sys/class/devcoredump/ to device coredump folder
>
> Fixes: 07e6bddb54b4 ("Bluetooth: btintel_pcie: Add support for device cor=
edump")
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v3:
>   - Make a seperate patch to include vendor and driver name in device cor=
edump
>
> changes in v2:
>   - Fix compiler warning reported by android toolchain
>
>  drivers/bluetooth/btintel_pcie.c | 211 ++++++++++---------------------
>  1 file changed, 65 insertions(+), 146 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 22a2953adbd6..a78e24aa5e38 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -15,6 +15,7 @@
>  #include <linux/interrupt.h>
>
>  #include <linux/unaligned.h>
> +#include <linux/devcoredump.h>
>
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> @@ -559,25 +560,6 @@ static void btintel_pcie_mac_init(struct btintel_pci=
e_data *data)
>         btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
>  }
>
> -static int btintel_pcie_add_dmp_data(struct hci_dev *hdev, const void *d=
ata, int size)
> -{
> -       struct sk_buff *skb;
> -       int err;
> -
> -       skb =3D alloc_skb(size, GFP_ATOMIC);
> -       if (!skb)
> -               return -ENOMEM;
> -
> -       skb_put_data(skb, data, size);
> -       err =3D hci_devcd_append(hdev, skb);
> -       if (err) {
> -               bt_dev_err(hdev, "Failed to append data in the coredump")=
;
> -               return err;
> -       }
> -
> -       return 0;
> -}
> -
>  static int btintel_pcie_get_mac_access(struct btintel_pcie_data *data)
>  {
>         u32 reg;
> @@ -622,30 +604,33 @@ static void btintel_pcie_release_mac_access(struct =
btintel_pcie_data *data)
>         btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
>  }
>
> -static void btintel_pcie_copy_tlv(struct sk_buff *skb, enum btintel_pcie=
_tlv_type type,
> -                                 void *data, int size)
> +static void *btintel_pcie_copy_tlv(void *dest, enum btintel_pcie_tlv_typ=
e type,
> +                                  void *data, size_t size)
>  {
>         struct intel_tlv *tlv;
>
> -       tlv =3D skb_put(skb, sizeof(*tlv) + size);
> +       tlv =3D dest;
>         tlv->type =3D type;
>         tlv->len =3D size;
>         memcpy(tlv->val, data, tlv->len);
> +       return dest + sizeof(*tlv) + size;
>  }
>
>  static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data=
)
>  {
> -       u32 offset, prev_size, wr_ptr_status, dump_size, i;
> +       u32 offset, prev_size, wr_ptr_status, dump_size, data_len;
>         struct btintel_pcie_dbgc *dbgc =3D &data->dbgc;
> -       u8 buf_idx, dump_time_len, fw_build;
>         struct hci_dev *hdev =3D data->hdev;
> +       u8 *pdata, *p, buf_idx;
>         struct intel_tlv *tlv;
>         struct timespec64 now;
> -       struct sk_buff *skb;
>         struct tm tm_now;
> -       char buf[256];
> -       u16 hdr_len;
> -       int ret;
> +       char fw_build[128];
> +       char ts[128];
> +
> +       if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
> +               return -EOPNOTSUPP;
> +
>
>         wr_ptr_status =3D btintel_pcie_rd_dev_mem(data, BTINTEL_PCIE_DBGC=
_CUR_DBGBUFF_STATUS);
>         offset =3D wr_ptr_status & BTINTEL_PCIE_DBG_OFFSET_BIT_MASK;
> @@ -664,92 +649,79 @@ static int btintel_pcie_read_dram_buffers(struct bt=
intel_pcie_data *data)
>
>         ktime_get_real_ts64(&now);
>         time64_to_tm(now.tv_sec, 0, &tm_now);
> -       dump_time_len =3D snprintf(buf, sizeof(buf), "Dump Time: %02d-%02=
d-%04ld %02d:%02d:%02d",
> +       snprintf(ts, sizeof(ts), "Dump Time: %02d-%02d-%04ld %02d:%02d:%0=
2d",
>                                  tm_now.tm_mday, tm_now.tm_mon + 1, tm_no=
w.tm_year + 1900,
>                                  tm_now.tm_hour, tm_now.tm_min, tm_now.tm=
_sec);
>
> -       fw_build =3D snprintf(buf + dump_time_len, sizeof(buf) - dump_tim=
e_len,
> +       snprintf(fw_build, sizeof(fw_build),
>                             "Firmware Timestamp: Year %u WW %02u buildtyp=
e %u build %u",
>                             2000 + (data->dmp_hdr.fw_timestamp >> 8),
>                             data->dmp_hdr.fw_timestamp & 0xff, data->dmp_=
hdr.fw_build_type,
>                             data->dmp_hdr.fw_build_num);
>
> -       hdr_len =3D sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_bt) +
> -                 sizeof(*tlv) + sizeof(data->dmp_hdr.write_ptr) +
> -                 sizeof(*tlv) + sizeof(data->dmp_hdr.wrap_ctr) +
> -                 sizeof(*tlv) + sizeof(data->dmp_hdr.trigger_reason) +
> -                 sizeof(*tlv) + sizeof(data->dmp_hdr.fw_git_sha1) +
> -                 sizeof(*tlv) + sizeof(data->dmp_hdr.cnvr_top) +
> -                 sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_top) +
> -                 sizeof(*tlv) + dump_time_len +
> -                 sizeof(*tlv) + fw_build;
> +       data_len =3D sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_bt) +
> +               sizeof(*tlv) + sizeof(data->dmp_hdr.write_ptr) +
> +               sizeof(*tlv) + sizeof(data->dmp_hdr.wrap_ctr) +
> +               sizeof(*tlv) + sizeof(data->dmp_hdr.trigger_reason) +
> +               sizeof(*tlv) + sizeof(data->dmp_hdr.fw_git_sha1) +
> +               sizeof(*tlv) + sizeof(data->dmp_hdr.cnvr_top) +
> +               sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_top) +
> +               sizeof(*tlv) + strlen(ts) +
> +               sizeof(*tlv) + strlen(fw_build);
>
> -       dump_size =3D hdr_len + sizeof(hdr_len);
> +       /*
> +        * sizeof(u32) - signature
> +        * sizeof(data_len) - to store tlv data size
> +        * data_len - TLV data
> +        */
> +       dump_size =3D sizeof(u32) + sizeof(data_len) + data_len;
>
> -       skb =3D alloc_skb(dump_size, GFP_KERNEL);
> -       if (!skb)
> -               return -ENOMEM;
>
>         /* Add debug buffers data length to dump size */
>         dump_size +=3D BTINTEL_PCIE_DBGC_BUFFER_SIZE * dbgc->count;
>
> -       ret =3D hci_devcd_init(hdev, dump_size);
> -       if (ret) {
> -               bt_dev_err(hdev, "Failed to init devcoredump, err %d", re=
t);
> -               kfree_skb(skb);
> -               return ret;
> -       }
> +       pdata =3D vmalloc(dump_size);
> +       if (!pdata)
> +               return -ENOMEM;
> +       p =3D pdata;
>
> -       skb_put_data(skb, &hdr_len, sizeof(hdr_len));
> +       *(u32 *)p =3D BTINTEL_PCIE_MAGIC_NUM;
> +       p +=3D sizeof(u32);
>
> -       btintel_pcie_copy_tlv(skb, BTINTEL_CNVI_BT, &data->dmp_hdr.cnvi_b=
t,
> -                             sizeof(data->dmp_hdr.cnvi_bt));
> +       *(u32 *)p =3D data_len;
> +       p +=3D sizeof(u32);
>
> -       btintel_pcie_copy_tlv(skb, BTINTEL_WRITE_PTR, &data->dmp_hdr.writ=
e_ptr,
> -                             sizeof(data->dmp_hdr.write_ptr));
> +       p =3D btintel_pcie_copy_tlv(p, BTINTEL_DUMP_TIME, ts, strlen(ts))=
;
> +       p =3D btintel_pcie_copy_tlv(p, BTINTEL_FW_BUILD, fw_build,
> +                                 strlen(fw_build));
> +       p =3D btintel_pcie_copy_tlv(p, BTINTEL_CNVI_BT, &data->dmp_hdr.cn=
vi_bt,
> +                                 sizeof(data->dmp_hdr.cnvi_bt));
> +       p =3D btintel_pcie_copy_tlv(p, BTINTEL_WRITE_PTR, &data->dmp_hdr.=
write_ptr,
> +                                 sizeof(data->dmp_hdr.write_ptr));
> +       p =3D btintel_pcie_copy_tlv(p, BTINTEL_WRAP_CTR, &data->dmp_hdr.w=
rap_ctr,
> +                                 sizeof(data->dmp_hdr.wrap_ctr));
>
>         data->dmp_hdr.wrap_ctr =3D btintel_pcie_rd_dev_mem(data,
>                                                          BTINTEL_PCIE_DBG=
C_DBGBUFF_WRAP_ARND);
>
> -       btintel_pcie_copy_tlv(skb, BTINTEL_WRAP_CTR, &data->dmp_hdr.wrap_=
ctr,
> -                             sizeof(data->dmp_hdr.wrap_ctr));
> -
> -       btintel_pcie_copy_tlv(skb, BTINTEL_TRIGGER_REASON, &data->dmp_hdr=
.trigger_reason,
> -                             sizeof(data->dmp_hdr.trigger_reason));
> -
> -       btintel_pcie_copy_tlv(skb, BTINTEL_FW_SHA, &data->dmp_hdr.fw_git_=
sha1,
> -                             sizeof(data->dmp_hdr.fw_git_sha1));
> -
> -       btintel_pcie_copy_tlv(skb, BTINTEL_CNVR_TOP, &data->dmp_hdr.cnvr_=
top,
> -                             sizeof(data->dmp_hdr.cnvr_top));
> -
> -       btintel_pcie_copy_tlv(skb, BTINTEL_CNVI_TOP, &data->dmp_hdr.cnvi_=
top,
> -                             sizeof(data->dmp_hdr.cnvi_top));
> -
> -       btintel_pcie_copy_tlv(skb, BTINTEL_DUMP_TIME, buf, dump_time_len)=
;
> -
> -       btintel_pcie_copy_tlv(skb, BTINTEL_FW_BUILD, buf + dump_time_len,=
 fw_build);
> -
> -       ret =3D hci_devcd_append(hdev, skb);
> -       if (ret)
> -               goto exit_err;
> -
> -       for (i =3D 0; i < dbgc->count; i++) {
> -               ret =3D btintel_pcie_add_dmp_data(hdev, dbgc->bufs[i].dat=
a,
> -                                               BTINTEL_PCIE_DBGC_BUFFER_=
SIZE);
> -               if (ret)
> -                       break;
> -       }
> -
> -exit_err:
> -       hci_devcd_complete(hdev);
> -       return ret;
> +       p =3D btintel_pcie_copy_tlv(p, BTINTEL_TRIGGER_REASON, &data->dmp=
_hdr.trigger_reason,
> +                                 sizeof(data->dmp_hdr.trigger_reason));
> +       p =3D btintel_pcie_copy_tlv(p, BTINTEL_FW_SHA, &data->dmp_hdr.fw_=
git_sha1,
> +                                 sizeof(data->dmp_hdr.fw_git_sha1));
> +       p =3D btintel_pcie_copy_tlv(p, BTINTEL_CNVR_TOP, &data->dmp_hdr.c=
nvr_top,
> +                                 sizeof(data->dmp_hdr.cnvr_top));
> +       p =3D btintel_pcie_copy_tlv(p, BTINTEL_CNVI_TOP, &data->dmp_hdr.c=
nvi_top,
> +                                 sizeof(data->dmp_hdr.cnvi_top));
> +
> +       memcpy(p, dbgc->bufs[0].data, dbgc->count * BTINTEL_PCIE_DBGC_BUF=
FER_SIZE);
> +       dev_coredumpv(&hdev->dev, pdata, dump_size, GFP_KERNEL);

We are missing the following logic as well:

    /* Send a copy to monitor as a diagnostic packet */
    skb =3D bt_skb_alloc(size, GFP_ATOMIC);
    if (skb) {
        skb_put_data(skb, hdev->dump.head, size);
        hci_recv_diag(hdev, skb);
    }

So it gets included in the btmon traces for example.

> +       return 0;
>  }
>
>  static void btintel_pcie_dump_traces(struct hci_dev *hdev)
>  {
>         struct btintel_pcie_data *data =3D hci_get_drvdata(hdev);
> -       int ret =3D 0;
> +       int ret;
>
>         ret =3D btintel_pcie_get_mac_access(data);
>         if (ret) {
> @@ -765,51 +737,6 @@ static void btintel_pcie_dump_traces(struct hci_dev =
*hdev)
>                 bt_dev_err(hdev, "Failed to dump traces: (%d)", ret);
>  }
>
> -static void btintel_pcie_dump_hdr(struct hci_dev *hdev, struct sk_buff *=
skb)
> -{
> -       struct btintel_pcie_data *data =3D hci_get_drvdata(hdev);
> -       u16 len =3D skb->len;
> -       u16 *hdrlen_ptr;
> -       char buf[80];
> -
> -       hdrlen_ptr =3D skb_put_zero(skb, sizeof(len));
> -
> -       snprintf(buf, sizeof(buf), "Controller Name: 0x%X\n",
> -                INTEL_HW_VARIANT(data->dmp_hdr.cnvi_bt));
> -       skb_put_data(skb, buf, strlen(buf));
> -
> -       snprintf(buf, sizeof(buf), "Firmware Build Number: %u\n",
> -                data->dmp_hdr.fw_build_num);
> -       skb_put_data(skb, buf, strlen(buf));
> -
> -       snprintf(buf, sizeof(buf), "Driver: %s\n", data->dmp_hdr.driver_n=
ame);
> -       skb_put_data(skb, buf, strlen(buf));
> -
> -       snprintf(buf, sizeof(buf), "Vendor: Intel\n");
> -       skb_put_data(skb, buf, strlen(buf));
> -
> -       *hdrlen_ptr =3D skb->len - len;
> -}
> -
> -static void btintel_pcie_dump_notify(struct hci_dev *hdev, int state)
> -{
> -       struct btintel_pcie_data *data =3D hci_get_drvdata(hdev);
> -
> -       switch (state) {
> -       case HCI_DEVCOREDUMP_IDLE:
> -               data->dmp_hdr.state =3D HCI_DEVCOREDUMP_IDLE;
> -               break;
> -       case HCI_DEVCOREDUMP_ACTIVE:
> -               data->dmp_hdr.state =3D HCI_DEVCOREDUMP_ACTIVE;
> -               break;
> -       case HCI_DEVCOREDUMP_TIMEOUT:
> -       case HCI_DEVCOREDUMP_ABORT:
> -       case HCI_DEVCOREDUMP_DONE:
> -               data->dmp_hdr.state =3D HCI_DEVCOREDUMP_IDLE;
> -               break;
> -       }
> -}
> -
>  /* This function enables BT function by setting BTINTEL_PCIE_CSR_FUNC_CT=
RL_MAC_INIT bit in
>   * BTINTEL_PCIE_CSR_FUNC_CTRL_REG register and wait for MSI-X with
>   * BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0.
> @@ -1383,6 +1310,11 @@ static void btintel_pcie_rx_work(struct work_struc=
t *work)
>                                         struct btintel_pcie_data, rx_work=
);
>         struct sk_buff *skb;
>
> +       if (test_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags)) {
> +               btintel_pcie_dump_traces(data->hdev);
> +               clear_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags)=
;
> +       }
> +
>         if (test_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags)) {
>                 /* Unlike usb products, controller will not send hardware
>                  * exception event on exception. Instead controller write=
s the
> @@ -1395,11 +1327,6 @@ static void btintel_pcie_rx_work(struct work_struc=
t *work)
>                 clear_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags);
>         }
>
> -       if (test_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags)) {
> -               btintel_pcie_dump_traces(data->hdev);
> -               clear_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags)=
;
> -       }
> -
>         /* Process the sk_buf in queue and send to the HCI layer */
>         while ((skb =3D skb_dequeue(&data->rx_skb_q))) {
>                 btintel_pcie_recv_frame(data, skb);
> @@ -2190,13 +2117,6 @@ static int btintel_pcie_setup_internal(struct hci_=
dev *hdev)
>         if (ver_tlv.img_type =3D=3D 0x02 || ver_tlv.img_type =3D=3D 0x03)
>                 data->dmp_hdr.fw_git_sha1 =3D ver_tlv.git_sha1;
>
> -       err =3D hci_devcd_register(hdev, btintel_pcie_dump_traces, btinte=
l_pcie_dump_hdr,
> -                                btintel_pcie_dump_notify);
> -       if (err) {
> -               bt_dev_err(hdev, "Failed to register coredump (%d)", err)=
;
> -               goto exit_error;
> -       }
> -
>         btintel_print_fseq_info(hdev);
>  exit_error:
>         kfree_skb(skb);
> @@ -2325,7 +2245,6 @@ static void btintel_pcie_removal_work(struct work_s=
truct *wk)
>         btintel_pcie_synchronize_irqs(data);
>
>         flush_work(&data->rx_work);
> -       flush_work(&data->hdev->dump.dump_rx);
>
>         bt_dev_dbg(data->hdev, "Release bluetooth interface");
>         btintel_pcie_release_hdev(data);
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
