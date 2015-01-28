Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Jan 2015 22:11:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Perform a power cycle when receiving
 hardware error event
Message-ID: <20150128201112.GB2864@t440s.P-661HNU-F1>
References: <1422472196-9595-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422472196-9595-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 28, 2015, Marcel Holtmann wrote:
> When receiving a HCI Hardware Error event, the controller should be
> assumed to be non-functional until issuing a HCI Reset command.
> 
> The Bluetooth hardware errors are vendor specific and so add a
> new hdev->hw_error callback that drivers can provide to run extra
> code to handle the hardware error.
> 
> After completing the vendor specific error handling perform a full
> reset of the Bluetooth stack by closing and re-opening the transport.
> 
> Based-on-patch-by: Johan Hedberg <johan.hedberg@intel.com>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  3 +++
>  net/bluetooth/hci_core.c         | 21 +++++++++++++++++++++
>  net/bluetooth/hci_event.c        |  4 +++-
>  3 files changed, 27 insertions(+), 1 deletion(-)

Both of these patches have been applied to bluetooth-next. Thanks.

Johan
