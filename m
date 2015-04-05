Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Apr 2015 09:26:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: hci_uart: Introduce h4_recv_buf helper
 function
Message-ID: <20150405062608.GF11977@t440s.P-661HNU-F1>
References: <1428209967-20757-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428209967-20757-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Apr 04, 2015, Marcel Holtmann wrote:
> The h4_recv_buf helper function can be used for receiving H:4 packets
> out of a TTY stream. It is self-contained and allows for reuse by all
> HCI UART protocols.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_h4.c   | 98 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/hci_uart.h |  3 ++
>  2 files changed, 101 insertions(+)

All four patches in this set have been applied to bluetooth-next.
Thanks.

Johan
