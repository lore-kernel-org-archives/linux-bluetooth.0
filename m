Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v5 03/15] Bluetooth: Check pending command in
 start_discovery()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 15 Oct 2011 11:30:48 -0700
In-Reply-To: <1317856847-28167-4-git-send-email-andre.guedes@openbossa.org>
References: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
	 <1317856847-28167-4-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1318703467.15441.66.camel@aeonflux>
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

I still do not like this at all. There should be a flag that clearly
identifies if we are doing a discovery right now or not.

We need a flag on per controller to know if currently a discovery is
going on. And going through all controllers and all pending commands to
figure this out seems not a good idea. Even with a low amount of pending
commands, then mgmt_pending_find is an expensive operation.

>  	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, index, NULL, 0);
>  	if (!cmd) {
>  		err = -ENOMEM;

The other question I have is why we have to duplicate the parameters
when adding a command to the list. Why not keep a reference of the SKB?

Regards

Marcel



