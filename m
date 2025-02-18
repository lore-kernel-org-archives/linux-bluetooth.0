Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58B3286A1
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899725; cv=none; b=fEDZw9/Ce6tOUMLN4HdPs4SzmVV5tETN7hWrAK1T5cX0PvRoEG6KXt+NfxOesEuKEkLfLBcp7mOLX0k4LH5YjS7iBcWnGlqBA8S27mG3re5MKHK7nE0eGHj5A091n/mZYO4SXBNYaFmckqvjh/ThR8ZmDACdXkCVAjR25s0HtT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899725; c=relaxed/simple;
	bh=sJgFFc2KBpQPqn1ELRuTIR1QX2DzckW0yp+MeXFLEHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jM59JF8Pwm/Ha9iPS/yiKNb3E8DwFyB5xjMIANI7iO1XaR1VGMDOO03cs7SlJcwKe0sVEHBAPJYCpn/ZhWW/hUifCUpoiJanS3/OIVE210B9hu0N5jK5KdzVJu16/dY/xn0qNcur/19I+ARlEcpRz29Noc8XV89NvcYVFx9WB74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkWDi3To; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkWDi3To"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3061513d353so61274311fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 09:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739899722; x=1740504522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHhVcd3XcSMi0871lE13OteRup1SWkVVdUxuv2DncSY=;
        b=YkWDi3ToU7gJnAhP96lFSf+6vCk8GNOXw3+35kDd7hjLFBxP6cD01bvXW5eJLZ4dSk
         zfPI3Vsr8GVI03iK2lyxupijpw1854DtBVY9Ij4EU/aDKyWrMMfzXxbmGWP08QKUmZKf
         zmG5GvkBz5Q4y/2beTz7xQ81O9QOXh/yqdthqjgD6/YTCKBskfc6tioQQ+r9W4uekcQo
         7vRORxB1L/Kh5ZCg89A5Sn5pjGbsmnqQ5Vqu3q0xvDzmjzkzqU3gen/T7Z2ZCr502Nj+
         seX36LOnoQY3F+5uQT7ENd/Qsz4EsJ3PI6Y1wF1FKpCEqmMuiohvRXoBnJOTt6Lj6ItF
         cSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899722; x=1740504522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHhVcd3XcSMi0871lE13OteRup1SWkVVdUxuv2DncSY=;
        b=N2L6BzZJqeHgTMw/OmIMCtmIhW1iMXeXjlonZjzsE07FuL7LWOsRtnHT/EUNGKOMA3
         d2RvZkI26hiQRwaE4CNOoWJ+nlBiwxri5TX3iksGs5ZmMKR+S5vmErgM/QvsSsOTnXKn
         g3Mi/MipnFvPBcVIaTYtkHFhjxgqS7zOQpSG7y58bVLR1ECrRO4sEUPl8iIBd1GrMGet
         JZjyRWKRtA+fR0Wm5UfNQIIZ3eXxQEDsD20IV0ZTILi4K5p/QDaKejIWM20vVveREgBh
         PY+UFSdksjkzr9zMvn73a95eNt4Fzpi0GeAzqsdn4DDvJ69PI7YZNw7HzD0n0x3kDGTo
         OM/Q==
X-Gm-Message-State: AOJu0Yw2ljdeYPb0TLeYxsv2NF93JIXyKjG1+yT9zJmK7rtB0r2Jm0Oi
	jwcpN+OUDyGTqlWDIPfhaEMjwfJdPZ9BbYt0CEAFYljVhSkUi8lur+9mdflK97lxgbPkWu1ksrj
	BFJVXx7uuqVqq90I+xClQ/Fuan3w=
X-Gm-Gg: ASbGncsz8ldTKrvn6/p4zJo+8VD9XY1QRcnV+bIHDfA9+GxHUZqHqfx9HP5aRBuRAB1
	QrjLMec0bxbOSM+oouAKoFdx4vB9jMsxtPZi9rE0iu4IDt+2ro8c2XDkpeau5j87/fhjPvbqbcw
	==
X-Google-Smtp-Source: AGHT+IGYMRSen+agcGMtAlPRuUxfuTcAGX2O/LG3HiIpr0bknebeq/msIi++MmXmUm8XnzbubYYmVIWaDiL5zs9jrcI=
X-Received: by 2002:a2e:b607:0:b0:309:bc3:3b01 with SMTP id
 38308e7fff4ca-309279833e9mr41509871fa.0.1739899721426; Tue, 18 Feb 2025
 09:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218122620.762523-1-kiran.k@intel.com> <20250218122620.762523-2-kiran.k@intel.com>
In-Reply-To: <20250218122620.762523-2-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Feb 2025 12:28:26 -0500
X-Gm-Features: AWEUYZnOjvsbApRbW3cm4lpcI1Hsn1-8FX-h2gZOC--Jfr1HqihB65M-VImyaCE
Message-ID: <CABBYNZLGg6eJXm6kZmF2KZ-ux5tGRqBssQgL=Cb=CHPcUgx7fA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] Bluetooth: btintel_pcie: Read hardware exception data
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com, 
	vijay.satija@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Tue, Feb 18, 2025 at 7:27=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> On hardware error, controller writes hardware error event and optional
> vendor specific hci events in device memory in TLV format and raises
> MSIX interrupt. Driver reads the device memory and passes the events to
> the stack for further processing.
>
> Co-developed-by: Vijay Satija <vijay.satija@intel.com>
> Signed-off-by: Vijay Satija <vijay.satija@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.h      |   1 +
>  drivers/bluetooth/btintel_pcie.c | 212 ++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btintel_pcie.h |  23 ++++
>  3 files changed, 235 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 19530ea14905..4c21e69887a3 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -190,6 +190,7 @@ enum {
>  struct btintel_data {
>         DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
>         int (*acpi_reset_method)(struct hci_dev *hdev);
> +       u32     cnvi_top;
>  };
>
>  #define btintel_set_flag(hdev, nr)                                     \
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 11e2b805c7cc..6c78472f9dad 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -51,6 +51,14 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
>
>   #define BTINTEL_PCIE_MAGIC_NUM    0xA5A5A5A5
>
> +#define BTINTEL_PCIE_BLZR_HWEXP_SIZE           1024
> +#define BTINTEL_PCIE_BLZR_HWEXP_DMP_ADDR       0xB00A7C00
> +
> +#define BTINTEL_PCIE_SCP_HWEXP_SIZE            4096
> +#define BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR                0xB030F800
> +
> +#define BTINTEL_PCIE_MAGIC_NUM 0xA5A5A5A5
> +
>  /* Alive interrupt context */
>  enum {
>         BTINTEL_PCIE_ROM,
> @@ -353,6 +361,63 @@ static int btintel_pcie_reset_bt(struct btintel_pcie=
_data *data)
>         return reg =3D=3D 0 ? 0 : -ENODEV;
>  }
>
> +static void btintel_pcie_mac_init(struct btintel_pcie_data *data)
> +{
> +       u32 reg;
> +
> +       /* Set MAC_INIT bit to start primary bootloader */
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_RE=
G);
> +       reg &=3D ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
> +                       BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_DISCON |
> +                       BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET);
> +       reg |=3D (BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_ENA |
> +                       BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT);
> +       btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
> +}
> +
> +static int btintel_pcie_get_mac_access(struct btintel_pcie_data *data)
> +{
> +       u32 reg;
> +       int retry =3D 15;
> +
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_RE=
G);
> +
> +       reg |=3D BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS;
> +       reg |=3D BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ;
> +       if ((reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS) =3D=3D 0)
> +               reg |=3D BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ;
> +
> +       btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
> +
> +       do {
> +               reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC=
_CTRL_REG);
> +               if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS)
> +                       return 0;
> +               usleep_range(1000, 1200);
> +
> +       } while (--retry > 0);

There seems to be a similar call to btintel_pcie_wr_reg32(data,
BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg); in btintel_pcie_mac_init but
that doesn't retry for some reason, maybe leave a comment if that is
intentional, that said this write, read and wait is sort of weird to
me, if we know it takes time there should probably be an event coming
back, rather than polling multiple times in quick succession.

> +
> +       return -ETIME;
> +}
> +
> +static void btintel_pcie_release_mac_access(struct btintel_pcie_data *da=
ta)
> +{
> +       u32 reg;
> +
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_RE=
G);
> +
> +       if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ)
> +               reg &=3D ~BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ;
> +
> +       if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS)
> +               reg &=3D ~BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS;
> +
> +       if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ)
> +               reg &=3D ~BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ;
> +
> +       btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
> +}
> +
>  /* This function enables BT function by setting BTINTEL_PCIE_CSR_FUNC_CT=
RL_MAC_INIT bit in
>   * BTINTEL_PCIE_CSR_FUNC_CTRL_REG register and wait for MSI-X with
>   * BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0.
> @@ -473,6 +538,133 @@ static inline char *btintel_pcie_alivectxt_state2st=
r(u32 alive_intr_ctxt)
>         }
>  }
>
> +static int btintel_pcie_read_device_mem(struct btintel_pcie_data *data,
> +                                       void *buf, u32 dev_addr, int len)
> +{
> +       int err;
> +       u32 *val =3D buf;
> +
> +       /* Get device mac access */
> +       err =3D btintel_pcie_get_mac_access(data);
> +       if (err) {
> +               bt_dev_err(data->hdev, "Failed to get mac access %d", err=
);
> +               return err;
> +       }
> +
> +       for (; len > 0; len -=3D 4, dev_addr +=3D 4, val++)
> +               *val =3D btintel_pcie_rd_dev_mem(data, dev_addr);
> +
> +       btintel_pcie_release_mac_access(data);
> +
> +       return 0;
> +}
> +
> +static void btintel_pcie_dump_hwexp(struct btintel_pcie_data *data)
> +{
> +       struct btintel_data *intel_data =3D hci_get_priv(data->hdev);
> +       int len, err, offset, pending;
> +       struct sk_buff *skb;
> +       u32 addr, val;
> +       u8 *buf;
> +
> +       struct tlv {
> +               u8      type;
> +               u16     len;
> +               u8      val[];
> +       } __packed;
> +
> +       struct tlv *tlv;
> +
> +       switch (intel_data->cnvi_top & 0xfff) {
> +       case BTINTEL_CNVI_BLAZARI:
> +       case BTINTEL_CNVI_BLAZARIW:
> +               /* only from step B0 onwards */
> +               if (INTEL_CNVX_TOP_STEP(intel_data->cnvi_top) !=3D 0x01)
> +                       return;
> +               len =3D BTINTEL_PCIE_BLZR_HWEXP_SIZE; /* exception data l=
ength */
> +               addr =3D BTINTEL_PCIE_BLZR_HWEXP_DMP_ADDR;
> +       break;
> +       case BTINTEL_CNVI_SCP:
> +               len =3D BTINTEL_PCIE_SCP_HWEXP_SIZE;
> +               addr =3D BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR;
> +       break;
> +       default:
> +               bt_dev_err(data->hdev, "Unsupported cnvi 0x%8x", intel_da=
ta->cnvi_top);
> +               return;
> +       }
> +
> +       buf =3D kzalloc(len, GFP_KERNEL);
> +       if (!buf)
> +               goto exit_on_error;
> +
> +       btintel_pcie_mac_init(data);
> +
> +       err =3D btintel_pcie_read_device_mem(data, buf, addr, len);
> +       if (err)
> +               goto exit_on_error;
> +
> +       val =3D get_unaligned_le32(buf);
> +       if (val !=3D BTINTEL_PCIE_MAGIC_NUM) {
> +               bt_dev_err(data->hdev, "Invalid exception dump signature:=
 0x%8.8x",
> +                          val);
> +               goto exit_on_error;
> +       }
> +
> +       offset =3D 4;
> +       do {
> +               pending =3D len - offset;
> +               if (pending < sizeof(*tlv))
> +                       break;
> +               tlv =3D (struct tlv *)(buf + offset);
> +               if (!tlv->type) {
> +                       bt_dev_dbg(data->hdev, "Invalid TLV type 0");
> +                       break;
> +               }
> +               tlv->len =3D le16_to_cpu((__force __le16)tlv->len);
> +               offset +=3D sizeof(*tlv);
> +               pending =3D len - offset;
> +               if (tlv->len > pending)
> +                       break;
> +
> +               offset +=3D tlv->len;
> +                /* Only TLV of type =3D 1 are vendor HCI events */
> +               if (tlv->type !=3D 1)
> +                       continue;
> +
> +               bt_dev_dbg(data->hdev, "Exception pkt len: %u", tlv->len)=
;
> +               if (tlv->len > HCI_MAX_EVENT_SIZE)
> +                       break;
> +               skb =3D bt_skb_alloc(tlv->len, GFP_KERNEL);
> +               if (!skb)
> +                       goto exit_on_error;
> +               hci_skb_pkt_type(skb) =3D HCI_EVENT_PKT;
> +               skb_put_data(skb, tlv->val, tlv->len);
> +
> +               /* copy Intel specific pcie packet type */
> +               val =3D BTINTEL_PCIE_HCI_EVT_PKT;
> +               memcpy(skb_push(skb, BTINTEL_PCIE_HCI_TYPE_LEN), &val,
> +                      BTINTEL_PCIE_HCI_TYPE_LEN);
> +
> +               print_hex_dump(KERN_DEBUG, "Bluetooth: ", DUMP_PREFIX_OFF=
SET, 16,
> +                              1, tlv->val, tlv->len, false);
> +
> +               skb_queue_tail(&data->rx_skb_q, skb);
> +               queue_work(data->workqueue, &data->rx_work);
> +       } while (offset < len);

Could there be multiple exceptions? If there is only one the perhaps
you could use eir_get_data instead of recreating the code for parsing
LTV entries, although we could possibly rename that to make it more
generic.

> +
> +exit_on_error:
> +       kfree(buf);
> +}
> +
> +static void btintel_pcie_hwexp_work(struct work_struct *work)
> +{
> +       struct btintel_pcie_data *data =3D container_of(work,
> +                                       struct btintel_pcie_data, hwexp_w=
ork);
> +       btintel_pcie_dump_hwexp(data);
> +
> +       clear_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags);
> +}
> +
>  /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
>   * BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES) which is sent for boot stage and=
 image response.
>   */
> @@ -794,6 +986,14 @@ static int btintel_pcie_recv_frame(struct btintel_pc=
ie_data *data,
>         return ret;
>  }
>
> +static void btintel_pcie_msix_hw_exp_handler(struct btintel_pcie_data *d=
ata)
> +{
> +       bt_dev_err(data->hdev, "Received hw exception interrupt");
> +       if (test_and_set_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags)=
)
> +               return;
> +       queue_work(data->workqueue, &data->hwexp_work);

Any particular reason why we can process the exception in the rx_work?
That shall probably be made into a comment either way.

> +}
> +
>  static void btintel_pcie_rx_work(struct work_struct *work)
>  {
>         struct btintel_pcie_data *data =3D container_of(work,
> @@ -920,6 +1120,10 @@ static irqreturn_t btintel_pcie_irq_msix_handler(in=
t irq, void *dev_id)
>                 return IRQ_NONE;
>         }
>
> +       /* This interrupt is raised when there is an hardware exception *=
/
> +       if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP)
> +               btintel_pcie_msix_hw_exp_handler(data);
> +
>         /* This interrupt is triggered by the firmware after updating
>          * boot_stage register and image_response register
>          */
> @@ -1000,7 +1204,8 @@ struct btintel_pcie_causes_list {
>  static struct btintel_pcie_causes_list causes_list[] =3D {
>         { BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0,    BTINTEL_PCIE_CSR_MSIX_FH_=
INT_MASK,      0x00 },
>         { BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1,    BTINTEL_PCIE_CSR_MSIX_FH_=
INT_MASK,      0x01 },
> -       { BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0, BTINTEL_PCIE_CSR_MSIX_HW_I=
NT_MASK,       0x20 },
> +       { BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0,  BTINTEL_PCIE_CSR_MSIX_HW_=
INT_MASK,      0x20 },
> +       { BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP, BTINTEL_PCIE_CSR_MSIX_HW=
_INT_MASK,     0x23 },
>  };
>
>  /* This function configures the interrupt masks for both HW_INT_CAUSES a=
nd
> @@ -1482,6 +1687,7 @@ static void btintel_pcie_release_hdev(struct btinte=
l_pcie_data *data)
>
>  static int btintel_pcie_setup_internal(struct hci_dev *hdev)
>  {
> +       struct btintel_data *data =3D hci_get_priv(hdev);
>         const u8 param[1] =3D { 0xFF };
>         struct intel_version_tlv ver_tlv;
>         struct sk_buff *skb;
> @@ -1520,6 +1726,7 @@ static int btintel_pcie_setup_internal(struct hci_d=
ev *hdev)
>                 goto exit_error;
>         }
>
> +       data->cnvi_top =3D ver_tlv.cnvi_top;
>         switch (INTEL_HW_PLATFORM(ver_tlv.cnvi_bt)) {
>         case 0x37:
>                 break;
> @@ -1667,6 +1874,8 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
>         skb_queue_head_init(&data->rx_skb_q);
>         INIT_WORK(&data->rx_work, btintel_pcie_rx_work);
>
> +       INIT_WORK(&data->hwexp_work, btintel_pcie_hwexp_work);
> +
>         data->boot_stage_cache =3D 0x00;
>         data->img_resp_cache =3D 0x00;
>
> @@ -1731,6 +1940,7 @@ static void btintel_pcie_remove(struct pci_dev *pde=
v)
>         btintel_pcie_release_hdev(data);
>
>         flush_work(&data->rx_work);
> +       flush_work(&data->hwexp_work);
>
>         destroy_workqueue(data->workqueue);
>
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel=
_pcie.h
> index b9d32393002b..98902fd4fc96 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -16,6 +16,8 @@
>  #define BTINTEL_PCIE_CSR_CI_ADDR_LSB_REG       (BTINTEL_PCIE_CSR_BASE + =
0x118)
>  #define BTINTEL_PCIE_CSR_CI_ADDR_MSB_REG       (BTINTEL_PCIE_CSR_BASE + =
0x11C)
>  #define BTINTEL_PCIE_CSR_IMG_RESPONSE_REG      (BTINTEL_PCIE_CSR_BASE + =
0x12C)
> +#define BTINTEL_PCIE_PRPH_DEV_ADDR_REG         (BTINTEL_PCIE_CSR_BASE + =
0x440)
> +#define BTINTEL_PCIE_PRPH_DEV_RD_REG           (BTINTEL_PCIE_CSR_BASE + =
0x458)
>  #define BTINTEL_PCIE_CSR_HBUS_TARG_WRPTR       (BTINTEL_PCIE_CSR_BASE + =
0x460)
>
>  /* BTINTEL_PCIE_CSR Function Control Register */
> @@ -23,6 +25,12 @@
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT            (BIT(6))
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT           (BIT(7))
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS      (BIT(20))
> +
> +#define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ      (BIT(21))
> +/* Stop MAC Access disconnection request */
> +#define BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS (BIT(22))
> +#define BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ                (BIT(23))
> +
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_STS      (BIT(28))
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_DISCON   (BIT(29))
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET            (BIT(31))
> @@ -72,6 +80,7 @@ enum msix_fh_int_causes {
>  /* Causes for the HW register interrupts */
>  enum msix_hw_int_causes {
>         BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0     =3D BIT(0),       /* caus=
e 32 */
> +       BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP   =3D BIT(3),       /* caus=
e 35 */
>  };
>
>  /* PCIe device states
> @@ -84,6 +93,11 @@ enum {
>         BTINTEL_PCIE_STATE_D3_HOT =3D 2,
>         BTINTEL_PCIE_STATE_D3_COLD =3D 3,
>  };
> +
> +enum {
> +       BTINTEL_PCIE_HWEXP_INPROGRESS,
> +};
> +
>  #define BTINTEL_PCIE_MSIX_NON_AUTO_CLEAR_CAUSE BIT(7)
>
>  /* Minimum and Maximum number of MSI-X Vector
> @@ -437,6 +451,7 @@ struct btintel_pcie_data {
>         struct rxq      rxq;
>         u32     alive_intr_ctxt;
>         struct btintel_pcie_dbgc        dbgc;
> +       struct work_struct      hwexp_work;
>  };
>
>  static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
> @@ -476,3 +491,11 @@ static inline void btintel_pcie_clr_reg_bits(struct =
btintel_pcie_data *data,
>         r &=3D ~bits;
>         iowrite32(r, data->base_addr + offset);
>  }
> +
> +static inline u32 btintel_pcie_rd_dev_mem(struct btintel_pcie_data *data=
,
> +                                         u32 addr)
> +{
> +       btintel_pcie_wr_reg32(data, BTINTEL_PCIE_PRPH_DEV_ADDR_REG, addr)=
;
> +       return btintel_pcie_rd_reg32(data, BTINTEL_PCIE_PRPH_DEV_RD_REG);
> +}
> +
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
