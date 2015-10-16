Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Oct 2015 08:29:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: fix double scan updates
Message-ID: <20151016052910.GB28796@t440s.P-661HNU-F1>
References: <1444938838-3225-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444938838-3225-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thu, Oct 15, 2015, Jakub Pawlowski wrote:
> When disble/enable scan command is issued twice, some controllers would
> return error for second request. Therefore requests including those would
> fail on some controllers, and succeed on others.

Do you actually have examples of controllers that don't fail? I haven't
seen any. Also, the usual convention is the provide a btmon output
snippet of the failure in the commit message.

> @@ -6124,7 +6124,11 @@ static int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
>  	case HCI_AUTO_CONN_ALWAYS:
>  		if (!is_connected(hdev, addr, addr_type)) {
>  			list_add(&params->action, &hdev->pend_le_conns);
> -			__hci_update_background_scan(req);
> +			/* If we are connecting to device using random address,
> +			 * we were already added to pend_le_conns and scanning.
> +			 */
> +			if (params->auto_connect != HCI_AUTO_CONN_EXPLICIT)
> +				__hci_update_background_scan(req);

The patch looks in general fine, but the above code comment has always
confused me. What has this got to do with random addresses? Wouldn't we
be scanning regardless of what type of address had previously been
added?

Johan
