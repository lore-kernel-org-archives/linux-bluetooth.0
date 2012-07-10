Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jul 2012 15:57:02 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 13/17] Bluetooth: Add initial sleep support to Three-wire
 UART
Message-ID: <20120710185702.GH13847@joana>
References: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
 <1340796367-10321-14-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340796367-10321-14-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-06-27 14:26:03 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch adds very basic support for the sleep related messages. The
> only thing the code does right now is send a wakeup message as soon as
> receiving a sleep one, essentially preventing the controller from going
> to sleep.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  drivers/bluetooth/hci_h5.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 31b8d57..d26f801 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -71,6 +71,8 @@ struct h5 {
>  	bool			tx_ack_req;	/* Pending ack to send */
>  	u8			tx_seq;		/* Next seq number to send */
>  	u8			tx_ack;		/* Next ack number to send */
> +
> +	bool			sleeping;

Please fold this into the flags member I proposed in the other patch.

	Gustavo
