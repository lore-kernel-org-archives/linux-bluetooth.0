Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927751FB3
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745246827; cv=none; b=U5SRWVmvw8gsxaqm2NFp90t7PECWSIV4S4IdvfWMlKKWnfmrjav8DR+GcjPAAK9veYGULiZZ5iqhADyUDI0d4lchPoz72ypybcei4/FbPT9e3A8yp527y7jlyHiTngQCK6cNqSfAePr9/OQYV/cOVL4nUQuvio2Ly7FTXGtWJzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745246827; c=relaxed/simple;
	bh=Zu3IiOJusrRwAY9RMMeCsyLDqpG+1pzuFy97mUkRvIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNAX5cgMEHljYxQy/dh9cHFKhDdS+cew/TkwCUlmFLYxpRb+pmNpyxXEzYMAHLQ4r3A0MW2oz5GXPddiBhlDQvgCb22ooQuwYfntow5qzQmUekSpyADztWY+KQPEAgk49Dq72xchcDY04lLnT67kg/Us5K91yi6w5cnISGBKwmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nolj+8YO; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nolj+8YO"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30db3f3c907so37546101fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745246824; x=1745851624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JX6ZiVx9fVwKngSSvAGg2S3TNEHv5xvxXcStGvU9quA=;
        b=Nolj+8YOTmSnZL1S3c8sWkx17vzTlvcX4rWNTmcyS28ELMfnGROzrNOlRL/edUH9vv
         KQ6i6iTGeVsANjhyXodbWbshLJk9xEOd2nr+70c2PFNnBs6WF/ysfaO7F88y6j9z7dos
         D0AASPowKo9+JSE1aPamCUm2TEAcel+Gc4ABaLcvVa6XTDLeFPXNMirzWZHrSbSLcbdZ
         eh/q6kOQdMmvoVle3a4tIlNne0VaeqfnRhCqpStLYfBmAwf7SAc430kP6snW/xd3vMmf
         Dg4VDucCLCXCTCury26TgTeQFBrIrEddL+caugD/0TToqY0Xf3lGQ1QKUA9FLZdPxaXc
         F9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745246824; x=1745851624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JX6ZiVx9fVwKngSSvAGg2S3TNEHv5xvxXcStGvU9quA=;
        b=ZoxLTt3BcpHaYUkyEkKSk4OcvjEUiNvAspLVy2DGsKPR3t+sxvp5W9smrl/IwJBFGs
         oO4kEwKaLcl9g4/d7W0MjJ7VFqbJSzRTruE75FqIUmTugvm/Udh2xbXbusqzg1QQa6K3
         J8zy+ES2zri6h/Tcn1EdNFLAtqq861Jl+1QoUCoWH6JqEgBGHb1stpGWq10Lwg1rLtl2
         DhA7xrnUDTXtUpXu7l4SUTqFLfQAmkyRJt7IOJEjfDEmcoYC/0BkW/KN/X1psVj0v3qz
         W1cXBzIXfCS5IaitRB2THNotI5O8uBzYQW++qrKB8JmI64g9pi4HByfi1zkjk6ro5Gaq
         TaTQ==
X-Gm-Message-State: AOJu0YwPVANTwLdCAGMTH7CwDarhhUpxR7N8YrJaF4W4/mNIJPEWgEmZ
	MKIfegKtO+860NvvdfBET5UkP7eQL8vQgq1EaOKsIx/RLBFnwPAHVNPp6fGQzqfP3Agu/ajx07q
	zeWNSUiWoQhfKhxCAxMY51yDstjQXOqR5
X-Gm-Gg: ASbGncsTlqflDnvk801EZdNZ5iEiAPtzPlg2kPXfKeZYFw0CPOhbe7bAsWnPMXkM6D5
	21zKDcpsPnnLowcTzf8pZL9CnV7f7kD4aLHt5UFV11Fplf9ZvqfiMHPrqtbDK0VL1y9Sx8/cOwi
	4CfUfi/o/0zF0FO7T7cNUR
X-Google-Smtp-Source: AGHT+IG37/QUVEYsfntKgjtCS44RVtDlPNTdwXsXzXenaUHKZIXO4wMSHnxbUi4tTccoIyslGG3IlO0geSsRxuctGoA=
X-Received: by 2002:a2e:8e8c:0:b0:30b:f469:47ef with SMTP id
 38308e7fff4ca-310905bacd4mr31023951fa.23.1745246823462; Mon, 21 Apr 2025
 07:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421092744.219097-1-kiran.k@intel.com>
In-Reply-To: <20250421092744.219097-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Apr 2025 10:46:50 -0400
X-Gm-Features: ATxdqUFHm0s0spQv4b3PEMxSvOmM0llCh28r4NHIUwoUf61UB4kr3CrA7p-gcXY
Message-ID: <CABBYNZKsnLQVcqCr4GzuaO+E0paeiQHUTi708phZ=-2DqYTA3A@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Dump debug registers on error
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com, 
	vijay.satija@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Mon, Apr 21, 2025 at 5:11=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
>
> Dumping debug registers on GP1 MSIx and error conditions, such as TX
> completion timeout, aiding in understanding the controller's state
> during errors. The register dump includes:
> - Boot stage
> - IPC control
> - IPC status
> - Mailbox registers
>
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com=
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 98 +++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btintel_pcie.h | 19 +++++++
>  2 files changed, 116 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index b73928e38d34..9b0629a1053f 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -208,6 +208,63 @@ static void btintel_pcie_prepare_tx(struct txq *txq,=
 u16 tfd_index,
>         memcpy(buf->data, skb->data, tfd->size);
>  }
>
> +static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hde=
v)
> +{
> +       struct btintel_pcie_data *data =3D hci_get_drvdata(hdev);
> +       u16 cr_hia, cr_tia;
> +       u32 reg, mbox_reg;
> +
> +       bt_dev_info(hdev, "---- Dump of debug registers ---");
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_BOOT_STAGE_R=
EG);
> +       bt_dev_info(hdev, "boot stage: 0x%8.8x", reg);
> +       data->boot_stage_cache =3D reg;
> +
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IPC_STATUS_R=
EG);
> +       bt_dev_info(hdev, "ipc status: 0x%8.8x", reg);
> +
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IPC_CONTROL_=
REG);
> +       bt_dev_info(hdev, "ipc control: 0x%8.8x", reg);
> +
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IPC_SLEEP_CT=
L_REG);
> +       bt_dev_info(hdev, "ipc sleep control: 0x%8.8x", reg);
> +
> +       /*Read the Mail box status and registers*/
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MBOX_STATUS_=
REG);
> +       bt_dev_info(hdev, "mbox status: 0x%8.8x", reg);
> +       if (reg & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX1) {
> +               mbox_reg =3D btintel_pcie_rd_reg32(data,
> +                                                BTINTEL_PCIE_CSR_MBOX_1_=
REG);
> +               bt_dev_info(hdev, "mbox_1: 0x%8.8x", mbox_reg);
> +       }
> +
> +       if (reg & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX2) {
> +               mbox_reg =3D btintel_pcie_rd_reg32(data,
> +                                                BTINTEL_PCIE_CSR_MBOX_2_=
REG);
> +               bt_dev_info(hdev, "mbox_2: 0x%8.8x", mbox_reg);
> +       }
> +
> +       if (reg & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX3) {
> +               mbox_reg =3D btintel_pcie_rd_reg32(data,
> +                                                BTINTEL_PCIE_CSR_MBOX_3_=
REG);
> +               bt_dev_info(hdev, "mbox_3: 0x%8.8x", mbox_reg);
> +       }
> +
> +       if (reg & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX4) {
> +               mbox_reg =3D btintel_pcie_rd_reg32(data,
> +                                                BTINTEL_PCIE_CSR_MBOX_4_=
REG);
> +               bt_dev_info(hdev, "mbox_4: 0x%8.8x", mbox_reg);
> +       }
> +
> +       cr_hia =3D data->ia.cr_hia[BTINTEL_PCIE_RXQ_NUM];
> +       cr_tia =3D data->ia.cr_tia[BTINTEL_PCIE_RXQ_NUM];
> +       bt_dev_info(hdev, "rxq: cr_tia: %u cr_hia: %u", cr_tia, cr_hia);
> +
> +       cr_hia =3D data->ia.cr_hia[BTINTEL_PCIE_TXQ_NUM];
> +       cr_tia =3D data->ia.cr_tia[BTINTEL_PCIE_TXQ_NUM];
> +       bt_dev_info(hdev, "txq: cr_tia: %u cr_hia: %u", cr_tia, cr_hia);
> +       bt_dev_info(hdev, "--------------------------------");

I'd go with bt_dev_info instead, also this may be a case where
hci_recv_diag could be used since it appears the intention here is for
diagnostic logging it on the monitor may help putting the pieces
together, otherwise one will need to look into dmesg logs + HCI traces
to know what was the traffic that generated such error.

> +}
> +
>  static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
>                                   struct sk_buff *skb)
>  {
> @@ -237,8 +294,11 @@ static int btintel_pcie_send_sync(struct btintel_pci=
e_data *data,
>         /* Wait for the complete interrupt - URBD0 */
>         ret =3D wait_event_timeout(data->tx_wait_q, data->tx_wait_done,
>                                  msecs_to_jiffies(BTINTEL_PCIE_TX_WAIT_TI=
MEOUT_MS));
> -       if (!ret)
> +       if (!ret) {
> +               bt_dev_err(data->hdev, "tx completion timeout");
> +               btintel_pcie_dump_debug_registers(data->hdev);
>                 return -ETIME;
> +       }
>
>         return 0;
>  }
> @@ -756,6 +816,26 @@ static int btintel_pcie_read_device_mem(struct btint=
el_pcie_data *data,
>         return 0;
>  }
>
> +static inline bool btintel_pcie_in_lockdown(struct btintel_pcie_data *da=
ta)
> +{
> +       return (data->boot_stage_cache &
> +               BTINTEL_PCIE_CSR_BOOT_STAGE_ROM_LOCKDOWN) ||
> +               (data->boot_stage_cache &
> +                BTINTEL_PCIE_CSR_BOOT_STAGE_IML_LOCKDOWN);
> +}
> +
> +static inline bool btintel_pcie_in_error(struct btintel_pcie_data *data)
> +{
> +       return (data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_DEVI=
CE_ERR) ||
> +               (data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_ABO=
RT_HANDLER);
> +}
> +
> +static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data=
)
> +{
> +       bt_dev_err(data->hdev, "Received gp1 mailbox interrupt");
> +       btintel_pcie_dump_debug_registers(data->hdev);
> +}
> +
>  /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
>   * BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES) which is sent for boot stage and=
 image response.
>   */
> @@ -779,6 +859,18 @@ static void btintel_pcie_msix_gp0_handler(struct bti=
ntel_pcie_data *data)
>         if (reg !=3D data->img_resp_cache)
>                 data->img_resp_cache =3D reg;
>
> +       if (btintel_pcie_in_error(data)) {
> +               bt_dev_err(data->hdev, "Controller in error state");
> +               btintel_pcie_dump_debug_registers(data->hdev);
> +               return;
> +       }
> +
> +       if (btintel_pcie_in_lockdown(data)) {
> +               bt_dev_err(data->hdev, "Controller in lockdown state");
> +               btintel_pcie_dump_debug_registers(data->hdev);
> +               return;
> +       }
> +
>         data->gp0_received =3D true;
>
>         old_ctxt =3D data->alive_intr_ctxt;
> @@ -1325,6 +1417,9 @@ static irqreturn_t btintel_pcie_irq_msix_handler(in=
t irq, void *dev_id)
>         if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP)
>                 btintel_pcie_msix_hw_exp_handler(data);
>
> +       if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1)
> +               btintel_pcie_msix_gp1_handler(data);
> +
>         /* This interrupt is triggered by the firmware after updating
>          * boot_stage register and image_response register
>          */
> @@ -2004,6 +2099,7 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
>         while ((err =3D btintel_pcie_setup_internal(hdev)) && fw_dl_retry=
++ < 1) {
>                 bt_dev_err(hdev, "Firmware download retry count: %d",
>                            fw_dl_retry);
> +               btintel_pcie_dump_debug_registers(hdev);
>                 err =3D btintel_pcie_reset_bt(data);
>                 if (err) {
>                         bt_dev_err(hdev, "Failed to do shr reset: %d", er=
r);
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel=
_pcie.h
> index 873178019cad..21b964b15c1c 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -12,10 +12,17 @@
>  #define BTINTEL_PCIE_CSR_HW_REV_REG            (BTINTEL_PCIE_CSR_BASE + =
0x028)
>  #define BTINTEL_PCIE_CSR_RF_ID_REG             (BTINTEL_PCIE_CSR_BASE + =
0x09C)
>  #define BTINTEL_PCIE_CSR_BOOT_STAGE_REG                (BTINTEL_PCIE_CSR=
_BASE + 0x108)
> +#define BTINTEL_PCIE_CSR_IPC_CONTROL_REG       (BTINTEL_PCIE_CSR_BASE + =
0x10C)
> +#define BTINTEL_PCIE_CSR_IPC_STATUS_REG                (BTINTEL_PCIE_CSR=
_BASE + 0x110)
>  #define BTINTEL_PCIE_CSR_IPC_SLEEP_CTL_REG     (BTINTEL_PCIE_CSR_BASE + =
0x114)
>  #define BTINTEL_PCIE_CSR_CI_ADDR_LSB_REG       (BTINTEL_PCIE_CSR_BASE + =
0x118)
>  #define BTINTEL_PCIE_CSR_CI_ADDR_MSB_REG       (BTINTEL_PCIE_CSR_BASE + =
0x11C)
>  #define BTINTEL_PCIE_CSR_IMG_RESPONSE_REG      (BTINTEL_PCIE_CSR_BASE + =
0x12C)
> +#define BTINTEL_PCIE_CSR_MBOX_1_REG            (BTINTEL_PCIE_CSR_BASE + =
0x170)
> +#define BTINTEL_PCIE_CSR_MBOX_2_REG            (BTINTEL_PCIE_CSR_BASE + =
0x174)
> +#define BTINTEL_PCIE_CSR_MBOX_3_REG            (BTINTEL_PCIE_CSR_BASE + =
0x178)
> +#define BTINTEL_PCIE_CSR_MBOX_4_REG            (BTINTEL_PCIE_CSR_BASE + =
0x17C)
> +#define BTINTEL_PCIE_CSR_MBOX_STATUS_REG       (BTINTEL_PCIE_CSR_BASE + =
0x180)
>  #define BTINTEL_PCIE_PRPH_DEV_ADDR_REG         (BTINTEL_PCIE_CSR_BASE + =
0x440)
>  #define BTINTEL_PCIE_PRPH_DEV_RD_REG           (BTINTEL_PCIE_CSR_BASE + =
0x458)
>  #define BTINTEL_PCIE_CSR_HBUS_TARG_WRPTR       (BTINTEL_PCIE_CSR_BASE + =
0x460)
> @@ -41,6 +48,9 @@
>  #define BTINTEL_PCIE_CSR_BOOT_STAGE_OPFW               (BIT(2))
>  #define BTINTEL_PCIE_CSR_BOOT_STAGE_ROM_LOCKDOWN       (BIT(10))
>  #define BTINTEL_PCIE_CSR_BOOT_STAGE_IML_LOCKDOWN       (BIT(11))
> +#define BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_ERR         (BIT(12))
> +#define BTINTEL_PCIE_CSR_BOOT_STAGE_ABORT_HANDLER      (BIT(13))
> +#define BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_HALTED      (BIT(14))
>  #define BTINTEL_PCIE_CSR_BOOT_STAGE_MAC_ACCESS_ON      (BIT(16))
>  #define BTINTEL_PCIE_CSR_BOOT_STAGE_ALIVE              (BIT(23))
>  #define BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY     (BIT(24))
> @@ -89,6 +99,7 @@ enum msix_fh_int_causes {
>  /* Causes for the HW register interrupts */
>  enum msix_hw_int_causes {
>         BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0     =3D BIT(0),       /* caus=
e 32 */
> +       BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1     =3D BIT(1),       /* caus=
e 33 */
>         BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP   =3D BIT(3),       /* caus=
e 35 */
>  };
>
> @@ -121,6 +132,14 @@ enum btintel_pcie_tlv_type {
>         BTINTEL_FW_BUILD,
>  };
>
> +/* causes for the MBOX interrupts */
> +enum msix_mbox_int_causes {
> +       BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX1 =3D BIT(0), /* cause MBOX1 */
> +       BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX2 =3D BIT(1), /* cause MBOX2 */
> +       BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX3 =3D BIT(2), /* cause MBOX3 */
> +       BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX4 =3D BIT(3), /* cause MBOX4 */
> +};
> +
>  #define BTINTEL_PCIE_MSIX_NON_AUTO_CLEAR_CAUSE BIT(7)
>
>  /* Minimum and Maximum number of MSI-X Vector
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
