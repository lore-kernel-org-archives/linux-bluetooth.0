Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4 03/14] Bluetooth: Check pending command in
 start_discovery()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 20 Sep 2011 14:26:48 +0200
In-Reply-To: <1316468136-12472-4-git-send-email-andre.guedes@openbossa.org>
References: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org>
	 <1316468136-12472-4-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316521610.1937.72.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> If discovery procedure is already running then EINPROGRESS command
> status should be returned.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index cc0c204..d8333e0 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1622,6 +1622,12 @@ static int start_discovery(struct sock *sk, u16 index)
>  
>  	hci_dev_lock_bh(hdev);
>  
> +	if (mgmt_pending_find(MGMT_OP_START_DISCOVERY, index)) {
> +		err = cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
> +								EINPROGRESS);
> +		goto failed;
> +	}
> +

the idea is correct, but instead of using mgmt_pending_find we should
have an internal flags field to track our current states. That is way
more efficient then looking for pending commands.

Regards

Marcel


