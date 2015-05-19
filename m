Return-Path: <cyrus@holtmann.org>
Message-ID: <555AF22C.7000108@broadcom.com>
Date: Tue, 19 May 2015 10:19:56 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Ilya Faenson <ifaenson@broadcom.com>
CC: Marcel Holtmann <marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC v3 0/4] Broadcom Bluetooth UART device driver
References: <1431553823-25670-1-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1431553823-25670-1-git-send-email-ifaenson@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/13/15 23:50, Ilya Faenson wrote:
> The next version of the driver changed as per Marcel's comments.

This is just a cover letter and as such not stored in the git 
repository, but it is stored in the mailing list archives so I would 
recommend giving a short description here about what this patch series 
provides followed by a change log so you can keep the description and 
indicate in the change log what was done in the next version.

Regards,
Arend

> Ilya Faenson (4):
>    Broadcom Bluetooth UART Device Tree bindings
>    Broadcom Bluetooth UART Platform Driver
>    Broadcom Bluetooth protocol UART support
>    BlueZ Broadcom UART Protocol
>
>   .../devicetree/bindings/net/bluetooth/btbcm.txt    |  54 ++
>   drivers/bluetooth/Kconfig                          |   9 +
>   drivers/bluetooth/Makefile                         |   1 +
>   drivers/bluetooth/btbcm.c                          | 155 ++++-
>   drivers/bluetooth/btbcm.h                          |  13 +
>   drivers/bluetooth/btbcm_uart.c                     | 705 +++++++++++++++++++++
>   drivers/bluetooth/btbcm_uart.h                     | 116 ++++
>   drivers/bluetooth/hci_bcm.c                        | 528 ++++++++++++++-
>   8 files changed, 1561 insertions(+), 20 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
>   create mode 100644 drivers/bluetooth/btbcm_uart.c
>   create mode 100644 drivers/bluetooth/btbcm_uart.h
>
