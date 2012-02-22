Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Feb 2012 10:09:11 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/6] Bluetooth: mgmt: Fix Removing discoverable timeout
 in set_connectable
Message-ID: <20120222080910.GD24328@aemeltch-MOBL1>
References: <1329846229-7919-1-git-send-email-johan.hedberg@gmail.com>
 <1329846229-7919-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329846229-7919-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Feb 21, 2012 at 07:43:45PM +0200, johan.hedberg@gmail.com wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> When switching connectable mode off any pending discoverable timeout
> must also be disabled to avoid duplicate write_scan_enable commands.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 6311be7..eec70a4 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -935,9 +935,14 @@ static int set_connectable(struct sock *sk, u16 index, void *data, u16 len)
>  
>  	if (cp->val)
>  		scan = SCAN_PAGE;
> -	else
> +	else {

I think here you have to use braces in both branches.

Best regards 
Andrei Emeltchenko 

>  		scan = 0;
>  
> +		if (test_bit(HCI_ISCAN, &hdev->flags) &&
> +						hdev->discov_timeout > 0)
> +			cancel_delayed_work(&hdev->discov_off);
> +	}
> +
>  	err = hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
>  	if (err < 0)
>  		mgmt_pending_remove(cmd);

