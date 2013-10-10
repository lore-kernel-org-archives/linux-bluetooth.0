Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Oct 2013 22:15:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: AMP contollers do not support the legacy
 ioctls
Message-ID: <20131010201508.GB9414@x220.p-661hnu-f1>
References: <1381424528-9754-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381424528-9754-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 10, 2013, Marcel Holtmann wrote:
> The legacy ioctls for device specific commands including inquiry are
> not support by AMP controllers. So just reject them right away instead
> of trying to send the HCI command and wait for failure from the
> actual hardware.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 10 ++++++++++
>  net/bluetooth/hci_sock.c |  3 +++
>  2 files changed, 13 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
