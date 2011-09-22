Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Fix possible NULL pointer dereference
From: Marcel Holtmann <marcel@holtmann.org>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>,
	padovan@profusion.mobi,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Date: Thu, 22 Sep 2011 11:51:40 +0200
In-Reply-To: <1316671092-4387-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <20110921070804.GA5982@elgon.mountain>
	 <1316671092-4387-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316685104.1937.120.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

> Checking conn->pending_sec_level if there is no connection leads to potential
> null pointer dereference. Don't process pin_code_request_event at all if no
> connection exists.
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
> ---
>  net/bluetooth/hci_event.c |   30 ++++++++++++++++--------------
>  1 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index a520787..41c2562 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2175,24 +2175,26 @@ static inline void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff
>  	hci_dev_lock(hdev);
>  
>  	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
> -	if (conn && conn->state == BT_CONNECTED) {
> -		hci_conn_hold(conn);
> -		conn->disc_timeout = HCI_PAIRING_TIMEOUT;
> -		hci_conn_put(conn);
> -	}
> +	if (conn) {

what is from with this:

	if (!conn)
		goto unlock;

Regards

Marcel


