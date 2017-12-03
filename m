Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] bluetooth: serdev: hci_ll: Wait for CTS instead of using
 msleep
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1512269035-21710-1-git-send-email-david@lechnology.com>
Date: Sun, 3 Dec 2017 20:24:04 +0100
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Message-Id: <F488D1A7-F38F-4930-979C-E30881E11AA9@holtmann.org>
References: <1512269035-21710-1-git-send-email-david@lechnology.com>
To: David Lechner <david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> When a TI Bluetooth chip is reset, it takes about 100ms for the RTS line of
> the chip to deassert. For my use case with a TI CC2560A chip, this delay
> was not long enough and caused the local UART to never transmit at all (TI
> AM1808 SoC UART2).
> 
> We can wait for the CTS signal using serdev_device_wait_for_cts() instead
> of trying to guess using msleep().
> 
> Also changed the comment to be more informative while we are touching this
> code.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> drivers/bluetooth/hci_ll.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
