Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/3] Bluetooth: Code refactoring
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 10 Nov 2011 07:18:05 +0900
In-Reply-To: <1320869667-1373-3-git-send-email-andre.guedes@openbossa.org>
References: <1320869667-1373-1-git-send-email-andre.guedes@openbossa.org>
	 <1320869667-1373-3-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320877088.15441.350.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds the helper function cmd_failed() to handle mgmt
> commands failures. This function sends the proper command status
> event and removes the command from the pending list.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |   53 +++++++++++++++++--------------------------------
>  1 files changed, 19 insertions(+), 34 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

<snip>
 
>  int mgmt_disconnect_failed(struct hci_dev *hdev)
>  {
> -	struct pending_cmd *cmd;
> -	int err;
> -
> -	cmd = mgmt_pending_find(MGMT_OP_DISCONNECT, hdev);
> -	if (!cmd)
> -		return -ENOENT;
> -
> -	err = cmd_status(cmd->sk, hdev->id, MGMT_OP_DISCONNECT, EIO);
> -
> -	mgmt_pending_remove(cmd);
> -
> -	return err;
> +	return cmd_failed(hdev, MGMT_OP_DISCONNECT, EIO);
>  }

So the only left-over question now is if we need to keep these empty
stub functions around or can just call cmd_failed directly.

It might be actually cleaner to just call cmd_failed directly.

Regards

Marcel


