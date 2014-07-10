Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Jul 2014 16:39:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Set HCI_PAIRABLE during power on for legacy
 ioctl
Message-ID: <20140710133913.GA15936@t440s.ger.corp.intel.com>
References: <1404998722-60828-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404998722-60828-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jul 10, 2014, Marcel Holtmann wrote:
> When the controller is brought up using legacy ioctl, the setting of
> the HCI_PAIRABLE flag should happen then. Previously it was set during
> enumeration and when retrieving device information.
> 
> This change also will not set the HCI_PAIRABLE flag when the controller
> is used with the HCI User Channel operation.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
