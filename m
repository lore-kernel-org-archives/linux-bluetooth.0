Return-Path: <cyrus@holtmann.org>
Message-ID: <1333643105.16897.12.camel@aeonflux>
Subject: Re: [PATCH v2] Bluetooth: Temporary keys should be retained during
 connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 05 Apr 2012 09:25:05 -0700
In-Reply-To: <1333624699-7922-1-git-send-email-vishal.agarwal@stericsson.com>
References: <1333624699-7922-1-git-send-email-vishal.agarwal@stericsson.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

> If a key is non persistent then it should not be used in future
> connections but it should be kept for current connection. And
> it should be removed when connecion is removed.
> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |   11 +++++++----
>  net/bluetooth/hci_event.c        |    2 ++
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index c0b232c..ce7a415 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -318,6 +318,7 @@ struct hci_conn {
>  
>  	__u8		remote_cap;
>  	__u8		remote_auth;
> +	bool		temp_link_key;

I would actually rename this into an action. So something like
flush_key.
 
>  	unsigned int	sent;
>  
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 286f3fc..fddd0ac 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1330,10 +1330,13 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
>  
>  	mgmt_new_link_key(hdev, key, persistent);
>  
> -	if (!persistent) {
> -		list_del(&key->list);
> -		kfree(key);
> -	}
> +	if (!conn)
> +		return 0;
> +
> +	if (persistent)
> +		conn->temp_link_key = false;
> +	else
> +		conn->temp_link_key = true;

So I would actually prefer a cleanup patch first that changes
hci_persistent_key() function into a bool return value.

After that it could become just like this

	conn->temp_link_key = !persistent;

>  
>  	return 0;
>  }
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 7325300..0b19852 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1928,6 +1928,8 @@ static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff
>  	}
>  
>  	if (ev->status == 0) {
> +		if (conn->type == ACL_LINK && conn->temp_link_key)
> +			hci_remove_link_key(hdev, &conn->dst);
>  		hci_proto_disconn_cfm(conn, ev->reason);
>  		hci_conn_del(conn);
>  	}

Otherwise this looks all reasonable.

Regards

Marcel


