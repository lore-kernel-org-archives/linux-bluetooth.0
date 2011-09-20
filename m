Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4 02/14] Bluetooth: Add mgmt_discovery_complete()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 20 Sep 2011 14:29:44 +0200
In-Reply-To: <1316468136-12472-3-git-send-email-andre.guedes@openbossa.org>
References: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org>
	 <1316468136-12472-3-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316521786.1937.75.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds the mgmt_discovery_complete() function which
> removes pending discovery commands and sends command complete/
> status events.
> 
> This function should be called when the discovery procedure finishes.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_event.c        |    7 +++++++
>  net/bluetooth/mgmt.c             |   31 +++++++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 5b92442..df6fa85 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -875,6 +875,7 @@ int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
>  int mgmt_discovering(u16 index, u8 discovering);
>  int mgmt_device_blocked(u16 index, bdaddr_t *bdaddr);
>  int mgmt_device_unblocked(u16 index, bdaddr_t *bdaddr);
> +int mgmt_discovery_complete(u16 index, u8 status);
>  
>  /* HCI info for socket */
>  #define hci_pi(sk) ((struct hci_pinfo *) sk)
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 89faf48..b44f362 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -55,6 +55,8 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
>  
>  	BT_DBG("%s status 0x%x", hdev->name, status);
>  
> +	mgmt_discovery_complete(hdev->id, status);
> +
>  	if (status)
>  		return;
>  
> @@ -951,6 +953,9 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
>  	if (status) {
>  		hci_req_complete(hdev, HCI_OP_INQUIRY, status);
>  		hci_conn_check_pending(hdev);
> +
> +		mgmt_discovery_complete(hdev->id, status);
> +
>  		return;
>  	}
>  
> @@ -1342,6 +1347,8 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
>  	if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
>  		return;
>  
> +	mgmt_discovery_complete(hdev->id, 0);
> +
>  	mgmt_discovering(hdev->id, 0);
>  }
>  
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 5a94eec..cc0c204 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2378,3 +2378,34 @@ int mgmt_device_unblocked(u16 index, bdaddr_t *bdaddr)
>  	return mgmt_event(MGMT_EV_DEVICE_UNBLOCKED, index, &ev, sizeof(ev),
>  						cmd ? cmd->sk : NULL);
>  }
> +
> +int mgmt_discovery_complete(u16 index, u8 status)
> +{
> +	struct pending_cmd *cmd_start;
> +	struct pending_cmd *cmd_stop;
> +	u8 discov_status = bt_to_errno(status);
> +
> +	cmd_start = mgmt_pending_find(MGMT_OP_START_DISCOVERY, index);
> +	if (!cmd_start)
> +		return -ENOENT;
> +
> +	BT_DBG("hci%u status %u", index, status);
> +
> +	cmd_stop = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index);
> +	if (cmd_stop && status == 0)
> +		discov_status = ECANCELED;
> +
> +	if (discov_status)
> +		cmd_status(cmd_start->sk, index, MGMT_OP_START_DISCOVERY,
> +								discov_status);
> +	else
> +		cmd_complete(cmd_start->sk, index, MGMT_OP_START_DISCOVERY,
> +								NULL, 0);
> +
> +	mgmt_pending_remove(cmd_start);
> +
> +	if (cmd_stop)
> +		mgmt_pending_remove(cmd_stop);
> +

doing this via an internal flags variable to track current states seems
a bit more efficient then these lookups. It also seems a bit cleaner
from a code point of view and easy to read and understand.

Can the race condition between cmd_status and cmd_complete really happen
in reality. I am thinking that we rather should not signal POLLOUT and
return an error on write if cmd_status has not yet been sent. The
cmd_status should be always immediate anyway.

Regards

Marcel


