Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Jul 2014 16:41:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Check for default address of Intel USB
 controllers
Message-ID: <20140702134143.GC15249@t440s.P-661HNU-F1>
References: <1404295605-23326-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404295605-23326-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 02, 2014, Marcel Holtmann wrote:
> Some Intel Bluetooth controllers come with a default address. If this
> address is found, print an error to warn the user about it.
> 
> The controller is fully operational, but the danger of duplicate
> Bluetooth addresses might causes issues. At least with a clear
> error it becomes easier to debug these cases.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
