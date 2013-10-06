Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Oct 2013 11:04:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Reject enabling controllers without valid
 addresses
Message-ID: <20131006090457.GA22667@x220.p-661hnu-f1>
References: <1381046938-34970-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381046938-34970-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 06, 2013, Marcel Holtmann wrote:
> In case of a single mode LE-only controller it is possible that no
> public address is used. These type of controllers require a random
> address to be configured.
> 
> Without a configured static random address, such a controller is
> not functional. So reject powering on the controller in this case
> until it gets configured with a random address.
> 
> The controller setup stage is still run since it is the only way
> to determinate if a public address is available or not. So it is
> similar on how RFKILL gets handled during initial setup of the
> controller.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 43 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 8 deletions(-)

This patch has been applied to bluetooth-next. Thanks.

Johan
