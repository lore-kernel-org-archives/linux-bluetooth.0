Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB40C306B3D
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133086; cv=pass; b=r334V40ZIP0FuRMwekCRIP8FrqXlKPqLmz2F5gQkxaJrbwOFVPt6ZhRz1EPRDrTebngaQpH3t9097opLNISX58W5Hqk8WkTL0Xgdr/MI6N5uignwG0qRw+ZmURxOXU9vWRjHa3s0q8i7U0la8UMePeIBvBaUuB4nMJMDhWdG0p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133086; c=relaxed/simple;
	bh=9FyWOBUmLaJw5T6+xyTZIIwa9qAC8Non/fBLM3ZjfYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLtppLinwVsuXH4J4EdDOWWyBRDX4x298/73ySx7BziV94BZBrvfQfttEfdDTNIaSwbZJy+uZwQstVB24FstjlZYtxvIsPZsfa4FpKAmjVv32H310OzKH/sLCXBqCsKJ0RJzAziAdg9qhUtJuR4vM+KC4/FvIV7Tqqy1n14YpAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQ/P6VBE; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ/P6VBE"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81e83f1f15aso33846297b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 09:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784133081; cv=none;
        d=google.com; s=arc-20260327;
        b=A1w3IbGmb6oBTtFFDfbfyy76a3ln6MbPkaaZPq9Z7KTuZSEsr9Af6+kKVNckxLj1yp
         yBwhDjD4HJ4EJC+4uQHfQamL3JlfDWDZYUkUhqv3crSM70xCi5El1DaCGv5JS3qWd0sQ
         6BfcREBXwFmUohqPAO6zZssajMhqo6ZB2HmsQPm9093lUiIz46/qEDkxWFS64WOIuxzI
         ZEDJMd/llFkKnLTDcrQuhgtigG1E4Nj/PDmfSkiGdfD3ZJ1A3YHb73Ls8AxPEMy3meAM
         Oy24n+6I5y4Dq2k5FHH8p53wXkKmw/K+Y0f3qjzqwjED+Shd/8P+k7mLQE2vREgAAvm6
         BNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iipXTeBT8ciQjd0hDUA0me90CQkP7GRnoYQRQTt8Ssc=;
        fh=AoCiKGPH1WOPbp1vjbnEchVMP+LeAEXipwGvtK4RsFg=;
        b=jLTVfV2B23ujxfKUKKtRyIewYkwOq6ZZ7N/6oUQwATo6TgvJpun1UOdT5Lro4p+gkP
         nmgouwzGsrQqyiJAx6IzASvXSHAIqFTQ+XudVPQ+s7hVfil9ArmoAXDxZDdcr0r3pql4
         m8WW9tqtNH36PW2Fz70eVopCODgIMv6Fz8/m3r+q+L+uCmW/M2f/YYPptXVLNV2MX+g+
         vspkaJgcC7J3lPqR2e9A5E1GhFnEUiVJAd5o9ELZXz8blkEyrGQ+XEzf6rnxw0zHKlOx
         gGXN8aoiC35SCDkEAc/Qo5x0mpOFtRZKb1SEFwgg73rLloAhHpVhuWTMqU72mIj1d74H
         qpPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784133081; x=1784737881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iipXTeBT8ciQjd0hDUA0me90CQkP7GRnoYQRQTt8Ssc=;
        b=mQ/P6VBEvraTqPC9vbERKNIIv0ozSR406N+M+ePrcvYbWlvwIMJvTsxPeLvqas+2hp
         6mzfimfOYGBbi1zWbl1akW21cPMgtEECOz9Y8H7B4Aqddj3yOnOROfF5Piew5eFaQgmv
         w+C50an7RLtjhLTwl8Iqh4FMSAa1zmsKf7XIisbyrqL7mOYfgW2KCnaMjo7+BjOYjKgH
         mxONKr7YjnVUmRb6dAzyvkN45KsX9ki50yiyTIFvOtMd+j/CsCSCemBFduO4gCzd21ZU
         +jUUxPB4vcGbzw/gTzbVHDRCFBiYDIH0OkFTGwycYWQDZWEL02CM504Xd99jViftuJP0
         UWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784133081; x=1784737881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iipXTeBT8ciQjd0hDUA0me90CQkP7GRnoYQRQTt8Ssc=;
        b=A3wBVFTnVuMni+ZZ6dpfNv7fQ/SfakotSa7/rYP6Z+8gOaJT61TQCfieOkSFhUbWKg
         9H682uQdcDjKlESrNfjYwmviafnJLkJ6SPvfaa1VcBSAIh1qkZZtbLieHzBTSngM5kif
         2JGyVh+uQzw5uKrFodQJcYJ8lgsljFv9NHjeC9v36owGRhg2jCvHpFn7+3zZxowAYDbV
         YiYKJPnHp3vDsjED5K7dweV+vjuIPNhut2XJ70U+FpH9ppE6tKrZDlF0WZYSYYq7SgCs
         Ithv1uocTsoAEKr2TgngzQgpgCuhPJnLkr2b7/j569YkSE5bkJu0goVIFGT6c5GuGCT7
         fJ9Q==
X-Gm-Message-State: AOJu0Yz/HsSaJLvspGhz6JF/VmCWS+F++sBkoU7cZHch9iaxCFrdo+cB
	eQqVnTPQxpWn0IAsV06GYYVfAuyf2B7mBTOHX3hlNKDS8a3lnSGHnxqi86R99ndNwG/XM6G8oP+
	ymN+iC+q4ZrH4oeo/ueLPk1/Qj4tRhWI=
X-Gm-Gg: AfdE7cl4UmSzwqpczd/4npOg+dUwRGUd/bkd8ujyo75ZYcByQW4C6xEYib8t9HF0wB/
	3yM+RmsfiL9+TXnwfCJ0LwtmuYVq2R6FvYdYkgMwrIEgKjOIdhuNB04QWzrX+c6bnTYue57Kv5X
	uIEW71vULhHZ1NPChDtLU+igFOxN8Ij+VQN93kMPypUA+UaCps76uUuzM6YIJk+ovAamMetxuIy
	d6i572zslpdWyxxp864Px6xb8+22kkbnEuH49R95TkN7jQT1XNMBThwExNa0rCV91TRH5E+d8hD
	g0t6ePzV1sNo/gtvCFGBR6tr+my0+0+zL2rw6Bw4VUG6UUE9QzLW2HuQEUg=
X-Received: by 2002:a05:690c:e3cd:b0:81e:a373:47ad with SMTP id
 00721157ae682-81ede3c3c8bmr1214947b3.2.1784133076823; Wed, 15 Jul 2026
 09:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715155401.605564-1-chandrashekar.devegowda@intel.com>
In-Reply-To: <20260715155401.605564-1-chandrashekar.devegowda@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 15 Jul 2026 12:31:04 -0400
X-Gm-Features: AUfX_mxjES8b18-pmgY4YdB4DF0JUm6IjBbBd4QJeYWuUsNnJOcTgB3JtkVTr4M
Message-ID: <CABBYNZK552wDe6JwrAa-R5f0kenzjnKLv9DMsJBROjs1XFXE1w@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: support unified decoder
 coredump format
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, bhelgaas@google.com, 
	ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com, 
	Kiran K <kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chandru,

On Wed, Jul 15, 2026 at 12:03=E2=80=AFPM Chandrashekar Devegowda
<chandrashekar.devegowda@intel.com> wrote:
>
> Refactor the coredump collection to use a unified decoder format
> that consolidates exception dump, DCCM, SDS, SDS IOSF, ECL, and
> SMEM memory regions into a structured TLV-based dump. This enables
> a single decoder tool to parse all dump types across different
> Intel BT PCIe controller variants (BlazarI/W, ScP, ScP2/F, Draco).
>
> Key changes:
> - Parse dump memory region addresses from FW-provided TLV data
> - Add per-variant DBGC register offsets for wrap counter and
>   write pointer status
> - Collect and emit coredump sections with proper headers for
>   the unified decoder tool

Could you split into 3 independent changes then, looks like its going
to be a substantial change.

> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com=
>
> ---
>  drivers/bluetooth/btintel.c      |   12 +
>  drivers/bluetooth/btintel.h      |    1 +
>  drivers/bluetooth/btintel_pcie.c | 1193 +++++++++++++++++++++++++-----
>  drivers/bluetooth/btintel_pcie.h |  267 ++++++-
>  4 files changed, 1299 insertions(+), 174 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 5e9cac090bd8..b0b8c38ae9e4 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -65,6 +65,7 @@ static struct {
>         const char *driver_name;
>         u8         hw_variant;
>         u32        fw_build_num;
> +       u32        fw_git_sha1;

I just name it fw_sha, if that comes from git or not doesn't matter to
the driver.

>  } coredump_info;
>
>  const guid_t btintel_guid_dsm =3D
> @@ -559,6 +560,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
>
>         coredump_info.hw_variant =3D INTEL_HW_VARIANT(version->cnvi_bt);
>         coredump_info.fw_build_num =3D version->build_num;
> +       coredump_info.fw_git_sha1 =3D version->git_sha1;
>
>         bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u", var=
iant,
>                     2000 + (version->timestamp >> 8), version->timestamp =
& 0xff,
> @@ -2448,6 +2450,13 @@ static int btintel_prepare_fw_download_tlv(struct =
hci_dev *hdev,
>                 btintel_reset_to_bootloader(hdev);
>
>  done:
> +       {
> +               struct btintel_data *intel_data =3D hci_get_priv(hdev);
> +
> +               intel_data->cnvi_bt =3D ver->cnvi_bt;
> +               bt_dev_dbg(hdev, "INTEL HW VARIANT is: 0x%2x",
> +                          INTEL_HW_VARIANT(intel_data->cnvi_bt));
> +       }
>         release_firmware(fw);
>         return err;
>  }
> @@ -3299,6 +3308,9 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hd=
ev,
>
>         btintel_version_info_tlv(hdev, &new_ver);
>
> +       /* Update ver with the operational firmware version */
> +       *ver =3D new_ver;
> +
>  finish:
>         /* Set the event mask for Intel specific vendor events. This enab=
les
>          * a few extra events that are useful during general operation. I=
t
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 37d93abdd5a3..02a37a3d459d 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -229,6 +229,7 @@ enum {
>  struct btintel_data {
>         DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
>         int (*acpi_reset_method)(struct hci_dev *hdev);
> +       u32 cnvi_bt;
>  };
>
>  #define btintel_set_flag(hdev, nr)                                     \
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 013568197a39..3a714854ff50 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -19,6 +19,7 @@
>
>  #include <linux/unaligned.h>
>  #include <linux/devcoredump.h>
> +#include <linux/scatterlist.h>
>
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> @@ -73,17 +74,6 @@ struct btintel_pcie_dev_recovery {
>  #define BTINTEL_PCIE_HCI_EVT_PKT       0x00000004
>  #define BTINTEL_PCIE_HCI_ISO_PKT       0x00000005
>
> -#define BTINTEL_PCIE_MAGIC_NUM    0xA5A5A5A5
> -
> -#define BTINTEL_PCIE_BLZR_HWEXP_SIZE           1024
> -#define BTINTEL_PCIE_BLZR_HWEXP_DMP_ADDR       0xB00A7C00
> -
> -#define BTINTEL_PCIE_SCP_HWEXP_SIZE            4096
> -#define BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR                0xB030F800
> -
> -#define BTINTEL_PCIE_SCP2_HWEXP_SIZE           4096
> -#define BTINTEL_PCIE_SCP2_HWEXP_DMP_ADDR       0xB031D000
> -
>  #define BTINTEL_PCIE_MAGIC_NUM 0xA5A5A5A5
>
>  #define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER       0x17A2
> @@ -145,6 +135,20 @@ struct btintel_pcie_dbgc_ctxt {
>         struct btintel_pcie_dbgc_ctxt_buf bufs[BTINTEL_PCIE_DBGC_BUFFER_C=
OUNT];
>  };
>
> +struct btintel_pcie_mdbgc_ctxt {
> +       u32     magic_num;
> +       u32     ver;
> +       u32     buf1_index;
> +       u32     buf1_count;
> +       struct btintel_pcie_dbgc_ctxt_buf buf1[BTINTEL_PCIE_DBGC_BUFFER_C=
OUNT];
> +       u32     buf2_index;
> +       u32     buf2_count;
> +       struct btintel_pcie_dbgc_ctxt_buf buf2[BTINTEL_PCIE_DBGC_BUFFER_C=
OUNT];
> +       u32     buf3_index;
> +       u32     buf3_count;
> +       struct btintel_pcie_dbgc_ctxt_buf buf3[BTINTEL_PCIE_DBGC_BUFFER_C=
OUNT];

Why don't we store index and count inside btintel_pcie_dbgc_ctxt_buf?
I don't really follow why we need 3 fixed arrays of buffers?

> +};
> +
>  struct btintel_pcie_trigger_evt {
>         u8 type;
>         u8 len;
> @@ -186,6 +190,127 @@ static inline char *btintel_pcie_alivectxt_state2st=
r(u32 alive_intr_ctxt)
>         }
>  }
>
> +/* Helper function to allocate and setup a debug buffer group
> + * @data: driver data structure
> + * @buf: pointer to data_buf array pointer
> + * @p_addr: pointer to physical DMA address
> + * @v_addr: pointer to virtual address
> + * @frag_buf: pointer to fragment buffer array
> + * @buf_index: buffer index (for error messages)
> + * @buf_count: number of buffers to allocate
> + */
> +static int btintel_pcie_alloc_dbgc_buf(struct btintel_pcie_data *data,
> +                                      struct data_buf **buf,
> +                                      dma_addr_t *p_addr,
> +                                      void **v_addr,
> +                                      struct btintel_pcie_dbgc_ctxt_buf =
*frag_buf,
> +                                      u32 buf_index,
> +                                      u32 buf_count)
> +{
> +       struct data_buf *b;
> +       int i;
> +
> +       *buf =3D devm_kcalloc(&data->pdev->dev, buf_count,
> +                           sizeof(**buf), GFP_KERNEL);
> +       if (!*buf) {
> +               BT_ERR("Failed to allocate dbgc buf: %u", buf_index + 1);
> +               return -ENOMEM;
> +       }
> +
> +       *v_addr =3D dmam_alloc_coherent(&data->pdev->dev,
> +                                     buf_count *
> +                                       BTINTEL_PCIE_DBGC_BUFFER_SIZE,
> +                                       p_addr,
> +                                       GFP_KERNEL | __GFP_NOWARN);
> +       if (!*v_addr) {
> +               BT_ERR("Failed to allocate dbgc buf: %u DMA", buf_index +=
 1);
> +               return -ENOMEM;
> +       }
> +
> +       for (i =3D 0; i < buf_count; i++) {
> +               b =3D &(*buf)[i];
> +               b->data_p_addr =3D *p_addr + i * BTINTEL_PCIE_DBGC_BUFFER=
_SIZE;
> +               b->data =3D *v_addr + i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
> +               frag_buf[i].buf_addr_lsb =3D lower_32_bits(b->data_p_addr=
);
> +               frag_buf[i].buf_addr_msb =3D upper_32_bits(b->data_p_addr=
);
> +               frag_buf[i].buf_size =3D BTINTEL_PCIE_DBGC_BUFFER_SIZE;
> +       }
> +
> +       return 0;
> +}
> +
> +/* This function initializes the memory for MDBGC buffers and formats th=
e
> + * DBGC fragment which consists header info and DBGC buffer's LSB, MSB a=
nd
> + * size as the payload
> + */
> +static int btintel_pcie_setup_mdbgc(struct btintel_pcie_data *data)
> +{
> +       struct btintel_pcie_mdbgc_ctxt db_frag;
> +       int err;
> +
> +       data->mdbgc.count =3D BTINTEL_PCIE_DBGC_BUFFER_COUNT;
> +
> +       /* Allocate fragment context structure */
> +       data->mdbgc.frag_v_addr =3D dmam_alloc_coherent(&data->pdev->dev,
> +                                                     sizeof(struct btint=
el_pcie_mdbgc_ctxt),
> +                                       &data->mdbgc.frag_p_addr,
> +                                       GFP_KERNEL | __GFP_NOWARN);
> +       if (!data->mdbgc.frag_v_addr) {
> +               BT_ERR("Failed to allocate mdbgc context");
> +               return -ENOMEM;
> +       }
> +
> +       data->mdbgc.frag_size =3D sizeof(struct btintel_pcie_mdbgc_ctxt);
> +
> +       /* Initialize fragment header */
> +       memset(&db_frag, 0, sizeof(db_frag));
> +       db_frag.magic_num =3D BTINTEL_PCIE_MAGIC_NUM;
> +       db_frag.ver =3D BTINTEL_PCIE_MDBGC_FRAG_VERSION;
> +
> +       /* Allocate DBGC buffer 1 */
> +       db_frag.buf1_index =3D BTINTEL_PCIE_MDBGC_ALLOCATIONID_1;
> +       db_frag.buf1_count =3D data->mdbgc.count;
> +       err =3D btintel_pcie_alloc_dbgc_buf(data,
> +                                         &data->mdbgc.buf1,
> +                                         &data->mdbgc.buf1_p_addr,
> +                                         &data->mdbgc.buf1_v_addr,
> +                                         db_frag.buf1,
> +                                         0,
> +                                         data->mdbgc.count);
> +       if (err)
> +               return err;
> +
> +       /* Allocate DBGC buffer 2 */
> +       db_frag.buf2_index =3D BTINTEL_PCIE_MDBGC_ALLOCATIONID_2;
> +       db_frag.buf2_count =3D data->mdbgc.count;
> +       err =3D btintel_pcie_alloc_dbgc_buf(data,
> +                                         &data->mdbgc.buf2,
> +                                         &data->mdbgc.buf2_p_addr,
> +                                         &data->mdbgc.buf2_v_addr,
> +                                         db_frag.buf2,
> +                                         1,
> +                                         data->mdbgc.count);
> +       if (err)
> +               return err;
> +
> +       /* Allocate DBGC buffer 3 */
> +       db_frag.buf3_index =3D BTINTEL_PCIE_MDBGC_ALLOCATIONID_3;
> +       db_frag.buf3_count =3D data->mdbgc.count;
> +       err =3D btintel_pcie_alloc_dbgc_buf(data,
> +                                         &data->mdbgc.buf3,
> +                                         &data->mdbgc.buf3_p_addr,
> +                                         &data->mdbgc.buf3_v_addr,
> +                                         db_frag.buf3,
> +                                         2,
> +                                         data->mdbgc.count);
> +       if (err)
> +               return err;
> +
> +       /* Copy fragment to DMA coherent memory */
> +       memcpy(data->mdbgc.frag_v_addr, &db_frag, sizeof(db_frag));
> +       return 0;
> +}
> +
>  /* This function initializes the memory for DBGC buffers and formats the
>   * DBGC fragment which consists header info and DBGC buffer's LSB, MSB a=
nd
>   * size as the payload
> @@ -193,46 +318,41 @@ static inline char *btintel_pcie_alivectxt_state2st=
r(u32 alive_intr_ctxt)
>  static int btintel_pcie_setup_dbgc(struct btintel_pcie_data *data)
>  {
>         struct btintel_pcie_dbgc_ctxt db_frag;
> -       struct data_buf *buf;
> -       int i;
> +       int err;
>
>         data->dbgc.count =3D BTINTEL_PCIE_DBGC_BUFFER_COUNT;
> -       data->dbgc.bufs =3D devm_kcalloc(&data->pdev->dev, data->dbgc.cou=
nt,
> -                                      sizeof(*buf), GFP_KERNEL);
> -       if (!data->dbgc.bufs)
> -               return -ENOMEM;
> -
> -       data->dbgc.buf_v_addr =3D dmam_alloc_coherent(&data->pdev->dev,
> -                                                   data->dbgc.count *
> -                                                   BTINTEL_PCIE_DBGC_BUF=
FER_SIZE,
> -                                                   &data->dbgc.buf_p_add=
r,
> -                                                   GFP_KERNEL | __GFP_NO=
WARN);
> -       if (!data->dbgc.buf_v_addr)
> -               return -ENOMEM;
>
> +       /* Allocate fragment context structure */
>         data->dbgc.frag_v_addr =3D dmam_alloc_coherent(&data->pdev->dev,
>                                                      sizeof(struct btinte=
l_pcie_dbgc_ctxt),
>                                                      &data->dbgc.frag_p_a=
ddr,
>                                                      GFP_KERNEL | __GFP_N=
OWARN);
> -       if (!data->dbgc.frag_v_addr)
> +       if (!data->dbgc.frag_v_addr) {
> +               BT_ERR("Failed to allocate dbgc context");
>                 return -ENOMEM;
> +       }
>
>         data->dbgc.frag_size =3D sizeof(struct btintel_pcie_dbgc_ctxt);
>
> +       /* Initialize fragment header */
> +       memset(&db_frag, 0, sizeof(db_frag));
>         db_frag.magic_num =3D BTINTEL_PCIE_MAGIC_NUM;
>         db_frag.ver =3D BTINTEL_PCIE_DBGC_FRAG_VERSION;
>         db_frag.total_size =3D BTINTEL_PCIE_DBGC_FRAG_PAYLOAD_SIZE;
>         db_frag.num_buf =3D BTINTEL_PCIE_DBGC_FRAG_BUFFER_COUNT;
>
> -       for (i =3D 0; i < data->dbgc.count; i++) {
> -               buf =3D &data->dbgc.bufs[i];
> -               buf->data_p_addr =3D data->dbgc.buf_p_addr + i * BTINTEL_=
PCIE_DBGC_BUFFER_SIZE;
> -               buf->data =3D data->dbgc.buf_v_addr + i * BTINTEL_PCIE_DB=
GC_BUFFER_SIZE;
> -               db_frag.bufs[i].buf_addr_lsb =3D lower_32_bits(buf->data_=
p_addr);
> -               db_frag.bufs[i].buf_addr_msb =3D upper_32_bits(buf->data_=
p_addr);
> -               db_frag.bufs[i].buf_size =3D BTINTEL_PCIE_DBGC_BUFFER_SIZ=
E;
> -       }
> +       /* Allocate DBGC buffers */
> +       err =3D btintel_pcie_alloc_dbgc_buf(data,
> +                                         &data->dbgc.bufs,
> +                                         &data->dbgc.buf_p_addr,
> +                                         &data->dbgc.buf_v_addr,
> +                                         db_frag.bufs,
> +                                         0,
> +                                         data->dbgc.count);
> +       if (err)
> +               return err;
>
> +       /* Copy fragment to DMA coherent memory */
>         memcpy(data->dbgc.frag_v_addr, &db_frag, sizeof(db_frag));
>         return 0;
>  }
> @@ -639,63 +759,440 @@ static void btintel_pcie_release_mac_access(struct=
 btintel_pcie_data *data)
>         }
>  }
>
> -static void *btintel_pcie_copy_tlv(void *dest, enum btintel_pcie_tlv_typ=
e type,
> -                                  void *data, size_t size)
> +static const char *btintel_pcie_dumptype_to_str(struct hci_dev *hdev,
> +                                               u8 dumptype)
>  {
> -       struct intel_tlv *tlv;
> +       switch (dumptype) {
> +       case BTINTEL_DRAM_REGION:
> +               return "DRAM_DUMP";
> +       case BTINTEL_SMEM_REGION:
> +               return "MONITOR_SMEM";
> +       case BTINTEL_DCCM_REGION:
> +               return "DCCM_DUMP";
> +       case BTINTEL_SDS_REGION:
> +               return "SDS_DUMP";
> +       case BTINTEL_SDS_IOSF_DATA_REGION:
> +               return "SDS_IOSF_DATA_DUMP";
> +       case BTINTEL_SDS_FIXED_ROM_REGION:
> +               return "SDS_FIXED_ROM_DUMP";
> +       case BTINTEL_EXCEPTION_EVT_DEBUG_REGION:
> +               return "EXCEPTION_EVT_DEBUG_DATA";
> +       case BTINTEL_ECL_REGION:
> +               return "ECL_DUMP";
> +       default:
> +               bt_dev_dbg(hdev, "Unknown dump type: %d", dumptype);
> +               return "UNKNOWN_DUMP_TYPE";
> +       }
> +}
> +
> +static struct scatterlist *btintel_pcie_alloc_sgtable(ssize_t size)
> +{
> +       int nents, i;
> +       struct page *page;
> +       struct scatterlist *sg, *result;
> +
> +       if (size <=3D 0)
> +               return NULL;
>
> -       tlv =3D dest;
> -       tlv->type =3D type;
> -       tlv->len =3D size;
> -       memcpy(tlv->val, data, tlv->len);
> -       return dest + sizeof(*tlv) + size;
> +       nents =3D DIV_ROUND_UP(size, PAGE_SIZE);
> +       result =3D kcalloc(nents + 1, sizeof(*result), GFP_KERNEL);
> +       if (!result)
> +               return NULL;
> +
> +       sg_init_table(result, nents + 1);
> +       sg =3D result;
> +
> +       for (i =3D 0; size > 0; i++) {
> +               ssize_t bytes =3D min_t(ssize_t, size, PAGE_SIZE);
> +
> +               page =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
> +               if (!page)
> +                       goto err_free;
> +
> +               sg_set_page(sg, page, bytes, 0);
> +               sg =3D sg_next(sg);
> +               size -=3D bytes;
> +       }
> +       sg_mark_end(sg - 1);
> +       return result;
> +
> +err_free:
> +       for (sg =3D result; sg; sg =3D sg_next(sg)) {
> +               page =3D sg_page(sg);
> +               if (page)
> +                       __free_page(page);
> +       }
> +       kfree(result);
> +       return NULL;
> +}
> +
> +static struct btintel_pcie_dump_entry *btintel_pcie_dump_entry_alloc(u32=
 data_size)
> +{
> +       struct btintel_pcie_dump_entry *entry;
> +
> +       entry =3D vzalloc(sizeof(*entry) + data_size);
> +       if (!entry)
> +               return NULL;
> +
> +       entry->size =3D data_size;
> +       INIT_LIST_HEAD(&entry->list);
> +       return entry;
> +}
> +
> +static void btintel_pcie_dump_list_free(struct list_head *list)
> +{
> +       struct btintel_pcie_dump_entry *entry, *tmp;
> +
> +       list_for_each_entry_safe(entry, tmp, list, list) {
> +               list_del(&entry->list);
> +               vfree(entry);
> +       }
> +}
> +
> +static u32 btintel_pcie_dump_list_total_size(struct list_head *list)
> +{
> +       struct btintel_pcie_dump_entry *entry;
> +       u32 total =3D 0;
> +
> +       list_for_each_entry(entry, list, list)
> +               total +=3D entry->size;
> +
> +       return total;
> +}
> +
> +static int btintel_pcie_dump_dram(struct list_head *list,
> +                                 u8 count, struct data_buf *bufs,
> +                                 u8 buf_idx, u32 write_ptr, u32 wrap_ctr=
,
> +                                 u32 region_id, const char *name)
> +{
> +       struct btintel_pcie_dump_entry *entry;
> +       struct btintel_pcie_ini_dump_data *dump_data;
> +       struct btintel_pcie_ini_monitor_dump *mon_dump;
> +       struct btintel_pcie_dump_range *range;
> +       u32 mon_hdr_size, ranges_size, payload_size, total_size;
> +       int i;
> +
> +       mon_hdr_size =3D sizeof(*mon_dump);
> +       ranges_size =3D count * (sizeof(*range) + BTINTEL_PCIE_DBGC_BUFFE=
R_SIZE);
> +       payload_size =3D mon_hdr_size + ranges_size;
> +       total_size =3D sizeof(*dump_data) + payload_size;
> +
> +       entry =3D btintel_pcie_dump_entry_alloc(total_size);
> +       if (!entry)
> +               return -ENOMEM;
> +
> +       dump_data =3D (void *)entry->data;
> +       dump_data->type =3D BTINTEL_PCIE_INI_REGION_DRAM_BUFFER;
> +       dump_data->sub_type =3D 0;
> +       dump_data->sub_type_ver =3D 0;
> +       dump_data->reserved =3D 0;
> +       dump_data->len =3D cpu_to_le32(payload_size);
> +
> +       mon_dump =3D (void *)dump_data->data;
> +       mon_dump->header.version =3D cpu_to_le32(BTINTEL_PCIE_INI_DUMP_VE=
R);
> +       mon_dump->header.region_id =3D cpu_to_le32(region_id);
> +       mon_dump->header.num_of_ranges =3D cpu_to_le32(count);
> +       mon_dump->header.name_len =3D cpu_to_le32(BTINTEL_PCIE_INI_MAX_NA=
ME);
> +       memset(mon_dump->header.name, 0, BTINTEL_PCIE_INI_MAX_NAME);
> +       strscpy(mon_dump->header.name, name, BTINTEL_PCIE_INI_MAX_NAME);
> +
> +       mon_dump->write_ptr =3D cpu_to_le32(write_ptr);
> +       mon_dump->cycle_cnt =3D cpu_to_le32(wrap_ctr);
> +       mon_dump->cur_frag =3D cpu_to_le32(buf_idx);
> +
> +       range =3D (void *)mon_dump->data;
> +       for (i =3D 0; i < count; i++) {
> +               range->range_data_size =3D cpu_to_le32(BTINTEL_PCIE_DBGC_=
BUFFER_SIZE);
> +               range->dram_base_addr =3D cpu_to_le64(bufs[i].data_p_addr=
);
> +               memcpy(range->data, bufs[i].data, BTINTEL_PCIE_DBGC_BUFFE=
R_SIZE);
> +               range =3D (void *)range->data + BTINTEL_PCIE_DBGC_BUFFER_=
SIZE;
> +       }
> +
> +       list_add_tail(&entry->list, list);
> +       return 0;
>  }
>
> -static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data=
)
> +static int btintel_pcie_dump_target_region(struct btintel_pcie_data *dat=
a,
> +                                          struct list_head *list,
> +                                          u8 region_type, u32 region_id,
> +                                          const char *name,
> +                                          u32 addr_start, u32 size)
>  {
> -       u32 offset, prev_size, wr_ptr_status, dump_size, data_len;
> -       u32 status_reg, wrap_reg;
> -       struct btintel_pcie_dbgc *dbgc =3D &data->dbgc;
> +       struct btintel_pcie_dump_entry *entry;
> +       struct btintel_pcie_ini_dump_data *dump_data;
> +       struct btintel_pcie_ini_dump_header *hdr;
> +       struct btintel_pcie_dump_range *range;
> +       u32 payload_size, total_size, target_mem_offset, tempdata;
> +       u8 *dest;
> +       int i;
> +
> +       if (!size) {
> +               bt_dev_warn(data->hdev, "Skipping empty dump region: %s",=
 name);
> +               return 0;
> +       }
> +
> +       if (!addr_start) {
> +               bt_dev_warn(data->hdev, "Skipping dump region with zero a=
ddress: %s", name);
> +               return 0;
> +       }
> +
> +       /* Align to 4 bytes - target access reads 32-bit words */
> +       size =3D round_down(size, sizeof(u32));
> +
> +       bt_dev_info(data->hdev,
> +                   "Target access: region=3D%s start=3D0x%08x size=3D%u"=
,
> +                   name, addr_start, size);
> +
> +       payload_size =3D sizeof(*hdr) + sizeof(*range) + size;
> +       total_size =3D sizeof(*dump_data) + payload_size;
> +       entry =3D btintel_pcie_dump_entry_alloc(total_size);
> +       if (!entry)
> +               return -ENOMEM;
> +
> +       dump_data =3D (void *)entry->data;
> +       dump_data->type =3D region_type;
> +       dump_data->sub_type =3D 0;
> +       dump_data->sub_type_ver =3D 0;
> +       dump_data->reserved =3D 0;
> +       dump_data->len =3D cpu_to_le32(payload_size);
> +
> +       hdr =3D (void *)dump_data->data;
> +       hdr->version =3D cpu_to_le32(BTINTEL_PCIE_INI_DUMP_VER);
> +       hdr->region_id =3D cpu_to_le32(region_id);
> +       hdr->num_of_ranges =3D cpu_to_le32(1);
> +       hdr->name_len =3D cpu_to_le32(BTINTEL_PCIE_INI_MAX_NAME);
> +       memset(hdr->name, 0, BTINTEL_PCIE_INI_MAX_NAME);
> +       strscpy(hdr->name, name, BTINTEL_PCIE_INI_MAX_NAME);
> +
> +       range =3D (void *)(hdr + 1);
> +       range->range_data_size =3D cpu_to_le32(size);
> +       range->internal_base_addr =3D cpu_to_le32(addr_start);
> +
> +       dest =3D (u8 *)range->data;
> +       target_mem_offset =3D size / sizeof(u32);
> +       for (i =3D 0; i < target_mem_offset; i++) {
> +               u32 offset =3D BTINTEL_PCIE_TARGET_ACCESS_FRAG_OFFSET * i=
;
> +
> +               tempdata =3D btintel_pcie_rd_dev_mem(data,
> +                                                  addr_start + offset);
> +               memcpy(dest, &tempdata, sizeof(tempdata));
> +               dest +=3D sizeof(tempdata);
> +       }
> +
> +       list_add_tail(&entry->list, list);
> +       return 0;
> +}
> +
> +static int btintel_pcie_dump_smem_monitor_region(struct btintel_pcie_dat=
a *data,
> +                                                struct list_head *list,
> +                                                u32 region_id,
> +                                                const char *name,
> +                                                u32 addr_start, u32 size=
)
> +{
> +       struct btintel_pcie_dump_entry *entry;
> +       struct btintel_pcie_ini_dump_data *dump_data;
> +       struct btintel_pcie_ini_monitor_dump *mon;
> +       struct btintel_pcie_dump_range *range;
> +       u32 payload_size, total_size, target_mem_offset, tempdata;
> +       u8 *dest;
> +       int i;
> +
> +       if (!size || !addr_start) {
> +               bt_dev_err(data->hdev, "Skipping smem dump: size =3D %u a=
ddr =3D %8.8x",
> +                          size, addr_start);
> +               return -EINVAL;
> +       }
> +
> +       payload_size =3D sizeof(*mon) + sizeof(*range) + size;
> +       total_size =3D sizeof(*dump_data) + payload_size;
> +       entry =3D btintel_pcie_dump_entry_alloc(total_size);
> +       if (!entry)
> +               return -ENOMEM;
> +
> +       dump_data =3D (void *)entry->data;
> +       dump_data->type =3D BTINTEL_PCIE_INI_REGION_INTERNAL_BUFFER;
> +       dump_data->sub_type =3D 0;
> +       dump_data->sub_type_ver =3D 0;
> +       dump_data->reserved =3D 0;
> +       dump_data->len =3D cpu_to_le32(payload_size);
> +
> +       mon =3D (void *)dump_data->data;
> +       mon->header.version =3D cpu_to_le32(BTINTEL_PCIE_INI_DUMP_VER);
> +       mon->header.region_id =3D cpu_to_le32(region_id);
> +       mon->header.num_of_ranges =3D cpu_to_le32(1);
> +       mon->header.name_len =3D cpu_to_le32(BTINTEL_PCIE_INI_MAX_NAME);
> +       memset(mon->header.name, 0, BTINTEL_PCIE_INI_MAX_NAME);
> +       strscpy(mon->header.name, name, BTINTEL_PCIE_INI_MAX_NAME);
> +
> +       mon->write_ptr =3D cpu_to_le32(0);
> +       mon->cycle_cnt =3D cpu_to_le32(0);
> +       mon->cur_frag =3D cpu_to_le32(0);
> +
> +       range =3D (void *)mon->data;
> +       range->range_data_size =3D cpu_to_le32(size);
> +       range->internal_base_addr =3D cpu_to_le32(addr_start);
> +
> +       dest =3D (u8 *)range->data;
> +       target_mem_offset =3D size / sizeof(u32);
> +       for (i =3D 0; i < target_mem_offset; i++) {
> +               u32 offset =3D BTINTEL_PCIE_TARGET_ACCESS_FRAG_OFFSET * i=
;
> +
> +               tempdata =3D btintel_pcie_rd_dev_mem(data,
> +                                                  addr_start + offset);
> +               memcpy(dest, &tempdata, sizeof(tempdata));
> +               dest +=3D sizeof(tempdata);
> +       }
> +
> +       list_add_tail(&entry->list, list);
> +       return 0;
> +}
> +
> +static int btintel_pcie_dump_info(struct btintel_pcie_data *data,
> +                                 struct list_head *list,
> +                                 u64 regions_mask)
> +{
> +       struct btintel_pcie_dump_entry *entry;
> +       struct btintel_pcie_error_dump_data *tlv;
> +       struct btintel_pcie_ini_dump_info *dump;
> +       u32 size =3D sizeof(*tlv) + sizeof(*dump);
> +       char build_tag[64];
> +
> +       entry =3D btintel_pcie_dump_entry_alloc(size);
> +       if (!entry)
> +               return -ENOMEM;
> +
> +       tlv =3D (void *)entry->data;
> +       tlv->type =3D cpu_to_le32(BTINTEL_PCIE_INI_DUMP_INFO_TYPE);
> +       tlv->len =3D cpu_to_le32(sizeof(*dump));
> +
> +       dump =3D (void *)tlv->data;
> +       memset(dump, 0, sizeof(*dump));
> +
> +       dump->version =3D cpu_to_le32(BTINTEL_PCIE_INI_DUMP_VER);
> +       dump->trigger_reason =3D cpu_to_le32(data->dmp_hdr.trigger_reason=
);
> +
> +       if (data->dmp_hdr.trigger_reason =3D=3D BTINTEL_PCIE_TRIGGER_REAS=
ON_FW_ASSERT)
> +               dump->time_point =3D cpu_to_le32(BTINTEL_PCIE_TIME_POINT_=
FW_ASSERT);
> +       else if (data->dmp_hdr.trigger_reason =3D=3D BTINTEL_PCIE_TRIGGER=
_REASON_USER_TRIGGER)
> +               dump->time_point =3D cpu_to_le32(BTINTEL_PCIE_TIME_POINT_=
USER_TRIGGER);
> +
> +       dump->hw_type =3D cpu_to_le32(data->dmp_hdr.cnvi_top & 0xFFFF);
> +       bt_dev_dbg(data->hdev, "hw_type=3D0x%x (cnvi_top=3D0x%x)",
> +                  data->dmp_hdr.cnvi_top & 0xFFFF,
> +                  data->dmp_hdr.cnvi_top);
> +
> +       dump->ver_type =3D cpu_to_le32(data->dmp_hdr.cnvi_bt);
> +       dump->ver_subtype =3D cpu_to_le32(data->dmp_hdr.fw_git_sha1);
> +       dump->hw_step =3D cpu_to_le32(data->cnvr);
> +       dump->rf_id_type =3D cpu_to_le32(data->dmp_hdr.cnvr_top & 0xFFF);
> +       dump->rf_id_flavor =3D cpu_to_le32(data->dmp_hdr.cnvr_top);
> +       bt_dev_dbg(data->hdev, "rf_id_type=3D0x%x (cnvr_top=3D0x%x)",
> +                  data->dmp_hdr.cnvr_top & 0xFFF,
> +                  data->dmp_hdr.cnvr_top);
> +       dump->lmac_major =3D cpu_to_le32(0);
> +       dump->lmac_minor =3D cpu_to_le32(0);
> +       dump->umac_major =3D cpu_to_le32(0);
> +       dump->umac_minor =3D cpu_to_le32(0);
> +       dump->fw_mon_mode =3D cpu_to_le32(BTINTEL_PCIE_FW_MON_MODE_DRAM);
> +
> +       dump->regions_mask =3D cpu_to_le64(regions_mask);
> +
> +       bt_dev_dbg(data->hdev, "ExpectedRegionIDs regions_mask=3D0x%016ll=
x",
> +                  le64_to_cpu(dump->regions_mask));
> +
> +       snprintf(build_tag, sizeof(build_tag), "%08X", data->dmp_hdr.fw_g=
it_sha1);
> +
> +       dump->build_tag_len =3D cpu_to_le32(strlen(build_tag));
> +       memcpy(dump->build_tag, build_tag, min(strlen(build_tag),
> +                                              sizeof(dump->build_tag)));
> +
> +       dump->num_of_cfg_names =3D cpu_to_le32(0);
> +
> +       bt_dev_dbg(data->hdev, "HwType=3D0x%08x HwStep=3D0x%08x RfIdType=
=3D0x%08x RfIdFlavor=3D0x%08x",
> +                  le32_to_cpu(dump->hw_type), le32_to_cpu(dump->hw_step)=
,
> +                  le32_to_cpu(dump->rf_id_type), le32_to_cpu(dump->rf_id=
_flavor));
> +       bt_dev_dbg(data->hdev, "VerType=3D0x%08x VerSubType=3D0x%08x",
> +                  le32_to_cpu(dump->ver_type), le32_to_cpu(dump->ver_sub=
type));
> +       bt_dev_dbg(data->hdev, "LmacMajor=3D0x%08x LmacMinor=3D0x%08x Uma=
cMajor=3D0x%08x UmacMinor=3D0x%08x",
> +                  le32_to_cpu(dump->lmac_major), le32_to_cpu(dump->lmac_=
minor),
> +                  le32_to_cpu(dump->umac_major), le32_to_cpu(dump->umac_=
minor));
> +       bt_dev_dbg(data->hdev, "TriggerReason=3D0x%04x MonMode=3D%u Build=
Tag=3D%.64s",
> +                  le32_to_cpu(dump->trigger_reason),
> +                  le32_to_cpu(dump->fw_mon_mode),
> +                  dump->build_tag);
> +
> +       list_add(&entry->list, list);
> +
> +       return 0;
> +}
> +
> +static bool btintel_pcie_is_mdbgc_supported(struct btintel_pcie_data *da=
ta)
> +{
> +       return data->pdev->device =3D=3D BTINTEL_PCIE_DEVICE_ID_NVL_S_SCP=
2 ||
> +               data->pdev->device =3D=3D BTINTEL_PCIE_DEVICE_ID_NVL_Hx_S=
CP2 ||
> +               data->pdev->device =3D=3D BTINTEL_PCIE_DEVICE_ID_PTL_FMP2=
;
> +}
> +
> +static int btintel_pcie_read_debug_regions(struct btintel_pcie_data *dat=
a)
> +{
> +       struct btintel_pcie_dbgc *dbgc =3D NULL;
> +       struct btintel_pcie_mdbgc *mdbgc =3D NULL;
>         struct hci_dev *hdev =3D data->hdev;
> -       u8 *pdata, *p, buf_idx, hw_variant;
> -       struct intel_tlv *tlv;
> -       struct timespec64 now;
> -       struct tm tm_now;
> -       char fw_build[128];
> -       char ts[128];
> -       char vendor[64];
> -       char driver[64];
> +       struct btintel_pcie_dump_entry *entry;
> +       struct btintel_pcie_dump_file_hdr *file_hdr;
> +       struct scatterlist *sg_dump_data;
> +       u32 offset, prev_size, wr_ptr_status;
> +       u32 region_size;
> +       u32 exception_dump_len;
> +       u64 regions_mask =3D 0;
> +       u8 buf_idx, hw_variant;
> +       u32 smem_rd_addr =3D 0, smem_rd_size =3D 0;
> +       u32 file_len;
> +       u8 count;
> +       int ret;
> +       LIST_HEAD(dump_list);
>
>         if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
>                 return -EOPNOTSUPP;
>
> +       bt_dev_info(data->hdev, "%s: WRT dump triggered",
> +                   data->dmp_hdr.trigger_reason =3D=3D BTINTEL_PCIE_TRIG=
GER_REASON_FW_ASSERT ?
> +                       "Firmware" : "User");
> +
> +       if (btintel_pcie_is_mdbgc_supported(data)) {
> +               mdbgc =3D &data->mdbgc;
> +               count =3D mdbgc->count;
> +       } else {
> +               dbgc =3D &data->dbgc;
> +               count =3D dbgc->count;
> +       }
>
>         hw_variant =3D INTEL_HW_VARIANT(data->cnvi);
> -       switch (hw_variant) {
> -       case BTINTEL_HWID_BZRI:
> -       case BTINTEL_HWID_BZRIW:
> -               status_reg =3D BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS;
> -               wrap_reg =3D BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND;
> -               break;
> -       case BTINTEL_HWID_SCP:
> -       case BTINTEL_HWID_SCP2:
> -       case BTINTEL_HWID_SCP2F:
> -               status_reg =3D BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS_SCP;
> -               wrap_reg =3D BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND_SCP;
> -               break;
> -       default:
> -               bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%=
2.2x)",
> -                          hw_variant);
> +
> +       if (hw_variant =3D=3D BTINTEL_HWID_BZRI ||
> +           hw_variant =3D=3D BTINTEL_HWID_BZRIW) {
> +               wr_ptr_status =3D
> +                       btintel_pcie_rd_dev_mem(data,
> +                                              BTINTEL_PCIE_DBGC_CUR_DBGB=
UFF_STATUS);
> +               data->dmp_hdr.wrap_ctr =3D
> +                       btintel_pcie_rd_dev_mem(data,
> +                                              BTINTEL_PCIE_DBGC_DBGBUFF_=
WRAP_ARND);
> +       } else if (hw_variant >=3D BTINTEL_HWID_SCP) {
> +               wr_ptr_status =3D
> +                       btintel_pcie_rd_dev_mem(data,
> +                                              BTINTEL_PCIE_DBGC_CUR_DBGB=
UFF_STATUS_SCP);
> +               data->dmp_hdr.wrap_ctr =3D
> +                       btintel_pcie_rd_dev_mem(data,
> +                                              BTINTEL_PCIE_DBGC_DBGBUFF_=
WRAP_ARND_SCP);
> +       } else {
> +               bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%=
2.2x)", hw_variant);
>                 return -EINVAL;
>         }
>
> -       wr_ptr_status =3D btintel_pcie_rd_dev_mem(data, status_reg);
> -       data->dmp_hdr.wrap_ctr =3D btintel_pcie_rd_dev_mem(data, wrap_reg=
);
> -
>         offset =3D wr_ptr_status & BTINTEL_PCIE_DBG_OFFSET_BIT_MASK;
>
>         buf_idx =3D BTINTEL_PCIE_DBGC_DBG_BUF_IDX(wr_ptr_status);
> -       if (buf_idx > dbgc->count) {
> +       if (buf_idx > count) {
>                 bt_dev_warn(hdev, "Buffer index is invalid");
>                 return -EINVAL;
>         }
> @@ -706,102 +1203,193 @@ static int btintel_pcie_read_dram_buffers(struct=
 btintel_pcie_data *data)
>         else
>                 return -EINVAL;
>
> -       strscpy(vendor, "Vendor: Intel\n");
> -       snprintf(driver, sizeof(driver), "Driver: %s\n",
> -                data->dmp_hdr.driver_name);
> -
> -       ktime_get_real_ts64(&now);
> -       time64_to_tm(now.tv_sec, 0, &tm_now);
> -       snprintf(ts, sizeof(ts), "Dump Time: %02d-%02d-%04ld %02d:%02d:%0=
2d",
> -                                tm_now.tm_mday, tm_now.tm_mon + 1, tm_no=
w.tm_year + 1900,
> -                                tm_now.tm_hour, tm_now.tm_min, tm_now.tm=
_sec);
> -
> -       snprintf(fw_build, sizeof(fw_build),
> -                           "Firmware Timestamp: Year %u WW %02u buildtyp=
e %u build %u",
> -                           2000 + (data->dmp_hdr.fw_timestamp >> 8),
> -                           data->dmp_hdr.fw_timestamp & 0xff, data->dmp_=
hdr.fw_build_type,
> -                           data->dmp_hdr.fw_build_num);
> -
> -       data_len =3D sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_bt) +
> -               sizeof(*tlv) + sizeof(data->dmp_hdr.write_ptr) +
> -               sizeof(*tlv) + sizeof(data->dmp_hdr.wrap_ctr) +
> -               sizeof(*tlv) + sizeof(data->dmp_hdr.trigger_reason) +
> -               sizeof(*tlv) + sizeof(data->dmp_hdr.fw_git_sha1) +
> -               sizeof(*tlv) + sizeof(data->dmp_hdr.cnvr_top) +
> -               sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_top) +
> -               sizeof(*tlv) + strlen(ts) +
> -               sizeof(*tlv) + strlen(fw_build) +
> -               sizeof(*tlv) + strlen(vendor) +
> -               sizeof(*tlv) + strlen(driver);
> -
> -       if (data->dmp_hdr.event_type && data->dmp_hdr.event_id) {
> -               data_len +=3D sizeof(*tlv) + sizeof(data->dmp_hdr.event_t=
ype);
> -               data_len +=3D sizeof(*tlv) + sizeof(data->dmp_hdr.event_i=
d);
> +       bt_dev_dbg(hdev, "wr_ptr_status=3D0x%08x buf_idx=3D%u offset=3D0x=
%06x",
> +                  wr_ptr_status, buf_idx, offset);
> +       bt_dev_dbg(hdev, "write_ptr=3D0x%08x wrap_ctr=3D0x%08x",
> +                  data->dmp_hdr.write_ptr, data->dmp_hdr.wrap_ctr);
> +
> +       smem_rd_addr =3D data->dump_info.smem_addr_start;
> +       smem_rd_size =3D (data->dump_info.smem_addr_end + 0x04) -
> +                      data->dump_info.smem_addr_start;
> +
> +       bt_dev_info(hdev, "smem_region: smem_start_addr=3D0x%08x smem_end=
_addr=3D0x%08x smem_rd_size=3D%u",
> +                   smem_rd_addr, data->dump_info.smem_addr_end, smem_rd_=
size);
> +
> +       if (smem_rd_size =3D=3D 0 ||
> +           smem_rd_size > BTINTEL_PCIE_SMEM_MAX_SIZE) {
> +               bt_dev_err(hdev, "Invalid smem region: smem_rd_addr 0x%08=
x size %u (max %u)",
> +                          smem_rd_addr, smem_rd_size, BTINTEL_PCIE_SMEM_=
MAX_SIZE);
> +               smem_rd_size =3D 0;
>         }
>
> -       /*
> -        * sizeof(u32) - signature
> -        * sizeof(data_len) - to store tlv data size
> -        * data_len - TLV data
> -        */
> -       dump_size =3D sizeof(u32) + sizeof(data_len) + data_len;
> +       if (btintel_pcie_is_mdbgc_supported(data)) {
> +               ret =3D btintel_pcie_dump_dram(&dump_list, count,
> +                                            mdbgc->buf1, 0,
> +                                            data->dmp_hdr.write_ptr,
> +                                            data->dmp_hdr.wrap_ctr,
> +                                            BTINTEL_PCIE_INI_ID_DRAM_MON=
ITOR1,
> +                                            "monitor");
> +               if (!ret)
> +                       regions_mask |=3D BIT_ULL(BTINTEL_PCIE_INI_ID_DRA=
M_MONITOR1);
> +               else
> +                       bt_dev_warn(hdev, "Failed to dump DRAM buf1: %d",=
 ret);
> +
> +               ret =3D btintel_pcie_dump_dram(&dump_list, count,
> +                                            mdbgc->buf2, 0,
> +                                            data->dmp_hdr.write_ptr,
> +                                            data->dmp_hdr.wrap_ctr,
> +                                            BTINTEL_PCIE_INI_ID_DRAM_MON=
ITOR2,
> +                                            "monitor2");
> +               if (!ret)
> +                       regions_mask |=3D BIT_ULL(BTINTEL_PCIE_INI_ID_DRA=
M_MONITOR2);
> +               else
> +                       bt_dev_warn(hdev, "Failed to dump DRAM buf2: %d",=
 ret);
> +
> +               ret =3D btintel_pcie_dump_dram(&dump_list, count,
> +                                            mdbgc->buf3, 0,
> +                                            data->dmp_hdr.write_ptr,
> +                                            data->dmp_hdr.wrap_ctr,
> +                                            BTINTEL_PCIE_INI_ID_DRAM_MON=
ITOR3,
> +                                            "monitor3");
> +               if (!ret)
> +                       regions_mask |=3D BIT_ULL(BTINTEL_PCIE_INI_ID_DRA=
M_MONITOR3);
> +               else
> +                       bt_dev_warn(hdev, "Failed to dump DRAM buf3: %d",=
 ret);
> +       } else {
> +               ret =3D btintel_pcie_dump_dram(&dump_list, count,
> +                                            dbgc->bufs, 0,
> +                                            data->dmp_hdr.write_ptr,
> +                                            data->dmp_hdr.wrap_ctr,
> +                                            BTINTEL_PCIE_INI_ID_DRAM_MON=
ITOR1,
> +                                            "monitor");
> +               if (!ret)
> +                       regions_mask |=3D BIT_ULL(BTINTEL_PCIE_INI_ID_DRA=
M_MONITOR1);
> +               else
> +                       bt_dev_warn(hdev, "Failed to dump DRAM region: %d=
", ret);
> +       }
> +
> +       if (smem_rd_size) {
> +               ret =3D btintel_pcie_dump_smem_monitor_region(data, &dump=
_list,
> +                                                           BTINTEL_PCIE_=
INI_ID_SMEM,
> +                                                           "monitor_smem=
",
> +                                                           smem_rd_addr,=
 smem_rd_size);
> +               if (!ret)
> +                       regions_mask |=3D BIT_ULL(BTINTEL_PCIE_INI_ID_SME=
M);
> +       }
> +
> +       exception_dump_len =3D data->dump_info.exception_dump_len;
> +       ret =3D btintel_pcie_dump_target_region(data, &dump_list,
> +                                             BTINTEL_PCIE_INI_REGION_DEV=
ICE_MEMORY,
> +                                             BTINTEL_PCIE_INI_ID_EXCEPTI=
ON_EVT,
> +                                             "EXCEPTION_EVT_BUFFER",
> +                                             data->dump_info.exception_d=
ump_addr,
> +                                             exception_dump_len);
> +       if (!ret && exception_dump_len)
> +               regions_mask |=3D BIT_ULL(BTINTEL_PCIE_INI_ID_EXCEPTION_E=
VT);
> +
> +       if (data->dump_info.dccm_addr_start &&
> +           data->dump_info.dccm_addr_end &&
> +           data->dump_info.dccm_addr_end >=3D data->dump_info.dccm_addr_=
start) {
> +               region_size =3D (data->dump_info.dccm_addr_end + 0x04) -
> +                             data->dump_info.dccm_addr_start;
> +               ret =3D btintel_pcie_dump_target_region(data, &dump_list,
> +                                                     BTINTEL_PCIE_INI_RE=
GION_DEVICE_MEMORY,
> +                                                     BTINTEL_PCIE_INI_ID=
_DCCM,
> +                                                     "DCCM",
> +                                                     data->dump_info.dcc=
m_addr_start,
> +                                                     region_size);
> +               if (!ret)
> +                       regions_mask |=3D BIT_ULL(BTINTEL_PCIE_INI_ID_DCC=
M);
> +       }
> +
> +       if (data->dump_info.sds_start_addr_start &&
> +           data->dump_info.sds_start_addr_end &&
> +           data->dump_info.sds_start_addr_end >=3D data->dump_info.sds_s=
tart_addr_start) {
> +               region_size =3D (data->dump_info.sds_start_addr_end + 0x0=
4) -
> +                             data->dump_info.sds_start_addr_start;
> +               ret =3D btintel_pcie_dump_target_region(data, &dump_list,
> +                                                     BTINTEL_PCIE_INI_RE=
GION_DEVICE_MEMORY,
> +                                                     BTINTEL_PCIE_INI_ID=
_SDS,
> +                                                     "SDS",
> +                                                     data->dump_info.sds=
_start_addr_start,
> +                                                     region_size);
> +               if (!ret)
> +                       regions_mask |=3D BIT_ULL(BTINTEL_PCIE_INI_ID_SDS=
);
> +       }
> +
> +       if (data->dump_info.sds_iosf_data_addr_start &&
> +           data->dump_info.sds_iosf_data_addr_end &&
> +           data->dump_info.sds_iosf_data_addr_end >=3D data->dump_info.s=
ds_iosf_data_addr_start) {
> +               region_size =3D (data->dump_info.sds_iosf_data_addr_end +=
 0x04) -
> +                             data->dump_info.sds_iosf_data_addr_start;
> +               ret =3D btintel_pcie_dump_target_region(data, &dump_list,
> +                                                     BTINTEL_PCIE_INI_RE=
GION_DEVICE_MEMORY,
> +                                                     BTINTEL_PCIE_INI_ID=
_SDS_IOSF,
> +                                                     "SDS_IOSF",
> +                                                     data->dump_info.sds=
_iosf_data_addr_start,
> +                                                     region_size);
> +               if (!ret)
> +                       regions_mask |=3D BIT_ULL(BTINTEL_PCIE_INI_ID_SDS=
_IOSF);
> +       }
>
> +       if (data->dump_info.ecl_addr_start &&
> +           data->dump_info.ecl_addr_end &&
> +           data->dump_info.ecl_addr_end >=3D data->dump_info.ecl_addr_st=
art) {
> +               region_size =3D (data->dump_info.ecl_addr_end + 0x04) -
> +                             data->dump_info.ecl_addr_start;
> +               ret =3D btintel_pcie_dump_target_region(data, &dump_list,
> +                                                     BTINTEL_PCIE_INI_RE=
GION_DEVICE_MEMORY,
> +                                                     BTINTEL_PCIE_INI_ID=
_ECL,
> +                                                     "ECL_REGION",
> +                                                     data->dump_info.ecl=
_addr_start,
> +                                                     region_size);
> +               if (!ret)
> +                       regions_mask |=3D BIT_ULL(BTINTEL_PCIE_INI_ID_ECL=
);
> +       }
>
> -       /* Add debug buffers data length to dump size */
> -       dump_size +=3D BTINTEL_PCIE_DBGC_BUFFER_SIZE * dbgc->count;
> +       ret =3D btintel_pcie_dump_info(data, &dump_list, regions_mask);
> +       if (ret) {
> +               btintel_pcie_dump_list_free(&dump_list);
> +               return ret;
> +       }
>
> -       pdata =3D vmalloc(dump_size);
> -       if (!pdata)
> +       file_len =3D sizeof(*file_hdr) + btintel_pcie_dump_list_total_siz=
e(&dump_list);
> +       entry =3D btintel_pcie_dump_entry_alloc(sizeof(*file_hdr));
> +       if (!entry) {
> +               btintel_pcie_dump_list_free(&dump_list);
>                 return -ENOMEM;
> -       p =3D pdata;
> -
> -       *(u32 *)p =3D BTINTEL_PCIE_MAGIC_NUM;
> -       p +=3D sizeof(u32);
> -
> -       *(u32 *)p =3D data_len;
> -       p +=3D sizeof(u32);
> -
> -
> -       p =3D btintel_pcie_copy_tlv(p, BTINTEL_VENDOR, vendor, strlen(ven=
dor));
> -       p =3D btintel_pcie_copy_tlv(p, BTINTEL_DRIVER, driver, strlen(dri=
ver));
> -       p =3D btintel_pcie_copy_tlv(p, BTINTEL_DUMP_TIME, ts, strlen(ts))=
;
> -       p =3D btintel_pcie_copy_tlv(p, BTINTEL_FW_BUILD, fw_build,
> -                                 strlen(fw_build));
> -       p =3D btintel_pcie_copy_tlv(p, BTINTEL_CNVI_BT, &data->dmp_hdr.cn=
vi_bt,
> -                                 sizeof(data->dmp_hdr.cnvi_bt));
> -       p =3D btintel_pcie_copy_tlv(p, BTINTEL_WRITE_PTR, &data->dmp_hdr.=
write_ptr,
> -                                 sizeof(data->dmp_hdr.write_ptr));
> -       p =3D btintel_pcie_copy_tlv(p, BTINTEL_WRAP_CTR, &data->dmp_hdr.w=
rap_ctr,
> -                                 sizeof(data->dmp_hdr.wrap_ctr));
> -       p =3D btintel_pcie_copy_tlv(p, BTINTEL_TRIGGER_REASON, &data->dmp=
_hdr.trigger_reason,
> -                                 sizeof(data->dmp_hdr.trigger_reason));
> -       p =3D btintel_pcie_copy_tlv(p, BTINTEL_FW_SHA, &data->dmp_hdr.fw_=
git_sha1,
> -                                 sizeof(data->dmp_hdr.fw_git_sha1));
> -       p =3D btintel_pcie_copy_tlv(p, BTINTEL_CNVR_TOP, &data->dmp_hdr.c=
nvr_top,
> -                                 sizeof(data->dmp_hdr.cnvr_top));
> -       p =3D btintel_pcie_copy_tlv(p, BTINTEL_CNVI_TOP, &data->dmp_hdr.c=
nvi_top,
> -                                 sizeof(data->dmp_hdr.cnvi_top));
> -
> -       if (data->dmp_hdr.event_type && data->dmp_hdr.event_id) {
> -               p =3D btintel_pcie_copy_tlv(p, BTINTEL_EVENT_TYPE,
> -                                         &data->dmp_hdr.event_type,
> -                                         sizeof(data->dmp_hdr.event_type=
));
> -               p =3D btintel_pcie_copy_tlv(p, BTINTEL_EVENT_ID,
> -                                         &data->dmp_hdr.event_id,
> -                                         sizeof(data->dmp_hdr.event_id))=
;
> -               data->dmp_hdr.event_type =3D 0;
> -               data->dmp_hdr.event_id =3D 0;
> -       }
> -
> -       memcpy(p, dbgc->bufs[0].data, dbgc->count * BTINTEL_PCIE_DBGC_BUF=
FER_SIZE);
> -       dev_coredumpv(&hdev->dev, pdata, dump_size, GFP_KERNEL);
> +       }
> +
> +       file_hdr =3D (void *)entry->data;
> +       file_hdr->barker =3D cpu_to_le32(BTINTEL_PCIE_INI_ERROR_DUMP_BARK=
ER);
> +       file_hdr->file_len =3D cpu_to_le32(file_len);
> +       list_add(&entry->list, &dump_list);
> +
> +       sg_dump_data =3D btintel_pcie_alloc_sgtable(file_len);
> +       if (sg_dump_data) {
> +               int sg_entries =3D sg_nents(sg_dump_data);
> +               u32 offs =3D 0;
> +
> +               list_for_each_entry(entry, &dump_list, list) {
> +                       sg_pcopy_from_buffer(sg_dump_data, sg_entries,
> +                                            entry->data, entry->size, of=
fs);
> +                       offs +=3D entry->size;
> +               }
> +
> +               bt_dev_info(hdev, "triggering dev_coredumpsg()");
> +               dev_coredumpsg(&hdev->dev, sg_dump_data, file_len, GFP_KE=
RNEL);
> +       } else {
> +               bt_dev_err(hdev, "Failed to allocate scatter-gather table=
 for coredump");
> +       }
> +
> +       btintel_pcie_dump_list_free(&dump_list);
>         return 0;
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
> @@ -809,7 +1397,7 @@ static void btintel_pcie_dump_traces(struct hci_dev =
*hdev)
>                 return;
>         }
>
> -       ret =3D btintel_pcie_read_dram_buffers(data);
> +       ret =3D btintel_pcie_read_debug_regions(data);
>
>         btintel_pcie_release_mac_access(data);
>
> @@ -957,10 +1545,241 @@ static inline bool btintel_pcie_in_error(struct b=
tintel_pcie_data *data)
>         return  data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_ABOR=
T_HANDLER;
>  }
>
> +static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
> +{
> +       /* Custom TLV structure for mailbox parsing
> +        * len is __le16 as per agreemnt with FW
> +        */
> +       struct mbox_tlv {
> +               u8 type;
> +               __le16 len;
> +               u8 val[];
> +       } __packed;
> +
> +       u8 *buffer, *ptr;
> +       u32 buffer_len, err, remaining;
> +       struct mbox_tlv *tlv;
> +       struct btintel_data *cnvi_data =3D hci_get_priv(data->hdev);
> +       u8 hw_variant =3D INTEL_HW_VARIANT(cnvi_data->cnvi_bt);
> +
> +       if (!data->debug_table_size || !data->debug_table_addr)
> +               return -EINVAL;
> +
> +       buffer_len =3D data->debug_table_size;
> +
> +       buffer =3D vmalloc(buffer_len);
> +       if (!buffer)
> +               return -ENOMEM;
> +
> +       btintel_pcie_mac_init(data);
> +
> +       err =3D btintel_pcie_read_device_mem(data, buffer, data->debug_ta=
ble_addr,
> +                                          buffer_len);
> +       if (err)
> +               goto exit_on_error;
> +
> +       print_hex_dump_debug("dump_info: ", DUMP_PREFIX_OFFSET, 16, 1,
> +                            buffer, buffer_len, false);
> +
> +       ptr =3D buffer;
> +       remaining =3D buffer_len;
> +
> +       /* Parse TLV structures: 1 byte type + 2 bytes length + variable =
value */
> +       while (remaining >=3D sizeof(struct mbox_tlv)) {
> +               u16 tlv_len;
> +               u32 tlv_total;
> +
> +               tlv =3D (struct mbox_tlv *)ptr;
> +               tlv_len =3D le16_to_cpu(tlv->len);
> +               tlv_total =3D sizeof(tlv->type) + sizeof(tlv->len) + tlv_=
len;
> +
> +               if (tlv_total > remaining) {
> +                       bt_dev_err(data->hdev, "TLV parse error: not enou=
gh data for TLV value (type=3D%u, len=3D%u)",
> +                                  tlv->type, tlv_len);
> +                       break;
> +               }
> +
> +               switch (tlv->type) {
> +               case BTINTEL_PCIE_TLV_TYPE_EXCEPTION_DUMP_ADDRESS:
> +                       if (tlv_len < 8) {
> +                               bt_dev_err(data->hdev,
> +                                          "TLV %s too short: len=3D%u (n=
eed 8)",
> +                                          btintel_pcie_dumptype_to_str(d=
ata->hdev,
> +                                                                       t=
lv->type),
> +                                          tlv_len);
> +                               break;
> +                       }
> +                       data->dump_info.exception_dump_addr =3D get_unali=
gned_le32(&tlv->val[0]);
> +                       data->dump_info.exception_dump_len =3D get_unalig=
ned_le32(&tlv->val[4]);
> +                       break;
> +               case BTINTEL_PCIE_TLV_TYPE_DCCM_MEM_ADDRESS:
> +                       if (tlv_len < 8) {
> +                               bt_dev_err(data->hdev,
> +                                          "TLV %s too short: len=3D%u (n=
eed 8)",
> +                                          btintel_pcie_dumptype_to_str(d=
ata->hdev,
> +                                                                       t=
lv->type),
> +                                          tlv_len);
> +                               break;
> +                       }
> +                       data->dump_info.dccm_addr_start =3D get_unaligned=
_le32(&tlv->val[0]);
> +                       data->dump_info.dccm_addr_end =3D get_unaligned_l=
e32(&tlv->val[4]);
> +                       break;
> +               case BTINTEL_PCIE_TLV_TYPE_SDS_MEM_ADDRESS:
> +                       if (tlv_len =3D=3D 16 && hw_variant > BTINTEL_HWI=
D_BZRI) {
> +                               data->dump_info.sds_start_addr_start =3D
> +                                       get_unaligned_le32(&tlv->val[0]);
> +                               data->dump_info.sds_start_addr_end =3D
> +                                       get_unaligned_le32(&tlv->val[4]);
> +                               data->dump_info.sds_iosf_data_addr_start =
=3D
> +                                       get_unaligned_le32(&tlv->val[8]);
> +                               data->dump_info.sds_iosf_data_addr_end =
=3D
> +                                       get_unaligned_le32(&tlv->val[12])=
;
> +                       } else if (tlv_len =3D=3D 24 && (hw_variant =3D=
=3D BTINTEL_HWID_BZRI ||
> +                                                    hw_variant =3D=3D BT=
INTEL_HWID_BZRIW)) {
> +                               data->dump_info.sds_fixed_rom_addr_start =
=3D
> +                                       get_unaligned_le32(&tlv->val[0]);
> +                               data->dump_info.sds_fixed_rom_addr_end =
=3D
> +                                       get_unaligned_le32(&tlv->val[4]);
> +                               data->dump_info.sds_start_addr_start =3D
> +                                       get_unaligned_le32(&tlv->val[8]);
> +                               data->dump_info.sds_start_addr_end =3D
> +                                       get_unaligned_le32(&tlv->val[12])=
;
> +                               data->dump_info.sds_iosf_data_addr_start =
=3D
> +                                       get_unaligned_le32(&tlv->val[16])=
;
> +                               data->dump_info.sds_iosf_data_addr_end =
=3D
> +                                       get_unaligned_le32(&tlv->val[20])=
;
> +                       } else {
> +                               bt_dev_err(data->hdev, "SDS TLV: unsuppor=
ted hw_variant=3D0x%02x len=3D%u",
> +                                          hw_variant, tlv_len);
> +                       }
> +                       break;
> +               case BTINTEL_PCIE_TLV_TYPE_ECL_MEM_ADDRESS:
> +                       if (tlv_len < 8) {
> +                               bt_dev_err(data->hdev,
> +                                          "TLV %s too short: len=3D%u (n=
eed 8)",
> +                                          btintel_pcie_dumptype_to_str(d=
ata->hdev,
> +                                                                       t=
lv->type),
> +                                          tlv_len);
> +                               break;
> +                       }
> +                       data->dump_info.ecl_addr_start =3D get_unaligned_=
le32(&tlv->val[0]);
> +                       data->dump_info.ecl_addr_end =3D get_unaligned_le=
32(&tlv->val[4]);
> +                       break;
> +               case BTINTEL_PCIE_TLV_TYPE_SMEM_ADDRESS:
> +                       if (tlv_len < 8) {
> +                               bt_dev_err(data->hdev,
> +                                          "TLV %s too short: len=3D%u (n=
eed 8)",
> +                                          btintel_pcie_dumptype_to_str(d=
ata->hdev,
> +                                                                       t=
lv->type),
> +                                          tlv_len);
> +                               break;
> +                       }
> +                       data->dump_info.smem_addr_start =3D get_unaligned=
_le32(&tlv->val[0]);
> +                       data->dump_info.smem_addr_end =3D get_unaligned_l=
e32(&tlv->val[4]);
> +                       break;
> +               default:
> +                       bt_dev_dbg(data->hdev, "Unknown TLV type: %u leng=
th: %u",
> +                                  tlv->type, tlv_len);
> +                       break;
> +               }
> +
> +               /* Move to next TLV */
> +               ptr +=3D tlv_total;
> +               remaining -=3D tlv_total;
> +       }
> +
> +       bt_dev_info(data->hdev,
> +                   "exception_dump: addr:0x%08x len:0x%08x",
> +                   data->dump_info.exception_dump_addr,
> +                   data->dump_info.exception_dump_len);
> +       bt_dev_info(data->hdev,
> +                   "dccm: start:0x%08x end:0x%08x",
> +                   data->dump_info.dccm_addr_start,
> +                   data->dump_info.dccm_addr_end);
> +       bt_dev_info(data->hdev,
> +                   "sds_fixed_rom: start:0x%08x end:0x%08x",
> +                   data->dump_info.sds_fixed_rom_addr_start,
> +                   data->dump_info.sds_fixed_rom_addr_end);
> +       bt_dev_info(data->hdev,
> +                   "sds: start:0x%08x end:0x%08x",
> +                   data->dump_info.sds_start_addr_start,
> +                   data->dump_info.sds_start_addr_end);
> +       bt_dev_info(data->hdev,
> +                   "sds_iosf: start:0x%08x end:0x%08x",
> +                   data->dump_info.sds_iosf_data_addr_start,
> +                   data->dump_info.sds_iosf_data_addr_end);
> +       bt_dev_info(data->hdev,
> +                   "ecl: start:0x%08x end:0x%08x",
> +                   data->dump_info.ecl_addr_start,
> +                   data->dump_info.ecl_addr_end);
> +       bt_dev_info(data->hdev,
> +                   "smem: start:0x%08x end:0x%08x",
> +                   data->dump_info.smem_addr_start,
> +                   data->dump_info.smem_addr_end);

Not much of a fan to use bt_dev_info to dump memory containts like
this, actually why is this not sent as a devcoredump?

> +
> +       vfree(buffer);
> +       return 0;
> +
> +exit_on_error:
> +       vfree(buffer);
> +       return err;
> +}
> +
>  static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data=
)
>  {
> -       bt_dev_err(data->hdev, "Received gp1 mailbox interrupt");
> -       btintel_pcie_dump_debug_registers(data->hdev);
> +       bool target_access =3D false;
> +       ktime_t calltime, delta, rettime;
> +       unsigned long long duration;
> +
> +       calltime =3D ktime_get();
> +
> +       /* Read the Mail box status and registers */
> +       data->mbox.mbox_status =3D btintel_pcie_rd_reg32(data, BTINTEL_PC=
IE_CSR_MBOX_STATUS_REG);
> +       if (data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX1) =
{
> +               data->mbox.mbox1 =3D btintel_pcie_rd_reg32(data,
> +                                                        BTINTEL_PCIE_CSR=
_MBOX_1_REG);
> +               if (data->mbox.mbox1 =3D=3D BTINTEL_PCIE_BUILD_SPECIFIC_R=
ESOURCES_MAPPING) {
> +                       bt_dev_info(data->hdev, "mailbox for target acces=
s");
> +                       target_access =3D true;
> +               }
> +       }
> +
> +       if (data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX2) =
{
> +               data->mbox.mbox2 =3D btintel_pcie_rd_reg32(data,
> +                                                        BTINTEL_PCIE_CSR=
_MBOX_2_REG);
> +               if (target_access)
> +                       data->debug_table_addr =3D data->mbox.mbox2;
> +       }
> +
> +       if (data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX3) =
{
> +               data->mbox.mbox3 =3D btintel_pcie_rd_reg32(data,
> +                                                        BTINTEL_PCIE_CSR=
_MBOX_3_REG);
> +               if (target_access)
> +                       data->debug_table_size =3D data->mbox.mbox3;
> +       }
> +
> +       if (data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX4) =
{
> +               data->mbox.mbox4 =3D btintel_pcie_rd_reg32(data,
> +                                                        BTINTEL_PCIE_CSR=
_MBOX_4_REG);
> +       }
> +
> +       bt_dev_err(data->hdev, "GP1_handler: mbox status: 0x%8.8x mbox_1:=
 0x%8.8x mbox_2: 0x%8.8x mbox_3: 0x%8.8x mbox_4: 0x%8.8x",
> +                  data->mbox.mbox_status, data->mbox.mbox1, data->mbox.m=
box2,
> +                  data->mbox.mbox3, data->mbox.mbox4);

Ok, this is definitely not within 80 columns. You know we still have
use max 80 columns for the Bluetooth subsystem right?

> +       if (target_access && !test_and_set_bit(BTINTEL_PCIE_MAIL_BOX_INTR=
, &data->flags)) {
> +               if (!queue_work(data->dump_workqueue, &data->mbox_work))
> +                       clear_bit(BTINTEL_PCIE_MAIL_BOX_INTR, &data->flag=
s);
> +       }
> +
> +       /* Mailbox is read, ack to FW */
> +       btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_IPC_DOORBELL_VEC=
_REG,
> +                                 BTINTEL_PCIE_CSR_DOORBELL_MBOX_READ_CON=
FIRM);
> +
> +       rettime =3D ktime_get();
> +       delta =3D ktime_sub(rettime, calltime);
> +       duration =3D (unsigned long long)ktime_to_ns(delta) >> 10;
> +       bt_dev_info(data->hdev, "Mailbox acked in %llu usecs", duration);
>  }
>
>  /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
> @@ -1307,23 +2126,25 @@ static void btintel_pcie_read_hwexp(struct btinte=
l_pcie_data *data)
>                 /* only from step B0 onwards */
>                 if (INTEL_CNVX_TOP_STEP(data->dmp_hdr.cnvi_top) !=3D 0x01=
)
>                         return;
> -               len =3D BTINTEL_PCIE_BLZR_HWEXP_SIZE; /* exception data l=
ength */
> -               addr =3D BTINTEL_PCIE_BLZR_HWEXP_DMP_ADDR;
>                 break;
>         case BTINTEL_CNVI_SCP:
> -               len =3D BTINTEL_PCIE_SCP_HWEXP_SIZE;
> -               addr =3D BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR;
> -               break;
>         case BTINTEL_CNVI_SCP2:
>         case BTINTEL_CNVI_SCP2F:
> -               len =3D BTINTEL_PCIE_SCP2_HWEXP_SIZE;
> -               addr =3D BTINTEL_PCIE_SCP2_HWEXP_DMP_ADDR;
>                 break;
>         default:
>                 bt_dev_err(data->hdev, "Unsupported cnvi 0x%8.8x", data->=
dmp_hdr.cnvi_top);
>                 return;
>         }
>
> +       len =3D data->dump_info.exception_dump_len;
> +       addr =3D data->dump_info.exception_dump_addr;
> +
> +       if (!addr || !len) {
> +               bt_dev_err(data->hdev, "Invalid exception address: 0x%8.8=
x or length: %d",
> +                          addr, len);
> +               return;
> +       }
> +
>         buf =3D kzalloc(len, GFP_KERNEL);
>         if (!buf)
>                 goto exit_on_error;
> @@ -1576,6 +2397,20 @@ static void btintel_pcie_fwtrigger_worker(struct w=
ork_struct *work)
>         clear_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags);
>  }
>
> +static void btintel_pcie_mbox_worker(struct work_struct *work)
> +{
> +       struct btintel_pcie_data *data =3D container_of(work,
> +                                       struct btintel_pcie_data, mbox_wo=
rk);
> +
> +       if (!data->hdev)
> +               goto out;
> +
> +       btintel_parse_mbox_tlv(data);
> +out:
> +       /* Release guard last; matches set in gp1 handler. */
> +       clear_bit(BTINTEL_PCIE_MAIL_BOX_INTR, &data->flags);
> +}
> +
>  static void btintel_pcie_rx_work(struct work_struct *work)
>  {
>         struct btintel_pcie_data *data =3D container_of(work,
> @@ -1886,9 +2721,16 @@ static void btintel_pcie_init_ci(struct btintel_pc=
ie_data *data,
>         ci->num_urbdq1 =3D data->rxq.count;
>         ci->urbdq_db_vec =3D BTINTEL_PCIE_RXQ_NUM;
>
> -       ci->dbg_output_mode =3D 0x01;
> -       ci->dbgc_addr =3D data->dbgc.frag_p_addr;
> -       ci->dbgc_size =3D data->dbgc.frag_size;
> +       ci->dbg_output_mode =3D BTINTEL_PCIE_DRAM;
> +
> +       if (btintel_pcie_is_mdbgc_supported(data)) {
> +               ci->dbgc_addr =3D data->mdbgc.frag_p_addr;
> +               ci->dbgc_size =3D data->mdbgc.frag_size;
> +       } else {
> +               ci->dbgc_addr =3D data->dbgc.frag_p_addr;
> +               ci->dbgc_size =3D data->dbgc.frag_size;
> +       }
> +
>         ci->dbg_preset =3D 0x00;
>  }
>
> @@ -2116,7 +2958,10 @@ static int btintel_pcie_alloc(struct btintel_pcie_=
data *data)
>         v_addr +=3D ci_size;
>
>         /* Setup data buffers for dbgc */
> -       err =3D btintel_pcie_setup_dbgc(data);
> +       if (btintel_pcie_is_mdbgc_supported(data))
> +               err =3D btintel_pcie_setup_mdbgc(data);
> +       else
> +               err =3D btintel_pcie_setup_dbgc(data);
>         if (err)
>                 goto exit_error_txq;
>
> @@ -2380,6 +3225,7 @@ static int btintel_pcie_setup_internal(struct hci_d=
ev *hdev)
>                 goto exit_error;
>         }
>
> +       data->dmp_hdr.cnvi_bt =3D ver_tlv.cnvi_bt;
>         switch (INTEL_HW_PLATFORM(ver_tlv.cnvi_bt)) {
>         case 0x37:
>                 break;
> @@ -2433,7 +3279,6 @@ static int btintel_pcie_setup_internal(struct hci_d=
ev *hdev)
>         data->dmp_hdr.fw_timestamp =3D ver_tlv.timestamp;
>         data->dmp_hdr.fw_build_type =3D ver_tlv.build_type;
>         data->dmp_hdr.fw_build_num =3D ver_tlv.build_num;
> -       data->dmp_hdr.cnvi_bt =3D ver_tlv.cnvi_bt;
>
>         if (ver_tlv.img_type =3D=3D 0x02 || ver_tlv.img_type =3D=3D 0x03)
>                 data->dmp_hdr.fw_git_sha1 =3D ver_tlv.git_sha1;
> @@ -2718,6 +3563,7 @@ static void btintel_pcie_reset_work(struct work_str=
uct *wk)
>         disable_work_sync(&data->coredump_work);
>         disable_work_sync(&data->hwexp_work);
>         disable_work_sync(&data->fwtrigger_work);
> +       disable_work_sync(&data->mbox_work);
>
>         bt_dev_dbg(data->hdev, "Release bluetooth interface");
>
> @@ -2742,6 +3588,7 @@ static void btintel_pcie_reset_work(struct work_str=
uct *wk)
>                 enable_work(&data->coredump_work);
>                 enable_work(&data->hwexp_work);
>                 enable_work(&data->fwtrigger_work);
> +               enable_work(&data->mbox_work);
>         }
>
>  out:
> @@ -2948,6 +3795,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
>         INIT_WORK(&data->coredump_work, btintel_pcie_coredump_worker);
>         INIT_WORK(&data->hwexp_work, btintel_pcie_hwexp_worker);
>         INIT_WORK(&data->fwtrigger_work, btintel_pcie_fwtrigger_worker);
> +       INIT_WORK(&data->mbox_work, btintel_pcie_mbox_worker);
>
>         data->boot_stage_cache =3D 0x00;
>         data->img_resp_cache =3D 0x00;
> @@ -3017,6 +3865,7 @@ static void btintel_pcie_remove(struct pci_dev *pde=
v)
>         disable_work_sync(&data->coredump_work);
>         disable_work_sync(&data->hwexp_work);
>         disable_work_sync(&data->fwtrigger_work);
> +       disable_work_sync(&data->mbox_work);
>
>         /* Cancel pending reset work. Skip only when remove() is called f=
rom
>          * within the reset work itself (PLDR device_reprobe path) to avo=
id
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel=
_pcie.h
> index 749369b24031..93aaa1d1e187 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -23,6 +23,8 @@
>  #define BTINTEL_PCIE_CSR_MBOX_3_REG            (BTINTEL_PCIE_CSR_BASE + =
0x178)
>  #define BTINTEL_PCIE_CSR_MBOX_4_REG            (BTINTEL_PCIE_CSR_BASE + =
0x17C)
>  #define BTINTEL_PCIE_CSR_MBOX_STATUS_REG       (BTINTEL_PCIE_CSR_BASE + =
0x180)
> +#define BTINTEL_PCIE_CSR_IPC_DOORBELL_VEC_REG  (BTINTEL_PCIE_CSR_BASE + =
0x130)
> +#define BTINTEL_PCIE_CSR_DOORBELL_MBOX_READ_CONFIRM    (BIT(4))
>  #define BTINTEL_PCIE_PRPH_DEV_ADDR_REG         (BTINTEL_PCIE_CSR_BASE + =
0x440)
>  #define BTINTEL_PCIE_PRPH_DEV_RD_REG           (BTINTEL_PCIE_CSR_BASE + =
0x458)
>  #define BTINTEL_PCIE_CSR_HBUS_TARG_WRPTR       (BTINTEL_PCIE_CSR_BASE + =
0x460)
> @@ -67,15 +69,26 @@
>  #define BTINTEL_PCIE_DBGC_BASE_ADDR                    (0xf3800300)
>  #define BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS           (BTINTEL_PCIE_DBG=
C_BASE_ADDR + 0x1C)
>  #define BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND            (BTINTEL_PCIE_DBG=
C_BASE_ADDR + 0x2C)
> +#define BTINTEL_PCIE_DBGC_IF_BASE_ADDR                 (BTINTEL_PCIE_DBG=
C_BASE_ADDR + 0x30)
> +#define BTINTEL_PCIE_DBGC_IF_SIZE                      (BTINTEL_PCIE_DBG=
C_BASE_ADDR + 0x34)
> +
> +#define BTINTEL_PCIE_SMEM_BASE_ADDR                    (0xf4000000)
> +#define BTINTEL_PCIE_SMEM_END_ADDR                     (BTINTEL_PCIE_SME=
M_BASE_ADDR + 0x4000)
> +
> +#define BTINTEL_PCIE_DBGC_BASE_ADDR_BZRI       (0xf3800300)
>
>  #define BTINTEL_PCIE_DBGC_BASE_ADDR_SCP                        (0xf0d5d5=
00)
>  #define BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS_SCP       (BTINTEL_PCIE_DBG=
C_BASE_ADDR_SCP + 0x1C)
>  #define BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND_SCP                (BTINTEL_=
PCIE_DBGC_BASE_ADDR_SCP + 0x2C)
>
> +#define BTINTEL_PCIE_SMEM_FRAGMENT_OFFSET      4
> +#define BTINTEL_PCIE_SMEM_MAX_SIZE             (16 * 1024)
>  #define BTINTEL_PCIE_DBG_IDX_BIT_MASK          0x0F
>  #define BTINTEL_PCIE_DBGC_DBG_BUF_IDX(data)    (((data) >> 24) & BTINTEL=
_PCIE_DBG_IDX_BIT_MASK)
>  #define BTINTEL_PCIE_DBG_OFFSET_BIT_MASK       0xFFFFFF
>
> +#define BTINTEL_PCIE_TARGET_ACCESS_FRAG_OFFSET 4
> +
>  /* The DRAM buffer count, each buffer size, and
>   * fragment buffer size
>   */
> @@ -91,6 +104,27 @@
>  /* Num of alloc Dbg buff (4) + (LSB(4), MSB(4), Size(4)) for each buffer=
 */
>  #define BTINTEL_PCIE_DBGC_FRAG_PAYLOAD_SIZE    196
>
> +#define BTINTEL_PCIE_MDBGC_FRAG_VERSION                2
> +#define BTINTEL_PCIE_MDBGC_TOTAL_BUFFER_COUNT  (16 * 3)
> +
> +#define BTINTEL_PCIE_MDBGC_ALLOCATIONID_1              0
> +#define BTINTEL_PCIE_MDBGC_ALLOCATIONID_2              1
> +#define BTINTEL_PCIE_MDBGC_ALLOCATIONID_3              2
> +
> +/* Magic number(4), version(4), size of payload length(4) */
> +#define BTINTEL_PCIE_MDBGC_FRAG_HEADER_SIZE            12
> +
> +/* Num of alloc Dbg buff (4) + (LSB(4), MSB(4), Size(4)) for each buffer=
 */
> +#define BTINTEL_PCIE_MDBGC_FRAG_PAYLOAD_SIZE   196
> +
> +#define BTINTEL_PCIE_DEVICE_ID_NVL_S_SCP2      0x6E74
> +#define BTINTEL_PCIE_DEVICE_ID_NVL_Hx_SCP2     0xD346
> +#define BTINTEL_PCIE_DEVICE_ID_PTL_FMP2                0xE476
> +
> +#define BTINTEL_PCIE_SMEM      0x00
> +#define BTINTEL_PCIE_DRAM      0x01
> +#define BTINTEL_PCIE_FW_MON_MODE_DRAM  0x02
> +
>  /* Causes for the FH register interrupts */
>  enum msix_fh_int_causes {
>         BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0       =3D BIT(0),       /* caus=
e 0 */
> @@ -121,7 +155,8 @@ enum {
>         BTINTEL_PCIE_COREDUMP_INPROGRESS,
>         BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS,
>         BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
> -       BTINTEL_PCIE_SETUP_DONE
> +       BTINTEL_PCIE_SETUP_DONE,
> +       BTINTEL_PCIE_MAIL_BOX_INTR
>  };
>
>  enum btintel_pcie_tlv_type {
> @@ -137,7 +172,20 @@ enum btintel_pcie_tlv_type {
>         BTINTEL_VENDOR,
>         BTINTEL_DRIVER,
>         BTINTEL_EVENT_TYPE,
> -       BTINTEL_EVENT_ID
> +       BTINTEL_EVENT_ID,
> +       BTINTEL_DRAM_REGION,
> +       BTINTEL_SMEM_REGION,
> +       BTINTEL_DCCM_BASE_ADDR,
> +       BTINTEL_DCCM_REGION,
> +       BTINTEL_SDS_BASE_ADDR,
> +       BTINTEL_SDS_REGION,
> +       BTINTEL_SDS_IOSF_BASE_ADDR,
> +       BTINTEL_SDS_IOSF_DATA_REGION,
> +       BTINTEL_SDS_FIXED_ROM_BASE_ADDR,
> +       BTINTEL_SDS_FIXED_ROM_REGION,
> +       BTINTEL_EXCEPTION_EVT_DEBUG_REGION,
> +       BTINTEL_ECL_BASE_ADDR,
> +       BTINTEL_ECL_REGION
>  };
>
>  /* causes for the MBOX interrupts */
> @@ -153,6 +201,14 @@ enum btintel_pcie_reset_type {
>         BTINTEL_PCIE_IOSF_PRR_PLDR =3D 1,
>  };
>
> +enum btintel_pcie_mbox_msg {
> +       BTINTEL_PCIE_NO_USE =3D 0,
> +       BTINTEL_PCIE_TOP_SILENT_RESET,
> +       BTINTEL_PCIE_SB_AUDIO_DEVICE_REPORT,
> +       BTINTEL_PCIE_BUILD_SPECIFIC_RESOURCES_MAPPING,
> +       BTINTEL_PCIE_LAST_MESSAGE =3D 4095 /* 0xFFF=3D 0x100-0x1 */
> +};
> +
>  #define BTINTEL_PCIE_MSIX_NON_AUTO_CLEAR_CAUSE BIT(7)
>
>  /* Minimum and Maximum number of MSI-X Vector
> @@ -198,6 +254,12 @@ enum {
>  /* RBD buffer size mapping */
>  #define BTINTEL_PCIE_RBD_SIZE_4K       0x04
>
> +#define BTINTEL_PCIE_TLV_TYPE_EXCEPTION_DUMP_ADDRESS  0x04
> +#define BTINTEL_PCIE_TLV_TYPE_DCCM_MEM_ADDRESS        0x05
> +#define BTINTEL_PCIE_TLV_TYPE_SDS_MEM_ADDRESS         0x06
> +#define BTINTEL_PCIE_TLV_TYPE_ECL_MEM_ADDRESS         0x07
> +#define BTINTEL_PCIE_TLV_TYPE_SMEM_ADDRESS           0x08
> +
>  /*
>   * Struct for Context Information (v2)
>   *
> @@ -424,6 +486,62 @@ struct btintel_pcie_dbgc {
>         struct data_buf *bufs;
>  };
>
> +struct btintel_pcie_mdbgc {
> +       u32             count;
> +
> +       void            *frag_v_addr;
> +       dma_addr_t      frag_p_addr;
> +       u32             frag_size;
> +
> +       dma_addr_t      buf1_p_addr;
> +       void            *buf1_v_addr;
> +       dma_addr_t      buf2_p_addr;
> +       void            *buf2_v_addr;
> +       dma_addr_t      buf3_p_addr;
> +       void            *buf3_v_addr;
> +       struct data_buf *buf1;
> +       struct data_buf *buf2;
> +       struct data_buf *buf3;
> +};
> +
> +/* Structure for packing dump to decoder
> + * @type: TLV type
> + * @len: The length of TLV is u32 as agreed with decoder to accomadate l=
arger
> + * dumps
> + * @val: TLV value
> + */
> +struct intel_pcie_tlv {
> +       u8 type;
> +       u32 len;
> +       u8 val[];
> +} __packed;
> +
> +struct btintel_pcie_dump_mem_info {
> +       u32     exception_dump_addr;
> +       u32     exception_dump_len;
> +       u32     dccm_addr_start;
> +       u32     dccm_addr_end;
> +       u32     sds_fixed_rom_addr_start;
> +       u32     sds_fixed_rom_addr_end;
> +       u32     sds_start_addr_start;
> +       u32     sds_start_addr_end;
> +       u32     sds_iosf_data_addr_start;
> +       u32     sds_iosf_data_addr_end;
> +       u32     ecl_addr_start;
> +       u32     ecl_addr_end;
> +       u32     smem_addr_start;
> +       u32     smem_addr_end;
> +};
> +
> +struct btintel_pcie_mbox {
> +       u32 mbox_flags;
> +       u32 mbox_status;
> +       u32 mbox1;
> +       u32 mbox2;
> +       u32 mbox3;
> +       u32 mbox4;
> +};
> +
>  struct btintel_pcie_dump_header {
>         const char      *driver_name;
>         u32             cnvi_top;
> @@ -441,6 +559,145 @@ struct btintel_pcie_dump_header {
>         u16             event_id;
>  };
>
> +/* Per-fragment range descriptor for dump regions.
> + * Binary-compatible with iwl_fw_ini_error_dump_range.
> + */
> +struct btintel_pcie_dump_range {
> +       __le32  range_data_size;
> +       union {
> +               __le32  internal_base_addr;
> +               __le64  dram_base_addr;
> +               __le32  page_num;
> +       };
> +       __le32  data[];
> +} __packed;
> +
> +/*
> + * INI region types for ini_dump_data.type field.
> + * The unified decoder dispatches parsing logic based on these values.
> + */
> +#define BTINTEL_PCIE_INI_REGION_INTERNAL_BUFFER        2
> +#define BTINTEL_PCIE_INI_REGION_DRAM_BUFFER    3
> +#define BTINTEL_PCIE_INI_REGION_DEVICE_MEMORY  9
> +
> +/* INI region IDs - used in dump header region_id field and regions_mask=
 */
> +#define BTINTEL_PCIE_INI_ID_EXCEPTION_EVT      7
> +#define BTINTEL_PCIE_INI_ID_SMEM               15
> +#define BTINTEL_PCIE_INI_ID_DCCM               39
> +#define BTINTEL_PCIE_INI_ID_SDS                        40
> +#define BTINTEL_PCIE_INI_ID_SDS_IOSF           41
> +#define BTINTEL_PCIE_INI_ID_ECL                        42
> +#define BTINTEL_PCIE_INI_ID_DRAM_MONITOR3      61
> +#define BTINTEL_PCIE_INI_ID_DRAM_MONITOR2      62
> +#define BTINTEL_PCIE_INI_ID_DRAM_MONITOR1      63
> +
> +/*
> + * INI (Intel INI debug infrastructure) style dump data TLV - wraps each=
 dump
> + * region. INI is the iwlwifi firmware debug format used by the unified =
decoder.
> + * Compatible with iwl_fw_ini_error_dump_data.
> + */
> +struct btintel_pcie_ini_dump_data {
> +       u8      type;
> +       u8      sub_type;
> +       u8      sub_type_ver;
> +       u8      reserved;
> +       __le32  len;
> +       u8      data[];
> +} __packed;
> +
> +/*
> + * INI-style region dump header.
> + * Compatible with iwl_fw_ini_error_dump_header.
> + */
> +#define BTINTEL_PCIE_INI_MAX_NAME      32
> +#define BTINTEL_PCIE_INI_DUMP_VER      1
> +
> +struct btintel_pcie_ini_dump_header {
> +       __le32  version;
> +       __le32  region_id;
> +       __le32  num_of_ranges;
> +       __le32  name_len;
> +       u8      name[BTINTEL_PCIE_INI_MAX_NAME];
> +};
> +
> +/*
> + * INI-style monitor dump - region header + monitor state.
> + * Compatible with iwl_fw_ini_monitor_dump.
> + */
> +struct btintel_pcie_ini_monitor_dump {
> +       struct btintel_pcie_ini_dump_header header;
> +       __le32  write_ptr;
> +       __le32  cycle_cnt;
> +       __le32  cur_frag;
> +       u8      data[];
> +} __packed;
> +
> +/* Linked list entry for modular dump collection */
> +struct btintel_pcie_dump_entry {
> +       struct list_head        list;
> +       u32                     size;
> +       u8                      data[];
> +};
> +
> +/* File-level header for coredump output.
> + * Compatible with iwl_fw_ini_dump_file_hdr.
> + * Uses IWL_FW_INI_ERROR_DUMP_BARKER (0x14789633) for decoder compatibil=
ity.
> + */
> +#define BTINTEL_PCIE_INI_ERROR_DUMP_BARKER     0x14789633
> +
> +struct btintel_pcie_dump_file_hdr {
> +       __le32  barker;
> +       __le32  file_len;
> +} __packed;
> +
> +/*
> + * Legacy-style dump data wrapper for dump info TLV.
> + * Compatible with iwl_fw_error_dump_data.
> + * Used only for the dump info entry (type=3DBTINTEL_PCIE_INI_DUMP_INFO_=
TYPE).
> + */
> +struct btintel_pcie_error_dump_data {
> +       __le32  type;
> +       __le32  len;
> +       u8      data[];
> +} __packed;
> +
> +/* Use bit 31 as dump info type, matching IWL_INI_DUMP_INFO_TYPE */
> +#define BTINTEL_PCIE_INI_DUMP_INFO_TYPE        BIT(31)
> +
> +/* Time point values matching iwl_fw_ini_time_point for fwdump parser */
> +#define BTINTEL_PCIE_TIME_POINT_FW_ASSERT      4
> +#define BTINTEL_PCIE_TIME_POINT_USER_TRIGGER   9
> +
> +/*
> + * Dump info struct - single TLV containing all metadata.
> + * Compatible with iwl_fw_ini_dump_info.
> + * Packs all device/firmware info that the decoder needs.
> + */
> +struct btintel_pcie_ini_dump_info {
> +       __le32  version;
> +       __le32  time_point;
> +       __le32  trigger_reason;
> +       __le32  external_cfg_state;
> +       __le32  ver_type;
> +       __le32  ver_subtype;
> +       __le32  hw_step;
> +       __le32  hw_type;
> +       __le32  rf_id_flavor;
> +       __le32  rf_id_dash;
> +       __le32  rf_id_step;
> +       __le32  rf_id_type;
> +       __le32  lmac_major;
> +       __le32  lmac_minor;
> +       __le32  umac_major;
> +       __le32  umac_minor;
> +       __le32  fw_mon_mode;
> +       __le64  regions_mask;
> +       __le32  build_tag_len;
> +       u8      build_tag[64];
> +       __le32  num_of_cfg_names;
> +       /* no cfg_names for BT - keep zero-length */
> +} __packed;
> +
>  /* struct btintel_pcie_data
>   * @pdev: pci device
>   * @hdev: hdev device
> @@ -522,6 +779,7 @@ struct btintel_pcie_data {
>         struct work_struct      coredump_work;
>         struct work_struct      hwexp_work;
>         struct work_struct      fwtrigger_work;
> +       struct work_struct      mbox_work;
>
>         struct dma_pool *dma_pool;
>         dma_addr_t      dma_p_addr;
> @@ -535,10 +793,15 @@ struct btintel_pcie_data {
>         u32     alive_intr_ctxt;
>         enum btintel_pcie_reset_type    reset_type;
>         struct btintel_pcie_dbgc        dbgc;
> +       struct btintel_pcie_mdbgc       mdbgc;
>         struct btintel_pcie_dump_header dmp_hdr;
>         u8      pm_sx_event;
>         u32     debug_evt_addr;
>         u32     debug_evt_size;
> +       dma_addr_t      debug_table_addr;
> +       u32     debug_table_size;
> +       struct btintel_pcie_dump_mem_info       dump_info;
> +       struct btintel_pcie_mbox        mbox;
>  };
>
>  static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
