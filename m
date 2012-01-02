Return-Path: <cyrus@holtmann.org>
Message-ID: <1325543108.1965.403.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix mgmt_stop_discovery_failed()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 02 Jan 2012 14:25:08 -0800
In-Reply-To: <1325533853-10101-1-git-send-email-andre.guedes@openbossa.org>
References: <1325533853-10101-1-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> Stop Discovery Command Status Event should use mgmt status code.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 2540944..fb0b15e 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2756,7 +2756,7 @@ int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
>  	if (!cmd)
>  		return -ENOENT;
>  
> -	err = cmd_status(cmd->sk, hdev->id, cmd->opcode, status);
> +	err = cmd_status(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status));
>  	mgmt_pending_remove(cmd);

patch does look reasonable to me, but I am not this is the expected
behavior. I leave this up to Johan to ACK or NAK.

Regards

Marcel


