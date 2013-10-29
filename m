Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [RFC v2 12/15] Bleutooth: Add support for auto connect options
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383053160-10175-13-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 30 Oct 2013 00:15:24 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <5BFD1E7B-590C-4648-8074-169FA18F0178@holtmann.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org> <1383053160-10175-13-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds support for the HCI_AUTO_CONN_ALWAYS and HCI_AUTO_
> CONN_LINK_LOSS options from struct hci_conn_params.
> 
> The HCI_AUTO_CONN_ALWAYS option configures the kernel to always re-
> establish the connection, no matter the reason the connection was
> terminated. This feature is required by some LE profiles such as
> HID over GATT, Health Thermometer and Blood Pressure. These profiles
> require the host autonomously connect to the device as soon as it
> enters in connectable mode (start advertising) so the device is able
> to delivery a notification or indication.
> 
> The BT_AUTO_CONN_LINK_LOSS option configures the kernel to re-
> establish the connection in case the connection was terminated due
> to a link loss. This feature is required by the majority of LE
> profiles such as Proximity, Find Me, Cycling Speed and Cadence and
> Time.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_event.c | 26 ++++++++++++++++++++++++++
> 1 file changed, 26 insertions(+)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index e48601d..b2d8aee 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1785,6 +1785,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 	struct hci_conn *conn;
> 	u8 type;
> 	bool send_mgmt_event = false;
> +	struct hci_conn_params *params;
> 
> 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
> 
> @@ -1817,6 +1818,31 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 	if (conn->type == ACL_LINK && conn->flush_key)
> 		hci_remove_link_key(hdev, &conn->dst);
> 
> +	params = hci_find_conn_params(hdev, &conn->dst, conn->dst_type);
> +	if (params) {
> +		int err;
> +
> +		switch (params->auto_connect) {
> +		case HCI_AUTO_CONN_LINK_LOSS:
> +			if (ev->reason != HCI_ERROR_CONNECTION_TIMEOUT)
> +				break;
> +			/* Fall through */
> +
> +		case HCI_AUTO_CONN_ALWAYS:
> +			err = __hci_add_pending_auto_conn(hdev, &conn->dst,
> +							  conn->dst_type);
> +			if (err)
> +				BT_ERR("Failed to add pending auto connection "
> +				       " %d", err);

I really wonder what we are getting from pushing the errors out here if the only thing we do is print an error message anyway. I do not see the point. Print the error where it happens and make the rest void.

> +			break;
> +
> +		default:
> +			break;
> +		}
> +
> +		hci_conn_params_put(params);
> +	}
> +
> 	type = conn->type;
> 	hci_proto_disconn_cfm(conn, ev->reason);
> 	hci_conn_del(conn);

Regards

Marcel

