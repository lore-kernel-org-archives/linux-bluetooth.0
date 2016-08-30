Return-Path: <boris.brezillon@free-electrons.com>
Date: Tue, 30 Aug 2016 15:26:43 +0200
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jason.abele@gmail.com
Subject: Re: [PATCH 0/4] Bluetooth: hci_uart: various fixes
Message-ID: <20160830152643.3a64de8b@bbrezillon>
In-Reply-To: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 19 Aug 2016 09:38:43 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hi,
> 
> We recently faced some problems when using an BT uart chip interfaced
> through the H5 proto (rtk_h5). Here are the logs of the 2 different
> issues we had when closing the line discipline (actually, restoring
> the previous one) [1][2]. I know the kernel is Tainted in those logs,
> but after some investigations I found a few potential issues that might
> explain what we're seeing.
> 
> Patches 1 and 2 are fixing 2 potential 'use after free' bugs: in some
> (unlikely) cases the timer and work we try to cancel in the closing
> path can be re-scheduled in our back, and since we're releasing the
> memory region assigned to those elements at the end of the closing
> procedure we can end-up with those invalid pointer exception when the
> work or timer handler is called.
> 
> Note that this problem is pretty hard to reproduce, so I'm not sure
> my patches are fixing all the racy paths.
> 
> Patches 3 and 4 are fixing potential issues that I didn't directly
> face but may be worth fixing. Path 3 is fixing a potential double
> free issue (proto->close() called twice if the hdev registration
> failed). Patch 4 is making sure we don't loose some TX events.
> 
> Let me know what you think.

Ping.

> 
> Thanks,
> 
> Boris
> 
> [1]http://code.bulix.org/8qtjly-105082
> [2]http://code.bulix.org/qzur9n-105083
> 
> 
> Boris Brezillon (4):
>   Bluetooth: hci_ldisc: fix a race in the hdev closing path
>   Bluetooth: hci_h5: fix a race in the closing path
>   Bluetooth: hci_ldisc: don't release resources in hci_uart_init_work()
>   Bluetooth: hci_ldisc: make sure we don't loose HCI_UART_TX_WAKEUP
>     events
> 
>  drivers/bluetooth/hci_h5.c    |  7 ++++++-
>  drivers/bluetooth/hci_ldisc.c | 30 ++++++++++++++++++++++++++----
>  drivers/bluetooth/hci_uart.h  |  1 +
>  3 files changed, 33 insertions(+), 5 deletions(-)
> 
