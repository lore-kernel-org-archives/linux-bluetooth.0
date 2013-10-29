Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [RFC v2 01/15] Bluetooth: Refactor hci_disconn_complete_evt
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383053160-10175-2-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 29 Oct 2013 23:52:19 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <227F5D6B-6B76-428E-9893-37ED1562F833@holtmann.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org> <1383053160-10175-2-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> hci_disconn_complete_evt() logic is more complicated than what it
> should be, making it hard to follow and add new features.
> 
> So this patch does some code refactoring by handling the error cases
> in the beginning of the function and by moving the main flow into the
> first level of function scope. No change is done in the event handling
> logic itself.
> 
> Besides organizing this messy code, this patch makes easier to add
> code for handling LE auto connection (which will be added in a further
> patch).
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_event.c | 62 +++++++++++++++++++++++++----------------------
> 1 file changed, 33 insertions(+), 29 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 5935f74..8b7cd37 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1783,6 +1783,8 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> {
> 	struct hci_ev_disconn_complete *ev = (void *) skb->data;
> 	struct hci_conn *conn;
> +	u8 type;
> +	bool send_mgmt_event = false;
> 
> 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
> 
> @@ -1792,44 +1794,46 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 	if (!conn)
> 		goto unlock;
> 
> -	if (ev->status == 0)
> -		conn->state = BT_CLOSED;
> -
> 	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags) &&
> -	    (conn->type == ACL_LINK || conn->type == LE_LINK)) {
> -		if (ev->status) {
> +	    (conn->type == ACL_LINK || conn->type == LE_LINK))
> +		send_mgmt_event = true;
> +
> +	if (ev->status) {
> +		if (send_mgmt_event)
> 			mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
> 					       conn->dst_type, ev->status);
> -		} else {
> -			u8 reason = hci_to_mgmt_reason(ev->reason);
> -
> -			mgmt_device_disconnected(hdev, &conn->dst, conn->type,
> -						 conn->dst_type, reason);
> -		}
> +		return;
> 	}

so I get the feeling that mgmt_disconnect_failed should check the link type all by itself. Since we are handing it over to the function anyway. And then this send_mgmt_event could be just removed.

> -	if (ev->status == 0) {
> -		u8 type = conn->type;
> +	conn->state = BT_CLOSED;
> 
> -		if (type == ACL_LINK && conn->flush_key)
> -			hci_remove_link_key(hdev, &conn->dst);
> -		hci_proto_disconn_cfm(conn, ev->reason);
> -		hci_conn_del(conn);
> +	if (send_mgmt_event) {
> +		u8 reason = hci_to_mgmt_reason(ev->reason);
> 
> -		/* Re-enable advertising if necessary, since it might
> -		 * have been disabled by the connection. From the
> -		 * HCI_LE_Set_Advertise_Enable command description in
> -		 * the core specification (v4.0):
> -		 * "The Controller shall continue advertising until the Host
> -		 * issues an LE_Set_Advertise_Enable command with
> -		 * Advertising_Enable set to 0x00 (Advertising is disabled)
> -		 * or until a connection is created or until the Advertising
> -		 * is timed out due to Directed Advertising."
> -		 */
> -		if (type == LE_LINK)
> -			mgmt_reenable_advertising(hdev);
> +		mgmt_device_disconnected(hdev, &conn->dst, conn->type,
> +					 conn->dst_type, reason);
> 	}

Same here. Just make sure that mgmt_device_disconneted checks the link type by itself and call it unconditional.

> 
> +	if (conn->type == ACL_LINK && conn->flush_key)
> +		hci_remove_link_key(hdev, &conn->dst);
> +
> +	type = conn->type;
> +	hci_proto_disconn_cfm(conn, ev->reason);
> +	hci_conn_del(conn);
> +
> +	/* Re-enable advertising if necessary, since it might
> +	 * have been disabled by the connection. From the
> +	 * HCI_LE_Set_Advertise_Enable command description in
> +	 * the core specification (v4.0):
> +	 * "The Controller shall continue advertising until the Host
> +	 * issues an LE_Set_Advertise_Enable command with
> +	 * Advertising_Enable set to 0x00 (Advertising is disabled)
> +	 * or until a connection is created or until the Advertising
> +	 * is timed out due to Directed Advertising."
> +	 */
> +	if (type == LE_LINK)
> +		mgmt_reenable_advertising(hdev);
> +
> unlock:
> 	hci_dev_unlock(hdev);
> }

Regards

Marcel

