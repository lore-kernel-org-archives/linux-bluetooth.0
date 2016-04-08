Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2][RESEND] Bluetooth: hci_ldisc: Fix null pointer derefence in case of early data
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1459759693-5687-1-git-send-email-loic.poulain@intel.com>
Date: Fri, 8 Apr 2016 10:03:31 -0700
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <B290528F-CEA9-4DF6-9367-71DA6AAFE74A@holtmann.org>
References: <1459759693-5687-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> HCI_UART_PROTO_SET flag is set before hci_uart_set_proto call. If we
> receive data from tty layer during this procedure, proto pointer may
> not be assigned yet, leading to null pointer dereference in rx method
> hci_uart_tty_receive.
> 
> This patch fixes this issue by introducing HCI_UART_PROTO_READY flag in
> order to avoid any proto operation before proto opening and assignment.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: Use PROTO_READY instead of overloading PROTO_SET ioctl.
> 
> drivers/bluetooth/hci_ldisc.c | 11 +++++++----
> drivers/bluetooth/hci_uart.h  |  1 +
> 2 files changed, 8 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

