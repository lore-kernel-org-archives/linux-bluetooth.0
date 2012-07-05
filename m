Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Jul 2012 15:37:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Override status if local user rejects pairing
Message-ID: <20120705123731.GA32370@x220.P-661HNU-F1>
References: <1341490285-14932-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341490285-14932-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Jul 05, 2012, Jaganath Kanakkassery wrote:
> In case if ssp is failed, user cannot differentiate from the status
> whether failure is caused by local rejection or remote rejection
> because authentication failure is coming in both the cases.
> 
> This patch overrides the status from controller with "pin or key missing"
> in case of local rejection. In legacy pairing already contoller gives
> this error.
> 
> This patch will be useful if user can take some action based on local
> or remote rejection
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> ---
--snip--
> +	/* Override status if local device rejected pairing */
> +	if (auth_rejected == true)
> +		ev.status = MGMT_STATUS_NOT_PAIRED;
> +	else
> +		ev.status = mgmt_status(status);

You're not returning "pin or key missing" (which sounds like an HCI
error) but MGMT_STATUS_NOT_PAIRED. Please be honest about this in your
commit message. However, I don't think this is a very intuitive error
code for a local rejection. Could you just use MGMT_STATUS_REJECTED for
it? I think you'll get "pin or key missing" also if the remote side
rejects so I don't think that's a good HCI error to derive the needed
mgmt error from.

Johan
