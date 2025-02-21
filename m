Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8174BED
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150197; cv=none; b=hTQ+5fhROkTzUdrWHzPABiKiMsfov+j9iPWqmTbZ4jI0ZuTTZnGOYwbkvFoq/97svrlEctJ7YrPyogbC9Um7BE2m/haBC6E7w8/LmxyANDHk60P04ZrkT9DR1JB2wM3yfd4NYv1CUVXBfSctICBzK9dv0JfYbVm9KwbYtKS+RlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150197; c=relaxed/simple;
	bh=j5dSPsn2W+GzfOt4wmqRyERK3y1MsaKCLt+2qKQmn0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLhNTMbY1n7YTR9HIUHXVgUZiM5dfx9tmkK0K+gn3l+OOXHUXc0j/WgpNXrnrSlRx/DNnR7u3TMjotkl6CF/BjByrj3QyCRWrmDqjHNLTX1CMt2p0Xm5spyxsMhiIPGVxMUPzwI9ISAsnOvhlWfuc13pUzNHRY77V9bjwc1vfuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQ07AWZb; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ07AWZb"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30797730cbdso21711771fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 07:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740150192; x=1740754992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVlcXUyrNhRii5I3F36TXZNkg9lgLdmv11rVWve0sYM=;
        b=NQ07AWZb/Iqg1rTDz9Z54n/oVn1K+XSX5k2ZiJp8+Sr9Y9DmbOyOhHsrOt3mf6zDWK
         dzMpVlYBrlbvOdcTwPlBY8+3ePV3107iGfjQmGk2VfCeJAMRYR4qdnCpDt9Du1X8Dt2q
         OUsWZB5QZE1pkfr5Hrza3lLSYSL5w/w2Ibq1cqeYhRZs5sF7535r0oHYODJl3XFLxh7M
         NQrg53KiX4V6Em87ItMc3beXbc+9MguaYLQrTf3GClZHS6VSfZTBx/QedaZUUrDpWtvi
         Hbd+LeAxsSPujbYraCV8/hW/841dFCGRhbuRIl/bRrO39BK2Mmn3+6PMm4tm/dqQLTl5
         rWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740150192; x=1740754992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVlcXUyrNhRii5I3F36TXZNkg9lgLdmv11rVWve0sYM=;
        b=aKZNxMIoAgfCqiVYI0dCt/yA2i3b75uu8mT0iIuNXb48/O8gtX0slX+wNoavCht7d6
         kxXeufvu7z1ICKLiLwh1JqaY5hOcb1fw4w3Q5zzUt0kroW5Uh1Nn9siyTDxCMiXsip84
         o0MySmp2z4DYH+ARp3fcqTsezH9K4cUhs83cSZ8wCMJxnl1JYNAO0kKbVvLm1efkGXRV
         f8cIR3k2BTCDJf1oDPAeMQdq0pPLhq4knVUFUDzP2dKMsQdT3jXDnaIA2C1GbIUg7N5i
         /K80st5rpRTh6PAfjKKiQzMH/Jvzp2k94QwibOaYpQQBWC/ejjUpvogtkxJp5DEbPilJ
         M8ww==
X-Gm-Message-State: AOJu0YzlZPaELLEWdkGZVWfzMxnNVqIt5JHNAa2uVJpURwLt16tCD5n1
	h9NfTx01bxg23LgTq80yypgRb179cZVYpaNfhm7udQwPKwVRESILeOKEkbfS2VzjjglWfQg+/p9
	8DXvXFSdKVo2Jayk4JjKyvFz6EDJkOJJ7
X-Gm-Gg: ASbGncsZ7Lh9lAyzt07vpOAefDlW0X3RygHINK6s32ampUFhoalrIeWCeaZhPA5xo6x
	/1C8xvFy+11GxTznxch21JBYI1VAnKPw8WQcyVPPo4dToXvs6fhzjkvoKZJFy7Imj1+x+CtK+Tc
	hPrK33YufK
X-Google-Smtp-Source: AGHT+IGahPHTL5/vbt37mNvgCuoy94X8jeX8VPZfQ1TFVvCAbQ0EOeId9/3PTU0e/DAVF+Ue6slwa0D1p604OwHFRfg=
X-Received: by 2002:a2e:97ca:0:b0:302:1861:6df4 with SMTP id
 38308e7fff4ca-30a599ba0dcmr11866961fa.35.1740150192135; Fri, 21 Feb 2025
 07:03:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221144245.1012686-1-kiran.k@intel.com>
In-Reply-To: <20250221144245.1012686-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 21 Feb 2025 10:02:58 -0500
X-Gm-Features: AWEUYZli_WO6Wl8Eglkev5A5xIwvFj69zsMHcNrfHT4nTET4aE_3aQg1TXVs8jM
Message-ID: <CABBYNZLZedz1WE6SAK9F_zy-Y9c5EOVEgv61Yo0eavtivjJzdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Bluetooth: btintel_pcie: Setup buffers for
 firmware traces
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com, 
	vijay.satija@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Fri, Feb 21, 2025 at 9:44=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> This patch allocates the host memory which is used by controller to dump
> the firmware traces. The memory needs to be shared with controller via
> context information.
>
> Co-developed-by: Vijay Satija <vijay.satija@intel.com>
> Signed-off-by: Vijay Satija <vijay.satija@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> v1 -> v2:
> No change
>
>  drivers/bluetooth/btintel_pcie.c | 89 ++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btintel_pcie.h | 32 ++++++++++++
>  2 files changed, 121 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index b8b241a92bf9..11e2b805c7cc 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -49,6 +49,8 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
>  #define BTINTEL_PCIE_HCI_EVT_PKT       0x00000004
>  #define BTINTEL_PCIE_HCI_ISO_PKT       0x00000005
>
> + #define BTINTEL_PCIE_MAGIC_NUM    0xA5A5A5A5
> +
>  /* Alive interrupt context */
>  enum {
>         BTINTEL_PCIE_ROM,
> @@ -60,6 +62,83 @@ enum {
>         BTINTEL_PCIE_D3
>  };
>
> +/* Structure for dbgc fragment buffer
> + * @buf_addr_lsb: LSB of the buffer's physical address
> + * @buf_addr_msb: MSB of the buffer's physical address
> + * @buf_size: Total size of the buffer
> + */
> +struct btintel_pcie_dbgc_ctxt_buf {
> +       u32     buf_addr_lsb;
> +       u32     buf_addr_msb;
> +       u32     buf_size;
> +};
> +
> +/* Structure for dbgc fragment
> + * @magic_num: 0XA5A5A5A5
> + * @ver: For Driver-FW compatibility
> + * @total_size: Total size of the payload debug info
> + * @num_buf: Num of allocated debug bufs
> + * @bufs: All buffer's addresses and sizes
> + */
> +struct btintel_pcie_dbgc_ctxt {
> +       u32     magic_num;
> +       u32     ver;
> +       u32     total_size;
> +       u32     num_buf;
> +       struct btintel_pcie_dbgc_ctxt_buf bufs[BTINTEL_PCIE_DBGC_BUFFER_C=
OUNT];
> +};
> +
> +/* This function initializes the memory for DBGC buffers and formats the
> + * DBGC fragment which consists header info and DBGC buffer's LSB, MSB a=
nd
> + * size as the payload
> + */
> +static int btintel_pcie_setup_dbgc(struct btintel_pcie_data *data)
> +{
> +       struct btintel_pcie_dbgc_ctxt db_frag;
> +       struct data_buf *buf;
> +       int i;
> +
> +       data->dbgc.count =3D BTINTEL_PCIE_DBGC_BUFFER_COUNT;
> +       data->dbgc.bufs =3D devm_kcalloc(&data->pdev->dev, data->dbgc.cou=
nt,
> +                                      sizeof(*buf), GFP_KERNEL);
> +       if (!data->dbgc.bufs)
> +               return -ENOMEM;
> +
> +       data->dbgc.buf_v_addr =3D dmam_alloc_coherent(&data->pdev->dev,
> +                                                   data->dbgc.count *
> +                                                   BTINTEL_PCIE_DBGC_BUF=
FER_SIZE,
> +                                                   &data->dbgc.buf_p_add=
r,
> +                                                   GFP_KERNEL | __GFP_NO=
WARN);
> +       if (!data->dbgc.buf_v_addr)
> +               return -ENOMEM;
> +
> +       data->dbgc.frag_v_addr =3D dmam_alloc_coherent(&data->pdev->dev,
> +                                                    sizeof(struct btinte=
l_pcie_dbgc_ctxt),
> +                                                    &data->dbgc.frag_p_a=
ddr,
> +                                                    GFP_KERNEL | __GFP_N=
OWARN);
> +       if (!data->dbgc.frag_v_addr)
> +               return -ENOMEM;
> +
> +       data->dbgc.frag_size =3D sizeof(struct btintel_pcie_dbgc_ctxt);
> +
> +       db_frag.magic_num =3D BTINTEL_PCIE_MAGIC_NUM;
> +       db_frag.ver =3D BTINTEL_PCIE_DBGC_FRAG_VERSION;
> +       db_frag.total_size =3D BTINTEL_PCIE_DBGC_FRAG_PAYLOAD_SIZE;
> +       db_frag.num_buf =3D BTINTEL_PCIE_DBGC_FRAG_BUFFER_COUNT;
> +
> +       for (i =3D 0; i < data->dbgc.count; i++) {
> +               buf =3D &data->dbgc.bufs[i];
> +               buf->data_p_addr =3D data->dbgc.buf_p_addr + i * BTINTEL_=
PCIE_DBGC_BUFFER_SIZE;
> +               buf->data =3D data->dbgc.buf_v_addr + i * BTINTEL_PCIE_DB=
GC_BUFFER_SIZE;
> +               db_frag.bufs[i].buf_addr_lsb =3D (u32)(buf->data_p_addr &=
 0xffffffff);
> +               db_frag.bufs[i].buf_addr_msb =3D (u32)((buf->data_p_addr =
>> 32) & 0xffffffff);

If I recall it correctly the shift was causing build errors/warnings.

> +               db_frag.bufs[i].buf_size =3D BTINTEL_PCIE_DBGC_BUFFER_SIZ=
E;
> +       }
> +
> +       memcpy(data->dbgc.frag_v_addr, &db_frag, sizeof(db_frag));
> +       return 0;
> +}
> +
>  static inline void ipc_print_ia_ring(struct hci_dev *hdev, struct ia *ia=
,
>                                      u16 queue_num)
>  {
> @@ -1008,6 +1087,11 @@ static void btintel_pcie_init_ci(struct btintel_pc=
ie_data *data,
>         ci->addr_urbdq1 =3D data->rxq.urbd1s_p_addr;
>         ci->num_urbdq1 =3D data->rxq.count;
>         ci->urbdq_db_vec =3D BTINTEL_PCIE_RXQ_NUM;
> +
> +       ci->dbg_output_mode =3D 0x01;
> +       ci->dbgc_addr =3D data->dbgc.frag_p_addr;
> +       ci->dbgc_size =3D data->dbgc.frag_size;
> +       ci->dbg_preset =3D 0x00;
>  }
>
>  static void btintel_pcie_free_txq_bufs(struct btintel_pcie_data *data,
> @@ -1220,6 +1304,11 @@ static int btintel_pcie_alloc(struct btintel_pcie_=
data *data)
>         /* Setup Index Array */
>         btintel_pcie_setup_ia(data, p_addr, v_addr, &data->ia);
>
> +       /* Setup data buffers for dbgc */
> +       err =3D btintel_pcie_setup_dbgc(data);
> +       if (err)
> +               goto exit_error_txq;
> +
>         /* Setup Context Information */
>         p_addr +=3D sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 4;
>         v_addr +=3D sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 4;
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel=
_pcie.h
> index f9aada0543c4..b9d32393002b 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -48,6 +48,21 @@
>  #define BTINTEL_PCIE_CSR_MSIX_IVAR_BASE                (BTINTEL_PCIE_CSR=
_MSIX_BASE + 0x0880)
>  #define BTINTEL_PCIE_CSR_MSIX_IVAR(cause)      (BTINTEL_PCIE_CSR_MSIX_IV=
AR_BASE + (cause))
>
> +/* The DRAM buffer count, each buffer size, and
> + * fragment buffer size
> + */
> +#define BTINTEL_PCIE_DBGC_BUFFER_COUNT         16
> +#define BTINTEL_PCIE_DBGC_BUFFER_SIZE          (256 * 1024) /* 256 KB */
> +
> +#define BTINTEL_PCIE_DBGC_FRAG_VERSION         1
> +#define BTINTEL_PCIE_DBGC_FRAG_BUFFER_COUNT    BTINTEL_PCIE_DBGC_BUFFER_=
COUNT
> +
> +/* Magic number(4), version(4), size of payload length(4) */
> +#define BTINTEL_PCIE_DBGC_FRAG_HEADER_SIZE     12
> +
> +/* Num of alloc Dbg buff (4) + (LSB(4), MSB(4), Size(4)) for each buffer=
 */
> +#define BTINTEL_PCIE_DBGC_FRAG_PAYLOAD_SIZE    196
> +
>  /* Causes for the FH register interrupts */
>  enum msix_fh_int_causes {
>         BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0       =3D BIT(0),       /* caus=
e 0 */
> @@ -325,6 +340,22 @@ struct rxq {
>         struct data_buf *bufs;
>  };
>
> +/* Structure for DRAM Buffer
> + * @count: Number of descriptors
> + * @buf: Array of data_buf structure
> + */
> +struct btintel_pcie_dbgc {
> +       u16             count;
> +
> +       void            *frag_v_addr;
> +       dma_addr_t      frag_p_addr;
> +       u16             frag_size;
> +
> +       dma_addr_t      buf_p_addr;
> +       void            *buf_v_addr;
> +       struct data_buf *bufs;
> +};
> +
>  /* struct btintel_pcie_data
>   * @pdev: pci device
>   * @hdev: hdev device
> @@ -405,6 +436,7 @@ struct btintel_pcie_data {
>         struct txq      txq;
>         struct rxq      rxq;
>         u32     alive_intr_ctxt;
> +       struct btintel_pcie_dbgc        dbgc;
>  };
>
>  static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
