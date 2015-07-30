Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH 1/2] Bluetooth: btqca: Introduce generic QCA ROME support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55B97E71.7000204@qca.qualcomm.com>
Date: Thu, 30 Jul 2015 13:06:14 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <17F8E500-52D2-45CC-BB6B-F33EB4A0FD28@holtmann.org>
References: <55B97E71.7000204@qca.qualcomm.com>
To: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ben,

> This is for supporting BT for QCA ROME with specific vendor
> specific HCI commands and initialization. This will have USB/UART
> implementation both, but for now, adding UART vendor specific
> commands to patch downloading and set BDaddress using VS command.
> 
> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
> ---
> drivers/bluetooth/Kconfig  |   4 +
> drivers/bluetooth/Makefile |   1 +
> drivers/bluetooth/btqca.c  | 523 +++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btqca.h  | 156 ++++++++++++++
> 4 files changed, 684 insertions(+)
> create mode 100644 drivers/bluetooth/btqca.c
> create mode 100644 drivers/bluetooth/btqca.h
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 79e8234..f580334 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -13,6 +13,10 @@ config BT_RTL
>     tristate
>     select FW_LOADER
> 
> +config BT_QCA
> +    tristate
> +    select FW_LOADER
> +
> config BT_HCIBTUSB
>     tristate "HCI USB driver"
>     depends on USB
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index f40e194..15a0d1d 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_BT_MRVL_SDIO)    += btmrvl_sdio.o
> obj-$(CONFIG_BT_WILINK)        += btwilink.o
> obj-$(CONFIG_BT_BCM)        += btbcm.o
> obj-$(CONFIG_BT_RTL)        += btrtl.o
> +obj-$(CONFIG_BT_QCA)        += btqca.o
> 
> btmrvl-y            := btmrvl_main.o
> btmrvl-$(CONFIG_DEBUG_FS)    += btmrvl_debugfs.o
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> new file mode 100644
> index 0000000..9c1ae6b
> --- /dev/null
> +++ b/drivers/bluetooth/btqca.c
> @@ -0,0 +1,523 @@
> +/*
> + *  Bluetooth supports for Qualcomm Atheros chips
> + *
> + *  Copyright (c) 2015 The Linux Foundation. All rights reserved.

copyright assigned to Linux Foundation is intentional?

> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/firmware.h>
> +#include <asm/unaligned.h>
> +#include <stdbool.h>

Why would you include stdbool.h here. That was never needed.

> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include "hci_uart.h"

You should not need this include. Please do not include driver header files in the common modules.

> +#include "btqca.h"
> +
> +#define VERSION "0.1"
> +
> +static uint8_t g_qca_user_baud_rate = QCA_BAUDRATE_115200;

Please stop with the g_ for global variable. I am not even sure how this one would be useful anyway.

> +
> +static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
> +{
> +    struct sk_buff *skb;
> +    struct edl_event_hdr *edl;
> +    struct rome_version *ver;
> +    char cmd;
> +    int ret = 0;

Since the tabs vs spaces is completely messed up, I stopped going through the patch. Please make sure you do this correctly and that your email client/server does not mess this up.

Regards

Marcel

