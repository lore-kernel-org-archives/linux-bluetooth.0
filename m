Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v5 1/2] Bluetooth: btqca: Introduce generic QCA ROME support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55C9167C.7050707@qca.qualcomm.com>
Date: Mon, 10 Aug 2015 14:57:37 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C8084DB2-D2CD-4C60-99F9-4CBE3657892C@holtmann.org>
References: <55C9167C.7050707@qca.qualcomm.com>
To: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ben,

> This is for supporting BT for QCA ROME with vendor specific
> HCI commands and initialization on the chip. This will have
> USB/UART implementation both, but for now, adding UART vendor
> specific commands to patch downloading and set Bluetooth device
> address using vendor specific command.
> 
> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
> ---
> drivers/bluetooth/Kconfig  |   4 +
> drivers/bluetooth/Makefile |   1 +
> drivers/bluetooth/btqca.c  | 392 +++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btqca.h  | 135 ++++++++++++++++
> 4 files changed, 532 insertions(+)
> create mode 100644 drivers/bluetooth/btqca.c
> create mode 100644 drivers/bluetooth/btqca.h

patch has been applied to bluetooth-next tree.

Regards

Marcel

