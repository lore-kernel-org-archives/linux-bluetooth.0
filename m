Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Jul 2014 15:03:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Skip unconfigured init procedure for raw-only
 devices
Message-ID: <20140706120355.GA31903@t440s.Elisa>
References: <1404647000-44459-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404647000-44459-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 06, 2014, Marcel Holtmann wrote:
> When the driver sets HCI_QUIRK_RAW_DEVICE, the controller will be set
> as unconfigured. However running the unconfigured init procecure is
> not useful since raw-only devices are not allowed to change its
> configuration. This change skips the init procedure and just allows
> user channel operation for this device.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
