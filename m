Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Jan 2015 09:05:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix issue with Roper Class 1 Bluetooth Dongle
Message-ID: <20150102070506.GA13581@t440s.P-661HNU-F1>
References: <1420162477-2669-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420162477-2669-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jan 01, 2015, Marcel Holtmann wrote:
> The Roper Class 1 Bluetooth Dongle is another device that claims to
> support Bluetooth 1.2 specification, but does not support the HCI
> command for reading the local supported commands.
> 
>   < HCI Command: Read Local Version Information (0x04|0x0001) plen 0
>   > HCI Event: Command Complete (0x0e) plen 12
>       Read Local Version Information (0x04|0x0001) ncmd 1
>       status 0x00
>       HCI Version: 1.2 (0x2) HCI Revision: 0x0
>       LMP Version: 1.2 (0x2) LMP Subversion: 0x757
>       Manufacturer: Silicon Wave (11)
> 
> It clearly claims Bluetooth 1.2 support and in that regard has the
> same issue as the AVM BlueFritz! USB devices (Silicon Wave based),
> but the HCI Read Local Supported Commands command fails.
> 
>   < HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
>   > HCI Event: Command Status (0x0f) plen 4
>       Read Local Supported Commands (0x04|0x0002) status 0x01 ncmd 1
>       Error: Unknown HCI Command
> 
> Use the HCI_QUIRK_BROKEN_LOCAL_COMMANDS quirk for these devices and
> the failing command will be skipped.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
