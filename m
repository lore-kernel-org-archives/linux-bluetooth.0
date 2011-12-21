Return-Path: <cyrus@holtmann.org>
Message-ID: <1324439113.1965.165.camel@aeonflux>
Subject: Re: [PATCH v2 2/2] Bluetooth: Make HCI call directly into SCO and
 L2CAP event functions
From: Marcel Holtmann <marcel@holtmann.org>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Tue, 20 Dec 2011 19:45:13 -0800
In-Reply-To: <1324438330-9887-2-git-send-email-ulisses@profusion.mobi>
References: <1324438330-9887-1-git-send-email-ulisses@profusion.mobi>
	 <1324438330-9887-2-git-send-email-ulisses@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

> The struct hci_proto and all related register/unregister and dispatching
> code was removed. HCI core code now call directly the SCO and L2CAP
> event functions.
> 
> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
> ---
>  include/net/bluetooth/hci_core.h |  125 ++++++++++++-------------------------
>  net/bluetooth/hci_core.c         |   59 +-----------------
>  net/bluetooth/l2cap_core.c       |   51 ++-------------
>  net/bluetooth/sco.c              |   38 +----------
>  4 files changed, 56 insertions(+), 217 deletions(-)

<snip>

>  static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  								__u8 type)
>  {
> -	register struct hci_proto *hp;
> -	int mask = 0;
> -
> -	hp = hci_proto[HCI_PROTO_L2CAP];
> -	if (hp && hp->connect_ind)
> -		mask |= hp->connect_ind(hdev, bdaddr, type);
> +	if (type == ACL_LINK)
> +		return l2cap_connect_ind(hdev, bdaddr);
> +	else if (type == SCO_LINK || type == ESCO_LINK)
> +		return sco_connect_ind(hdev, bdaddr);

this one screams switch statement.
 
> -	hp = hci_proto[HCI_PROTO_SCO];
> -	if (hp && hp->connect_ind)
> -		mask |= hp->connect_ind(hdev, bdaddr, type);
> -
> -	return mask;
> +	BT_DBG("unknown link type %d", type);

And make this BT_ERR. It is fine to just actually print an error. We
could also think about just calling BUG here. Since it really should not
happen and if it does, we have a real problem.

> +	return -EINVAL;
>  }
>  
>  static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
>  {
> -	register struct hci_proto *hp;
> -
> -	hp = hci_proto[HCI_PROTO_L2CAP];
> -	if (hp && hp->connect_cfm)
> -		hp->connect_cfm(conn, status);
> -
> -	hp = hci_proto[HCI_PROTO_SCO];
> -	if (hp && hp->connect_cfm)
> -		hp->connect_cfm(conn, status);
> +	if (conn->type == ACL_LINK || conn->type == LE_LINK)
> +		l2cap_connect_cfm(conn, status);
> +	else if (conn->type == SCO_LINK || conn->type == ESCO_LINK)
> +		sco_connect_cfm(conn, status);
> +	else
> +		BT_DBG("unknown link type %d", conn->type);

Still switch statement looks way cleaner here. And so on.

Regards

Marcel


