Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Feb 2011 14:25:31 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: anderson.briglia@openbossa.org
Cc: linux-bluetooth@vger.kernel.org,
	Ville Tervo <ville.tervo@nokia.com>
Subject: Re: [RFCv2 3/4] Bluetooth: Use ERR_PTR to return error from
 hci_connect
Message-ID: <20110217172531.GJ10543@joana>
References: <n>
 <4d5d2589.8f7edc0a.5af6.27dd@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4d5d2589.8f7edc0a.5af6.27dd@mx.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

* anderson.briglia@openbossa.org <anderson.briglia@openbossa.org> [2011-02-17 10:39:55 -0300]:

> From: Ville Tervo <ville.tervo@nokia.com>
> 
> Use ERR_PRT mechanism to return error from hci_connect. This patch also

Typo here, ERR_PTR.

> includes a change to return error if LE link exists already to remote host.
> 
> Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> ---
>  net/bluetooth/hci_conn.c   |   12 +++++++-----
>  net/bluetooth/l2cap_core.c |   10 ++++------
>  net/bluetooth/sco.c        |    6 +++---
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index ee7dcdd..e06b856 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -305,7 +305,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
>  
>  	conn = kzalloc(sizeof(struct hci_conn), GFP_ATOMIC);
>  	if (!conn)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);

That's not really need. Seems that return NULL here means ENOMEM.

>  
>  	bacpy(&conn->dst, dst);
>  	conn->hdev  = hdev;
> @@ -459,8 +459,10 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
>  		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
>  		if (!le)
>  			le = hci_conn_add(hdev, LE_LINK, dst);
> -		if (!le)
> -			return NULL;
> +		else
> +			return ERR_PTR(-EBUSY);
> +		if (IS_ERR(le))
> +			return le;

I prefer this instead:

                le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
                if (le)
                        return ERR_PTR(-EBUSY);

                le = hci_conn_add(hdev, LE_LINK, dst);
                if (!le)
                        return ERR_PTR(-ENOMEM);

Regards,

-- 
Gustavo F. Padovan
http://profusion.mobi
