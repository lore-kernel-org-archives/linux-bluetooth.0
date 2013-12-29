Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Dec 2013 21:36:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for vectored writes to virtual
 HCI driver
Message-ID: <20131229193638.GB26228@x220.p-661hnu-f1>
References: <1388296634-46026-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388296634-46026-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Dec 28, 2013, Marcel Holtmann wrote:
> The Bluetooth virtual HCI driver is using a misc character device to
> allow emulation of HCI devices from userspace. This change enables the
> support for vectored writes. Previously this was failing with EINVAL
> since no complete H:4 packet was written.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_vhci.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
