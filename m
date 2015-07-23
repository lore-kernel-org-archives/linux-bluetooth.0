Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Jul 2015 11:04:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Bluetooth: Fix connection to already paired
 device.
Message-ID: <20150723080439.GA4104@t440s.lan>
References: <1437564577-4207-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437564577-4207-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Jul 22, 2015, Jakub Pawlowski wrote:
> Currently, when trying to connect to already paired device that just
> rotated its RPA MAC address, old address would be used and connection
> would fail. In order to fix that, kernel must scan and receive
> advertisement with fresh RPA before connecting.
> 
> This patch adds infrastructure for future changes in connection
> estabilishment procedure behaviour for all devices. Instead of just
> sending HCI_OP_LE_CREATE_CONN to controller, "connect" will add device to
> kernel whitelist and start scan. If advertisement is received, it'll be
> compared against whitelist and then trigger connection if it matches.
> That fixes mentioned reconnect issue for  already paired devices. It also
> make whole connection procedure more robust. We can try to connect to
> multiple devices at same time now, even though controller allow only one.
> 
> HCI_AUTO_CONN_JUST_ONCE value was added to hci_conn_params. It is used to

I don't see HCI_AUTO_CONN_JUST_ONCE anywhere in the patch. Have you
forgotten to update the commit message?

> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -512,9 +512,11 @@ struct hci_conn_params {
>  		HCI_AUTO_CONN_DIRECT,
>  		HCI_AUTO_CONN_ALWAYS,
>  		HCI_AUTO_CONN_LINK_LOSS,
> +		HCI_AUTO_CONN_SOCK,
>  	} auto_connect;
>  
>  	struct hci_conn *conn;
> +	bool is_sock_conn;
>  };

I still don't like having the term "sock" anywhere in the HCI core. The
fact that a higher layer is implemented through sockets is something the
HCI core shouldn't need to care or know about imo.

Could we perhaps make all of this completely generic and simpler through
adding reference counting the hci_conn_params struct? The socket based
attempt would own its own reference and drop it after the attempt
completes (either in success or failure). Likewise the mgmt based Add
Device would add its own reference which would get dropped once Remove
Device is called. This way the HCI core wouldn't need to care about any
other details of the lifetime of the parameters.

> +/* This function requires the caller holds hdev->lock */
> +void hci_remove_from_sock_conn_whitelist(struct hci_conn *conn)
> +{
> +	struct hci_request req;
> +	struct hci_conn_params *params = hci_pend_le_sock_action_lookup(
> +						conn->hdev, &conn->dst,
> +						conn->dst_type);
> +	if (!params)
> +		return;

Call hci_pend_le_sock_action_lookup() here separate from the 'params'
variable declaration, and remember that there should be an empty line
between the variable declarations and the rest of the function.

> +	hci_req_init(&req, conn->hdev);
> +	__hci_update_background_scan(&req);
> +	hci_req_run(&req, NULL);

Can't you just use hci_update_background_scan() instead of these three
function calls?

As a general comment I think this patch is quite big and it'd be good if
you could try to find ways to split it up into smaller pieces.

Johan
