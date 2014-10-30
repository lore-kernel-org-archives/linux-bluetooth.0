Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Oct 2014 17:42:25 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Clear LE white list when resetting controller
Message-ID: <20141030164225.GA27956@t440s>
References: <1414622273-35237-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414622273-35237-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 29, 2014, Marcel Holtmann wrote:
> The internal representation of the LE white list needs to be cleared
> when receiving a successful HCI_Reset command. A reset of the controller
> is expected to start with an empty LE white list.
> 
> When the LE white list is not cleared on controller reset, the passive
> background scanning might skip programming the remote devices. Only
> changes to the LE white list are programmed when passive background
> is started.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Cc: stable@vger.kernel.org # 3.17.x
> ---
>  net/bluetooth/hci_event.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
