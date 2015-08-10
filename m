Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v5 2/2] Bluetooth: hciuart: Add support QCA chipset for UART
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55C91681.9060504@qca.qualcomm.com>
Date: Mon, 10 Aug 2015 14:57:35 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1928131C-C3B2-4FEB-913A-2B925180B670@holtmann.org>
References: <55C91681.9060504@qca.qualcomm.com>
To: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ben,

> QCA61x4 chips have supported sleep feature using In-Band-Sleep commands
> to enable sleep feature based on H4 protocol. After sending
> patch/nvm configuration is done, IBS mode will be up and running
> 
> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
> ---
> drivers/bluetooth/Kconfig     |  13 +
> drivers/bluetooth/Makefile    |   1 +
> drivers/bluetooth/hci_ldisc.c |   6 +
> drivers/bluetooth/hci_qca.c   | 969 ++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/hci_uart.h  |   8 +-
> 5 files changed, 996 insertions(+), 1 deletion(-)
> create mode 100644 drivers/bluetooth/hci_qca.c

patch has been applied to bluetooth-next tree.

Regards

Marcel

