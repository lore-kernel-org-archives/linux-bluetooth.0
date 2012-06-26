Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Jun 2012 15:00:10 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Route traffic only through BR/EDR controller
Message-ID: <20120626120008.GD22061@aemeltch-MOBL1>
References: <1340108482-16071-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340108482-16071-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jun 19, 2012 at 03:21:21PM +0300, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> If AMP controller is first in the list then Bluetooth traffic might
> be routed through it (if source is not specified). The patch
> prevents this case and also checks that source is BR/EDR.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

ping


> ---
>  net/bluetooth/hci_conn.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 9aac198..3ec5fc2 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -442,7 +442,8 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
>  
>  	list_for_each_entry(d, &hci_dev_list, list) {
>  		if (!test_bit(HCI_UP, &d->flags) ||
> -		    test_bit(HCI_RAW, &d->flags))
> +		    test_bit(HCI_RAW, &d->flags) ||
> +		    d->dev_type != HCI_BREDR)
>  			continue;
>  
>  		/* Simple routing:
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
