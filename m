Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] Bluetooth: Add definitions for LE set address resolution
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1531730009-7740-1-git-send-email-ankit.p.navik@intel.com>
Date: Mon, 16 Jul 2018 15:21:25 +0200
Cc: linux-bluetooth@vger.kernel.org, bharat.b.panda@intel.com
Message-Id: <3A6916F8-8D54-4D19-AFC6-F6D366B64E0A@holtmann.org>
References: <1531730009-7740-1-git-send-email-ankit.p.navik@intel.com>
To: Ankit Navik <ankit.p.navik@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ankit,

> Add the definitions for LE address resolution enable HCI commands.
> When the LE address resolution enable gets changed via HCI commands
> make sure that flag gets updated.
> 
> Signed-off-by: Ankit Navik <ankit.p.navik@intel.com>
> ---
> include/net/bluetooth/hci.h |  2 ++
> net/bluetooth/hci_event.c   | 40 ++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 42 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 1abcd14..c45fab5 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1512,6 +1512,8 @@ struct hci_rp_le_read_resolv_list_size {
> 	__u8	size;
> } __packed;
> 
> +#define HCI_OP_LE_SET_ADDR_RESOLUTION_ENABLE 0x202d
> +

please shortcut this to ADDR_RESOLV_ENABLE.

> #define HCI_OP_LE_READ_MAX_DATA_LEN	0x202f
> struct hci_rp_le_read_max_data_len {
> 	__u8	status;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index e8d6df9..e930556 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1372,6 +1372,42 @@ static void hci_cc_le_read_resolv_list_size(struct hci_dev *hdev,
> 	hdev->le_resolv_list_size = rp->size;
> }
> 
> +static void hci_cc_le_set_addr_resolution_enable(struct hci_dev *hdev,
> +						struct sk_buff *skb)
> +{
> +	__u8 *sent, status = *((__u8 *) skb->data);
> +
> +	BT_DBG("%s status 0x%2.2x", hdev->name, status);
> +
> +	if (status)
> +		return;
> +
> +	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADDR_RESOLUTION_ENABLE);
> +	if (!sent)
> +		return;
> +
> +	hci_dev_lock(hdev);
> +
> +	/* If we're doing connection initiation as peripheral. Set a
> +	 * timeout in case something goes wrong.
> +	 */
> +	if (*sent) {
> +		struct hci_conn *conn;
> +
> +		hci_dev_set_flag(hdev, HCI_RPA_RESOLVING);

Not sure we want to use the same flag here. Any concerns?

> +
> +		conn = hci_lookup_le_connect(hdev);
> +		if (conn)
> +			queue_delayed_work(hdev->workqueue,
> +					   &conn->le_conn_timeout,
> +					   conn->conn_timeout);

And I do not get the timeout here.

> +	} else {
> +		hci_dev_clear_flag(hdev, HCI_RPA_RESOLVING);
> +	}
> +
> +	hci_dev_unlock(hdev);
> +}
> +
> static void hci_cc_le_read_max_data_len(struct hci_dev *hdev,
> 					struct sk_buff *skb)
> {
> @@ -3097,6 +3133,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
> 		hci_cc_le_read_resolv_list_size(hdev, skb);
> 		break;
> 
> +	case HCI_OP_LE_SET_ADDR_RESOLUTION_ENABLE:
> +		hci_cc_le_set_addr_resolution_enable(hdev, skb);
> +		break;
> +
> 	case HCI_OP_LE_READ_MAX_DATA_LEN:
> 		hci_cc_le_read_max_data_len(hdev, skb);
> 		break;

Regards

Marcel

