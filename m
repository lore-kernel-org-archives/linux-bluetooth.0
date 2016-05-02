Return-Path: <johan.hedberg@gmail.com>
Date: Mon, 2 May 2016 21:02:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Marcel Holtmann <marcel@holtmann.org>, kernel-janitors@vger.kernel.org,
	Gustavo Padovan <gustavo@padovan.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use hci_conn_hash_lookup_le
Message-ID: <20160502180256.GA22757@t440s>
References: <1461957760-753-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461957760-753-1-git-send-email-Julia.Lawall@lip6.fr>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Apr 29, 2016, Julia Lawall wrote:
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -4773,7 +4773,8 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
>  		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
>  					       &cp->addr.bdaddr);
>  	else
> -		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
> +		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
> +					       cp->addr.type);

I don't think is is correct. There are two possible domains for address
types: the user space-facing interface that has three values: BR/EDR, LE
public & LE random, and the internal one which maps to HCI that has two
values: random or public. You'd need to convert from the former to the
latter when making the lookup call, i.e:

	conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
				       le_addr_type(cp->addr.type));


Johan
