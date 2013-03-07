Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Mar 2013 09:15:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] Bluetooth: HCI request error handling
Message-ID: <20130307071527.GB28536@x220>
References: <1362613517-1761-1-git-send-email-andre.guedes@openbossa.org>
 <1362613517-1761-3-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362613517-1761-3-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Wed, Mar 06, 2013, Andre Guedes wrote:
> @@ -1042,6 +1042,9 @@ int hci_unregister_cb(struct hci_cb *hcb);
>  struct hci_request {
>  	struct hci_dev		*hdev;
>  	struct sk_buff_head	cmd_q;
> +
> +	/* This flag is set if something goes wrong during request creation */
> +	bool			error;
>  };

I'd prefer if you'd use "int err". That'd allow you to record the exact
error from when it occurred and have hci_req_run return it.

>  int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
> @@ -2460,6 +2461,15 @@ int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
>  	if (skb_queue_empty(&req->cmd_q))
>  		return -ENODATA;
>  
> +	/*
> +	 * If error flag is set, remove all HCI commands queued on the HCI
> +	 * request queue.
> +	 */
> +	if (req->error) {
> +		skb_queue_purge(&req->cmd_q);
> +		return -EIO;
> +	}

I think this check belongs before the queue_empty check. If the first
command failed to be added we should properly have hci_req_run fail too.
If you do it your way e.g. hci_req_sync would just succeed even though
there was a memory allocation error.

> @@ -2533,6 +2543,7 @@ int hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param)
>  	skb = hci_prepare_cmd(hdev, opcode, plen, param);
>  	if (!skb) {
>  		BT_ERR("%s no memory for command", hdev->name);
> +		req->error = true;
>  		return -ENOMEM;
>  	}

If the error is already set then I don't think hci_req_add should even
be attempting to add another command to the queue. So you should be
checking for a set error early in the function and just return if it's
set.

Johan
