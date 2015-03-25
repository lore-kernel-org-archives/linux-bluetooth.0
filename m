Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: hci_ldisc: Add setup callback
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427293170-3658-1-git-send-email-loic.poulain@intel.com>
Date: Wed, 25 Mar 2015 09:35:08 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <1E3986E3-0736-4338-9D22-F06D37E7A7FC@holtmann.org>
References: <1427293170-3658-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Some Bluetooth controllers require initialization before
> being used (vendor config, firmware download).
> Add possibility for a HCI UART proto to implement this
> early init via the setup callback.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 11 +++++++++++
> drivers/bluetooth/hci_uart.h  |  1 +
> 2 files changed, 12 insertions(+)

patch has been applied to bluetooth-next tree.

However I changed to subject to mention hci_uart and not hci_ldisc. Please use hci_uart to refer to the driver.

Regards

Marcel

