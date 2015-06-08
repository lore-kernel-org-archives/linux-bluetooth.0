Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Jun 2015 11:06:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix race condition with user channel and
 setup stage
Message-ID: <20150608080637.GA717@t440s.lan>
References: <1433563609-75812-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433563609-75812-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jun 06, 2015, Marcel Holtmann wrote:
> During the initial setup stage of a controller, the low-level transport
> is actually active. This means that HCI_UP is true. To avoid toggling
> the transport off and back on again for normal operation the kernel
> holds a grace period with HCI_AUTO_OFF that will turn the low-level
> transport off in case no user is present.
> 
> The idea of the grace period is important to avoid having to initialize
> all of the controller twice. So legacy ioctl and the new management
> interface knows how to clear this grace period and then start normal
> operation.
> 
> For the user channel operation this grace period has not been taken into
> account which results in the problem that HCI_UP and HCI_AUTO_OFF are
> set and the kernel will return EBUSY. However from a system point of
> view the controller is ready to be grabbed by either the ioctl, the
> management interface or the user channel.
> 
> This patch brings the user channel to the same level as the other two
> entries for operating a controller.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Cc: stable@vger.kernel.org
> ---
>  net/bluetooth/hci_sock.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
