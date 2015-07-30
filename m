Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH] Bluetooth: Fix Add Device response status
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1436791005-2894-1-git-send-email-jpawlowski@google.com>
Date: Thu, 30 Jul 2015 13:54:31 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FFFBE407-5596-4302-9219-FA462620CBF7@holtmann.org>
References: <1436791005-2894-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> Make sure that MGMT_STATUS_INVALID_PARAMS is returned when non identity
> address is passed to ADD_DEVICE. Right now MGMT_STATUS_FAILED is
> returned, which might be misleading.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> net/bluetooth/mgmt.c | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 7998fb2..47462bf 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -6226,6 +6226,13 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
> 	else
> 		auto_conn = HCI_AUTO_CONN_REPORT;
> 
> +	/* Allow only identity addresses */
> +	if (!hci_is_identity_address(&cp->addr.bdaddr, addr_type)) {
> +		err = cmd->cmd_complete(cmd, MGMT_STATUS_INVALID_PARAMS);
> +		mgmt_pending_remove(cmd);
> +		goto unlock;
> +	}
> +

did we loose this patch or is it no longer needed?

Regards

Marcel

