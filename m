Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Oct 2015 09:57:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: hci_bcm: Enable parsing of LM_DIAG messages
Message-ID: <20151008065703.GC25309@t440s.lan>
References: <1444237974-31017-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444237974-31017-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 07, 2015, Marcel Holtmann wrote:
> The Broadcom UART based controllers can send LM_DIAG messages with the
> identifier 0x07 inside the HCI stream. These messages are 63 octets in
> size and have no variable payload or length indicator.
> 
> This patch adds correct parsing information for the h4_recv_buf handler
> and in case these packets are received, they are forwarded to the
> Bluetooth core via hci_recv_diag interface.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_bcm.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
