Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v5 04/15] Bluetooth: Check pending commands in
 stop_discovery()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 15 Oct 2011 11:33:04 -0700
In-Reply-To: <1317856847-28167-5-git-send-email-andre.guedes@openbossa.org>
References: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
	 <1317856847-28167-5-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1318703615.15441.68.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds extra checks in stop_discovery().
> 
> The MGMT_OP_STOP_DISCOVERY command should be executed if the device
> is running the discovery procedure. So, if there is no discovery
> procedure running then EINVAL command status should be returned.
> 
> Also, if a MGMT_OP_STOP_DISCOVERY command has been already issued
> then EINPROGRESS command status should returned.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index d8333e0..5e1414b 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1664,6 +1664,17 @@ static int stop_discovery(struct sock *sk, u16 index)
>  
>  	hci_dev_lock_bh(hdev);
>  
> +	if (!mgmt_pending_find(MGMT_OP_START_DISCOVERY, index)) {
> +		err = cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY, EINVAL);
> +		goto failed;
> +	}
> +
> +	if (mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index)) {
> +		err = cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY,
> +								EINPROGRESS);
> +		goto failed;
> +	}
> +

and this case makes it obvious clear that we should use a flag to keep
track of the current discovery state. You are running through the same
list twice in a row. This is utterly stupid.

Regards

Marcel


