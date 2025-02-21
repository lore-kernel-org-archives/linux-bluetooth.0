Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD201EBFE8
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152707; cv=none; b=IKVUz+4zJI3rRKEYRHGwuOEe8eWX67R1EiMFzK5Dw+9rxFR5fTkH48H7GES1juKtjiy+n52hX/+f7bvqIcAvSeCzPThuoo/BZTP0beDcvr2w3CkylvKy2I7Khijw4RdWpJtNfg/u+dy7Zr95c3qby3y1fmg6u+w2IKSb2n38AXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152707; c=relaxed/simple;
	bh=exSMq/mNjLPyiYXkBZTCKtlhvDfXs0/PzJqgQjgFXfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RN4tC1cQ7WycVTechkQx+PQrNinVQLIu+DJtS835Y6B8X1l6WJ810oIS2rdV9Sq7/U+oGU3GWlmDaR/DeH9eW6iWVyxfbIRdg2/o/RZD+BTjVRRQ91H6Nw1sYWkNl4Vih58D0kuNfgITZDkhPR8kZ51mW+Pm7oalM0afccmJ9sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLW2HElC; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLW2HElC"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30918c29da2so23499511fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 07:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740152703; x=1740757503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IpMLRWSRQgZmF9yDS72h19GC6fbQWZ2TJ/kCOTbtUI=;
        b=WLW2HElCM79OGl5qgyzu/QlYEyw7/3Bc3e5aZdbQwFT5xr3OwUR30CKI87DvenjhfO
         qpw8Jrm08qZObhlBnF/dKoGuydwLJCq9pUJdSH1oDdO+qa38756vBQ4HqkV0EXdIQ0W/
         RqyCYl4RA4BaRHn+hzl2AGv8FD5qXFvLB2oJbc4t0yrOh9ADOx3pgklOn0MSgtKIB3rw
         LWp+QeKN2tFZ+pMpKW5IM/4xtR+KXfZmOAAEb156k7DhgmTUYv3FxpSQ3/ZTquGxG3W7
         mRayDpce53nIc3e3dqhIJ/Gysj7C8T29iWrwZuq6EhH2fpLlYQ8FL5ctO1fXh+sKt5aX
         wWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740152703; x=1740757503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IpMLRWSRQgZmF9yDS72h19GC6fbQWZ2TJ/kCOTbtUI=;
        b=FFVh0fi4OK0iHJNJKP8kR4JKb8cIo37271Msdr21NGYb1VrJmFuCvGH/RV4FhrzHxD
         3Bo9qH45bgM/+GxEx8u8NE4rXxZzl4AmkoB7fcRrnAmA74KYCdz8iN1rtUEAW7Z0MY+R
         UIk4BYwwCRpLRT+8p/Q+dRdqfzDMg8LRorYEjDZUUad9spdC0WNOhvLX2fNgryTuwIb3
         xEY9rirTD+F5fxGPnKfRzKZj7PANqbl57bPZsoi+M6OwWNRlm/edETrcPsRuSbjFzmh2
         gDA0XMXOKEqBrBtKblV0b6Pnube8y1weL/dvkti8VJmCtVbPSpqUTFaCKiWU7+Nbm3Yo
         i1Hg==
X-Gm-Message-State: AOJu0Yz86VsZ4OqKpixazhBiYBJsX7gZG2qEWb4taNeCkgkY0ewaPsxM
	7qnDd0QDuKUdzwJvZWtzEa7oFOSJpYWUt80PsToeMwhpupHAPo0eSjyCTD5pRn4nqVBL8ZG1v1u
	/tEyBSf5JHxwl9xEUnavm8UyLENSB08cG1vY=
X-Gm-Gg: ASbGnctBau3hU4vSlm1DZfbMGdOSWCl252w06r/5d9lcWlyddXYpkWRIkGZiP/gk50E
	6l/MwWFQsJ//R9xUpgWJgkl9jIxgTw3WaedDIqzyc94AKs1GjucttCsxKwfAsVFbfLVtAthOYUH
	lfyIsjkXur
X-Google-Smtp-Source: AGHT+IETHVZFrMgRWVK40IxD4xa6yt2Axelhc9b0CnwKHsZJVLA3yBiQKIFe43RCOFl8BJ8qCOVUslNQ4peMjYv2VPE=
X-Received: by 2002:a2e:994c:0:b0:307:2b3e:a4a9 with SMTP id
 38308e7fff4ca-30a598f42d2mr14700831fa.20.1740152702271; Fri, 21 Feb 2025
 07:45:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221144245.1012686-1-kiran.k@intel.com> <20250221144245.1012686-2-kiran.k@intel.com>
In-Reply-To: <20250221144245.1012686-2-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 21 Feb 2025 10:44:49 -0500
X-Gm-Features: AWEUYZkkTcgUxhFBH_a9kSlaP5DGks7tX_0JC3fG-fXNIepyu0tXt0AOysUhqPw
Message-ID: <CABBYNZLFeFOmtKHNGWmJkGjoJUoF_Pic+h5J4tpTW5vyTam_3A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Bluetooth: btintel_pcie: Read hardware exception data
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com, 
	vijay.satija@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Fri, Feb 21, 2025 at 9:43=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
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
> v1 --> v2:
> - Add comments for the delay added in MAC for target acess
> - Add comment for having a seperate work item to read exception events
> - Add hci interface name while logging expception event in dmesg.
>
>  drivers/bluetooth/btintel.h      |   1 +
>  drivers/bluetooth/btintel_pcie.c | 226 ++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btintel_pcie.h |  23 ++++
>  3 files changed, 249 insertions(+), 1 deletion(-)
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
> index 11e2b805c7cc..f93ddd2fdb01 100644
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
> @@ -353,6 +361,64 @@ static int btintel_pcie_reset_bt(struct btintel_pcie=
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
> +               /* Need delay here for Target Access harwdware to settle =
down*/
> +               usleep_range(1000, 1200);
> +
> +       } while (--retry > 0);
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
> @@ -473,6 +539,140 @@ static inline char *btintel_pcie_alivectxt_state2st=
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
> +       u8 *buf, prefix[64];
> +       u32 addr, val;
> +
> +       struct tlv {
> +               u8      type;
> +               u16     len;
> +               u8      val[];
> +       } __packed;

This format seems different from intel_tlv, is this intentional? This
should really be part of btintel.c though alongside the likes of
btintel_diagnostics.

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
> +               bt_dev_err(data->hdev, "Unsupported cnvi 0x%8.8x", intel_=
data->cnvi_top);
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
> +       snprintf(prefix, sizeof(prefix), "Bluetooth: %s: ", bt_dev_name(d=
ata->hdev));
> +
> +       offset =3D 4;
> +       do {
> +               pending =3D len - offset;
> +               if (pending < sizeof(*tlv))
> +                       break;
> +               tlv =3D (struct tlv *)(buf + offset);
> +
> +               /* If type =3D=3D 0, then there are no more TLVs to be pa=
rsed */
> +               if (!tlv->type) {
> +                       bt_dev_dbg(data->hdev, "Invalid TLV type 0");
> +                       break;
> +               }
> +               tlv->len =3D le16_to_cpu((__force __le16)tlv->len);

Weird, why not use le16 in the declaration?

> +               offset +=3D sizeof(*tlv);
> +               pending =3D len - offset;
> +               if (tlv->len > pending)
> +                       break;
> +
> +               offset +=3D tlv->len;
> +
> +                /* Only TLVs of type =3D=3D 1 are HCI events, no need to=
 process other
> +                 * TLVs
> +                 */
> +               if (tlv->type !=3D 1)
> +                       continue;
> +
> +               bt_dev_dbg(data->hdev, "TLV packet length: %u", tlv->len)=
;
> +               if (tlv->len > HCI_MAX_EVENT_SIZE)
> +                       break;
> +               skb =3D bt_skb_alloc(tlv->len, GFP_KERNEL);
> +               if (!skb)
> +                       goto exit_on_error;

If we are going to create an skb then perhaps we should create it
earlier and then use its function to part the tlv (e.g. skb_pull_data,
etc).

> +               hci_skb_pkt_type(skb) =3D HCI_EVENT_PKT;
> +               skb_put_data(skb, tlv->val, tlv->len);
> +
> +               /* copy Intel specific pcie packet type */
> +               val =3D BTINTEL_PCIE_HCI_EVT_PKT;
> +               memcpy(skb_push(skb, BTINTEL_PCIE_HCI_TYPE_LEN), &val,
> +                      BTINTEL_PCIE_HCI_TYPE_LEN);
> +
> +               print_hex_dump(KERN_DEBUG, prefix, DUMP_PREFIX_OFFSET, 16=
, 1,
> +                              tlv->val, tlv->len, false);
> +
> +               skb_queue_tail(&data->rx_skb_q, skb);
> +               queue_work(data->workqueue, &data->rx_work);

So all this exercise was just to create an skb out of the data and
then again trigger rx_work? I don't think it is worth adding a work
just to do that, especially since if there is an exception then the
rx_work will probably not be doing anything until the recovery kicks
in.

> +       } while (offset < len);
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
> @@ -794,6 +994,20 @@ static int btintel_pcie_recv_frame(struct btintel_pc=
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
> +       /* Unlike usb products, there will be no hardware event sent by
> +        * controller on exception. Instead, controller writes the hardwa=
re error
> +        * event along with optional debug events in devie memory and hal=
ts. Driver
> +        * shall read the events from device memory, construct skbs and p=
ush
> +        * to rx_work item for further processing.
> +        */
> +       queue_work(data->workqueue, &data->hwexp_work);

So this is in an interrupt context, right? In that case we probably
can't process it directly, but I don't think it would be a problem to
process it on rx_work/btintel_pcie_rx_work since you can use
BTINTEL_PCIE_HWEXP_INPROGRESS to check that there is a exception to be
processed.

> +}
> +
>  static void btintel_pcie_rx_work(struct work_struct *work)
>  {
>         struct btintel_pcie_data *data =3D container_of(work,
> @@ -920,6 +1134,10 @@ static irqreturn_t btintel_pcie_irq_msix_handler(in=
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
> @@ -1000,7 +1218,8 @@ struct btintel_pcie_causes_list {
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
> @@ -1482,6 +1701,7 @@ static void btintel_pcie_release_hdev(struct btinte=
l_pcie_data *data)
>
>  static int btintel_pcie_setup_internal(struct hci_dev *hdev)
>  {
> +       struct btintel_data *data =3D hci_get_priv(hdev);
>         const u8 param[1] =3D { 0xFF };
>         struct intel_version_tlv ver_tlv;
>         struct sk_buff *skb;
> @@ -1520,6 +1740,7 @@ static int btintel_pcie_setup_internal(struct hci_d=
ev *hdev)
>                 goto exit_error;
>         }
>
> +       data->cnvi_top =3D ver_tlv.cnvi_top;
>         switch (INTEL_HW_PLATFORM(ver_tlv.cnvi_bt)) {
>         case 0x37:
>                 break;
> @@ -1667,6 +1888,8 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
>         skb_queue_head_init(&data->rx_skb_q);
>         INIT_WORK(&data->rx_work, btintel_pcie_rx_work);
>
> +       INIT_WORK(&data->hwexp_work, btintel_pcie_hwexp_work);
> +
>         data->boot_stage_cache =3D 0x00;
>         data->img_resp_cache =3D 0x00;
>
> @@ -1731,6 +1954,7 @@ static void btintel_pcie_remove(struct pci_dev *pde=
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
