Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6ED181CFE
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099395; cv=none; b=fFRscNlMsd+88kV9203N/JKe7rBbJg63+7W3MGHKVzF/4aPKNQ456GX3tO+Yq5v4/jkxW5rz6rcuUh9i+wPZgZRUWBsiBoby2671f7e9gf7u2t9eDWpeGRt5FT7ySbNbnj79SclSokt/VGaeN75WVdl4CqnMCSVe2oRn1/A6+4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099395; c=relaxed/simple;
	bh=ShcckxRsJG9qpAP1VPRfLjNQGkMIaRe3NmieVKmSTFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrGaejDk0tbDUHrWT1KCuPpTJsSIDD/n9PtSTlM3xdLvkes2J8SBXpJ8TLvpUxwV3B96W9vHhZaA3x8zjk3ToFyFDe7pXs1bCF/alDN/XBM1pW6pfFhH0DbWXJbivKn9Ff/GWCxvK9F4BDsmS55L4FNcGNTqcx3iLKqX2qs0gBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DM36ku2G; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DM36ku2G"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e3f6166e4aso19579061fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2024 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715099390; x=1715704190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyKOlYLkvyJNhDe3HhmpxTBBdFRKI6MxHK3x9RXjO9g=;
        b=DM36ku2GMGE6n4NcLGcSOm8brx52kfkVuKk/HiRXtqb2L3pbch4JNHgF7Dmg2weAXm
         yhJwqN/b+2KPDoevohCQ1MZGJyRkV8Xl9AsmGnXzdQH9nUPW5onfvvE7qCfxuVL/KvQ7
         BzGD92xvjxrFzeQQZyROqOUd1lii3NBJPNSAs2d/1xDkCZK3dk0P9qFy2WUNNwQYXS4o
         8tl4TrNfioxHIHqOywCIbV80KvTaLV/hdZM4lVTar2zvY59jXpvpKV34twBLz255RK8U
         1hVrKJwD7hrZDUb80XUeuUHFZFbKD1lpN2euQefQGLX0KVkXlRrPkv17X1LfaGGUwVTX
         4zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099390; x=1715704190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyKOlYLkvyJNhDe3HhmpxTBBdFRKI6MxHK3x9RXjO9g=;
        b=tQ8zD+/xMKBuhe01zGvG9iE58q2YXdIpsDW64+1ibQ/hv+gD1N+DepGj6FQK36QCxp
         tw+NTAl0VBCRJaYucS4jhtBZKDkCekON2BDaT6ct/wCuTJye1OODrf9gDUMuZF1XiIKv
         DH7Y2EO8ejIcTIhVZbrD/oeuM+FFtS2M7/tAVDZx4LrsTMoMotBO2oBma3fOesZu7lXS
         sMruq8Qs2VuXbqTOLxHi8WjxVNgpeNJardl7iID1i+sLt8XyV7gkj55RVSkO1xnizbw/
         5GuJLag+l6pGugDH3vwma/EzvzvWEIrh1I/HE1sW5b1+cN/ZODIBcv466Yl2d4UHEQ+o
         Mxpw==
X-Gm-Message-State: AOJu0Yw0cxfL9ohJZTlqJt20uMC57jqr9giZSAESm+5hhSJgU9GwEryF
	G5WIxP1N2nyqYAQpS9mRMrc+zidg1t7TFaagER0TafxWnJWuAyVnVV2TI+tKp/hDh611bbWpJ+J
	QAt4Ts/0b7HvdEw+cVSSr7+3KuCE=
X-Google-Smtp-Source: AGHT+IE9gXqJ979AX/oVsDibFUUD+JoMIBT1Y+qxTAd5y7Ymxypco8+vm7EwKXH5/dWrNIZvyrcXOcymN62vmlLTL4Y=
X-Received: by 2002:a2e:9141:0:b0:2e0:da20:2502 with SMTP id
 38308e7fff4ca-2e4476b98fbmr701201fa.49.1715099389634; Tue, 07 May 2024
 09:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507155658.294676-1-kiran.k@intel.com> <20240507155658.294676-2-kiran.k@intel.com>
In-Reply-To: <20240507155658.294676-2-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 May 2024 12:29:36 -0400
Message-ID: <CABBYNZJWfomEa-6LaEB8kKK5+CO_o5KZLJzeNkZpxT51FKkpow@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Bluetooth: btintel_pcie: Add support for PCIe transport
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com, 
	helgaas@kernel.org, pmenzel@molgen.mpg.de, 
	Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Tue, May 7, 2024 at 11:43=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> Add initial code to support Intel bluetooth devices based on PCIe
> transport. Allocate memory for TX & RX buffers, internal structures,
> initialize interrupts for TX & RX and PCIe device.
>
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Suggested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/Kconfig        |   12 +
>  drivers/bluetooth/Makefile       |    1 +
>  drivers/bluetooth/btintel.h      |    2 +-
>  drivers/bluetooth/btintel_pcie.c | 1057 ++++++++++++++++++++++++++++++
>  drivers/bluetooth/btintel_pcie.h |  425 ++++++++++++
>  5 files changed, 1496 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/bluetooth/btintel_pcie.c
>  create mode 100644 drivers/bluetooth/btintel_pcie.h
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index bc211c324206..41851b9a8070 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -478,5 +478,17 @@ config BT_NXPUART
>           Say Y here to compile support for NXP Bluetooth UART device int=
o
>           the kernel, or say M here to compile as a module (btnxpuart).
>
> +config BT_INTEL_PCIE
> +       tristate "Intel HCI PCIe driver"
> +       depends on PCI
> +       select BT_INTEL
> +       select FW_LOADER
> +       default y
> +       help
> +         Intel Bluetooth transport driver for PCIe.
> +         This driver is required if you want to use Intel Bluetooth devi=
ce
> +         with PCIe interface.
>
> +         Say Y here to compiler support for Intel Bluetooth PCIe device =
into
> +         the kernel or say M to compile it as module (btintel_pcie)
>  endmenu
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index 7a5967e9ac48..0730d6684d1a 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_BT_HCIBTUSB)     +=3D btusb.o
>  obj-$(CONFIG_BT_HCIBTSDIO)     +=3D btsdio.o
>
>  obj-$(CONFIG_BT_INTEL)         +=3D btintel.o
> +obj-$(CONFIG_BT_INTEL_PCIE)    +=3D btintel_pcie.o btintel.o
>  obj-$(CONFIG_BT_ATH3K)         +=3D ath3k.o
>  obj-$(CONFIG_BT_MRVL)          +=3D btmrvl.o
>  obj-$(CONFIG_BT_MRVL_SDIO)     +=3D btmrvl_sdio.o
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 1462a57420a0..5d4685b5c1fa 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -209,7 +209,7 @@ struct btintel_data {
>  #define btintel_wait_on_flag_timeout(hdev, nr, m, to)                  \
>                 wait_on_bit_timeout(btintel_get_flag(hdev), (nr), m, to)
>
> -#if IS_ENABLED(CONFIG_BT_INTEL)
> +#if IS_ENABLED(CONFIG_BT_INTEL) || IS_ENABLED(CONFIG_BT_INTEL_PCIE)
>
>  int btintel_check_bdaddr(struct hci_dev *hdev);
>  int btintel_enter_mfg(struct hci_dev *hdev);
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> new file mode 100644
> index 000000000000..911bb50d7ce7
> --- /dev/null
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -0,0 +1,1057 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  Bluetooth support for Intel PCIe devices
> + *
> + *  Copyright (C) 2024  Intel Corporation
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/firmware.h>
> +#include <linux/pci.h>
> +#include <linux/wait.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +
> +#include <asm/unaligned.h>
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include "btintel.h"
> +#include "btintel_pcie.h"
> +
> +#define VERSION "0.1"
> +
> +#define BTINTEL_PCI_DEVICE(dev, subdev)        \
> +       .vendor =3D PCI_VENDOR_ID_INTEL,  \
> +       .device =3D (dev),                \
> +       .subvendor =3D PCI_ANY_ID,        \
> +       .subdevice =3D (subdev),          \
> +       .driver_data =3D 0
> +
> +#define POLL_INTERVAL_US       10
> +
> +/* Intel Bluetooth PCIe device id table */
> +static const struct pci_device_id btintel_pcie_table[] =3D {
> +       { BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) },
> +       { 0 }
> +};
> +MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
> +
> +/* Intel PCIe uses 4 bytes of HCI type instead of 1 byte BT SIG HCI type=
 */
> +#define BTINTEL_PCIE_HCI_TYPE_LEN      4
> +#define BTINTEL_PCIE_HCI_ACL_PKT       0x00000002
> +#define BTINTEL_PCIE_HCI_SCO_PKT       0x00000003
> +#define BTINTEL_PCIE_HCI_EVT_PKT       0x00000004
> +
> +static inline void ipc_print_ia_ring(struct hci_dev *hdev, struct ia *ia=
,
> +                                    u16 queue_num)
> +{
> +       bt_dev_dbg(hdev, "IA: %s: tr-h:%02u  tr-t:%02u  cr-h:%02u  cr-t:%=
02u",
> +                  queue_num =3D=3D BTINTEL_PCIE_TXQ_NUM ? "TXQ" : "RXQ",
> +                  ia->tr_hia[queue_num], ia->tr_tia[queue_num],
> +                  ia->cr_hia[queue_num], ia->cr_tia[queue_num]);
> +}
> +
> +static inline void ipc_print_urbd1(struct hci_dev *hdev, struct urbd1 *u=
rbd1,
> +                                  u16 index)
> +{
> +       bt_dev_dbg(hdev, "RXQ:urbd1(%u) frbd_tag:%u status: 0x%x fixed:0x=
%x",
> +                  index, urbd1->frbd_tag, urbd1->status, urbd1->fixed);
> +}
> +
> +static int btintel_pcie_poll_bit(struct btintel_pcie_data *data, u32 off=
set,
> +                                u32 bits, u32 mask, int timeout_us)
> +{
> +       int t =3D 0;
> +       u32 reg;
> +
> +       do {
> +               reg =3D btintel_pcie_rd_reg32(data, offset);
> +
> +               if ((reg & mask) =3D=3D (bits & mask))
> +                       return t;
> +               udelay(POLL_INTERVAL_US);
> +               t +=3D POLL_INTERVAL_US;
> +       } while (t < timeout_us);
> +
> +       return -ETIMEDOUT;
> +}
> +
> +static struct btintel_pcie_data *btintel_pcie_get_data(struct msix_entry=
 *entry)
> +{
> +       u8 queue =3D entry->entry;
> +       struct msix_entry *entries =3D entry - queue;
> +
> +       return container_of(entries, struct btintel_pcie_data, msix_entri=
es[0]);
> +}
> +
> +/* Set the doorbell for RXQ to notify the device that @index (actually i=
ndex-1)
> + * is available to receive the data
> + */
> +static void btintel_pcie_set_rx_db(struct btintel_pcie_data *data, u16 i=
ndex)
> +{
> +       u32 val;
> +
> +       val =3D index;
> +       val |=3D (BTINTEL_PCIE_RX_DB_VEC << 16);
> +
> +       btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_HBUS_TARG_WRPTR, val=
);
> +}
> +
> +/* Update the FRBD (free buffer descriptor) with the @frbd_index and the
> + * DMA address of the free buffer.
> + */
> +static void btintel_pcie_prepare_rx(struct rxq *rxq, u16 frbd_index)
> +{
> +       struct data_buf *buf;
> +       struct frbd *frbd;
> +
> +       /* Get the buffer of the FRBD for DMA */
> +       buf =3D &rxq->bufs[frbd_index];
> +
> +       frbd =3D &rxq->frbds[frbd_index];
> +       memset(frbd, 0, sizeof(*frbd));
> +
> +       /* Update FRBD */
> +       frbd->tag =3D frbd_index;
> +       frbd->addr =3D buf->data_p_addr;
> +}
> +
> +static int btintel_pcie_submit_rx(struct btintel_pcie_data *data)
> +{
> +       u16 frbd_index;
> +       struct rxq *rxq =3D &data->rxq;
> +
> +       frbd_index =3D data->ia.tr_hia[BTINTEL_PCIE_RXQ_NUM];
> +
> +       if (frbd_index > rxq->count)
> +               return -ERANGE;
> +
> +       /* Prepare for RX submit. It updates the FRBD with the address of=
 DMA
> +        * buffer
> +        */
> +       btintel_pcie_prepare_rx(rxq, frbd_index);
> +
> +       frbd_index =3D (frbd_index + 1) % rxq->count;
> +       data->ia.tr_hia[BTINTEL_PCIE_RXQ_NUM] =3D frbd_index;
> +       ipc_print_ia_ring(data->hdev, &data->ia, BTINTEL_PCIE_RXQ_NUM);
> +
> +       /* Set the doorbell to notify the device */
> +       btintel_pcie_set_rx_db(data, frbd_index);
> +
> +       return 0;
> +}
> +
> +static int btintel_pcie_start_rx(struct btintel_pcie_data *data)
> +{
> +       int i, ret;
> +
> +       for (i =3D 0; i < BTINTEL_PCIE_RX_MAX_QUEUE; i++) {
> +               ret =3D btintel_pcie_submit_rx(data);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static void btintel_pcie_reset_ia(struct btintel_pcie_data *data)
> +{
> +       memset(data->ia.tr_hia, 0, sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES)=
;
> +       memset(data->ia.tr_tia, 0, sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES)=
;
> +       memset(data->ia.cr_hia, 0, sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES)=
;
> +       memset(data->ia.cr_tia, 0, sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES)=
;
> +}
> +
> +static void btintel_pcie_reset_bt(struct btintel_pcie_data *data)
> +{
> +       btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG,
> +                             BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET);
> +}
> +
> +/* This function enables BT function by setting BTINTEL_PCIE_CSR_FUNC_CT=
RL_MAC_INIT bit in
> + * BTINTEL_PCIE_CSR_FUNC_CTRL_REG register and wait for MSI-X with
> + * BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0.
> + * Then the host reads firmware version from BTINTEL_CSR_F2D_MBX and the=
 boot stage
> + * from BTINTEL_PCIE_CSR_BOOT_STAGE_REG.
> + */
> +static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
> +{
> +       int err;
> +       u32 reg;
> +
> +       data->gp0_received =3D false;
> +
> +       /* Update the DMA address of CI struct to CSR */
> +       btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_CI_ADDR_LSB_REG,
> +                             data->ci_p_addr & 0xffffffff);
> +       btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_CI_ADDR_MSB_REG,
> +                             data->ci_p_addr >> 32);
> +
> +       /* Reset the cached value of boot stage. it is updated by the MSI=
-X
> +        * gp0 interrupt handler.
> +        */
> +       data->boot_stage_cache =3D 0x0;
> +
> +       /* Set MAC_INIT bit to start primary bootloader */
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_RE=
G);
> +
> +       btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG,
> +                                 BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT);
> +
> +       /* Wait until MAC_ACCESS is granted */
> +       err =3D btintel_pcie_poll_bit(data, BTINTEL_PCIE_CSR_FUNC_CTRL_RE=
G,
> +                                   BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS=
_STS,
> +                                   BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS=
_STS,
> +                                   BTINTEL_DEFAULT_MAC_ACCESS_TIMEOUT_US=
);
> +       if (err < 0)
> +               return -ENODEV;
> +
> +       /* MAC is ready. Enable BT FUNC */
> +       btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG,
> +                                 BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_ENA |
> +                                 BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT);
> +
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_RE=
G);
> +
> +       /* wait for interrupt from the device after booting up to primary
> +        * bootloader.
> +        */
> +       err =3D wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> +                                msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TI=
MEOUT));
> +       if (!err)
> +               return -ETIME;
> +
> +       /* Check cached boot stage is BTINTEL_PCIE_CSR_BOOT_STAGE_ROM(BIT=
(0)) */
> +       if (~data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_ROM)
> +               return -ENODEV;
> +
> +       return 0;
> +}
> +
> +/* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
> + * BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES) which is sent for boot stage and=
 image response.
> + */
> +static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data=
)
> +{
> +       u32 reg;
> +
> +       /* This interrupt is for three different causes and it is not eas=
y to
> +        * know what causes the interrupt. So, it compares each register =
value
> +        * with cached value and update it before it wake up the queue.
> +        */
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_BOOT_STAGE_R=
EG);
> +       if (reg !=3D data->boot_stage_cache)
> +               data->boot_stage_cache =3D reg;
> +
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IMG_RESPONSE=
_REG);
> +       if (reg !=3D data->img_resp_cache)
> +               data->img_resp_cache =3D reg;
> +
> +       data->gp0_received =3D true;
> +
> +       /* If the boot stage is OP or IML, reset IA and start RX again */
> +       if (data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_OPFW ||
> +           data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_IML) {
> +               btintel_pcie_reset_ia(data);
> +               btintel_pcie_start_rx(data);
> +       }
> +
> +       wake_up(&data->gp0_wait_q);
> +}
> +
> +/* This function handles the MSX-X interrupt for rx queue 0 which is for=
 TX
> + */
> +static void btintel_pcie_msix_tx_handle(struct btintel_pcie_data *data)
> +{
> +       u16 cr_tia, cr_hia;
> +       struct txq *txq;
> +       struct urbd0 *urbd0;
> +
> +       cr_tia =3D data->ia.cr_tia[BTINTEL_PCIE_TXQ_NUM];
> +       cr_hia =3D data->ia.cr_hia[BTINTEL_PCIE_TXQ_NUM];
> +
> +       if (cr_tia =3D=3D cr_hia)
> +               return;
> +
> +       txq =3D &data->txq;
> +
> +       while (cr_tia !=3D cr_hia) {
> +               data->tx_wait_done =3D true;
> +               wake_up(&data->tx_wait_q);
> +
> +               urbd0 =3D &txq->urbd0s[cr_tia];
> +
> +               if (urbd0->tfd_index > txq->count)
> +                       return;
> +
> +               cr_tia =3D (cr_tia + 1) % txq->count;
> +               data->ia.cr_tia[BTINTEL_PCIE_TXQ_NUM] =3D cr_tia;
> +               ipc_print_ia_ring(data->hdev, &data->ia, BTINTEL_PCIE_TXQ=
_NUM);
> +       }
> +}
> +
> +/* Process the received rx data
> + * It check the frame header to identify the data type and create skb
> + * and calling HCI API
> + */
> +static int btintel_pcie_hci_recv_frame(struct btintel_pcie_data *data,
> +                                      struct sk_buff *skb)
> +{
> +       int ret;
> +       u8 pkt_type;
> +       u16 plen;
> +       u32 pcie_pkt_type;
> +       struct sk_buff *new_skb;
> +       void *pdata;
> +       struct hci_dev *hdev =3D data->hdev;
> +
> +       spin_lock(&data->hci_rx_lock);
> +
> +       /* The first 4 bytes indicates the Intel PCIe specific packet typ=
e */
> +       pdata =3D skb_pull_data(skb, BTINTEL_PCIE_HCI_TYPE_LEN);
> +       if (!data) {
> +               bt_dev_err(hdev, "Corrupted packet received");
> +               ret =3D -EILSEQ;
> +               goto exit_error;
> +       }
> +
> +       pcie_pkt_type =3D get_unaligned_le32(pdata);
> +
> +       switch (pcie_pkt_type) {
> +       case BTINTEL_PCIE_HCI_ACL_PKT:
> +               if (skb->len >=3D HCI_ACL_HDR_SIZE) {
> +                       plen =3D HCI_ACL_HDR_SIZE + __le16_to_cpu(hci_acl=
_hdr(skb)->dlen);
> +                       pkt_type =3D HCI_ACLDATA_PKT;
> +               } else {
> +                       bt_dev_err(hdev, "ACL packet is too short");
> +                       ret =3D -EILSEQ;
> +                       goto exit_error;
> +               }
> +               break;
> +
> +       case BTINTEL_PCIE_HCI_SCO_PKT:
> +               if (skb->len >=3D HCI_SCO_HDR_SIZE) {
> +                       plen =3D HCI_SCO_HDR_SIZE + hci_sco_hdr(skb)->dle=
n;
> +                       pkt_type =3D HCI_SCODATA_PKT;
> +               } else {
> +                       bt_dev_err(hdev, "SCO packet is too short");
> +                       ret =3D -EILSEQ;
> +                       goto exit_error;
> +               }
> +               break;
> +
> +       case BTINTEL_PCIE_HCI_EVT_PKT:
> +               if (skb->len >=3D HCI_EVENT_HDR_SIZE) {
> +                       plen =3D HCI_EVENT_HDR_SIZE + hci_event_hdr(skb)-=
>plen;
> +                       pkt_type =3D HCI_EVENT_PKT;
> +               } else {
> +                       bt_dev_err(hdev, "Event packet is too short");
> +                       ret =3D -EILSEQ;
> +                       goto exit_error;
> +               }
> +               break;
> +       default:
> +               bt_dev_err(hdev, "Invalid packet type received: 0x%4.4x",
> +                          pcie_pkt_type);
> +               ret =3D -EINVAL;
> +               goto exit_error;
> +       }
> +
> +       if (skb->len < plen) {
> +               bt_dev_err(hdev, "Received corrupted packet. type: 0x%2.2=
x",
> +                          pkt_type);
> +               ret =3D -EILSEQ;
> +               goto exit_error;
> +       }
> +
> +       bt_dev_dbg(hdev, "pkt_type: 0x%2.2x len: %u", pkt_type, plen);
> +
> +       new_skb =3D bt_skb_alloc(plen, GFP_ATOMIC);
> +       if (!new_skb) {
> +               bt_dev_err(hdev, "Failed to allocate memory for skb of le=
n: %u",
> +                          skb->len);
> +               ret =3D -ENOMEM;
> +               goto exit_error;
> +       }
> +
> +       hci_skb_pkt_type(new_skb) =3D pkt_type;
> +       skb_put_data(new_skb, skb->data, plen);
> +       hdev->stat.byte_rx +=3D plen;
> +
> +       if (pcie_pkt_type =3D=3D BTINTEL_PCIE_HCI_EVT_PKT)
> +               ret =3D btintel_recv_event(hdev, new_skb);
> +       else
> +               ret =3D hci_recv_frame(hdev, new_skb);
> +
> +exit_error:
> +       if (ret)
> +               hdev->stat.err_rx++;
> +
> +       spin_unlock(&data->hci_rx_lock);
> +
> +       return ret;
> +}
> +
> +static void btintel_pcie_rx_work(struct work_struct *work)
> +{
> +       struct btintel_pcie_data *data =3D container_of(work,
> +                                       struct btintel_pcie_data, rx_work=
);
> +       struct sk_buff *skb;
> +       int err;
> +       struct hci_dev *hdev =3D data->hdev;
> +
> +       /* Process the sk_buf in queue and send to the HCI layer */
> +       while ((skb =3D skb_dequeue(&data->rx_skb_q))) {
> +               err =3D btintel_pcie_hci_recv_frame(data, skb);
> +               if (err)
> +                       bt_dev_err(hdev, "Failed to send received frame: =
%d",
> +                                  err);
> +               kfree_skb(skb);
> +       }
> +}
> +
> +/* create sk_buff with data and save it to queue and start RX work */
> +static int btintel_pcie_submit_rx_work(struct btintel_pcie_data *data, u=
8 status,
> +                                      void *buf)
> +{
> +       int ret, len;
> +       struct rfh_hdr *rfh_hdr;
> +       struct sk_buff *skb;
> +
> +       rfh_hdr =3D buf;
> +
> +       len =3D rfh_hdr->packet_len;
> +       if (len <=3D 0) {
> +               ret =3D -EINVAL;
> +               goto resubmit;
> +       }
> +
> +       /* Remove RFH header */
> +       buf +=3D sizeof(*rfh_hdr);
> +
> +       skb =3D alloc_skb(len, GFP_ATOMIC);
> +       if (!skb) {
> +               ret =3D -ENOMEM;
> +               goto resubmit;
> +       }
> +
> +       skb_put_data(skb, buf, len);
> +       skb_queue_tail(&data->rx_skb_q, skb);
> +       queue_work(data->workqueue, &data->rx_work);
> +
> +resubmit:
> +       ret =3D btintel_pcie_submit_rx(data);
> +
> +       return ret;
> +}
> +
> +/* Handles the MSI-X interrupt for rx queue 1 which is for RX */
> +static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
> +{
> +       u16 cr_hia, cr_tia;
> +       struct rxq *rxq;
> +       struct urbd1 *urbd1;
> +       struct frbd *frbd;
> +       struct data_buf *buf;
> +       int ret;
> +       struct hci_dev *hdev =3D data->hdev;
> +
> +       cr_hia =3D data->ia.cr_hia[BTINTEL_PCIE_RXQ_NUM];
> +       cr_tia =3D data->ia.cr_tia[BTINTEL_PCIE_RXQ_NUM];
> +
> +       bt_dev_dbg(hdev, "RXQ: cr_hia: %u  cr_tia: %u", cr_hia, cr_tia);
> +
> +       /* Check CR_TIA and CR_HIA for change */
> +       if (cr_tia =3D=3D cr_hia) {
> +               bt_dev_warn(hdev, "RXQ: no new CD found");
> +               return;
> +       }
> +
> +       rxq =3D &data->rxq;
> +
> +       /* The firmware sends multiple CD in a single MSI-X and it needs =
to
> +        * process all received CDs in this interrupt.
> +        */
> +       while (cr_tia !=3D cr_hia) {
> +               urbd1 =3D &rxq->urbd1s[cr_tia];
> +               ipc_print_urbd1(data->hdev, urbd1, cr_tia);
> +
> +               frbd =3D &rxq->frbds[urbd1->frbd_tag];
> +
> +               buf =3D &rxq->bufs[urbd1->frbd_tag];
> +               if (!buf) {
> +                       bt_dev_err(hdev, "RXQ: failed to get the DMA buff=
er for %d",
> +                                  urbd1->frbd_tag);
> +                       return;
> +               }
> +
> +               ret =3D btintel_pcie_submit_rx_work(data, urbd1->status,
> +                                                 buf->data);
> +               if (ret) {
> +                       bt_dev_err(hdev, "RXQ: failed to submit rx reques=
t");
> +                       return;
> +               }
> +
> +               cr_tia =3D (cr_tia + 1) % rxq->count;
> +               data->ia.cr_tia[BTINTEL_PCIE_RXQ_NUM] =3D cr_tia;
> +               ipc_print_ia_ring(data->hdev, &data->ia, BTINTEL_PCIE_RXQ=
_NUM);
> +       }
> +}
> +
> +static irqreturn_t btintel_pcie_msix_isr(int irq, void *data)
> +{
> +       return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
> +{
> +       struct msix_entry *entry =3D dev_id;
> +       struct btintel_pcie_data *data =3D btintel_pcie_get_data(entry);
> +       u32 intr_fh, intr_hw;
> +
> +       spin_lock(&data->irq_lock);
> +       intr_fh =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MSIX_FH_=
INT_CAUSES);
> +       intr_hw =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MSIX_HW_=
INT_CAUSES);
> +
> +       /* Clear causes registers to avoid being handling the same cause =
*/
> +       btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_MSIX_FH_INT_CAUSES, =
intr_fh);
> +       btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES, =
intr_hw);
> +       spin_unlock(&data->irq_lock);
> +
> +       if (unlikely(!(intr_fh | intr_hw))) {
> +               /* Ignore interrupt, inta =3D=3D 0 */
> +               return IRQ_NONE;
> +       }
> +
> +       /* This interrupt is triggered by the firmware after updating
> +        * boot_stage register and image_response register
> +        */
> +       if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0)
> +               btintel_pcie_msix_gp0_handler(data);
> +
> +       /* For TX */
> +       if (intr_fh & BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0)
> +               btintel_pcie_msix_tx_handle(data);
> +
> +       /* For RX */
> +       if (intr_fh & BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1)
> +               btintel_pcie_msix_rx_handle(data);
> +
> +       /*
> +        * Before sending the interrupt the HW disables it to prevent a n=
ested
> +        * interrupt. This is done by writing 1 to the corresponding bit =
in
> +        * the mask register. After handling the interrupt, it should be
> +        * re-enabled by clearing this bit. This register is defined as w=
rite 1
> +        * clear (W1C) register, meaning that it's cleared by writing 1
> +        * to the bit.
> +        */
> +       btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_MSIX_AUTOMASK_ST,
> +                             BIT(entry->entry));
> +
> +       return IRQ_HANDLED;
> +}
> +
> +/* This function requests the irq for MSI-X and registers the handlers p=
er irq.
> + * Currently, it requests only 1 irq for all interrupt causes.
> + */
> +static int btintel_pcie_setup_irq(struct btintel_pcie_data *data)
> +{
> +       int err;
> +       int num_irqs, i;
> +
> +       for (i =3D 0; i < BTINTEL_PCIE_MSIX_VEC_MAX; i++)
> +               data->msix_entries[i].entry =3D i;
> +
> +       num_irqs =3D pci_alloc_irq_vectors(data->pdev, BTINTEL_PCIE_MSIX_=
VEC_MIN,
> +                                        BTINTEL_PCIE_MSIX_VEC_MAX, PCI_I=
RQ_MSIX);
> +       if (num_irqs < 0)
> +               return num_irqs;
> +
> +       data->alloc_vecs =3D num_irqs;
> +       data->msix_enabled =3D 1;
> +       data->def_irq =3D 0;
> +
> +       /* setup irq handler */
> +       for (i =3D 0; i < data->alloc_vecs; i++) {
> +               struct msix_entry *msix_entry;
> +
> +               msix_entry =3D &data->msix_entries[i];
> +               msix_entry->vector =3D pci_irq_vector(data->pdev, i);
> +
> +               err =3D devm_request_threaded_irq(&data->pdev->dev,
> +                                               msix_entry->vector,
> +                                               btintel_pcie_msix_isr,
> +                                               btintel_pcie_irq_msix_han=
dler,
> +                                               IRQF_SHARED,
> +                                               KBUILD_MODNAME,
> +                                               msix_entry);
> +               if (err) {
> +                       pci_free_irq_vectors(data->pdev);
> +                       data->alloc_vecs =3D 0;
> +                       return err;
> +               }
> +       }
> +       return 0;
> +}
> +
> +struct btintel_pcie_causes_list {
> +       u32 cause;
> +       u32 mask_reg;
> +       u8 cause_num;
> +};
> +
> +struct btintel_pcie_causes_list causes_list[] =3D {
> +       { BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0,    BTINTEL_PCIE_CSR_MSIX_FH_=
INT_MASK,      0x00 },
> +       { BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1,    BTINTEL_PCIE_CSR_MSIX_FH_=
INT_MASK,      0x01 },
> +       { BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0, BTINTEL_PCIE_CSR_MSIX_HW_I=
NT_MASK,       0x20 },
> +};
> +
> +/* This function configures the interrupt masks for both HW_INT_CAUSES a=
nd
> + * FH_INT_CAUSES which are meaningful to us.
> + *
> + * After resetting BT function via PCIE FLR or FUNC_CTRL reset, the driv=
er
> + * need to call this function again to configure since the masks
> + * are reset to 0xFFFFFFFF after reset.
> + */
> +static void btintel_pcie_config_msix(struct btintel_pcie_data *data)
> +{
> +       int i;
> +       int val =3D data->def_irq | BTINTEL_PCIE_MSIX_NON_AUTO_CLEAR_CAUS=
E;
> +
> +       /* Set Non Auto Clear Cause */
> +       for (i =3D 0; i < ARRAY_SIZE(causes_list); i++) {
> +               btintel_pcie_wr_reg8(data,
> +                                    BTINTEL_PCIE_CSR_MSIX_IVAR(causes_li=
st[i].cause_num),
> +                                    val);
> +               btintel_pcie_clr_reg_bits(data,
> +                                         causes_list[i].mask_reg,
> +                                         causes_list[i].cause);
> +       }
> +
> +       /* Save the initial interrupt mask */
> +       data->fh_init_mask =3D ~btintel_pcie_rd_reg32(data, BTINTEL_PCIE_=
CSR_MSIX_FH_INT_MASK);
> +       data->hw_init_mask =3D ~btintel_pcie_rd_reg32(data, BTINTEL_PCIE_=
CSR_MSIX_HW_INT_MASK);
> +}
> +
> +static int btintel_pcie_config_pcie(struct pci_dev *pdev,
> +                                   struct btintel_pcie_data *data)
> +{
> +       int err;
> +
> +       err =3D pcim_enable_device(pdev);
> +       if (err)
> +               return err;
> +
> +       pci_set_master(pdev);
> +
> +       err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +       if (err) {
> +               err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MAS=
K(32));
> +               if (err)
> +                       return err;
> +       }
> +
> +       err =3D pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
> +       if (err)
> +               return err;
> +
> +       data->base_addr =3D pcim_iomap_table(pdev)[0];
> +       if (!data->base_addr)
> +               return -ENODEV;
> +
> +       err =3D btintel_pcie_setup_irq(data);
> +       if (err)
> +               return err;
> +
> +       /* Configure MSI-X with causes list */
> +       btintel_pcie_config_msix(data);
> +
> +       return 0;
> +}
> +
> +static void btintel_pcie_init_ci(struct btintel_pcie_data *data,
> +                                struct ctx_info *ci)
> +{
> +       ci->version =3D 0x1;
> +       ci->size =3D sizeof(*ci);
> +       ci->config =3D 0x0000;
> +       ci->addr_cr_hia =3D data->ia.cr_hia_p_addr;
> +       ci->addr_tr_tia =3D data->ia.tr_tia_p_addr;
> +       ci->addr_cr_tia =3D data->ia.cr_tia_p_addr;
> +       ci->addr_tr_hia =3D data->ia.tr_hia_p_addr;
> +       ci->num_cr_ia =3D BTINTEL_PCIE_NUM_QUEUES;
> +       ci->num_tr_ia =3D BTINTEL_PCIE_NUM_QUEUES;
> +       ci->addr_urbdq0 =3D data->txq.urbd0s_p_addr;
> +       ci->addr_tfdq =3D data->txq.tfds_p_addr;
> +       ci->num_tfdq =3D data->txq.count;
> +       ci->num_urbdq0 =3D data->txq.count;
> +       ci->tfdq_db_vec =3D BTINTEL_PCIE_TXQ_NUM;
> +       ci->urbdq0_db_vec =3D BTINTEL_PCIE_TXQ_NUM;
> +       ci->rbd_size =3D BTINTEL_PCIE_RBD_SIZE_4K;
> +       ci->addr_frbdq =3D data->rxq.frbds_p_addr;
> +       ci->num_frbdq =3D data->rxq.count;
> +       ci->frbdq_db_vec =3D BTINTEL_PCIE_RXQ_NUM;
> +       ci->addr_urbdq1 =3D data->rxq.urbd1s_p_addr;
> +       ci->num_urbdq1 =3D data->rxq.count;
> +       ci->urbdq_db_vec =3D BTINTEL_PCIE_RXQ_NUM;
> +}
> +
> +static void btintel_pcie_free_txq_bufs(struct btintel_pcie_data *data,
> +                                      struct txq *txq)
> +{
> +       /* Free data buffers first */
> +       dma_free_coherent(&data->pdev->dev, txq->count * BTINTEL_PCIE_BUF=
FER_SIZE,
> +                         txq->buf_v_addr, txq->buf_p_addr);
> +       kfree(txq->bufs);
> +}
> +
> +static int btintel_pcie_setup_txq_bufs(struct btintel_pcie_data *data,
> +                                      struct txq *txq)
> +{
> +       int i;
> +       struct data_buf *buf;
> +
> +       /* Allocate the same number of buffers as the descriptor */
> +       txq->bufs =3D kmalloc_array(txq->count, sizeof(*buf), GFP_KERNEL)=
;
> +       if (!txq->bufs)
> +               return -ENOMEM;
> +
> +       /* Allocate full chunk of data buffer for DMA first and do indexi=
ng and
> +        * initialization next, so it can be freed easily
> +        */
> +       txq->buf_v_addr =3D dma_alloc_coherent(&data->pdev->dev,
> +                                            txq->count * BTINTEL_PCIE_BU=
FFER_SIZE,
> +                                            &txq->buf_p_addr,
> +                                            GFP_KERNEL | __GFP_NOWARN);
> +       if (!txq->buf_v_addr) {
> +               kfree(txq->bufs);
> +               return -ENOMEM;
> +       }
> +       memset(txq->buf_v_addr, 0, txq->count * BTINTEL_PCIE_BUFFER_SIZE)=
;
> +
> +       /* Setup the allocated DMA buffer to bufs. Each data_buf should
> +        * have virtual address and physical address
> +        */
> +       for (i =3D 0; i < txq->count; i++) {
> +               buf =3D &txq->bufs[i];
> +               buf->data_p_addr =3D txq->buf_p_addr + (i * BTINTEL_PCIE_=
BUFFER_SIZE);
> +               buf->data =3D txq->buf_v_addr + (i * BTINTEL_PCIE_BUFFER_=
SIZE);
> +       }
> +
> +       return 0;
> +}
> +
> +static void btintel_pcie_free_rxq_bufs(struct btintel_pcie_data *data,
> +                                      struct rxq *rxq)
> +{
> +       /* Free data buffers first */
> +       dma_free_coherent(&data->pdev->dev, rxq->count * BTINTEL_PCIE_BUF=
FER_SIZE,
> +                         rxq->buf_v_addr, rxq->buf_p_addr);
> +       kfree(rxq->bufs);
> +}
> +
> +static int btintel_pcie_setup_rxq_bufs(struct btintel_pcie_data *data,
> +                                      struct rxq *rxq)
> +{
> +       int i;
> +       struct data_buf *buf;
> +
> +       /* Allocate the same number of buffers as the descriptor */
> +       rxq->bufs =3D kmalloc_array(rxq->count, sizeof(*buf), GFP_KERNEL)=
;
> +       if (!rxq->bufs)
> +               return -ENOMEM;
> +
> +       /* Allocate full chunk of data buffer for DMA first and do indexi=
ng and
> +        * initialization next, so it can be freed easily
> +        */
> +       rxq->buf_v_addr =3D dma_alloc_coherent(&data->pdev->dev,
> +                                            rxq->count * BTINTEL_PCIE_BU=
FFER_SIZE,
> +                                            &rxq->buf_p_addr,
> +                                            GFP_KERNEL | __GFP_NOWARN);
> +       if (!rxq->buf_v_addr) {
> +               kfree(rxq->bufs);
> +               return -ENOMEM;
> +       }
> +       memset(rxq->buf_v_addr, 0, rxq->count * BTINTEL_PCIE_BUFFER_SIZE)=
;
> +
> +       /* Setup the allocated DMA buffer to bufs. Each data_buf should
> +        * have virtual address and physical address
> +        */
> +       for (i =3D 0; i < rxq->count; i++) {
> +               buf =3D &rxq->bufs[i];
> +               buf->data_p_addr =3D rxq->buf_p_addr + (i * BTINTEL_PCIE_=
BUFFER_SIZE);
> +               buf->data =3D rxq->buf_v_addr + (i * BTINTEL_PCIE_BUFFER_=
SIZE);
> +       }
> +
> +       return 0;
> +}
> +
> +static void btintel_pcie_setup_ia(struct btintel_pcie_data *data,
> +                                 dma_addr_t p_addr, void *v_addr,
> +                                 struct ia *ia)
> +{
> +       /* TR Head Index Array */
> +       ia->tr_hia_p_addr =3D p_addr;
> +       ia->tr_hia =3D v_addr;
> +
> +       /* TR Tail Index Array */
> +       ia->tr_tia_p_addr =3D p_addr + sizeof(u16) * BTINTEL_PCIE_NUM_QUE=
UES;
> +       ia->tr_tia =3D v_addr + sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES;
> +
> +       /* CR Head index Array */
> +       ia->cr_hia_p_addr =3D p_addr + (sizeof(u16) * BTINTEL_PCIE_NUM_QU=
EUES * 2);
> +       ia->cr_hia =3D v_addr + (sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * =
2);
> +
> +       /* CR Tail Index Array */
> +       ia->cr_tia_p_addr =3D p_addr + (sizeof(u16) * BTINTEL_PCIE_NUM_QU=
EUES * 3);
> +       ia->cr_tia =3D v_addr + (sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * =
3);
> +}
> +
> +static void btintel_pcie_free(struct btintel_pcie_data *data)
> +{
> +       btintel_pcie_free_rxq_bufs(data, &data->rxq);
> +       btintel_pcie_free_txq_bufs(data, &data->txq);
> +
> +       dma_pool_free(data->dma_pool, data->dma_v_addr, data->dma_p_addr)=
;
> +       dma_pool_destroy(data->dma_pool);
> +}
> +
> +/* Allocate tx and rx queues, any related data structures and buffers.
> + */
> +static int btintel_pcie_alloc(struct btintel_pcie_data *data)
> +{
> +       int err =3D 0;
> +       size_t total;
> +       dma_addr_t p_addr;
> +       void *v_addr;
> +
> +       /* Allocate the chunk of DMA memory for descriptors, index array,=
 and
> +        * context information, instead of allocating individually.
> +        * The DMA memory for data buffer is allocated while setting up t=
he
> +        * each queue.
> +        *
> +        * Total size is sum of the following
> +        *  + size of TFD * Number of descriptors in queue
> +        *  + size of URBD0 * Number of descriptors in queue
> +        *  + size of FRBD * Number of descriptors in queue
> +        *  + size of URBD1 * Number of descriptors in queue
> +        *  + size of index * Number of queues(2) * type of index array(4=
)
> +        *  + size of context information
> +        */
> +       total =3D (sizeof(struct tfd) + sizeof(struct urbd0) + sizeof(str=
uct frbd)
> +               + sizeof(struct urbd1)) * BTINTEL_DESCS_COUNT;
> +
> +       /* Add the sum of size of index array and size of ci struct */
> +       total +=3D (sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 4) + sizeof(s=
truct ctx_info);
> +
> +       /* Allocate DMA Pool */
> +       data->dma_pool =3D dma_pool_create(KBUILD_MODNAME, &data->pdev->d=
ev,
> +                                        total, BTINTEL_PCIE_DMA_POOL_ALI=
GNMENT, 0);
> +       if (!data->dma_pool) {
> +               err =3D -ENOMEM;
> +               goto exit_error;
> +       }
> +
> +       v_addr =3D dma_pool_zalloc(data->dma_pool, GFP_KERNEL | __GFP_NOW=
ARN,
> +                                &p_addr);
> +       if (!v_addr) {
> +               dma_pool_destroy(data->dma_pool);
> +               err =3D -ENOMEM;
> +               goto exit_error;
> +       }
> +
> +       data->dma_p_addr =3D p_addr;
> +       data->dma_v_addr =3D v_addr;
> +
> +       /* Setup descriptor count */
> +       data->txq.count =3D BTINTEL_DESCS_COUNT;
> +       data->rxq.count =3D BTINTEL_DESCS_COUNT;
> +
> +       /* Setup tfds */
> +       data->txq.tfds_p_addr =3D p_addr;
> +       data->txq.tfds =3D v_addr;
> +
> +       p_addr +=3D (sizeof(struct tfd) * BTINTEL_DESCS_COUNT);
> +       v_addr +=3D (sizeof(struct tfd) * BTINTEL_DESCS_COUNT);
> +
> +       /* Setup urbd0 */
> +       data->txq.urbd0s_p_addr =3D p_addr;
> +       data->txq.urbd0s =3D v_addr;
> +
> +       p_addr +=3D (sizeof(struct urbd0) * BTINTEL_DESCS_COUNT);
> +       v_addr +=3D (sizeof(struct urbd0) * BTINTEL_DESCS_COUNT);
> +
> +       /* Setup FRBD*/
> +       data->rxq.frbds_p_addr =3D p_addr;
> +       data->rxq.frbds =3D v_addr;
> +
> +       p_addr +=3D (sizeof(struct frbd) * BTINTEL_DESCS_COUNT);
> +       v_addr +=3D (sizeof(struct frbd) * BTINTEL_DESCS_COUNT);
> +
> +       /* Setup urbd1 */
> +       data->rxq.urbd1s_p_addr =3D p_addr;
> +       data->rxq.urbd1s =3D v_addr;
> +
> +       p_addr +=3D (sizeof(struct urbd1) * BTINTEL_DESCS_COUNT);
> +       v_addr +=3D (sizeof(struct urbd1) * BTINTEL_DESCS_COUNT);
> +
> +       /* Setup data buffers for txq */
> +       err =3D btintel_pcie_setup_txq_bufs(data, &data->txq);
> +       if (err)
> +               goto exit_error_pool;
> +
> +       /* Setup data buffers for rxq */
> +       err =3D btintel_pcie_setup_rxq_bufs(data, &data->rxq);
> +       if (err)
> +               goto exit_error_txq;
> +
> +       /* Setup Index Array */
> +       btintel_pcie_setup_ia(data, p_addr, v_addr, &data->ia);
> +
> +       /* Setup Context Information */
> +       p_addr +=3D sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 4;
> +       v_addr +=3D sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 4;
> +
> +       data->ci =3D v_addr;
> +       data->ci_p_addr =3D p_addr;
> +
> +       /* Initialize the CI */
> +       btintel_pcie_init_ci(data, data->ci);
> +
> +       return 0;
> +
> +exit_error_txq:
> +       btintel_pcie_free_txq_bufs(data, &data->txq);
> +exit_error_pool:
> +       dma_pool_free(data->dma_pool, data->dma_v_addr, data->dma_p_addr)=
;
> +       dma_pool_destroy(data->dma_pool);
> +exit_error:
> +       return err;
> +}
> +
> +static void btintel_pcie_release_hdev(struct btintel_pcie_data *data)
> +{
> +       /* TODO: Unregister and release hdev */
> +}
> +
> +static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
> +{
> +       /* TODO: initialize hdev and assign the callbacks to hdev */
> +       return -ENODEV;

So it looks to me that this would never work until we implement the
TODO item above, in which case this is sort of useless to be enabled
by default, so what is holding us to properly initialize the hdev? Or
you want to do that in a follow-up change? Then again let's not enable
it by default if it is incomplete.

> +}
> +
> +static int btintel_pcie_probe(struct pci_dev *pdev,
> +                             const struct pci_device_id *ent)
> +{
> +       int err;
> +       struct btintel_pcie_data *data;
> +
> +       if (!pdev)
> +               return -ENODEV;
> +
> +       data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->pdev =3D pdev;
> +
> +       spin_lock_init(&data->irq_lock);
> +       spin_lock_init(&data->hci_rx_lock);
> +
> +       init_waitqueue_head(&data->gp0_wait_q);
> +       data->gp0_received =3D false;
> +
> +       init_waitqueue_head(&data->tx_wait_q);
> +       data->tx_wait_done =3D false;
> +
> +       data->workqueue =3D alloc_ordered_workqueue(KBUILD_MODNAME, WQ_HI=
GHPRI);
> +       if (!data->workqueue)
> +               return -ENOMEM;
> +
> +       skb_queue_head_init(&data->rx_skb_q);
> +       INIT_WORK(&data->rx_work, btintel_pcie_rx_work);
> +
> +       data->boot_stage_cache =3D 0x00;
> +       data->img_resp_cache =3D 0x00;
> +
> +       err =3D btintel_pcie_config_pcie(pdev, data);
> +       if (err)
> +               goto exit_error;
> +
> +       pci_set_drvdata(pdev, data);
> +
> +       err =3D btintel_pcie_alloc(data);
> +       if (err)
> +               goto exit_error;
> +
> +       err =3D btintel_pcie_enable_bt(data);
> +       if (err)
> +               goto exit_error;
> +
> +       /* CNV information (CNVi and CNVr) is in CSR */
> +       data->cnvi =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_HW_RE=
V_REG);
> +
> +       data->cnvr =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_RF_ID=
_REG);
> +
> +       err =3D btintel_pcie_start_rx(data);
> +       if (err)
> +               goto exit_error;
> +
> +       err =3D btintel_pcie_setup_hdev(data);
> +       if (err)
> +               goto exit_error;
> +
> +       bt_dev_dbg(data->hdev, "cnvi: 0x%8.8x cnvr: 0x%8.8x", data->cnvi,
> +                  data->cnvr);
> +       return 0;
> +
> +exit_error:
> +       /* reset device before exit */
> +       btintel_pcie_reset_bt(data);
> +
> +       pci_clear_master(pdev);
> +
> +       pci_set_drvdata(pdev, NULL);
> +
> +       return err;
> +}
> +
> +static void btintel_pcie_remove(struct pci_dev *pdev)
> +{
> +       struct btintel_pcie_data *data;
> +
> +       data =3D pci_get_drvdata(pdev);
> +
> +       btintel_pcie_reset_bt(data);
> +
> +       pci_free_irq_vectors(pdev);
> +
> +       btintel_pcie_release_hdev(data);
> +
> +       flush_work(&data->rx_work);
> +
> +       destroy_workqueue(data->workqueue);
> +
> +       btintel_pcie_free(data);
> +
> +       pci_clear_master(pdev);
> +
> +       pci_set_drvdata(pdev, NULL);
> +}
> +
> +static struct pci_driver btintel_pcie_driver =3D {
> +       .name =3D KBUILD_MODNAME,
> +       .id_table =3D btintel_pcie_table,
> +       .probe =3D btintel_pcie_probe,
> +       .remove =3D btintel_pcie_remove,
> +};
> +module_pci_driver(btintel_pcie_driver);
> +
> +MODULE_AUTHOR("Tedd Ho-Jeong An <tedd.an@intel.com>");
> +MODULE_DESCRIPTION("Intel Bluetooth PCIe transport driver ver " VERSION)=
;
> +MODULE_VERSION(VERSION);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel=
_pcie.h
> new file mode 100644
> index 000000000000..f925dfb23cfc
> --- /dev/null
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -0,0 +1,425 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *
> + *  Bluetooth support for Intel PCIe devices
> + *
> + *  Copyright (C) 2024  Intel Corporation
> + */
> +
> +/* Control and Status Register(BTINTEL_PCIE_CSR) */
> +#define BTINTEL_PCIE_CSR_BASE                  (0x000)
> +#define BTINTEL_PCIE_CSR_FUNC_CTRL_REG         (BTINTEL_PCIE_CSR_BASE + =
0x024)
> +#define BTINTEL_PCIE_CSR_HW_REV_REG            (BTINTEL_PCIE_CSR_BASE + =
0x028)
> +#define BTINTEL_PCIE_CSR_RF_ID_REG             (BTINTEL_PCIE_CSR_BASE + =
0x09C)
> +#define BTINTEL_PCIE_CSR_BOOT_STAGE_REG                (BTINTEL_PCIE_CSR=
_BASE + 0x108)
> +#define BTINTEL_PCIE_CSR_CI_ADDR_LSB_REG       (BTINTEL_PCIE_CSR_BASE + =
0x118)
> +#define BTINTEL_PCIE_CSR_CI_ADDR_MSB_REG       (BTINTEL_PCIE_CSR_BASE + =
0x11C)
> +#define BTINTEL_PCIE_CSR_IMG_RESPONSE_REG      (BTINTEL_PCIE_CSR_BASE + =
0x12C)
> +#define BTINTEL_PCIE_CSR_HBUS_TARG_WRPTR       (BTINTEL_PCIE_CSR_BASE + =
0x460)
> +
> +/* BTINTEL_PCIE_CSR Function Control Register */
> +#define BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_ENA            (BIT(0))
> +#define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT            (BIT(6))
> +#define BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT           (BIT(7))
> +#define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS      (BIT(20))
> +#define BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET            (BIT(31))
> +
> +/* Value for BTINTEL_PCIE_CSR_BOOT_STAGE register */
> +#define BTINTEL_PCIE_CSR_BOOT_STAGE_ROM                (BIT(0))
> +#define BTINTEL_PCIE_CSR_BOOT_STAGE_IML                (BIT(1))
> +#define BTINTEL_PCIE_CSR_BOOT_STAGE_OPFW               (BIT(2))
> +#define BTINTEL_PCIE_CSR_BOOT_STAGE_ROM_LOCKDOWN       (BIT(10))
> +#define BTINTEL_PCIE_CSR_BOOT_STAGE_IML_LOCKDOWN       (BIT(11))
> +#define BTINTEL_PCIE_CSR_BOOT_STAGE_MAC_ACCESS_ON      (BIT(16))
> +#define BTINTEL_PCIE_CSR_BOOT_STAGE_ALIVE              (BIT(23))
> +
> +/* Registers for MSI-X */
> +#define BTINTEL_PCIE_CSR_MSIX_BASE             (0x2000)
> +#define BTINTEL_PCIE_CSR_MSIX_FH_INT_CAUSES    (BTINTEL_PCIE_CSR_MSIX_BA=
SE + 0x0800)
> +#define BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK      (BTINTEL_PCIE_CSR_MSIX_BA=
SE + 0x0804)
> +#define BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES    (BTINTEL_PCIE_CSR_MSIX_BA=
SE + 0x0808)
> +#define BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK      (BTINTEL_PCIE_CSR_MSIX_BA=
SE + 0x080C)
> +#define BTINTEL_PCIE_CSR_MSIX_AUTOMASK_ST      (BTINTEL_PCIE_CSR_MSIX_BA=
SE + 0x0810)
> +#define BTINTEL_PCIE_CSR_MSIX_AUTOMASK_EN      (BTINTEL_PCIE_CSR_MSIX_BA=
SE + 0x0814)
> +#define BTINTEL_PCIE_CSR_MSIX_IVAR_BASE                (BTINTEL_PCIE_CSR=
_MSIX_BASE + 0x0880)
> +#define BTINTEL_PCIE_CSR_MSIX_IVAR(cause)      (BTINTEL_PCIE_CSR_MSIX_IV=
AR_BASE + (cause))
> +
> +/* Causes for the FH register interrupts */
> +enum msix_fh_int_causes {
> +       BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0       =3D BIT(0),       /* caus=
e 0 */
> +       BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1       =3D BIT(1),       /* caus=
e 1 */
> +};
> +
> +/* Causes for the HW register interrupts */
> +enum msix_hw_int_causes {
> +       BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0     =3D BIT(0),       /* caus=
e 32 */
> +};
> +
> +#define BTINTEL_PCIE_MSIX_NON_AUTO_CLEAR_CAUSE BIT(7)
> +
> +/* Minimum and Maximum number of MSI-X Vector
> + * Intel Bluetooth PCIe support only 1 vector
> + */
> +#define BTINTEL_PCIE_MSIX_VEC_MAX      1
> +#define BTINTEL_PCIE_MSIX_VEC_MIN      1
> +
> +/* Default poll time for MAC access during init */
> +#define BTINTEL_DEFAULT_MAC_ACCESS_TIMEOUT_US  200000
> +
> +/* Default interrupt timeout in msec */
> +#define BTINTEL_DEFAULT_INTR_TIMEOUT   3000
> +
> +/* The number of descriptors in TX/RX queues */
> +#define BTINTEL_DESCS_COUNT    16
> +
> +/* Number of Queue for TX and RX
> + * It indicates the index of the IA(Index Array)
> + */
> +enum {
> +       BTINTEL_PCIE_TXQ_NUM =3D 0,
> +       BTINTEL_PCIE_RXQ_NUM =3D 1,
> +       BTINTEL_PCIE_NUM_QUEUES =3D 2,
> +};
> +
> +/* The size of DMA buffer for TX and RX in bytes */
> +#define BTINTEL_PCIE_BUFFER_SIZE       4096
> +
> +/* DMA allocation alignment */
> +#define BTINTEL_PCIE_DMA_POOL_ALIGNMENT        256
> +
> +/* Number of pending RX requests for downlink */
> +#define BTINTEL_PCIE_RX_MAX_QUEUE      6
> +
> +/* Doorbell vector for FRBD */
> +#define BTINTEL_PCIE_RX_DB_VEC 513
> +
> +/* RBD buffer size mapping */
> +#define BTINTEL_PCIE_RBD_SIZE_4K       0x04
> +
> +/*
> + * Struct for Context Information (v2)
> + *
> + * All members are write-only for host and read-only for device.
> + *
> + * @version: Version of context information
> + * @size: Size of context information
> + * @config: Config with which host wants peripheral to execute
> + *     Subset of capability register published by device
> + * @addr_tr_hia: Address of TR Head Index Array
> + * @addr_tr_tia: Address of TR Tail Index Array
> + * @addr_cr_hia: Address of CR Head Index Array
> + * @addr_cr_tia: Address of CR Tail Index Array
> + * @num_tr_ia: Number of entries in TR Index Arrays
> + * @num_cr_ia: Number of entries in CR Index Arrays
> + * @rbd_siz: RBD Size { 0x4=3D4K }
> + * @addr_tfdq: Address of TFD Queue(tx)
> + * @addr_urbdq0: Address of URBD Queue(tx)
> + * @num_tfdq: Number of TFD in TFD Queue(tx)
> + * @num_urbdq0: Number of URBD in URBD Queue(tx)
> + * @tfdq_db_vec: Queue number of TFD
> + * @urbdq0_db_vec: Queue number of URBD
> + * @addr_frbdq: Address of FRBD Queue(rx)
> + * @addr_urbdq1: Address of URBD Queue(rx)
> + * @num_frbdq: Number of FRBD in FRBD Queue(rx)
> + * @frbdq_db_vec: Queue number of FRBD
> + * @num_urbdq1: Number of URBD in URBD Queue(rx)
> + * @urbdq_db_vec: Queue number of URBDQ1
> + * @tr_msi_vec: Transfer Ring MSI-X Vector
> + * @cr_msi_vec: Completion Ring MSI-X Vector
> + * @dbgc_addr: DBGC first fragment address
> + * @dbgc_size: DBGC buffer size
> + * @early_enable: Enarly debug enable
> + * @dbg_output_mode: Debug output mode
> + *     Bit[4] DBGC O/P { 0=3DSRAM, 1=3DDRAM(not relevant for NPK) }
> + *     Bit[5] DBGC I/P { 0=3DBDBG, 1=3DDBGI }
> + *     Bits[6:7] DBGI O/P(relevant if bit[5] =3D 1)
> + *      0=3DBT DBGC, 1=3DWiFi DBGC, 2=3DNPK }
> + * @dbg_preset: Debug preset
> + * @ext_addr: Address of context information extension
> + * @ext_size: Size of context information part
> + *
> + * Total 38 DWords
> + */
> +struct ctx_info {
> +       u16     version;
> +       u16     size;
> +       u32     config;
> +       u32     reserved_dw02;
> +       u32     reserved_dw03;
> +       u64     addr_tr_hia;
> +       u64     addr_tr_tia;
> +       u64     addr_cr_hia;
> +       u64     addr_cr_tia;
> +       u16     num_tr_ia;
> +       u16     num_cr_ia;
> +       u32     rbd_size:4,
> +               reserved_dw13:28;
> +       u64     addr_tfdq;
> +       u64     addr_urbdq0;
> +       u16     num_tfdq;
> +       u16     num_urbdq0;
> +       u16     tfdq_db_vec;
> +       u16     urbdq0_db_vec;
> +       u64     addr_frbdq;
> +       u64     addr_urbdq1;
> +       u16     num_frbdq;
> +       u16     frbdq_db_vec;
> +       u16     num_urbdq1;
> +       u16     urbdq_db_vec;
> +       u16     tr_msi_vec;
> +       u16     cr_msi_vec;
> +       u32     reserved_dw27;
> +       u64     dbgc_addr;
> +       u32     dbgc_size;
> +       u32     early_enable:1,
> +               reserved_dw31:3,
> +               dbg_output_mode:4,
> +               dbg_preset:8,
> +               reserved2_dw31:16;
> +       u64     ext_addr;
> +       u32     ext_size;
> +       u32     test_param;
> +       u32     reserved_dw36;
> +       u32     reserved_dw37;
> +} __packed;
> +
> +/* Transfer Descriptor for TX
> + * @type: Not in use. Set to 0x0
> + * @size: Size of data in the buffer
> + * @addr: DMA Address of buffer
> + */
> +struct tfd {
> +       u8      type;
> +       u16     size;
> +       u8      reserved;
> +       u64     addr;
> +       u32     reserved1;
> +} __packed;
> +
> +/* URB Descriptor for TX
> + * @tfd_index: Index of TFD in TFDQ + 1
> + * @num_txq: Queue index of TFD Queue
> + * @cmpl_count: Completion count. Always 0x01
> + * @immediate_cmpl: Immediate completion flag: Always 0x01
> + */
> +struct urbd0 {
> +       u32     tfd_index:16,
> +               num_txq:8,
> +               cmpl_count:4,
> +               reserved:3,
> +               immediate_cmpl:1;
> +} __packed;
> +
> +/* FRB Descriptor for RX
> + * @tag: RX buffer tag (index of RX buffer queue)
> + * @addr: Address of buffer
> + */
> +struct frbd {
> +       u32     tag:16,
> +               reserved:16;
> +       u32     reserved2;
> +       u64     addr;
> +} __packed;
> +
> +/* URB Descriptor for RX
> + * @frbd_tag: Tag from FRBD
> + * @status: Status
> + */
> +struct urbd1 {
> +       u32     frbd_tag:16,
> +               status:1,
> +               reserved:14,
> +               fixed:1;
> +} __packed;
> +
> +/* RFH header in RX packet
> + * @packet_len: Length of the data in the buffer
> + * @rxq: RX Queue number
> + * @cmd_id: Command ID. Not in Use
> + */
> +struct rfh_hdr {
> +       u64     packet_len:16,
> +               rxq:6,
> +               reserved:10,
> +               cmd_id:16,
> +               reserved1:16;
> +} __packed;
> +
> +/* Internal data buffer
> + * @data: pointer to the data buffer
> + * @p_addr: physical address of data buffer
> + */
> +struct data_buf {
> +       u8              *data;
> +       dma_addr_t      data_p_addr;
> +};
> +
> +/* Index Array */
> +struct ia {
> +       dma_addr_t      tr_hia_p_addr;
> +       u16             *tr_hia;
> +       dma_addr_t      tr_tia_p_addr;
> +       u16             *tr_tia;
> +       dma_addr_t      cr_hia_p_addr;
> +       u16             *cr_hia;
> +       dma_addr_t      cr_tia_p_addr;
> +       u16             *cr_tia;
> +};
> +
> +/* Structure for TX Queue
> + * @count: Number of descriptors
> + * @tfds: Array of TFD
> + * @urbd0s: Array of URBD0
> + * @buf: Array of data_buf structure
> + */
> +struct txq {
> +       u16             count;
> +
> +       dma_addr_t      tfds_p_addr;
> +       struct tfd      *tfds;
> +
> +       dma_addr_t      urbd0s_p_addr;
> +       struct urbd0    *urbd0s;
> +
> +       dma_addr_t      buf_p_addr;
> +       void            *buf_v_addr;
> +       struct data_buf *bufs;
> +};
> +
> +/* Structure for RX Queue
> + * @count: Number of descriptors
> + * @frbds: Array of FRBD
> + * @urbd1s: Array of URBD1
> + * @buf: Array of data_buf structure
> + */
> +struct rxq {
> +       u16             count;
> +
> +       dma_addr_t      frbds_p_addr;
> +       struct frbd     *frbds;
> +
> +       dma_addr_t      urbd1s_p_addr;
> +       struct urbd1    *urbd1s;
> +
> +       dma_addr_t      buf_p_addr;
> +       void            *buf_v_addr;
> +       struct data_buf *bufs;
> +};
> +
> +/* struct btintel_pcie_data
> + * @pdev: pci device
> + * @hdev: hdev device
> + * @flags: driver state
> + * @irq_lock: spinlock for MSI-X
> + * @hci_rx_lock: spinlock for HCI RX flow
> + * @base_addr: pci base address (from BAR)
> + * @msix_entries: array of MSI-X entries
> + * @msix_enabled: true if MSI-X is enabled;
> + * @alloc_vecs: number of interrupt vectors allocated
> + * @def_irq: default irq for all causes
> + * @fh_init_mask: initial unmasked rxq causes
> + * @hw_init_mask: initial unmaksed hw causes
> + * @boot_stage_cache: cached value of boot stage register
> + * @img_resp_cache: cached value of image response register
> + * @cnvi: CNVi register value
> + * @cnvr: CNVr register value
> + * @gp0_received: condition for gp0 interrupt
> + * @gp0_wait_q: wait_q for gp0 interrupt
> + * @tx_wait_done: condition for tx interrupt
> + * @tx_wait_q: wait_q for tx interrupt
> + * @workqueue: workqueue for RX work
> + * @rx_skb_q: SKB queue for RX packet
> + * @rx_work: RX work struct to process the RX packet in @rx_skb_q
> + * @dma_pool: DMA pool for descriptors, index array and ci
> + * @dma_p_addr: DMA address for pool
> + * @dma_v_addr: address of pool
> + * @ci_p_addr: DMA address for CI struct
> + * @ci: CI struct
> + * @ia: Index Array struct
> + * @txq: TX Queue struct
> + * @rxq: RX Queue struct
> + */
> +struct btintel_pcie_data {
> +       struct pci_dev  *pdev;
> +       struct hci_dev  *hdev;
> +
> +       unsigned long   flags;
> +       /* lock used in MSI-X interrupt */
> +       spinlock_t      irq_lock;
> +       /* lock to serialize rx events */
> +       spinlock_t      hci_rx_lock;
> +
> +       void __iomem    *base_addr;
> +
> +       struct msix_entry       msix_entries[BTINTEL_PCIE_MSIX_VEC_MAX];
> +       bool    msix_enabled;
> +       u32     alloc_vecs;
> +       u32     def_irq;
> +
> +       u32     fh_init_mask;
> +       u32     hw_init_mask;
> +
> +       u32     boot_stage_cache;
> +       u32     img_resp_cache;
> +
> +       u32     cnvi;
> +       u32     cnvr;
> +
> +       bool    gp0_received;
> +       wait_queue_head_t       gp0_wait_q;
> +
> +       bool    tx_wait_done;
> +       wait_queue_head_t       tx_wait_q;
> +
> +       struct workqueue_struct *workqueue;
> +       struct sk_buff_head     rx_skb_q;
> +       struct work_struct      rx_work;
> +
> +       struct dma_pool *dma_pool;
> +       dma_addr_t      dma_p_addr;
> +       void            *dma_v_addr;
> +
> +       dma_addr_t      ci_p_addr;
> +       struct ctx_info *ci;
> +       struct ia       ia;
> +       struct txq      txq;
> +       struct rxq      rxq;
> +};
> +
> +static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
> +                                       u32 offset)
> +{
> +       return ioread32(data->base_addr + offset);
> +}
> +
> +static inline void btintel_pcie_wr_reg8(struct btintel_pcie_data *data,
> +                                       u32 offset, u8 val)
> +{
> +       iowrite8(val, data->base_addr + offset);
> +}
> +
> +static inline void btintel_pcie_wr_reg32(struct btintel_pcie_data *data,
> +                                        u32 offset, u32 val)
> +{
> +       iowrite32(val, data->base_addr + offset);
> +}
> +
> +static inline void btintel_pcie_set_reg_bits(struct btintel_pcie_data *d=
ata,
> +                                            u32 offset, u32 bits)
> +{
> +       u32 r;
> +
> +       r =3D ioread32(data->base_addr + offset);
> +       r |=3D bits;
> +       iowrite32(r, data->base_addr + offset);
> +}
> +
> +static inline void btintel_pcie_clr_reg_bits(struct btintel_pcie_data *d=
ata,
> +                                            u32 offset, u32 bits)
> +{
> +       u32 r;
> +
> +       r =3D ioread32(data->base_addr + offset);
> +       r &=3D ~bits;
> +       iowrite32(r, data->base_addr + offset);
> +}
> --
> 2.40.1
>
>


--=20
Luiz Augusto von Dentz
