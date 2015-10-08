Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Oct 2015 09:53:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Buetooth: Add support for vendor specific diagnostic
 channel
Message-ID: <20151008065309.GB25309@t440s.lan>
References: <1444228715-28972-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444228715-28972-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 07, 2015, Marcel Holtmann wrote:
> Introduce hci_recv_diag function for HCI drivers to allow sending vendor
> specific diagnostic messages into the Bluetooth core stack. The messages
> are not processed, but they are forwarded to the monitor channel and can
> be retrieved by user space diagnostic tools.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h      |  1 +
>  include/net/bluetooth/hci_core.h |  1 +
>  include/net/bluetooth/hci_mon.h  |  1 +
>  net/bluetooth/hci_core.c         | 15 +++++++++++++++
>  net/bluetooth/hci_sock.c         |  3 +++
>  5 files changed, 21 insertions(+)

Applied to bluetooth-next (with the obvious 'Buetooth' typo fix).
Thanks.

Johan
