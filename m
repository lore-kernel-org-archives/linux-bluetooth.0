Return-Path: <cyrus@holtmann.org>
Message-ID: <1334566820.16897.171.camel@aeonflux>
Subject: Re: [PATCHv2 2/2] Bluetooth: Temporary keys should be retained
 during connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 16 Apr 2012 11:00:20 +0200
In-Reply-To: <1334319203-9482-2-git-send-email-vishal.agarwal@stericsson.com>
References: <1334319203-9482-1-git-send-email-vishal.agarwal@stericsson.com>
	 <1334319203-9482-2-git-send-email-vishal.agarwal@stericsson.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

> If a key is non persistent then it should not be used in future
> connections but it should be kept for current connection. And it
> should be removed when connecion is removed.
> 
> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |    6 ++----
>  net/bluetooth/hci_event.c        |    2 ++
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 8a9abe2..afdea95 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -318,6 +318,7 @@ struct hci_conn {
>  
>  	__u8		remote_cap;
>  	__u8		remote_auth;
> +	bool		flush_key;
>  
>  	unsigned int	sent;
>  
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 703c28d..1101f7d 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1333,10 +1333,8 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
>  
>  	mgmt_new_link_key(hdev, key, persistent);
>  
> -	if (!persistent) {
> -		list_del(&key->list);
> -		kfree(key);
> -	}
> +	if (!conn)
> +		conn->flush_key = !persistent;

this is a NULL pointer dereference waiting to happen.

Regards

Marcel


