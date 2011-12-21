Return-Path: <cyrus@holtmann.org>
Message-ID: <1324433442.1965.148.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Make HCI call directly into SCO and
 L2CAP event functions
From: Marcel Holtmann <marcel@holtmann.org>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Tue, 20 Dec 2011 18:10:42 -0800
In-Reply-To: <1324430302-3002-2-git-send-email-ulisses@profusion.mobi>
References: <1324430302-3002-1-git-send-email-ulisses@profusion.mobi>
	 <1324430302-3002-2-git-send-email-ulisses@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

> The struct hci_proto and all related register/unregister and dispatching
> code was removed. HCI core code now call directly the SCO and L2CAP
> event functions.

<snip>

>  static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  								__u8 type)
>  {
> -	register struct hci_proto *hp;
>  	int mask = 0;
>  
> -	hp = hci_proto[HCI_PROTO_L2CAP];
> -	if (hp && hp->connect_ind)
> -		mask |= hp->connect_ind(hdev, bdaddr, type);
> -
> -	hp = hci_proto[HCI_PROTO_SCO];
> -	if (hp && hp->connect_ind)
> -		mask |= hp->connect_ind(hdev, bdaddr, type);
> +	mask |= l2cap_connect_ind(hdev, bdaddr, type);
> +	mask |= sco_connect_ind(hdev, bdaddr, type);

I am fine if you wanna do this in two steps for a more clean process of
getting where need to go, but we are not leaving it like this.

We do already know where the packet is going. So we can just check the
type up front. Remove the type check in the L2CAP/SCO and remove the
type parameter altogether.

No point in calling a function if we already know it just returns EINVAL
anyway.

>  	return mask;
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
> +	l2cap_connect_cfm(conn, status);
> +	sco_connect_cfm(conn, status);

Same here since conn->type will give you the link type. And so on for
all the others.

Regards

Marcel


