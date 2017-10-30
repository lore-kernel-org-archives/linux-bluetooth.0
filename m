Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH] Bluetooth: hci_ldisc: Fix another race when closing the
 tty.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171026051519.GA15958@innovation.ch>
Date: Mon, 30 Oct 2017 15:49:16 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Dean Jenkins <Dean_Jenkins@mentor.com>,
        Lukas Wunner <lukas@wunner.de>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <B2277FFE-D3B4-4AB3-9443-27549D703886@holtmann.org>
References: <20171026051519.GA15958@innovation.ch>
To: =?us-ascii?B?PT9VVEYtOD9xP1JvbmFsZD0yMFRzY2hhbD1DMz1BNHI/PQ==?=
        <ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ronald,

> The following race condition still existed:
> 
>         P1                                P2
>  cancel_work_sync()
>                                     hci_uart_tx_wakeup()
>                                     hci_uart_write_work()
>                                     hci_uart_dequeue()
>  clear_bit(HCI_UART_PROTO_READY)
>  hci_unregister_dev(hdev)
>  hci_free_dev(hdev)
>  hu->proto->close(hu)
>  kfree(hu)
>                                     access to hdev and hu
> 
> Cancelling the work after clearing the HCI_UART_PROTO_READY bit avoids
> this as any hci_uart_tx_wakeup() issued after the flag is cleared will
> detect that and not schedule further work.
> 
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> Cc: Dean Jenkins <Dean_Jenkins@mentor.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
