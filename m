Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH V2 0/7] Bluetooth HCI LDISC and BCSP fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
Date: Sat, 24 Sep 2016 06:41:38 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <309CAC2D-5247-4D30-BB70-CE905C875516@holtmann.org>
References: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

> This patchset contains the following commits:
> 
> Dean Jenkins (4):
>  Bluetooth: Tidy-up coding style in hci_bcsp.c
>  Bluetooth: BCSP fails to ACK re-transmitted frames from the peer
>  Bluetooth: Add mutex to hci_uart_tty_ioctl()
>  Revert "Bluetooth: hci_ldisc: Fix null pointer derefence in case of
>    early data"
> 
> Deepak Das (1):
>  Bluetooth: Prevent scheduling of work after hci_uart_tty_close()
> 
> Vignesh Raman (2):
>  Bluetooth: Use single return in hci_uart_tty_ioctl() call
>  Bluetooth: Fix HCI UART HCI_UART_PROTO_SET locking
> 
> drivers/bluetooth/hci_bcsp.c  | 128 ++++++++++++++++++++++++------------------
> drivers/bluetooth/hci_ldisc.c |  63 +++++++++++++--------
> drivers/bluetooth/hci_uart.h  |   4 +-
> 3 files changed, 117 insertions(+), 78 deletions(-)

I applied patches 1-3 to bluetooth-next tree.

Regards

Marcel

