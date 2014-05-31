Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] bluetooth: Try to avoid forming scatternets
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401277204-28062-1-git-send-email-luiz.dentz@gmail.com>
Date: Sat, 31 May 2014 07:23:47 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BE96F0F6-FB1C-463E-A75B-6F9BE4EE0ABC@holtmann.org>
References: <1401277204-28062-1-git-send-email-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> In case of multiple connections automatically attempt to become master
> to avoid scatternet topology.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_event.c | 21 ++++++++++++++++-----
> 1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 492d8d5..e6aed6e 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2017,8 +2017,15 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 	if (ev->status) {
> 		hci_proto_connect_cfm(conn, ev->status);
> 		hci_conn_del(conn);
> -	} else if (ev->link_type != ACL_LINK)
> +	} else if (ev->link_type != ACL_LINK) {
> 		hci_proto_connect_cfm(conn, ev->status);
> +	} else if (hci_conn_num(hdev, ACL_LINK) > 1) {
> +		/* Attempt to switch to master to avoid scatternet */
> +		list_for_each_entry(conn, &hdev->conn_hash.list, list) {
> +			if (conn->type == ACL_LINK)
> +				hci_conn_switch_role(conn, 0x00);
> +		}
> +	}

I am not convinced this is a good idea. We do not know if the other also has two connections and wants to be the master. I think we can not generalize this on the HCI level. This has to be L2CAP socket policy that will allow us to make smart decisions. Sometimes the scatternet is just the better choice since our scatternet will result in a cheaper one than the others.
 
> 
> unlock:
> 	hci_dev_unlock(hdev);
> @@ -2035,6 +2042,12 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 	BT_DBG("%s bdaddr %pMR type 0x%x", hdev->name, &ev->bdaddr,
> 	       ev->link_type);
> 
> +	hci_dev_lock(hdev);
> +
> +	/* Allways attempt to become the master in multiple connection case */
> +	if (hci_conn_num(hdev, ev->link_type) > 0)
> +		mask |= HCI_LM_MASTER;
> +

Isn’t this useless for SCO and eSCO links since the master definition is really only for the ACL link.

> 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type,
> 				      &flags);
> 
> @@ -2044,8 +2057,6 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 		struct inquiry_entry *ie;
> 		struct hci_conn *conn;
> 
> -		hci_dev_lock(hdev);
> -
> 		ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
> 		if (ie)
> 			memcpy(ie->data.dev_class, ev->dev_class, 3);
> @@ -2063,8 +2074,6 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 
> 		memcpy(conn->dev_class, ev->dev_class, 3);
> 
> -		hci_dev_unlock(hdev);
> -
> 		if (ev->link_type == ACL_LINK ||
> 		    (!(flags & HCI_PROTO_DEFER) && !lmp_esco_capable(hdev))) {
> 			struct hci_cp_accept_conn_req cp;
> @@ -2106,6 +2115,8 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 		cp.reason = HCI_ERROR_REJ_BAD_ADDR;
> 		hci_send_cmd(hdev, HCI_OP_REJECT_CONN_REQ, sizeof(cp), &cp);
> 	}
> +
> +	hci_dev_unlock(hdev);
> }

Regards

Marcel

