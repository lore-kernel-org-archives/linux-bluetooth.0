Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Mar 2013 09:49:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 4/6] Bluetooth: HCI request error handling
Message-ID: <20130308074933.GA817@x220>
References: <1362692892-28716-1-git-send-email-andre.guedes@openbossa.org>
 <1362692892-28716-5-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362692892-28716-5-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Mar 07, 2013, Andre Guedes wrote:
> +	if (req->err) {
> +		skb_queue_purge(&req->cmd_q);
> +		return req->err;
> +	}

Don't we usually use if (err < 0) instead of if (err) for error checks?

>  	skb = hci_prepare_cmd(hdev, opcode, plen, param);
>  	if (!skb) {
>  		BT_ERR("%s no memory for command", hdev->name);
> +		req->err = -ENOMEM;
>  		return -ENOMEM;
>  	}

I think it'd be good to add at least the opcode to the BT_ERR log above
since otherwise the information of exactly which command in the request
caused an error is lost.

Johan
