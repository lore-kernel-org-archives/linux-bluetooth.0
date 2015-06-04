Return-Path: <cyrus@holtmann.org>
Message-ID: <557001E4.6030000@broadcom.com>
Date: Thu, 4 Jun 2015 09:44:36 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Ilya Faenson <ifaenson@broadcom.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 0/5] Broadcom Bluetooth UART device driver
References: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/03/15 23:01, Ilya Faenson wrote:
> This is a merge of the Broadcom Bluetooth UART logic with
> the latest line discipline and protocol enhancements implemented
> by Frederic Danis of Intel.

The series from Frederic Danis can be found by its message-id:

1432805106-25719-1-git-send-email-frederic.danis@linux.intel.com

Regards,
Arend

[1] 
http://mid.gmane.org/1432805106-25719-1-git-send-email-frederic.danis@linux.intel.com

> Ilya Faenson (5):
>    Broadcom Bluetooth UART Device Tree bindings
>    Intel based H4 line discipline enhancements
>    Broadcom Bluetooth UART Platform Driver
>    Broadcom Bluetooth protocol UART support
>    BlueZ Broadcom UART Protocol
>
>   .../devicetree/bindings/net/bluetooth/btbcm.txt    |  82 +++
>   drivers/bluetooth/Kconfig                          |   9 +
>   drivers/bluetooth/Makefile                         |   1 +
>   drivers/bluetooth/btbcm.c                          | 142 ++++-
>   drivers/bluetooth/btbcm.h                          |  21 +-
>   drivers/bluetooth/btbcm_uart.c                     | 673 +++++++++++++++++++++
>   drivers/bluetooth/btbcm_uart.h                     |  89 +++
>   drivers/bluetooth/hci_bcm.c                        | 481 ++++++++++++++-
>   drivers/bluetooth/hci_ldisc.c                      | 110 +++-
>   drivers/bluetooth/hci_uart.h                       |   6 +
>   10 files changed, 1565 insertions(+), 49 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
>   create mode 100755 drivers/bluetooth/btbcm_uart.c
>   create mode 100755 drivers/bluetooth/btbcm_uart.h
>

