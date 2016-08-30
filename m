Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/4] Bluetooth: hci_h5: fix a race in the closing path
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1471592327-14133-3-git-send-email-boris.brezillon@free-electrons.com>
Date: Tue, 30 Aug 2016 09:54:01 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        jason.abele@gmail.com
Message-Id: <237F08CD-9031-4155-ADB5-85D6E5D634D8@holtmann.org>
References: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com> <1471592327-14133-3-git-send-email-boris.brezillon@free-electrons.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Boris,

> The H5 timer should not be rescheduled while we are closing the device,
> otherwise it's defeating the del_timer_sync() call done in h5_close().
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> drivers/bluetooth/hci_h5.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 0879d64b1caf..d9720c59cffa 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -140,7 +140,12 @@ static void h5_timed_event(unsigned long arg)
> 	}
> 
> 	if (h5->state != H5_ACTIVE) {
> -		mod_timer(&h5->timer, jiffies + H5_SYNC_TIMEOUT);
> +		/*
> +		 * Do not re-schedule the timer if the device is being closed.
> +		 */

same here as the other patch. Use network subsystem comment style.

Regards

Marcel

