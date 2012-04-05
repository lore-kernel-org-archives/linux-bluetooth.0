Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Apr 2012 13:22:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2 3/5] Bluetooth: Add dst_type parameter to hci_connect
Message-ID: <20120405102208.GC32212@x220>
References: <1333570570-1288-1-git-send-email-andre.guedes@openbossa.org>
 <1333570570-1288-4-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333570570-1288-4-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Wed, Apr 04, 2012, Andre Guedes wrote:
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 542fea2..9083a95 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -574,7 +574,7 @@ int hci_chan_del(struct hci_chan *chan);
>  void hci_chan_list_flush(struct hci_conn *conn);
>  
>  struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
> -						__u8 sec_level, __u8 auth_type);
> +				__u8 dst_type, __u8 sec_level, __u8 auth_type);

It seems like you're not using the "new" style of aligning with the
opening parenthesis here.

> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1911,11 +1911,11 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>  		auth_type = HCI_AT_DEDICATED_BONDING_MITM;
>  
>  	if (cp->addr.type == BDADDR_BREDR)
> -		conn = hci_connect(hdev, ACL_LINK, &cp->addr.bdaddr, sec_level,
> -				   auth_type);
> +		conn = hci_connect(hdev, ACL_LINK, &cp->addr.bdaddr,
> +					cp->addr.type, sec_level, auth_type);
>  	else
> -		conn = hci_connect(hdev, LE_LINK, &cp->addr.bdaddr, sec_level,
> -				   auth_type);
> +		conn = hci_connect(hdev, LE_LINK, &cp->addr.bdaddr,
> +					cp->addr.type, sec_level, auth_type);

Same issue with the above two cases.

> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -196,7 +196,8 @@ static int sco_connect(struct sock *sk)
>  	else
>  		type = SCO_LINK;
>  
> -	hcon = hci_connect(hdev, type, dst, BT_SECURITY_LOW, HCI_AT_NO_BONDING);
> +	hcon = hci_connect(hdev, type, dst, BDADDR_BREDR, BT_SECURITY_LOW,
> +				HCI_AT_NO_BONDING);

And here as well.

Johan
