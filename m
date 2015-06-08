Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Jun 2015 12:56:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: btusb: Remove double error check from
 local version command
Message-ID: <20150608095617.GA31930@t440s.lan>
References: <1433664062-37464-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433664062-37464-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 07, 2015, Marcel Holtmann wrote:
> The __hci_cmd_sync function already handles the command status and
> command complete errors. No need to check the status field again.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)

Both patches in this set have been applied to bluetooth-next. Thanks.

Johan
